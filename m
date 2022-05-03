Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58985518040
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiECJAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiECJAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 05:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4A36141
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 411CB6126D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97798C385B2;
        Tue,  3 May 2022 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568188;
        bh=V1hoaQTCsdNE7BC6xp608amDLKMrFoZ5Gr763uAhcDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZ35NCVQlwMnluY0FbUDycjeix8/9yDK+HG6T3qEUddU20XqqlEWJsgiVFR89oFzk
         XikTvwd5BvRId+uWZw78fyRBwLS8QngCOznwLCyGSjQRc480e5nIXZVsUzD1Xh1aDH
         GTJ3dq2pzbEltIVsLivrKQzC8kCA6Kz4qyodhm0zIGDI/hEeDYXXTs6eG9CKCMpF5d
         5e5+fBakIH0fr39gyU2Ux/KJPM3YuzA12E1Zxhbw4266p1ba/ncm5QdB4LtlAXvueP
         YtgQjlhhKvYvieFFamFm3JUJLAt1ADcUafO6SJ6RViVaPqx5ClA7TVajT+t7Q/wxPd
         rG/bCG4KLIR6w==
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
Subject: [PATCH 30/92] iio: adc: ti-adc108s102: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:33 +0100
Message-Id: <20220503085935.1533814-31-jic23@kernel.org>
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

Dual fixes tags as two cases that were introduced in different patches.
One of those patches is a fix however and likely to have been backported
to stable kernels.

Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
Fixes: cbe5c6977604 ("iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc108s102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index c8e48881c37f..4307d87d5400 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -77,8 +77,8 @@ struct adc108s102_state {
 	 *  tx_buf: 8 channel read commands, plus 1 dummy command
 	 *  rx_buf: 1 dummy response, 8 channel responses
 	 */
-	__be16				rx_buf[9] ____cacheline_aligned;
-	__be16				tx_buf[9] ____cacheline_aligned;
+	__be16				rx_buf[9] __aligned(IIO_ALIGN);
+	__be16				tx_buf[9] __aligned(IIO_ALIGN);
 };
 
 #define ADC108S102_V_CHAN(index)					\
-- 
2.36.0

