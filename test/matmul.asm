
./test/matmul_zwd：     文件格式 elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	a5,0xffff0
   100b4:	f5078793          	addi	a5,a5,-176 # 0 <register_fini-0x100b0>
   100b8:	c791                	beqz	a5,100c4 <register_fini+0x14>
   100ba:	00000517          	auipc	a0,0x0
   100be:	46850513          	addi	a0,a0,1128 # 10522 <__libc_fini_array>
   100c2:	a91d                	j	104f8 <atexit>
   100c4:	8082                	ret

00000000000100c6 <_start>:
   100c6:	00001197          	auipc	gp,0x1
   100ca:	75a18193          	addi	gp,gp,1882 # 11820 <__global_pointer$>
   100ce:	f6018513          	addi	a0,gp,-160 # 11780 <_edata>
   100d2:	05018613          	addi	a2,gp,80 # 11870 <__BSS_END__>
   100d6:	8e09                	sub	a2,a2,a0
   100d8:	4581                	li	a1,0
   100da:	4ea000ef          	jal	ra,105c4 <memset>
   100de:	00000517          	auipc	a0,0x0
   100e2:	44450513          	addi	a0,a0,1092 # 10522 <__libc_fini_array>
   100e6:	412000ef          	jal	ra,104f8 <atexit>
   100ea:	470000ef          	jal	ra,1055a <__libc_init_array>
   100ee:	4502                	lw	a0,0(sp)
   100f0:	002c                	addi	a1,sp,8
   100f2:	4601                	li	a2,0
   100f4:	060000ef          	jal	ra,10154 <main>
   100f8:	a129                	j	10502 <exit>

00000000000100fa <__do_global_dtors_aux>:
   100fa:	f601c783          	lbu	a5,-160(gp) # 11780 <_edata>
   100fe:	eb95                	bnez	a5,10132 <__do_global_dtors_aux+0x38>
   10100:	ffff0797          	auipc	a5,0xffff0
   10104:	f0078793          	addi	a5,a5,-256 # 0 <register_fini-0x100b0>
   10108:	c38d                	beqz	a5,1012a <__do_global_dtors_aux+0x30>
   1010a:	1141                	addi	sp,sp,-16
   1010c:	00001517          	auipc	a0,0x1
   10110:	ef450513          	addi	a0,a0,-268 # 11000 <__FRAME_END__>
   10114:	e406                	sd	ra,8(sp)
   10116:	00000097          	auipc	ra,0x0
   1011a:	000000e7          	jalr	zero # 0 <register_fini-0x100b0>
   1011e:	60a2                	ld	ra,8(sp)
   10120:	4785                	li	a5,1
   10122:	f6f18023          	sb	a5,-160(gp) # 11780 <_edata>
   10126:	0141                	addi	sp,sp,16
   10128:	8082                	ret
   1012a:	4785                	li	a5,1
   1012c:	f6f18023          	sb	a5,-160(gp) # 11780 <_edata>
   10130:	8082                	ret
   10132:	8082                	ret

0000000000010134 <frame_dummy>:
   10134:	ffff0797          	auipc	a5,0xffff0
   10138:	ecc78793          	addi	a5,a5,-308 # 0 <register_fini-0x100b0>
   1013c:	cb99                	beqz	a5,10152 <frame_dummy+0x1e>
   1013e:	f6818593          	addi	a1,gp,-152 # 11788 <object.5475>
   10142:	00001517          	auipc	a0,0x1
   10146:	ebe50513          	addi	a0,a0,-322 # 11000 <__FRAME_END__>
   1014a:	00000317          	auipc	t1,0x0
   1014e:	00000067          	jr	zero # 0 <register_fini-0x100b0>
   10152:	8082                	ret

