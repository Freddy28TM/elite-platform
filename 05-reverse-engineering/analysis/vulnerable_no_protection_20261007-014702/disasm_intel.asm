
./samples/vulnerable_no_protection:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	48 83 ec 08          	sub    rsp,0x8
  401004:	48 8b 05 d5 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd5]        # 403fe0 <__gmon_start__@Base>
  40100b:	48 85 c0             	test   rax,rax
  40100e:	74 02                	je     401012 <_init+0x12>
  401010:	ff d0                	call   rax
  401012:	48 83 c4 08          	add    rsp,0x8
  401016:	c3                   	ret

Disassembly of section .plt:

0000000000401020 <putchar@plt-0x10>:
  401020:	ff 35 ca 2f 00 00    	push   QWORD PTR [rip+0x2fca]        # 403ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 cc 2f 00 00    	jmp    QWORD PTR [rip+0x2fcc]        # 403ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <putchar@plt>:
  401030:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 404000 <putchar@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401040 <strcpy@plt>:
  401040:	ff 25 c2 2f 00 00    	jmp    QWORD PTR [rip+0x2fc2]        # 404008 <strcpy@GLIBC_2.2.5>
  401046:	68 01 00 00 00       	push   0x1
  40104b:	e9 d0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401050 <puts@plt>:
  401050:	ff 25 ba 2f 00 00    	jmp    QWORD PTR [rip+0x2fba]        # 404010 <puts@GLIBC_2.2.5>
  401056:	68 02 00 00 00       	push   0x2
  40105b:	e9 c0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401060 <printf@plt>:
  401060:	ff 25 b2 2f 00 00    	jmp    QWORD PTR [rip+0x2fb2]        # 404018 <printf@GLIBC_2.2.5>
  401066:	68 03 00 00 00       	push   0x3
  40106b:	e9 b0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401070 <_start>:
  401070:	31 ed                	xor    ebp,ebp
  401072:	49 89 d1             	mov    r9,rdx
  401075:	5e                   	pop    rsi
  401076:	48 89 e2             	mov    rdx,rsp
  401079:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  40107d:	50                   	push   rax
  40107e:	54                   	push   rsp
  40107f:	45 31 c0             	xor    r8d,r8d
  401082:	31 c9                	xor    ecx,ecx
  401084:	48 c7 c7 bd 11 40 00 	mov    rdi,0x4011bd
  40108b:	ff 15 47 2f 00 00    	call   QWORD PTR [rip+0x2f47]        # 403fd8 <__libc_start_main@GLIBC_2.34>
  401091:	f4                   	hlt
  401092:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  401099:	00 00 00 
  40109c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010a0 <_dl_relocate_static_pie>:
  4010a0:	c3                   	ret
  4010a1:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  4010a8:	00 00 00 
  4010ab:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

00000000004010b0 <deregister_tm_clones>:
  4010b0:	b8 30 40 40 00       	mov    eax,0x404030
  4010b5:	48 3d 30 40 40 00    	cmp    rax,0x404030
  4010bb:	74 13                	je     4010d0 <deregister_tm_clones+0x20>
  4010bd:	b8 00 00 00 00       	mov    eax,0x0
  4010c2:	48 85 c0             	test   rax,rax
  4010c5:	74 09                	je     4010d0 <deregister_tm_clones+0x20>
  4010c7:	bf 30 40 40 00       	mov    edi,0x404030
  4010cc:	ff e0                	jmp    rax
  4010ce:	66 90                	xchg   ax,ax
  4010d0:	c3                   	ret
  4010d1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010d8:	00 00 00 00 
  4010dc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010e0 <register_tm_clones>:
  4010e0:	be 30 40 40 00       	mov    esi,0x404030
  4010e5:	48 81 ee 30 40 40 00 	sub    rsi,0x404030
  4010ec:	48 89 f0             	mov    rax,rsi
  4010ef:	48 c1 ee 3f          	shr    rsi,0x3f
  4010f3:	48 c1 f8 03          	sar    rax,0x3
  4010f7:	48 01 c6             	add    rsi,rax
  4010fa:	48 d1 fe             	sar    rsi,1
  4010fd:	74 11                	je     401110 <register_tm_clones+0x30>
  4010ff:	b8 00 00 00 00       	mov    eax,0x0
  401104:	48 85 c0             	test   rax,rax
  401107:	74 07                	je     401110 <register_tm_clones+0x30>
  401109:	bf 30 40 40 00       	mov    edi,0x404030
  40110e:	ff e0                	jmp    rax
  401110:	c3                   	ret
  401111:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401118:	00 00 00 00 
  40111c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401120 <__do_global_dtors_aux>:
  401120:	f3 0f 1e fa          	endbr64
  401124:	80 3d 05 2f 00 00 00 	cmp    BYTE PTR [rip+0x2f05],0x0        # 404030 <__TMC_END__>
  40112b:	75 13                	jne    401140 <__do_global_dtors_aux+0x20>
  40112d:	55                   	push   rbp
  40112e:	48 89 e5             	mov    rbp,rsp
  401131:	e8 7a ff ff ff       	call   4010b0 <deregister_tm_clones>
  401136:	c6 05 f3 2e 00 00 01 	mov    BYTE PTR [rip+0x2ef3],0x1        # 404030 <__TMC_END__>
  40113d:	5d                   	pop    rbp
  40113e:	c3                   	ret
  40113f:	90                   	nop
  401140:	c3                   	ret
  401141:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401148:	00 00 00 00 
  40114c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401150 <frame_dummy>:
  401150:	f3 0f 1e fa          	endbr64
  401154:	eb 8a                	jmp    4010e0 <register_tm_clones>

