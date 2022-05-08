Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A851EFFE
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiEHTSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbiEHRxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 13:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C75DFC5
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DFDD61286
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39144C385B0;
        Sun,  8 May 2022 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032182;
        bh=hjQgsBhbT7ICmgPO0M6ZbutIAZpaN/baR8k265nazXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfJWBXwjm0zWltzpWyAm750dLvdjXPX0kr7EyCz1m/szF2dvEowkckngH2Z2m3Y3F
         U0lnwdw3W1suN9wTciQYf5s1cNx9e6CYkhQtyoyISj21R/Y8l3mhwytigoUTKDBfJP
         06QVN92XFUHkUZKR1L25XHz5jdycC/NHC6V4za348ySh0Ug2vtLrNvRgwTC1+wXF8u
         KF+X3iF5jOcEVFNWAcx1qOLaJShFyfAxlG8FycO62nz8nxYLtqyELD0ORKNue+yzpT
         7Uk2XGfnHSMv91NTU6142c8E+QXvVTCo8Hr+yThmb705Waftl9scREhB8t+yqpdPkp
         SH9ISEidMmfQQ==
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v2 04/92] iio: accel: adxl367: Fix alignment for DMA safety
Date:   Sun,  8 May 2022 18:55:44 +0100
Message-Id: <20220508175712.647246-5-jic23@kernel.org>
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

____cacheline_aligned is insufficient guarantee for non-coherent DMA.
Switch to the updated IIO_DMA_MINALIGN definition.

Update comment to reflect that DMA safety may require separate
cachelines.

Fixes: cbab791c5e2a5 ("iio: accel: add ADXL367 driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/accel/adxl367.c     | 2 +-
 drivers/iio/accel/adxl367_spi.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 62960134ea19..d680bec05efc 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -179,7 +179,7 @@ struct adxl367_state {
 	unsigned int	fifo_set_size;
 	unsigned int	fifo_watermark;
 
-	__be16		fifo_buf[ADXL367_FIFO_SIZE] ____cacheline_aligned;
+	__be16		fifo_buf[ADXL367_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	__be16		sample_buf;
 	u8		act_threshold_buf[2];
 	u8		inact_time_buf[2];
diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 26dfc821ebbe..118c894015a5 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -9,6 +9,8 @@
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
+#include <linux/iio/iio.h>
+
 #include "adxl367.h"
 
 #define ADXL367_SPI_WRITE_COMMAND	0x0A
@@ -28,10 +30,10 @@ struct adxl367_spi_state {
 	struct spi_transfer	fifo_xfer[2];
 
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers live in their own cache lines.
 	 */
-	u8			reg_write_tx_buf[1] ____cacheline_aligned;
+	u8			reg_write_tx_buf[1] __aligned(IIO_DMA_MINALIGN);
 	u8			reg_read_tx_buf[2];
 	u8			fifo_tx_buf[1];
 };
-- 
2.36.0

