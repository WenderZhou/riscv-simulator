
qsort:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <_start>:
   100b0:	00002197          	auipc	gp,0x2
   100b4:	ea818193          	addi	gp,gp,-344 # 11f58 <__global_pointer$>
   100b8:	81818513          	addi	a0,gp,-2024 # 11770 <_edata>
   100bc:	91018613          	addi	a2,gp,-1776 # 11868 <_end>
   100c0:	8e09                	sub	a2,a2,a0
   100c2:	4581                	li	a1,0
   100c4:	428000ef          	jal	ra,104ec <memset>
   100c8:	00000517          	auipc	a0,0x0
   100cc:	36e50513          	addi	a0,a0,878 # 10436 <__libc_fini_array>
   100d0:	00000097          	auipc	ra,0x0
   100d4:	332080e7          	jalr	818(ra) # 10402 <atexit>
   100d8:	00000097          	auipc	ra,0x0
   100dc:	3ac080e7          	jalr	940(ra) # 10484 <__libc_init_array>
   100e0:	4502                	lw	a0,0(sp)
   100e2:	002c                	addi	a1,sp,8
   100e4:	4601                	li	a2,0
   100e6:	296000ef          	jal	ra,1037c <main>
   100ea:	00000317          	auipc	t1,0x0
   100ee:	32630067          	jr	806(t1) # 10410 <exit>

00000000000100f2 <_fini>:
   100f2:	8082                	ret

00000000000100f4 <deregister_tm_clones>:
   100f4:	6545                	lui	a0,0x11
   100f6:	67c5                	lui	a5,0x11
   100f8:	75850713          	addi	a4,a0,1880 # 11758 <__TMC_END__>
   100fc:	75878793          	addi	a5,a5,1880 # 11758 <__TMC_END__>
   10100:	00e78b63          	beq	a5,a4,10116 <deregister_tm_clones+0x22>
   10104:	00000337          	lui	t1,0x0
   10108:	00030313          	mv	t1,t1
   1010c:	00030563          	beqz	t1,10116 <deregister_tm_clones+0x22>
   10110:	75850513          	addi	a0,a0,1880
   10114:	8302                	jr	t1
   10116:	8082                	ret

0000000000010118 <register_tm_clones>:
   10118:	67c5                	lui	a5,0x11
   1011a:	6545                	lui	a0,0x11
   1011c:	75878593          	addi	a1,a5,1880 # 11758 <__TMC_END__>
   10120:	75850793          	addi	a5,a0,1880 # 11758 <__TMC_END__>
   10124:	8d9d                	sub	a1,a1,a5
   10126:	858d                	srai	a1,a1,0x3
   10128:	4789                	li	a5,2
   1012a:	02f5c5b3          	div	a1,a1,a5
   1012e:	c991                	beqz	a1,10142 <register_tm_clones+0x2a>
   10130:	00000337          	lui	t1,0x0
   10134:	00030313          	mv	t1,t1
   10138:	00030563          	beqz	t1,10142 <register_tm_clones+0x2a>
   1013c:	75850513          	addi	a0,a0,1880
   10140:	8302                	jr	t1
   10142:	8082                	ret

0000000000010144 <__do_global_dtors_aux>:
   10144:	8201c703          	lbu	a4,-2016(gp) # 11778 <completed.5184>
   10148:	eb15                	bnez	a4,1017c <__do_global_dtors_aux+0x38>
   1014a:	1141                	addi	sp,sp,-16
   1014c:	e022                	sd	s0,0(sp)
   1014e:	e406                	sd	ra,8(sp)
   10150:	843e                	mv	s0,a5
   10152:	fa3ff0ef          	jal	ra,100f4 <deregister_tm_clones>
   10156:	000007b7          	lui	a5,0x0
   1015a:	00078793          	mv	a5,a5
   1015e:	cb81                	beqz	a5,1016e <__do_global_dtors_aux+0x2a>
   10160:	6545                	lui	a0,0x11
   10162:	abc50513          	addi	a0,a0,-1348 # 10abc <__EH_FRAME_BEGIN__>
   10166:	ffff0097          	auipc	ra,0xffff0
   1016a:	e9a080e7          	jalr	-358(ra) # 0 <_start-0x100b0>
   1016e:	4785                	li	a5,1
   10170:	82f18023          	sb	a5,-2016(gp) # 11778 <completed.5184>
   10174:	60a2                	ld	ra,8(sp)
   10176:	6402                	ld	s0,0(sp)
   10178:	0141                	addi	sp,sp,16
   1017a:	8082                	ret
   1017c:	8082                	ret

000000000001017e <frame_dummy>:
   1017e:	000007b7          	lui	a5,0x0
   10182:	00078793          	mv	a5,a5
   10186:	cf99                	beqz	a5,101a4 <frame_dummy+0x26>
   10188:	65c5                	lui	a1,0x11
   1018a:	6545                	lui	a0,0x11
   1018c:	1141                	addi	sp,sp,-16
   1018e:	78058593          	addi	a1,a1,1920 # 11780 <object.5189>
   10192:	abc50513          	addi	a0,a0,-1348 # 10abc <__EH_FRAME_BEGIN__>
   10196:	e406                	sd	ra,8(sp)
   10198:	ffff0097          	auipc	ra,0xffff0
   1019c:	e68080e7          	jalr	-408(ra) # 0 <_start-0x100b0>
   101a0:	60a2                	ld	ra,8(sp)
   101a2:	0141                	addi	sp,sp,16
   101a4:	f75ff06f          	j	10118 <register_tm_clones>

