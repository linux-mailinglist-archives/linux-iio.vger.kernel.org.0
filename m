Return-Path: <linux-iio+bounces-17094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DEFA68DA5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 14:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC368188845F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098C2561C0;
	Wed, 19 Mar 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNImw24G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8F23AD
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390345; cv=none; b=kYnB1yt1uFaCHjGiJZnsOMx3NrYAvT3cIYJFhJ3VwLlORrdUTRTi2k5AeVBHXjwDFSi9D3DMgYMWfFActdOvgu9RiioWYDJhsjwLnpoOggNO8vsicihUK2wwE3NU6NtNqN0b/Bk1bd/El2ByuShnWtDZxrVqhNDtfkI64KnA0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390345; c=relaxed/simple;
	bh=hhWhB/6AyTAzsLjmb7MnVI89IXBGq/vT8pGoYGdyvzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jE5UmYzjN1mTK0BcZRzO7AxNlBLrV39WRR6U9ccOD1vPOiMV+intxR7ouus22dI98vdTvk9H2un0yqFSvYArMP6s2SmCNVQ5sPPwJK3T+QWOZKqh/azo3zjRj1aKN/eELZm5y4deHOH3meS6RC0KAPnjTQU/lUuzys/OcKNc5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNImw24G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98257C4CEE9
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742390345;
	bh=hhWhB/6AyTAzsLjmb7MnVI89IXBGq/vT8pGoYGdyvzA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fNImw24Gc4T1Zlb3fYeDXmOxaMS0TEPcUmAUgO52Q2xvDP++3ZJvYEQ5Hpg/QO0AO
	 yYymWgi0ociqYennRWUnCIdi4KmpB8xWRzp5f6uopozI0PM5uUo/ucbqk4X/cqJtTh
	 pwmroL6sBbah6DUrzQ9FTfaTskekoBqUforpo3TlY6X6sDJeLC+OvA6auHrCD/jNB0
	 aHK6yInA6BzM0hHUkXj4YhguGNnp0L6S5HsidUr1sairwe4Tq/E1bYnArFCnAqUb/X
	 qljc2BYKvz1Csaej8X9TvgqA3G9NfQSWjh6xsE3luJgYz5a7zAvkNcyaNg4WNdHzCc
	 J6UzObgC4HymA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 91129C41612; Wed, 19 Mar 2025 13:19:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 13:19:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-oZ2FnLIARZ@https.bugzilla.kernel.org/>
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

--- Comment #20 from Fred (wysiwyg81@rbox.co) ---
*sorry 1st sentence in previous message was truncated.

I meant "If I don't understood wrong the data in  dmesg and watch commands,=
 my
understanding is that"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

