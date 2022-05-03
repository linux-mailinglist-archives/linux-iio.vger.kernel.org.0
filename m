Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105B51802F
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiECI6D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECI6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8EC35ABF
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1078B81BE0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251AC385B3;
        Tue,  3 May 2022 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568067;
        bh=/BNk9/AlOPchEdgEbpPVzhIEOuH6okWywZLnZ66GgGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJViwevIO+PFx3ynllppohdgacUltAfG3PpHvtDkh0r6kH0EtNMh014dTpeQpmA4h
         +HRHI+teSnb+8KxJlBs95Z+iCQNGXHfMWZ7mdgLpiKFb7o/JXnnv17+Lp8oHe5Ns13
         ddpAI6R6d8yfwDRNTT0CfmOlv8yUkMt5ziCT2wJP7ceIJ3twivsnMEzhUFG8QRbbMM
         w5DcDxOnEsVyh/Xjg68kf7bU85zMkSpCsuUG54tABAVLpCU3nLqjS5syuRmLdObLFG
         aRu/GCGIibQEyuzG7iHj9cBiTDoTtaUVeGPNiRLeGKjdDRwZ0OU5+2GEKH2kvvi00L
         Nl2v6FNVd6Ccw==
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
Subject: [PATCH 17/92] iio: adc: ad7887: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:20 +0100
Message-Id: <20220503085935.1533814-18-jic23@kernel.org>
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

Update the comment to include 'may'.

Fixes tag is clearly not where this was introduced but it is very unlikely
anyone will back port it past that point.

Fixes: 65dd3d3d7a9b ("staging:iio:ad7887: Squash everything into one file")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7887.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index f64999714a4d..17b20d2085f9 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -66,13 +66,12 @@ struct ad7887_state {
 	unsigned char			tx_cmd_buf[4];
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
+	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 * Buffer needs to be large enough to hold two 16 bit samples and a
 	 * 64 bit aligned 64 bit timestamp.
 	 */
-	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)]
-		____cacheline_aligned;
+	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)] __aligned(IIO_ALIGN);
 };
 
 enum ad7887_supported_device_ids {
-- 
2.36.0

