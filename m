Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDE5A54B7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiH2Trx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2Trw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 15:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0E75CC9
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 12:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8A66062B
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 19:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D227C433D7
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661802471;
        bh=uNnBbS5Q+s+KlX2ltnHL9UcvwS3FZnjpblm3nKRhgDw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uhUeTEYJk9QENKSeP1T66xnMXLW/meB3Dx25FJRnAZvyqMO0NOYre3OhV83rJutZr
         yKTfERLBbkWiFwqxxd8w1LhdpjSoDUwp0dOU8aDMqKy+0jL0wj/kiQcSeLf0Abd8dJ
         A/lged3SCJDN4NV23oHqP+wT0szwcmOSzboDYt+ez1tohWMWrGf/K1zgCzekMW78iY
         m8zbe9MEPLAssaT50rNycXI4PyA4Vv0yEK14X2YK3HY34JWvQA808dZy4DwmFzJDJL
         5yedOy7JHBdeqdFSjmA1fAb51oy7l7Ja0MJR2QS9UciO3R2Ae8ieVs733eYb7oqqNQ
         xqbsDEnqXwwjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E3E24C433E4; Mon, 29 Aug 2022 19:47:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200775] Cannot read the accelerometer raw data from the sensor
 LNG2DM
Date:   Mon, 29 Aug 2022 19:47:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200775-217253-w3BktBUZkz@https.bugzilla.kernel.org/>
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

--- Comment #7 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
Without OEM's help, we can't resolve. It is possible that Windows also poll=
ing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
