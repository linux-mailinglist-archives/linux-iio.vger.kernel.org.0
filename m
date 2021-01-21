Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0F2FF53F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 20:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbhAUT7L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 Jan 2021 14:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAUT6w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Jan 2021 14:58:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0E07C23A5C
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 19:58:12 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F0E698671E; Thu, 21 Jan 2021 19:58:11 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 209883] iio: light: build error due to unmet dependency for
 IIO_TRIGGERED_BUFFER by VCNL4035
Date:   Thu, 21 Jan 2021 19:58:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-209883-217253-6AdXj6TMio@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209883-217253@https.bugzilla.kernel.org/>
References: <bug-209883-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209883

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com
          Component|I2O                         |IIO
           Assignee|lars@metafoo.de             |drivers_iio@kernel-bugs.ker
                   |                            |nel.org

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
