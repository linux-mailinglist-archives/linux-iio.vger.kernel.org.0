Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89AD3F0256
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhHRLM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:28 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50709 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhHRLMV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0A6256000F;
        Wed, 18 Aug 2021 11:11:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 09/16] iio: adc: max1027: Create a helper to configure the channels to scan
Date:   Wed, 18 Aug 2021 13:11:32 +0200
Message-Id: <20210818111139.330636-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These bits are meant to be reused for triggered buffers setup.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 4a78c9cbc339..223c9e4abd86 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -236,6 +236,22 @@ struct max1027_state {
 	u8				reg ____cacheline_aligned;
 };
 
+/* Scan from 0 to the highest requested channel */
+static int max1027_configure_chans_to_scan(struct iio_dev *indio_dev)
+{
+	struct max1027_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/* The temperature could be avoided but it simplifies a bit the logic */
+	st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N | MAX1027_TEMP;
+	st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
+	ret = spi_write(st->spi, &st->reg, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int max1027_configure_trigger(struct iio_dev *indio_dev)
 {
 	struct max1027_state *st = iio_priv(indio_dev);
@@ -391,14 +407,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 		if (ret)
 			return ret;
 
-		/*
-		 * Scan from 0 to the highest requested channel. The temperature
-		 * could be avoided but it simplifies a bit the logic.
-		 */
-		st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N | MAX1027_TEMP;
-		st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_configure_chans_to_scan(indio_dev);
+		if (ret)
 			return ret;
 	} else {
 		/*
-- 
2.27.0