0000000000010154 <main>:
   10154:	fc010113          	addi	sp,sp,-64
   10158:	02813c23          	sd	s0,56(sp)
   1015c:	04010413          	addi	s0,sp,64
   10160:	fe042623          	sw	zero,-20(s0)
   10164:	0540006f          	j	101b8 <main+0x64>
   10168:	fe042423          	sw	zero,-24(s0)
   1016c:	0300006f          	j	1019c <main+0x48>
   10170:	02818713          	addi	a4,gp,40 # 11848 <result>
   10174:	fe842783          	lw	a5,-24(s0)
   10178:	fec42683          	lw	a3,-20(s0)
   1017c:	00169693          	slli	a3,a3,0x1
   10180:	00f687b3          	add	a5,a3,a5
   10184:	00279793          	slli	a5,a5,0x2
   10188:	00f707b3          	add	a5,a4,a5
   1018c:	0007a023          	sw	zero,0(a5)
   10190:	fe842783          	lw	a5,-24(s0)
   10194:	0017879b          	addiw	a5,a5,1
   10198:	fef42423          	sw	a5,-24(s0)
   1019c:	fe842783          	lw	a5,-24(s0)
   101a0:	0007871b          	sext.w	a4,a5
   101a4:	00100793          	li	a5,1
   101a8:	fce7d4e3          	bge	a5,a4,10170 <main+0x1c>
   101ac:	fec42783          	lw	a5,-20(s0)
   101b0:	0017879b          	addiw	a5,a5,1
   101b4:	fef42623          	sw	a5,-20(s0)
   101b8:	fec42783          	lw	a5,-20(s0)
   101bc:	0007871b          	sext.w	a4,a5
   101c0:	00400793          	li	a5,4
   101c4:	fae7d2e3          	bge	a5,a4,10168 <main+0x14>
   101c8:	fe042223          	sw	zero,-28(s0)
   101cc:	fe042023          	sw	zero,-32(s0)
   101d0:	0680006f          	j	10238 <main+0xe4>
   101d4:	fc042e23          	sw	zero,-36(s0)
   101d8:	0440006f          	j	1021c <main+0xc8>
   101dc:	fe442703          	lw	a4,-28(s0)
   101e0:	0017079b          	addiw	a5,a4,1
   101e4:	fef42223          	sw	a5,-28(s0)
   101e8:	f9818613          	addi	a2,gp,-104 # 117b8 <A>
   101ec:	fdc42583          	lw	a1,-36(s0)
   101f0:	fe042683          	lw	a3,-32(s0)
   101f4:	00068793          	mv	a5,a3
   101f8:	00279793          	slli	a5,a5,0x2
   101fc:	00d787b3          	add	a5,a5,a3
   10200:	00b787b3          	add	a5,a5,a1
   10204:	00279793          	slli	a5,a5,0x2
   10208:	00f607b3          	add	a5,a2,a5
   1020c:	00e7a023          	sw	a4,0(a5)
   10210:	fdc42783          	lw	a5,-36(s0)
   10214:	0017879b          	addiw	a5,a5,1
   10218:	fcf42e23          	sw	a5,-36(s0)
   1021c:	fdc42783          	lw	a5,-36(s0)
   10220:	0007871b          	sext.w	a4,a5
   10224:	00400793          	li	a5,4
   10228:	fae7dae3          	bge	a5,a4,101dc <main+0x88>
   1022c:	fe042783          	lw	a5,-32(s0)
   10230:	0017879b          	addiw	a5,a5,1
   10234:	fef42023          	sw	a5,-32(s0)
   10238:	fe042783          	lw	a5,-32(s0)
   1023c:	0007871b          	sext.w	a4,a5
   10240:	00400793          	li	a5,4
   10244:	f8e7d8e3          	bge	a5,a4,101d4 <main+0x80>
   10248:	fe042223          	sw	zero,-28(s0)
   1024c:	fc042c23          	sw	zero,-40(s0)
   10250:	0600006f          	j	102b0 <main+0x15c>
   10254:	fc042a23          	sw	zero,-44(s0)
   10258:	03c0006f          	j	10294 <main+0x140>
   1025c:	fe442783          	lw	a5,-28(s0)
   10260:	0017871b          	addiw	a4,a5,1
   10264:	fee42223          	sw	a4,-28(s0)
   10268:	00018693          	mv	a3,gp
   1026c:	fd442703          	lw	a4,-44(s0)
   10270:	fd842603          	lw	a2,-40(s0)
   10274:	00161613          	slli	a2,a2,0x1
   10278:	00e60733          	add	a4,a2,a4
   1027c:	00271713          	slli	a4,a4,0x2
   10280:	00e68733          	add	a4,a3,a4
   10284:	00f72023          	sw	a5,0(a4)
   10288:	fd442783          	lw	a5,-44(s0)
   1028c:	0017879b          	addiw	a5,a5,1
   10290:	fcf42a23          	sw	a5,-44(s0)
   10294:	fd442783          	lw	a5,-44(s0)
   10298:	0007871b          	sext.w	a4,a5
   1029c:	00100793          	li	a5,1
   102a0:	fae7dee3          	bge	a5,a4,1025c <main+0x108>
   102a4:	fd842783          	lw	a5,-40(s0)
   102a8:	0017879b          	addiw	a5,a5,1
   102ac:	fcf42c23          	sw	a5,-40(s0)
   102b0:	fd842783          	lw	a5,-40(s0)
   102b4:	0007871b          	sext.w	a4,a5
   102b8:	00400793          	li	a5,4
   102bc:	f8e7dce3          	bge	a5,a4,10254 <main+0x100>
   102c0:	fc042823          	sw	zero,-48(s0)
   102c4:	0f00006f          	j	103b4 <main+0x260>
   102c8:	fc042623          	sw	zero,-52(s0)
   102cc:	0cc0006f          	j	10398 <main+0x244>
   102d0:	fc042423          	sw	zero,-56(s0)
   102d4:	0a80006f          	j	1037c <main+0x228>
   102d8:	02818713          	addi	a4,gp,40 # 11848 <result>
   102dc:	fcc42783          	lw	a5,-52(s0)
   102e0:	fd042683          	lw	a3,-48(s0)
   102e4:	00169693          	slli	a3,a3,0x1
   102e8:	00f687b3          	add	a5,a3,a5
   102ec:	00279793          	slli	a5,a5,0x2
   102f0:	00f707b3          	add	a5,a4,a5
   102f4:	0007a683          	lw	a3,0(a5)
   102f8:	f9818613          	addi	a2,gp,-104 # 117b8 <A>
   102fc:	fc842583          	lw	a1,-56(s0)
   10300:	fd042703          	lw	a4,-48(s0)
   10304:	00070793          	mv	a5,a4
   10308:	00279793          	slli	a5,a5,0x2
   1030c:	00e787b3          	add	a5,a5,a4
   10310:	00b787b3          	add	a5,a5,a1
   10314:	00279793          	slli	a5,a5,0x2
   10318:	00f607b3          	add	a5,a2,a5
   1031c:	0007a703          	lw	a4,0(a5)
   10320:	00018613          	mv	a2,gp
   10324:	fcc42783          	lw	a5,-52(s0)
   10328:	fc842583          	lw	a1,-56(s0)
   1032c:	00159593          	slli	a1,a1,0x1
   10330:	00f587b3          	add	a5,a1,a5
   10334:	00279793          	slli	a5,a5,0x2
   10338:	00f607b3          	add	a5,a2,a5
   1033c:	0007a783          	lw	a5,0(a5)
   10340:	02f707bb          	mulw	a5,a4,a5
   10344:	0007879b          	sext.w	a5,a5
   10348:	00f687bb          	addw	a5,a3,a5
   1034c:	0007871b          	sext.w	a4,a5
   10350:	02818693          	addi	a3,gp,40 # 11848 <result>
   10354:	fcc42783          	lw	a5,-52(s0)
   10358:	fd042603          	lw	a2,-48(s0)
   1035c:	00161613          	slli	a2,a2,0x1
   10360:	00f607b3          	add	a5,a2,a5
   10364:	00279793          	slli	a5,a5,0x2
   10368:	00f687b3          	add	a5,a3,a5
   1036c:	00e7a023          	sw	a4,0(a5)
   10370:	fc842783          	lw	a5,-56(s0)
   10374:	0017879b          	addiw	a5,a5,1
   10378:	fcf42423          	sw	a5,-56(s0)
   1037c:	fc842783          	lw	a5,-56(s0)
   10380:	0007871b          	sext.w	a4,a5
   10384:	00400793          	li	a5,4
   10388:	f4e7d8e3          	bge	a5,a4,102d8 <main+0x184>
   1038c:	fcc42783          	lw	a5,-52(s0)
   10390:	0017879b          	addiw	a5,a5,1
   10394:	fcf42623          	sw	a5,-52(s0)
   10398:	fcc42783          	lw	a5,-52(s0)
   1039c:	0007871b          	sext.w	a4,a5
   103a0:	00100793          	li	a5,1
   103a4:	f2e7d6e3          	bge	a5,a4,102d0 <main+0x17c>
   103a8:	fd042783          	lw	a5,-48(s0)
   103ac:	0017879b          	addiw	a5,a5,1
   103b0:	fcf42823          	sw	a5,-48(s0)
   103b4:	fd042783          	lw	a5,-48(s0)
   103b8:	0007871b          	sext.w	a4,a5
   103bc:	00400793          	li	a5,4
   103c0:	f0e7d4e3          	bge	a5,a4,102c8 <main+0x174>
   103c4:	00000793          	li	a5,0
   103c8:	00078513          	mv	a0,a5
   103cc:	03813403          	ld	s0,56(sp)
   103d0:	04010113          	addi	sp,sp,64
   103d4:	00008067          	ret

