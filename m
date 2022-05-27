Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0C5365B8
	for <lists+linux-iio@lfdr.de>; Fri, 27 May 2022 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353800AbiE0QIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 May 2022 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349472AbiE0QIn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2022 12:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE61498D5
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 09:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A1161DCF
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 357BEC385A9
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667721;
        bh=Y2k/TCidYGU6zQQI0BlAf5ErlaM3biAWh5vxyPivEdM=;
        h=From:To:Subject:Date:From;
        b=q1Ygp1uRqIK9Zr+ALmKKGS72H++ogkASC93jBPZqyuZB6FSAIPyQmQzf4MdrqUIRx
         5iWrOEKQfpj5tmp2SutiEMQadGYWXMH3nDG6ob1d6b4uT7tO4IYYWOGpcHoxnIsA5K
         VbJ96Y9521WPTzvEiGQEl1wZhn0kINgB4igB7M4D18CCf3/WesUukC8HBoFS7Tw+5T
         nv1c0FNUuHgpym4wAPE3I7jufU9kqzl3uEOPP881DOhI4jl3Hl12frt5t5Zj1kpCJc
         uQ/QFGwbjAt2sGrMXj+OZd2HCtuY/OxFZlqpSNcR1z65iDekyfqz/KM9IvmTeR7pGG
         38Jjk1Ux9mw6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 14B2CC05FD5; Fri, 27 May 2022 16:08:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 216037] New: Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date:   Fri, 27 May 2022 16:08:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickel@altlinux.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216037-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

            Bug ID: 216037
           Summary: Second MXC6655 accelerometer is not detected on
                    transformer Aquarius NS483 laptop
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17.11
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: nickel@altlinux.org
        Regression: No

A couple of accelerometers are used to detect the hinge angle in convertible
laptops(one for display, one for base/keyboard).

A discussion on the topic is available at [1]

But in my case while DSDT describes two I2C devices (if I interpret it righ=
t):

>Device (ACMG)
>        {
>            Name (_ADR, Zero)  // _ADR: Address
>            Name (_HID, "MXC6655")  // _HID: Hardware ID
>            Name (_CID, "MXC6655")  // _CID: Compatible ID
>            Name (_DDN, "Accelerometer with Angle Calculation")  // _DDN: =
DOS
>            Device Name
>            Name (_UID, One)  // _UID: Unique ID
>            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
>            Settings
>            {
>                Name (RBUF, ResourceTemplate ()
>                {
>                    I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A8=
0,
>                        AddressingMode7Bit, "\\_SB.PC00.I2C1",
>                        0x00, ResourceConsumer, , Exclusive,
>                        )
>                    I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A8=
0,
>                        AddressingMode7Bit, "\\_SB.PC00.I2C2",
>                        0x00, ResourceConsumer, , Exclusive,
>                        )
>                })
>                Return (RBUF) /* \_SB_.PC00.I2C1.ACMG._CRS.RBUF */
>            }

only one of them is detected (display side one, up and running, by the way):

> P: /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-16/i2c-MXC6655:00
> L: 0
> E:
> DEVPATH=3D/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-16/i2c-MX=
C6655:00
> E: SUBSYSTEM=3Di2c
> E: DRIVER=3Dmxc4005
> E: MODALIAS=3Dacpi:MXC6655:MXC6655:
>
> P:
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-16/i2c-MXC6655:00/i=
io:device0
> N: iio:device0
> L: 0
> E:
> DEVPATH=3D/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-16/i2c-MX=
C6655:00/iio:device0
> E: SUBSYSTEM=3Diio
> E: DEVNAME=3D/dev/iio:device0
> E: DEVTYPE=3Diio_device
> E: MAJOR=3D238
> E: MINOR=3D0
> E: USEC_INITIALIZED=3D4954716
> E: IIO_SENSOR_PROXY_TYPE=3Diio-poll-accel iio-buffer-accel
> E: SYSTEMD_WANTS=3Diio-sensor-proxy.service
> E: TAGS=3D:systemd:
> E: CURRENT_TAGS=3D:systemd:

There should be 2 I2C devices with DRIVER=3Dmxc4005, shouldn't they?

Attaching detailed logs also.

[1] https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests=
/338

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
