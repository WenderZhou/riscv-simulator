#include"Read_Elf.h"

ElfReader::ElfReader(MonitorUnit* _monitorTable, int cnt)
{
	memset(this,0,sizeof(ElfReader));
	file = NULL;
	elf = NULL;
	monitorTable = _monitorTable;
	monitorCnt = cnt;
}

ElfReader::~ElfReader()
{

}

bool ElfReader::open_file(char* filename)
{
	file = fopen(filename,"r");
	elf = fopen(ELF_NAME,"w+");
	if(file == NULL || elf == NULL)
		return false;
	return true;
}

void ElfReader::read_elf(char* filename)
{
	if(!open_file(filename))
	{
		printf("file can not open!\n");
		return ;
	}
		
		
	fprintf(elf,"ELF Header:\n");
	read_Elf_header();

	fprintf(elf,"\n\nSection Headers:\n");
	read_elf_sections();

	fprintf(elf,"\n\nProgram Headers:\n");
	read_Phdr();

	fprintf(elf,"\n\nSymbol table:\n");
	read_symtable();

	fclose(elf);
}

void ElfReader::read_Elf_header()
{
	fseek(file,0,SEEK_SET);
	//file should be relocated
	fread(&elf64_hdr,1,sizeof(elf64_hdr),file);
		
	fprintf(elf," magic number:  ");
	for(int i = 0; i < EI_NIDENT; ++i)
		fprintf(elf, "%02x ", elf64_hdr.e_ident[i]);

	fprintf(elf,"\n Class:  ");
	switch (elf64_hdr.e_ident[EI_CLASS])
	{
	case 0:
		fprintf(elf,"ELFCLASSNONE");
		break;
	case 1:
		fprintf(elf,"ELFCLASS32");
		break;
	case 2:
		fprintf(elf,"ELFCLASS64");
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	fprintf(elf,"\n Data:  ");
	switch (elf64_hdr.e_ident[EI_DATA])
	{
	case 0:
		fprintf(elf,"ELFDATANONE");
		break;
	case 1:
		fprintf(elf,"ELFDATA2LSB");	// little endian
		break;
	case 2:
		fprintf(elf,"ELFDATA2MSB");	// big endian
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	fprintf(elf,"\n Version:   ");
	switch (elf64_hdr.e_ident[EI_VERSION])
	{
	case 0:
		fprintf(elf,"NONE");
		break;
	case 1:
		fprintf(elf,"CURRENT");
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	// NOTE: I can not find what is this
	fprintf(elf,"\n OS/ABI:	 System V ABI\n");
	fprintf(elf," ABI Version:   \n");
	
	fprintf(elf," Type:  ");
	switch ((unsigned short)elf64_hdr.e_type)
	{
	case 0:
		fprintf(elf,"NONE");
		break;
	case 1:
		fprintf(elf,"REL");
		break;
	case 2:
		fprintf(elf,"EXEC");
		break;
	case 3:
		fprintf(elf,"DYN");
		break;
	case 4:
		fprintf(elf,"CORE");
		break;
	case 0xff00:
		fprintf(elf,"LOPROC");
		break;
	case 0xffff:
		fprintf(elf,"HIPROC");
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	fprintf(elf,"\n Machine:   ");
	switch ((unsigned short)elf64_hdr.e_machine)
	{
	case 0:
		fprintf(elf,"NONE");
		break;
	case 1:
		fprintf(elf,"M32");
		break;
	case 2:
		fprintf(elf,"SPARC");
		break;
	case 3:
		fprintf(elf,"386");
		break;
	case 4:
		fprintf(elf,"68K");
		break;
	case 5:
		fprintf(elf,"88K");
		break;
	case 7:
		fprintf(elf,"860");
		break;
	case 8:
		fprintf(elf,"MIPS");
		break;
	case 10:
		fprintf(elf,"MIPS_RS4_BE");
		break;
	case 243:
		fprintf(elf,"RISCV");
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	fprintf(elf,"\n Version:  ");
	switch ((unsigned int)elf64_hdr.e_version)
	{
	case 0:
		fprintf(elf,"NONE");
		break;
	case 1:
		fprintf(elf,"CURRENT");
		break;
	default:
		fprintf(elf,"??????");
		break;
	}

	entry = (unsigned long long)elf64_hdr.e_entry;
	fprintf(elf,"\n Entry point address:  0x%llx\n", entry);

	padr = (unsigned long long)elf64_hdr.e_phoff;
	fprintf(elf," Start of program headers: %llu bytes into file\n",padr);

	sadr = (unsigned long long)elf64_hdr.e_shoff;
	fprintf(elf," Start of section headers: %llu bytes into file\n",sadr);

	fprintf(elf," Flags:  0x%x\n",(unsigned int)elf64_hdr.e_flags);

	fprintf(elf," Size of this header: %hu Bytes\n", (unsigned short)elf64_hdr.e_ehsize);

	psize = (unsigned short)elf64_hdr.e_phentsize;
	fprintf(elf," Size of program headers: %d Bytes\n",psize);

	pnum = (unsigned short)elf64_hdr.e_phnum;
	fprintf(elf," Number of program headers: %d\n",pnum);

	ssize = (unsigned short)elf64_hdr.e_shentsize; 
	fprintf(elf," Size of section headers: %d Bytes\n",ssize);

	snum = (unsigned short)elf64_hdr.e_shnum;
	fprintf(elf," Number of section headers: %d\n",snum);

	index = (unsigned short)elf64_hdr.e_shstrndx;
	fprintf(elf," Section header string table index: %d\n",index);
}

void ElfReader::read_elf_sections()
{
	Elf64_Shdr elf64_shdr, shstrtab_shdr;

	fseek(file, sadr + index * ssize, SEEK_SET);
	fread(&shstrtab_shdr, 1, sizeof(Elf64_Shdr), file);
	unsigned long long length = (unsigned long long)shstrtab_shdr.sh_size;
	char* sectionName = new char[length];
	fseek(file, (unsigned long long)shstrtab_shdr.sh_offset, SEEK_SET);
	fread(sectionName,1,length,file);

	fseek(file, sadr, SEEK_SET);
	
	for(unsigned int c=0;c<snum;c++)
	{
		fprintf(elf," [%3d]\n",c);
		
		//file should be relocated
		fread(&elf64_shdr,1,sizeof(Elf64_Shdr),file);

		fprintf(elf," Name: %-16s", sectionName + (unsigned int)elf64_shdr.sh_name);
		if(strcmp(sectionName + (unsigned int)elf64_shdr.sh_name,".strtab") == 0)
		{
			stradr = (unsigned long long)elf64_shdr.sh_offset;
			strLen = (unsigned long long)elf64_shdr.sh_size;
		}

		fprintf(elf,"  Type: ");
		switch ((unsigned int)elf64_shdr.sh_type)
		{
		case 0:
			fprintf(elf,"%-12s", "NULL");
			break;
		case 1:
			fprintf(elf,"%-12s", "PROGBITS");
			break;
		case 2:
			fprintf(elf,"%-12s", "SYMTAB");
			symsize = (unsigned long long)elf64_shdr.sh_size;
			symadr = (unsigned long long)elf64_shdr.sh_offset;
			symnum = symsize / sizeof(Elf64_Sym);
			break;
		case 3:
			fprintf(elf,"%-12s", "STRTAB");
			break;
		case 4:
			fprintf(elf,"%-12s", "RELA");
			break;
		case 5:
			fprintf(elf,"%-12s", "HASH");
			break;
		case 6:
			fprintf(elf,"%-12s", "DYNAMIC");
			break;
		case 7:
			fprintf(elf,"%-12s", "NOTE");
			break;
		case 8:
			fprintf(elf,"%-12s", "NOBITS");
			break;
		case 9:
			fprintf(elf,"%-12s", "REL");
			break;
		case 10:
			fprintf(elf,"%-12s", "SHLIB");
			break;
		case 11:
			fprintf(elf,"%-12s", "DYNSYM");
			break;
		case 14:
			fprintf(elf,"%-12s", "INIT_ARRAY");
			break;
		case 15:
			fprintf(elf,"%-12s", "FINI_ARRAY");
			break;
		case 0x70000000:
			fprintf(elf,"%-12s", "LOPROC");
			break;
		case 0x7fffffff:
			fprintf(elf,"%-12s", "HIPROC");
			break;
		case 0x80000000:
			fprintf(elf,"%-12s", "LOUSER");
			break;
		case 0xffffffff:
			fprintf(elf,"%-12s", "HIUSER");
			break;
		default:
			fprintf(elf,"%-12s", "??????");
			break;
		}

		fprintf(elf," Address:	%016llx", (unsigned long long)elf64_shdr.sh_addr);

		fprintf(elf," Offest:  %016llx\n", (unsigned long long)elf64_shdr.sh_offset);

		fprintf(elf," Size:  %016llx", (unsigned long long)elf64_shdr.sh_size);

		fprintf(elf," Entsize:  %016llx", (unsigned long long)elf64_shdr.sh_entsize);

		fprintf(elf," Flags:   ");
		switch ((unsigned long long)elf64_shdr.sh_flags)
		{
		case 0:
			fprintf(elf,"%-3s","");
			break;
		case 1:
			fprintf(elf,"%-3s","W");
			break;
		case 2:
			fprintf(elf,"%-3s","A");
			break;
		case 3:
			fprintf(elf,"%-3s","WA");
			break;
		case 4:
			fprintf(elf,"%-3s","X");
			break;
		case 5:
			fprintf(elf,"%-3s","WX");
			break;
		case 6:
			fprintf(elf,"%-3s","AX");
			break;
		case 7:
			fprintf(elf,"%-3s","WAX");
			break;
		case 0x30:	// NOTE: accoding to readelf
			fprintf(elf,"%-3s","MS");
			break;
		case 0xf0000000:
			fprintf(elf,"%-3s","!!!");
			break;
		default:
			fprintf(elf,"%-3s","???");
			break;
		}

		fprintf(elf," Link:  %u", (unsigned int)elf64_shdr.sh_link);

		fprintf(elf," Info:  %u", (unsigned int)elf64_shdr.sh_info);

		fprintf(elf," Align: %llu\n", (unsigned long long)elf64_shdr.sh_addralign);

 	}
	
	delete []sectionName;
}

void ElfReader::read_Phdr()
{
	fseek(file, padr, SEEK_SET);

	Elf64_Phdr elf64_phdr;

	for(unsigned int c=0;c<pnum;c++)
	{
		fprintf(elf," [%3d]\n",c);
			
		// file should be relocated
		fread(&elf64_phdr,1,sizeof(Elf64_Phdr),file);

		fprintf(elf," Type:   ");

		switch ((unsigned int)elf64_phdr.p_type)
		{
		case 0:
			fprintf(elf,"%-12s", "NULL");
			break;
		case 1:
			fprintf(elf,"%-12s", "LOAD");
			break;
		case 2:
			fprintf(elf,"%-12s", "DYNAMIC");
			break;
		case 3:
			fprintf(elf,"%-12s", "INTERP");
			break;
		case 4:
			fprintf(elf,"%-12s", "NOTE");
			break;
		case 5:
			fprintf(elf,"%-12s", "SHLIB");
			break;
		case 6:
			fprintf(elf,"%-12s", "PHDR");
			break;
		case 0x70000000:
			fprintf(elf,"%-12s", "LOPROC");
			break;
		case 0x7fffffff:
			fprintf(elf,"%-12s", "HIPROC");
			break;
		default:
			fprintf(elf,"%-12s", "??????");
			break;
		}
		
		fprintf(elf," Offset:   %016llx", (unsigned long long)elf64_phdr.p_offset);
		
		fprintf(elf," VirtAddr:  %016llx", (unsigned long long)elf64_phdr.p_vaddr);
		
		fprintf(elf," PhysAddr:   %016llx\n", (unsigned long long)elf64_phdr.p_paddr);

		fprintf(elf," FileSiz:   %016llx", (unsigned long long)elf64_phdr.p_filesz);

		fprintf(elf," MemSiz:   %016llx", (unsigned long long)elf64_phdr.p_memsz);
		
		fprintf(elf," Align:   %llu", (unsigned long long)elf64_phdr.p_align);

		fprintf(elf," Flags:   ");
		switch ((unsigned int)elf64_phdr.p_flags)
		{
		case 0:
			fprintf(elf,"%-3s","");
			break;
		case 1:
			fprintf(elf,"%-3s","E");
			break;
		case 2:
			fprintf(elf,"%-3s","W");
			break;
		case 3:
			fprintf(elf,"%-3s","WE");
			break;
		case 4:
			fprintf(elf,"%-3s","R");
			break;
		case 5:
			fprintf(elf,"%-3s","RE");
			if((unsigned int)elf64_phdr.p_type == 1)
			{
				cadr = (unsigned long long)elf64_phdr.p_offset;
				csize = (unsigned long long)elf64_phdr.p_filesz;
				cvadr = (unsigned long long)elf64_phdr.p_vaddr;
			}
			break;
		case 6:
			fprintf(elf,"%-3s","RW");
			if((unsigned int)elf64_phdr.p_type == 1)
			{
				dadr = (unsigned long long)elf64_phdr.p_offset;
				dsize = (unsigned long long)elf64_phdr.p_filesz;
				dvadr = (unsigned long long)elf64_phdr.p_vaddr;
			}
			break;
		case 7:
			fprintf(elf,"%-3s","RWE");
			break;
		default:
			fprintf(elf,"%-3s","???");
			break;
		}
		fprintf(elf,"\n");
	}
}


void ElfReader::read_symtable()
{
	Elf64_Sym elf64_sym;

	fseek(file, stradr, SEEK_SET);
	char* stringTable = new char[strLen];
	fread(stringTable,1,strLen,file);

	fseek(file, symadr, SEEK_SET);
	
	for(unsigned int c=0;c<symnum;c++)
	{
		fprintf(elf," [%3d]   ",c);
		
		//file should be relocated
		fread(&elf64_sym,1,sizeof(elf64_sym),file);

		fprintf(elf," Name:  %40s   ", 
				stringTable + (unsigned int)elf64_sym.st_name);
		
		char* name = stringTable + (unsigned int)elf64_sym.st_name;

		if(strcmp(name, "main") == 0)
		{
			madr = (unsigned long long)elf64_sym.st_value;
			// NOTE: why size is not aligned by 4 byte?
			mend = madr + (unsigned long long)elf64_sym.st_size + STRANGE_MAGIC_NUMBER - 4;
		}

		if(strcmp(name, "__global_pointer$") == 0)
			gp = (unsigned long long)elf64_sym.st_value;
		
		if(strcmp(name, "atexit") == 0)
			endPC = (unsigned long long)elf64_sym.st_value;

		for(int i = 0; i < monitorCnt; ++i)
		{
			if(strcmp(name, monitorTable[i].name) == 0)
				monitorTable[i].vadr = (unsigned long long)elf64_sym.st_value;
				
		}	

		fprintf(elf," Bind:	");
		switch (elf64_sym.st_info >> 4)
		{
		case 0:
			fprintf(elf,"%6s","LOCAL");
			break;
		case 1:
			fprintf(elf,"%6s","GLOBAL");
			break;
		case 2:
			fprintf(elf,"%6s","WEAK");
			break;
		case 13:
			fprintf(elf,"%6s","LOPROC");
			break;
		case 15:
			fprintf(elf,"%6s","HIPROC");
			break;
		default:
			fprintf(elf,"%6s","??????");
			break;
		}
		
		fprintf(elf," Type:	");
		switch (elf64_sym.st_info & 0xf)
		{
		case 0:
			fprintf(elf,"%7s","NOTYPE");
			break;
		case 1:
			fprintf(elf,"%7s","OBJECT");
			break;
		case 2:
			fprintf(elf,"%7s","FUNC");
			break;
		case 3:
			fprintf(elf,"%7s","SECTION");
			break;
		case 4:
			fprintf(elf,"%7s","FILE");
			break;
		case 13:
			fprintf(elf,"%7s","LOPROC");
			break;
		case 15:
			fprintf(elf,"%7s","HIPROC");
			break;
		default:
			fprintf(elf,"%7s","??????");
			break;
		}
		
		fprintf(elf," NDX:	%-6hu", (unsigned short)elf64_sym.st_shndx);
		
		fprintf(elf," Size:	%llu",(unsigned long long)elf64_sym.st_size);

		fprintf(elf," Value:	%016llx\n", (unsigned long long)elf64_sym.st_value);

	}
	delete stringTable;
}


