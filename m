Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929C3E32C0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 04:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHGCgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 22:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhHGCga (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Aug 2021 22:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 40E3B60200
        for <linux-iio@vger.kernel.org>; Sat,  7 Aug 2021 02:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628303774;
        bh=6B6etEEt2TKaBQ/s70ftjJTaIGBFcvn3mcqCPTjWJBM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fxAr0ipldHg7LeDxpxmsaJwLdjfKCLNRIG0kihyQw8bwxZSplBowSLL0TNf3VAmCC
         3bN1/fXGpiLjongJ0OUvhOy9vQqpPE8KOITHVYnwvG1SzthVAYRH4tr9yWzeLMmSBH
         HZtDb5DOEs8fVBA10vvg0HXSFDhPSM3v8MXFGYchrOlbKXL+pU89hMX7pMyTs0p2f1
         d4w0kGimyDXSqrf8Wg/Dh1SMxZ7nH8xGOZ08Gd7pWhQZOn5XDM5DkrTPyykD7MpIH5
         /nsCDGe0ofYat5eIsdfTEPDtYDxhvyELheQJKRSTMfR4G1npGark7neRoysYGESMCX
         k40pJDI/Wf8UQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2B67960F70; Sat,  7 Aug 2021 02:36:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 213979] needs unknown symbol errors building
 cros_ec_sensors_core
Date:   Sat, 07 Aug 2021 02:36:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jason@montleon.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-213979-217253-xVAhPJd0YD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213979-217253@https.bugzilla.kernel.org/>
References: <bug-213979-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213979

Jason M. (jason@montleon.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Jason M. (jason@montleon.com) ---
Andy, Guenter, thank you for your help. I apologize for filing this and tak=
ing
your time. It looks like an issue with the script Fedora uses to filter mod=
ules
into the kernel-core and kernel-modules packages.

The modules under drivers/platform were getting filtered out (removed) while
the iio/common modules were left in place before it was running depmod, whi=
ch
is what resulted in the warnings. I modified the script a bit and my custom
build worked.

https://src.fedoraproject.org/rpms/kernel/blob/f34/f/filter-modules.sh.fedo=
ra

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
