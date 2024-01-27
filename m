Return-Path: <linux-iio+bounces-1937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899983ED40
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B952E283503
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B525605;
	Sat, 27 Jan 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP/gxaaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3F2575A
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361583; cv=none; b=cPiT3r6Cad6pR0s/1lpUCFh4TzMLSFYKO0w4XStafLqjXmevMHap7Je7IH24DibUml1BNMiNBDxmuG3Em+0hx3vPdhXUez9/sJfi1Bmvdw/gB5q/puw0KMlrvx6vTIibhJPBhXL4LvVzf3dK2LKsfKOTplpZKl8AS2e8uNgrRVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361583; c=relaxed/simple;
	bh=9olPHtuRjpliJGJQAqrqZl+39+iaBfHIxf0GzTVQWIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrQDdgIUACoL9vFUy0bVe5MBNFYv3mgc5T9HryZjJBEyRUkNnJsq3zHiTVYxkSn1gN2PlPRCOIBEezsZlJsUUgmQPwLXsRL2jmdBZ8dc1GXLh/eTMGwtSOWR+kQ2mljsdeKg/FToJKi3c/6gHw4uik+RE+cXhj/j5DCS307n4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP/gxaaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD49FC433F1
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706361582;
	bh=9olPHtuRjpliJGJQAqrqZl+39+iaBfHIxf0GzTVQWIQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OP/gxaaQJVfMdxy4EAgSYQ1SDnM2FTJr1Q/B1UQp4/obE+qiWZsdVScHZMrMulWSY
	 vS4697NxV/ArRz10hGO2TTftHjPrBNuciMPOM6SSczkPpkwZ+sXa/grcz+PglQEcjb
	 yn427qnZGVh/1/y9BYhY62BRJitT8S2ZOePLRqzTc4Mh4fhLMRlZZAoTsGReIFgIls
	 RPAB5z2Vm2PyGqHA8joiccyKAyd2knt+Ohb5+8qvQkxjBrYdLVpeZCVxe7VY0h3Ktp
	 ARKG3TGI0tRa21UrDi/+Kkciju4BpC/UGcMcCdNc/MXrDG+5XUGjnb6bNF/GdSVpl8
	 iX0SDcQnUs27w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B3CC6C4332E; Sat, 27 Jan 2024 13:19:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date: Sat, 27 Jan 2024 13:19:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: I2C
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: freedman.joshua@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214751-217253-FQHt7TePAW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214751-217253@https.bugzilla.kernel.org/>
References: <bug-214751-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D214751

--- Comment #6 from Josh (freedman.joshua@gmail.com) ---
Disregard; wrong laptop

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

