Return-Path: <linux-iio+bounces-9395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EFC971CA8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCAFB21355
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442801BA276;
	Mon,  9 Sep 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxgcTb42"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6A1B86D0
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892346; cv=none; b=H74kXJal7fXLtcAC6JQmAFBvstR0v7jj7wYUvC5zW+fc2NFUWLzCjt8i5c2L+H8P07xQVsIhnB/DwEJXeQN+xPlYGquIgi1qGZLrFed00nLpU1bHNZotIXdrr4V2pfCq6SI7n4G63iBQtwNfYj5+4vWJ8r+Xg4MOsyRQY7x2gLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892346; c=relaxed/simple;
	bh=ZZ5EbMlXo0wzAGQ+Mj42Z1SRUJjXoW3QEb8+WrVE3jo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gy4rTPgQsq3osBRSvM5j0Omb+vAYDvJoJQV1DbzjA5OFUYG4HwnVse3uw0CKDq0M9jOehhRRgQFHtR1Mkj9C2eLUc/hbtTOuvFuRb9l2+A5f6bf14zdZKAltP5O6WqCKgTMM5TVtNakOA3mSU1M9vEN4upCmJPjjhJpazZSHESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxgcTb42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC295C4CEC6
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892345;
	bh=ZZ5EbMlXo0wzAGQ+Mj42Z1SRUJjXoW3QEb8+WrVE3jo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UxgcTb42dXGMSoXrI+y0vdSdXJtHot54BTy6aZ2EyGCCY9zRm/Ba6sOgPpOOVGezb
	 uGaE72HmQmDGLucXbHSjBMkkAZUBJo4bNyXVutLuFci2nwY09CI4f9xKlp795u0zX7
	 7L3fhWpDXRbdanyYeJhrihBCvbXvSgSL4P3ZkV7f1rOzvUAR5bVGFjkANCuzz9WF5K
	 3Dc51GVrv0mIQ937GbO+5iLM0IEDD2m80DU0D9xzX4F2Wvo2/MebtxSUMyJKSi5NQA
	 PZ84y3qUwCf1FYGRFmPZd0V0QGJqg9wC8ONyFLECcdgMgY6B4CaEuSymEWWbvfeCos
	 s4bFNixJdbOWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2047C53BC7; Mon,  9 Sep 2024 14:32:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Mon, 09 Sep 2024 14:32:25 +0000
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
X-Bugzilla-Changed-Fields: attachments.ispatch attachments.mimetype
Message-ID: <bug-218223-217253-AqLsWZ9nnV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218223-217253@https.bugzilla.kernel.org/>
References: <bug-218223-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218223

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #305607|0                           |1
           is patch|                            |
 Attachment #305607|application/mbox            |text/plain
          mime type|                            |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

