Return-Path: <linux-iio+bounces-17201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B5A6C8D2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 10:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0921B6309B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BC1EFF83;
	Sat, 22 Mar 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldfRqsQN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA31EF37D
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742636300; cv=none; b=I2jI64S+k97pPeJSc1omwdPiwhXquvXx70/rDLkEbQN/BI9ZA8LEhaT+DNTjC7bGv1FO0fvGn6Z5Y4vLQ/bPTXFMNBDCYpRHNJMENdI9HWvR97x6C4M4n4owtzl4QCmyTpzhRatK/veIy7mJegAEuSn0rrGYVo13u01UXC98rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742636300; c=relaxed/simple;
	bh=ODfDNlXXJhMoEo/IyERkXK//xFYMokmy1Vg+xz+peYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeZvz8clMnQ26WWWBgWVBBdRnINEOes8KdjqOlCRhz1BvJy7QDnyqgO0e0Tn9cj1234qASKDtyIDHNBXFeHfyvMcNabOc4C4zwEqTRMJlOIXGBmrp2h+k8Qs84rIgcJ8PhPzsAJleRsQc7qf7/3OqsrG26gFtTRMM5O70iLm1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldfRqsQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B7FC4CEE9
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742636299;
	bh=ODfDNlXXJhMoEo/IyERkXK//xFYMokmy1Vg+xz+peYw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ldfRqsQNkWsa0uNMpT1lER2ODdc9R4IcYROWqJLyL/62Y10yLNTC7p0AmWvdntMwo
	 FSP9LKJV2oAuxu+hPhzF8PCulQ7xhDlH3S63A0icXwoyGbBDRzKINC6MRj8eM7w2q2
	 DjHSXGDfoTwEMkhnrFIkeye0NCO0MsB+g6UEDPthkOuW+sDNdxZ7pxWdJPU6ErYwdk
	 K1K1DAtryBiwEL2UvFkHjAyEG5go/LBQNDSp6Zxwy74yo7OZAQGdKuW1CCDDHEpX0d
	 TnplqzWzexSNtQPeoDcoldM8QAjHITNORxWbOTVGzcAXkxRUXHSBoxkPUCGnMvUv6n
	 sWQfNrRu+sWog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E77ACC41612; Sat, 22 Mar 2025 09:38:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Sat, 22 Mar 2025 09:38:18 +0000
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
Message-ID: <bug-219890-217253-oeiUhIa2cy@https.bugzilla.kernel.org/>
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

--- Comment #30 from Fred (wysiwyg81@rbox.co) ---
Hello Srinivas,

Problem seems gone with iio-sensor-proxy v3.7 that I installed yesterday=20

https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/407

Thank you for your kind support in processing this issue !

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

