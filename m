Return-Path: <linux-iio+bounces-25146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D8BE3B98
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2C1D4E8EAD
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5371198A11;
	Thu, 16 Oct 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/mlO7+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F771D5CE8
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621649; cv=none; b=ixItrjpgb4Mog+dCcsWF4Mb56u+DwWx7wjkkvvLSWl07HWxoH7iUMOfszYxfe/Dsgmon0ZweYmlkmqezWHOyj7fKlRsxHG1orP64FY04c61zynC5WHcDjJmbXNzUdQ1Mn/SwtG2gArtz8DgrYhAJAaSmT5uKqjBvUb499NDjQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621649; c=relaxed/simple;
	bh=aJGMBv7xKUwiCpOSu2IDMBE7+CNsB2hTMBXos+9+C7k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqLa7BYf+X2cd/BGkwAYgljL5sHCu/xsTJrFznr2vSGz9QQOcVmEEPRbVtcjFZf/FR0XJPS1SejNir/wqJ9XKaofkjO1ApiDqrEoEmiPDsgPqdJv4aFBZGY8k9zv1QKqnGXbl6a+Pt8tHEt8VZg98ZtTbnYmtVtpwcO4Jn3fBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/mlO7+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB17EC116B1
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621648;
	bh=aJGMBv7xKUwiCpOSu2IDMBE7+CNsB2hTMBXos+9+C7k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n/mlO7+/a2gxl0/RvGkFCnFXHIXLwpp+PVtg8j64BS/wW5eo1keRYY77FGDdfvsV3
	 g1Z7r8Bqy53b4tg/pvYNjqXKKFtRToQnK7tRJIKyYiSuiqfb2pH/r+roy4dQeanugw
	 OhFvBMRkWTpWc1ehIb0RBZfo9NcDJOP8Eblit5KGXC1OPzmxQ3fYxNTayPoThjmGUS
	 E9unm2AVPg5+kzguD4q3YHxYIkLMW98mDKIxHqDPl1NjEhoUNAoVqNtMROwRIIm4nY
	 gD3XCbqyEEn5wLmUJh5VJjaJ6W2Q7yLbBEmsVu/EEq8Px8c/ZGxDnMBHJEjbzJEJl5
	 9poBGVZoBqesQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D533DC53BC5; Thu, 16 Oct 2025 13:34:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220670] Accelerometer missing on cold boot (Lenovo Yoga 7
 16AKP10, Ryzen AI 7 350)
Date: Thu, 16 Oct 2025 13:34:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Input Devices
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_input-devices@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to
Message-ID: <bug-220670-217253-sFd4Uv6H9L@https.bugzilla.kernel.org/>
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
          Component|IIO                         |Input Devices
           Assignee|drivers_iio@kernel-bugs.ker |drivers_input-devices@kerne
                   |nel.org                     |l-bugs.osdl.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

