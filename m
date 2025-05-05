Return-Path: <linux-iio+bounces-19089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B28AA92A2
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DED8188AB00
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B820408A;
	Mon,  5 May 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU/xkyxm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1791DFE20
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446565; cv=none; b=cyT0w98JW7zARvFuL9Xvg4xRebxM1gaBv+A1wmOOuHJ+1bwhGBF7zpIbqJffqBizqZmpX7cNiQ0prPlxD9Hl66D7iCCyjQpS2BRL6PAhr1Jw5Pu53gOMyuY3fp3VHyqIG+zdxWVL2d/R7KG9n4T+Fc9KC74NCDq4bpusitNpzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446565; c=relaxed/simple;
	bh=XmuaQJy17+dy40vlnpI1/DLK2PZwfua63+O7iCgV1Jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIFcAQXdgQ8+ICJI4MTJHv777Ilc2HZ72nnDXN8RtP6MwWePojmmuT/Hhdqrtkq6zon0TNSua1SIwgx7/bx45JOa4cF4S6OcL2+nwH9ZjJc5oIU5yJvWjMRbkDRGLYBqOCO2Os/ks7HIIt+3bZnwlZhpZGk/JLmcJYixGdsvbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU/xkyxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8E8C4CEEF
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746446564;
	bh=XmuaQJy17+dy40vlnpI1/DLK2PZwfua63+O7iCgV1Jw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dU/xkyxm3A2PT+OOetA75dIkC2nu2aMCPp8sgqZk4SDBAKjZJLs6rqPN5bH2GuCe/
	 6xEeBMlzM9xahLOVHMs7pO6QFI5p/Ya3/HekOM9pcroY62RNPLnoLK6nszszef/xyV
	 Y6XDErhoElHYnKbCFjFwfKjEqICt4nTX4yDFqu0DjB0mN/tMvWq+SQejBc1D+g1X3g
	 1S/QP2OUxcjShLQot2OWfgXepVfdSf0Jhi9SbHcd5TuG/da7yVIaQHR0r3bsbfxOhs
	 O7t3EbQRODeA7cCpqeG0UcV+yVOpshQ8kIpUbGdJ9xqt2EfVmzBGAwENF1L0f61zE5
	 hv66+KJgeoSzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60FB0C53BC5; Mon,  5 May 2025 12:02:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Mon, 05 May 2025 12:02:44 +0000
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
Message-ID: <bug-219192-217253-16KQh8BsBj@https.bugzilla.kernel.org/>
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

--- Comment #14 from Jonathan Cameron (jic23@kernel.org) ---
On Wed, 30 Apr 2025 06:33:42 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> --- Comment #13 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Another thread pointed out to the `BUG()` instead of `unreacheable()` whi=
ch
> should solve the issue. Can we go that direction?
>=20

Ok.  Maybe replace them with something that doesn't loose readability such =
as
BUG(); /* Unreachable */

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

