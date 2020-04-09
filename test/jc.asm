
./test/jc：     文件格式 elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	a5,0xffff0
   100b4:	f5078793          	addi	a5,a5,-176 # 0 <register_fini-0x100b0>
   100b8:	c791                	beqz	a5,100c4 <register_fini+0x14>
   100ba:	00000517          	auipc	a0,0x0
   100be:	16c50513          	addi	a0,a0,364 # 10226 <__libc_fini_array>
   100c2:	aa2d                	j	101fc <atexit>
   100c4:	8082                	ret

00000000000100c6 <_start>:
   100c6:	00002197          	auipc	gp,0x2
   100ca:	c3a18193          	addi	gp,gp,-966 # 11d00 <__global_pointer$>
   100ce:	f6018513          	addi	a0,gp,-160 # 11c60 <_edata>
   100d2:	fa018613          	addi	a2,gp,-96 # 11ca0 <__BSS_END__>
   100d6:	8e09                	sub	a2,a2,a0
   100d8:	4581                	li	a1,0
   100da:	1ee000ef          	jal	ra,102c8 <memset>
   100de:	00000517          	auipc	a0,0x0
   100e2:	14850513          	addi	a0,a0,328 # 10226 <__libc_fini_array>
   100e6:	116000ef          	jal	ra,101fc <atexit>
   100ea:	174000ef          	jal	ra,1025e <__libc_init_array>
   100ee:	4502                	lw	a0,0(sp)
   100f0:	002c                	addi	a1,sp,8
   100f2:	4601                	li	a2,0
   100f4:	0cc000ef          	jal	ra,101c0 <main>
   100f8:	a239                	j	10206 <exit>

00000000000100fa <__do_global_dtors_aux>:
   100fa:	f681c783          	lbu	a5,-152(gp) # 11c68 <completed.5470>
   100fe:	eb95                	bnez	a5,10132 <__do_global_dtors_aux+0x38>
   10100:	ffff0797          	auipc	a5,0xffff0
   10104:	f0078793          	addi	a5,a5,-256 # 0 <register_fini-0x100b0>
   10108:	c38d                	beqz	a5,1012a <__do_global_dtors_aux+0x30>
   1010a:	1141                	addi	sp,sp,-16
   1010c:	00001517          	auipc	a0,0x1
   10110:	3d450513          	addi	a0,a0,980 # 114e0 <__FRAME_END__>
   10114:	e406                	sd	ra,8(sp)
   10116:	00000097          	auipc	ra,0x0
   1011a:	000000e7          	jalr	zero # 0 <register_fini-0x100b0>
   1011e:	60a2                	ld	ra,8(sp)
   10120:	4785                	li	a5,1
   10122:	f6f18423          	sb	a5,-152(gp) # 11c68 <completed.5470>
   10126:	0141                	addi	sp,sp,16
   10128:	8082                	ret
   1012a:	4785                	li	a5,1
   1012c:	f6f18423          	sb	a5,-152(gp) # 11c68 <completed.5470>
   10130:	8082                	ret
   10132:	8082                	ret

0000000000010134 <frame_dummy>:
   10134:	ffff0797          	auipc	a5,0xffff0
   10138:	ecc78793          	addi	a5,a5,-308 # 0 <register_fini-0x100b0>
   1013c:	cb99                	beqz	a5,10152 <frame_dummy+0x1e>
   1013e:	f7018593          	addi	a1,gp,-144 # 11c70 <object.5475>
   10142:	00001517          	auipc	a0,0x1
   10146:	39e50513          	addi	a0,a0,926 # 114e0 <__FRAME_END__>
   1014a:	00000317          	auipc	t1,0x0
   1014e:	00000067          	jr	zero # 0 <register_fini-0x100b0>
   10152:	8082                	ret

