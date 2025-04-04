Return-Path: <linux-iio+bounces-17629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A316FA7C31F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C65172F72
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295F21507F;
	Fri,  4 Apr 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lA6t2n3R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87F15DBB3
	for <linux-iio@vger.kernel.org>; Fri,  4 Apr 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790474; cv=none; b=P6HGAvCu2nmJTQH6j37jamSzdNea2JG+tjRh8vzvgit77Gw7Bx5Hk80VdkFJ6F28yDWL3Gbt+Ek6vZ6139xLhWLI4LS+rU7uVkLUH5LIBtygA4hzz///emyUMdFOeOdAo00R9PikcxhYoRI6PRtkMjf/f682HUoQL82SaxFPcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790474; c=relaxed/simple;
	bh=b0yXdSPPEM/BHzIydaiOQ1im9W4vvz4ftY78YQdRybw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j83+HkSKgu7KUNnv653I1NaxvYRdM/mEzwr6yzLyK54VRMpTqQPx2hXwWRtvJWUKFt/Nd62wKRCgXQmVCXzZ3i2lew3Y7My4axJ4hKBn8iTTwaVT/ewvEXxJbS+GcGpnOChsyIQmZi6+QFUxRbBgcI8s7RBkDw6i1WQCaL0uryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lA6t2n3R; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72bb9725de1so618683a34.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Apr 2025 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743790470; x=1744395270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPS0By6+PX0Bry+3YPCkUrIWlS533GAkXzvPAqPcARU=;
        b=lA6t2n3R3GzpLqYMQYqyvLrYKy/0ljAuR4y4tOWZba0zCS/jH8WVMbxfnrnx5A1VaA
         /f81xM/MCk9UjO6n2GuFfwvEX+gMGG2PLxAMUVS7xUNyE1msw6F55zl8+/CZqaxsxH1k
         Pafy4O1cKmYunvOeL52HmbNMiK5F//VVgAWOhGr9mkeAWooKR8zO1sIg1AXtpD6fvLg9
         Yo3tw7Ve3amfr0N2X3np9nElBpyIIqqb/7QLvt1/5F6/Ptr0loXrXSjOgaEEdkj73F10
         gJv1XDukNVXx383nKjyqhD6ZmKl+wHCHtQlOLmTvYWzR5kdbEbxieSZQDLFsuu5/WzJa
         MhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790470; x=1744395270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPS0By6+PX0Bry+3YPCkUrIWlS533GAkXzvPAqPcARU=;
        b=b73YRRStzFavOsWBK/FPCOe40TpEzFWs2+mG6DtU5wLhbL8AgY55hNFEQ1/JTbGIvY
         Qu4x/cdISrxHvMCsWS1Xxn485TkfK6yIv6d3zEnajMsQegceHa+Zuim+OyG6lAYCwbDJ
         7XP2wNTVeFX5tkHHq2SPZyHgYQu/bMXVrblXPCn30NdMHBXfrDxQfxPNlQoxkDC3wI3/
         h8W8EPb7CV+ZPNHGYLsfjanxEfRpAuXG1awHVN+EbUx7tHcS3aTPLXsimKBuS8gzo+B6
         o48OijAKT+ELzVbKFgK+RTChhprsCus+tfaUkprMGGkauE6c4Pa9tSEDKAsn7ZjAMuI4
         q7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNTlI2dFJ8UKBk7kNPG5xg7E2ecMXEVdEiHeqrTy8pdnko9HzbeQpACKPQkfELjBIgQSEat4OXjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT+e3AhG21UhjqoRo4Syu6LBvyJgNGiY3mz40Ccv3uvwCOH0Q
	c55rox6Qf470H/TynODG1mobY5R+dv1lVI2WCGf6K46pja4hVTC5gDJR6VEj5Ss=
X-Gm-Gg: ASbGnctO0nlxi8gyfxyaA+jF9NJgng29Z8D5zdxIZM7yWV4UPiE8DDrN78OEuTcvDgC
	xP0E/8htIQo7yioLCICCFas+U1wlz2ExLquKUaVyc3P20ZvHO4j8FbKuNKYVr8VIENGaQpkoExB
	Q5uEjwKKrGZnqueBV1y8dTKlSR0/Slwy5T0KMFDXHqi4elcScK/vwvUe0F6Lcl+Q3ZYfwk0jEOj
	KgCkBkCczIUs2Pyn6AYIN1/5G4iaaS5n0CoeJal/rhFhipZupp83rYHABpZMCkPeKvMdfY4UXcE
	356QhRMWBElZOK1qRbt7DZ2Zh9gUBCmAVOaPYP947WB0jp4l870jGFdIxfCotXvEMjehdEc/Ao5
	uyFbTcQ==
X-Google-Smtp-Source: AGHT+IH+c/0KyFINSsy4htn2eLc1MKq9dlVFyXv9Z9HE42ccBET5q3pYMHtKHHpxUnsEKtgL/3Krmw==
X-Received: by 2002:a05:6830:6388:b0:727:4356:9f07 with SMTP id 46e09a7af769-72e367e510cmr2849237a34.14.1743790469499;
        Fri, 04 Apr 2025 11:14:29 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e3059a457sm750027a34.51.2025.04.04.11.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 11:14:29 -0700 (PDT)
Message-ID: <7035837b-e98f-4c36-ad44-f189cd91ce4a@baylibre.com>
Date: Fri, 4 Apr 2025 13:14:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Crash: iio_dummy: General protection fault and
 null-ptr-deref in iio_simple_dummy_events_register
