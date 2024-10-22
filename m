Return-Path: <linux-iio+bounces-10923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B59AA2DD
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397651C22298
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6819C576;
	Tue, 22 Oct 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXmEW4gA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FC19DF98
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603041; cv=none; b=LwFnFPVgN/uDPvKEqwghqXGRo7V3LU5HAvay4ciH2WI81BFSuI4lSvyhta9XYtV3XoKNqg/gMCB6L8X5x+SFFWv2tSIDNRxkr7ZjsXwU9YXKiMdWMb7U9FpPzNEjS0O+dOuVyvM/faQXATqezmqZr6owNRgOl2jYaBvb03olNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603041; c=relaxed/simple;
	bh=QSslLSObVKmMY4LfvHXBfYXa9hoZKsrEmg64wvcmxlI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pdgsXGSCjHL5wpS6bLBQL/7qgefA8f84HQ42bmBlUaXTfdJnrpt7r2BtcL11DR+YX5GVn/GYFOex0HdC3Zc3egVKPPkq5VPnK1ManOarr9Gu03N9NZPjoNO4UdyhD9caSHVRnGJYIB4BJkRsYX2iJTfsrGFuJz04ebr7nyToHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXmEW4gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C715C4CEC3
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603041;
	bh=QSslLSObVKmMY4LfvHXBfYXa9hoZKsrEmg64wvcmxlI=;
	h=From:To:Subject:Date:From;
	b=tXmEW4gAEr2J/bxOrUIAT/JTA8kvhkvlh1JJnABCYn+gCvFH89K6wLY+QOhKZMnnP
	 kO+S1TBHWPXS21uvg0cadFLGHSaJ8Fb+6pvWOGzSXEgRD4jmibJm61pit31phU+iPW
	 9LBMFTLQETNAg2FFLqGqmPPBRmRqbowS4ry5Owi3Vh/f9UZQzfpxglR8Xobj6sOTrK
	 o4q40RmH+uZTQ8FMlKiyYBC7vKsB/KGMnVH9HxNBeQbkMfH1iQHtHjdoCggoDr2Ugb
	 Q4h4a84bm7Z4LZsSazOVDkn9kZVIA1BjbaiqSg2nMS5SXK5uA9jAuefhCkWBGWJNbH
	 59Oz3Fre/FwIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 17B2AC53BBF; Tue, 22 Oct 2024 13:17:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] New: BOSC0200 Accelerometer Invalid chip 12
 initialization error
Date: Tue, 22 Oct 2024 13:17:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

            Bug ID: 219418
           Summary: BOSC0200 Accelerometer Invalid chip 12 initialization
                    error
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: cameraphone77@gmail.com
        Regression: No

Created attachment 307035
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307035&action=3Dedit
lspci output

Hardware: Acer aspire spin 3 A3SP14-31PT-38YA

One line summary of the problem:
BOSC0200 Accelerometer Invalid chip 12 initialization error

Full description of the problem/report:
The Accelerometer is not detected by iio and does not function

Kernel version (from /proc/version):
Linux version 6.11.4-arch2-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240910, =
GNU
ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sun, 20 Oct 2024 18:20:12
+0000


sudo /usr/lib/iio-sensor-proxy -v
** (iio-sensor-proxy:2007): DEBUG: 22:33:10.952: Starting iio-sensor-proxy
version 3.5
(iio-sensor-proxy:2007): GLib-GIO-DEBUG: 22:33:10.954: Using cross-namespace
EXTERNAL authentication (this will deadlock if server is GDBus < 2.73.3)
** (iio-sensor-proxy:2007): DEBUG: 22:33:10.991: No sensors or missing kern=
el
drivers for the sensors

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