0000000000010154 <cal_n>:
   10154:	fe010113          	addi	sp,sp,-32
   10158:	00113c23          	sd	ra,24(sp)
   1015c:	00813823          	sd	s0,16(sp)
   10160:	02010413          	addi	s0,sp,32
   10164:	00050793          	mv	a5,a0
   10168:	fef42623          	sw	a5,-20(s0)
   1016c:	fec42783          	lw	a5,-20(s0)
   10170:	0007871b          	sext.w	a4,a5
   10174:	00100793          	li	a5,1
   10178:	00f71663          	bne	a4,a5,10184 <cal_n+0x30>
   1017c:	fec42783          	lw	a5,-20(s0)
   10180:	02c0006f          	j	101ac <cal_n+0x58>
   10184:	fec42783          	lw	a5,-20(s0)
   10188:	fff7879b          	addiw	a5,a5,-1
   1018c:	0007879b          	sext.w	a5,a5
   10190:	00078513          	mv	a0,a5
   10194:	fc1ff0ef          	jal	ra,10154 <cal_n>
   10198:	00050793          	mv	a5,a0
   1019c:	00078713          	mv	a4,a5
   101a0:	fec42783          	lw	a5,-20(s0)
   101a4:	02e787bb          	mulw	a5,a5,a4
   101a8:	0007879b          	sext.w	a5,a5
   101ac:	00078513          	mv	a0,a5
   101b0:	01813083          	ld	ra,24(sp)
   101b4:	01013403          	ld	s0,16(sp)
   101b8:	02010113          	addi	sp,sp,32
   101bc:	00008067          	ret

00000000000101c0 <main>:
   101c0:	ff010113          	addi	sp,sp,-16
   101c4:	00113423          	sd	ra,8(sp)
   101c8:	00813023          	sd	s0,0(sp)
   101cc:	01010413          	addi	s0,sp,16
   101d0:	00a00513          	li	a0,10
   101d4:	f81ff0ef          	jal	ra,10154 <cal_n>
   101d8:	00050793          	mv	a5,a0
   101dc:	00078713          	mv	a4,a5
   101e0:	f6e1a023          	sw	a4,-160(gp) # 11c60 <_edata>
   101e4:	00000793          	li	a5,0
   101e8:	00078513          	mv	a0,a5
   101ec:	00813083          	ld	ra,8(sp)
   101f0:	00013403          	ld	s0,0(sp)
   101f4:	01010113          	addi	sp,sp,16
   101f8:	00008067          	ret

00000000000101fc <atexit>:
   101fc:	85aa                	mv	a1,a0
   101fe:	4681                	li	a3,0
   10200:	4601                	li	a2,0
   10202:	4501                	li	a0,0
   10204:	a2bd                	j	10372 <__register_exitproc>

0000000000010206 <exit>:
   10206:	1141                	addi	sp,sp,-16
   10208:	4581                	li	a1,0
   1020a:	e022                	sd	s0,0(sp)
   1020c:	e406                	sd	ra,8(sp)
   1020e:	842a                	mv	s0,a0
   10210:	1da000ef          	jal	ra,103ea <__call_exitprocs>
   10214:	f4818793          	addi	a5,gp,-184 # 11c48 <_global_impure_ptr>
   10218:	6388                	ld	a0,0(a5)
   1021a:	6d3c                	ld	a5,88(a0)
   1021c:	c391                	beqz	a5,10220 <exit+0x1a>
   1021e:	9782                	jalr	a5
   10220:	8522                	mv	a0,s0
   10222:	28a000ef          	jal	ra,104ac <_exit>

0000000000010226 <__libc_fini_array>:
   10226:	1101                	addi	sp,sp,-32
   10228:	e822                	sd	s0,16(sp)
   1022a:	00001797          	auipc	a5,0x1
   1022e:	2d678793          	addi	a5,a5,726 # 11500 <__fini_array_end>
   10232:	00001417          	auipc	s0,0x1
   10236:	2c640413          	addi	s0,s0,710 # 114f8 <__init_array_end>
   1023a:	8f81                	sub	a5,a5,s0
   1023c:	e426                	sd	s1,8(sp)
   1023e:	ec06                	sd	ra,24(sp)
   10240:	4037d493          	srai	s1,a5,0x3
   10244:	c881                	beqz	s1,10254 <__libc_fini_array+0x2e>
   10246:	17e1                	addi	a5,a5,-8
   10248:	943e                	add	s0,s0,a5
   1024a:	601c                	ld	a5,0(s0)
   1024c:	14fd                	addi	s1,s1,-1
   1024e:	1461                	addi	s0,s0,-8
   10250:	9782                	jalr	a5
   10252:	fce5                	bnez	s1,1024a <__libc_fini_array+0x24>
   10254:	60e2                	ld	ra,24(sp)
   10256:	6442                	ld	s0,16(sp)
   10258:	64a2                	ld	s1,8(sp)
   1025a:	6105                	addi	sp,sp,32
   1025c:	8082                	ret

