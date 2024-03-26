Return-Path: <linux-iio+bounces-3824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A788D116
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 23:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139A91F65335
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CA13DDAA;
	Tue, 26 Mar 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZLLieDX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301C13DBBF
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492636; cv=none; b=njKQnopf9PFjm1lFiJq3+sQFiFwKb7MHBeweW7TZEx+PuaALdB5ItN9Vv6XPxDNM8dK0wS0aLQz6CUKqZ+gM4qHjOFTU4ky/5ZiMkVWQSVY363Du+JQkC1jQJj0lNBeUPM4x1h0AZX8Y7Kf2gGOEAVnA0tPdMhjBB2dZwDBKSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492636; c=relaxed/simple;
	bh=NQSXmEEodakXlFrLY4QfvmvF7bUMNwkv3HoEDsKPNdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOnliAX518GZeNFdSXQvKiVm8462NnPG0QX6XTOu2+6E4Wi2jnhqkWPjOjH7VJM1RlB77D1v9AeggUVVpd40KywKEO2/3J7dKCogoTWOyyIAUz9wLpM6oIa3Ks486Z0tJoqmDN+ybT3zaJ98QNPk0m0Mll3B825mdz5yvqXHf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZLLieDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8E70C43399
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492635;
	bh=NQSXmEEodakXlFrLY4QfvmvF7bUMNwkv3HoEDsKPNdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aZLLieDXRzX4debdwgJf/Bkw4EAZZgMfXVuvoSa6vzaj4LzcAD4bN8vc5EyC0Ox2G
	 pn6UwT91Q5rhd8x5+aF3qTXvlyNj3/dV5vsZsEogaX4q6Q6pO+U7GDVr4aCKZr5eMI
	 JLV2DMAWadWoU0B87c196Rvfy3lBPBCLBpG5fcPF2V1MvvzwMIRlOPmoj3v/bEdCsZ
	 9xHz7EqfhhYq659LupdJ+60K0DreSLQGJTvXhwFy/VNdjMOIJy4LFS7FGpL5Icli9L
	 btic7mw+etmh62FgPida2oaP56m1tbslAvf/3XHOT9jNbEWJ+4aVoanBkYUFw74se6
	 LecdF+sPQgx+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A5359C53BCD; Tue, 26 Mar 2024 22:37:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Tue, 26 Mar 2024 22:37:15 +0000
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
Message-ID: <bug-218578-217253-2XhBuf6GC0@https.bugzilla.kernel.org/>
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

--- Comment #22 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

Awesome, thanks so much!  I am thrilled to report that this has fixed all of
the issues.

I tested on both of my devices with this chip:
- UBook X 2023
- UBook X Pro 2023

I tested a number of scenarios including:
- Cold boot into Fedora
- Reboot out of Windows, boot into Fedora
- Reboot out of Fedora, boot into Fedora
- Go to sleep and wake up

In all cases, the accelerometer is now working 100% of the time. :)=20


My issue is resolved, but I am still leaving the file I put in
/etc/udev/hwdb.d/ubook.hwdb which is necessary to fix the orientation of the
accelerometer.  Without this updated ACCEL_MOUNT_MATRIX, I found the screen
rotation was upside down.

I'm not sure if it would be appropriate to push this type of update with the
update we're doing, but if we are able to push that changed matrix out too,
then anyone with this hardware should work properly out of the box with your
patch.  If not, users of this model will still need to create that hwdb fil=
e.

Thanks!
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

