Return-Path: <linux-iio+bounces-8773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514A95E2DE
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7D11F2202E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68474429;
	Sun, 25 Aug 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeRue/OW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F02AF07
	for <linux-iio@vger.kernel.org>; Sun, 25 Aug 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724578538; cv=none; b=QLONk0tFq4g0vp7n76aRqXq3cQ9WPBpPl+7pehwaFXDqpogxBZ9kjJelWIH4OENGDu8/EN9i5lyr6wcxpW9dlGoJhuSOJSlavWZy0CefLruXbvV9LbsmCbMm65V1Pc0nRp0SCchXdC2/pp5V/ZbuFUpvShcIzj8/sJHv8n2A1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724578538; c=relaxed/simple;
	bh=z76ncXcBhtnBEX5DgePG8kGAsXpHzLiYb/JJnsXR4+o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bbfkpHm22QjwxwfavmKRXKfRKV8EDTzyPngJPjDwOAiWtlAt+5zMx0Esacbj5fWGHBhrDRQiwzzPESR8o6QNVARFu8cAtfoyn4kn32RNcn8fTg1zlCCZPITHXbekCYFHcrds5Uzym4cEeCy9/On3XKI+7lIt3ntkfwVcvzROHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeRue/OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C29B9C32782
	for <linux-iio@vger.kernel.org>; Sun, 25 Aug 2024 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724578537;
	bh=z76ncXcBhtnBEX5DgePG8kGAsXpHzLiYb/JJnsXR4+o=;
	h=From:To:Subject:Date:From;
	b=aeRue/OWhgI3nnLB1boP9UCT/X5HmoQSyEZvQM9cqhju+7FtC3uduRX04BjsLgsxJ
	 m8vGQzm8N80nIpKSWwIzdgXF9K1EAzsuJfpUHjId++8uWLcdOvv2LHQItwG9bGR92p
	 eravJzW7V7cHtChaAGriPpgz8+PXXxZGffzQEYfY8FWKXVP2SwVNmVTMwP+ssljRv2
	 zPBQcY+KtsGoxYkwcCcqItuS6cGr8RQTV/qY8GOw/44opFDvWN8cM4Gyo2dUL9QTLm
	 Xs1w/0mTu2bivw/U2Rn/CFcS+7Slok0sznTq+IBhcPvyjESr38N8jTS3AUd5Y55DF2
	 iQxo4h0d6BWVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0998C53B50; Sun, 25 Aug 2024 09:35:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] New: drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sun, 25 Aug 2024 09:35:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

            Bug ID: 219192
           Summary: drivers/iio/imu/adis16400.o: warning: objtool:
                    adis16400_write_raw() falls through to next function
                    adis16400_show_flash_count()
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw() falls
through to next function adis16400_show_flash_count()

Kernel: 6.11.0-rc5 vanilla
GCC compiler: gcc (Debian 14.1.0-5) 14.1.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