To: Waseem Riaz <waseem.riaz.9999@gmail.com>, linux-iio@vger.kernel.org
References: <CAGehKVX1bLj67wSVxDkNBLFP7nXs572z+WQVcnfiOTEoY4sygQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAGehKVX1bLj67wSVxDkNBLFP7nXs572z+WQVcnfiOTEoY4sygQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/25 10:26 PM, Waseem Riaz wrote:
> Hi,
> 
> I'm encountering a kernel crash when trying to create a dummy device
> in the IIO subsystem using configfs. This occurs when executing:
> 
>     mkdir /config/iio/devices/dummy/my_dummy_device
> 
> The error manifests as a general protection fault with KASAN reporting
> a null pointer dereference. The crash occurs in
> __x86_indirect_thunk_r13 during iio_simple_dummy_events_register.
> 
> ## Environment
> - Kernel version: 6.14.0-rc1-g2014c95afece
> - Architecture: x86_64
> - Testing environment: QEMU VM
> 
> ## Steps to reproduce
> 1. Build the kernel with CONFIG_IIO_CONFIGFS,
> CONFIG_IIO_SIMPLE_DUMMY=m, and CONFIG_IIO_DUMMY_EVGEN=m
> 2. Start qemu with the kernel and bullseye image with the following command
>          qemu-system-x86_64 \
>         -m 2G \
>         -smp 2 \
>         -kernel iio/arch/x86/boot/bzImage \
>         -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>         -drive file= image/bullseye.img,format=raw \
>         -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
>         -net nic,model=e1000 \
>         -enable-kvm \
>         -nographic \
>         -pidfile vm.pid \
>         2>&1 | tee vm.log
> 3. Mount configfs to /config
>          mount -t configfs none /config
> 4. Load the modules in order
> 5. Create a dummy device in /config/iio/devices/dummy/

Thanks for the detailed bug report. :-)

> 
> ## Crash Log
> [   99.037889] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000000: 000I
> [   99.044568] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [   99.046591] CPU: 1 UID: 0 PID: 236 Comm: mkdir Not tainted
> 6.14.0-rc1-g2014c95afece #8
> [   99.048575] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Arch Linux 1.16.3-1-1 04/01/204
> [   99.050516] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
> [   99.051818] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
> [   99.056765] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
> [   99.057870] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
> [   99.059311] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
> [   99.060580] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
> [   99.061419] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
> [   99.062269] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
> [   99.063254] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
> knlGS:0000000000000000
> [   99.064734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   99.065649] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
> [   99.066599] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   99.067627] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   99.068726] Call Trace:
> [   99.069106]  <TASK>
> [   99.069442]  ? __die_body.cold+0x19/0x29
> [   99.069862]  ? die_addr+0x41/0x70
> [   99.070222]  ? exc_general_protection+0x13f/0x210
> [   99.071005]  ? asm_exc_general_protection+0x26/0x30
> [   99.071809]  ? __pfx_irq_sim_request_resources+0x10/0x10
> [   99.072639]  ? kasan_save_stack+0x30/0x50
> [   99.073263]  ? __x86_indirect_thunk_r13+0xa/0x20
> [   99.074055]  ? irq_sim_request_resources+0xf3/0x160
> [   99.074871]  ? setup_irq_thread+0xfa/0x180
> [   99.075576]  ? __setup_irq+0x747/0x1a20
> [   99.076207]  ? kasan_save_track+0x14/0x30
> [   99.077482]  ? request_threaded_irq+0x20b/0x350
> [   99.077954]  ? __pfx_iio_simple_dummy_event_handler+0x10/0x10 [iio_dummy]
> [   99.078647]  ? iio_simple_dummy_events_register+0x104/0x1a0 [iio_dummy]
> [   99.079356]  ? kstrdup+0x8b/0xb0
> [   99.079991]  ? iio_dummy_probe+0x3d7/0x5c0 [iio_dummy]

Apparently, the IRQ is already triggered and the handler is called
before the indio_dev is fully registered.

We should probably be passing the IRQF_NO_AUTOEN flag when requesting
the IRQ and use the iio_simple_dummy_write_event_config() function to
actually enable and disable the IRQ.

And it would be good to understand why the interrupt was already
triggered.


> [   99.080761]  ? iio_sw_device_create+0x137/0x230
> [   99.081447]  ? __pfx_device_make_group+0x10/0x10
> [   99.082234]  ? device_make_group+0x33/0x80
> [   99.083106]  ? configfs_mkdir+0x449/0xdf0
> [   99.083836]  ? vfs_mkdir+0x452/0x760
> [   99.084457]  ? do_mkdirat+0x17b/0x330
> [   99.085022]  ? __pfx_do_mkdirat+0x10/0x10
> [   99.085543]  ? strncpy_from_user+0x129/0x210
> [   99.085998]  ? __x64_sys_mkdir+0xe6/0x130
> [   99.086506]  ? do_syscall_64+0x9e/0x1a0
> [   99.087118]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   99.087936]  </TASK>
> [   99.088323] Modules linked in: iio_dummy iio_dummy_evgen
> [   99.088949] ---[ end trace 0000000000000000 ]---
> [   99.089526] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
> [   99.090194] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
> [   99.093617] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
> [   99.094379] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
> [   99.095596] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
> [   99.097176] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
> [   99.098109] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
> [   99.098893] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
> [   99.101368] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
> knlGS:0000000000000000
> [   99.102606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   99.105567] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
> [   99.107410] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   99.108835] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Segmentation fault
> 
> Any help or guidance would be appreciated
> 
> I'm planning to apply for GSOC but I think it's already late. Should I
> try writing a proposal?

It looks like there are still a few days left before the deadline.

If you haven't seen the other recent discussions, you will probably find some
useful info here: https://lore.kernel.org/linux-iio/?q=gsoc

> 
> Thank you,
> Waseem
> 


