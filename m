Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D395A4D09
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiH2NI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiH2NIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 09:08:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95784AD50
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 06:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AF2CB80F9F
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 12:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E03C433C1
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661777861;
        bh=/KzowYfFq8ADESJGEPiEPrMxBvQnCKmAC8tewrNF94U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uAj0AEzgl6SwbjnVU0Afg/BzVvEik+cNmGiqqPl9J+F4w4u/Dyxk2+nL4F3EE3v6R
         VuM+JYJUfRPc+XfKXtFdQZLc6hjv7Iwx7a4rULBDi++5ylDfsqxujAGrnwdf7w7GaV
         yA1WO9uj799fXiBOlO1H3xVaACIe+4WNkYFoXNHN4WPCMnKLd7XMdptrY2GL7mZdp0
         GMmRHgntaCI5HCTzh0k4Khe6mnKN72bP0S/X3NSuY9O/CHvT68kyKD67MUsftrlkXx
         zz24l078xrzBVny4iRSeTqxjFCflkWt7SHmo38/iMeDCU948oTdB8CRsovbQ2Hl3K9
         a2SIdTbJPGcjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 09382C433E7; Mon, 29 Aug 2022 12:57:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200775] Cannot read the accelerometer raw data from the sensor
 LNG2DM
Date:   Mon, 29 Aug 2022 12:57:40 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200775-217253-MSpOFfXy9G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200775-217253@https.bugzilla.kernel.org/>
References: <bug-200775-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200775

--- Comment #6 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
What's the status of the issue? Can we close it?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
