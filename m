Return-Path: <linux-iio+bounces-17264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC2CA70F67
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BF71887337
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C51624CE;
	Wed, 26 Mar 2025 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQwbiuQi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80672E403
	for <linux-iio@vger.kernel.org>; Wed, 26 Mar 2025 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959608; cv=none; b=mh3RMyHV0SCXEC9kAiVmts4vO4ivR+7vA7wwp4YBOd35pTm1M5owAdGJpefBPXdG1bKfrNhkHypan0m1gS5DbMvHKV+gFD57RiGq/wxPYspQu9ZBg5JTAEwcrUHbeMM5EwnRFA+26kll3hzbzgfYCAxdnV8BVHBtUkjocb10PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959608; c=relaxed/simple;
	bh=rLtiKoVldWH5uElLWwxoqLiJA7nWL5a1sicBgon2gtk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oa4JaISdmkAaCheSk94UtLTQ3mQCAmNX0oVvrQjJs2PJUcQOXGJCHfzlAofs0XqXUwR4F+lR+ld4HN5Ncda7KHPmUYfJ383PCKuuZ5iyL6dkFamlglHuHeLtXfap4WRIiKK6gaX5GTU53MVl2ApA0l3zWTfeIqdQlWck4lFim/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQwbiuQi; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so5013580276.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Mar 2025 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742959605; x=1743564405; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRR/wmJ8OPBM8CXguPoBfrsIHSbQwaHX6ORBONyNwGU=;
        b=HQwbiuQi+kNNT8Mr2CQb4XVJhV2jkcf4CR9a594wrGPt5NaZYAzMgS65T/crCBqWo7
         FfREGX4YRD+F4Ai7acsBK4ANq297/yojxCzRadKRwu/aFZlq75lCLvNGQFFyIl8C8Hm8
         gIoZS69N8EO5m32Rmuoo2FJfSkqxvIhnQP6OY/oUtO7A2B5GpFJdcyCrD63t2t/sgcBm
         pD61GF2FGSSGfiLMzfVr+CI6d6+89OpxUH5Vjd4d1FnAxSwzJOgxgcpHRKUTCUEtzxsj
         +2irwgwSSAdu9fkAfFygCwnPLrigaNK5ZaCIlx1N0bD+xpmcduVt9xE2EDqPvgNptfww
         2fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742959605; x=1743564405;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRR/wmJ8OPBM8CXguPoBfrsIHSbQwaHX6ORBONyNwGU=;
        b=FclxDvHcKNga8F3LYyq2fRXNBwMbcA0uD8eWlP+2N7re7PwCKmwcDxBTZAD//A/tIb
         kBz7hFeCLWv4JbXf1PTLETa80/HtlU8kbbaWmz8603RGkHG0Pasa1W83setsIg19H+Xw
         Xr4h+Ym69rzvoPcYWpGy/Ia8QGLOU5zfhum79AjSyxzqCfIzBIV9BwQMOlA/DiUgSa/p
         uKYbWPlTVgx4EvyUfHxD6W9gTr2AljaqbR88no1q7qZ4+memoYt6rOqSiLJ7TIKriQ+F
         u3J3YoL9DbkX/SNXzcqvNEC9IMIjzP7C16ySaVWlyjP948aCFsJBBQIOvmHaBu17jRyT
         EjXw==
X-Gm-Message-State: AOJu0Yx3VqTabIOOyV7DI0Ed9hJslNDlhyOd6JqoZjxgs4bvhqljyz7f
	3bQFMJxxWti9vdt8SAu5B71mqz+3YuXo/mzqn8nezkHrw7QlzgWNSAmJxMKWCSUPn5CEZxTD/TC
	awivoRNHB0tHJwtliGlIDkCEMp4Y63exZK/E=
X-Gm-Gg: ASbGnctg3otba7cyVl1h61XVt8/xlJElxJs3P8iBSQaJxcK8n/AaClqi1/SJQIXyeMx
	HrVb520sE8i8c4El6aep33qzfs5//Yd1jqil1gSQYjUv0PNGpYjJHjxQ+HzRCpq1y3RTGn4VE8S
	UOj117RGjIlTiDLx0vfv7SBgwpRWs=
X-Google-Smtp-Source: AGHT+IEWMwmAvYupUa0ZbooCNi8gWqMUGa1BiLgHdkGnH0xd8X/QMWiTTIhSplZMN8DGBaWy/4MDTDd2LAJ2HnYpEyc=
X-Received: by 2002:a05:6902:845:b0:e69:1efc:9ec8 with SMTP id
 3f1490d57ef6-e6926cef7c3mr5618845276.7.1742959605164; Tue, 25 Mar 2025
 20:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Waseem Riaz <waseem.riaz.9999@gmail.com>
Date: Wed, 26 Mar 2025 08:56:34 +0530
X-Gm-Features: AQ5f1JroK2xvfZ1slBKgMMxVJULJE5NMgFUT3XzUegQzu-t43INJxD_1xlBtMeA
Message-ID: <CAGehKVX1bLj67wSVxDkNBLFP7nXs572z+WQVcnfiOTEoY4sygQ@mail.gmail.com>
Subject: Kernel Crash: iio_dummy: General protection fault and null-ptr-deref
 in iio_simple_dummy_events_register
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm encountering a kernel crash when trying to create a dummy device
in the IIO subsystem using configfs. This occurs when executing:

    mkdir /config/iio/devices/dummy/my_dummy_device

