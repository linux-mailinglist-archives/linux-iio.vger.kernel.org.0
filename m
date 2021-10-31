Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A642B440DF4
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhJaL3Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 07:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhJaL3Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Oct 2021 07:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 426EC60F56
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635679613;
        bh=EYwfm2XiBi79h4vDv/NECV0XFOtjcqPzRcHejbNEi3c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h3a/MWb7wVBZuWQrfHg5KiUQN71c9UWZeR7UAc7qTMrxRArrTro5Czc/58md877of
         5jHsy1qnpFYre7FSZnaX2Z9M0qEdj+3srFx/Yg05oqvIsBjRj4Sxm3rbKRhWvqWgzv
         ma2QTFp5V6RSNZRMTlQgoSKelzRcGTPipoDXhpogE2wgUmmHzdZBc9YbErIuhLGZJk
         SEf+A2GbYU5h4tL0pXKefClJVEzNDVNp369HQdmZBXQBZlccA32g9sHgwcKtuSJG+i
         FvP91AIDn62KSwGUB9edm4EY+lMxaRqz07lKBaaSezlqnacnQF0/z1BDJcdaA/Hpgf
         qz9p9q1EM1AHQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3DF6C60F46; Sun, 31 Oct 2021 11:26:53 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Sun, 31 Oct 2021 11:26:53 +0000
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
Message-ID: <bug-214751-217253-9XJGwbh8tC@https.bugzilla.kernel.org/>
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

--- Comment #3 from waleed (waownn@gmail.com) ---
sudo lspci
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Process=
or
Host Bridge/DRAM Registers (rev 08)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (rev =
07)
00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-=
1500
v5/6th Gen Core Processor Thermal Subsystem (rev 08)
00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI
Controller (rev 21)
00:14.1 USB controller: Intel Corporation Device 9d30 (rev 21)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP
Thermal subsystem (rev 21)
00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO I2C Controller #0 (rev 21)
00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO I2C Controller #1 (rev 21)
00:15.2 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO I2C Controller #2 (rev 21)
00:15.3 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO I2C Controller #3 (rev 21)
00:19.0 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO UART Controller #2 (rev 21)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #4
(rev f1)
00:1e.0 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO UART Controller #0 (rev 21)
00:1e.2 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO SPI Controller #0 (rev 21)
00:1e.3 Signal processing controller: Intel Corporation Sunrise Point-LP Se=
rial
IO SPI Controller #1 (rev 21)
00:1e.4 SD Host controller: Intel Corporation Device 9d2b (rev 21)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC Controller/eSPI
Controller (rev 21)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
00:1f.3 Multimedia audio controller: Intel Corporation Sunrise Point-LP HD
Audio (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
00:1f.5 Non-VGA unclassified device: Intel Corporation Device 9d24 (rev 21)
01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 61)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
