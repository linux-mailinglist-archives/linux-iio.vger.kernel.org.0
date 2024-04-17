Return-Path: <linux-iio+bounces-4309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF208A897F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243A8B24774
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0D17108F;
	Wed, 17 Apr 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oui+M67N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350E171084
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373062; cv=none; b=Dk2CKkxeocKc5u4t+SlwTLKWJCU3lSEhoTlqtsiHpYFcUo9+aWNrAvqNXuvGVhGtepvYjlIgunYDcgWGps7rozJ8tCiiHNXatDZdpuk0NBANEJ93DZ2HY4DdL16w+A2cbdDEWyjadcjszWb10bWlggUZU5Xq5HXwtFjlsmAeNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373062; c=relaxed/simple;
	bh=FKqR+iLserS8Lwwezm9AmBtKimMKYuZgwbez4TU/juQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cS3UC7q/gar1418LfZMBl5vx2NPLe9CViokwH7IGrNDYJtYevPMBrlGBjLabIszSmrsOJ8qKpiCfnTXq+XF9zR0qAWRBYdNoQ5r08QItnraCLNwwGoSXo9wbTzBYyppsMlNZ8qmJrJ0Z6RNeWPA3A0uE9nKFo3rLJFo6DhVECPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oui+M67N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E781C072AA
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373062;
	bh=FKqR+iLserS8Lwwezm9AmBtKimMKYuZgwbez4TU/juQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oui+M67NO1yyIVFxjyHlneWqmAkT1GTu8lcb6ZqtEPvWWf5dSyVNsq9Lm4auE+ugr
	 WNfZHCFfDzT8/uXd7qx6QfL884HSL3Tgobq18cwW7fkK7WbLCFxPm2TGmy0PnOvHeQ
	 krYUqdenFobkLmRAl0CL/BZJ13JbaLa7J7IvE7cDcoviYladcEza47Ih/XY2EHiqwO
	 +q5/nS0+aauMhNFDtFhv4O0YHl7EAjRNvWVJU0rdH81/c6YKG8GiSTYZNfDmOEMJy8
	 QHkPn52o9nySUSzGi5aSdndmektFgirLjdFBdr4pelNooT2L6yrov3eJgNu/FJV5kF
	 ATBmZnFkB9Z+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 52168C433E2; Wed, 17 Apr 2024 16:57:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 17 Apr 2024 16:57:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-cfPWTduCx0@https.bugzilla.kernel.org/>
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

--- Comment #28 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
> I have attached an ACPI Dump as requested.

Thank you. First of all sorry for asking for one needlessly I now see there
already was one attached to this bug.

So the ACPI firmware node describing the MXC6655 does contain a ROTM method
like we have also seen on BOSC0200 and KIOX000A ACPI firmware nodes and that
does correctly describe the rotation matrix of the accelerometer if I compa=
re
it with your hwdb, the only thing which is different is that it inverts the=
 Z
axis, but that axis is not used for rotation so chances are that inverting =
it
is actually correct for apps which do care about it.

I have prepared a set of patches:
https://lore.kernel.org/linux-iio/20240417164616.74651-1-hdegoede@redhat.co=
m/

Which adds ROTM parsing to the mxc4005 driver. I have started a F39 kernel
build with the original set of fixes + these patches on top here:

https://koji.fedoraproject.org/koji/taskinfo?taskID=3D116515238

This is still building atm, this should complete building in a couple of ho=
urs.
Once this is done building please give this a test run. Here are some
instructions for directly installing a kernel from koji (Fedora's buildsyst=
em):
https://fedorapeople.org/~jwrdegoede/kernel-test-instructions.txt

If you don't have time to test the next couple of days, please at least
download the kernel rpms.

After booting this kernel you should be able to do:

cat /sys/bus/iio/devices/iio:device0/in_mount_matrix

(assuming iio:device0 is the accel)

And this should then show:

0, -1, 0; -1, 0, 0; 0, 0, -1

and you could drop the hwdb entry for the tablet if you want since
iio-sensor-proxy should now pick it up from this file (hwdb entries will
override the contents of this file so that broken firmware settings can be
fixed).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

