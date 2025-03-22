Return-Path: <linux-iio+bounces-17205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02BA6CB20
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 16:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333D118880C1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC822E402;
	Sat, 22 Mar 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2CQnwS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA3155335
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742656275; cv=none; b=ZYuNyFRR5af+E7/y85Kka53ImOaCxChWvjd7dshv2dq5viaYHVZ6c4CUKXtR22ivKbWBWLu2dvJr3WhP9G54r14XwVI124Ax0IqHOZTSzZEMHMNUPxA1JVBvhYVUmpbyPKrQ/XGNmSzlTumy6bhex/UaEaeHMTc4uxCkH56Do2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742656275; c=relaxed/simple;
	bh=WSRanJDuKc8kzwX2sNwCvb3slGf29fsDDKahQ19LL0o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em8/2rCUz83UY3YRCtDohWOyvSqhMyag3OsIt+FZ8pmfcYdyug2NtbVlAnFuoOH+JtwfqbFDwzFTyFkgGqhvxgseivIxUQhfuNzP9TFGPCK2ugQhHF8YYrLtftPNsl4i24GXdefskuoSQsjztMZ/+glbywcOhQsUgA3dE1ahy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2CQnwS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3EFDC4CEDD
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742656273;
	bh=WSRanJDuKc8kzwX2sNwCvb3slGf29fsDDKahQ19LL0o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f2CQnwS2kP9NjNU/2NA/zVIdpjGHfjjpR6Gw0FodU+Sx9/M9tBJ4/hbTKIpNkaE6D
	 AxHGLEGwbIk99XPmR0dHmUBk0Ta6UHMyVJaT/1tFqoQO3jwEsP+4an3IKKm5Lh9ptY
	 KvGMF+PbJVGjJznSCc9C6ac4i2R1Pw04sr4v8vx/Ts+JfI3zXmRYvQn0SjeeCSefRV
	 6zyauepyekWchX62VCSRmLRcHTqmK/kl9y3l5O45Oa+NWtKDtbq7jm1/co3wFYP6Tw
	 Y9fFE7fu9iaP965HiKZmV96RJ/41xNqpCZDqiN6uxhGs3Jf9+NazAsnvmqMaxVV5II
	 Sk8VJQ2/xtypA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8F9ADC433E1; Sat, 22 Mar 2025 15:11:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Sat, 22 Mar 2025 15:11:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-mGVt0xotay@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #31 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
(In reply to Fred from comment #30)
> Hello Srinivas,
>=20
> Problem seems gone with iio-sensor-proxy v3.7 that I installed yesterday=
=20
>=20
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/407
>=20
> Thank you for your kind support in processing this issue !

Hi Fred, Thanks for bringing up. I will try to inform Lenovo about this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

