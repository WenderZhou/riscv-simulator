
mul-div:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <_start>:
   100b0:	00002197          	auipc	gp,0x2
   100b4:	ed018193          	addi	gp,gp,-304 # 11f80 <__global_pointer$>
   100b8:	81818513          	addi	a0,gp,-2024 # 11798 <_edata>
   100bc:	86818613          	addi	a2,gp,-1944 # 117e8 <_end>
   100c0:	8e09                	sub	a2,a2,a0
   100c2:	4581                	li	a1,0
   100c4:	2ca000ef          	jal	ra,1038e <memset>
   100c8:	00000517          	auipc	a0,0x0
   100cc:	21050513          	addi	a0,a0,528 # 102d8 <__libc_fini_array>
   100d0:	00000097          	auipc	ra,0x0
   100d4:	1d4080e7          	jalr	468(ra) # 102a4 <atexit>
   100d8:	00000097          	auipc	ra,0x0
   100dc:	24e080e7          	jalr	590(ra) # 10326 <__libc_init_array>
   100e0:	4502                	lw	a0,0(sp)
   100e2:	002c                	addi	a1,sp,8
   100e4:	4601                	li	a2,0
   100e6:	00000097          	auipc	ra,0x0
   100ea:	0c6080e7          	jalr	198(ra) # 101ac <main>
   100ee:	00000317          	auipc	t1,0x0
   100f2:	1c430067          	jr	452(t1) # 102b2 <exit>

00000000000100f6 <_fini>:
   100f6:	8082                	ret

00000000000100f8 <deregister_tm_clones>:
   100f8:	6545                	lui	a0,0x11
   100fa:	67c5                	lui	a5,0x11
   100fc:	78050713          	addi	a4,a0,1920 # 11780 <__TMC_END__>
   10100:	78078793          	addi	a5,a5,1920 # 11780 <__TMC_END__>
   10104:	00e78b63          	beq	a5,a4,1011a <deregister_tm_clones+0x22>
   10108:	00000337          	lui	t1,0x0
   1010c:	00030313          	mv	t1,t1
   10110:	00030563          	beqz	t1,1011a <deregister_tm_clones+0x22>
   10114:	78050513          	addi	a0,a0,1920
   10118:	8302                	jr	t1
   1011a:	8082                	ret

000000000001011c <register_tm_clones>:
   1011c:	67c5                	lui	a5,0x11
   1011e:	6545                	lui	a0,0x11
   10120:	78078593          	addi	a1,a5,1920 # 11780 <__TMC_END__>
   10124:	78050793          	addi	a5,a0,1920 # 11780 <__TMC_END__>
   10128:	8d9d                	sub	a1,a1,a5
   1012a:	858d                	srai	a1,a1,0x3
   1012c:	4789                	li	a5,2
   1012e:	02f5c5b3          	div	a1,a1,a5
   10132:	c991                	beqz	a1,10146 <register_tm_clones+0x2a>
   10134:	00000337          	lui	t1,0x0
   10138:	00030313          	mv	t1,t1
   1013c:	00030563          	beqz	t1,10146 <register_tm_clones+0x2a>
   10140:	78050513          	addi	a0,a0,1920
   10144:	8302                	jr	t1
   10146:	8082                	ret

0000000000010148 <__do_global_dtors_aux>:
   10148:	8201c703          	lbu	a4,-2016(gp) # 117a0 <completed.5184>
   1014c:	eb15                	bnez	a4,10180 <__do_global_dtors_aux+0x38>
   1014e:	1141                	addi	sp,sp,-16
   10150:	e022                	sd	s0,0(sp)
   10152:	e406                	sd	ra,8(sp)
   10154:	843e                	mv	s0,a5
   10156:	fa3ff0ef          	jal	ra,100f8 <deregister_tm_clones>
   1015a:	000007b7          	lui	a5,0x0
   1015e:	00078793          	mv	a5,a5
   10162:	cb81                	beqz	a5,10172 <__do_global_dtors_aux+0x2a>
   10164:	6545                	lui	a0,0x11
   10166:	96050513          	addi	a0,a0,-1696 # 10960 <__EH_FRAME_BEGIN__>
   1016a:	ffff0097          	auipc	ra,0xffff0
   1016e:	e96080e7          	jalr	-362(ra) # 0 <_start-0x100b0>
   10172:	4785                	li	a5,1
   10174:	82f18023          	sb	a5,-2016(gp) # 117a0 <completed.5184>
   10178:	60a2                	ld	ra,8(sp)
   1017a:	6402                	ld	s0,0(sp)
   1017c:	0141                	addi	sp,sp,16
   1017e:	8082                	ret
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	000007b7          	lui	a5,0x0
   10186:	00078793          	mv	a5,a5
   1018a:	cf99                	beqz	a5,101a8 <frame_dummy+0x26>
   1018c:	65c5                	lui	a1,0x11
   1018e:	6545                	lui	a0,0x11
   10190:	1141                	addi	sp,sp,-16
   10192:	7a858593          	addi	a1,a1,1960 # 117a8 <object.5189>
   10196:	96050513          	addi	a0,a0,-1696 # 10960 <__EH_FRAME_BEGIN__>
   1019a:	e406                	sd	ra,8(sp)
   1019c:	ffff0097          	auipc	ra,0xffff0
   101a0:	e64080e7          	jalr	-412(ra) # 0 <_start-0x100b0>
   101a4:	60a2                	ld	ra,8(sp)
   101a6:	0141                	addi	sp,sp,16
   101a8:	f75ff06f          	j	1011c <register_tm_clones>