00000000000101a8 <qsort>:
   101a8:	fd010113          	addi	sp,sp,-48
   101ac:	02113423          	sd	ra,40(sp)
   101b0:	02813023          	sd	s0,32(sp)
   101b4:	03010413          	addi	s0,sp,48
   101b8:	00050793          	mv	a5,a0
   101bc:	00058713          	mv	a4,a1
   101c0:	fcf42e23          	sw	a5,-36(s0)
   101c4:	00070793          	mv	a5,a4
   101c8:	fcf42c23          	sw	a5,-40(s0)
   101cc:	000117b7          	lui	a5,0x11
   101d0:	fdc42703          	lw	a4,-36(s0)
   101d4:	00271713          	slli	a4,a4,0x2
   101d8:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   101dc:	00f707b3          	add	a5,a4,a5
   101e0:	0007a783          	lw	a5,0(a5)
   101e4:	fef42223          	sw	a5,-28(s0)
   101e8:	fdc42783          	lw	a5,-36(s0)
   101ec:	fef42623          	sw	a5,-20(s0)
   101f0:	fd842783          	lw	a5,-40(s0)
   101f4:	fef42423          	sw	a5,-24(s0)
   101f8:	fdc42703          	lw	a4,-36(s0)
   101fc:	fd842783          	lw	a5,-40(s0)
   10200:	0007071b          	sext.w	a4,a4
   10204:	0007879b          	sext.w	a5,a5
   10208:	16f75063          	ble	a5,a4,10368 <qsort+0x1c0>
   1020c:	0f00006f          	j	102fc <qsort+0x154>
   10210:	fe842783          	lw	a5,-24(s0)
   10214:	fff7879b          	addiw	a5,a5,-1
   10218:	fef42423          	sw	a5,-24(s0)
   1021c:	fec42703          	lw	a4,-20(s0)
   10220:	fe842783          	lw	a5,-24(s0)
   10224:	0007071b          	sext.w	a4,a4
   10228:	0007879b          	sext.w	a5,a5
   1022c:	02f75463          	ble	a5,a4,10254 <qsort+0xac>
   10230:	000117b7          	lui	a5,0x11
   10234:	fe842703          	lw	a4,-24(s0)
   10238:	00271713          	slli	a4,a4,0x2
   1023c:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   10240:	00f707b3          	add	a5,a4,a5
   10244:	0007a703          	lw	a4,0(a5)
   10248:	fe442783          	lw	a5,-28(s0)
   1024c:	0007879b          	sext.w	a5,a5
   10250:	fcf750e3          	ble	a5,a4,10210 <qsort+0x68>
   10254:	000117b7          	lui	a5,0x11
   10258:	fe842703          	lw	a4,-24(s0)
   1025c:	00271713          	slli	a4,a4,0x2
   10260:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   10264:	00f707b3          	add	a5,a4,a5
   10268:	0007a703          	lw	a4,0(a5)
   1026c:	000117b7          	lui	a5,0x11
   10270:	fec42683          	lw	a3,-20(s0)
   10274:	00269693          	slli	a3,a3,0x2
   10278:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   1027c:	00f687b3          	add	a5,a3,a5
   10280:	00e7a023          	sw	a4,0(a5)
   10284:	0100006f          	j	10294 <qsort+0xec>
   10288:	fec42783          	lw	a5,-20(s0)
   1028c:	0017879b          	addiw	a5,a5,1
   10290:	fef42623          	sw	a5,-20(s0)
   10294:	fec42703          	lw	a4,-20(s0)
   10298:	fe842783          	lw	a5,-24(s0)
   1029c:	0007071b          	sext.w	a4,a4
   102a0:	0007879b          	sext.w	a5,a5
   102a4:	02f75463          	ble	a5,a4,102cc <qsort+0x124>
   102a8:	000117b7          	lui	a5,0x11
   102ac:	fec42703          	lw	a4,-20(s0)
   102b0:	00271713          	slli	a4,a4,0x2
   102b4:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   102b8:	00f707b3          	add	a5,a4,a5
   102bc:	0007a703          	lw	a4,0(a5)
   102c0:	fe442783          	lw	a5,-28(s0)
   102c4:	0007879b          	sext.w	a5,a5
   102c8:	fce7d0e3          	ble	a4,a5,10288 <qsort+0xe0>
   102cc:	000117b7          	lui	a5,0x11
   102d0:	fec42703          	lw	a4,-20(s0)
   102d4:	00271713          	slli	a4,a4,0x2
   102d8:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   102dc:	00f707b3          	add	a5,a4,a5
   102e0:	0007a703          	lw	a4,0(a5)
   102e4:	000117b7          	lui	a5,0x11
   102e8:	fe842683          	lw	a3,-24(s0)
   102ec:	00269693          	slli	a3,a3,0x2
   102f0:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   102f4:	00f687b3          	add	a5,a3,a5
   102f8:	00e7a023          	sw	a4,0(a5)
   102fc:	fec42703          	lw	a4,-20(s0)
   10300:	fe842783          	lw	a5,-24(s0)
   10304:	0007071b          	sext.w	a4,a4
   10308:	0007879b          	sext.w	a5,a5
   1030c:	f0f748e3          	blt	a4,a5,1021c <qsort+0x74>
   10310:	000117b7          	lui	a5,0x11
   10314:	fec42703          	lw	a4,-20(s0)
   10318:	00271713          	slli	a4,a4,0x2
   1031c:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   10320:	00f707b3          	add	a5,a4,a5
   10324:	fe442703          	lw	a4,-28(s0)
   10328:	00e7a023          	sw	a4,0(a5)
   1032c:	fec42783          	lw	a5,-20(s0)
   10330:	fff7879b          	addiw	a5,a5,-1
   10334:	0007871b          	sext.w	a4,a5
   10338:	fdc42783          	lw	a5,-36(s0)
   1033c:	00070593          	mv	a1,a4
   10340:	00078513          	mv	a0,a5
   10344:	e65ff0ef          	jal	ra,101a8 <qsort>
   10348:	fec42783          	lw	a5,-20(s0)
   1034c:	0017879b          	addiw	a5,a5,1
   10350:	0007879b          	sext.w	a5,a5
   10354:	fd842703          	lw	a4,-40(s0)
   10358:	00070593          	mv	a1,a4
   1035c:	00078513          	mv	a0,a5
   10360:	e49ff0ef          	jal	ra,101a8 <qsort>
   10364:	0080006f          	j	1036c <qsort+0x1c4>
   10368:	00000013          	nop
   1036c:	02813083          	ld	ra,40(sp)
   10370:	02013403          	ld	s0,32(sp)
   10374:	03010113          	addi	sp,sp,48
   10378:	00008067          	ret