0000000000401156 <vulnerable_function>:
  401156:	55                   	push   rbp
  401157:	48 89 e5             	mov    rbp,rsp
  40115a:	48 83 ec 50          	sub    rsp,0x50
  40115e:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
  401162:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
  401166:	48 8d 45 c0          	lea    rax,[rbp-0x40]
  40116a:	48 89 d6             	mov    rsi,rdx
  40116d:	48 89 c7             	mov    rdi,rax
  401170:	e8 cb fe ff ff       	call   401040 <strcpy@plt>
  401175:	48 8d 45 c0          	lea    rax,[rbp-0x40]
  401179:	48 89 c6             	mov    rsi,rax
  40117c:	48 8d 05 85 0e 00 00 	lea    rax,[rip+0xe85]        # 402008 <_IO_stdin_used+0x8>
  401183:	48 89 c7             	mov    rdi,rax
  401186:	b8 00 00 00 00       	mov    eax,0x0
  40118b:	e8 d0 fe ff ff       	call   401060 <printf@plt>
  401190:	90                   	nop
  401191:	c9                   	leave
  401192:	c3                   	ret

0000000000401193 <format_string_vuln>:
  401193:	55                   	push   rbp
  401194:	48 89 e5             	mov    rbp,rsp
  401197:	48 83 ec 10          	sub    rsp,0x10
  40119b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  40119f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  4011a3:	48 89 c7             	mov    rdi,rax
  4011a6:	b8 00 00 00 00       	mov    eax,0x0
  4011ab:	e8 b0 fe ff ff       	call   401060 <printf@plt>
  4011b0:	bf 0a 00 00 00       	mov    edi,0xa
  4011b5:	e8 76 fe ff ff       	call   401030 <putchar@plt>
  4011ba:	90                   	nop
  4011bb:	c9                   	leave
  4011bc:	c3                   	ret

00000000004011bd <main>:
  4011bd:	55                   	push   rbp
  4011be:	48 89 e5             	mov    rbp,rsp
  4011c1:	48 83 ec 10          	sub    rsp,0x10
  4011c5:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
  4011c8:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  4011cc:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
  4011d0:	7f 25                	jg     4011f7 <main+0x3a>
  4011d2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  4011d6:	48 8b 00             	mov    rax,QWORD PTR [rax]
  4011d9:	48 89 c6             	mov    rsi,rax
  4011dc:	48 8d 05 30 0e 00 00 	lea    rax,[rip+0xe30]        # 402013 <_IO_stdin_used+0x13>
  4011e3:	48 89 c7             	mov    rdi,rax
  4011e6:	b8 00 00 00 00       	mov    eax,0x0
  4011eb:	e8 70 fe ff ff       	call   401060 <printf@plt>
  4011f0:	b8 01 00 00 00       	mov    eax,0x1
  4011f5:	eb 3a                	jmp    401231 <main+0x74>
  4011f7:	48 8d 05 2a 0e 00 00 	lea    rax,[rip+0xe2a]        # 402028 <_IO_stdin_used+0x28>
  4011fe:	48 89 c7             	mov    rdi,rax
  401201:	e8 4a fe ff ff       	call   401050 <puts@plt>
  401206:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  40120a:	48 83 c0 08          	add    rax,0x8
  40120e:	48 8b 00             	mov    rax,QWORD PTR [rax]
  401211:	48 89 c7             	mov    rdi,rax
  401214:	e8 3d ff ff ff       	call   401156 <vulnerable_function>
  401219:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  40121d:	48 83 c0 08          	add    rax,0x8
  401221:	48 8b 00             	mov    rax,QWORD PTR [rax]
  401224:	48 89 c7             	mov    rdi,rax
  401227:	e8 67 ff ff ff       	call   401193 <format_string_vuln>
  40122c:	b8 00 00 00 00       	mov    eax,0x0
  401231:	c9                   	leave
  401232:	c3                   	ret

Disassembly of section .fini:

0000000000401234 <_fini>:
  401234:	48 83 ec 08          	sub    rsp,0x8
  401238:	48 83 c4 08          	add    rsp,0x8
  40123c:	c3                   	ret
