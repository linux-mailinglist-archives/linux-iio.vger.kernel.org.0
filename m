Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84D5365BC
	for <lists+linux-iio@lfdr.de>; Fri, 27 May 2022 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiE0QJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 May 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiE0QJn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2022 12:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BF9149AAB
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 09:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D059A61DCB
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D80C385A9
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667781;
        bh=akEc/Gpz4TeePC2vBo/aACfs+dagqvfZVxj3/hcTiGw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LKyfODdD1Wilt0LDQInPMKAolymO5RIKlMaEhEzJsaUZDMKsVyhUVE/siR1mqhWjG
         tSG/wmH+/7ydEMMhc6dNwkPvUWhVdq7oy27MAB/A3SywkXubiZTJhgJ42hk7n0e1l/
         pZW8MqtiHhckiUjXPXhibcN0TUPZ8NsMbj8kUWQq5F8LS18pT7SOW9kn2+C2boFQ2z
         sYo+HC0PaC4+0r1f4r5AHntSfkJIZGnlEvS8mCACLYbFqyuz7xtZfftKnnXoySrvQp
         Je5vG0k8n6cigJWFMHYQjPgseDqlLyFRkf2m8x/iSzzcznJz558o4hOO+wkD7KVKTm
         BENHj9sP+/hnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 311D4C05FD5; Fri, 27 May 2022 16:09:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date:   Fri, 27 May 2022 16:09:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickel@altlinux.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216037-217253-YGhyTvacaq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216037-217253@https.bugzilla.kernel.org/>
References: <bug-216037-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

--- Comment #1 from Nikolai (nickel@altlinux.org) ---
Created attachment 301058
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301058&action=3Dedit
ACPI DSDT

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
