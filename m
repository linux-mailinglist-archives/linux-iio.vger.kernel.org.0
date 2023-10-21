Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FED7D1BD5
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjJUIxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUIxe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 04:53:34 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07060106
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
        s=protonmail; t=1697878405; x=1698137605;
        bh=5zSt/69qjIS5nkceCpXWJeBki/maOUNuElIaw6BQIRM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=pg+ncpM39D6XbqN2wquzI3vNsvQzohDqZFyFoukDLuZtGXZ8cCKLchpuVm1zn9JJP
         nuHXp/+EmZSEXDjzuqyG2HG2Pu2XKs30DnLy5GbaYY+EjV3tosH+3ckNTkPq6ESYVq
         5Qzh6ldg15jlKRS4MUe9lthKLQWSWbse1XSrH5KR2vy4bOg8xAaeYfVXoPetCz6Kxy
         UFexYm2Z9pqShO/ze1uJgnhLylhL+lyEkvgDCEB+B/LEgXgq3HV7d9pHrJyxoYmNCb
         yALRD/cRmX57j4C/luryCwG/sz8TKWa/KkJSSPJC+eGHSIsk15wva54iSQvgvgB3ET
         53KbJKs+DY94g==
Date:   Sat, 21 Oct 2023 08:53:17 +0000
To:     jic23@kernel.org
From:   Matt Ranostay <matt@ranostay.sg>
Cc:     linux-iio@vger.kernel.org, Matt Ranostay <matt@ranostay.sg>
Subject: [PATCH] mailmap: Change email mapping from previous employers
Message-ID: <20231021085250.21431-1-matt@ranostay.sg>
Feedback-ID: 87502384:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt@ranostay.sg>
---
 .mailmap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2643b7203a74..f06431ac148e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -381,9 +381,10 @@ Matthias Fuchs <socketcan@esd.eu> <matthias.fuchs@esd.=
eu>
 Matthieu Baerts <matttbe@kernel.org> <matthieu.baerts@tessares.net>
 Matthieu CASTET <castet.matthieu@free.fr>
 Matti Vaittinen <mazziesaccount@gmail.com> <matti.vaittinen@fi.rohmeurope.=
com>
-Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
-Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedal=
ley.com>
-Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
+Matt Ranostay <matt@ranostay.sg> <matt.ranostay@konsulko.com>
+Matt Ranostay <matt@ranostay.sg> <matt@ranostay.consulting>
+Matt Ranostay <matt@ranostay.sg> Matthew Ranostay <mranostay@embeddedalley=
.com>
+Matt Ranostay <matt@ranostay.sg> <matt.ranostay@intel.com>
 Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
 Maulik Shah <quic_mkshah@quicinc.com> <mkshah@codeaurora.org>
 Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
--=20
2.40.1


