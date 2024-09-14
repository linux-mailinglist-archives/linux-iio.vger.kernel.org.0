Return-Path: <linux-iio+bounces-9539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A329C97907C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE781F21989
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A61CF5D3;
	Sat, 14 Sep 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omS//oKP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49211CF29C
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313348; cv=none; b=jLJbjbHH1nSIYZu6G+gXgbueTCL7nsaZ8YRh1K2/kHmY7LzlQW1hw4/hLA33uC/MI37ZkPaQOrBVUOfBoeqwR8R9LdsYCyeY9cqUGBsYQK/YGKy81SzuS9FJYEL8NbsMYIb2bRMmHLZ/ZsKIosSXnMGSgsayOSNujzP7+MvVbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313348; c=relaxed/simple;
	bh=hOUCnBWnBY58rGdomgxhy2kLJhKk6gGlOdPSUPREYZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrquaucUN+DiP4hi7GYI1Is3qmW0YGKO0mg1EgyHQKKOl8zbFrzTvaQtcVprVM+P1Q4rmY63R2ZlWOhRS0xfecy81fXpxSFWJAb8SaOAI/22W7gEd20DNSctu8cgcIn4T6adNnlWajvJSL5l3crIUOI6HN9GhdnydVTXb34Gvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omS//oKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7824DC4CEC0
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313347;
	bh=hOUCnBWnBY58rGdomgxhy2kLJhKk6gGlOdPSUPREYZE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=omS//oKPk/NNQNUX86AHLpcUaauSF3iWNNuaS8H6BUuId/Pmingn0nz/4XKxb511a
	 RG7QFl2zJ0HEgUNG6lSLl6T1LSuvQZPuP8jqWb0uTRzlOcW4f+QrHEBB3wKmvm6Tj1
	 Kv33GUvbyV9U7kEszJbJuitnI0k0M3PSdMX6O17MHwvjoQyIvdhAD2E2mk9ExlmFSd
	 FzKinDwPnq+c+sgOayfHsJYIFlfaWAuJD08fR8ROtYSr19CRH+wNbploXKXnq7iUKp
	 L4f+ZIAvsM8ZUQ5tcW2d2SARTkOVciDGTmyhPYC3Yb+FMoAH9sE7Qub4z3u19lZQ7w
	 j7QYr2AyaWWOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6CA76C53BC3; Sat, 14 Sep 2024 11:29:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date: Sat, 14 Sep 2024 11:29:07 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216037-217253-aUDCF10lCD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216037-217253@https.bugzilla.kernel.org/>
References: <bug-216037-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

--- Comment #6 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Andy, thank you for the Cc.

Nikolai, thank you for reporting this and thank you for already doing some
initial investigation and providing a DSDT.

Looking at the _CRS for the Device (ACMG) {} then it has 2 I2cSerialBusV2
resources, likely one for each accelerometer.

We have hit this case before with BOSC0200 ACPI devices describing bmc150
accelerometers, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/iio/accel/bmc150-accel-i2c.c#n125

I think we need to add a function like bmc150_acpi_dual_accel_probe() to
drivers/iio/accel/mxc4005.c minus the extra special suspend/resume handling.

Nikolai, do you think you can write a patch for this yourself (mostly copy +
pasting the bmc150_acpi_dual_accel_probe() function) ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

