Return-Path: <linux-iio+bounces-26256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD7C61463
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FB294E5E78
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045CA2C15B1;
	Sun, 16 Nov 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUoMnNQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D5274B26
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294708; cv=none; b=eU0lg8QjtwvnBndiGI8t9VnCs9aHlBLXtwaQ9jtGgxOqviDVSwqW6Iz2MT1IguxNHmEJpbRccRAGQTNeqM29l09esAaITzjMO5qX/7+J9VGc02CGENeRabQgT/z+C3lFczsk/hcI9DzECSLylNtUAmvu9+1BiUAB9R4knMbvtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294708; c=relaxed/simple;
	bh=CGq+c4HS5tSQDPI+sy4uH5gh/qyHTPmxvWkPDFzR3Bk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5N76qmZsBKMZAU2teO1SCjscGEefqRmc53ShPN+Yq8D4PjgYfRk/UM+/57Hz4BcEIuZ0jBsEyihQNO3TEcz7S4ndEyG0xqvVYSXXSpZZto6IFPOD9szRzhm3L8MhaEqja5bl2WNrgX7BxO47/pq6uTIzeiVO8g4QKrD+SFkQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUoMnNQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 525F2C4CEF5
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763294708;
	bh=CGq+c4HS5tSQDPI+sy4uH5gh/qyHTPmxvWkPDFzR3Bk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lUoMnNQThyWUCE7vKFCrsinKHt4w7Q2SdBOGUNF3ZnhFMH4U5lf44X0d4fC9llfEX
	 2QAF0O/FdxSFzjfZiqOR2l+23YVltMj4E5aPD2LBaIu8hL/ouTh8dWoqQp8ZH4FRhn
	 jQQ7HdlMbstNw5s6WhDP1aCic63MgqwXOllKqg8EOKbK2HYENlj6gGSPzkSkb/ocqt
	 FNQY9ZEo2EfnZ2n/zIo5+oOeIIuykMzS8UxLGguSDJ5sWcKy08eOng3FzJKpVeoRmZ
	 hhCKGxjraLwNFOwPjcMTKYxzefvAQd0XKM39yL7y+gsYaaCfJuFdAc/yqS4Ick+Kxr
	 /YcWXlRLqOA+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3B62ACAB785; Sun, 16 Nov 2025 12:05:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Sun, 16 Nov 2025 12:05:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: highwaystar.ru@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220772-217253-qW8fwxy3Kc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220772-217253@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220772

--- Comment #5 from Vitaliy Tomin (highwaystar.ru@gmail.com) ---
Created attachment 308945
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308945&action=3Dedit
dmesg booted with patch applied

I've tried you patch and it is working with no issue - no crash, accelerome=
ter
working. I've attached dmesg booted with this patch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