000000000001037c <main>:
   1037c:	fe010113          	addi	sp,sp,-32
   10380:	00113c23          	sd	ra,24(sp)
   10384:	00813823          	sd	s0,16(sp)
   10388:	02010413          	addi	s0,sp,32
   1038c:	fe042623          	sw	zero,-20(s0)
   10390:	0380006f          	j	103c8 <main+0x4c>
   10394:	02700713          	li	a4,39
   10398:	fec42783          	lw	a5,-20(s0)
   1039c:	40f707bb          	subw	a5,a4,a5
   103a0:	0007871b          	sext.w	a4,a5
   103a4:	000117b7          	lui	a5,0x11
   103a8:	fec42683          	lw	a3,-20(s0)
   103ac:	00269693          	slli	a3,a3,0x2
   103b0:	7b078793          	addi	a5,a5,1968 # 117b0 <result>
   103b4:	00f687b3          	add	a5,a3,a5
   103b8:	00e7a023          	sw	a4,0(a5)
   103bc:	fec42783          	lw	a5,-20(s0)
   103c0:	0017879b          	addiw	a5,a5,1
   103c4:	fef42623          	sw	a5,-20(s0)
   103c8:	fec42783          	lw	a5,-20(s0)
   103cc:	0007871b          	sext.w	a4,a5
   103d0:	02700793          	li	a5,39
   103d4:	fce7d0e3          	ble	a4,a5,10394 <main+0x18>
   103d8:	02700593          	li	a1,39
   103dc:	00000513          	li	a0,0
   103e0:	00000097          	auipc	ra,0x0
   103e4:	dc8080e7          	jalr	-568(ra) # 101a8 <qsort>
   103e8:	00000793          	li	a5,0
   103ec:	00078513          	mv	a0,a5
   103f0:	01813083          	ld	ra,24(sp)
   103f4:	01013403          	ld	s0,16(sp)
   103f8:	02010113          	addi	sp,sp,32
   103fc:	00008067          	ret
	...

0000000000010402 <atexit>:
   10402:	85aa                	mv	a1,a0
   10404:	4681                	li	a3,0
   10406:	4601                	li	a2,0
   10408:	4501                	li	a0,0
   1040a:	18c0006f          	j	10596 <__register_exitproc>
	...

0000000000010410 <exit>:
   10410:	1141                	addi	sp,sp,-16
   10412:	4581                	li	a1,0
   10414:	e022                	sd	s0,0(sp)
   10416:	e406                	sd	ra,8(sp)
   10418:	842a                	mv	s0,a0
   1041a:	1e4000ef          	jal	ra,105fe <__call_exitprocs>
   1041e:	67c5                	lui	a5,0x11
   10420:	7607b503          	ld	a0,1888(a5) # 11760 <_global_impure_ptr>
   10424:	6d3c                	ld	a5,88(a0)
   10426:	c391                	beqz	a5,1042a <exit+0x1a>
   10428:	9782                	jalr	a5
   1042a:	8522                	mv	a0,s0
   1042c:	00000097          	auipc	ra,0x0
   10430:	66e080e7          	jalr	1646(ra) # 10a9a <_exit>
	...

0000000000010436 <__libc_fini_array>:
   10436:	7179                	addi	sp,sp,-48
   10438:	67c5                	lui	a5,0x11
   1043a:	6745                	lui	a4,0x11
   1043c:	f022                	sd	s0,32(sp)
   1043e:	00870713          	addi	a4,a4,8 # 11008 <__init_array_end>
   10442:	01078413          	addi	s0,a5,16 # 11010 <__fini_array_end>
   10446:	8c19                	sub	s0,s0,a4
   10448:	ec26                	sd	s1,24(sp)
   1044a:	e84a                	sd	s2,16(sp)
   1044c:	e44e                	sd	s3,8(sp)
   1044e:	f406                	sd	ra,40(sp)
   10450:	840d                	srai	s0,s0,0x3
   10452:	4481                	li	s1,0
   10454:	01078913          	addi	s2,a5,16
   10458:	59e1                	li	s3,-8
   1045a:	00941c63          	bne	s0,s1,10472 <__libc_fini_array+0x3c>
   1045e:	7402                	ld	s0,32(sp)
   10460:	70a2                	ld	ra,40(sp)
   10462:	64e2                	ld	s1,24(sp)
   10464:	6942                	ld	s2,16(sp)
   10466:	69a2                	ld	s3,8(sp)
   10468:	6145                	addi	sp,sp,48
   1046a:	00000317          	auipc	t1,0x0
   1046e:	c8830067          	jr	-888(t1) # 100f2 <_fini>
   10472:	033487b3          	mul	a5,s1,s3
   10476:	0485                	addi	s1,s1,1
   10478:	97ca                	add	a5,a5,s2
   1047a:	ff87b783          	ld	a5,-8(a5)
   1047e:	9782                	jalr	a5
   10480:	bfe9                	j	1045a <__libc_fini_array+0x24>
	...

0000000000010484 <__libc_init_array>:
   10484:	1101                	addi	sp,sp,-32
   10486:	e822                	sd	s0,16(sp)
   10488:	e426                	sd	s1,8(sp)
   1048a:	6445                	lui	s0,0x11
   1048c:	64c5                	lui	s1,0x11
   1048e:	00048793          	mv	a5,s1
   10492:	00040413          	mv	s0,s0
   10496:	8c1d                	sub	s0,s0,a5
   10498:	e04a                	sd	s2,0(sp)
   1049a:	ec06                	sd	ra,24(sp)
   1049c:	840d                	srai	s0,s0,0x3
   1049e:	00048493          	mv	s1,s1
   104a2:	4901                	li	s2,0
   104a4:	02891963          	bne	s2,s0,104d6 <__libc_init_array+0x52>
   104a8:	64c5                	lui	s1,0x11
   104aa:	00000097          	auipc	ra,0x0
   104ae:	c48080e7          	jalr	-952(ra) # 100f2 <_fini>
   104b2:	6445                	lui	s0,0x11
   104b4:	00048793          	mv	a5,s1
   104b8:	00840413          	addi	s0,s0,8 # 11008 <__init_array_end>
   104bc:	8c1d                	sub	s0,s0,a5
   104be:	840d                	srai	s0,s0,0x3
   104c0:	00048493          	mv	s1,s1
   104c4:	4901                	li	s2,0
   104c6:	00891d63          	bne	s2,s0,104e0 <__libc_init_array+0x5c>
   104ca:	60e2                	ld	ra,24(sp)
   104cc:	6442                	ld	s0,16(sp)
   104ce:	64a2                	ld	s1,8(sp)
   104d0:	6902                	ld	s2,0(sp)
   104d2:	6105                	addi	sp,sp,32
   104d4:	8082                	ret
   104d6:	609c                	ld	a5,0(s1)
   104d8:	0905                	addi	s2,s2,1
   104da:	04a1                	addi	s1,s1,8
   104dc:	9782                	jalr	a5
   104de:	b7d9                	j	104a4 <__libc_init_array+0x20>
   104e0:	609c                	ld	a5,0(s1)
   104e2:	0905                	addi	s2,s2,1
   104e4:	04a1                	addi	s1,s1,8
   104e6:	9782                	jalr	a5
   104e8:	bff9                	j	104c6 <__libc_init_array+0x42>
	...