00000000000101ac <main>:
   101ac:	fe010113          	addi	sp,sp,-32
   101b0:	00813c23          	sd	s0,24(sp)
   101b4:	02010413          	addi	s0,sp,32
   101b8:	fe042623          	sw	zero,-20(s0)
   101bc:	fe042623          	sw	zero,-20(s0)
   101c0:	0540006f          	j	10214 <main+0x68>
      101c4:	000117b7          	lui	a5,0x11
   101c8:	fec42703          	lw	a4,-20(s0)
   101cc:	00271713          	slli	a4,a4,0x2
   101d0:	01078793          	addi	a5,a5,16 # 11010 <__fini_array_end>
   101d4:	00f707b3          	add	a5,a4,a5
   101d8:	0007a783          	lw	a5,0(a5)
   101dc:	00078713          	mv	a4,a5
   101e0:	00070793          	mv	a5,a4
   101e4:	0027979b          	slliw	a5,a5,0x2
   101e8:	00e787bb          	addw	a5,a5,a4
   101ec:	0007871b          	sext.w	a4,a5
   101f0:	000117b7          	lui	a5,0x11
   101f4:	fec42683          	lw	a3,-20(s0)
   101f8:	00269693          	slli	a3,a3,0x2
   101fc:	01078793          	addi	a5,a5,16 # 11010 <__fini_array_end>
   10200:	00f687b3          	add	a5,a3,a5
   10204:	00e7a023          	sw	a4,0(a5)
   10208:	fec42783          	lw	a5,-20(s0)
   1020c:	0017879b          	addiw	a5,a5,1
   10210:	fef42623          	sw	a5,-20(s0)
   10214:	fec42783          	lw	a5,-20(s0)
   10218:	0007871b          	sext.w	a4,a5
   1021c:	00400793          	li	a5,4
      10220:	fae7d2e3          	ble	a4,a5,101c4 <main+0x18>
   10224:	00500793          	li	a5,5
   10228:	fef42623          	sw	a5,-20(s0)
   1022c:	0500006f          	j	1027c <main+0xd0>
   10230:	000117b7          	lui	a5,0x11
   10234:	fec42703          	lw	a4,-20(s0)
   10238:	00271713          	slli	a4,a4,0x2
   1023c:	01078793          	addi	a5,a5,16 # 11010 <__fini_array_end>
   10240:	00f707b3          	add	a5,a4,a5
   10244:	0007a783          	lw	a5,0(a5)
   10248:	01f7d71b          	srliw	a4,a5,0x1f
   1024c:	00f707bb          	addw	a5,a4,a5
   10250:	4017d79b          	sraiw	a5,a5,0x1
   10254:	0007871b          	sext.w	a4,a5
   10258:	000117b7          	lui	a5,0x11
   1025c:	fec42683          	lw	a3,-20(s0)
   10260:	00269693          	slli	a3,a3,0x2
   10264:	01078793          	addi	a5,a5,16 # 11010 <__fini_array_end>
   10268:	00f687b3          	add	a5,a3,a5
   1026c:	00e7a023          	sw	a4,0(a5)
   10270:	fec42783          	lw	a5,-20(s0)
   10274:	0017879b          	addiw	a5,a5,1
   10278:	fef42623          	sw	a5,-20(s0)
   1027c:	fec42783          	lw	a5,-20(s0)
   10280:	0007871b          	sext.w	a4,a5
   10284:	00900793          	li	a5,9
   10288:	fae7d4e3          	ble	a4,a5,10230 <main+0x84>
   1028c:	00000793          	li	a5,0
   10290:	00078513          	mv	a0,a5
   10294:	01813403          	ld	s0,24(sp)
   10298:	02010113          	addi	sp,sp,32
   1029c:	00008067          	ret
   102a0:	0000                	unimp
	...

00000000000102a4 <atexit>:
   102a4:	85aa                	mv	a1,a0
   102a6:	4681                	li	a3,0
   102a8:	4601                	li	a2,0
   102aa:	4501                	li	a0,0
   102ac:	18c0006f          	j	10438 <__register_exitproc>
	...

00000000000102b2 <exit>:
   102b2:	1141                	addi	sp,sp,-16
   102b4:	4581                	li	a1,0
   102b6:	e022                	sd	s0,0(sp)
   102b8:	e406                	sd	ra,8(sp)
   102ba:	842a                	mv	s0,a0
   102bc:	1e4000ef          	jal	ra,104a0 <__call_exitprocs>
   102c0:	67c5                	lui	a5,0x11
   102c2:	7887b503          	ld	a0,1928(a5) # 11788 <_global_impure_ptr>
   102c6:	6d3c                	ld	a5,88(a0)
   102c8:	c391                	beqz	a5,102cc <exit+0x1a>
   102ca:	9782                	jalr	a5
   102cc:	8522                	mv	a0,s0
   102ce:	00000097          	auipc	ra,0x0
   102d2:	66e080e7          	jalr	1646(ra) # 1093c <_exit>
	...

00000000000102d8 <__libc_fini_array>:
   102d8:	7179                	addi	sp,sp,-48
   102da:	67c5                	lui	a5,0x11
   102dc:	6745                	lui	a4,0x11
   102de:	f022                	sd	s0,32(sp)
   102e0:	00870713          	addi	a4,a4,8 # 11008 <__init_array_end>
   102e4:	01078413          	addi	s0,a5,16 # 11010 <__fini_array_end>
   102e8:	8c19                	sub	s0,s0,a4
   102ea:	ec26                	sd	s1,24(sp)
   102ec:	e84a                	sd	s2,16(sp)
   102ee:	e44e                	sd	s3,8(sp)
   102f0:	f406                	sd	ra,40(sp)
   102f2:	840d                	srai	s0,s0,0x3
   102f4:	4481                	li	s1,0
   102f6:	01078913          	addi	s2,a5,16
   102fa:	59e1                	li	s3,-8
   102fc:	00941c63          	bne	s0,s1,10314 <__libc_fini_array+0x3c>
   10300:	7402                	ld	s0,32(sp)
   10302:	70a2                	ld	ra,40(sp)
   10304:	64e2                	ld	s1,24(sp)
   10306:	6942                	ld	s2,16(sp)
   10308:	69a2                	ld	s3,8(sp)
   1030a:	6145                	addi	sp,sp,48
   1030c:	00000317          	auipc	t1,0x0
   10310:	dea30067          	jr	-534(t1) # 100f6 <_fini>
   10314:	033487b3          	mul	a5,s1,s3
   10318:	0485                	addi	s1,s1,1
   1031a:	97ca                	add	a5,a5,s2
   1031c:	ff87b783          	ld	a5,-8(a5)
   10320:	9782                	jalr	a5
   10322:	bfe9                	j	102fc <__libc_fini_array+0x24>
	...

