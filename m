Return-Path: <linux-iio+bounces-3466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D2878753
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FF8B20C04
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7653E27;
	Mon, 11 Mar 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y47hQk8X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC053E22
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181796; cv=none; b=NTcDe/FOOVDe9+ngSzhELVBISK2ZTD89N9LpBNAalgBsE31AD6tS6JBzDI2MQ0Te0gtI/gmNtdf6xKUul0zzaNtv9X32iaL7Z7gA8j/L+0wqyYvpbu1YVpctLjjcPCPsWlYSWf2gSJLmidTxGkb7AtTgrFboxls4QFjm3J15WJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181796; c=relaxed/simple;
	bh=i/3GP0PpiNsvHjdPBd8lZFtMGUucMiPhWK635lnyVvA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je8viUf8tLKTmv59/c5EJsoIfPuTZjy6NqdK7o6nxSFLV0vCgxoTkTj/mHGEEYQNd0iOVAyEYzxwb9jX3BawBuU7//sunTZWU/r7kRWGsVKaFkxvVKuqixDnfJ03203okIKdbMJUwbZp7d0mm2TdbwBUkN4F6Z8BCTDx9IpLUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y47hQk8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47424C43390
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710181796;
	bh=i/3GP0PpiNsvHjdPBd8lZFtMGUucMiPhWK635lnyVvA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y47hQk8XkJWLxwTCjQDbVDhRaioTliUUMgvcselofx8QmPKbITRaaI0LlmZmVKOm4
	 7iNMiFh+K+CBvdVIifrlorcl85pe4LT0WPRGCD1b+c7tdCJTu7fb32D47bnA+yTa4W
	 eIEcLRezkW8Ko5QL0QSfncyleaG6Z90gUtHvg8Om7u4e+LoeWuRNNzQjG5rL+Z0L53
	 O6TsRZL7B/ihWQdFXvKWmI5BVXZ9qkFOoKyr0LY8Un20L2014leK4OV/LYuR5hO/Ui
	 wL25gpbF+xX4xhqHXzcA0F9g7jC8YTYwvMpmx0ZtAY/2KpGYf47OqT5tqiiNAGA7xU
	 CZJA7aQSRA+HA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2FF4EC53BD0; Mon, 11 Mar 2024 18:29:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Mon, 11 Mar 2024 18:29:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218578-217253-RZT2sBnTrr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218578-217253@https.bugzilla.kernel.org/>
References: <bug-218578-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218578

Hans de Goede (jwrdegoede@fedoraproject.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jwrdegoede@fedoraproject.or
                   |                            |g

--- Comment #4 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Kirk, Jonathan Cc-ed me on this bug since I've done a lot of work on
accelerometers on x86 tablets.

I notice you use the word "reboot(ed)" a lot in your last comment.

What happens if you power off the tablet and then power it back on again and
then directly start the livecd (presumably this is what you did during your
first test?).

This way the device is fully reset / in a clean hwstate when starting the
livecd.

Or reboot from a working Windows environment into the livecd ?  (maybe Wind=
ows
does something extra and rebooting keeps that state, combined with the live=
cd
because you have had the accelerometer work there before)

As for figuring out which DSDT node is actually the one used on your tablet.
Lets first focus on 1 single tablet (of your choosing) and ignore the other
tablet for now.

On the chosen tablet can you do:

ls -l /sys/bus/i2c/devices/

This should show a device for your accelerometer. E.g. "i2c-MXC6655:00" (but
maybe something else) please run:

cat /sys/bus/i2c/devices/i2c-MXC6655:00/firmware_node/path

replacing "i2c-MXC6655:00" with the actual accelerometer i2c-device and then
let us know the output.

Also please run:

sudo acpidump -o acpidump.txt
sudo dmesg > dmesg.txt

And attach both generated .txt files here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