000000000001025e <__libc_init_array>:
   1025e:	1101                	addi	sp,sp,-32
   10260:	e822                	sd	s0,16(sp)
   10262:	e04a                	sd	s2,0(sp)
   10264:	00001417          	auipc	s0,0x1
   10268:	28040413          	addi	s0,s0,640 # 114e4 <__preinit_array_end>
   1026c:	00001917          	auipc	s2,0x1
   10270:	27890913          	addi	s2,s2,632 # 114e4 <__preinit_array_end>
   10274:	40890933          	sub	s2,s2,s0
   10278:	ec06                	sd	ra,24(sp)
   1027a:	e426                	sd	s1,8(sp)
   1027c:	40395913          	srai	s2,s2,0x3
   10280:	00090963          	beqz	s2,10292 <__libc_init_array+0x34>
   10284:	4481                	li	s1,0
   10286:	601c                	ld	a5,0(s0)
   10288:	0485                	addi	s1,s1,1
   1028a:	0421                	addi	s0,s0,8
   1028c:	9782                	jalr	a5
   1028e:	fe991ce3          	bne	s2,s1,10286 <__libc_init_array+0x28>
   10292:	00001417          	auipc	s0,0x1
   10296:	25640413          	addi	s0,s0,598 # 114e8 <__init_array_start>
   1029a:	00001917          	auipc	s2,0x1
   1029e:	25e90913          	addi	s2,s2,606 # 114f8 <__init_array_end>
   102a2:	40890933          	sub	s2,s2,s0
   102a6:	40395913          	srai	s2,s2,0x3
   102aa:	00090963          	beqz	s2,102bc <__libc_init_array+0x5e>
   102ae:	4481                	li	s1,0
   102b0:	601c                	ld	a5,0(s0)
   102b2:	0485                	addi	s1,s1,1
   102b4:	0421                	addi	s0,s0,8
   102b6:	9782                	jalr	a5
   102b8:	fe991ce3          	bne	s2,s1,102b0 <__libc_init_array+0x52>
   102bc:	60e2                	ld	ra,24(sp)
   102be:	6442                	ld	s0,16(sp)
   102c0:	64a2                	ld	s1,8(sp)
   102c2:	6902                	ld	s2,0(sp)
   102c4:	6105                	addi	sp,sp,32
   102c6:	8082                	ret

00000000000102c8 <memset>:
   102c8:	433d                	li	t1,15
   102ca:	872a                	mv	a4,a0
   102cc:	02c37163          	bgeu	t1,a2,102ee <memset+0x26>
   102d0:	00f77793          	andi	a5,a4,15
   102d4:	e3c1                	bnez	a5,10354 <memset+0x8c>
   102d6:	e1bd                	bnez	a1,1033c <memset+0x74>
   102d8:	ff067693          	andi	a3,a2,-16
   102dc:	8a3d                	andi	a2,a2,15
   102de:	96ba                	add	a3,a3,a4
   102e0:	e30c                	sd	a1,0(a4)
   102e2:	e70c                	sd	a1,8(a4)
   102e4:	0741                	addi	a4,a4,16
   102e6:	fed76de3          	bltu	a4,a3,102e0 <memset+0x18>
   102ea:	e211                	bnez	a2,102ee <memset+0x26>
   102ec:	8082                	ret
   102ee:	40c306b3          	sub	a3,t1,a2
   102f2:	068a                	slli	a3,a3,0x2
   102f4:	00000297          	auipc	t0,0x0
   102f8:	9696                	add	a3,a3,t0
   102fa:	00a68067          	jr	10(a3)
   102fe:	00b70723          	sb	a1,14(a4)
   10302:	00b706a3          	sb	a1,13(a4)
   10306:	00b70623          	sb	a1,12(a4)
   1030a:	00b705a3          	sb	a1,11(a4)
   1030e:	00b70523          	sb	a1,10(a4)
   10312:	00b704a3          	sb	a1,9(a4)
   10316:	00b70423          	sb	a1,8(a4)
   1031a:	00b703a3          	sb	a1,7(a4)
   1031e:	00b70323          	sb	a1,6(a4)
   10322:	00b702a3          	sb	a1,5(a4)
   10326:	00b70223          	sb	a1,4(a4)
   1032a:	00b701a3          	sb	a1,3(a4)
   1032e:	00b70123          	sb	a1,2(a4)
   10332:	00b700a3          	sb	a1,1(a4)
   10336:	00b70023          	sb	a1,0(a4)
   1033a:	8082                	ret
   1033c:	0ff5f593          	andi	a1,a1,255
   10340:	00859693          	slli	a3,a1,0x8
   10344:	8dd5                	or	a1,a1,a3
   10346:	01059693          	slli	a3,a1,0x10
   1034a:	8dd5                	or	a1,a1,a3
   1034c:	02059693          	slli	a3,a1,0x20
   10350:	8dd5                	or	a1,a1,a3
   10352:	b759                	j	102d8 <memset+0x10>
   10354:	00279693          	slli	a3,a5,0x2
   10358:	00000297          	auipc	t0,0x0
   1035c:	9696                	add	a3,a3,t0
   1035e:	8286                	mv	t0,ra
   10360:	fa2680e7          	jalr	-94(a3)
   10364:	8096                	mv	ra,t0
   10366:	17c1                	addi	a5,a5,-16
   10368:	8f1d                	sub	a4,a4,a5
   1036a:	963e                	add	a2,a2,a5
   1036c:	f8c371e3          	bgeu	t1,a2,102ee <memset+0x26>
   10370:	b79d                	j	102d6 <memset+0xe>