0000000000010326 <__libc_init_array>:
   10326:	1101                	addi	sp,sp,-32
   10328:	e822                	sd	s0,16(sp)
   1032a:	e426                	sd	s1,8(sp)
   1032c:	6445                	lui	s0,0x11
   1032e:	64c5                	lui	s1,0x11
   10330:	00048793          	mv	a5,s1
   10334:	00040413          	mv	s0,s0
   10338:	8c1d                	sub	s0,s0,a5
   1033a:	e04a                	sd	s2,0(sp)
   1033c:	ec06                	sd	ra,24(sp)
   1033e:	840d                	srai	s0,s0,0x3
   10340:	00048493          	mv	s1,s1
   10344:	4901                	li	s2,0
   10346:	02891963          	bne	s2,s0,10378 <__libc_init_array+0x52>
   1034a:	64c5                	lui	s1,0x11
   1034c:	00000097          	auipc	ra,0x0
   10350:	daa080e7          	jalr	-598(ra) # 100f6 <_fini>
   10354:	6445                	lui	s0,0x11
   10356:	00048793          	mv	a5,s1
   1035a:	00840413          	addi	s0,s0,8 # 11008 <__init_array_end>
   1035e:	8c1d                	sub	s0,s0,a5
   10360:	840d                	srai	s0,s0,0x3
   10362:	00048493          	mv	s1,s1
   10366:	4901                	li	s2,0
   10368:	00891d63          	bne	s2,s0,10382 <__libc_init_array+0x5c>
   1036c:	60e2                	ld	ra,24(sp)
   1036e:	6442                	ld	s0,16(sp)
   10370:	64a2                	ld	s1,8(sp)
   10372:	6902                	ld	s2,0(sp)
   10374:	6105                	addi	sp,sp,32
   10376:	8082                	ret
   10378:	609c                	ld	a5,0(s1)
   1037a:	0905                	addi	s2,s2,1
   1037c:	04a1                	addi	s1,s1,8
   1037e:	9782                	jalr	a5
   10380:	b7d9                	j	10346 <__libc_init_array+0x20>
   10382:	609c                	ld	a5,0(s1)
   10384:	0905                	addi	s2,s2,1
   10386:	04a1                	addi	s1,s1,8
   10388:	9782                	jalr	a5
   1038a:	bff9                	j	10368 <__libc_init_array+0x42>
	...

000000000001038e <memset>:
   1038e:	483d                	li	a6,15
   10390:	872a                	mv	a4,a0
   10392:	02c87163          	bleu	a2,a6,103b4 <memset+0x26>
   10396:	00f77793          	andi	a5,a4,15
   1039a:	e3c1                	bnez	a5,1041a <memset+0x8c>
   1039c:	e1bd                	bnez	a1,10402 <memset+0x74>
   1039e:	ff067693          	andi	a3,a2,-16
   103a2:	8a3d                	andi	a2,a2,15
   103a4:	96ba                	add	a3,a3,a4
   103a6:	e30c                	sd	a1,0(a4)
   103a8:	e70c                	sd	a1,8(a4)
   103aa:	0741                	addi	a4,a4,16
   103ac:	fed76de3          	bltu	a4,a3,103a6 <memset+0x18>
   103b0:	e211                	bnez	a2,103b4 <memset+0x26>
   103b2:	8082                	ret
   103b4:	40c806b3          	sub	a3,a6,a2
   103b8:	068a                	slli	a3,a3,0x2
   103ba:	00000297          	auipc	t0,0x0
   103be:	9696                	add	a3,a3,t0
   103c0:	00a68067          	jr	10(a3)
   103c4:	00b70723          	sb	a1,14(a4)
   103c8:	00b706a3          	sb	a1,13(a4)
   103cc:	00b70623          	sb	a1,12(a4)
   103d0:	00b705a3          	sb	a1,11(a4)
   103d4:	00b70523          	sb	a1,10(a4)
   103d8:	00b704a3          	sb	a1,9(a4)
   103dc:	00b70423          	sb	a1,8(a4)
   103e0:	00b703a3          	sb	a1,7(a4)
   103e4:	00b70323          	sb	a1,6(a4)
   103e8:	00b702a3          	sb	a1,5(a4)
   103ec:	00b70223          	sb	a1,4(a4)
   103f0:	00b701a3          	sb	a1,3(a4)
   103f4:	00b70123          	sb	a1,2(a4)
   103f8:	00b700a3          	sb	a1,1(a4)
   103fc:	00b70023          	sb	a1,0(a4)
   10400:	8082                	ret
   10402:	0ff5f593          	andi	a1,a1,255
   10406:	00859693          	slli	a3,a1,0x8
   1040a:	8dd5                	or	a1,a1,a3
   1040c:	01059693          	slli	a3,a1,0x10
   10410:	8dd5                	or	a1,a1,a3
   10412:	02059693          	slli	a3,a1,0x20
   10416:	8dd5                	or	a1,a1,a3
   10418:	b759                	j	1039e <memset+0x10>
   1041a:	00279693          	slli	a3,a5,0x2
   1041e:	00000297          	auipc	t0,0x0
   10422:	9696                	add	a3,a3,t0
   10424:	8286                	mv	t0,ra
   10426:	fa2680e7          	jalr	-94(a3)
   1042a:	8096                	mv	ra,t0
   1042c:	17c1                	addi	a5,a5,-16
   1042e:	8f1d                	sub	a4,a4,a5
   10430:	963e                	add	a2,a2,a5
   10432:	f8c871e3          	bleu	a2,a6,103b4 <memset+0x26>
   10436:	b79d                	j	1039c <memset+0xe>

