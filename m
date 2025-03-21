Return-Path: <linux-iio+bounces-17180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4730A6C00D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 17:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4C31896C51
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0A22D4D6;
	Fri, 21 Mar 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmDxkczr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2322D4C5
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575003; cv=none; b=Qwe5NykL3igviVhGHiS5unxeCzHMxKS9FAFabIsZ4s5ZvKF17xXVkmFHd3sFfB4bS9THZiacOqIMz1lnrv+C89ZJ455w8CIQcvN1O5eM77/rFCnf1YthRU9W7Q4ipMWuhplhjwtVceHPMSopOI42GEqzi24m/1Ax/I3vY+RIggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575003; c=relaxed/simple;
	bh=g6smKiQnADp7sFDjyf8UdkjFxuqqLs92YsC8De5O0rc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzPjgKvoT230AtAXHpDplp0+070awg3xMlU09/ocC+No84B5doTIvbbdkPk4oNE06u+QohseaI+CX5CibNghgHR/h1mZaA+5fJUl1WzOORlfHuJS3ekLeYoNyBkcmQd8W8ba9WQ1amSx8IuV8Idm+uEG7mZVK8G4bpCmTO/rKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmDxkczr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D427C4CEF2
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742575001;
	bh=g6smKiQnADp7sFDjyf8UdkjFxuqqLs92YsC8De5O0rc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NmDxkczr2R8mp9TYrJeHkqCbbOeuS/W+HvKVMLLOkEw2t0+prVF8C8Ayq1CxHFuzS
	 wz6+6LJ5sJSLpD/jYlg7WXQF5L9JscHtDvAO4d7QDYDup2kcwtOWMsAHBYboy+1rWt
	 vTu0sxWASJbJ7L1uYMvXRdLGdnbu7QsiFOyeeiMDP9lNdHD0CGVl/tw4ECRALKqf+6
	 D0z3joInolqiCElHE6LVYD4zEIAW6ACCVIz4GrW3Dj9QSqha8GvYhjAl1PvLFBUte3
	 A4JDB9uQ4ZWx6PdY3P0uYg7+ZJGpsPE8MVJvDv5OBF2KmHmCPaE5IE7BEoY7BVLfdn
	 fdqDtffvdvKNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 49C45C433E1; Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Fri, 21 Mar 2025 16:36:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-o0IYnOub2M@https.bugzilla.kernel.org/>
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

--- Comment #29 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
That is the observation from test program also. This sensor when polled, it
sends a response which probably is incomplete (may in in flight). But in
buffered mode, no needs to poll.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

