Return-Path: <linux-iio+bounces-4312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3E8A89A9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC6928614A
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF042173329;
	Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTFs/Be/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E8173324
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373274; cv=none; b=itOTr5lT+m9GNofg+KOPmSpPD/kSBD1tcWTLuZ7mgNrljGrgrikvBOv+zOHlwkS8CG94A8NDuQm22Z1OTM4df6iqcG8Dj5tcG+kQyo5HN81dXBiYqVE2tp6NbIsh+Fa4jyDuVEpU+znhUdD5Iw2hKQX3yPQ/s3oYK3Dq9XhaBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373274; c=relaxed/simple;
	bh=r5Tjy+/ntypJYCtYLluZVglvbrGDda17ydrDq2iHwXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QghQxoc/aC7iAOUmIPpL28/8A/2mH0BAivlS/RgfwcpqFaJpyq/Qu9t8Fnalp3SA+SJf50bti61rxqvWntrlRxVqiZz25bFH8KRKjxk6oZtrHyU4L2+krM2/VYMY+DBfO3n3FnPURDthvemK1QgXWf8hqMII3h+GjOcsnIUEOD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTFs/Be/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BAA4C072AA
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373274;
	bh=r5Tjy+/ntypJYCtYLluZVglvbrGDda17ydrDq2iHwXk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JTFs/Be/IlC43LfERmXRvojRBPaJCH8JrGRPx6X4e0hvFOd5e8ON+cZQ7tdYr9UdR
	 6JNVX6WQnCMMJ2/XB5MaH1RnPX2pbgKhPUQZgYYEUHBlBRC8RXiHuHFSbgLvfJwnKj
	 VhkePl37cM4synZbPBpzhLTo1QlC2jNGR8VZ6tIlWKFRsIvUqxD3EV0AYRQFCpadjK
	 ezGGN+R7eRl/QStHc1r1UHk9Pzci6DbCZBfA31UWH5w/+zKORo/vC90c3QPekA7pFP
	 O2mBFLGiaY+RU9nRpWZNAE5vtNDOQo4T/FXHcXXK/7FFESBbarEUCsnm0JCBeZz8Qn
	 OMZkWaTv5AjHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 40B4DC433E5; Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 17 Apr 2024 17:01:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-rqH8b9n0bq@https.bugzilla.kernel.org/>
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

--- Comment #29 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
p.s. Your systemd pull-request to fix the missing colon in hwdb of course is
still good to have no need to retract that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

