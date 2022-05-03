Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60826518091
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiECJID (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiECJIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232471BEA4
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C06FBB81C97
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17986C385A4;
        Tue,  3 May 2022 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568665;
        bh=6ahk6GPr3iG/AnzIywU8mEvEbxtAE4DCjfpABrv1ZQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSQ9HQoTOeiq8CGsVIcKzrTroxkKlhDiBQtBiK9vooFTFFQi7M3Lh7kgaXKpUdZVq
         NR5UAwBQSzGjVUVuEBEaQgPFyg/N34Nwdx35W0F5ohGehYckyPBbdWCN6LzEqR18Zg
         sH5MsCpQZhX5BXLZgwuXkMFq64t+7LW3PTf06sdbLfGhur2XLoVkWgxP59G8/bmqCj
         +sYR8+pw70Fg0t5MX3AXMYUvzTgWbTBd5iejEn7bjICDHfQMxMsvzBl4Wz6ZkhlYtF
         kocbEEWqhzAKA6x2/Mll4Nj76GqvqG31SFTqNrW8B3Qv1buIePZHMjFcL0cPhRfZul
         tkd0NB99cA1Nw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 81/92] iio: potentiometer: ad5272: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:24 +0100
Message-Id: <20220503085935.1533814-82-jic23@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503085935.1533814-1-jic23@kernel.org>
References: <20220503085935.1533814-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_ALIGN definition.

Fixes: 79e8a32d2aa9 ("iio: ad5272: Add support for Analog Devices digital potentiometers")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/potentiometer/ad5272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index d8cbd170262f..e023c0f92242 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -50,7 +50,7 @@ struct ad5272_data {
 	struct i2c_client       *client;
 	struct mutex            lock;
 	const struct ad5272_cfg *cfg;
-	u8                      buf[2] ____cacheline_aligned;
+	u8                      buf[2] __aligned(IIO_ALIGN);
 };
 
 static const struct iio_chan_spec ad5272_channel = {
-- 
2.36.0