00000000000103d8 <my_exit>:
   103d8:	fe010113          	addi	sp,sp,-32
   103dc:	00813c23          	sd	s0,24(sp)
   103e0:	02010413          	addi	s0,sp,32
   103e4:	00050793          	mv	a5,a0
   103e8:	fef42623          	sw	a5,-20(s0)
   103ec:	00000893          	li	a7,0
   103f0:	00000073          	ecall
   103f4:	00000013          	nop
   103f8:	01813403          	ld	s0,24(sp)
   103fc:	02010113          	addi	sp,sp,32
   10400:	00008067          	ret

0000000000010404 <print_c>:
   10404:	fe010113          	addi	sp,sp,-32
   10408:	00813c23          	sd	s0,24(sp)
   1040c:	02010413          	addi	s0,sp,32
   10410:	00050793          	mv	a5,a0
   10414:	fef407a3          	sb	a5,-17(s0)
   10418:	00100893          	li	a7,1
   1041c:	00000073          	ecall
   10420:	00000013          	nop
   10424:	01813403          	ld	s0,24(sp)
   10428:	02010113          	addi	sp,sp,32
   1042c:	00008067          	ret

0000000000010430 <print_s>:
   10430:	fe010113          	addi	sp,sp,-32
   10434:	00813c23          	sd	s0,24(sp)
   10438:	02010413          	addi	s0,sp,32
   1043c:	fea43423          	sd	a0,-24(s0)
   10440:	00200893          	li	a7,2
   10444:	00000073          	ecall
   10448:	00000013          	nop
   1044c:	01813403          	ld	s0,24(sp)
   10450:	02010113          	addi	sp,sp,32
   10454:	00008067          	ret

