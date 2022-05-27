Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B515365BD
	for <lists+linux-iio@lfdr.de>; Fri, 27 May 2022 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiE0QKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 May 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiE0QKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2022 12:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9F149AB2
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 09:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E810361DD3
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB9FC385A9
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667815;
        bh=EAghifMP9Sqo4rZBpZQmnKSKGQShGuAGtZToI1R2ghk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bNmX9CFdljGEG5LGyb3pOpouTX9TfWAAVf3uREw/jXqKkaJU7OjuoDWl1M56b2HHP
         L6NCiPMyF9VOiFw+Hvd/WylzI1n63QyojVXsXg3y+F1PBOU1mw4sWqD5mNNUa2jryd
         mys12ZYqg1pr9YriQexYJDV2ZkWTiTbKlsRDTtl3Oi7M0PLKRMY2Viqb+WcMAFuW5q
         poK8wq8jQFRf7TXafrofEnP4ebwq1MVPd/JRFPo8l8IYHAhdBX8I+MYkmDYcWad9/I
         WzuUZirW+RnQa7F26PW6XaIAbLM/7IRgfC97w7dgbtohGWyWwitvXc+S7hz03DEcuz
         EjBlyGUDZGXmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 46A51C05FD5; Fri, 27 May 2022 16:10:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date:   Fri, 27 May 2022 16:10:15 +0000
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
Message-ID: <bug-216037-217253-YjGNAkiU2n@https.bugzilla.kernel.org/>
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

--- Comment #2 from Nikolai (nickel@altlinux.org) ---
Created attachment 301059
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301059&action=3Dedit
DMIDECODE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
