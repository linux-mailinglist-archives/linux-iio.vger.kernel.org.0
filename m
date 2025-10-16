Return-Path: <linux-iio+bounces-25145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203ABE3B95
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D2974E9EBE
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3F198A11;
	Thu, 16 Oct 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKw5LmTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8531F4165
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621627; cv=none; b=ORIoOByanNiZN3xbNZMElYatafjn3YvrXgvZslGd3ojalvEZq91iRIyQ/6Eqr+DPdh+z+vYjnS70obuDl+v7DuEvC6s/IvC84LKGpSDmHnmjhMHx7vHSyACWPLHrN1jEi6rRTItEbBrcgNDHfXBsxPNeDH289KmJIxoGDuX0JME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621627; c=relaxed/simple;
	bh=046zc46vtgVHabRaXNHGC2eofcQaF2+a3t9NeraHQP4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3dwrtohzIykfJK3lYSiYx1VsAYwgMpdbAw8VF0xa5YJfWgmTI8svweGh7BaUei+tPFrJwlK3DXIlNyNB9hu9jfnZwvZcNkGa76eU8Vka5BULb396rL/lKFL88zymSn4jzhAfotBfz5Bx2Zt9iZvorUuCh9qt42cGmDLH+IJTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKw5LmTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 508D7C116B1
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621627;
	bh=046zc46vtgVHabRaXNHGC2eofcQaF2+a3t9NeraHQP4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eKw5LmTVBM2i/ymvoy7qmW6AtJPin6l/6ACH1MZU8K1K9gFoccEiF6OPmQ5JPspZi
	 82hoE7QFCuPDV+pcldOnZvtMvuF1AHHu1QlNmPw+qlfopbvlhAmX8O17OrUBEtM/T7
	 jWHv0vpqjCgqyB+cxSJUBk/Y4qmSKOgXGgMaTka8NSLnSwrYfCvX69Xjga2K5YJEYk
	 9Ug0/qeYxswzSO7LKE6NF2ZfY5FUQmOPDOVBxHBqHsnenyY0eSWsHMWVapL4WbfRwV
	 IyWGQttpfN5QHkNVJ3RZAAWivvfXApfSy9aX8oQzKyGxLEonvUmeELSKR++jzAnbn3
	 joTh8VX3DzDIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E9CEC53BC5; Thu, 16 Oct 2025 13:33:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220670] Accelerometer missing on cold boot (Lenovo Yoga 7
 16AKP10, Ryzen AI 7 350)
Date: Thu, 16 Oct 2025 13:33:47 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220670-217253-rdIpbkU58x@https.bugzilla.kernel.org/>
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

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
The main difference from your logs is that the warm boot from Windows 11 ha=
s an
extra device enumerated from the amd-sfh driver:

> dmesgAfterWindows11Boot.txt:[    5.878776] pcie_mp2_amd 0000:04:00.7:
> enabling device (0000 -> 0002)
> dmesgAfterWindows11Boot.txt:[   11.323615] hid-sensor-hub
> 0020:1022:0001.0004: hidraw3: SENSOR HUB HID v0.00 Device [hid-amdsfh
> 1022:0001] on pcie_mp2_amd

> dmesgCold.txt:[    5.881143] pcie_mp2_amd 0000:04:00.7: enabling device (=
0000
> -> 0002)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

