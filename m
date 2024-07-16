Return-Path: <linux-iio+bounces-7638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC651932E74
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B61C2214D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E019E822;
	Tue, 16 Jul 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8p1OCvj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCD1DFF0;
	Tue, 16 Jul 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147852; cv=none; b=MdpTuTFUjxyMNrEX/cnVRVETlVq3uo4xAVf6b2jAj/qEVGcqVjx0Nve4J4MmqfTfGwLoBoF2DgVNN4usEp4ugY6AC0odsZJO0Wl0EazZzO8T2iPoPju/6Vgmt25J3Kp4+6KW6mVI1TA3CDnmCvx1tLIgkimWVsiLNp8bMZ5Xfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147852; c=relaxed/simple;
	bh=vK7Gyxxt2pqmgNDEvXOM+qGxAkW9bXhQSQBiN5GtWFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqoDyozOI662UE2VB7U9KBFxs7UL3vaNjmQE5UAQbnuj72cSewIFPBdO7plUAU1WW8fBI40SB9IQbMVp+GgIbskp+0AEyzW0A1xb0c6MAKlso8Yqsw28rVT3iuFYo71V36xUurSD247Ju+VjZGG8VpzjyK1etyA79WJW4KMrVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8p1OCvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04514C116B1;
	Tue, 16 Jul 2024 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721147852;
	bh=vK7Gyxxt2pqmgNDEvXOM+qGxAkW9bXhQSQBiN5GtWFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8p1OCvjiMLG5mQY3dWb54Zh8iTNLFBxMGZg3SFx+x2ecNBsslAkPksPz0KHgULuZ
	 XdTACUQvwbRBsh7m+iHmjjc86Nyt4InNWsDTKk9QteTVxunpH1Fga/YDUUm/+k3tJN
	 vDnF7Ygs6C+KtW8Fi5glY+SL245X96Bq9GhOhU0gAq2Qgxul24cPXPDP68FWy5Jzuu
	 cErXlOfRpLaAK8QlSLEBrTE5OFckAmn4f9QeZoMDNrwGYnGmdPD9p+Hu36Sn1263il
	 JErILZ6Rmaw0j+PQBlFQYrthk/zE1QwdAe8vg/bygFs3ujTYuD4WLySJKA2hTq4te4
	 i7UJsyb3dEA4w==
Date: Tue, 16 Jul 2024 17:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 Linux Memory Management List <linux-mm@kvack.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Paul Menzel <pmenzel@molgen.mpg.de>, Marco
 Elver <elver@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [linux-next:master] [iio]  8d61d01cde:
 WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk
Message-ID: <20240716173722.5e582581@jic23-huawei>
In-Reply-To: <202407161520.ee3d9347-lkp@intel.com>
References: <202407161520.ee3d9347-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 15:59:12 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk" on:
> 
> commit: 8d61d01cdec275719b70295e98e4d45c5f284f29 ("iio: gyro: adis16260: make use of the new lock helpers")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 91e3b24eb7d297d9d99030800ed96944b8652eaf]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: trivial
> 
> 
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------+------------+------------+
> |                                                     | ccd52641f9 | 8d61d01cde |
> +-----------------------------------------------------+------------+------------+
> | WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk | 0          | 30         |
> | RIP:__warn_thunk                                    | 0          | 30         |
> +-----------------------------------------------------+------------+------------+

Hi All.

I'm struggling to have any idea what this is reporting.
The code is question must be the use of adis_dev_autoscoped_lock()
which is very straight forward.

		adis_dev_auto_scoped_lock(adis) {
			if (t >= 0x0A)
				adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
			else
				adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
			return __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
		}
		unreachable();
		//needed because not all compilers seem to be able to tell
		//that a scoped_guard() always runs.

where the definition is simply 

#define adis_dev_auto_scoped_lock(adis) \
	scoped_guard(mutex, &(adis)->state_lock)

Looks like there was some fun with ksan earlier in the year that smells superficially
similar but that is long resolved? (+CC some of the folk involved in solving that).

Any thoughts?

Jonathan

> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407161520.ee3d9347-lkp@intel.com
> 
> 
> [    6.698254][    T1] ------------[ cut here ]------------
> [    6.698774][    T1] Unpatched return thunk in use. This should not happen!
> [ 6.699377][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3023 __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [    6.699604][    T1] Modules linked in:
> [    6.699937][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc4-00198-g8d61d01cdec2 #1
> [    6.700668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 6.701548][ T1] RIP: 0010:__warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [ 6.701983][ T1] Code: 1f 44 00 00 80 3d dd fb e3 03 00 74 08 31 ff c3 cc cc cc cc cc c6 05 cc fb e3 03 01 90 48 c7 c7 40 b0 a1 83 e8 76 c6 13 00 90 <0f> 0b 90 90 31 ff c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8
> All code
> ========
>    0:	1f                   	(bad)
>    1:	44 00 00             	add    %r8b,(%rax)
>    4:	80 3d dd fb e3 03 00 	cmpb   $0x0,0x3e3fbdd(%rip)        # 0x3e3fbe8
>    b:	74 08                	je     0x15
>    d:	31 ff                	xor    %edi,%edi
>    f:	c3                   	ret
>   10:	cc                   	int3
>   11:	cc                   	int3
>   12:	cc                   	int3
>   13:	cc                   	int3
>   14:	cc                   	int3
>   15:	c6 05 cc fb e3 03 01 	movb   $0x1,0x3e3fbcc(%rip)        # 0x3e3fbe8
>   1c:	90                   	nop
>   1d:	48 c7 c7 40 b0 a1 83 	mov    $0xffffffff83a1b040,%rdi
>   24:	e8 76 c6 13 00       	call   0x13c69f
>   29:	90                   	nop
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	90                   	nop
>   2d:	90                   	nop
>   2e:	31 ff                	xor    %edi,%edi
>   30:	c3                   	ret
>   31:	cc                   	int3
>   32:	cc                   	int3
>   33:	cc                   	int3
>   34:	cc                   	int3
>   35:	cc                   	int3
>   36:	cc                   	int3
>   37:	cc                   	int3
>   38:	cc                   	int3
>   39:	cc                   	int3
>   3a:	cc                   	int3
>   3b:	cc                   	int3
>   3c:	cc                   	int3
>   3d:	cc                   	int3
>   3e:	cc                   	int3
>   3f:	b8                   	.byte 0xb8
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	31 ff                	xor    %edi,%edi
>    6:	c3                   	ret
>    7:	cc                   	int3
>    8:	cc                   	int3
>    9:	cc                   	int3
>    a:	cc                   	int3
>    b:	cc                   	int3
>    c:	cc                   	int3
>    d:	cc                   	int3
>    e:	cc                   	int3
>    f:	cc                   	int3
>   10:	cc                   	int3
>   11:	cc                   	int3
>   12:	cc                   	int3
>   13:	cc                   	int3
>   14:	cc                   	int3
>   15:	b8                   	.byte 0xb8
> [    6.703602][    T1] RSP: 0000:ffffc9000001fe88 EFLAGS: 00010246
> [    6.704116][    T1] RAX: 0000000000000000 RBX: ffffffff856a96a0 RCX: 0000000000000000
> [    6.704787][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    6.705462][    T1] RBP: ffffc9000001fed8 R08: 0000000000000000 R09: 0000000000000000
> [    6.706134][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    6.706804][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff856a96a0
> [    6.707476][    T1] FS:  0000000000000000(0000) GS:ffffffff844a7000(0000) knlGS:0000000000000000
> [    6.707601][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.708157][    T1] CR2: ffff88843ffff000 CR3: 000000000446c000 CR4: 00000000000406f0
> [    6.708834][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    6.709505][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    6.710174][    T1] Call Trace:
> [    6.710452][    T1]  <TASK>
> [ 6.710701][ T1] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
> [ 6.711054][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [ 6.711434][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [ 6.711604][ T1] ? report_bug (lib/bug.c:?) 
> [ 6.711991][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
> [ 6.712357][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> [ 6.712759][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [ 6.713193][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [ 6.713575][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:3023) 
> [ 6.713956][ T1] warn_thunk_thunk (arch/x86/entry/entry.S:48) 
> [ 6.714352][ T1] ? __cfi_asan.module_ctor (main.c:?) 
> [ 6.714810][ T1] do_basic_setup (init/main.c:1126 init/main.c:1363) 
> [ 6.715194][ T1] kernel_init_freeable (init/main.c:1582) 
> [ 6.715602][ T1] ? __cfi_kernel_init (init/main.c:1459) 
> [ 6.716022][ T1] kernel_init (init/main.c:1469) 
> [ 6.716389][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 6.716769][ T1] ? __cfi_kernel_init (init/main.c:1459) 
> [ 6.717187][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [    6.717600][    T1]  </TASK>
> [    6.717856][    T1] irq event stamp: 14123
> [ 6.718213][ T1] hardirqs last enabled at (14131): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
> [ 6.719011][ T1] hardirqs last disabled at (14138): console_unlock (kernel/printk/printk.c:339) 
> [ 6.719601][ T1] softirqs last enabled at (2244): irq_exit_rcu (kernel/softirq.c:651) 
> [ 6.720366][ T1] softirqs last disabled at (2235): irq_exit_rcu (kernel/softirq.c:651) 
> [    6.721120][    T1] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240716/202407161520.ee3d9347-lkp@intel.com
> 
> 
> 