0000000000010372 <__register_exitproc>:
   10372:	f4818793          	addi	a5,gp,-184 # 11c48 <_global_impure_ptr>
   10376:	6398                	ld	a4,0(a5)
   10378:	1f873783          	ld	a5,504(a4)
   1037c:	c3b1                	beqz	a5,103c0 <__register_exitproc+0x4e>
   1037e:	4798                	lw	a4,8(a5)
   10380:	487d                	li	a6,31
   10382:	06e84263          	blt	a6,a4,103e6 <__register_exitproc+0x74>
   10386:	c505                	beqz	a0,103ae <__register_exitproc+0x3c>
   10388:	00371813          	slli	a6,a4,0x3
   1038c:	983e                	add	a6,a6,a5
   1038e:	10c83823          	sd	a2,272(a6)
   10392:	3107a883          	lw	a7,784(a5)
   10396:	4605                	li	a2,1
   10398:	00e6163b          	sllw	a2,a2,a4
   1039c:	00c8e8b3          	or	a7,a7,a2
   103a0:	3117a823          	sw	a7,784(a5)
   103a4:	20d83823          	sd	a3,528(a6)
   103a8:	4689                	li	a3,2
   103aa:	02d50063          	beq	a0,a3,103ca <__register_exitproc+0x58>
   103ae:	00270693          	addi	a3,a4,2
   103b2:	068e                	slli	a3,a3,0x3
   103b4:	2705                	addiw	a4,a4,1
   103b6:	c798                	sw	a4,8(a5)
   103b8:	97b6                	add	a5,a5,a3
   103ba:	e38c                	sd	a1,0(a5)
   103bc:	4501                	li	a0,0
   103be:	8082                	ret
   103c0:	20070793          	addi	a5,a4,512
   103c4:	1ef73c23          	sd	a5,504(a4)
   103c8:	bf5d                	j	1037e <__register_exitproc+0xc>
   103ca:	3147a683          	lw	a3,788(a5)
   103ce:	4501                	li	a0,0
   103d0:	8e55                	or	a2,a2,a3
   103d2:	00270693          	addi	a3,a4,2
   103d6:	068e                	slli	a3,a3,0x3
   103d8:	2705                	addiw	a4,a4,1
   103da:	30c7aa23          	sw	a2,788(a5)
   103de:	c798                	sw	a4,8(a5)
   103e0:	97b6                	add	a5,a5,a3
   103e2:	e38c                	sd	a1,0(a5)
   103e4:	8082                	ret
   103e6:	557d                	li	a0,-1
   103e8:	8082                	ret

