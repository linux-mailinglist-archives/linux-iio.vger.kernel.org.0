Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3C31B7DD
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBOLSz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhBOLSw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 06:18:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5685864E5E
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613387892;
        bh=5Kv2Sf1SzTXi5BftQnaNuRz8Kyi6sNHmQrXWNXVUbWU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LGzJwavHDOhOqH1k7skbMmth13X7knoCkVDxTuitbF+JNEgJ2GLdCeihsPr4x2uhf
         ZwLIATyOS8R8owTsGyD/oZxi0jRouiSXxji6N91xb6SClWXwnDEcw/eBe6So+xLNL4
         4Cp+6vn1clWKTlalzwTTdw+VExDW5fwNMVnWBwvzXl+hXxZDICUJO5eVR03Y9dnxQa
         C6Ox/L+GeK6dfdAb+YyxhBH+hBFIuJ6OrpAYDkpsppHMHHc0TFPvUDl3/KczRUnINs
         HxKqTmOpp4V7F8iGkHzeG4nefEv9cHuZ16X1fOOk4LT/0BEdMQ15xvSMl7RFCRCSRT
         /k9Ts+wcpE9/A==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4E53B6001D; Mon, 15 Feb 2021 11:18:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200493] drivers\iio\magnetometer\hmc5843_i2c.c unchecked return
 value of devm_regmap_init_i2c() in function hmc5843_i2c_probe
Date:   Mon, 15 Feb 2021 11:18:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-200493-217253-AYyMBIuhr9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200493-217253@https.bugzilla.kernel.org/>
References: <bug-200493-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200493

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com
          Component|Other                       |IIO
           Assignee|drivers_other@kernel-bugs.o |drivers_iio@kernel-bugs.ker
                   |sdl.org                     |nel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