0000000000010458 <print_l>:
   10458:	fe010113          	addi	sp,sp,-32
   1045c:	00813c23          	sd	s0,24(sp)
   10460:	02010413          	addi	s0,sp,32
   10464:	fea43423          	sd	a0,-24(s0)
   10468:	00300893          	li	a7,3
   1046c:	00000073          	ecall
   10470:	00000013          	nop
   10474:	01813403          	ld	s0,24(sp)
   10478:	02010113          	addi	sp,sp,32
   1047c:	00008067          	ret

0000000000010480 <scan_c>:
   10480:	fe010113          	addi	sp,sp,-32
   10484:	00813c23          	sd	s0,24(sp)
   10488:	02010413          	addi	s0,sp,32
   1048c:	fea43423          	sd	a0,-24(s0)
   10490:	00400893          	li	a7,4
   10494:	00000073          	ecall
   10498:	00000013          	nop
   1049c:	01813403          	ld	s0,24(sp)
   104a0:	02010113          	addi	sp,sp,32
   104a4:	00008067          	ret

00000000000104a8 <scan_s>:
   104a8:	fe010113          	addi	sp,sp,-32
   104ac:	00813c23          	sd	s0,24(sp)
   104b0:	02010413          	addi	s0,sp,32
   104b4:	fea43423          	sd	a0,-24(s0)
   104b8:	00500893          	li	a7,5
   104bc:	00000073          	ecall
   104c0:	00000013          	nop
   104c4:	01813403          	ld	s0,24(sp)
   104c8:	02010113          	addi	sp,sp,32
   104cc:	00008067          	ret

