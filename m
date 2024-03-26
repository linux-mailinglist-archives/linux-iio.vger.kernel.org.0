Return-Path: <linux-iio+bounces-3813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289388C119
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1926300541
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A55C90B;
	Tue, 26 Mar 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve8Hm6iJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AE5A0F0
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453556; cv=none; b=kgw/oA2wetOFBwEnqnW340gwl2uUyBhKu3Gx4tt7bDqOF7okjz2mgK7aaQ1NFw/8ChDIl2NC7SwxM4WD5FEUCTz33/YQ8jv098H1LGAZ4InXdT++W4iOhlsHHb3Kg/s0P6xPXM+ua4qyoP6OiQ1s0VtSmiOKeKmXUOWJrE9H+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453556; c=relaxed/simple;
	bh=lwpJasEIvE8ex//n3fVhgTDhu0VNbxdg5FEkW2t4K5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IV9uqp6F0zzHIUp8jm+unDtlRx4fK4+eUwRxWGIcj+2wJq9VzSl812K5ZNWQb0egAzNZ5KwPTNW61G2pEo49kUQugvCs2m5NncYHK287ZUSDO06capNrsoIvooagT4hwKHFVwiZdPWa/oAYJQ7St3SRaRZQJxB8Q32Rwl6wlRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve8Hm6iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57DB7C43390
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453555;
	bh=lwpJasEIvE8ex//n3fVhgTDhu0VNbxdg5FEkW2t4K5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ve8Hm6iJLxwOfoR7wTEyJ9f7xGfiU+2bUS9A08mhitXSl4Vlbe8CUVh3DCMUkyOPY
	 HhlbxiLY40U5vkcmlHMdSAQlqBu0EE/wddWmIyWbEv6gC16AMGsLK1pP46r3nbkSim
	 Vlids6Lxtvp04/7WodXKQPJcRI5pvnkR3wIBfE7dqQi2LBwfaISK0wI5G+WutEZEj5
	 /BrTSbT/UoyOh3pHaF+lEfX45wOuTGc7z8ADRAXUBs2hfD3vQSveJxgMZaJcWRni/K
	 WuT5g3S3R0E/oV2p4Xv5Wkd++B9eeVCEbQAcYpFqSIjjjFh03+qDxLQe6kuDxJgi4l
	 4L7udSpcdV4zQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3DCE9C53BD4; Tue, 26 Mar 2024 11:45:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Tue, 26 Mar 2024 11:45:54 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-012HuUtiRt@https.bugzilla.kernel.org/>
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

--- Comment #20 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Ok I have written a set of fixes for this and posted this upstream (as RFC =
for
now since these are untested):
https://lore.kernel.org/linux-iio/20240326113700.56725-1-hdegoede@redhat.co=
m/

I have also started a build of the latest Fedora 39 kernel with these patch=
es
(and the MDA6655 ACPI id which was recently added) for you to test:
https://koji.fedoraproject.org/koji/taskinfo?taskID=3D115457033

This is still building atm, this should complete building in a couple of ho=
urs.
Once this is done building please give this a test run. Here are some
instructions for directly installing a kernel from koji (Fedora's buildsyst=
em):
https://fedorapeople.org/~jwrdegoede/kernel-test-instructions.txt

If you don't have time to test the next couple of days, please at least
download the kernel rpms. Since this is a test kernel build the build-resul=
ts
will be cleaned up to reclaim diskspace in about 5 days from now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

