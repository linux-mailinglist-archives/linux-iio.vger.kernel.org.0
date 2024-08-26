Return-Path: <linux-iio+bounces-8786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B495EE2C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E358F2837A7
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9073146D40;
	Mon, 26 Aug 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNEBZCu1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB0146A6B
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667104; cv=none; b=g5FP6I8eNc/ej0PzE6Q5hDx5joWOkXi92P5FTPSO7wSZlIMKaJ2xDfcUJYtRcvfvt1xyFhwHowln2qr8h2Z2i6arau1otNEMfeVbcRAJYTG/G24XSDVAiVkqLVQGwb/76+Uy5ub7Iquh1S7DBsXpMd48OA3uJAyd0ayM4VAoW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667104; c=relaxed/simple;
	bh=6DC/pljILmal3vJXTXzPzWMCUvoNsIiuwQPiYZAu2to=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoFm1vGJJxLzeqsRXJm1DuVXaFxWNlBQg78h686+ByL5M8WATn0Ekan7wyVBb5KwpyZPhvzmq9wSgw+CLNFrun3QQ3wTTTKCzfn0QX+fkw6i9Jcb4mcHVU2KSTEJmRGBqQIupklxtQff5S6KDnkSxluGvuVbm13I7NEp4hDX2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNEBZCu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1664BC51406
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724667104;
	bh=6DC/pljILmal3vJXTXzPzWMCUvoNsIiuwQPiYZAu2to=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jNEBZCu1aQ76TlHBBh/sw6lti2lH+c7tVDXQMchH2MJkfjqpOI6RuTV77ex2DH9X7
	 c3YpViWuxlp+RGjnljU2nqSI0PgpVjJv0usbotGaRD77mjNceKQBlBd7+3NI4h+3Cr
	 EQCVYNMinrBLKWt0by3hldq3OtsvDNuf5uit9oNTWjicCY/TFynJMCo0Lpi95O/FQ+
	 fFW2Ccs/J7nWfejFpbiWt3og8cK5Y7i7QJAK67qxk9mR/aBPRYtpe/C2MLUDPWF83y
	 PlryJmQ4+FQdw0g056GMccNF8Mf2OgzKzXPdAKyXpUFH5QIRcN4mPA7k2byfNQ+knH
	 EaffMrI3E44dA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06D43C53B7E; Mon, 26 Aug 2024 10:11:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Mon, 26 Aug 2024 10:11:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-CQKwJPN9Bh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
On Sun, 25 Aug 2024 09:35:37 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
>             Bug ID: 219192
>            Summary: drivers/iio/imu/adis16400.o: warning: objtool:
>                     adis16400_write_raw() falls through to next function
>                     adis16400_show_flash_count()
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: ionut_n2001@yahoo.com
>         Regression: No
>=20
> drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw() falls
> through to next function adis16400_show_flash_count()
>=20
> Kernel: 6.11.0-rc5 vanilla
> GCC compiler: gcc (Debian 14.1.0-5) 14.1.0

I think this is a false positive.  None of the cases of the switch statement
fail to return and there are unreachable() markings that this
check seems to not be able to see which were added to try and
point out to the compiler that it was failing to identify they
were not possible to get to.

We could add some returns the unreachable paths to work around
this warning I suppose.

Maybe we are doing something wrong otherwise?  I'd like more
eyes on this incase I'm just missing something obvious.

Jonathan


>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