0000000000010438 <__register_exitproc>:
   10438:	67c5                	lui	a5,0x11
   1043a:	7887b703          	ld	a4,1928(a5) # 11788 <_global_impure_ptr>
   1043e:	832a                	mv	t1,a0
   10440:	1f873783          	ld	a5,504(a4)
   10444:	e789                	bnez	a5,1044e <__register_exitproc+0x16>
   10446:	20070793          	addi	a5,a4,512
   1044a:	1ef73c23          	sd	a5,504(a4)
   1044e:	4798                	lw	a4,8(a5)
   10450:	487d                	li	a6,31
   10452:	557d                	li	a0,-1
   10454:	04e84463          	blt	a6,a4,1049c <__register_exitproc+0x64>
   10458:	02030a63          	beqz	t1,1048c <__register_exitproc+0x54>
   1045c:	00371813          	slli	a6,a4,0x3
   10460:	983e                	add	a6,a6,a5
   10462:	10c83823          	sd	a2,272(a6)
   10466:	3107a883          	lw	a7,784(a5)
   1046a:	4605                	li	a2,1
   1046c:	00e6163b          	sllw	a2,a2,a4
   10470:	00c8e8b3          	or	a7,a7,a2
   10474:	3117a823          	sw	a7,784(a5)
   10478:	20d83823          	sd	a3,528(a6)
   1047c:	4689                	li	a3,2
   1047e:	00d31763          	bne	t1,a3,1048c <__register_exitproc+0x54>
   10482:	3147a683          	lw	a3,788(a5)
   10486:	8e55                	or	a2,a2,a3
   10488:	30c7aa23          	sw	a2,788(a5)
   1048c:	0017069b          	addiw	a3,a4,1
   10490:	0709                	addi	a4,a4,2
   10492:	070e                	slli	a4,a4,0x3
   10494:	c794                	sw	a3,8(a5)
   10496:	97ba                	add	a5,a5,a4
   10498:	e38c                	sd	a1,0(a5)
   1049a:	4501                	li	a0,0
   1049c:	8082                	ret
	...

00000000000104a0 <__call_exitprocs>:
   104a0:	715d                	addi	sp,sp,-80
   104a2:	67c5                	lui	a5,0x11
   104a4:	f44e                	sd	s3,40(sp)
   104a6:	7887b983          	ld	s3,1928(a5) # 11788 <_global_impure_ptr>
   104aa:	f052                	sd	s4,32(sp)
   104ac:	ec56                	sd	s5,24(sp)
   104ae:	e85a                	sd	s6,16(sp)
   104b0:	e486                	sd	ra,72(sp)
   104b2:	e0a2                	sd	s0,64(sp)
   104b4:	fc26                	sd	s1,56(sp)
   104b6:	f84a                	sd	s2,48(sp)
   104b8:	e45e                	sd	s7,8(sp)
   104ba:	8aaa                	mv	s5,a0
   104bc:	8a2e                	mv	s4,a1
   104be:	4b05                	li	s6,1
   104c0:	1f89b403          	ld	s0,504(s3)
   104c4:	c801                	beqz	s0,104d4 <__call_exitprocs+0x34>
   104c6:	4404                	lw	s1,8(s0)
   104c8:	34fd                	addiw	s1,s1,-1
   104ca:	00349913          	slli	s2,s1,0x3
   104ce:	9922                	add	s2,s2,s0
   104d0:	0004dd63          	bgez	s1,104ea <__call_exitprocs+0x4a>
   104d4:	60a6                	ld	ra,72(sp)
   104d6:	6406                	ld	s0,64(sp)
   104d8:	74e2                	ld	s1,56(sp)
   104da:	7942                	ld	s2,48(sp)
   104dc:	79a2                	ld	s3,40(sp)
   104de:	7a02                	ld	s4,32(sp)
   104e0:	6ae2                	ld	s5,24(sp)
   104e2:	6b42                	ld	s6,16(sp)
   104e4:	6ba2                	ld	s7,8(sp)
   104e6:	6161                	addi	sp,sp,80
   104e8:	8082                	ret
   104ea:	000a0963          	beqz	s4,104fc <__call_exitprocs+0x5c>
   104ee:	21093783          	ld	a5,528(s2)
   104f2:	01478563          	beq	a5,s4,104fc <__call_exitprocs+0x5c>
   104f6:	34fd                	addiw	s1,s1,-1
   104f8:	1961                	addi	s2,s2,-8
   104fa:	bfd9                	j	104d0 <__call_exitprocs+0x30>
   104fc:	441c                	lw	a5,8(s0)
   104fe:	01093683          	ld	a3,16(s2)
   10502:	37fd                	addiw	a5,a5,-1
   10504:	02979663          	bne	a5,s1,10530 <__call_exitprocs+0x90>
   10508:	c404                	sw	s1,8(s0)
   1050a:	d6f5                	beqz	a3,104f6 <__call_exitprocs+0x56>
   1050c:	31042703          	lw	a4,784(s0)
   10510:	009b163b          	sllw	a2,s6,s1
   10514:	00842b83          	lw	s7,8(s0)
   10518:	8f71                	and	a4,a4,a2
   1051a:	2701                	sext.w	a4,a4
   1051c:	ef09                	bnez	a4,10536 <__call_exitprocs+0x96>
   1051e:	9682                	jalr	a3
   10520:	4418                	lw	a4,8(s0)
   10522:	1f89b783          	ld	a5,504(s3)
   10526:	f9771de3          	bne	a4,s7,104c0 <__call_exitprocs+0x20>
   1052a:	fcf406e3          	beq	s0,a5,104f6 <__call_exitprocs+0x56>
   1052e:	bf49                	j	104c0 <__call_exitprocs+0x20>
   10530:	00093823          	sd	zero,16(s2)
   10534:	bfd9                	j	1050a <__call_exitprocs+0x6a>
   10536:	31442783          	lw	a5,788(s0)
   1053a:	11093583          	ld	a1,272(s2)
   1053e:	8ff1                	and	a5,a5,a2
   10540:	2781                	sext.w	a5,a5
   10542:	e781                	bnez	a5,1054a <__call_exitprocs+0xaa>
   10544:	8556                	mv	a0,s5
   10546:	9682                	jalr	a3
   10548:	bfe1                	j	10520 <__call_exitprocs+0x80>
   1054a:	852e                	mv	a0,a1
   1054c:	9682                	jalr	a3
   1054e:	bfc9                	j	10520 <__call_exitprocs+0x80>
	...

