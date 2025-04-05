Return-Path: <linux-iio+bounces-17636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F1DA7C9E6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A144171669
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D062260C;
	Sat,  5 Apr 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1T/TMci"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDC46447
	for <linux-iio@vger.kernel.org>; Sat,  5 Apr 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743866931; cv=none; b=URoyILOnyV3bot3LnUjgCfZ4cc6BfciMzc1d+8FltCIByXz6eJdVpi3Vsk4z3ahVcojolGDKoGMxhVCLJ7pWStK33eZAbxm/UFXdRbDI+RDLJ5aqCurcIY//HvG2aThrRIuTTEF32V/0WOEz8hmaWnPolUs3NzfQXRUjc10+3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743866931; c=relaxed/simple;
	bh=76bToZogENJS65Wewj9QgfboWuktGDWmS5WBoTVkwm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EI2ogYo3iUfGIrAGaD+im6vR7M1SujAKL/KIY7c2LrFLWNIEfCe4yMsW16NE5IuE7tWGbbPJRg9szKqtnwE7F1QxLd3CU7kXz53R7/IoUYpwvE9GstKD/gOwlRg2aX/7N2Mna8O/4D2Sx6gYsZEQx8xAJQLQyUGylYVVbY3ijUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1T/TMci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29CBC4CEE4;
	Sat,  5 Apr 2025 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743866930;
	bh=76bToZogENJS65Wewj9QgfboWuktGDWmS5WBoTVkwm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1T/TMciQ5rLxz65rd/n8Uw46IU2bqPu0IZHj2daQDBs1fucYNVrIYrujNxQ/26Ai
	 /elJwBYAjZx/y1u8IFUKy+MkziFQNo+FzuvuLx4+dzX1v+IvspTvLlg83x2MG8ZA9Q
	 mQVQUV7wA9X+qoQ8ydHumHQySUlJW1NGzwR4PBdpZJv0gKzsZWDjBbaJURxXVOytPS
	 5EcBWkPHDfnmOtPatWlkAnYU0h5Giv9MyRL8oeJJngLusMb8r+xJbGstW6mIP28ATB
	 kiwvhMCc+vmef2NbmKbN5LKeFVptleYDM2Ic+RPhV8AQOQlMWqdxjAijSEtc/Bmlxf
	 NzHL0AQIn2XXw==
Date: Sat, 5 Apr 2025 16:28:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Waseem Riaz <waseem.riaz.9999@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: Kernel Crash: iio_dummy: General protection fault and
 null-ptr-deref in iio_simple_dummy_events_register
Message-ID: <20250405162845.48486938@jic23-huawei>
In-Reply-To: <7035837b-e98f-4c36-ad44-f189cd91ce4a@baylibre.com>
References: <CAGehKVX1bLj67wSVxDkNBLFP7nXs572z+WQVcnfiOTEoY4sygQ@mail.gmail.com>
	<7035837b-e98f-4c36-ad44-f189cd91ce4a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 13:14:28 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/25/25 10:26 PM, Waseem Riaz wrote:
