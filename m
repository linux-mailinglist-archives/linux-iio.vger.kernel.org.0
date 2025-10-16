Return-Path: <linux-iio+bounces-25144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF6BE3B83
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2AF407398
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3C338F40;
	Thu, 16 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG+gvt/Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F617A2E8
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621466; cv=none; b=E4VgS1w+lH/rmyfYwex1AApfSbsmXvdceJe8RPwDUWyD2XswPi2YNFWXhHkOQzws1zXG0yYfoVfvUqxdjkmR/kFJAsn95NrkujWU2rdOWUUVCDC2ZioFTH6OTwQl4S/+dXtUzPweCd/NGwqd1ZZxWdNuBmc9cjeVukJES5UKvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621466; c=relaxed/simple;
	bh=H7zfAUmqs4RUvyXwPQonO80zMHnwSQGs8geJbbo2ZKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvuxlzSKf/LAd2t4Farwq2R/pHSGsWJ2ZknBBSTP7RBTh/CqmXG8ZQM6W4GssC8RHz5agZeHg1Ue1aGWRivQB3unUUypvKIltnMrLUIpEZ7v7wf7MHyHumTNpt1BZ65BKlLgtwVj2glH2KxJGTSFzZhVHDYU9Omcf3NPh3fLi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG+gvt/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7FBC116B1
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621464;
	bh=H7zfAUmqs4RUvyXwPQonO80zMHnwSQGs8geJbbo2ZKY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PG+gvt/Qvc6n3JSYYwLLwRjMCjVBZU7hmCJKt+oMs7cOgGpsdSoGOlgpkAKsYOuwH
	 g+9YUbrRAJFkru4wmE+ZqwBQJPKIQhYpiqv0xso269k9EUQM5r8MTwKDlJQwVMaUC6
	 3SCFoQ0vMnXygg0RNv6Kvz1C9uw0pB/1/2/AXLTT5YqXMI/OgCG2uTJIuZ8Vh/kLSn
	 Z4XqIC+z88PvsnQiHYi4Jtwi7LBBXZqv79DiRTPvvmzR7uLb7gM77JRSkgztl5RGRy
	 IT7ulTthPhQvr3KOLqxE5YKXXHmrmPaKW65aRX0GUKv8ee92QMATcqctm5Vg903ApB
	 0WO01s1ucaoIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1FF07CAB780; Thu, 16 Oct 2025 13:31:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220670] Accelerometer missing on cold boot (Lenovo Yoga 7
 16AKP10, Ryzen AI 7 350)
Date: Thu, 16 Oct 2025 13:31:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-220670-217253-GSEbMnHjS1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220670-217253@https.bugzilla.kernel.org/>
References: <bug-220670-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220670

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com
          Component|Platform_x86                |IIO
           Assignee|drivers_platform_x86@kernel |drivers_iio@kernel-bugs.ker
                   |-bugs.osdl.org              |nel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