0000000000010552 <conv_stat>:
   10552:	619c                	ld	a5,0(a1)
   10554:	00f51023          	sh	a5,0(a0)
   10558:	659c                	ld	a5,8(a1)
   1055a:	00f51123          	sh	a5,2(a0)
   1055e:	499c                	lw	a5,16(a1)
   10560:	c15c                	sw	a5,4(a0)
   10562:	49dc                	lw	a5,20(a1)
   10564:	00f51423          	sh	a5,8(a0)
   10568:	4d9c                	lw	a5,24(a1)
   1056a:	00f51523          	sh	a5,10(a0)
   1056e:	4ddc                	lw	a5,28(a1)
   10570:	00f51623          	sh	a5,12(a0)
   10574:	719c                	ld	a5,32(a1)
   10576:	00f51723          	sh	a5,14(a0)
   1057a:	799c                	ld	a5,48(a1)
   1057c:	e91c                	sd	a5,16(a0)
   1057e:	61bc                	ld	a5,64(a1)
   10580:	e93c                	sd	a5,80(a0)
   10582:	5d9c                	lw	a5,56(a1)
   10584:	e53c                	sd	a5,72(a0)
   10586:	65bc                	ld	a5,72(a1)
   10588:	ed1c                	sd	a5,24(a0)
   1058a:	6dbc                	ld	a5,88(a1)
   1058c:	f51c                	sd	a5,40(a0)
   1058e:	75bc                	ld	a5,104(a1)
   10590:	fd1c                	sd	a5,56(a0)
   10592:	8082                	ret

0000000000010594 <__syscall_error>:
   10594:	1141                	addi	sp,sp,-16
   10596:	e022                	sd	s0,0(sp)
   10598:	e406                	sd	ra,8(sp)
   1059a:	842a                	mv	s0,a0
   1059c:	00000097          	auipc	ra,0x0
   105a0:	3ba080e7          	jalr	954(ra) # 10956 <__errno>
   105a4:	408007bb          	negw	a5,s0
   105a8:	60a2                	ld	ra,8(sp)
   105aa:	6402                	ld	s0,0(sp)
   105ac:	c11c                	sw	a5,0(a0)
   105ae:	557d                	li	a0,-1
   105b0:	0141                	addi	sp,sp,16
   105b2:	8082                	ret

00000000000105b4 <__internal_syscall>:
   105b4:	88aa                	mv	a7,a0
   105b6:	852e                	mv	a0,a1
   105b8:	85b2                	mv	a1,a2
   105ba:	8636                	mv	a2,a3
   105bc:	86ba                	mv	a3,a4
   105be:	00000073          	ecall
   105c2:	00055663          	bgez	a0,105ce <__internal_syscall+0x1a>
   105c6:	00000317          	auipc	t1,0x0
   105ca:	fce30067          	jr	-50(t1) # 10594 <__syscall_error>
   105ce:	8082                	ret

00000000000105d0 <open>:
   105d0:	1141                	addi	sp,sp,-16
   105d2:	86b2                	mv	a3,a2
   105d4:	4701                	li	a4,0
   105d6:	862e                	mv	a2,a1
   105d8:	85aa                	mv	a1,a0
   105da:	40000513          	li	a0,1024
   105de:	e406                	sd	ra,8(sp)
   105e0:	00000097          	auipc	ra,0x0
   105e4:	fd4080e7          	jalr	-44(ra) # 105b4 <__internal_syscall>
   105e8:	60a2                	ld	ra,8(sp)
   105ea:	2501                	sext.w	a0,a0
   105ec:	0141                	addi	sp,sp,16
   105ee:	8082                	ret

00000000000105f0 <openat>:
   105f0:	1141                	addi	sp,sp,-16
   105f2:	8736                	mv	a4,a3
   105f4:	86b2                	mv	a3,a2
   105f6:	862e                	mv	a2,a1
   105f8:	85aa                	mv	a1,a0
   105fa:	03800513          	li	a0,56
   105fe:	e406                	sd	ra,8(sp)
   10600:	fb5ff0ef          	jal	ra,105b4 <__internal_syscall>
   10604:	60a2                	ld	ra,8(sp)
   10606:	2501                	sext.w	a0,a0
   10608:	0141                	addi	sp,sp,16
   1060a:	8082                	ret

000000000001060c <lseek>:
   1060c:	86b2                	mv	a3,a2
   1060e:	4701                	li	a4,0
   10610:	862e                	mv	a2,a1
   10612:	85aa                	mv	a1,a0
   10614:	03e00513          	li	a0,62
   10618:	00000317          	auipc	t1,0x0
   1061c:	f9c30067          	jr	-100(t1) # 105b4 <__internal_syscall>

0000000000010620 <read>:
   10620:	86b2                	mv	a3,a2
   10622:	4701                	li	a4,0
   10624:	862e                	mv	a2,a1
   10626:	85aa                	mv	a1,a0
   10628:	03f00513          	li	a0,63
   1062c:	f89ff06f          	j	105b4 <__internal_syscall>

0000000000010630 <write>:
   10630:	86b2                	mv	a3,a2
   10632:	4701                	li	a4,0
   10634:	862e                	mv	a2,a1
   10636:	85aa                	mv	a1,a0
   10638:	04000513          	li	a0,64
   1063c:	00000317          	auipc	t1,0x0
   10640:	f7830067          	jr	-136(t1) # 105b4 <__internal_syscall>

