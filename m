Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14863FF57A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbhIBVPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35473 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347175AbhIBVPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 92EF9240002;
        Thu,  2 Sep 2021 21:14:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 14/16] iio: adc: max1027: Don't just sleep when the EOC interrupt is available
Date:   Thu,  2 Sep 2021 23:14:35 +0200
Message-Id: <20210902211437.503623-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt will fire upon end of conversion. This currently can
happen in two situations: either the cnvst trigger was enabled and
toggled, or a single read was requested and the data is ready. The first
situation is already covered while the second is not. Instead, a waiting
delay is applied. Let's handle these interrupts more properly by adding
second path in our EOC helper.

Rename the interrupt handler to a more generic name as it won't only
handle triggered situations.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index b85fe0a48ff9..e734d32a5507 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -256,15 +256,27 @@ struct max1027_state {
 	struct iio_trigger		*trig;
 	__be16				*buffer;
 	struct mutex			lock;
+	struct completion		complete;
 
 	u8				reg ____cacheline_aligned;
 };
 
 static int max1027_wait_eoc(struct iio_dev *indio_dev)
 {
+	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
+	int ret;
 
-	usleep_range(conversion_time, conversion_time * 2);
+	if (st->spi->irq) {
+		ret = wait_for_completion_timeout(&st->complete,
+						  msecs_to_jiffies(1000));
+		if (!ret)
+			return ret;
+
+		reinit_completion(&st->complete);
+	} else {
+		usleep_range(conversion_time, conversion_time * 2);
+	}
 
 	return 0;
 }
@@ -457,12 +469,24 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static irqreturn_t max1027_trigger_handler(int irq, void *private)
+static irqreturn_t max1027_threaded_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	struct max1027_state *st = iio_priv(indio_dev);
 	int ret;
 
+	/*
+	 * When buffers are disabled, no trigger is in use but if we are here it
+	 * means that the device IRQ is enabled:
+	 * this is a single read EOC interrupt, we only need to call complete()
+	 * and return.
+	 */
+	if (!iio_buffer_enabled(indio_dev)) {
+		complete(&st->complete);
+		return IRQ_HANDLED;
+	}
+
 	ret = max1027_read_scan(indio_dev);
 	if (ret)
 		dev_err(&indio_dev->dev,
@@ -501,6 +525,7 @@ static int max1027_probe(struct spi_device *spi)
 	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
 	mutex_init(&st->lock);
+	init_completion(&st->complete);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1027_info;
@@ -516,7 +541,7 @@ static int max1027_probe(struct spi_device *spi)
 	if (spi->irq) {
 		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 						      &iio_pollfunc_store_time,
-						      &max1027_trigger_handler,
+						      &max1027_threaded_handler,
 						      NULL);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
-- 
2.27.0

