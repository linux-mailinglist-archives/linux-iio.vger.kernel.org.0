Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE448116E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Dec 2021 10:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhL2Jv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 04:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhL2Jv6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 04:51:58 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAAFC061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 01:51:57 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id v14so18782298uau.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=AnfDVyJVKDScRfEFsJB+9knAraXNeCc8DQi6K59/RYk=;
        b=SPRCG1qBfPpuyGFgRckxYrXBX8GiewUbmINLUvW2utS3EMMzeg7DdoEVybFi++deCk
         TvQcybnC7EiFfAWjeiQcDvtw8cWtRfkSj9jrmsTiRWUJhhBAhbrtvIThupzkTmVra0Rd
         /iFwgYd2SFiDyQcQtwvko0Q/AVI02HexVLeHgkTVonAtc7voH6wALQOfHPlRQ2AVOyzD
         /AkYOMjD+GnlhvVqscJPxaq5MIDc/UDdgJqgrPh0EzSJb/bD68jSTELXbqRcuvFJfilV
         l3hfpRyF5s8qdiQcB3/6JwobS7dkUUPHZ47HG2jzzGtx7o1yK1Mn7UrXSC12kUFBLl4E
         9IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AnfDVyJVKDScRfEFsJB+9knAraXNeCc8DQi6K59/RYk=;
        b=zMP66bLYvv8aHIgm9upW3cjbiO/h8lAs5CbLuJwFTzSHyEgUYQiAgE0MPXZRbXhGfC
         +Wb6aXb4Gyx/nUKP/n5oJYrd6wwxfMGPRI9lWl4nshO8xUl3Yg2LyAT9V+vJf6YDdhUK
         CT2175A5VJUMtR5usvYgODGMER3mu4jftsxEHto8S2vVCq6VAX1+VCm/d5nEHQS0Obor
         uw3tqh1dlVbymHBJLW30bS4n9LI7M2TpeW4hJIesCli8/hRklIPfi4DiXyIn5jWJO4UW
         m1zdhBPumaMjUqstZT7e+VTkb4BtXSG+vwHN5zXPAJPGNSGtMqzOCN4ZDy/58ebw4aGa
         3NFA==
X-Gm-Message-State: AOAM533dS57mYjLuoiXNu5gZMk/r6gINccTh1cSF5L/ikldmLaktGqTU
        Wr0kS5SG8GxuxXPVTkftOAoUeSIwUs1lhDAiQpY=
X-Google-Smtp-Source: ABdhPJxTS9ItL3nGpBYce0Va+MB1K5+zCjQHIXnWebLmZxlAd0JoeGJ8iIjdLCM44hOuO04XwuKffj6nIyI9yNUzmMY=
X-Received: by 2002:a05:6102:903:: with SMTP id x3mr7992339vsh.41.1640771516725;
 Wed, 29 Dec 2021 01:51:56 -0800 (PST)
MIME-Version: 1.0
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 29 Dec 2021 10:51:45 +0100
Message-ID: <CAN8YU5NSyqLrhX_SUYP3Jm1gqmNXgoZC2wKx-s=qnkL6bawN-Q@mail.gmail.com>
Subject: [Oops] IIO git tree since f73f7f4da5818 (iio: buffer: add ioctl() to
 support opening extra buffers for IIO device)
To:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

After rebasing my tree on latest iio git tree I got an Oops [0] on
rmmod of my wip driver, then I reproduced it also with iio-dummy
driver; this has been bisected to f73f7f4da5818 (iio: buffer: add
ioctl() to support opening extra buffers for IIO device).

To reproduce, you need  CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

Then:
root@localhost:/home/ubuntu# insmod iio_dummy.ko
root@localhost:/home/ubuntu# mkdir /sys/kernel/config/iio/devices/dummy/mydummy
root@localhost:/home/ubuntu# rmdir /sys/kernel/config/iio/devices/dummy/mydummy
Segmentation fault

I'm not familiar with IIO internals design, so I've gathered some
clues (right below) and I'm just reporting this :)

My suspect is about a doubled list_del() on the buffer ioctl handler:
iio_device_unregister() loops on iio_dev_opaque->ioctl_handlers and
deletes all elements, then it calls also
iio_buffers_free_sysfs_and_mask() which in turn tries to unregister
the buffer ioctl handler causing list_del() to be invoked again. Here
the element being deleted has LIST_POISON1 and LIST_POISON2 as its
next and prev ptrs.