00000000000103ea <__call_exitprocs>:
   103ea:	715d                	addi	sp,sp,-80
   103ec:	f4818793          	addi	a5,gp,-184 # 11c48 <_global_impure_ptr>
   103f0:	e062                	sd	s8,0(sp)
   103f2:	0007bc03          	ld	s8,0(a5)
   103f6:	f44e                	sd	s3,40(sp)
   103f8:	f052                	sd	s4,32(sp)
   103fa:	ec56                	sd	s5,24(sp)
   103fc:	e85a                	sd	s6,16(sp)
   103fe:	e486                	sd	ra,72(sp)
   10400:	e0a2                	sd	s0,64(sp)
   10402:	fc26                	sd	s1,56(sp)
   10404:	f84a                	sd	s2,48(sp)
   10406:	e45e                	sd	s7,8(sp)
   10408:	8aaa                	mv	s5,a0
   1040a:	8b2e                	mv	s6,a1
   1040c:	4a05                	li	s4,1
   1040e:	59fd                	li	s3,-1
   10410:	1f8c3903          	ld	s2,504(s8)
   10414:	02090463          	beqz	s2,1043c <__call_exitprocs+0x52>
   10418:	00892483          	lw	s1,8(s2)
   1041c:	fff4841b          	addiw	s0,s1,-1
   10420:	00044e63          	bltz	s0,1043c <__call_exitprocs+0x52>
   10424:	048e                	slli	s1,s1,0x3
   10426:	94ca                	add	s1,s1,s2
   10428:	020b0663          	beqz	s6,10454 <__call_exitprocs+0x6a>
   1042c:	2084b783          	ld	a5,520(s1)
   10430:	03678263          	beq	a5,s6,10454 <__call_exitprocs+0x6a>
   10434:	347d                	addiw	s0,s0,-1
   10436:	14e1                	addi	s1,s1,-8
   10438:	ff3418e3          	bne	s0,s3,10428 <__call_exitprocs+0x3e>
   1043c:	60a6                	ld	ra,72(sp)
   1043e:	6406                	ld	s0,64(sp)
   10440:	74e2                	ld	s1,56(sp)
   10442:	7942                	ld	s2,48(sp)
   10444:	79a2                	ld	s3,40(sp)
   10446:	7a02                	ld	s4,32(sp)
   10448:	6ae2                	ld	s5,24(sp)
   1044a:	6b42                	ld	s6,16(sp)
   1044c:	6ba2                	ld	s7,8(sp)
   1044e:	6c02                	ld	s8,0(sp)
   10450:	6161                	addi	sp,sp,80
   10452:	8082                	ret
   10454:	00892783          	lw	a5,8(s2)
   10458:	6498                	ld	a4,8(s1)
   1045a:	37fd                	addiw	a5,a5,-1
   1045c:	04878263          	beq	a5,s0,104a0 <__call_exitprocs+0xb6>
   10460:	0004b423          	sd	zero,8(s1)
   10464:	db61                	beqz	a4,10434 <__call_exitprocs+0x4a>
   10466:	31092783          	lw	a5,784(s2)
   1046a:	008a16bb          	sllw	a3,s4,s0
   1046e:	00892b83          	lw	s7,8(s2)
   10472:	8ff5                	and	a5,a5,a3
   10474:	2781                	sext.w	a5,a5
   10476:	eb99                	bnez	a5,1048c <__call_exitprocs+0xa2>
   10478:	9702                	jalr	a4
   1047a:	00892783          	lw	a5,8(s2)
   1047e:	f97799e3          	bne	a5,s7,10410 <__call_exitprocs+0x26>
   10482:	1f8c3783          	ld	a5,504(s8)
   10486:	fb2787e3          	beq	a5,s2,10434 <__call_exitprocs+0x4a>
   1048a:	b759                	j	10410 <__call_exitprocs+0x26>
   1048c:	31492783          	lw	a5,788(s2)
   10490:	1084b583          	ld	a1,264(s1)
   10494:	8ff5                	and	a5,a5,a3
   10496:	2781                	sext.w	a5,a5
   10498:	e799                	bnez	a5,104a6 <__call_exitprocs+0xbc>
   1049a:	8556                	mv	a0,s5
   1049c:	9702                	jalr	a4
   1049e:	bff1                	j	1047a <__call_exitprocs+0x90>
   104a0:	00892423          	sw	s0,8(s2)
   104a4:	b7c1                	j	10464 <__call_exitprocs+0x7a>
   104a6:	852e                	mv	a0,a1
   104a8:	9702                	jalr	a4
   104aa:	bfc1                	j	1047a <__call_exitprocs+0x90>

00000000000104ac <_exit>:
   104ac:	4581                	li	a1,0
   104ae:	4601                	li	a2,0
   104b0:	4681                	li	a3,0
   104b2:	4701                	li	a4,0
   104b4:	4781                	li	a5,0
   104b6:	05d00893          	li	a7,93
   104ba:	00000073          	ecall
   104be:	00054363          	bltz	a0,104c4 <_exit+0x18>
   104c2:	a001                	j	104c2 <_exit+0x16>
   104c4:	1141                	addi	sp,sp,-16
   104c6:	e022                	sd	s0,0(sp)
   104c8:	842a                	mv	s0,a0
   104ca:	e406                	sd	ra,8(sp)
   104cc:	4080043b          	negw	s0,s0
   104d0:	008000ef          	jal	ra,104d8 <__errno>
   104d4:	c100                	sw	s0,0(a0)
   104d6:	a001                	j	104d6 <_exit+0x2a>

00000000000104d8 <__errno>:
   104d8:	f5818793          	addi	a5,gp,-168 # 11c58 <_impure_ptr>
   104dc:	6388                	ld	a0,0(a5)
   104de:	8082                	ret
