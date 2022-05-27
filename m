Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F905365C4
	for <lists+linux-iio@lfdr.de>; Fri, 27 May 2022 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiE0QLX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 May 2022 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349155AbiE0QLW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2022 12:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83251339
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 09:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E16D61DB2
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82F0FC385A9
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667879;
        bh=BM1LxoayAFFjiz/phtrDNtif2fg2XIqjGtMZ2hiFbdk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vNlmFdRm4QJo1xNRREXZ99rIWp8IkU/wJH2xIx7mHJMI7vmEbD7SgvQEXJFET/qzn
         zekLKnLliBtPPvyLCOkeECEg04EtlV1zghCA0cUhTAJx6SiCNJF5q686avjVsDVlbz
         86TDLiRmOGcjoShMhdDR2GnxygWD5Qz8sOl8WwWdvKXGEfXVEyq0ctljqJDkk5fpR/
         t4p4lnB8vOCqBs2CDj1+zbSh1vLdjFuqVsGkoCiNNOme9d1rYyVHF72FWHbIXTauu3
         Rifar+I5Ns9DkZNwPOcPFU7s5RGclEGXDMOtFWmi8ZwNX0ctQZ+AfgyCVuQAv0yxg4
         vXS2UTw0g2YxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6B819C05FD4; Fri, 27 May 2022 16:11:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date:   Fri, 27 May 2022 16:11:19 +0000
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
Message-ID: <bug-216037-217253-EgOLR6zTFl@https.bugzilla.kernel.org/>
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

--- Comment #3 from Nikolai (nickel@altlinux.org) ---
Created attachment 301060
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301060&action=3Dedit
udevadm info --export-db log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