00000000000104ec <memset>:
   104ec:	483d                	li	a6,15
   104ee:	872a                	mv	a4,a0
   104f0:	02c87163          	bleu	a2,a6,10512 <memset+0x26>
   104f4:	00f77793          	andi	a5,a4,15
   104f8:	e3c1                	bnez	a5,10578 <memset+0x8c>
   104fa:	e1bd                	bnez	a1,10560 <memset+0x74>
   104fc:	ff067693          	andi	a3,a2,-16
   10500:	8a3d                	andi	a2,a2,15
   10502:	96ba                	add	a3,a3,a4
   10504:	e30c                	sd	a1,0(a4)
   10506:	e70c                	sd	a1,8(a4)
   10508:	0741                	addi	a4,a4,16
   1050a:	fed76de3          	bltu	a4,a3,10504 <memset+0x18>
   1050e:	e211                	bnez	a2,10512 <memset+0x26>
   10510:	8082                	ret
   10512:	40c806b3          	sub	a3,a6,a2
   10516:	068a                	slli	a3,a3,0x2
   10518:	00000297          	auipc	t0,0x0
   1051c:	9696                	add	a3,a3,t0
   1051e:	00a68067          	jr	10(a3)
   10522:	00b70723          	sb	a1,14(a4)
   10526:	00b706a3          	sb	a1,13(a4)
   1052a:	00b70623          	sb	a1,12(a4)
   1052e:	00b705a3          	sb	a1,11(a4)
   10532:	00b70523          	sb	a1,10(a4)
   10536:	00b704a3          	sb	a1,9(a4)
   1053a:	00b70423          	sb	a1,8(a4)
   1053e:	00b703a3          	sb	a1,7(a4)
   10542:	00b70323          	sb	a1,6(a4)
   10546:	00b702a3          	sb	a1,5(a4)
   1054a:	00b70223          	sb	a1,4(a4)
   1054e:	00b701a3          	sb	a1,3(a4)
   10552:	00b70123          	sb	a1,2(a4)
   10556:	00b700a3          	sb	a1,1(a4)
   1055a:	00b70023          	sb	a1,0(a4)
   1055e:	8082                	ret
   10560:	0ff5f593          	andi	a1,a1,255
   10564:	00859693          	slli	a3,a1,0x8
   10568:	8dd5                	or	a1,a1,a3
   1056a:	01059693          	slli	a3,a1,0x10
   1056e:	8dd5                	or	a1,a1,a3
   10570:	02059693          	slli	a3,a1,0x20
   10574:	8dd5                	or	a1,a1,a3
   10576:	b759                	j	104fc <memset+0x10>
   10578:	00279693          	slli	a3,a5,0x2
   1057c:	00000297          	auipc	t0,0x0
   10580:	9696                	add	a3,a3,t0
   10582:	8286                	mv	t0,ra
   10584:	fa2680e7          	jalr	-94(a3)
   10588:	8096                	mv	ra,t0
   1058a:	17c1                	addi	a5,a5,-16
   1058c:	8f1d                	sub	a4,a4,a5
   1058e:	963e                	add	a2,a2,a5
   10590:	f8c871e3          	bleu	a2,a6,10512 <memset+0x26>
   10594:	b79d                	j	104fa <memset+0xe>

0000000000010596 <__register_exitproc>:
   10596:	67c5                	lui	a5,0x11
   10598:	7607b703          	ld	a4,1888(a5) # 11760 <_global_impure_ptr>
   1059c:	832a                	mv	t1,a0
   1059e:	1f873783          	ld	a5,504(a4)
   105a2:	e789                	bnez	a5,105ac <__register_exitproc+0x16>
   105a4:	20070793          	addi	a5,a4,512
   105a8:	1ef73c23          	sd	a5,504(a4)
   105ac:	4798                	lw	a4,8(a5)
   105ae:	487d                	li	a6,31
   105b0:	557d                	li	a0,-1
   105b2:	04e84463          	blt	a6,a4,105fa <__register_exitproc+0x64>
   105b6:	02030a63          	beqz	t1,105ea <__register_exitproc+0x54>
   105ba:	00371813          	slli	a6,a4,0x3
   105be:	983e                	add	a6,a6,a5
   105c0:	10c83823          	sd	a2,272(a6)
   105c4:	3107a883          	lw	a7,784(a5)
   105c8:	4605                	li	a2,1
   105ca:	00e6163b          	sllw	a2,a2,a4
   105ce:	00c8e8b3          	or	a7,a7,a2
   105d2:	3117a823          	sw	a7,784(a5)
   105d6:	20d83823          	sd	a3,528(a6)
   105da:	4689                	li	a3,2
   105dc:	00d31763          	bne	t1,a3,105ea <__register_exitproc+0x54>
   105e0:	3147a683          	lw	a3,788(a5)
   105e4:	8e55                	or	a2,a2,a3
   105e6:	30c7aa23          	sw	a2,788(a5)
   105ea:	0017069b          	addiw	a3,a4,1
   105ee:	0709                	addi	a4,a4,2
   105f0:	070e                	slli	a4,a4,0x3
   105f2:	c794                	sw	a3,8(a5)
   105f4:	97ba                	add	a5,a5,a4
   105f6:	e38c                	sd	a1,0(a5)
   105f8:	4501                	li	a0,0
   105fa:	8082                	ret
	...

