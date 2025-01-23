Return-Path: <linux-iio+bounces-14545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6EDA1A915
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B291889E63
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B531494BF;
	Thu, 23 Jan 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsKxSO/f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C14600F
	for <linux-iio@vger.kernel.org>; Thu, 23 Jan 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654330; cv=none; b=B6d2dkEc5B9AzEpQZq4SxE2KT+lmWy885Fmwq2fKcK6Ht+ftsJor+cyCWNq5r1C795IGmK4wiQUzJcPBJ9V9EW7ylJdwtEXKlHMit3UK5pBJH8xVabnr2e7DNuQNFtJwpQa3hzbwvPHiL2tf+XXjJbclPoEaJOwyNsR1NhXXsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654330; c=relaxed/simple;
	bh=csbyce3fa2ie/keCzhPkpX90Efu6AyzGwi97m8HModA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqwFjTSPafwKywXC3mhLiIlN3OQLQeC1bvbA/qA0dofqJ1HRZDGFKXghRM4KMG8NiyzYNcxlZUnq7+hI54FYoS0gQj9A2uYL9dB5B2FOrgjrs0f+1+D3bbovrXEEj7Rd/PuEMca6uXKZvPyAbBC5jUyqGlhSa9UVMNsc+hjPJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsKxSO/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A58BC4CEE2
	for <linux-iio@vger.kernel.org>; Thu, 23 Jan 2025 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737654330;
	bh=csbyce3fa2ie/keCzhPkpX90Efu6AyzGwi97m8HModA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZsKxSO/fhXvJA7KQwnIRVVx1boDiT8DkZtxbGM78JJBZsUMP89P/PQRcXEuTsHfxo
	 2SFLZ7aIaFtMLYPmaQHPC/hwRJ21tbLUNqLarIVpv3FMj91/rGK7YDjq5mHtXDnZgw
	 Hw3js8wcoG+56GIr6yMHaRfr/hFVgBsETwVc3kyBrGwtqKYUrbrXp0/IoPkLFObaLv
	 bg7ZAz33JuUYqIHQYZFfR4yC7qSUe+jDjTJltFc9mZi8ebPX2iCoQkvVjwUzj9eygK
	 cepyb4MOsyzNV6vuH0+08dluQ8qqyl0SLagVDQhCqKmkH2BSZd/VUPoNUHK/LtzO+w
	 0MdvAtMXD9ZJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 15F00C41614; Thu, 23 Jan 2025 17:45:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Thu, 23 Jan 2025 17:45:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-TaTr78TvIB@https.bugzilla.kernel.org/>
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

--- Comment #11 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
Do we still have this issue in the latest vanilla (v6.13)? Looking again at=
 the
code I'm wondering why we can't simply use guard()() instead of scoped_guar=
d().
It might actually fix this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

