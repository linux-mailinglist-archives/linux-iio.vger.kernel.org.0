Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B406751801E
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiECIz4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiECIzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6C20BFD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 01:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 765B4612DD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 08:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26F0C385A9;
        Tue,  3 May 2022 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651567941;
        bh=qM//c9ayuCqnoyQxEHD2ne7ItUofq48CK9Nuw0vQYM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMGVIYotC34U7aPBduKrrOqWRreRp1byN5Nx/aw2ZbqXSkMlegeV9A8gYzhA7kX/W
         aibz9B3n6eNnlbB+McWWTfDsvLGVI5j1aJL7IuDHKx/7Q3yYRRiepc2FLvqzJ2sS6q
         wMi5cv9YjLsWwt43c+7IwQfd8Cxqn5+vDT9utV18FmaHxqtrr825ntNicFb8xPYUJz
         7s/wnLwHtoE33m4BSIjjVCZUfFeWUE6q8JftCrGNHZrEUsiV0IGQUrV++viu0BjJbi
         2iJ2x+m8UlDLSge+C0Uh0v1JfMM2V0N9OE+57n2a0OMdPxx19Jmbohce/XI16wiUrK
         EKaEjJzDZubhw==
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 04/92] iio: accel: adxl367: Fix alignment for DMA safety
Date:   Tue,  3 May 2022 09:58:07 +0100
Message-Id: <20220503085935.1533814-5-jic23@kernel.org>
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

____cacheline_aligned is insufficient guarantee for non-coherent DMA.
Switch to the updated IIO_ALIGN definition.

Update comment to reflect that DMA safety may require separate
cachelines.

Fixes: cbab791c5e2a5 ("iio: accel: add ADXL367 driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/accel/adxl367.c     | 2 +-
 drivers/iio/accel/adxl367_spi.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 62960134ea19..9b933c5715c3 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -179,7 +179,7 @@ struct adxl367_state {
 	unsigned int	fifo_set_size;
 	unsigned int	fifo_watermark;
 
-	__be16		fifo_buf[ADXL367_FIFO_SIZE] ____cacheline_aligned;
+	__be16		fifo_buf[ADXL367_FIFO_SIZE] __aligned(IIO_ALIGN);
 	__be16		sample_buf;
 	u8		act_threshold_buf[2];
 	u8		inact_time_buf[2];
diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 26dfc821ebbe..872b1c5a2cc5 100644
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
+	u8			reg_write_tx_buf[1] __aligned(IIO_ALIGN);
 	u8			reg_read_tx_buf[2];
 	u8			fifo_tx_buf[1];
 };
-- 
2.36.0

