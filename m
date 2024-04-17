Return-Path: <linux-iio+bounces-4323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4EE8A8C25
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3EC1F2258A
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E428DB3;
	Wed, 17 Apr 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQzLmK/e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633661DFF0
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382348; cv=none; b=b9PGqzIDYFbvWTcimahonWgZxO69Y6d3Zf5TUgX4kWip3mDEXtWiVa2AdvRIM/jIHEHRPv0wapm5wwooL3cDxbyE68Q16vSk18nHVbxps/qw7NDc6wbN2fddbsX6okobtkMyrrNXz0R9tRdjOTbIW0fg6eCpEDPW+056Mbo+Ix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382348; c=relaxed/simple;
	bh=UiN5hoFKpdS51MgJIwsHIkMIlUaXyQxtC2lVRCgyBh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITjITr4yMwVWdKu7HJDFW1hFAIp8FTKFBrw9HUZQK/gw0Yi6FChryo9AFybPtGHJ4SUgiHtq9VeeAV/FRcc6FNBJi53mQs6poLWGpsgnB4ukygOMOp3aB/QviEEYDxZ3f+ke2QB8lWcFLbd7dEkeBIKqh45RbR3eYqu9Rj18Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQzLmK/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3635C3277B
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713382347;
	bh=UiN5hoFKpdS51MgJIwsHIkMIlUaXyQxtC2lVRCgyBh4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jQzLmK/ej3H2ppGgCKTWdSnGRW3pRFaxFq8PD19W56/fac8JFdlDsUlPdUg5FrDCK
	 UPc5qjOMeFDl9L8Vnr5KaiKsP/b5s9f0Vn/SOisxy2a5K2V/n07zNA6LaKo2C/oEwd
	 YGjkx8zXe2VIealXAU2gRX3tPaCKUjv9pf0HfHEVEB/bpWS+mXf54uMklXbWBcDF1E
	 7RkImwiITttamCa+taNmyeXfByxsWEOF9PpZvc2P5YXWvUpcdQu3IaxHJbQR1XvOMX
	 XQK0qbuMPID+XS5QUjb7+vjAZYNd6YEKAK/4UnQ3tkYxmwox8KtsBdvIiqZvpN8XbQ
	 YkHUIMzqct0Yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D362AC433E2; Wed, 17 Apr 2024 19:32:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 17 Apr 2024 19:32:27 +0000
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
Message-ID: <bug-218578-217253-F6mi9tjKWS@https.bugzilla.kernel.org/>
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

--- Comment #30 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Ok, so my first build failed due to some diskspace issue on the builder. A =
new
successful build with the patches to parse the "ROTM" ACPI method is here:

https://koji.fedoraproject.org/koji/taskinfo?taskID=3D116519225

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

