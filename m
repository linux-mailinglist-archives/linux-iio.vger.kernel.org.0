Return-Path: <linux-iio+bounces-27153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC04CCC939D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 19:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32D2C30203A6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C06249EB;
	Wed, 17 Dec 2025 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNkDLH1d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C45271448
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995081; cv=none; b=OPKSTF1JRhUHdLoGAAL+SZfY9ArnJvm79NYciZolou5M9JUDmI35tgtCE98q+jcI7wVhz7t/b6yXpBnkhosrwvrZzZ+ePtZl7jQDP4BXMPPp4tjnWPxNQyo6sz/ys7dyD2rKdw9xfRsvE9q5+hThgNeQCjeik3X3ZuecfV0uwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995081; c=relaxed/simple;
	bh=D8VzXhneEGg4vZwRoxLekAUp7JxQesHy/EO6KPYQzZ8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tdFfNJDGiafQs9DRptqsmqyAi+ca/bAE1o2fZMUmWtbB5xJoBPUXh93iLxzPWGq09rNfSWN0NKM5dknYSxnyIv4a/X0qfsbDOpgtkeEjzoXRngTlU8Xxr67DKM0/RksYnChz0N0dB30JZpAQuW9TI58ZWXNwRKFlGOepnxqDbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNkDLH1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A9D8C4CEF5
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765995081;
	bh=D8VzXhneEGg4vZwRoxLekAUp7JxQesHy/EO6KPYQzZ8=;
	h=From:To:Subject:Date:From;
	b=cNkDLH1dGiZszxCuvir9k6MNdy8aVGlYbxG4b1kvsvtHC1DNiHElJg7l1B1w/TFZj
	 tkZVexdiFd2/vZAsTKMvITibz41fLPhmxRm5kl18g3eGogQ44LpwzsmrbM/n4+stPT
	 EIgIqiqddzgC34VpeNsNt8CZkE3mhhfTQTKvzJXUoOYkHl7UzJppXI36r+GF7lbUBc
	 MG0p1024jrHzSA3qDdzf2Q16vR/M8BrB0TDIfR4yZa34/L3snUCZnUMR3EmJwbHJy0
	 NhHzBPFu4WZHqzM6CJ1RrIE6l2qCGpaLsg+026+RfrGB0kbxby5P6y6x7HqtqlzDII
	 gP9Ebzv6H72QA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 147DAC4160E; Wed, 17 Dec 2025 18:11:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220867] New: illuminance goes to zero after suspend
Date: Wed, 17 Dec 2025 18:11:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xaver.hugl@kde.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220867-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220867

            Bug ID: 220867
           Summary: illuminance goes to zero after suspend
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: xaver.hugl@kde.org
        Regression: No

Every time the system suspends, illuminance_raw reads zero, until it's not =
read
for a few seconds, at which point it recovers and reads correct measurement
values again.

Reproduction steps are
1. run "watch -n 1 cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw"
2. suspend, wake the device again. The output is now zero
3. interrupt the process, wait for a few seconds, run it again. The output =
is
now a correct measurement value

This is on a Framework 13 with a Ryzen 7840U, tested with kernel version
6.17.11.
It's not a recent regression, when I looked into automatic brightness contr=
ol
for KDE Plasma a few months ago, I already saw the zero readings once (but
didn't look into it further).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

