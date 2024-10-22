Return-Path: <linux-iio+bounces-10925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64F9AA2E0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B51C222E3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E919DF9E;
	Tue, 22 Oct 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsMCsSXu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6E19ABD5
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603080; cv=none; b=dkNchzNKjWSeiXxISLeXxCl0trUsZf2opl0lb2am2QLWDvArsrlwl8p8N+w9jvoeqoTkNh/S6fX4QjpKYcwCY/NHoSWxB6nd/9bjfqzqKF78ZDGAEZLI+/HQANv/ePhRnumpRINRtH9oSTRCxkZk3E/r5NgyxpUQD8cIvAEh82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603080; c=relaxed/simple;
	bh=jawFfqhcuybdr5d9hx5rqnMM5n3ybmlhgEbbRNmp+S0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7Vjl6uz/RrtwfqHU5D3X8c3g3oTvA5liQGVcbHZTLknIekGVkTq3R0X3Hun2e59OqmI1S3LIGNpojAcnJdhIXiy7q+OAFMzik6tJoy+8P8sy/4XtPGvvvuDN5rs8cblinmxCDkR9VgAQ/Wz9j6bAEFh0YIAafP6m30oJezBgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsMCsSXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA7B7C4CEC3
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603079;
	bh=jawFfqhcuybdr5d9hx5rqnMM5n3ybmlhgEbbRNmp+S0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tsMCsSXufqJVcwqLMtvLjHqPWt2nn8Kt3lFl1cykOJBjpvzjxjg1bLZzJW8wVp3CO
	 ugVTPemmFkB0yA8ZEORpaZ2MRanlkTqzAPqBodhne/4TC3pRJHAQJHB8wCi15k9+XM
	 ootBRd9eiQW8O5FChU3eh4yOPKs1PnQc7dkeQlZblGbqaTwY5RboJPch0htkRs8rCy
	 fn5K+tanV9/n90bfZbxIRoIunHh/2adM9GdKPFi9oIZQUPtWR27+dFGh0JPy6+mk7M
	 qrxI9ZAQ9Jyo3UGJlgl8BGNJarw4J/qgr9VKbnvDXW2OYVrZ3Z3iUVgm6/njSGPi8k
	 Q09myKH4NxhgA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0CAAC53BC4; Tue, 22 Oct 2024 13:17:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Tue, 22 Oct 2024 13:17:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219418-217253-Hcco1aQxK5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

--- Comment #2 from Camera Phone (cameraphone77@gmail.com) ---
Created attachment 307037
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307037&action=3Dedit
lspci output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

