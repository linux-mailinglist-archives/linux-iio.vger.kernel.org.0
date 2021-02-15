Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118A231B7F2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBOLXh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhBOLXc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 06:23:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A22A964E73
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613388172;
        bh=+/XzwVMxHYObBMFrDksQD3l3pgf+iF/Dxm26F3YwTkM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mtgcBXA9MlKM11Jq/qB+57SwCBDkMaRmiG75CzD2xLmLyOuP3dlJo6so6laN4j8sR
         uS5Z3Hp8hlsYvywomCoJ0WZfHsFrrdBGpytXzb3N2t441lxwwDwQg4wPxyML2HIxig
         RUoCESniiXcoxBcOeXir1rXKDRcf8gFBXIsYMz1ciSzWxd+USo9K8rWU4iX4dRdNXg
         JRXImBPsez4Pc70IQep67sizn5wpW+C+NVI3IXY4Ws6/tOjhB9y3Xir6F5E2Fw4YID
         Y9lLaE1foOim4v9uckQHTj9EYTQ4fVuwxb2inIsY8AX/mCK3lxw5TGtNOTTlJLTO/a
         5keBIvTGGobSQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9E8B860180; Mon, 15 Feb 2021 11:22:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 211741] amd-hid: add support for SW_TABLET_MODE
Date:   Mon, 15 Feb 2021 11:22:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Platform_x86
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_platform_x86@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-211741-217253-NT99iclmgo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211741-217253@https.bugzilla.kernel.org/>
References: <bug-211741-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211741

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com
          Component|IIO                         |Platform_x86
           Assignee|drivers_iio@kernel-bugs.ker |drivers_platform_x86@kernel
                   |nel.org                     |-bugs.osdl.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
