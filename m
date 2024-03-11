Return-Path: <linux-iio+bounces-3450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0A877A4F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 05:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD182820AC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8521187F;
	Mon, 11 Mar 2024 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAXxl4yl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787241860
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710130911; cv=none; b=FHs3Iyd5S8qSxDY1817aJ9mFNLUTKyezpFsDRcfE98a1J17ZphvCI8BKW8Squc8SwnE1GSF4ysIwBJvKoatPCe5r2fnFAfcm8FTfBeVc+aT80oowGla9i3TjUuICUyNm5NCuenzo9Z5i0fn/uq/s0BibOKD0zhCZH5sEnSq94nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710130911; c=relaxed/simple;
	bh=o5xMP4WKDy1XHDo+qgLrS0JvJcK8AfkBqSJlSn9v2xI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZE3yunFvYmv5VfI43dWb2bJXiZ+JR4JSAHl9eT4uB77c3jfSgscuUr+3Z3rRd2ak9tnKBLn3XaF2v7B29ux9bVe5MNH6L/8CCxcveXH4clp9Xuyl/IQA93EyTsjLHpQz3QkEwUGYEiDT9C4smWQe2km7GpYXqlukPJDUIPkoZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAXxl4yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE28EC433F1
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710130910;
	bh=o5xMP4WKDy1XHDo+qgLrS0JvJcK8AfkBqSJlSn9v2xI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TAXxl4ylPUTqJ/i28KGSf/KHlDJE31JVJLTXO+gmXtesvQAPjWNrj3BKpv7sMhXgT
	 otBKxzr8crO06ooTNm+qwJH+zWqfNaXo8VJmk5/CO3UkUZI5JIZQs3l/nyVWH5AYbV
	 jV3BmkP6vdRV8Wesx2C/4tAn3PebzzdUURpld8QbmqTALs9DJ3aZsFaqa92C1Fp1jT
	 daZ9DfwHAv73fBkHtan1avYnLRAgHDTS5vwXeRcCB8lM+aFpPO1aV56xmJ42B6Fu/k
	 qIDbc/yMs9h7wjPa/fLt8o0XMUjYzJwM4J/ORZ78+w1uzmSp1OKwFdw//+PGnkWk8S
	 Oph6XfLeqSLPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C06E7C4332E; Mon, 11 Mar 2024 04:21:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Mon, 11 Mar 2024 04:21:50 +0000
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
Message-ID: <bug-218578-217253-knrkNHnlKI@https.bugzilla.kernel.org/>
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

--- Comment #2 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305975
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305975&action=3Dedit
Excerpts from DSDT in ACPI table

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

