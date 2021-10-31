Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2734D440DF6
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 12:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJaLae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 07:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhJaLae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Oct 2021 07:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 851B660F59
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635679682;
        bh=XLbY9ePrF5ET1p5EeHJbDBy+6hrFPP3bGzN+abC8wmg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rdFKfGLC4/BT1k5oyRKQCpusNJhO/NXzNeuKWXmAaw99XLyxDl8//hgGUhz8u3ZHb
         fEtO1/JXBCKBhDJ+3KwyYy81k6DWbUK0enpEvaWLcm7JnSldRk/VJh/tqNkGnBmTm+
         a1oCGkuOei0eUShZD3m0nJpc4yVwU3tCvXAvp+0SsAA3ed8rWK8OKk7SArZTTYGw/h
         HjYAQcms/VECXlA6pne449kXUwH7rTUbY0rW+vokSHYu1AlFztqLVNPdhhCnC4yDRc
         J8JS/YqTR+rQ0K8xBGkkSZAXgtFWqXtgYqh/5on6cbSSSsBHlxNeep/bDOENqGfyso
         BmIVyyJI/zzTQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7B6A460F46; Sun, 31 Oct 2021 11:28:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Sun, 31 Oct 2021 11:28:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: I2C
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waownn@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214751-217253-p9GiQBQlk8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214751-217253@https.bugzilla.kernel.org/>
References: <bug-214751-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214751

--- Comment #4 from waleed (waownn@gmail.com) ---
sudo lshw -short
[sudo] password for root:=20
H/W path                 Device            Class          Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                                           system         Pantheon (sku1622=
7)
/0                                         bus            Pantheon
/0/0                                       memory         1MiB BIOS
/0/4                                       processor      Intel(R) Core(TM)
i7-8550U CPU @ 1.80GHz
/0/4/6                                     memory         128KiB L1 cache
/0/4/7                                     memory         1MiB L2 cache
/0/4/8                                     memory         8MiB L3 cache
/0/5                                       memory         128KiB L1 cache
/0/9                                       memory         16GiB System Memo=
ry
/0/9/0                                     memory         8GiB SODIMM DDR4
Synchronous 2400 MHz (0.4 ns)
/0/9/1                                     memory         8GiB SODIMM DDR4
Synchronous 2400 MHz (0.4 ns)
/0/100                                     bridge         Xeon E3-1200 v6/7=
th
Gen Core Processor Host Bridge/DRAM Regis
/0/100/2                 /dev/fb0          display        UHD Graphics 620
/0/100/4                                   generic        Xeon E3-1200
v5/E3-1500 v5/6th Gen Core Processor Thermal Sub
/0/100/14                                  bus            Sunrise Point-LP =
USB
3.0 xHCI Controller
/0/100/14/0              usb1              bus            xHCI Host Control=
ler
/0/100/14/0/5                              communication  Bluetooth wireless
interface
/0/100/14/0/7            input12           multimedia     Integrated Camera:
Integrated C
/0/100/14/1              usb2              bus            xHCI Host Control=
ler
/0/100/14/1/4            scsi0             storage        USB Storage
/0/100/14/1/4/0.0.0      /dev/sda          disk           256GB STORAGE DEV=
ICE
/0/100/14/1/4/0.0.0/0    /dev/sda          disk           256GB=20
/0/100/14/1/4/0.0.0/0/1  /dev/sda1         volume         93GiB EXT4 volume
/0/100/14/1/4/0.0.0/0/2  /dev/sda2         volume         145GiB EXT4 volume
/0/100/14.1                                bus            Intel Corporation
/0/100/14.2                                generic        Sunrise Point-LP
Thermal subsystem
/0/100/15                                  generic        Sunrise Point-LP
Serial IO I2C Controller #0
/0/100/15.1                                generic        Sunrise Point-LP
Serial IO I2C Controller #1
/0/100/15.2              input1            input          PRP0001:00
/0/100/15.3                                generic        Sunrise Point-LP
Serial IO I2C Controller #3
/0/100/19                                  generic        Sunrise Point-LP
Serial IO UART Controller #2
/0/100/1c                                  bridge         Sunrise Point-LP =
PCI
Express Root Port #4
/0/100/1c/0              wlp1s0            network        Wireless 7265
/0/100/1e                                  generic        Sunrise Point-LP
Serial IO UART Controller #0
/0/100/1e.2                                generic        Sunrise Point-LP
Serial IO SPI Controller #0
/0/100/1e.3                                generic        Sunrise Point-LP
Serial IO SPI Controller #1
/0/100/1e.4              mmc0              bus            Intel Corporation
/0/100/1e.4/1                              generic        DA4128
/0/100/1e.4/1/1          /dev/mmcblk0rpmb  generic=20=20=20=20=20=20=20=20
/0/100/1e.4/1/2          /dev/mmcblk0      generic=20=20=20=20=20=20=20=20
/0/100/1e.4/1/2/1                          volume         562MiB Windows FAT
volume
/0/100/1e.4/1/2/2        /dev/mmcblk0p2    volume         113GiB EFI partit=
ion
/0/100/1e.4/1/2/3        /dev/mmcblk0p3    volume         2GiB Linux swap
volume
/0/100/1f                                  bridge         Sunrise Point LPC
Controller/eSPI Controller
/0/100/1f/0                                system         PnP device PNP0c02
/0/100/1f/1                                system         PnP device PNP0103
/0/100/1f/2                                system         PnP device PNP0c02
/0/100/1f/3                                system         PnP device PNP0b00
/0/100/1f/4                                system         PnP device PNP0c02
/0/100/1f/5                                system         PnP device PNP0c02
/0/100/1f/6                                input          PnP device PNP0303
/0/100/1f/7              input6            input          Intel Virtual But=
tons
/0/100/1f.2                                memory         Memory controller
/0/100/1f.3                                multimedia     Sunrise Point-LP =
HD
Audio
/0/100/1f.4                                bus            Sunrise Point-LP
SMBus
/0/100/1f.5                                generic        Intel Corporation
/1                       input0            input          AT Translated Set=
 2
keyboard
/2                       input11           input          Synaptics TM3460-=
001
/3                       input13           input          JBL Go 3 (AVRCP)
/4                       input2            input          Video Bus
/5                       input3            input          Lid Switch
/6                       input4            input          Power Button
/7                       input5            input          Tablet Mode Switch
/8                       input8            input          PC Speaker

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
