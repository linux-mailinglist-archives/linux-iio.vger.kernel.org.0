Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC85BD12B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiISPh4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISPhy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:37:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF32A712
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4747B81BEC
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A944C433C1
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663601871;
        bh=YbPxC7rdDy/zPm5CPr4irjrpM3bC+zc7YX7WtNYoENg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s8AY/1aHLNfZxfz35j1ztfaFEzM4u/PbW7N9253fv04fWWCn+Vn6ML9k7RsMo9R3S
         U2XRkj+1XBcg0hOv/DuAKl2V3T/8FdnMcoOUwVOaqTZLiwe/EpSzpta1KOley5AXZp
         iNdW7IEfTDaQ+HlylOdRLlewfaBG+d/fjY8gmJP2Gv1rmcQyjyV5RB7Q2KfAufJDje
         uM80Jd4Nf4624cHrH2cQCalGqyt3ocJZ/5vISiLXmxhLouNt7VLnXS8xUKywTnjhYq
         ZZH7hr3XXjJj/I3yrZkoU3b76VTx1T4UkdoqUGSpwMCrVRcO1NyMwqn7fsaX+6xCi/
         ErQx8aS0LBhiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 658E3C433E9; Mon, 19 Sep 2022 15:37:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200775] Cannot read the accelerometer raw data from the sensor
 LNG2DM
Date:   Mon, 19 Sep 2022 15:37:51 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200775-217253-qO3eZWzCcz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200775-217253@https.bugzilla.kernel.org/>
References: <bug-200775-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200775

--- Comment #8 from Jonathan Cameron (jic23@kernel.org) ---
On Mon, 29 Aug 2022 19:47:50 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D200775
>=20
> --- Comment #7 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.=
com)
> ---
> Without OEM's help, we can't resolve. It is possible that Windows also
> polling.
>=20

Annoying though it is to leave a user stuck.  I would suggest closing this =
one
given no means to obtain required info to debug.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
