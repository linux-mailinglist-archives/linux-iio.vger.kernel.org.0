Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108931BBE7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 16:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBOPI4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 10:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBOPIK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 10:08:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 12F7164E2B
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613401649;
        bh=TcjS5SbwC0qS/TQc+GCR6W37AiIaolEMJOrZsNFjPOo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rtymTeqMIZ+9T4sBbdmLSXrL/6JIG6bJLPH4hs3WaKiYnArBJMPsegjG5U32PF/wG
         ASzv6xc8lRwnVs5NeQaTvg15mxBSWlDFA89+m9KIewh0vwGjRXzmpbafMOiTgOgX8K
         hg8URgV9XZyqIXElKXi6Kzw4iblWSLYUylAqtway111dB0gn3ir5vcRSVuIT/wwEqO
         S0DfBU/x4nZu+7J5bsrjQAH/Ld+r74iPbvu4/xdoQGa0IwUByNnRn52qFbvcg78esw
         zsQDw4GxPDR7H2FyKlOZwB7lHEk2/y3lcjjDj/WRn/AmmMM1zpmmkFumkhYvWPt9y4
         oVY0a2CugXhyw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id F201760180; Mon, 15 Feb 2021 15:07:28 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200493] drivers\iio\magnetometer\hmc5843_i2c.c unchecked return
 value of devm_regmap_init_i2c() in function hmc5843_i2c_probe
Date:   Mon, 15 Feb 2021 15:07:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-200493-217253-Yy1XksFVjI@https.bugzilla.kernel.org/>
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
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
