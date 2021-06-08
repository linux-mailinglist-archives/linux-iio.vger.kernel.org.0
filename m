Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6639F0ED
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHIaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 04:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhFHIaX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 04:30:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D9BEF61263
        for <linux-iio@vger.kernel.org>; Tue,  8 Jun 2021 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623140910;
        bh=On0/cUW6/O33AVxWqPkiIrJ0jgjnWXIq8QgYo+wlLIE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jmnLAxXEGD6/2aSmWpWHmVGmO9i2s6n/XmPQRMSkQwqb5E89L87FARXAqqo+edG92
         Zq3jh7lACNbwfb690nDHDOrW7dlgM4E/Du088Ji6HOJPcw6jm7Q9fcwLqtOp0uhO1g
         8xbiMgqSnrO87SeWwKK1CnVjtFsJxLb9WDm7ASTFFZLKpLrT5A6jwP9AJpiYs+VMPF
         qUfY/eZGthwocL15lOJjPxUgmZ/ejDGJXPOibh1HnIEjzoVkMzp2l05ZAepGvpE44w
         3+dRMpcWj1boFfGoMYXKb0c5P9kvx2mVZbvFGRSYcvAs71x+GQFL+23vDduBLgvz3b
         /CSmhwp2gGZ0g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D1ADB610CA; Tue,  8 Jun 2021 08:28:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 209889] iio: adc: build error due to unmet dependency for
 MFD_STM32_TIMERS by STM32_ADC_CORE
Date:   Tue, 08 Jun 2021 08:28:30 +0000
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
Message-ID: <bug-209889-217253-00Kggd2nGQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209889-217253@https.bugzilla.kernel.org/>
References: <bug-209889-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209889

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #1 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
commit 121875b28e3bd7519a675bf8ea2c2e793452c2bd
Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Sun Jan 24 19:50:34 2021 +0000

    iio:adc:stm32-adc: Add HAS_IOMEM dependency

    Seems that there are config combinations in which this driver gets enab=
led
    and hence selects the MFD, but with out HAS_IOMEM getting pulled in
    via some other route.  MFD is entirely contained in an
    if HAS_IOMEM block, leading to the build issue in this bugzilla.

    https://bugzilla.kernel.org/show_bug.cgi?id=3D209889

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