The error manifests as a general protection fault with KASAN reporting
a null pointer dereference. The crash occurs in
__x86_indirect_thunk_r13 during iio_simple_dummy_events_register.

## Environment
- Kernel version: 6.14.0-rc1-g2014c95afece
- Architecture: x86_64
- Testing environment: QEMU VM

## Steps to reproduce
1. Build the kernel with CONFIG_IIO_CONFIGFS,
CONFIG_IIO_SIMPLE_DUMMY=m, and CONFIG_IIO_DUMMY_EVGEN=m
2. Start qemu with the kernel and bullseye image with the following command
         qemu-system-x86_64 \
        -m 2G \
        -smp 2 \
        -kernel iio/arch/x86/boot/bzImage \
        -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
        -drive file= image/bullseye.img,format=raw \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
        -net nic,model=e1000 \
        -enable-kvm \
        -nographic \
        -pidfile vm.pid \
        2>&1 | tee vm.log
3. Mount configfs to /config
         mount -t configfs none /config
4. Load the modules in order
5. Create a dummy device in /config/iio/devices/dummy/

## Crash Log
[   99.037889] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000000: 000I
[   99.044568] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[   99.046591] CPU: 1 UID: 0 PID: 236 Comm: mkdir Not tainted
6.14.0-rc1-g2014c95afece #8
[   99.048575] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Arch Linux 1.16.3-1-1 04/01/204
[   99.050516] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
[   99.051818] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
[   99.056765] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
[   99.057870] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
[   99.059311] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
[   99.060580] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
[   99.061419] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
[   99.062269] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
[   99.063254] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
knlGS:0000000000000000
[   99.064734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.065649] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
[   99.066599] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   99.067627] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   99.068726] Call Trace:
[   99.069106]  <TASK>
[   99.069442]  ? __die_body.cold+0x19/0x29
[   99.069862]  ? die_addr+0x41/0x70
[   99.070222]  ? exc_general_protection+0x13f/0x210
[   99.071005]  ? asm_exc_general_protection+0x26/0x30
[   99.071809]  ? __pfx_irq_sim_request_resources+0x10/0x10
[   99.072639]  ? kasan_save_stack+0x30/0x50
[   99.073263]  ? __x86_indirect_thunk_r13+0xa/0x20
[   99.074055]  ? irq_sim_request_resources+0xf3/0x160
[   99.074871]  ? setup_irq_thread+0xfa/0x180
[   99.075576]  ? __setup_irq+0x747/0x1a20
[   99.076207]  ? kasan_save_track+0x14/0x30
[   99.077482]  ? request_threaded_irq+0x20b/0x350
[   99.077954]  ? __pfx_iio_simple_dummy_event_handler+0x10/0x10 [iio_dummy]
[   99.078647]  ? iio_simple_dummy_events_register+0x104/0x1a0 [iio_dummy]
[   99.079356]  ? kstrdup+0x8b/0xb0
[   99.079991]  ? iio_dummy_probe+0x3d7/0x5c0 [iio_dummy]
[   99.080761]  ? iio_sw_device_create+0x137/0x230
[   99.081447]  ? __pfx_device_make_group+0x10/0x10
[   99.082234]  ? device_make_group+0x33/0x80
[   99.083106]  ? configfs_mkdir+0x449/0xdf0
[   99.083836]  ? vfs_mkdir+0x452/0x760
[   99.084457]  ? do_mkdirat+0x17b/0x330
[   99.085022]  ? __pfx_do_mkdirat+0x10/0x10
[   99.085543]  ? strncpy_from_user+0x129/0x210
[   99.085998]  ? __x64_sys_mkdir+0xe6/0x130
[   99.086506]  ? do_syscall_64+0x9e/0x1a0
[   99.087118]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   99.087936]  </TASK>
[   99.088323] Modules linked in: iio_dummy iio_dummy_evgen
[   99.088949] ---[ end trace 0000000000000000 ]---
[   99.089526] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
[   99.090194] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 90
66 66 2e 0f 1f 84 00 00 00 00 00 0f 0
[   99.093617] RSP: 0018:ffff8880035a7bd0 EFLAGS: 00010246
[   99.094379] RAX: dffffc0000000000 RBX: ffff888008687828 RCX: 1ffff11000725946
[   99.095596] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888008686000
[   99.097176] RBP: ffff88800392ca00 R08: 0000000000000001 R09: ffffed10006b4f78
[   99.098109] R10: ffff8880035a7bc7 R11: ffffffff8ca58570 R12: 0000000000000000
[   99.098893] R13: 65645f7974743a72 R14: ffffffff8c5e5420 R15: ffff888008687870
[   99.101368] FS:  00007fe43adc2400(0000) GS:ffff88806d300000(0000)
knlGS:0000000000000000
[   99.102606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.105567] CR2: 000056088dfb66c0 CR3: 0000000001fc2000 CR4: 00000000000006f0
[   99.107410] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   99.108835] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Segmentation fault

Any help or guidance would be appreciated

I'm planning to apply for GSOC but I think it's already late. Should I
try writing a proposal?

Thank you,
Waseem

