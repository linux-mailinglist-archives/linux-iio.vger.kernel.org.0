Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095813FF571
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbhIBVPr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:47 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51635 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbhIBVPo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 126AB24000E;
        Thu,  2 Sep 2021 21:14:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 07/16] iio: adc: max1027: Create a helper to enable/disable the cnvst trigger
Date:   Thu,  2 Sep 2021 23:14:28 +0200
Message-Id: <20210902211437.503623-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max1027.c | 41 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index efea5ea14615..7611d96fc901 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -257,6 +257,25 @@ struct max1027_state {
 	u8				reg ____cacheline_aligned;
 };
 
+static int max1027_enable_trigger(struct iio_dev *indio_dev, bool enable)
+{
+	struct max1027_state *st = iio_priv(indio_dev);
+
+	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2;
+
+	/*
+	 * Start acquisition on:
+	 * MODE0: external hardware trigger wired to the cnvst input pin
+	 * MODE2: conversion register write
+	 */
+	if (enable)
+		st->reg |= MAX1027_CKS_MODE0;
+	else
+		st->reg |= MAX1027_CKS_MODE2;
+
+	return spi_write(st->spi, &st->reg, 1);
+}
+
 static int max1027_read_single_value(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     int *val)
@@ -269,14 +288,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 		return -EBUSY;
 	}
 
-	/* Start acquisition on conversion register write */
-	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2 | MAX1027_CKS_MODE2;
-	ret = spi_write(st->spi, &st->reg, 1);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev,
-			"Failed to configure setup register\n");
+	ret = max1027_enable_trigger(indio_dev, false);
+	if (ret)
 		return ret;
-	}
 
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
@@ -382,11 +396,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	int ret;
 
 	if (state) {
-		/* Start acquisition on cnvst */
-		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE0 |
-			  MAX1027_REF_MODE2;
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_enable_trigger(indio_dev, state);
+		if (ret)
 			return ret;
 
 		/*
@@ -403,10 +414,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 			return ret;
 	} else {
 		/* Start acquisition on conversion register write */
-		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE2	|
-			  MAX1027_REF_MODE2;
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_enable_trigger(indio_dev, state);
+		if (ret)
 			return ret;
 	}
 
-- 
2.27.0

