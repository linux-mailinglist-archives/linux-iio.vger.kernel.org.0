Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA64132F3
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhIULz7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:55:59 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38337 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhIULzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 57092240015;
        Tue, 21 Sep 2021 11:54:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 09/16] iio: adc: max1027: Create a helper to configure the channels to scan
Date:   Tue, 21 Sep 2021 13:54:01 +0200
Message-Id: <20210921115408.66711-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These bits are meant to be reused for triggered buffers setup.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 62570953653a..254df6a28cd8 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -271,6 +271,19 @@ struct max1027_state {
 	u8				reg ____cacheline_aligned;
 };
 
+/* Scan from chan 0 to the highest requested channel. Include temperature on demand. */
+static int max1027_configure_chans_and_start(struct iio_dev *indio_dev)
+{
+	struct max1027_state *st = iio_priv(indio_dev);
+
+	st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N;
+	st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
+	if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
+		st->reg |= MAX1027_TEMP;
+
+	return spi_write(st->spi, &st->reg, 1);
+}
+
 static int max1027_enable_trigger(struct iio_dev *indio_dev, bool enable)
 {
 	struct max1027_state *st = iio_priv(indio_dev);
@@ -402,7 +415,6 @@ static int max1027_validate_trigger(struct iio_dev *indio_dev,
 static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-	struct max1027_state *st = iio_priv(indio_dev);
 	int ret;
 
 	/*
@@ -416,17 +428,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 		return ret;
 
 	if (state) {
-		/*
-		 * Scan from chan 0 to the highest requested channel.
-		 * Include temperature on demand.
-		 */
-		st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N;
-		st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
-		if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
-			st->reg |= MAX1027_TEMP;
-
-		ret = spi_write(st->spi, &st->reg, 1);
-		if (ret < 0)
+		ret = max1027_configure_chans_and_start(indio_dev);
+		if (ret)
 			return ret;
 	}
 
-- 
2.27.0