00000000000105fe <__call_exitprocs>:
   105fe:	715d                	addi	sp,sp,-80
   10600:	67c5                	lui	a5,0x11
   10602:	f44e                	sd	s3,40(sp)
   10604:	7607b983          	ld	s3,1888(a5) # 11760 <_global_impure_ptr>
   10608:	f052                	sd	s4,32(sp)
   1060a:	ec56                	sd	s5,24(sp)
   1060c:	e85a                	sd	s6,16(sp)
   1060e:	e486                	sd	ra,72(sp)
   10610:	e0a2                	sd	s0,64(sp)
   10612:	fc26                	sd	s1,56(sp)
   10614:	f84a                	sd	s2,48(sp)
   10616:	e45e                	sd	s7,8(sp)
   10618:	8aaa                	mv	s5,a0
   1061a:	8a2e                	mv	s4,a1
   1061c:	4b05                	li	s6,1
   1061e:	1f89b403          	ld	s0,504(s3)
   10622:	c801                	beqz	s0,10632 <__call_exitprocs+0x34>
   10624:	4404                	lw	s1,8(s0)
   10626:	34fd                	addiw	s1,s1,-1
   10628:	00349913          	slli	s2,s1,0x3
   1062c:	9922                	add	s2,s2,s0
   1062e:	0004dd63          	bgez	s1,10648 <__call_exitprocs+0x4a>
   10632:	60a6                	ld	ra,72(sp)
   10634:	6406                	ld	s0,64(sp)
   10636:	74e2                	ld	s1,56(sp)
   10638:	7942                	ld	s2,48(sp)
   1063a:	79a2                	ld	s3,40(sp)
   1063c:	7a02                	ld	s4,32(sp)
   1063e:	6ae2                	ld	s5,24(sp)
   10640:	6b42                	ld	s6,16(sp)
   10642:	6ba2                	ld	s7,8(sp)
   10644:	6161                	addi	sp,sp,80
   10646:	8082                	ret
   10648:	000a0963          	beqz	s4,1065a <__call_exitprocs+0x5c>
   1064c:	21093783          	ld	a5,528(s2)
   10650:	01478563          	beq	a5,s4,1065a <__call_exitprocs+0x5c>
   10654:	34fd                	addiw	s1,s1,-1
   10656:	1961                	addi	s2,s2,-8
   10658:	bfd9                	j	1062e <__call_exitprocs+0x30>
   1065a:	441c                	lw	a5,8(s0)
   1065c:	01093683          	ld	a3,16(s2)
   10660:	37fd                	addiw	a5,a5,-1
   10662:	02979663          	bne	a5,s1,1068e <__call_exitprocs+0x90>
   10666:	c404                	sw	s1,8(s0)
   10668:	d6f5                	beqz	a3,10654 <__call_exitprocs+0x56>
   1066a:	31042703          	lw	a4,784(s0)
   1066e:	009b163b          	sllw	a2,s6,s1
   10672:	00842b83          	lw	s7,8(s0)
   10676:	8f71                	and	a4,a4,a2
   10678:	2701                	sext.w	a4,a4
   1067a:	ef09                	bnez	a4,10694 <__call_exitprocs+0x96>
   1067c:	9682                	jalr	a3
   1067e:	4418                	lw	a4,8(s0)
   10680:	1f89b783          	ld	a5,504(s3)
   10684:	f9771de3          	bne	a4,s7,1061e <__call_exitprocs+0x20>
   10688:	fcf406e3          	beq	s0,a5,10654 <__call_exitprocs+0x56>
   1068c:	bf49                	j	1061e <__call_exitprocs+0x20>
   1068e:	00093823          	sd	zero,16(s2)
   10692:	bfd9                	j	10668 <__call_exitprocs+0x6a>
   10694:	31442783          	lw	a5,788(s0)
   10698:	11093583          	ld	a1,272(s2)
   1069c:	8ff1                	and	a5,a5,a2
   1069e:	2781                	sext.w	a5,a5
   106a0:	e781                	bnez	a5,106a8 <__call_exitprocs+0xaa>
   106a2:	8556                	mv	a0,s5
   106a4:	9682                	jalr	a3
   106a6:	bfe1                	j	1067e <__call_exitprocs+0x80>
   106a8:	852e                	mv	a0,a1
   106aa:	9682                	jalr	a3
   106ac:	bfc9                	j	1067e <__call_exitprocs+0x80>
	...

00000000000106b0 <conv_stat>:
   106b0:	619c                	ld	a5,0(a1)
   106b2:	00f51023          	sh	a5,0(a0)
   106b6:	659c                	ld	a5,8(a1)
   106b8:	00f51123          	sh	a5,2(a0)
   106bc:	499c                	lw	a5,16(a1)
   106be:	c15c                	sw	a5,4(a0)
   106c0:	49dc                	lw	a5,20(a1)
   106c2:	00f51423          	sh	a5,8(a0)
   106c6:	4d9c                	lw	a5,24(a1)
   106c8:	00f51523          	sh	a5,10(a0)
   106cc:	4ddc                	lw	a5,28(a1)
   106ce:	00f51623          	sh	a5,12(a0)
   106d2:	719c                	ld	a5,32(a1)
   106d4:	00f51723          	sh	a5,14(a0)
   106d8:	799c                	ld	a5,48(a1)
   106da:	e91c                	sd	a5,16(a0)
   106dc:	61bc                	ld	a5,64(a1)
   106de:	e93c                	sd	a5,80(a0)
   106e0:	5d9c                	lw	a5,56(a1)
   106e2:	e53c                	sd	a5,72(a0)
   106e4:	65bc                	ld	a5,72(a1)
   106e6:	ed1c                	sd	a5,24(a0)
   106e8:	6dbc                	ld	a5,88(a1)
   106ea:	f51c                	sd	a5,40(a0)
   106ec:	75bc                	ld	a5,104(a1)
   106ee:	fd1c                	sd	a5,56(a0)
   106f0:	8082                	ret

00000000000106f2 <__syscall_error>:
   106f2:	1141                	addi	sp,sp,-16
   106f4:	e022                	sd	s0,0(sp)
   106f6:	e406                	sd	ra,8(sp)
   106f8:	842a                	mv	s0,a0
   106fa:	00000097          	auipc	ra,0x0
   106fe:	3ba080e7          	jalr	954(ra) # 10ab4 <__errno>
   10702:	408007bb          	negw	a5,s0
   10706:	60a2                	ld	ra,8(sp)
   10708:	6402                	ld	s0,0(sp)
   1070a:	c11c                	sw	a5,0(a0)
   1070c:	557d                	li	a0,-1
   1070e:	0141                	addi	sp,sp,16
   10710:	8082                	ret

0000000000010712 <__internal_syscall>:
   10712:	88aa                	mv	a7,a0
   10714:	852e                	mv	a0,a1
   10716:	85b2                	mv	a1,a2
   10718:	8636                	mv	a2,a3
   1071a:	86ba                	mv	a3,a4
   1071c:	00000073          	ecall
   10720:	00055663          	bgez	a0,1072c <__internal_syscall+0x1a>
   10724:	00000317          	auipc	t1,0x0
   10728:	fce30067          	jr	-50(t1) # 106f2 <__syscall_error>
   1072c:	8082                	ret

000000000001072e <open>:
   1072e:	1141                	addi	sp,sp,-16
   10730:	86b2                	mv	a3,a2
   10732:	4701                	li	a4,0
   10734:	862e                	mv	a2,a1
   10736:	85aa                	mv	a1,a0
   10738:	40000513          	li	a0,1024
   1073c:	e406                	sd	ra,8(sp)
   1073e:	00000097          	auipc	ra,0x0
   10742:	fd4080e7          	jalr	-44(ra) # 10712 <__internal_syscall>
   10746:	60a2                	ld	ra,8(sp)
   10748:	2501                	sext.w	a0,a0
   1074a:	0141                	addi	sp,sp,16
   1074c:	8082                	ret

