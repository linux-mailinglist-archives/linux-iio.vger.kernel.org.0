Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271F9440DF3
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 12:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhJaL2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 07:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhJaL2r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Oct 2021 07:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 53E6160EB8
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635679576;
        bh=Rl/rbukqOCXnKkgTOy7gMjQ+fwqr+sPPIQ2SFZ3V054=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GvXQ2+sCV6kR59Bu4K82r4OssNft6GlYSY0JCN5fPgpwqnKcP4RVoNS8Aol6V4D8N
         0MdeyjyBKpSCn1KH2eamP+QReIulgJiF4Nr9lI3mY2A4p4iUpAVk+TuZrcghEhuEf3
         TLoVbVRWZiVqtQBjBSw7s9RPJsSdCsNJILurnIjsLU+DMI7rFD36UvHLTJGRjsUvkP
         BlBybs6xzkBhyLoqolVbO3pDoCuWDLTKcHjFV4+Yy5saUgLBnrp+rfHPk/mSehwot7
         kdq1dIfKokFM7GxUCREVOrON4+tBeq6DFYS5tB8adqQtFAY6m9EJz79VLPloDHjJid
         X5QVptA5gZwDA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4320B60F46; Sun, 31 Oct 2021 11:26:16 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Sun, 31 Oct 2021 11:26:16 +0000
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
Message-ID: <bug-214751-217253-g3tkLE0PfY@https.bugzilla.kernel.org/>
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

--- Comment #2 from waleed (waownn@gmail.com) ---
dmesg|grep -i erro
[    1.590029] RAS: Correctable Errors collector initialized.
[    8.579619] snd_soc_skl 0000:00:1f.3: Direct firmware load for
9d71-GOOGLE-NAMIMAX-0-tplg.bin failed with error -2
[    8.580027] snd_soc_skl 0000:00:1f.3: Direct firmware load for
kbl_da7219_mx98357a-tplg.bin failed with error -2
[    8.580073] snd_soc_skl 0000:00:1f.3: Direct firmware load for dfw_sst.b=
in
failed with error -2
[    8.580244] snd_soc_skl 0000:00:1f.3: ASoC: error at snd_soc_component_p=
robe
on 0000:00:1f.3: -2
[    8.580799] kbl_da7219_max98357a: probe of kbl_da7219_mx98357a failed wi=
th
error -2
[   11.635022] i2c_hid_acpi: probe of i2c-SYTS7817:00 failed with error -121
[  951.669182] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pi=
pe A
(start=3D50827 end=3D50828) time 147 us, min 2146, max 2159, scanline start=
 2143,
end 2163
[ 4908.274566] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[ 4908.274589] pcieport 0000:00:1c.0: PCIe Bus Error: severity=3DCorrected,
type=3DPhysical Layer, (Receiver ID)
[ 4908.274595] pcieport 0000:00:1c.0:   device [8086:9d13] error
status/mask=3D00000001/00002000
[ 5776.242671] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[ 5776.242699] pcieport 0000:00:1c.0: PCIe Bus Error: severity=3DCorrected,
type=3DPhysical Layer, (Receiver ID)
[ 5776.242706] pcieport 0000:00:1c.0:   device [8086:9d13] error
status/mask=3D00000001/00002000
[ 6457.144925] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[ 6457.144956] pcieport 0000:00:1c.0: PCIe Bus Error: severity=3DCorrected,
type=3DPhysical Layer, (Receiver ID)
[ 6457.144962] pcieport 0000:00:1c.0:   device [8086:9d13] error
status/mask=3D00000001/00002000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
