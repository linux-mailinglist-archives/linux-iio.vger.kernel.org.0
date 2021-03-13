Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610EA339D2B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCMJOF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 04:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhCMJNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Mar 2021 04:13:49 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1AC061574
        for <linux-iio@vger.kernel.org>; Sat, 13 Mar 2021 01:13:49 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id g27so28356669iox.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Mar 2021 01:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoTECqJgvXU+I8kchkWR8b/ZeK18657gI5ErXzdEJTw=;
        b=QsMaI2wPwVvp/KhtDeyMr1Pxqh8/XD/wwx1BVLOnJnwjXRFMvu6rMwG/n+Lp7ZgOnl
         CH8iLVLyBTwnU3bDhoZVzKowo5niC928sIuU2+uu1F5v8FLAXosMjPKEtb0oGqM6V7Uk
         fvO2Kwbufhp6aXLEcE5b4V5bfkUnoKST6U7kPLZKf5+yd30gTDgvGWRYDCRZZVo4KUGm
         aYBQmiw9uWrL5sTLooxq/OAKSIfyUSZZ21QyqmDnItd9byB5ZTLczOhf2eN+C5r0dwyG
         tlT82hhFfWmjhUguybO2NBN/VulzUoOm7CDpEpMZkTlgTOVENDfVKvw7dC8KIAmaBQf6
         vghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoTECqJgvXU+I8kchkWR8b/ZeK18657gI5ErXzdEJTw=;
        b=N7Vag1W/f+B7u57HJq62GFumU3dBjRg07o09hdSiAky58Kzuzw9vxE7Dgn+puZKijT
         kZ7R/GW1AL7TkTxDdEv9ag1me722hpAX9lEf7Shbrvyygz2ivP5d4Fr2c7nzgzm+uzwj
         W/6mYe8dpsVxJRSuuZ0NXUoDPA9zNhu88LNu0/tIya43Ekc4u1YHeWYR2dzyLEJT7ydX
         8k04VykaQn8ezd/3qfSqJIAfVjqtynRNB9dtEslAAax1SIDqWzJMLxTunA8uW3ukPou8
         3Em9Muyfs2hxkQIA0bI2NSl+JvgSJTgFAyEBtT8hzXfFQXi2U2DOHvxBO/EgD5MCCP0w
         9YnA==
X-Gm-Message-State: AOAM530lj0ayI2FpF2bheCd0/I2xUGb6OVNa78eRY1wnZ2DzpsEnK9ke
        9BT/FbbWWlAEoFNCJwyW7GV4hQ8kPH0aHHptwybHosk6VuGrbw==
X-Google-Smtp-Source: ABdhPJzSwf6rMcBZbvvLpnxp4QemN1NwHxJ9973tXlwmEKm0CZTdqX0PMZhbEdUM9TpANIzopAJQCbllMZZ2JnCfjYQ=
X-Received: by 2002:a6b:7c4a:: with SMTP id b10mr2219196ioq.170.1615626828569;
 Sat, 13 Mar 2021 01:13:48 -0800 (PST)
MIME-Version: 1.0
References: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
In-Reply-To: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 13 Mar 2021 11:13:36 +0200
Message-ID: <CA+U=DsoLPkx8KpLuJRQv1gvmuuOspMgSE09wttf+OpRHZmAZ5w@mail.gmail.com>
Subject: Re: IIO advise + help
To:     Michel Arruat <michel.arruat@cern.ch>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 12, 2021 at 6:55 PM Michel Arruat <michel.arruat@cern.ch> wrote:
>
> Dear IIO Maintainers,
>
> I'm starting studying IIO framework in order to migrate our acquisition
> systems, based on fast ADC, to this framework.
> So far we are using our framework named ZIO which was developed more
> than 10 years ago, when IIO was not mature enough to handle high speed
> constraints, large DMA transfer(>256MB) and zero copy.
> Out of curiosity https://ohwr.org/project/zio
>
> The idea is to get rid of our local framework and move to IIO to benefit
> from the large Users community.
> For now, most of our drivers are running on x86_64 architecture, even if
> future applications will run on SoC (Zynq UltraScale+).
> I made a first prototype, widely inspired from your "ad_adc.c" driver

The ad_adc.c driver looks like it was pulled from the Analog Devices
Linux repo here:
https://github.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad_adc.c

That driver [particularly] was not upstreamed.
But that driver is a [simplified] duplicate of the same FPGA ADC that ADI does:
https://github.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/cf_axi_adc_core.c

An upstreamed variant was upstreamed in 5.7:
https://github.com/torvalds/linux/blob/master/drivers/iio/adc/adi-axi-adc.c
It should not be too difficult to backport it on a 4.18 kernel.

This driver however doesn't work standalone yet, though there was a
plan to make it standalone at some point.
It is meant to be a wrapper driver for this high-speed ADC:
https://github.com/torvalds/linux/blob/master/drivers/iio/adc/ad9467.c