0000000000010644 <fstat>:
   10644:	7135                	addi	sp,sp,-160
   10646:	e526                	sd	s1,136(sp)
   10648:	860a                	mv	a2,sp
   1064a:	84ae                	mv	s1,a1
   1064c:	4701                	li	a4,0
   1064e:	85aa                	mv	a1,a0
   10650:	4681                	li	a3,0
   10652:	05000513          	li	a0,80
   10656:	ed06                	sd	ra,152(sp)
   10658:	e922                	sd	s0,144(sp)
   1065a:	f5bff0ef          	jal	ra,105b4 <__internal_syscall>
   1065e:	842a                	mv	s0,a0
   10660:	858a                	mv	a1,sp
   10662:	8526                	mv	a0,s1
   10664:	eefff0ef          	jal	ra,10552 <conv_stat>
   10668:	0004051b          	sext.w	a0,s0
   1066c:	60ea                	ld	ra,152(sp)
   1066e:	644a                	ld	s0,144(sp)
   10670:	64aa                	ld	s1,136(sp)
   10672:	610d                	addi	sp,sp,160
   10674:	8082                	ret

0000000000010676 <stat>:
   10676:	7135                	addi	sp,sp,-160
   10678:	e526                	sd	s1,136(sp)
   1067a:	860a                	mv	a2,sp
   1067c:	84ae                	mv	s1,a1
   1067e:	4701                	li	a4,0
   10680:	85aa                	mv	a1,a0
   10682:	4681                	li	a3,0
   10684:	40e00513          	li	a0,1038
   10688:	ed06                	sd	ra,152(sp)
   1068a:	e922                	sd	s0,144(sp)
   1068c:	00000097          	auipc	ra,0x0
   10690:	f28080e7          	jalr	-216(ra) # 105b4 <__internal_syscall>
   10694:	842a                	mv	s0,a0
   10696:	858a                	mv	a1,sp
   10698:	8526                	mv	a0,s1
   1069a:	00000097          	auipc	ra,0x0
   1069e:	eb8080e7          	jalr	-328(ra) # 10552 <conv_stat>
   106a2:	0004051b          	sext.w	a0,s0
   106a6:	60ea                	ld	ra,152(sp)
   106a8:	644a                	ld	s0,144(sp)
   106aa:	64aa                	ld	s1,136(sp)
   106ac:	610d                	addi	sp,sp,160
   106ae:	8082                	ret

00000000000106b0 <lstat>:
   106b0:	7135                	addi	sp,sp,-160
   106b2:	e526                	sd	s1,136(sp)
   106b4:	860a                	mv	a2,sp
   106b6:	84ae                	mv	s1,a1
   106b8:	4701                	li	a4,0
   106ba:	85aa                	mv	a1,a0
   106bc:	4681                	li	a3,0
   106be:	40f00513          	li	a0,1039
   106c2:	ed06                	sd	ra,152(sp)
   106c4:	e922                	sd	s0,144(sp)
   106c6:	eefff0ef          	jal	ra,105b4 <__internal_syscall>
   106ca:	842a                	mv	s0,a0
   106cc:	858a                	mv	a1,sp
   106ce:	8526                	mv	a0,s1
   106d0:	e83ff0ef          	jal	ra,10552 <conv_stat>
   106d4:	0004051b          	sext.w	a0,s0
   106d8:	60ea                	ld	ra,152(sp)
   106da:	644a                	ld	s0,144(sp)
   106dc:	64aa                	ld	s1,136(sp)
   106de:	610d                	addi	sp,sp,160
   106e0:	8082                	ret

00000000000106e2 <fstatat>:
   106e2:	7135                	addi	sp,sp,-160
   106e4:	e526                	sd	s1,136(sp)
   106e6:	8736                	mv	a4,a3
   106e8:	84b2                	mv	s1,a2
   106ea:	868a                	mv	a3,sp
   106ec:	862e                	mv	a2,a1
   106ee:	85aa                	mv	a1,a0
   106f0:	04f00513          	li	a0,79
   106f4:	ed06                	sd	ra,152(sp)
   106f6:	e922                	sd	s0,144(sp)
   106f8:	00000097          	auipc	ra,0x0
   106fc:	ebc080e7          	jalr	-324(ra) # 105b4 <__internal_syscall>
   10700:	842a                	mv	s0,a0
   10702:	858a                	mv	a1,sp
   10704:	8526                	mv	a0,s1
   10706:	00000097          	auipc	ra,0x0
   1070a:	e4c080e7          	jalr	-436(ra) # 10552 <conv_stat>
   1070e:	0004051b          	sext.w	a0,s0
   10712:	60ea                	ld	ra,152(sp)
   10714:	644a                	ld	s0,144(sp)
   10716:	64aa                	ld	s1,136(sp)
   10718:	610d                	addi	sp,sp,160
   1071a:	8082                	ret

000000000001071c <access>:
   1071c:	1141                	addi	sp,sp,-16
   1071e:	862e                	mv	a2,a1
   10720:	4701                	li	a4,0
   10722:	85aa                	mv	a1,a0
   10724:	4681                	li	a3,0
   10726:	40900513          	li	a0,1033
   1072a:	e406                	sd	ra,8(sp)
   1072c:	e89ff0ef          	jal	ra,105b4 <__internal_syscall>
   10730:	60a2                	ld	ra,8(sp)
   10732:	2501                	sext.w	a0,a0
   10734:	0141                	addi	sp,sp,16
   10736:	8082                	ret

0000000000010738 <faccessat>:
   10738:	1141                	addi	sp,sp,-16
   1073a:	8736                	mv	a4,a3
   1073c:	86b2                	mv	a3,a2
   1073e:	862e                	mv	a2,a1
   10740:	85aa                	mv	a1,a0
   10742:	03000513          	li	a0,48
   10746:	e406                	sd	ra,8(sp)
   10748:	00000097          	auipc	ra,0x0
   1074c:	e6c080e7          	jalr	-404(ra) # 105b4 <__internal_syscall>
   10750:	60a2                	ld	ra,8(sp)
   10752:	2501                	sext.w	a0,a0
   10754:	0141                	addi	sp,sp,16
   10756:	8082                	ret