> > Hi,
> > 
> > I'm encountering a kernel crash when trying to create a dummy device
> > in the IIO subsystem using configfs. This occurs when executing:
> > 
> >     mkdir /config/iio/devices/dummy/my_dummy_device
> > 
> > The error manifests as a general protection fault with KASAN reporting
> > a null pointer dereference. The crash occurs in
> > __x86_indirect_thunk_r13 during iio_simple_dummy_events_register.
> > 
> > ## Environment
> > - Kernel version: 6.14.0-rc1-g2014c95afece
> > - Architecture: x86_64
> > - Testing environment: QEMU VM
> > 
> > ## Steps to reproduce
> > 1. Build the kernel with CONFIG_IIO_CONFIGFS,
> > CONFIG_IIO_SIMPLE_DUMMY=m, and CONFIG_IIO_DUMMY_EVGEN=m
> > 2. Start qemu with the kernel and bullseye image with the following command
> >          qemu-system-x86_64 \
> >         -m 2G \
> >         -smp 2 \
> >         -kernel iio/arch/x86/boot/bzImage \
> >         -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> >         -drive file= image/bullseye.img,format=raw \
> >         -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> >         -net nic,model=e1000 \
> >         -enable-kvm \
> >         -nographic \
> >         -pidfile vm.pid \  
> >         2>&1 | tee vm.log  
> > 3. Mount configfs to /config
> >          mount -t configfs none /config
> > 4. Load the modules in order
> > 5. Create a dummy device in /config/iio/devices/dummy/  
> 
> Thanks for the detailed bug report. :-)
> 
> > 
> > ## Crash Log
> > [   99.037889] Oops: general protection fault, probably for
> > non-canonical address 0xdffffc0000000000: 000I
> > [   99.044568] KASAN: null-ptr-deref in range
> > [0x0000000000000000-0x0000000000000007]
> > [   99.046591] CPU: 1 UID: 0 PID: 236 Comm: mkdir Not tainted
> > 6.14.0-rc1-g2014c95afece #8
> > [   99.048575] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS Arch Linux 1.16.3-1-1 04/01/204
> > [   99.050516] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
> > [   99.051818] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
> > 66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
> > [   99.056765] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
> > [   99.057870] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
> > [   99.059311] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
> > [   99.060580] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
> > [   99.061419] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
> > [   99.062269] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
> > [   99.063254] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
> > knlGS:0000000000000000
> > [   99.064734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   99.065649] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
> > [   99.066599] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   99.067627] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   99.068726] Call Trace:
> > [   99.069106]  <TASK>
> > [   99.069442]  ? __die_body.cold+0x19/0x29
> > [   99.069862]  ? die_addr+0x41/0x70
> > [   99.070222]  ? exc_general_protection+0x13f/0x210
> > [   99.071005]  ? asm_exc_general_protection+0x26/0x30
> > [   99.071809]  ? __pfx_irq_sim_request_resources+0x10/0x10
> > [   99.072639]  ? kasan_save_stack+0x30/0x50
> > [   99.073263]  ? __x86_indirect_thunk_r13+0xa/0x20
> > [   99.074055]  ? irq_sim_request_resources+0xf3/0x160
> > [   99.074871]  ? setup_irq_thread+0xfa/0x180
> > [   99.075576]  ? __setup_irq+0x747/0x1a20
> > [   99.076207]  ? kasan_save_track+0x14/0x30
> > [   99.077482]  ? request_threaded_irq+0x20b/0x350
> > [   99.077954]  ? __pfx_iio_simple_dummy_event_handler+0x10/0x10 [iio_dummy]
> > [   99.078647]  ? iio_simple_dummy_events_register+0x104/0x1a0 [iio_dummy]
> > [   99.079356]  ? kstrdup+0x8b/0xb0
> > [   99.079991]  ? iio_dummy_probe+0x3d7/0x5c0 [iio_dummy]  
> 
> Apparently, the IRQ is already triggered and the handler is called
> before the indio_dev is fully registered.
> 
> We should probably be passing the IRQF_NO_AUTOEN flag when requesting
> the IRQ and use the iio_simple_dummy_write_event_config() function to
> actually enable and disable the IRQ.
> 
> And it would be good to understand why the interrupt was already
> triggered.

I probably need more coffee but why do we know it was an interrupt triggered?

In general interrupt handlers should be safe against the
final iio_device_register() but we may be missing some protections
in the event handling if an interrupt hits mid registration.  In particular  
iio_device_register_eventset() sets the
iio_dev_opaque->event_interfaces pointer too early. That should only
happen once iio_set_evint() has succeeded (which sets up the kfifo and
similar).

Mostly we'd never see this as the interfaces to actually enable events
should be exposed only after this so the interrupts aren't turned on yet.
Still we might get a spurious signal so the code should be more careful
in this respect.

This area needs some review - but I'm not sure it is what is
going on here.  

Jonathan


> 
> 
> > [   99.080761]  ? iio_sw_device_create+0x137/0x230
> > [   99.081447]  ? __pfx_device_make_group+0x10/0x10
> > [   99.082234]  ? device_make_group+0x33/0x80
> > [   99.083106]  ? configfs_mkdir+0x449/0xdf0
> > [   99.083836]  ? vfs_mkdir+0x452/0x760
> > [   99.084457]  ? do_mkdirat+0x17b/0x330
> > [   99.085022]  ? __pfx_do_mkdirat+0x10/0x10
> > [   99.085543]  ? strncpy_from_user+0x129/0x210
> > [   99.085998]  ? __x64_sys_mkdir+0xe6/0x130
> > [   99.086506]  ? do_syscall_64+0x9e/0x1a0
> > [   99.087118]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   99.087936]  </TASK>
> > [   99.088323] Modules linked in: iio_dummy iio_dummy_evgen
> > [   99.088949] ---[ end trace 0000000000000000 ]---
> > [   99.089526] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
> > [   99.090194] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
> > 66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
> > [   99.093617] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
> > [   99.094379] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
> > [   99.095596] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
> > [   99.097176] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
> > [   99.098109] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
> > [   99.098893] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
> > [   99.101368] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
> > knlGS:0000000000000000
> > [   99.102606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   99.105567] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
> > [   99.107410] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   99.108835] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Segmentation fault
> > 
> > Any help or guidance would be appreciated
> > 
> > I'm planning to apply for GSOC but I think it's already late. Should I
> > try writing a proposal?  
> 
> It looks like there are still a few days left before the deadline.
> 
> If you haven't seen the other recent discussions, you will probably find some
> useful info here: https://lore.kernel.org/linux-iio/?q=gsoc
> 
> > 
> > Thank you,
> > Waseem
> >   
> 
> 


