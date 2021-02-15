Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089B531B7E2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOLTw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhBOLTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 06:19:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C1AD64E5E
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613387946;
        bh=TkDeaejjy1pjlPa1Rm9lKIO0+o9MuycQSgETacNQ7rI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ItcKg2vbRkyeSVaoI9opmVRzIbnpq2R2oUwM//9tsM0Z1DG6fxXQmH8WNRf81Qyxc
         sbS+yi28U6SuVJTwW31yaEOY6zZF7esCq7TRhNDyMpu21AJUhNtKHKZ9sIT+UktxzP
         k4p0DCpU8pj+sgbbeCFphDCcTzRB6rn0G9nVTlatCMGYEfUj2wlVr7veYjIUGk6LPD
         QtpAmvuZDqXa9FvOk/kf/WrQOmdWh3yzP6HSBKNXfomp5F4+cG2qk5PMl0UNP9lj0s
         aGnhlgzl0yVtdNeBQ1gVwJ8hI1Vk0an5njXIBmyhltgg+WQ+B7MDJ7rkPprFdf12UC
         dHez2CIKhk06w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 135F96017D; Mon, 15 Feb 2021 11:19:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200555] Missing check of the return value of
 devm_regmap_init_i2c() in drivers/iio/magnetometer/hmc5843_i2c.c
Date:   Mon, 15 Feb 2021 11:19:05 +0000
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
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-200555-217253-czEG1PtAnW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200555-217253@https.bugzilla.kernel.org/>
References: <bug-200555-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200555

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com
          Component|I2C                         |IIO
           Assignee|drivers-i2c@kernel-bugs.osd |drivers_iio@kernel-bugs.ker
                   |l.org                       |nel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