0000000000010758 <close>:
   10758:	1141                	addi	sp,sp,-16
   1075a:	85aa                	mv	a1,a0
   1075c:	4701                	li	a4,0
   1075e:	4681                	li	a3,0
   10760:	4601                	li	a2,0
   10762:	03900513          	li	a0,57
   10766:	e406                	sd	ra,8(sp)
   10768:	e4dff0ef          	jal	ra,105b4 <__internal_syscall>
   1076c:	60a2                	ld	ra,8(sp)
   1076e:	2501                	sext.w	a0,a0
   10770:	0141                	addi	sp,sp,16
   10772:	8082                	ret

0000000000010774 <link>:
   10774:	1141                	addi	sp,sp,-16
   10776:	862e                	mv	a2,a1
   10778:	4701                	li	a4,0
   1077a:	85aa                	mv	a1,a0
   1077c:	4681                	li	a3,0
   1077e:	40100513          	li	a0,1025
   10782:	e406                	sd	ra,8(sp)
   10784:	00000097          	auipc	ra,0x0
   10788:	e30080e7          	jalr	-464(ra) # 105b4 <__internal_syscall>
   1078c:	60a2                	ld	ra,8(sp)
   1078e:	2501                	sext.w	a0,a0
   10790:	0141                	addi	sp,sp,16
   10792:	8082                	ret

0000000000010794 <unlink>:
   10794:	1141                	addi	sp,sp,-16
   10796:	85aa                	mv	a1,a0
   10798:	4701                	li	a4,0
   1079a:	4681                	li	a3,0
   1079c:	4601                	li	a2,0
   1079e:	40200513          	li	a0,1026
   107a2:	e406                	sd	ra,8(sp)
   107a4:	e11ff0ef          	jal	ra,105b4 <__internal_syscall>
   107a8:	60a2                	ld	ra,8(sp)
   107aa:	2501                	sext.w	a0,a0
   107ac:	0141                	addi	sp,sp,16
   107ae:	8082                	ret

00000000000107b0 <execve>:
   107b0:	1141                	addi	sp,sp,-16
   107b2:	e406                	sd	ra,8(sp)
   107b4:	00000097          	auipc	ra,0x0
   107b8:	1a2080e7          	jalr	418(ra) # 10956 <__errno>
   107bc:	60a2                	ld	ra,8(sp)
   107be:	47b1                	li	a5,12
   107c0:	c11c                	sw	a5,0(a0)
   107c2:	557d                	li	a0,-1
   107c4:	0141                	addi	sp,sp,16
   107c6:	8082                	ret

00000000000107c8 <fork>:
   107c8:	1141                	addi	sp,sp,-16
   107ca:	e406                	sd	ra,8(sp)
   107cc:	18a000ef          	jal	ra,10956 <__errno>
   107d0:	60a2                	ld	ra,8(sp)
   107d2:	47ad                	li	a5,11
   107d4:	c11c                	sw	a5,0(a0)
   107d6:	557d                	li	a0,-1
   107d8:	0141                	addi	sp,sp,16
   107da:	8082                	ret

00000000000107dc <getpid>:
   107dc:	4505                	li	a0,1
   107de:	8082                	ret

00000000000107e0 <kill>:
   107e0:	1141                	addi	sp,sp,-16
   107e2:	e406                	sd	ra,8(sp)
   107e4:	172000ef          	jal	ra,10956 <__errno>
   107e8:	60a2                	ld	ra,8(sp)
   107ea:	47d9                	li	a5,22
   107ec:	c11c                	sw	a5,0(a0)
   107ee:	557d                	li	a0,-1
   107f0:	0141                	addi	sp,sp,16
   107f2:	8082                	ret

00000000000107f4 <wait>:
   107f4:	1141                	addi	sp,sp,-16
   107f6:	e406                	sd	ra,8(sp)
   107f8:	00000097          	auipc	ra,0x0
   107fc:	15e080e7          	jalr	350(ra) # 10956 <__errno>
   10800:	60a2                	ld	ra,8(sp)
   10802:	47a9                	li	a5,10
   10804:	c11c                	sw	a5,0(a0)
   10806:	557d                	li	a0,-1
   10808:	0141                	addi	sp,sp,16
   1080a:	8082                	ret

000000000001080c <isatty>:
   1080c:	7119                	addi	sp,sp,-128
   1080e:	002c                	addi	a1,sp,8
   10810:	fc86                	sd	ra,120(sp)
   10812:	e33ff0ef          	jal	ra,10644 <fstat>
   10816:	57fd                	li	a5,-1
   10818:	00f50663          	beq	a0,a5,10824 <isatty+0x18>
   1081c:	4532                	lw	a0,12(sp)
   1081e:	40d5551b          	sraiw	a0,a0,0xd
   10822:	8905                	andi	a0,a0,1
   10824:	70e6                	ld	ra,120(sp)
   10826:	6109                	addi	sp,sp,128
   10828:	8082                	ret

000000000001082a <gettimeofday>:
   1082a:	1141                	addi	sp,sp,-16
   1082c:	85aa                	mv	a1,a0
   1082e:	4701                	li	a4,0
   10830:	4681                	li	a3,0
   10832:	4601                	li	a2,0
   10834:	0a900513          	li	a0,169
   10838:	e406                	sd	ra,8(sp)
   1083a:	00000097          	auipc	ra,0x0
   1083e:	d7a080e7          	jalr	-646(ra) # 105b4 <__internal_syscall>
   10842:	60a2                	ld	ra,8(sp)
   10844:	2501                	sext.w	a0,a0
   10846:	0141                	addi	sp,sp,16
   10848:	8082                	ret

