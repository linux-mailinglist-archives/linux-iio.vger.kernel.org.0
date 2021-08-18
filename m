Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2753F0251
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhHRLMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43365 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhHRLMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:20 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AC2E860011;
        Wed, 18 Aug 2021 11:11:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 07/16] iio: adc: max1027: Create a helper to configure the trigger
Date:   Wed, 18 Aug 2021 13:11:30 +0200
Message-Id: <20210818111139.330636-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are two ways to physically trigger a conversion:
- A falling edge on the cnvst pin
- A write operation on the conversion register

Let's create a helper for this.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index a6ebc951c09a..59914fcfd320 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -232,10 +232,37 @@ struct max1027_state {
 	struct iio_trigger		*trig;
 	__be16				*buffer;
 	struct mutex			lock;
-
+	bool				cnvst_trigger;
 	u8				reg ____cacheline_aligned;
 };
 
+static int max1027_configure_trigger(struct iio_dev *indio_dev)
+{
+	struct max1027_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2;
+
+	/*
+	 * Start acquisition on:
+	 * MODE0: external hardware trigger wired to the cnvst input pin
+	 * MODE2: conversion register write
+	 */
+	if (st->cnvst_trigger)
+		st->reg |= MAX1027_CKS_MODE0;
+	else
+		st->reg |= MAX1027_CKS_MODE2;
+
+	ret = spi_write(st->spi, &st->reg, 1);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			"Failed to configure register (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int max1027_read_single_value(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     int *val)
@@ -248,14 +275,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 		return -EBUSY;
 	}
 
-	/* Start acquisition on conversion register write */
-	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2 | MAX1027_CKS_MODE2;
-	ret = spi_write(st->spi, &st->reg, 1);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev,
-			"Failed to configure setup register\n");
+	ret = max1027_configure_trigger(indio_dev);
+	if (ret)
 		return ret;
-	}
 
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
@@ -363,12 +385,10 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
+	st->cnvst_trigger = state;
 	if (state) {
-		/* Start acquisition on cnvst */
-		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE0 |
-			  MAX1027_REF_MODE2;
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_configure_trigger(indio_dev);
+		if (ret)
 			return ret;
 
 		/*
@@ -382,10 +402,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 			return ret;
 	} else {
 		/* Start acquisition on conversion register write */
-		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE2	|
-			  MAX1027_REF_MODE2;
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_configure_trigger(indio_dev);
+		if (ret)
 			return ret;
 	}
 
-- 
2.27.0

