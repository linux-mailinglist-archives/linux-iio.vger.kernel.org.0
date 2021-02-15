Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677831BAB9
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBOOHu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 09:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhBOOHt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 09:07:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8FDAF64DCF
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613398028;
        bh=yir/b8qeJ4MjAibLYVClmNKRsLr5AXHXdZ6hpVmZf0A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XcgyUACd+anODQH5sdLNo5fSe2N0Yue86+r2xmGFRh3YCVK436o4+4j3G0zBmQ4M9
         Z1hf+xw2RhoyFZJfLyoYoTUHOWOCpyjQtnz4eqw4JHoOG3Uh/HH0qopFM4DGwjx69r
         +8WkPbmu2WEPL2a0CyTgAsPmiUfHBDyR3RqaJQjZE71yhfXHknkRC6b1vrgncqoCeV
         cXVONsE41zRrwz/naznfyaWzd1ajMt+wF5o1sQG1TMqVXEJ5hXmaHxLNen7qHynOBV
         80KmDKztppCDfYkxhJ3eD5E+lTY79A4uIsbwU5afV3ByH3xTAOM8XjXtU7iWlpvpqg
         5rKMO9XSK/tOw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7129C6017B; Mon, 15 Feb 2021 14:07:08 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200493] drivers\iio\magnetometer\hmc5843_i2c.c unchecked return
 value of devm_regmap_init_i2c() in function hmc5843_i2c_probe
Date:   Mon, 15 Feb 2021 14:07:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-200493-217253-FdI0g0gmiF@https.bugzilla.kernel.org/>
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

Jonathan Cameron (jic23@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jic23@kernel.org

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
Long fixed. 536cc27deade8 ("iio: hmc5843: fix potential NULL pointer
dereferences")

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