Commenting out any of the two list deletions avoids the Oops and makes
things apparently work again.

Thanks,
Andrea

[0]
[  234.343644] 8<--- cut here ---
[  234.346832] Unable to handle kernel NULL pointer dereference at
virtual address 00000104
[  234.355016] pgd = (ptrval)
[  234.357763] [00000104] *pgd=3bc6c831
[  234.361302] Internal error: Oops: 817 [#1] SMP ARM
[  234.366131] Modules linked in: iio_dummy industrialio_sw_device
[last unloaded: iio_dummy]
[  234.374425] CPU: 0 PID: 410 Comm: rmdir Not tainted 5.13.0-rc1+ #25
[  234.380692] Hardware name: Xilinx Zynq Platform
[  234.385153] PC is at iio_device_ioctl_handler_unregister+0x24/0x38
[  234.391401] LR is at iio_buffers_free_sysfs_and_mask+0x2c/0x78
[  234.397226] pc : [<c08c5ec8>]    lr : [<c08cac38>]    psr: 20070013
[  234.403419] sp : c3283e10  ip : 00000100  fp : c3283e1c
[  234.408636] r10: 00000000  r9 : c283bc00  r8 : c2d8abb0
[  234.413907] r7 : 00000100  r6 : c28d1800  r5 : c28d1800  r4 : c28d1a10
[  234.420451] r3 : 00000122  r2 : 00000100  r1 : 00000122  r0 : c2311e80
[  234.426976] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  234.434127] Control: 18c5387d  Table: 0328404a  DAC: 00000051
[  234.439860] Register r0 information: slab kmalloc-64 start c2311e80
pointer offset 0 size 64
[  234.448338] Register r1 information: non-paged memory
[  234.453389] Register r2 information: non-paged memory
[  234.458439] Register r3 information: non-paged memory
[  234.463490] Register r4 information: slab kmalloc-1k start c28d1800
pointer offset 528 size 1024
[  234.472319] Register r5 information: slab kmalloc-1k start c28d1800
pointer offset 0 size 1024
[  234.480963] Register r6 information: slab kmalloc-1k start c28d1800
pointer offset 0 size 1024
[  234.489608] Register r7 information: non-paged memory
[  234.494677] Register r8 information: slab dentry start c2d8abb0
pointer offset 0 size 36
[  234.502805] Register r9 information: slab kmalloc-128 start
c283bc00 pointer offset 0 size 128
[  234.511450] Register r10 information: NULL pointer
[  234.516169] Register r11 information: non-slab/vmalloc memory
[  234.521901] Register r12 information: non-paged memory
[  234.527025] Process rmdir (pid: 410, stack limit = 0x(ptrval))
[  234.532924] Stack: (0xc3283e10 to 0xc3284000)
[  234.537292] 3e00:                                     c3283e3c
c3283e20 c08cac38 c08c5eb0
[  234.545476] 3e20: c28d1a10 c28d1800 00000122 00000100 c3283e5c
c3283e40 c08c4a08 c08cac18
[  234.553678] 3e40: c28d1800 bf002040 c11fec04 c2318bc0 c3283e74
c3283e60 bf000020 c08c4964
[  234.561862] 3e60: bf002000 bf002040 c3283e8c c3283e78 bf008024
bf00000c c283be08 bf002040
[  234.570064] 3e80: c3283ea4 c3283e90 bf008050 bf00800c c283be08
bf002040 c3283eb4 c3283ea8
[  234.578248] 3ea0: c0387de0 bf00803c c3283efc c3283eb8 c0388a34
c0387dac c2c26178 00000000
[  234.586451] 3ec0: c1104ec8 c11febb4 c3283efc 6e9cda98 c02ec2c8
c2d8abb0 c2c27be8 00000000
[  234.594634] 3ee0: c3283f50 ffffff9c c1104ec8 c3283f44 c3283f2c
c3283f00 c02ed64c c038882c
[  234.602763] 3f00: c02ed30c c02ed278 c15d6000 00000000 00000000
c15d6000 00000000 00000000
[  234.611002] 3f20: c3283f94 c3283f30 c02f18a4 c02ed5dc c3283f50
c3283f44 fffffe30 c2d8abb0
[  234.619186] 3f40: c1105584 00000000 c2430250 c2d8acc0 da1a2e65
00000007 c15d6035 b6f09000
[  234.627388] 3f60: c02f03a8 6e9cda98 00000001 00014d40 00026179
beecf7d9 00000028 c0100244
[  234.635572] 3f80: c3282000 00000028 c3283fa4 c3283f98 c02f1900
c02f1720 00000000 c3283fa8
[  234.643775] 3fa0: c0100060 c02f18e0 00014d40 00026179 beecf7d9
beecf694 00000000 00000001
[  234.651885] 3fc0: 00014d40 00026179 beecf7d9 00000028 00026168
0001497c 00014d54 00026174
[  234.660124] 3fe0: b6f11401 beecf4fc 00011183 b6f11406 00070030
beecf7d9 00000000 00000000
[  234.668308] Backtrace:
[  234.670759] [<c08c5ea4>] (iio_device_ioctl_handler_unregister) from
[<c08cac38>] (iio_buffers_free_sysfs_and_mask+0x2c/0x78)
[  234.682021] [<c08cac0c>] (iio_buffers_free_sysfs_and_mask) from
[<c08c4a08>] (iio_device_unregister+0xb0/0xb4)
[  234.692048]  r7:00000100 r6:00000122 r5:c28d1800 r4:c28d1a10
[  234.697707] [<c08c4958>] (iio_device_unregister) from [<bf000020>]
(iio_dummy_remove+0x20/0x40 [iio_dummy])
[  234.707421]  r7:c2318bc0 r6:c11fec04 r5:bf002040 r4:c28d1800
[  234.713135] [<bf000000>] (iio_dummy_remove [iio_dummy]) from
[<bf008024>] (iio_sw_device_destroy+0x24/0x30
[industrialio_sw_device])
[  234.725097]  r5:bf002040 r4:bf002000
[  234.728581] [<bf008000>] (iio_sw_device_destroy
[industrialio_sw_device]) from [<bf008050>]
(device_drop_group+0x20/0x2c [industrialio_sw_device])
[  234.741705]  r5:bf002040 r4:c283be08
[  234.745336] [<bf008030>] (device_drop_group
[industrialio_sw_device]) from [<c0387de0>]
(client_drop_item+0x40/0x54)
[  234.755897]  r5:bf002040 r4:c283be08
[  234.759473] [<c0387da0>] (client_drop_item) from [<c0388a34>]
(configfs_rmdir+0x214/0x300)
[  234.767768] [<c0388820>] (configfs_rmdir) from [<c02ed64c>]
(vfs_rmdir+0x7c/0x1b4)
[  234.775380]  r10:c3283f44 r9:c1104ec8 r8:ffffff9c r7:c3283f50
r6:00000000 r5:c2c27be8
[  234.783140]  r4:c2d8abb0
[  234.785721] [<c02ed5d0>] (vfs_rmdir) from [<c02f18a4>] (do_rmdir+0x190/0x1c0)
[  234.792872]  r6:00000000 r5:00000000 r4:c15d6000
[  234.797499] [<c02f1714>] (do_rmdir) from [<c02f1900>] (sys_rmdir+0x2c/0x30)
[  234.804411]  r10:00000028 r9:c3282000 r8:c0100244 r7:00000028
r6:beecf7d9 r5:00026179
[  234.812300]  r4:00014d40
[  234.814825] [<c02f18d4>] (sys_rmdir) from [<c0100060>]
(ret_fast_syscall+0x0/0x2c)
[  234.822419] Exception stack(0xc3283fa8 to 0xc3283ff0)
[  234.827488] 3fa0:                   00014d40 00026179 beecf7d9
beecf694 00000000 00000001
[  234.835598] 3fc0: 00014d40 00026179 beecf7d9 00000028 00026168
0001497c 00014d54 00026174
[  234.843837] 3fe0: b6f11401 beecf4fc 00011183 b6f11406
[  234.848888] Code: e5903004 e5902000 e3a0cc01 e3001122 (e5823004)
[  234.855062] ---[ end trace 0d5ead677fab1719 ]---
