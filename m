Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721EC51EFD3
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiEHTRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiEHSBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:01:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC3558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD6A5B80E5C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B741C385A4;
        Sun,  8 May 2022 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032626;
        bh=VHRObeUHPp1UUaxwuHPxSEdTgJq9apOm2YfVEOXR94o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwKfZnZGV9+oWWxSBMTWvQp5Q8bSU+Q6BSF1qQP97gBIICPDoR+m6ap3FElaqAzdF
         Uvs6YTLpnjh59wzzxdL3hBT16rTYlflGN331DMhh6rOTMAKDIQF6F9kdMkpLIiR0Hp
         b8CD1LGLOZxlp2su1rAzDY0r9P//eIEnsfUZI6be/7N+RmJQik5FuTKmCWkzdvaFrE
         oBY/mUdomlPkqiADlQlMBOGLKlt5f0Ik3mD34XgR8L/U0n619a9Bym+1wHa83eO+Z5
         VXwiFdfQDZWauKq1CCSuljlKFg3/PK9SQOc06wShyPQ2JSt7jBVBByL/l3KenNfXb4
         X0aARiORV66qQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
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
Subject: [PATCH v2 64/92] iio: dac: ti-dac7612: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:56:44 +0100
Message-Id: <20220508175712.647246-65-jic23@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508175712.647246-1-jic23@kernel.org>
References: <20220508175712.647246-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
IIO_DMA_MINALIGN definition.

Updated help text to 'may' require buffers to be in their own cacheline.

Fixes: 977724d20584 ("iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ti-dac7612.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 4c0f4b5e9ff4..8195815de26f 100644
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
+	uint8_t data[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
-- 
2.36.0

