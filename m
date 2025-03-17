Return-Path: <linux-iio+bounces-16944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4959A64A08
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F42A3A86E0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631792236FD;
	Mon, 17 Mar 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN7IRFzo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E62356AF
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207120; cv=none; b=rKUfkpqxB6CuSFyPTxq3cN02d4MGD0mtK3KvnA+6V/jkoUthiAyFzWF5QlU9zIUxVXDz5lGFe8yFJTJYB9RE+Nz0FMKyITXqRswMvXnpQF4iCrQpMMnxRLqtpiAwd/xMfAe3xG8WKCf3/1BFj67Jw5FTkomf2QnPfaNTrDnAINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207120; c=relaxed/simple;
	bh=kpBxk5735ZejM1m+EKHiOpWrCDZDynbRuB8yuRd5QKc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJ+hVr4rWN7Df/nA+EoU3mF1PIMvuyv/8gYjnUyhrxcpVi1Sp0xzg5fTNVImtQiw2gGEHPsO2RV7xzgvSlkZsWHIzOmrjbb5O+X1mzNSWZ0ac/mU/UQBo6Kmv7o161jwYBgh4pibDgt12d0BuJ8fi2GebSchZ3HIt7b2cBN6i7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN7IRFzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E2EC4CEE3
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207118;
	bh=kpBxk5735ZejM1m+EKHiOpWrCDZDynbRuB8yuRd5QKc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kN7IRFzobzyxJjMTS3HBieMM+J3FhI+qm7ZKbvVgJ8+o20KUpCh8NMXlG0LshuT6i
	 yiTHtgKzOV45SBinu2F4x4VBj0Nmk1JObAUJ1vxaA2/MPAm13mTgxBuEtqqHY/TcfO
	 h2xT5Ce7xDhBOUcRhPgfnoJk7YFMWG72hOM5/mFOYtV/VvsCfItRIsY+ixBuIYTcjj
	 2us8ReHtds2FP1A/c/esGvC6GuoeJelXS85dKJ+IBqgZXAlZOCx6FbXidnr4a3OeeH
	 gET38Nlhee7gKDevWlt7dKDgnzYeZuycHlYp+qYwXTEEBeLbb+0o4knhDbbEQcgDbe
	 pxHY3AsFtTXgg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D0C81C433E1; Mon, 17 Mar 2025 10:25:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 10:25:05 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219890-217253-ddLCrQ5vao@https.bugzilla.kernel.org/>
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

wysiwyg81@rbox.co changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.13.7-2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

