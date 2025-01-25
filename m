Return-Path: <linux-iio+bounces-14559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C03A1C2EF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113933A8FB4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69D1EE7B3;
	Sat, 25 Jan 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ8iIrM3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3213C67E
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737805188; cv=none; b=bLd3YxAJSJpIrPJL8ibcXy4XkhbPtcEZ7lTaK4+wh4Z5lADu8hCJbZ1YwCGyojxCtXTAJvahklG3aXVVq3s4Q7TiAgl32aj8doWSyHvLEg/AHSoW0CGEpwY8sAPmCRn7Q8JfcIWUOTW/iiKtbuQU4kdzXtgFz7RDuMZxKlcRreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737805188; c=relaxed/simple;
	bh=LNIImR0s/Hejs324k3ePrSzDZ8dHVEqfhozXmOTOkTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mvQcUkodq9/w8AjGuWAR/FDdMlIoqnKJr00w8pqDjAaHd1pRwWS5ILya2+D/TlyBmnYipPNIcg3fv91GiNY3+b6rfO0dNzmhvUTrXDaeOOHZeqdY29OB46/V48vF7bMHrZmfyqwMfpCa4Jm1mImb62R1ujHBV1yR2+jKqqFg4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ8iIrM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C9FC4CEE3
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737805186;
	bh=LNIImR0s/Hejs324k3ePrSzDZ8dHVEqfhozXmOTOkTU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fZ8iIrM3seroqy47VAYRTzF/W9B9rBW7mAVUzxYFKcVPpA1CHwZoGNoT7Yc1TXZ0D
	 DyjhpMyNzv2BbJokGSfuMrX/Rr6Ob6tF0KJsKZVELWFM69TZngJhrdEoRCYx0D1Ygn
	 9N6WtfSLP4mAMJqVe9uhGnObK6P3chDbEq5g5ml0eYFOos2b3n+c7KE6mLaMMmhi9P
	 +NCWduB5WwDRmWM+eox4wGkMJjgCLC7NePcMQ9pcJUJLsrkkt1nQR2KVhoLjk20d40
	 RabLwiSWJyArMjJmt+ukay0aQldElJ3mCUXuUmO9ceCpTQxsaOQXLVicklP+dfe8VC
	 CCiQaORVv4N+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 81E9DC41606; Sat, 25 Jan 2025 11:39:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sat, 25 Jan 2025 11:39:46 +0000
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
Message-ID: <bug-219192-217253-6vE0I5wcHD@https.bugzilla.kernel.org/>
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

--- Comment #12 from Jonathan Cameron (jic23@kernel.org) ---
On Thu, 23 Jan 2025 17:45:29 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> --- Comment #11 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Do we still have this issue in the latest vanilla (v6.13)? Looking again =
at
> the
> code I'm wondering why we can't simply use guard()() instead of
> scoped_guard().
> It might actually fix this.
>=20

Is this actually a bug rather than a false warning?
My impression was that this is a compiler problem and I'm not that keen to
modify
drivers to work around that unless the resulting module is actually broken.

If we have to, just add pointless returns instead of unreachable() markings
with a comment to say they are unreachable but we suppressing a toolchain
issue.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