00000000000104d0 <scan_l>:
   104d0:	fe010113          	addi	sp,sp,-32
   104d4:	00813c23          	sd	s0,24(sp)
   104d8:	02010413          	addi	s0,sp,32
   104dc:	fea43423          	sd	a0,-24(s0)
   104e0:	00600893          	li	a7,6
   104e4:	00000073          	ecall
   104e8:	00000013          	nop
   104ec:	01813403          	ld	s0,24(sp)
   104f0:	02010113          	addi	sp,sp,32
   104f4:	00008067          	ret

00000000000104f8 <atexit>:
   104f8:	85aa                	mv	a1,a0
   104fa:	4681                	li	a3,0
   104fc:	4601                	li	a2,0
   104fe:	4501                	li	a0,0
   10500:	a2bd                	j	1066e <__register_exitproc>

0000000000010502 <exit>:
   10502:	1141                	addi	sp,sp,-16
   10504:	4581                	li	a1,0
   10506:	e022                	sd	s0,0(sp)
   10508:	e406                	sd	ra,8(sp)
   1050a:	842a                	mv	s0,a0
   1050c:	1da000ef          	jal	ra,106e6 <__call_exitprocs>
   10510:	f4818793          	addi	a5,gp,-184 # 11768 <_global_impure_ptr>
   10514:	6388                	ld	a0,0(a5)
   10516:	6d3c                	ld	a5,88(a0)
   10518:	c391                	beqz	a5,1051c <exit+0x1a>
   1051a:	9782                	jalr	a5
   1051c:	8522                	mv	a0,s0
   1051e:	28a000ef          	jal	ra,107a8 <_exit>

0000000000010522 <__libc_fini_array>:
   10522:	1101                	addi	sp,sp,-32
   10524:	e822                	sd	s0,16(sp)
   10526:	00001797          	auipc	a5,0x1
   1052a:	afa78793          	addi	a5,a5,-1286 # 11020 <__fini_array_end>
   1052e:	00001417          	auipc	s0,0x1
   10532:	aea40413          	addi	s0,s0,-1302 # 11018 <__init_array_end>
   10536:	8f81                	sub	a5,a5,s0
   10538:	e426                	sd	s1,8(sp)
   1053a:	ec06                	sd	ra,24(sp)
   1053c:	4037d493          	srai	s1,a5,0x3
   10540:	c881                	beqz	s1,10550 <__libc_fini_array+0x2e>
   10542:	17e1                	addi	a5,a5,-8
   10544:	943e                	add	s0,s0,a5
   10546:	601c                	ld	a5,0(s0)
   10548:	14fd                	addi	s1,s1,-1
   1054a:	1461                	addi	s0,s0,-8
   1054c:	9782                	jalr	a5
   1054e:	fce5                	bnez	s1,10546 <__libc_fini_array+0x24>
   10550:	60e2                	ld	ra,24(sp)
   10552:	6442                	ld	s0,16(sp)
   10554:	64a2                	ld	s1,8(sp)
   10556:	6105                	addi	sp,sp,32
   10558:	8082                	ret

000000000001055a <__libc_init_array>:
   1055a:	1101                	addi	sp,sp,-32
   1055c:	e822                	sd	s0,16(sp)
   1055e:	e04a                	sd	s2,0(sp)
   10560:	00001417          	auipc	s0,0x1
   10564:	aa440413          	addi	s0,s0,-1372 # 11004 <__preinit_array_end>
   10568:	00001917          	auipc	s2,0x1
   1056c:	a9c90913          	addi	s2,s2,-1380 # 11004 <__preinit_array_end>
   10570:	40890933          	sub	s2,s2,s0
   10574:	ec06                	sd	ra,24(sp)
   10576:	e426                	sd	s1,8(sp)
   10578:	40395913          	srai	s2,s2,0x3
   1057c:	00090963          	beqz	s2,1058e <__libc_init_array+0x34>
   10580:	4481                	li	s1,0
   10582:	601c                	ld	a5,0(s0)
   10584:	0485                	addi	s1,s1,1
   10586:	0421                	addi	s0,s0,8
   10588:	9782                	jalr	a5
   1058a:	fe991ce3          	bne	s2,s1,10582 <__libc_init_array+0x28>
   1058e:	00001417          	auipc	s0,0x1
   10592:	a7a40413          	addi	s0,s0,-1414 # 11008 <__init_array_start>
   10596:	00001917          	auipc	s2,0x1
   1059a:	a8290913          	addi	s2,s2,-1406 # 11018 <__init_array_end>
   1059e:	40890933          	sub	s2,s2,s0
   105a2:	40395913          	srai	s2,s2,0x3
   105a6:	00090963          	beqz	s2,105b8 <__libc_init_array+0x5e>
   105aa:	4481                	li	s1,0
   105ac:	601c                	ld	a5,0(s0)
   105ae:	0485                	addi	s1,s1,1
   105b0:	0421                	addi	s0,s0,8
   105b2:	9782                	jalr	a5
   105b4:	fe991ce3          	bne	s2,s1,105ac <__libc_init_array+0x52>
   105b8:	60e2                	ld	ra,24(sp)
   105ba:	6442                	ld	s0,16(sp)
   105bc:	64a2                	ld	s1,8(sp)
   105be:	6902                	ld	s2,0(sp)
   105c0:	6105                	addi	sp,sp,32
   105c2:	8082                	ret

