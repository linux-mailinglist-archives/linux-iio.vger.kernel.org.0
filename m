Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8E31B233
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNTV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 14:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhBNTV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 14:21:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 395E564E2C
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2021 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613330448;
        bh=qy0f2PeNPEzh/MIL98hFDxdmC+Zq8mm/uScATLmTZws=;
        h=From:To:Subject:Date:From;
        b=T8Jm3WPIQ2fRLZluOOchQdw3Re1nsdZ2mUWmbH3UgJLoF90AQ3bduPqJmBhsBmC63
         P48ggQhbnKmo/XEmDyCrqbg2ytLYQVSQN5EV3hyBZoMECbqUX8GCgrgMSPWl5vfhF6
         jB1/gVfL6QZ9i8bmhK3uaWVmtdL/uiXyRg5E3pY3wTQVC39oRWHRR6A4Q33STWIkOI
         er4j8bDHYZBN92nsUp3R+cdSN4Cc0TS6mdY/Y70U1XbN9TzwWzOzsYQkiUnKtHafP4
         zfBifOJJ1KnrExY6qMwtFpa6LbzM0iMXjyt1dQOQTRZWbvYWs1rpV8j7qEXuJc4Eur
         IzJatvFDTbh6w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2465465371; Sun, 14 Feb 2021 19:20:48 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 211741] New: amd-hid: add support for SW_TABLET_MODE
Date:   Sun, 14 Feb 2021 19:20:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luya@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211741-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211741

            Bug ID: 211741
           Summary: amd-hid: add support for SW_TABLET_MODE
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.0-0.rc7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: luya@fedoraproject.org
        Regression: No

On a convertible laptop running on a mobile AMD Ryzen series like a HP Envy
360,  SW_TABLET_MODE failed to run preventing the disabling of keyboard whe=
n a
device is folded in tablet mode.

The issue is similar to https://bugzilla.kernel.org/show_bug.cgi?id=3D20743=
3 for
Intel HID suggesting either a driver or a firmware bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
