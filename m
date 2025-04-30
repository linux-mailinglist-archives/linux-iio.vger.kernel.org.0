Return-Path: <linux-iio+bounces-18891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB1AA4326
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08FF1C00F10
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9361E503D;
	Wed, 30 Apr 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB3RNIMv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B681C6FF2
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994823; cv=none; b=fF6RRGfeSEctp9o8IHKuF0NCjAI4q9Ygo5f2CTLAuJDIBtOhvRTd/X6ZTjW73K6ftxdTWbcl86QPRA3o5i8ghRydL918l7oHHVvkuvmcwogZtbZWdgz6gv+m/8umssp9ycfpE6QLHf39KA08nsp3H+0bT0HQNZlRQA+odGt2q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994823; c=relaxed/simple;
	bh=n0WpE2UkAT6cWjqVt7Lc4xp7LRpuIDg5MadkLX3yYkU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+TN+013ieDzMJ6dPHo3l/e8FxoHax3/F9UxVJPIZ2QxGlGBVucwAxmUfchLIcksLG+xHr0gAqdGfnSItAwATFE1bBsZ31f9ccPULBpxywYViAtL8IjRDxAQt0ij9518+OZuMezHhJSAkDaaA9eKb4RvqiWkLC+o8HLAMMK3t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB3RNIMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B3FBC4CEEE
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 06:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745994823;
	bh=n0WpE2UkAT6cWjqVt7Lc4xp7LRpuIDg5MadkLX3yYkU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GB3RNIMvyT/tP/UkWNAS8SEKqVqfEIptr4jks/ETdjxWaN09fvSK1lnfeufsNJi1b
	 V3c4Z0pdhrumJ9DS/znm8OwWGCkPZZY8jiV9t/KS7kqrqoTZ56DGxqg+gnPHBfDv5d
	 x8tzulzMaf+WH2Orwz1pMkvK2tgMJYCExx8yQAa6kNPtAzEYT91QpeOAhnBWWNGgCC
	 kyZ5S512LSeBfZ9OT70KkB2u65Hwp1bcF69YciSwsH7nLfgtiQi4mGj5M6//uv76EG
	 13sOBpVP7+wb738cnMSTVkZ656U2nbRvBUHFtG556xD8UnwOx6OMkD7cFtmmAp6Oc9
	 bmKOJaQAqatAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C734C41614; Wed, 30 Apr 2025 06:33:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Wed, 30 Apr 2025 06:33:42 +0000
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
Message-ID: <bug-219192-217253-VHSGhzyTgS@https.bugzilla.kernel.org/>
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

--- Comment #13 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
Another thread pointed out to the `BUG()` instead of `unreacheable()` which
should solve the issue. Can we go that direction?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