000000000001074e <openat>:
   1074e:	1141                	addi	sp,sp,-16
   10750:	8736                	mv	a4,a3
   10752:	86b2                	mv	a3,a2
   10754:	862e                	mv	a2,a1
   10756:	85aa                	mv	a1,a0
   10758:	03800513          	li	a0,56
   1075c:	e406                	sd	ra,8(sp)
   1075e:	fb5ff0ef          	jal	ra,10712 <__internal_syscall>
   10762:	60a2                	ld	ra,8(sp)
   10764:	2501                	sext.w	a0,a0
   10766:	0141                	addi	sp,sp,16
   10768:	8082                	ret

000000000001076a <lseek>:
   1076a:	86b2                	mv	a3,a2
   1076c:	4701                	li	a4,0
   1076e:	862e                	mv	a2,a1
   10770:	85aa                	mv	a1,a0
   10772:	03e00513          	li	a0,62
   10776:	00000317          	auipc	t1,0x0
   1077a:	f9c30067          	jr	-100(t1) # 10712 <__internal_syscall>

000000000001077e <read>:
   1077e:	86b2                	mv	a3,a2
   10780:	4701                	li	a4,0
   10782:	862e                	mv	a2,a1
   10784:	85aa                	mv	a1,a0
   10786:	03f00513          	li	a0,63
   1078a:	f89ff06f          	j	10712 <__internal_syscall>

000000000001078e <write>:
   1078e:	86b2                	mv	a3,a2
   10790:	4701                	li	a4,0
   10792:	862e                	mv	a2,a1
   10794:	85aa                	mv	a1,a0
   10796:	04000513          	li	a0,64
   1079a:	00000317          	auipc	t1,0x0
   1079e:	f7830067          	jr	-136(t1) # 10712 <__internal_syscall>

00000000000107a2 <fstat>:
   107a2:	7135                	addi	sp,sp,-160
   107a4:	e526                	sd	s1,136(sp)
   107a6:	860a                	mv	a2,sp
   107a8:	84ae                	mv	s1,a1
   107aa:	4701                	li	a4,0
   107ac:	85aa                	mv	a1,a0
   107ae:	4681                	li	a3,0
   107b0:	05000513          	li	a0,80
   107b4:	ed06                	sd	ra,152(sp)
   107b6:	e922                	sd	s0,144(sp)
   107b8:	f5bff0ef          	jal	ra,10712 <__internal_syscall>
   107bc:	842a                	mv	s0,a0
   107be:	858a                	mv	a1,sp
   107c0:	8526                	mv	a0,s1
   107c2:	eefff0ef          	jal	ra,106b0 <conv_stat>
   107c6:	0004051b          	sext.w	a0,s0
   107ca:	60ea                	ld	ra,152(sp)
   107cc:	644a                	ld	s0,144(sp)
   107ce:	64aa                	ld	s1,136(sp)
   107d0:	610d                	addi	sp,sp,160
   107d2:	8082                	ret

00000000000107d4 <stat>:
   107d4:	7135                	addi	sp,sp,-160
   107d6:	e526                	sd	s1,136(sp)
   107d8:	860a                	mv	a2,sp
   107da:	84ae                	mv	s1,a1
   107dc:	4701                	li	a4,0
   107de:	85aa                	mv	a1,a0
   107e0:	4681                	li	a3,0
   107e2:	40e00513          	li	a0,1038
   107e6:	ed06                	sd	ra,152(sp)
   107e8:	e922                	sd	s0,144(sp)
   107ea:	00000097          	auipc	ra,0x0
   107ee:	f28080e7          	jalr	-216(ra) # 10712 <__internal_syscall>
   107f2:	842a                	mv	s0,a0
   107f4:	858a                	mv	a1,sp
   107f6:	8526                	mv	a0,s1
   107f8:	00000097          	auipc	ra,0x0
   107fc:	eb8080e7          	jalr	-328(ra) # 106b0 <conv_stat>
   10800:	0004051b          	sext.w	a0,s0
   10804:	60ea                	ld	ra,152(sp)
   10806:	644a                	ld	s0,144(sp)
   10808:	64aa                	ld	s1,136(sp)
   1080a:	610d                	addi	sp,sp,160
   1080c:	8082                	ret

000000000001080e <lstat>:
   1080e:	7135                	addi	sp,sp,-160
   10810:	e526                	sd	s1,136(sp)
   10812:	860a                	mv	a2,sp
   10814:	84ae                	mv	s1,a1
   10816:	4701                	li	a4,0
   10818:	85aa                	mv	a1,a0
   1081a:	4681                	li	a3,0
   1081c:	40f00513          	li	a0,1039
   10820:	ed06                	sd	ra,152(sp)
   10822:	e922                	sd	s0,144(sp)
   10824:	eefff0ef          	jal	ra,10712 <__internal_syscall>
   10828:	842a                	mv	s0,a0
   1082a:	858a                	mv	a1,sp
   1082c:	8526                	mv	a0,s1
   1082e:	e83ff0ef          	jal	ra,106b0 <conv_stat>
   10832:	0004051b          	sext.w	a0,s0
   10836:	60ea                	ld	ra,152(sp)
   10838:	644a                	ld	s0,144(sp)
   1083a:	64aa                	ld	s1,136(sp)
   1083c:	610d                	addi	sp,sp,160
   1083e:	8082                	ret

0000000000010840 <fstatat>:
   10840:	7135                	addi	sp,sp,-160
   10842:	e526                	sd	s1,136(sp)
   10844:	8736                	mv	a4,a3
   10846:	84b2                	mv	s1,a2
   10848:	868a                	mv	a3,sp
   1084a:	862e                	mv	a2,a1
   1084c:	85aa                	mv	a1,a0
   1084e:	04f00513          	li	a0,79
   10852:	ed06                	sd	ra,152(sp)
   10854:	e922                	sd	s0,144(sp)
   10856:	00000097          	auipc	ra,0x0
   1085a:	ebc080e7          	jalr	-324(ra) # 10712 <__internal_syscall>
   1085e:	842a                	mv	s0,a0
   10860:	858a                	mv	a1,sp
   10862:	8526                	mv	a0,s1
   10864:	00000097          	auipc	ra,0x0
   10868:	e4c080e7          	jalr	-436(ra) # 106b0 <conv_stat>
   1086c:	0004051b          	sext.w	a0,s0
   10870:	60ea                	ld	ra,152(sp)
   10872:	644a                	ld	s0,144(sp)
   10874:	64aa                	ld	s1,136(sp)
   10876:	610d                	addi	sp,sp,160
   10878:	8082                	ret