000000000001084a <times>:
   1084a:	7179                	addi	sp,sp,-48
   1084c:	f022                	sd	s0,32(sp)
   1084e:	842a                	mv	s0,a0
   10850:	8581b783          	ld	a5,-1960(gp) # 117d8 <t0.2574>
   10854:	ec26                	sd	s1,24(sp)
   10856:	f406                	sd	ra,40(sp)
   10858:	85818493          	addi	s1,gp,-1960 # 117d8 <t0.2574>
   1085c:	eb81                	bnez	a5,1086c <times+0x22>
   1085e:	4581                	li	a1,0
   10860:	85818513          	addi	a0,gp,-1960 # 117d8 <t0.2574>
   10864:	00000097          	auipc	ra,0x0
   10868:	fc6080e7          	jalr	-58(ra) # 1082a <gettimeofday>
   1086c:	850a                	mv	a0,sp
   1086e:	4581                	li	a1,0
   10870:	00000097          	auipc	ra,0x0
   10874:	fba080e7          	jalr	-70(ra) # 1082a <gettimeofday>
   10878:	6098                	ld	a4,0(s1)
   1087a:	6782                	ld	a5,0(sp)
   1087c:	6494                	ld	a3,8(s1)
   1087e:	00043823          	sd	zero,16(s0)
   10882:	8f99                	sub	a5,a5,a4
   10884:	000f4737          	lui	a4,0xf4
   10888:	24070713          	addi	a4,a4,576 # f4240 <__global_pointer$+0xe22c0>
   1088c:	02e787b3          	mul	a5,a5,a4
   10890:	6722                	ld	a4,8(sp)
   10892:	00043c23          	sd	zero,24(s0)
   10896:	00043423          	sd	zero,8(s0)
   1089a:	8f15                	sub	a4,a4,a3
   1089c:	70a2                	ld	ra,40(sp)
   1089e:	64e2                	ld	s1,24(sp)
   108a0:	557d                	li	a0,-1
   108a2:	97ba                	add	a5,a5,a4
   108a4:	e01c                	sd	a5,0(s0)
   108a6:	7402                	ld	s0,32(sp)
   108a8:	6145                	addi	sp,sp,48
   108aa:	8082                	ret

00000000000108ac <ftime>:
   108ac:	00051423          	sh	zero,8(a0)
   108b0:	00053023          	sd	zero,0(a0)
   108b4:	4501                	li	a0,0
   108b6:	8082                	ret

00000000000108b8 <utime>:
   108b8:	557d                	li	a0,-1
   108ba:	8082                	ret

00000000000108bc <chown>:
   108bc:	557d                	li	a0,-1
   108be:	8082                	ret

00000000000108c0 <chmod>:
   108c0:	557d                	li	a0,-1
   108c2:	8082                	ret

00000000000108c4 <chdir>:
   108c4:	557d                	li	a0,-1
   108c6:	8082                	ret

00000000000108c8 <getcwd>:
   108c8:	4501                	li	a0,0
   108ca:	8082                	ret

00000000000108cc <sysconf>:
   108cc:	4789                	li	a5,2
   108ce:	00f50463          	beq	a0,a5,108d6 <sysconf+0xa>
   108d2:	557d                	li	a0,-1
   108d4:	8082                	ret
   108d6:	000f4537          	lui	a0,0xf4
   108da:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xe22c0>
   108de:	8082                	ret

00000000000108e0 <sbrk>:
   108e0:	1101                	addi	sp,sp,-32
   108e2:	e822                	sd	s0,16(sp)
   108e4:	8181b783          	ld	a5,-2024(gp) # 11798 <_edata>
   108e8:	e426                	sd	s1,8(sp)
   108ea:	ec06                	sd	ra,24(sp)
   108ec:	84aa                	mv	s1,a0
   108ee:	e785                	bnez	a5,10916 <sbrk+0x36>
   108f0:	4701                	li	a4,0
   108f2:	4681                	li	a3,0
   108f4:	4601                	li	a2,0
   108f6:	4581                	li	a1,0
   108f8:	0d600513          	li	a0,214
   108fc:	cb9ff0ef          	jal	ra,105b4 <__internal_syscall>
   10900:	57fd                	li	a5,-1
   10902:	00f51863          	bne	a0,a5,10912 <sbrk+0x32>
   10906:	557d                	li	a0,-1
   10908:	60e2                	ld	ra,24(sp)
   1090a:	6442                	ld	s0,16(sp)
   1090c:	64a2                	ld	s1,8(sp)
   1090e:	6105                	addi	sp,sp,32
   10910:	8082                	ret
   10912:	80a1bc23          	sd	a0,-2024(gp) # 11798 <_edata>
   10916:	8181b583          	ld	a1,-2024(gp) # 11798 <_edata>
   1091a:	4701                	li	a4,0
   1091c:	4681                	li	a3,0
   1091e:	95a6                	add	a1,a1,s1
   10920:	4601                	li	a2,0
   10922:	0d600513          	li	a0,214
   10926:	c8fff0ef          	jal	ra,105b4 <__internal_syscall>
   1092a:	8181b783          	ld	a5,-2024(gp) # 11798 <_edata>
   1092e:	94be                	add	s1,s1,a5
   10930:	fc951be3          	bne	a0,s1,10906 <sbrk+0x26>
   10934:	80a1bc23          	sd	a0,-2024(gp) # 11798 <_edata>
   10938:	853e                	mv	a0,a5
   1093a:	b7f9                	j	10908 <sbrk+0x28>

000000000001093c <_exit>:
   1093c:	1141                	addi	sp,sp,-16
   1093e:	85aa                	mv	a1,a0
   10940:	4701                	li	a4,0
   10942:	4681                	li	a3,0
   10944:	4601                	li	a2,0
   10946:	05d00513          	li	a0,93
   1094a:	e406                	sd	ra,8(sp)
   1094c:	00000097          	auipc	ra,0x0
   10950:	c68080e7          	jalr	-920(ra) # 105b4 <__internal_syscall>
   10954:	a001                	j	10954 <_exit+0x18>

0000000000010956 <__errno>:
   10956:	8101b503          	ld	a0,-2032(gp) # 11790 <_impure_ptr>
   1095a:	8082                	ret
	...