00000000000105c4 <memset>:
   105c4:	433d                	li	t1,15
   105c6:	872a                	mv	a4,a0
   105c8:	02c37163          	bgeu	t1,a2,105ea <memset+0x26>
   105cc:	00f77793          	andi	a5,a4,15
   105d0:	e3c1                	bnez	a5,10650 <memset+0x8c>
   105d2:	e1bd                	bnez	a1,10638 <memset+0x74>
   105d4:	ff067693          	andi	a3,a2,-16
   105d8:	8a3d                	andi	a2,a2,15
   105da:	96ba                	add	a3,a3,a4
   105dc:	e30c                	sd	a1,0(a4)
   105de:	e70c                	sd	a1,8(a4)
   105e0:	0741                	addi	a4,a4,16
   105e2:	fed76de3          	bltu	a4,a3,105dc <memset+0x18>
   105e6:	e211                	bnez	a2,105ea <memset+0x26>
   105e8:	8082                	ret
   105ea:	40c306b3          	sub	a3,t1,a2
   105ee:	068a                	slli	a3,a3,0x2
   105f0:	00000297          	auipc	t0,0x0
   105f4:	9696                	add	a3,a3,t0
   105f6:	00a68067          	jr	10(a3)
   105fa:	00b70723          	sb	a1,14(a4)
   105fe:	00b706a3          	sb	a1,13(a4)
   10602:	00b70623          	sb	a1,12(a4)
   10606:	00b705a3          	sb	a1,11(a4)
   1060a:	00b70523          	sb	a1,10(a4)
   1060e:	00b704a3          	sb	a1,9(a4)
   10612:	00b70423          	sb	a1,8(a4)
   10616:	00b703a3          	sb	a1,7(a4)
   1061a:	00b70323          	sb	a1,6(a4)
   1061e:	00b702a3          	sb	a1,5(a4)
   10622:	00b70223          	sb	a1,4(a4)
   10626:	00b701a3          	sb	a1,3(a4)
   1062a:	00b70123          	sb	a1,2(a4)
   1062e:	00b700a3          	sb	a1,1(a4)
   10632:	00b70023          	sb	a1,0(a4)
   10636:	8082                	ret
   10638:	0ff5f593          	andi	a1,a1,255
   1063c:	00859693          	slli	a3,a1,0x8
   10640:	8dd5                	or	a1,a1,a3
   10642:	01059693          	slli	a3,a1,0x10
   10646:	8dd5                	or	a1,a1,a3
   10648:	02059693          	slli	a3,a1,0x20
   1064c:	8dd5                	or	a1,a1,a3
   1064e:	b759                	j	105d4 <memset+0x10>
   10650:	00279693          	slli	a3,a5,0x2
   10654:	00000297          	auipc	t0,0x0
   10658:	9696                	add	a3,a3,t0
   1065a:	8286                	mv	t0,ra
   1065c:	fa2680e7          	jalr	-94(a3)
   10660:	8096                	mv	ra,t0
   10662:	17c1                	addi	a5,a5,-16
   10664:	8f1d                	sub	a4,a4,a5
   10666:	963e                	add	a2,a2,a5
   10668:	f8c371e3          	bgeu	t1,a2,105ea <memset+0x26>
   1066c:	b79d                	j	105d2 <memset+0xe>