000000000001087a <access>:
   1087a:	1141                	addi	sp,sp,-16
   1087c:	862e                	mv	a2,a1
   1087e:	4701                	li	a4,0
   10880:	85aa                	mv	a1,a0
   10882:	4681                	li	a3,0
   10884:	40900513          	li	a0,1033
   10888:	e406                	sd	ra,8(sp)
   1088a:	e89ff0ef          	jal	ra,10712 <__internal_syscall>
   1088e:	60a2                	ld	ra,8(sp)
   10890:	2501                	sext.w	a0,a0
   10892:	0141                	addi	sp,sp,16
   10894:	8082                	ret

0000000000010896 <faccessat>:
   10896:	1141                	addi	sp,sp,-16
   10898:	8736                	mv	a4,a3
   1089a:	86b2                	mv	a3,a2
   1089c:	862e                	mv	a2,a1
   1089e:	85aa                	mv	a1,a0
   108a0:	03000513          	li	a0,48
   108a4:	e406                	sd	ra,8(sp)
   108a6:	00000097          	auipc	ra,0x0
   108aa:	e6c080e7          	jalr	-404(ra) # 10712 <__internal_syscall>
   108ae:	60a2                	ld	ra,8(sp)
   108b0:	2501                	sext.w	a0,a0
   108b2:	0141                	addi	sp,sp,16
   108b4:	8082                	ret

00000000000108b6 <close>:
   108b6:	1141                	addi	sp,sp,-16
   108b8:	85aa                	mv	a1,a0
   108ba:	4701                	li	a4,0
   108bc:	4681                	li	a3,0
   108be:	4601                	li	a2,0
   108c0:	03900513          	li	a0,57
   108c4:	e406                	sd	ra,8(sp)
   108c6:	e4dff0ef          	jal	ra,10712 <__internal_syscall>
   108ca:	60a2                	ld	ra,8(sp)
   108cc:	2501                	sext.w	a0,a0
   108ce:	0141                	addi	sp,sp,16
   108d0:	8082                	ret

00000000000108d2 <link>:
   108d2:	1141                	addi	sp,sp,-16
   108d4:	862e                	mv	a2,a1
   108d6:	4701                	li	a4,0
   108d8:	85aa                	mv	a1,a0
   108da:	4681                	li	a3,0
   108dc:	40100513          	li	a0,1025
   108e0:	e406                	sd	ra,8(sp)
   108e2:	00000097          	auipc	ra,0x0
   108e6:	e30080e7          	jalr	-464(ra) # 10712 <__internal_syscall>
   108ea:	60a2                	ld	ra,8(sp)
   108ec:	2501                	sext.w	a0,a0
   108ee:	0141                	addi	sp,sp,16
   108f0:	8082                	ret

00000000000108f2 <unlink>:
   108f2:	1141                	addi	sp,sp,-16
   108f4:	85aa                	mv	a1,a0
   108f6:	4701                	li	a4,0
   108f8:	4681                	li	a3,0
   108fa:	4601                	li	a2,0
   108fc:	40200513          	li	a0,1026
   10900:	e406                	sd	ra,8(sp)
   10902:	e11ff0ef          	jal	ra,10712 <__internal_syscall>
   10906:	60a2                	ld	ra,8(sp)
   10908:	2501                	sext.w	a0,a0
   1090a:	0141                	addi	sp,sp,16
   1090c:	8082                	ret

000000000001090e <execve>:
   1090e:	1141                	addi	sp,sp,-16
   10910:	e406                	sd	ra,8(sp)
   10912:	00000097          	auipc	ra,0x0
   10916:	1a2080e7          	jalr	418(ra) # 10ab4 <__errno>
   1091a:	60a2                	ld	ra,8(sp)
   1091c:	47b1                	li	a5,12
   1091e:	c11c                	sw	a5,0(a0)
   10920:	557d                	li	a0,-1
   10922:	0141                	addi	sp,sp,16
   10924:	8082                	ret

0000000000010926 <fork>:
   10926:	1141                	addi	sp,sp,-16
   10928:	e406                	sd	ra,8(sp)
   1092a:	18a000ef          	jal	ra,10ab4 <__errno>
   1092e:	60a2                	ld	ra,8(sp)
   10930:	47ad                	li	a5,11
   10932:	c11c                	sw	a5,0(a0)
   10934:	557d                	li	a0,-1
   10936:	0141                	addi	sp,sp,16
   10938:	8082                	ret

000000000001093a <getpid>:
   1093a:	4505                	li	a0,1
   1093c:	8082                	ret

000000000001093e <kill>:
   1093e:	1141                	addi	sp,sp,-16
   10940:	e406                	sd	ra,8(sp)
   10942:	172000ef          	jal	ra,10ab4 <__errno>
   10946:	60a2                	ld	ra,8(sp)
   10948:	47d9                	li	a5,22
   1094a:	c11c                	sw	a5,0(a0)
   1094c:	557d                	li	a0,-1
   1094e:	0141                	addi	sp,sp,16
   10950:	8082                	ret

0000000000010952 <wait>:
   10952:	1141                	addi	sp,sp,-16
   10954:	e406                	sd	ra,8(sp)
   10956:	00000097          	auipc	ra,0x0
   1095a:	15e080e7          	jalr	350(ra) # 10ab4 <__errno>
   1095e:	60a2                	ld	ra,8(sp)
   10960:	47a9                	li	a5,10
   10962:	c11c                	sw	a5,0(a0)
   10964:	557d                	li	a0,-1
   10966:	0141                	addi	sp,sp,16
   10968:	8082                	ret

000000000001096a <isatty>:
   1096a:	7119                	addi	sp,sp,-128
   1096c:	002c                	addi	a1,sp,8
   1096e:	fc86                	sd	ra,120(sp)
   10970:	e33ff0ef          	jal	ra,107a2 <fstat>
   10974:	57fd                	li	a5,-1
   10976:	00f50663          	beq	a0,a5,10982 <isatty+0x18>
   1097a:	4532                	lw	a0,12(sp)
   1097c:	40d5551b          	sraiw	a0,a0,0xd
   10980:	8905                	andi	a0,a0,1
   10982:	70e6                	ld	ra,120(sp)
   10984:	6109                	addi	sp,sp,128
   10986:	8082                	ret

0000000000010988 <gettimeofday>:
   10988:	1141                	addi	sp,sp,-16
   1098a:	85aa                	mv	a1,a0
   1098c:	4701                	li	a4,0
   1098e:	4681                	li	a3,0
   10990:	4601                	li	a2,0
   10992:	0a900513          	li	a0,169
   10996:	e406                	sd	ra,8(sp)
   10998:	00000097          	auipc	ra,0x0
   1099c:	d7a080e7          	jalr	-646(ra) # 10712 <__internal_syscall>
   109a0:	60a2                	ld	ra,8(sp)
   109a2:	2501                	sext.w	a0,a0
   109a4:	0141                	addi	sp,sp,16
   109a6:	8082                	ret

