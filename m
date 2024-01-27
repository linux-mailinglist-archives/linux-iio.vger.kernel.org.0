Return-Path: <linux-iio+bounces-1936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067483ED3E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3758B1F21D7F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542325603;
	Sat, 27 Jan 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEw4f84s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC1200C0
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361466; cv=none; b=F9VCp/X3eiIDacX6GXQ/1qs1X4ceOSqnGSkiUGs/eZLr9FvsXeX7mQIJSdDGQ1OeejDVX3tRCdJtXzNhAS77X51ComW7BMCVRefgbHnw6/JMGNF60l2z5kzPFY2gAVpcygZpYFnqEZ+ktVy2ogaq868ODooZ1CHfyBBJ0Q3fW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361466; c=relaxed/simple;
	bh=5dJ2hAHEuJo5lJEEVnIkgOcUcSaufelRfqKe5PR4S5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhOJdkEXKcwQFpHSjXPyp/Xb6i08k79eW69aPCtIJkQXfA+TRG2aB25ddI6dJ7ZWvJ7IgSlJdRn8pM6pUU8jZSyn+iWGr4QL3mYN7uQI2UAKnxygrj5iuZiV3FbVQkklQNt86bIK045HUYi8aLhB4aTduMN7ZSl7vp6CbhMzb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEw4f84s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4095CC433C7
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706361466;
	bh=5dJ2hAHEuJo5lJEEVnIkgOcUcSaufelRfqKe5PR4S5s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SEw4f84sxEmARYXpLn4+rTVW7cn4EEw5hXeolk4gDpj6ZObO6Y4rzLecP3lELedRa
	 Oqt/gmeX87n3f9bSMJV2CBCpjPhFHT44nc+zvAf1VUvMxv3iZKdDC5CMn21uEcofdQ
	 n1BRw4HBkiKkF/cMn/2vbfe9ZETAFjmqpJZ028xO440FirGL7BdH9YRBBzrLe2Y48u
	 PZzBr5INB3bDbJ2iSVE00iwsus30dLKr2gFz4wHGoczbGTS8De7DH6SlrWLz5JDrPU
	 5Nq8MewdjGRDjZ+rwZrpCaCzJJsLFtFLHEYF1laCme2pf8jzALQc7kp8mOY8OvGFn8
	 hLrSyj9ZywOrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 205AAC4332E; Sat, 27 Jan 2024 13:17:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date: Sat, 27 Jan 2024 13:17:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: I2C
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: freedman.joshua@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214751-217253-HyJWqkQEzi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214751-217253@https.bugzilla.kernel.org/>
References: <bug-214751-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D214751

Josh (freedman.joshua@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |freedman.joshua@gmail.com

--- Comment #5 from Josh (freedman.joshua@gmail.com) ---
On opening of laptop during hibernation, everything restores and you can lo=
gin,
but sound never works.  I have to reboot.  9d71-LENOVO-CB-01-1-tplg.bin mig=
ht
be missing? as per dmesg?

dmesg failed
[87007.094848] snd_soc_skl 0000:00:1f.3: Transfer firmware failed-5
[87007.096696] snd_soc_skl 0000:00:1f.3: PM: failed to resume: error -5
[87007.413141] snd_soc_skl 0000:00:1f.3: ASoC: PRE_PMU: media0_in cpr 0 eve=
nt
failed: -110
[87007.733394] snd_soc_skl 0000:00:1f.3: ASoC: PRE_PMU: codec0_out mo event
failed: -110
[87082.208709] snd_soc_skl 0000:00:1f.3: ASoC: POST_PMD: codec0_out mo event
failed: -22
[87082.208743] snd_soc_skl 0000:00:1f.3: ASoC: POST_PMD: media0_in cpr 0 ev=
ent
failed: -22
[87135.219499] snd_soc_skl 0000:00:1f.3: ASoC: PRE_PMU: media0_in cpr 0 eve=
nt
failed: -110
[87135.539506] snd_soc_skl 0000:00:1f.3: ASoC: PRE_PMU: codec0_out mo event
failed: -110
[87135.550200]  Analog HDA DSP: ASoC: trigger FE cmd: 1 failed: -32
[87135.550224]  Analog HDA DSP: ASoC: trigger FE cmd: 0 failed: -32
[87135.562979]  Analog HDA DSP: ASoC: trigger FE cmd: 1 failed: -32
[87135.563000]  Analog HDA DSP: ASoC: trigge

dmesg error
[56950.019148] ath10k_pci 0000:6b:00.0:   device [168c:003e] error
status/mask=3D00000081/00006000
[87007.096696] snd_soc_skl 0000:00:1f.3: PM: failed to resume: error -5
[87061.478614] pcieport 0000:00:1c.4: AER: Multiple Corrected error receive=
d:
0000:6b:00.0
[87061.478716] ath10k_pci 0000:6b:00.0:   device [168c:003e] error
status/mask=3D00000080/00006000
[87135.550179] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.550215] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.562960] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.562991] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.584317] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.584352] snd_soc_skl 0000:00:1f.3: ASoC: error at soc_dai_trigger on
hda-dsp-analog-dai: -32
[87135.605942] snd_soc_skl 0000:00:1f.3: ASoC: err

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