This works reasonably well, but there is still some work required to
finish upstreaming some high-speed DMA stuff that are only present in
the ADI repo.
The upstream version will not be compatible with the one in the ADI
repo [unfortunately], though it may be similar.

So, I'd start with the adi-axi-adc.c driver, and maybe make a
standalone variant.
It mostly involves removing the adi_axi_adc_attach_client() and
putting registers where needed, extending read_raw/write_raw hooks and
other stuff.

> found on your git repo, with a 4.18 kernel. I am facing some issues
> including kernel Oops while unloading the module.
> Could you please let me know which minimal kernel version is required to
> use the "IIO DMA engine buffer" features. In addition, I would really

The oops looks like is happening on the remove() hook of the driver.
Looks like you are trying a rmmod that is failing.

Not to bash anyone [this is more of a fact], but a lot of non-upstream
drivers don't handle the remove/unload part of the driver too well.
Mostly because a driver gets loaded at boot time, and then the system
reboots completely.
But kmods can be a hassle during development.

So, maybe try the adi-axi-adc.c variant, or you could cleanup the
remove hook of the ad_adc.c driver.
Or if you want, you could also open a question here for ad_adc.c:
https://ez.analog.com/linux-software-drivers/f/q-a

> appreciate if you could point me to some reference IIO ADC driver
> implementation that handles similar DMA transfer size with good
> performances.

I don't know about good performances. Or how comparable it would be to ZIO.
But the ADI kernel repo has some high-speed/mmap IIO interface.
We're in the process of getting it upstreamed [somehow].
The ADI kernel implementation also has a userspace library that can be
used to interface with the kernel part:
https://github.com/analogdevicesinc/libiio
https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51

>
> Thanks in advance for your answer.
> Best regards,
> Michel Arruat.
>
> Oops:
> [ 1110.718286] Oops: 0000 [#1] SMP PTI
> [ 1110.759964] CPU: 5 PID: 155923 Comm: rmmod Kdump: loaded Tainted: P
>       W  OE    --------- -  - 4.18.0-193.28.1.el8_2.x86_64 #1
> [ 1110.900606] Hardware name: National Instruments NI PXIe-8861/NI
> PXIe-8861, BIOS 1.2.4f2 01/09/2020
> [ 1111.007906] RIP: 0010:kernfs_find_ns+0x17/0xc0
> [ 1111.061042] Code: c0 79 04 31 ff eb f4 89 c2 eb e3 0f 1f 84 00 00 00
> 00 00 0f 1f 44 00 00 41 55 48 85 d2 49 89 f5 41 54 0f 95 c1 55 48 89 d5
> 53 <0f> b7 47 70 66 83 e0 20 0f 95 c2 38 d1 75 52 48 8b 5f 48 48 89 ee
> [ 1111.286038] RSP: 0018:ffffa5b406e67d08 EFLAGS: 00010246
> [ 1111.348548] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [ 1111.433971] RDX: 0000000000000000 RSI: ffffffffb5ab1588 RDI:
> 0000000000000000
> [ 1111.519394] RBP: 0000000000000000 R08: ffffa5b406e67e18 R09:
> 0000000000000004
> [ 1111.604828] R10: 0000000000000000 R11: 0000000000000001 R12:
> 0000000000000000
> [ 1111.690250] R13: ffffffffb5ab1588 R14: ffff99f3c8c82ae0 R15:
> ffff99f435506390
> [ 1111.775673] FS:  00007f5690560740(0000) GS:ffff99f435b40000(0000)
> knlGS:0000000000000000
> [ 1111.872553] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1111.941310] CR2: 0000000000000070 CR3: 0000000248d1a002 CR4:
> 00000000003606e0
> [ 1112.026732] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1112.112156] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [ 1112.197596] Call Trace:
> [ 1112.226778]  kernfs_find_and_get_ns+0x2c/0x50
> [ 1112.278872]  sysfs_unmerge_group+0x18/0x60
> [ 1112.327843]  dpm_sysfs_remove+0x27/0x60
> [ 1112.373688]  device_del+0x85/0x380
> [ 1112.414323]  cdev_device_del+0x15/0x30
> [ 1112.459143]  iio_device_unregister+0x29/0x70 [industrialio]
> [ 1112.525821]  release_nodes+0x21d/0x270
> [ 1112.570626]  device_release_driver_internal+0xf4/0x1d0
> [ 1112.632094]  driver_detach+0x54/0x88
> [ 1112.674814]  bus_remove_driver+0x77/0xc9
> [ 1112.721704]  pci_unregister_driver+0x2d/0xb0
> [ 1112.772758]  __x64_sys_delete_module+0x139/0x280
> [ 1112.827977]  do_syscall_64+0x5b/0x1a0
>
>
>
>
>
