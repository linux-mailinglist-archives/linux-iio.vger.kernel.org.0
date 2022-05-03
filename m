Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76957518076
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiECJFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECJFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58D12AAD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 02:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF3461301
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D0C385A9;
        Tue,  3 May 2022 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568508;
        bh=vzAIERssUbeu4RCKLbdA/hikDWlcdSLHntt8ptxFeRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVhGHmsWnLG6SZ8aK8wmyzNtonZIt1CJR3o1xv/Xakjq4VQi4Zy35ajkwJ6KFqTkg
         jHh20iQ71se/1hYheCO1pApwX5FP9lEYPIjj8TUqkDAPRG7OO8Hy5/nl2P1fIuhufE
         4qg44z4FL+fL/QSDnEDju9Bkr7RwmzpkwUH1kj6OLWd1bLR41Fv6a14TUvfBNslEvI
         mETnQt1x8YbN7cxoiEOnpQKezuzu31W5IPPkXvnDU207Q2KbiSdOEgqcBXJORBxpTO
         GVfVZZza0k3N3QiqTxyGC+TUTfhXTMierTWSExuMWayOi614J2gyc2hSGy5B+49K1N
         /KReHq2xLcjtg==
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
Subject: [PATCH 64/92] iio: dac: ti-dac7612: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:59:07 +0100
Message-Id: <20220503085935.1533814-65-jic23@kernel.org>
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

Updated help text to 'may' require buffers to be in their own cacheline.

Fixes: 977724d20584 ("iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>
---
 drivers/iio/dac/ti-dac7612.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 4c0f4b5e9ff4..d118df004539 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -31,10 +31,10 @@ struct dac7612 {
 	struct mutex lock;
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	uint8_t data[2] ____cacheline_aligned;
+	uint8_t data[2] __aligned(IIO_ALIGN);
 };
 
 static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
-- 
2.36.0