000000000001066e <__register_exitproc>:
   1066e:	f4818793          	addi	a5,gp,-184 # 11768 <_global_impure_ptr>
   10672:	6398                	ld	a4,0(a5)
   10674:	1f873783          	ld	a5,504(a4)
   10678:	c3b1                	beqz	a5,106bc <__register_exitproc+0x4e>
   1067a:	4798                	lw	a4,8(a5)
   1067c:	487d                	li	a6,31
   1067e:	06e84263          	blt	a6,a4,106e2 <__register_exitproc+0x74>
   10682:	c505                	beqz	a0,106aa <__register_exitproc+0x3c>
   10684:	00371813          	slli	a6,a4,0x3
   10688:	983e                	add	a6,a6,a5
   1068a:	10c83823          	sd	a2,272(a6)
   1068e:	3107a883          	lw	a7,784(a5)
   10692:	4605                	li	a2,1
   10694:	00e6163b          	sllw	a2,a2,a4
   10698:	00c8e8b3          	or	a7,a7,a2
   1069c:	3117a823          	sw	a7,784(a5)
   106a0:	20d83823          	sd	a3,528(a6)
   106a4:	4689                	li	a3,2
   106a6:	02d50063          	beq	a0,a3,106c6 <__register_exitproc+0x58>
   106aa:	00270693          	addi	a3,a4,2
   106ae:	068e                	slli	a3,a3,0x3
   106b0:	2705                	addiw	a4,a4,1
   106b2:	c798                	sw	a4,8(a5)
   106b4:	97b6                	add	a5,a5,a3
   106b6:	e38c                	sd	a1,0(a5)
   106b8:	4501                	li	a0,0
   106ba:	8082                	ret
   106bc:	20070793          	addi	a5,a4,512
   106c0:	1ef73c23          	sd	a5,504(a4)
   106c4:	bf5d                	j	1067a <__register_exitproc+0xc>
   106c6:	3147a683          	lw	a3,788(a5)
   106ca:	4501                	li	a0,0
   106cc:	8e55                	or	a2,a2,a3
   106ce:	00270693          	addi	a3,a4,2
   106d2:	068e                	slli	a3,a3,0x3
   106d4:	2705                	addiw	a4,a4,1
   106d6:	30c7aa23          	sw	a2,788(a5)
   106da:	c798                	sw	a4,8(a5)
   106dc:	97b6                	add	a5,a5,a3
   106de:	e38c                	sd	a1,0(a5)
   106e0:	8082                	ret
   106e2:	557d                	li	a0,-1
   106e4:	8082                	ret

