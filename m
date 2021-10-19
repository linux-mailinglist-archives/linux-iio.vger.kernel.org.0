Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689894335F1
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 14:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhJSMaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 08:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 08:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4132960F02
        for <linux-iio@vger.kernel.org>; Tue, 19 Oct 2021 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634646480;
        bh=+DFUtGAUE2vIbAJ91ZT7xxTkqQuW7D6As4tKqPYmdhc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eohKwk3jVw/GwlS30zpJTQJgOoAydTJTYe3F+mLUJCHsF+y2vdtdHFt3tOfMN/7Xg
         chl3WlZXYVQ5MtENsyyKgsH9NPkJoxtGsLl0BLnmr4Ye4vZkt0lvxrVZZAyLCG6Dgd
         MStvL/WkyuBYaxNpQU911gkfB1XoR3sFYwgeM2sgcRHSK6n873Zm2CLzCuvvPJKdUu
         wxgHog6t8odcPqt6KUxNs+mzG6KtUpn1R1K3b6aiyERrXKyPSr4ba1mwdTVimYiyoj
         j8bSAy8GEGqllPq3zE8j2Wm5C6IAI07ocLeizgm08J9FoFYCGwJOwmXCeGI19PHayd
         MMsTNL+T7QIUg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2E35F610CA; Tue, 19 Oct 2021 12:28:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 214751] Lenovo Yoga Chromebook C630 i7 missing support for
 sound, microphone, touchscreen and gyroscope
Date:   Tue, 19 Oct 2021 12:27:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: I2C
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waownn@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component
Message-ID: <bug-214751-217253-8PWcALThML@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214751-217253@https.bugzilla.kernel.org/>
References: <bug-214751-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214751

waleed (waownn@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|IIO                         |I2C

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