00000000000109a8 <times>:
   109a8:	7179                	addi	sp,sp,-48
   109aa:	f022                	sd	s0,32(sp)
   109ac:	842a                	mv	s0,a0
   109ae:	9001b783          	ld	a5,-1792(gp) # 11858 <t0.2574>
   109b2:	ec26                	sd	s1,24(sp)
   109b4:	f406                	sd	ra,40(sp)
   109b6:	90018493          	addi	s1,gp,-1792 # 11858 <t0.2574>
   109ba:	eb81                	bnez	a5,109ca <times+0x22>
   109bc:	4581                	li	a1,0
   109be:	90018513          	addi	a0,gp,-1792 # 11858 <t0.2574>
   109c2:	00000097          	auipc	ra,0x0
   109c6:	fc6080e7          	jalr	-58(ra) # 10988 <gettimeofday>
   109ca:	850a                	mv	a0,sp
   109cc:	4581                	li	a1,0
   109ce:	00000097          	auipc	ra,0x0
   109d2:	fba080e7          	jalr	-70(ra) # 10988 <gettimeofday>
   109d6:	6098                	ld	a4,0(s1)
   109d8:	6782                	ld	a5,0(sp)
   109da:	6494                	ld	a3,8(s1)
   109dc:	00043823          	sd	zero,16(s0)
   109e0:	8f99                	sub	a5,a5,a4
   109e2:	000f4737          	lui	a4,0xf4
   109e6:	24070713          	addi	a4,a4,576 # f4240 <__global_pointer$+0xe22e8>
   109ea:	02e787b3          	mul	a5,a5,a4
   109ee:	6722                	ld	a4,8(sp)
   109f0:	00043c23          	sd	zero,24(s0)
   109f4:	00043423          	sd	zero,8(s0)
   109f8:	8f15                	sub	a4,a4,a3
   109fa:	70a2                	ld	ra,40(sp)
   109fc:	64e2                	ld	s1,24(sp)
   109fe:	557d                	li	a0,-1
   10a00:	97ba                	add	a5,a5,a4
   10a02:	e01c                	sd	a5,0(s0)
   10a04:	7402                	ld	s0,32(sp)
   10a06:	6145                	addi	sp,sp,48
   10a08:	8082                	ret

0000000000010a0a <ftime>:
   10a0a:	00051423          	sh	zero,8(a0)
   10a0e:	00053023          	sd	zero,0(a0)
   10a12:	4501                	li	a0,0
   10a14:	8082                	ret

0000000000010a16 <utime>:
   10a16:	557d                	li	a0,-1
   10a18:	8082                	ret

0000000000010a1a <chown>:
   10a1a:	557d                	li	a0,-1
   10a1c:	8082                	ret

0000000000010a1e <chmod>:
   10a1e:	557d                	li	a0,-1
   10a20:	8082                	ret

0000000000010a22 <chdir>:
   10a22:	557d                	li	a0,-1
   10a24:	8082                	ret

0000000000010a26 <getcwd>:
   10a26:	4501                	li	a0,0
   10a28:	8082                	ret

0000000000010a2a <sysconf>:
   10a2a:	4789                	li	a5,2
   10a2c:	00f50463          	beq	a0,a5,10a34 <sysconf+0xa>
   10a30:	557d                	li	a0,-1
   10a32:	8082                	ret
   10a34:	000f4537          	lui	a0,0xf4
   10a38:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xe22e8>
   10a3c:	8082                	ret

0000000000010a3e <sbrk>:
   10a3e:	1101                	addi	sp,sp,-32
   10a40:	e822                	sd	s0,16(sp)
   10a42:	8181b783          	ld	a5,-2024(gp) # 11770 <_edata>
   10a46:	e426                	sd	s1,8(sp)
   10a48:	ec06                	sd	ra,24(sp)
   10a4a:	84aa                	mv	s1,a0
   10a4c:	e785                	bnez	a5,10a74 <sbrk+0x36>
   10a4e:	4701                	li	a4,0
   10a50:	4681                	li	a3,0
   10a52:	4601                	li	a2,0
   10a54:	4581                	li	a1,0
   10a56:	0d600513          	li	a0,214
   10a5a:	cb9ff0ef          	jal	ra,10712 <__internal_syscall>
   10a5e:	57fd                	li	a5,-1
   10a60:	00f51863          	bne	a0,a5,10a70 <sbrk+0x32>
   10a64:	557d                	li	a0,-1
   10a66:	60e2                	ld	ra,24(sp)
   10a68:	6442                	ld	s0,16(sp)
   10a6a:	64a2                	ld	s1,8(sp)
   10a6c:	6105                	addi	sp,sp,32
   10a6e:	8082                	ret
   10a70:	80a1bc23          	sd	a0,-2024(gp) # 11770 <_edata>
   10a74:	8181b583          	ld	a1,-2024(gp) # 11770 <_edata>
   10a78:	4701                	li	a4,0
   10a7a:	4681                	li	a3,0
   10a7c:	95a6                	add	a1,a1,s1
   10a7e:	4601                	li	a2,0
   10a80:	0d600513          	li	a0,214
   10a84:	c8fff0ef          	jal	ra,10712 <__internal_syscall>
   10a88:	8181b783          	ld	a5,-2024(gp) # 11770 <_edata>
   10a8c:	94be                	add	s1,s1,a5
   10a8e:	fc951be3          	bne	a0,s1,10a64 <sbrk+0x26>
   10a92:	80a1bc23          	sd	a0,-2024(gp) # 11770 <_edata>
   10a96:	853e                	mv	a0,a5
   10a98:	b7f9                	j	10a66 <sbrk+0x28>

0000000000010a9a <_exit>:
   10a9a:	1141                	addi	sp,sp,-16
   10a9c:	85aa                	mv	a1,a0
   10a9e:	4701                	li	a4,0
   10aa0:	4681                	li	a3,0
   10aa2:	4601                	li	a2,0
   10aa4:	05d00513          	li	a0,93
   10aa8:	e406                	sd	ra,8(sp)
   10aaa:	00000097          	auipc	ra,0x0
   10aae:	c68080e7          	jalr	-920(ra) # 10712 <__internal_syscall>
   10ab2:	a001                	j	10ab2 <_exit+0x18>

0000000000010ab4 <__errno>:
   10ab4:	8101b503          	ld	a0,-2032(gp) # 11768 <_impure_ptr>
   10ab8:	8082                	ret
	...
