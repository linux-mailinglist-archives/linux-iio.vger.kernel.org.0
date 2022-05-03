Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A361518036
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiECI7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiECI64 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E368A18B3E
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA1C61266
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310F9C385B3;
        Tue,  3 May 2022 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651568122;
        bh=YYjIlAMbZFXS5TJCoxi+sB+JWOWMX+6tZaFa1o0muw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2l3ZWkhep32CTNWg4Z6WmHyDQXr2A68VXngqTwkYCGU3VscUFUkplmYzntWKB0N1
         PmhJvqL3zOC+Qp0HpPRGtT74bjqSj3IQSiQBtKLSzRsoZPeoyuhwcu3S6JH11xceQ9
         dUC4JsRpfdXeV+hcHb9pDUtiz59cXz84Gz0HazBNNMmqvofb9U8cxfEKENP8RSnL3Z
         o7xmrd5D36RgSLr2rZiAgLYiUcEQ/pRTRQFMG9z5+a91ea6JfLcNXO+biRSykH+7Zk
         Djrn/wYP4/ToYKuDwX4RBuvEJU7HB5kxF7HOhmrwQp2OX6STaFmYqMGfsWHZLgW4r1
         Oqgserkhc9wJw==
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
Subject: [PATCH 23/92] iio: adc: max1027: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:26 +0100
Message-Id: <20220503085935.1533814-24-jic23@kernel.org>
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

Fixes: fc167f624833 ("iio: add support of the max1027")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 4daf1d576c4e..f79fe49d69b7 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -272,7 +272,7 @@ struct max1027_state {
 	struct mutex			lock;
 	struct completion		complete;
 
-	u8				reg ____cacheline_aligned;
+	u8				reg __aligned(IIO_ALIGN);
 };
 
 static int max1027_wait_eoc(struct iio_dev *indio_dev)
-- 
2.36.0

