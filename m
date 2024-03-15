Return-Path: <linux-iio+bounces-3536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654487C782
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 03:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7744B1C2103D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DA7499;
	Fri, 15 Mar 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSPiR8se"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB66FB1
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469856; cv=none; b=pgC4lGxOXTzXYp4IVENNAGMQDk+JRAVMfmOj4S5igitJprirx4NHvkXngi0BHmSghwmxQBcMvtX/VonM1KElcTj+y4VJqlR7vQQ4l3EJK+lXEXIusY3FDjQD4Vc0H6LxeAx5H4t/KAW8HDk+PrrPnA8k2WefFYGlAkpZbgtcV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469856; c=relaxed/simple;
	bh=30SSkjdOZnxfCjIILVNEYGnuLUSD8BGSrDZSzHIl9Sw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSYnYWU0MpR6JCZK/WWMHSx33pmwr5faG/gcSLNWjYFyGSmRlTXNbEe9Bl5mRSfawCEdAtevNHKw66Ejt5dXa3jtKF4QKtwuHXthCJkzP5MhsAXkbMWyaQ+PnTEKasJKe/x2X40OZZJ8l/KO/l+BV7/R0C68QFdgSPTeSXvvqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSPiR8se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6B73C43390
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469855;
	bh=30SSkjdOZnxfCjIILVNEYGnuLUSD8BGSrDZSzHIl9Sw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FSPiR8sejMWiDDqGpE4ranQLoCjljeoDZMBlxG4qMcmxbHqWBNLnLfHSLolukYeRi
	 j9nGBMhQCG88ODRBSScxynAsCfxNtTytqtk9hArZRx+wZhAhP/N6C7O+2q5trBbjaR
	 LRzpcOfKJ9NtsbTwqQojKlKW9jNUHaXzdcdB0xXYZkBoOHZZVqyUk/o9MHDo6F7ka5
	 p9o2LYa0WPmE2WARrSFllSDZKLahTdzLx4cawubxOG1MNoGzsl6BR7TujQKAiXIUlg
	 rW8m4Fvvqw3r7aRrvouQXUtggEUPBut5uWrsa8Lj6xXyCkQqh4jrLfSmq68AeHjx6f
	 Zv/9B19NOL07A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E1408C53BD0; Fri, 15 Mar 2024 02:30:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 15 Mar 2024 02:30:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218578-217253-vqx1ZQWY4D@https.bugzilla.kernel.org/>
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

--- Comment #11 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305992
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305992&action=3Dedit
i2cdump good, cold boot, accelerometer working

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

