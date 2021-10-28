Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E843DD7B
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJ1JO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 05:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1JO2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 05:14:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D829610A0
        for <linux-iio@vger.kernel.org>; Thu, 28 Oct 2021 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635412322;
        bh=r+n4rbmqUS+HozgjsnTugOasqqBlCyq/lp92o9H9z0g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NqNB35sRaXZ5VAFxRJnFChhyxMbmVNtCB4TLNCESObfIJVb7UsxkXtEAAUKpSI7zB
         Rs9Ez+3/IZvU8CMNiG3zRvMxm+iS5SPWCHrUzF/SFe8Q4Fc1LG56QxQ5C0Q7BycxZp
         DIDN73eSHo4VhoocxMTS7evgYypaTAkQknVuZeg+swrLsQRSI3JGNIFq22MYFb0tcK
         q3c9KxUWApW5SG/9ZxLtAFp04HVHYzbHdtAa1Z2L3LwPBOiAb4QQKX4nqh9OMixUfv
         gEbzAYUKwXd+kjo4dK1UE6jG+8nBgcA+3d3i4gM+9nVq2km0P2FmhVT1exS29g4Mod
         hKi/jl3GHQVug==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 182D2610CD; Thu, 28 Oct 2021 09:12:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Thu, 28 Oct 2021 09:12:01 +0000
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
Message-ID: <bug-214751-217253-pSK4GjcWGk@https.bugzilla.kernel.org/>
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

--- Comment #1 from waleed (waownn@gmail.com) ---
dmesg | grep -i failed
[    7.539736] i2c_hid_acpi i2c-SYTS7817:00: failed to change power setting.
[    7.662541] raydium_ts i2c-RAYD0001:00: failed to get reset gpio: -16
[    7.794229] raydium_ts: probe of i2c-RAYD0001:00 failed with error -16
[    8.121999] iwlwifi 0000:01:00.0: pci_enable_msi failed - -22
[    8.562335] i2c_hid_acpi i2c-SYTS7817:00: failed to change power setting.
[    8.945729] thermal thermal_zone7: failed to read out thermal zone (-61)
[    9.018731] snd_soc_skl 0000:00:1f.3: Direct firmware load for
9d71-GOOGLE-NAMIMAX-0-tplg.bin failed with error -2
[    9.018735] snd_soc_skl 0000:00:1f.3: tplg fw 9d71-GOOGLE-NAMIMAX-0-tplg=
.bin
load failed with -2, trying alternative tplg name kbl_da7219_mx98357a-tplg.=
bin
[    9.018751] snd_soc_skl 0000:00:1f.3: Direct firmware load for
kbl_da7219_mx98357a-tplg.bin failed with error -2
[    9.018753] snd_soc_skl 0000:00:1f.3: tplg kbl_da7219_mx98357a-tplg.bin
failed with -2, falling back to dfw_sst.bin
[    9.018767] snd_soc_skl 0000:00:1f.3: Direct firmware load for dfw_sst.b=
in
failed with error -2
[    9.018768] snd_soc_skl 0000:00:1f.3: Fallback tplg fw dfw_sst.bin load
failed with -2
[    9.018804] snd_soc_skl 0000:00:1f.3: Failed to init topology!
[    9.018881] kbl_da7219_max98357a kbl_da7219_mx98357a: ASoC: failed to
instantiate card -2
[    9.019011] kbl_da7219_max98357a: probe of kbl_da7219_mx98357a failed wi=
th
error -2
[    9.586869] i2c_hid_acpi i2c-SYTS7817:00: failed to change power setting.
[   10.610851] i2c_hid_acpi i2c-SYTS7817:00: failed to change power setting.
[   11.634548] i2c_hid_acpi: probe of i2c-SYTS7817:00 failed with error -121

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
