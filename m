Return-Path: <linux-iio+bounces-3501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C921387B446
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0B280EC5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F059B4A;
	Wed, 13 Mar 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4wicIDc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635F59B42
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368072; cv=none; b=sfIkEb06nWvsJt1ypvo8IdIskbEeu5X+0jNSn/R6NT2319CL3VET3zxcg2JFLqo+AHKiP1pBbgBtsw9/S5k4Zx0Ww6OYK0WBV1U/WIOKw0Bj7x/gNxyt8AA2CuCT/ZPil3FKtesB5338JMs23JRlYlGDXPsoQitQFKEFvh78CXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368072; c=relaxed/simple;
	bh=dqDjb5730wS/5D/MVxGajrKC73K5hSJNRQSxZmSpUPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Heo1PHV+HZyJTlthPfCefILt1IPbJBmMBCAWdq+9FBMnebmvcqBb9b+kOWyeUp9pzDeC/W+Txl1bjzQLkckZZ8Lqc2xAIwoxpXFSR7MqY04EzGywcZ4Y4QcqEH6SN/blwS6oSGzRxgpg1D/OVmcd4jkpDsf7y2f9aQG8FN/Ll2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4wicIDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9A4C433C7
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710368071;
	bh=dqDjb5730wS/5D/MVxGajrKC73K5hSJNRQSxZmSpUPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s4wicIDcfiUhx4UyqQxUiv1LURN7wvptuePcLgKjKlN9S5JV+cJgO+Kelt0uCwBJg
	 UladwMSV9DAAgKQEL813GC3dUU2ocYet01saKWcCctaCE63PchG1/npWj3b5EP957V
	 zJxWs9daNoP+PF4fs76w4Ig0rDnvYXARVxKDBhVj53IpsK6OEuQsX78nML5qM03XVj
	 5k8ghjzBAshoxjApJSVwA/UTq1b+tLfsaLbcuEUMxPYZ6IzVYv++sgZmXoXVY/rG4i
	 yMNW7gkGiNeqHlYCWYF1f2/jZn8cBWN/gZM118WrJK8ALnSAAsKmYbdptpufYDqayM
	 a02vHVZMWuMhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A00A9C4332E; Wed, 13 Mar 2024 22:14:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 13 Mar 2024 22:14:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-hVAmpoGAio@https.bugzilla.kernel.org/>
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

--- Comment #7 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

Thanks for your response as well, and my apologies for the delay, I wanted =
to
do a bit of further testing.

It hadn't specifically occurred to me that rebooting from Windows might be
causing an issue.  I'm aware that Windows by default does save some state d=
ata
for a faster boot, but I didn't think any of this would make any difference=
 in
a normal reboot once you hit GRUB and select your Linux installation.

Regardless, it does seem like making sure to do a cold boot every time has
resulted in the accelerometer working a bit more reliably.  However, before=
, I
was even rebooting from Fedora back into Fedora and still having trouble wi=
th
it, so I don't think it's specifically Windows causing the symptoms either.=
=20
Not sure what to make of it yet...

In any case here are your requested details:

The path you specified did exist:
i2c-MXC6655:00 ->
../../../devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-MXC6655=
:00

# cat /sys/bus/i2c/devices/i2c-MXC6655\:00/firmware_node/path=20
\_SB_.PCI0.I2C0.ACC0

I'm attaching the dmesg and acpidump.  These are from a persistent Fedora
install which was updated to 6.7.7-200.fc39.x86_64.

Thanks!
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

