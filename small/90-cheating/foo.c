_start()
{
	// write 14 bytes to fd==1
	register int    syscall_wr  asm("rax") = 1;
	register int    arg1        asm("rdi") = 1;
	register char*  arg2        asm("rsi") = "hello, world!\n";
	register int    arg3        asm("rdx") = 14;
	asm("syscall");

	// exit with ret 0
	register int    syscall_ex  asm("rax") = 60;
	register int    arg4        asm("rdi") = 0;
	asm("syscall");
}