00000000000106e6 <__call_exitprocs>:
   106e6:	715d                	addi	sp,sp,-80
   106e8:	f4818793          	addi	a5,gp,-184 # 11768 <_global_impure_ptr>
   106ec:	e062                	sd	s8,0(sp)
   106ee:	0007bc03          	ld	s8,0(a5)
   106f2:	f44e                	sd	s3,40(sp)
   106f4:	f052                	sd	s4,32(sp)
   106f6:	ec56                	sd	s5,24(sp)
   106f8:	e85a                	sd	s6,16(sp)
   106fa:	e486                	sd	ra,72(sp)
   106fc:	e0a2                	sd	s0,64(sp)
   106fe:	fc26                	sd	s1,56(sp)
   10700:	f84a                	sd	s2,48(sp)
   10702:	e45e                	sd	s7,8(sp)
   10704:	8aaa                	mv	s5,a0
   10706:	8b2e                	mv	s6,a1
   10708:	4a05                	li	s4,1
   1070a:	59fd                	li	s3,-1
   1070c:	1f8c3903          	ld	s2,504(s8)
   10710:	02090463          	beqz	s2,10738 <__call_exitprocs+0x52>
   10714:	00892483          	lw	s1,8(s2)
   10718:	fff4841b          	addiw	s0,s1,-1
   1071c:	00044e63          	bltz	s0,10738 <__call_exitprocs+0x52>
   10720:	048e                	slli	s1,s1,0x3
   10722:	94ca                	add	s1,s1,s2
   10724:	020b0663          	beqz	s6,10750 <__call_exitprocs+0x6a>
   10728:	2084b783          	ld	a5,520(s1)
   1072c:	03678263          	beq	a5,s6,10750 <__call_exitprocs+0x6a>
   10730:	347d                	addiw	s0,s0,-1
   10732:	14e1                	addi	s1,s1,-8
   10734:	ff3418e3          	bne	s0,s3,10724 <__call_exitprocs+0x3e>
   10738:	60a6                	ld	ra,72(sp)
   1073a:	6406                	ld	s0,64(sp)
   1073c:	74e2                	ld	s1,56(sp)
   1073e:	7942                	ld	s2,48(sp)
   10740:	79a2                	ld	s3,40(sp)
   10742:	7a02                	ld	s4,32(sp)
   10744:	6ae2                	ld	s5,24(sp)
   10746:	6b42                	ld	s6,16(sp)
   10748:	6ba2                	ld	s7,8(sp)
   1074a:	6c02                	ld	s8,0(sp)
   1074c:	6161                	addi	sp,sp,80
   1074e:	8082                	ret
   10750:	00892783          	lw	a5,8(s2)
   10754:	6498                	ld	a4,8(s1)
   10756:	37fd                	addiw	a5,a5,-1
   10758:	04878263          	beq	a5,s0,1079c <__call_exitprocs+0xb6>
   1075c:	0004b423          	sd	zero,8(s1)
   10760:	db61                	beqz	a4,10730 <__call_exitprocs+0x4a>
   10762:	31092783          	lw	a5,784(s2)
   10766:	008a16bb          	sllw	a3,s4,s0
   1076a:	00892b83          	lw	s7,8(s2)
   1076e:	8ff5                	and	a5,a5,a3
   10770:	2781                	sext.w	a5,a5
   10772:	eb99                	bnez	a5,10788 <__call_exitprocs+0xa2>
   10774:	9702                	jalr	a4
   10776:	00892783          	lw	a5,8(s2)
   1077a:	f97799e3          	bne	a5,s7,1070c <__call_exitprocs+0x26>
   1077e:	1f8c3783          	ld	a5,504(s8)
   10782:	fb2787e3          	beq	a5,s2,10730 <__call_exitprocs+0x4a>
   10786:	b759                	j	1070c <__call_exitprocs+0x26>
   10788:	31492783          	lw	a5,788(s2)
   1078c:	1084b583          	ld	a1,264(s1)
   10790:	8ff5                	and	a5,a5,a3
   10792:	2781                	sext.w	a5,a5
   10794:	e799                	bnez	a5,107a2 <__call_exitprocs+0xbc>
   10796:	8556                	mv	a0,s5
   10798:	9702                	jalr	a4
   1079a:	bff1                	j	10776 <__call_exitprocs+0x90>
   1079c:	00892423          	sw	s0,8(s2)
   107a0:	b7c1                	j	10760 <__call_exitprocs+0x7a>
   107a2:	852e                	mv	a0,a1
   107a4:	9702                	jalr	a4
   107a6:	bfc1                	j	10776 <__call_exitprocs+0x90>

00000000000107a8 <_exit>:
   107a8:	4581                	li	a1,0
   107aa:	4601                	li	a2,0
   107ac:	4681                	li	a3,0
   107ae:	4701                	li	a4,0
   107b0:	4781                	li	a5,0
   107b2:	05d00893          	li	a7,93
   107b6:	00000073          	ecall
   107ba:	00054363          	bltz	a0,107c0 <_exit+0x18>
   107be:	a001                	j	107be <_exit+0x16>
   107c0:	1141                	addi	sp,sp,-16
   107c2:	e022                	sd	s0,0(sp)
   107c4:	842a                	mv	s0,a0
   107c6:	e406                	sd	ra,8(sp)
   107c8:	4080043b          	negw	s0,s0
   107cc:	008000ef          	jal	ra,107d4 <__errno>
   107d0:	c100                	sw	s0,0(a0)
   107d2:	a001                	j	107d2 <_exit+0x2a>

00000000000107d4 <__errno>:
   107d4:	f5818793          	addi	a5,gp,-168 # 11778 <_impure_ptr>
   107d8:	6388                	ld	a0,0(a5)
   107da:	8082                	ret
