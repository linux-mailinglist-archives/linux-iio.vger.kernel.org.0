Return-Path: <linux-iio+bounces-23830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC9B47852
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 01:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166727C219F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C83280332;
	Sat,  6 Sep 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4aJ10Gl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302D279910
	for <linux-iio@vger.kernel.org>; Sat,  6 Sep 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757202137; cv=none; b=EdrUb5W7nITiVx4i+71DTUvM71TcOIbI7lwxIk0mABtWoP+qb/w1oAelSd2stLC5UUlpjYXYnxG989ZqPL4B5cohBkgqQcqOZVzS4W3ON548vMZEqaTR4GVLuHzUhr/O23xWJz6oksH2rHG7wf88FU/xyde/rcuUWiZNkZpVm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757202137; c=relaxed/simple;
	bh=LxKDJYjxEHRwtAf+0ckocc8PU/qwK1aqu0lE/2eoWVw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EDS2NEtLzb50biKjUA56XkoFtb14PMYCps1iIT6XMUSi4SZWFIzTXtSHtg3C7BhWA6XFYxFGgukdZEIOHzNyu5uyetzOFFEpWC5S3SAfJC2aRfBB/3Fo02LyGDsr7fWlqFjGr3R3MzKMbtbWJUHaJDXKMkLL7gGojv9njxI67CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4aJ10Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5319BC4CEE7
	for <linux-iio@vger.kernel.org>; Sat,  6 Sep 2025 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757202136;
	bh=LxKDJYjxEHRwtAf+0ckocc8PU/qwK1aqu0lE/2eoWVw=;
	h=From:To:Subject:Date:From;
	b=m4aJ10GlgyPOXAvtJl8PxtgNEGRqdSLCxoZX8RzgC9JAQi60XNtjd/sEi6lLSJ1st
	 obsmo2+miLyKNyWNfrEldwALpWA180DU7UnZuPWqZG0pwTczTRqmFQmRZoewx8STS0
	 oVTyXIkqnYHe1EGJCMoma7Wu8OBO0Ii6uQEMxGpc+rH3yd79D0I1d6mRfooY9ifMzV
	 PfvpBPzakij3ZNyZihGxpjY9r7qmb+MPklwfT++6m9A7ajVlTs2P9HX7OLrh3b4trC
	 drcx4OzWgdScQd0QOmn5D9ykW7KMAFjWYQQS9OFzmzDvUnUzmQLlLiYjKS3kOETOl3
	 J/iA2NO05KXzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 40A0DC3279F; Sat,  6 Sep 2025 23:42:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220543] New: MCP3428 scaling values are incorrect, three orders
 of magnitude low
Date: Sat, 06 Sep 2025 23:42:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: phil@munts.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220543-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220543

            Bug ID: 220543
           Summary: MCP3428 scaling values are incorrect, three orders of
                    magnitude low
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: phil@munts.net
        Regression: No

The values for in_voltageY_scale that the 6.12 kernel generates for the MCP=
3428
ADC are too low by a factor of 1000.

The ADS1115 and the MCP3204 get in_voltageY_scale values around 1.0 (implyi=
ng
millivolts per ADC step) while the MCP3428 gets values around 0.001 and low=
er
(implying microvolts per ADC step).

See also: https://forums.raspberrypi.com/viewtopic.php?t=3D391674

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

