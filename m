Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73E40C8F7
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhIOPxU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50071 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhIOPxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:53:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B0A48200015;
        Wed, 15 Sep 2021 15:51:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 13/14] iio: adc: max1027: Deeply rework interrupt handling
Date:   Wed, 15 Sep 2021 17:51:16 +0200
Message-Id: <20210915155117.475962-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155117.475962-1-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt will fire upon end of conversion. This currently can
happen in three situations:
* a single read was requested and the data is ready
* the cnvst (internal) trigger was enabled and toggled
* an external trigger was enabled and toggled

So far, the driver only supported raw reads without involving the IRQ
and internal triggering. The internal trigger was actually the only
possible trigger, leading to shortcuts in the implementation.

In order to clarify the interrupt handling mechanism and extend the
software support to external triggers we must do all the following at
the same time:
* Create a hard IRQ handler only handling the EOC condition:
  In this handler, check if we are doing a raw read or a triggered
  read: maybe we just need to call complete() to unlock the waiting
  process, maybe we also need to push samples.
* Create a threaded IRQ handler only executed upon EOC condition only if
  the internal trigger is used: as said above, the goal of this threaded
  handler is to retrieve the data and push it to the buffers.
* Create another threaded IRQ handler that will be registered with
  devm_iio_triggered_buffer_setup(), in order to fully handle an
  external triggering event (start conversion, wait for EOC either by
  busy-waiting or with the completion object unlocked by the hard IRQ
  handler, retrieve the data, push it to the buffers).

In order to authorize external triggers, we need to drop the
->validate_trigger() verification.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 90 +++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index e0175448c899..9bf1c563042f 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -270,15 +270,26 @@ struct max1027_state {
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
+		reinit_completion(&st->complete);
+		if (!ret)
+			return ret;
+	} else {
+		usleep_range(conversion_time, conversion_time * 2);
+	}
 
 	return 0;
 }
@@ -418,17 +429,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
 	return spi_write(st->spi, val, 1);
 }
 
-static int max1027_validate_trigger(struct iio_dev *indio_dev,
-				    struct iio_trigger *trig)
-{
-	struct max1027_state *st = iio_priv(indio_dev);
-
-	if (st->trig != trig)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -473,13 +473,67 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static irqreturn_t max1027_trigger_handler(int irq, void *private)
+static bool max1027_own_trigger_enabled(struct iio_dev *indio_dev)
+{
+	int ret = iio_trigger_validate_own_device(indio_dev->trig, indio_dev);
+
+	return ret ? false : true;
+}
+
+static irqreturn_t max1027_eoc_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct max1027_state *st = iio_priv(indio_dev);
+
+	/*
+	 * If the buffers are disabled (raw read) or an external trigger is
+	 * used, we just need to call complete() to unlock the waiters
+	 * which will themselves handle the data.
+	 */
+	if (!iio_buffer_enabled(indio_dev) ||
+	    !max1027_own_trigger_enabled(indio_dev)) {
+		complete(&st->complete);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * When using the internal trigger, the data handling is done in
+	 * the threaded interrupt handler.
+	 */
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t max1027_int_trigger_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	int ret;
+
+	ret = max1027_read_scan(indio_dev);
+	if (ret)
+		dev_err(&indio_dev->dev,
+			"Cannot read scanned values (%d)\n", ret);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t max1027_ext_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	int ret;
 
+	ret = max1027_configure_chans_and_start(indio_dev);
+	if (ret)
+		goto out;
+
+	ret = max1027_wait_eoc(indio_dev);
+	if (ret)
+		goto out;
+
 	ret = max1027_read_scan(indio_dev);
+out:
 	if (ret)
 		dev_err(&indio_dev->dev,
 			"Cannot read scanned values (%d)\n", ret);
@@ -496,7 +550,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
 
 static const struct iio_info max1027_info = {
 	.read_raw = &max1027_read_raw,
-	.validate_trigger = &max1027_validate_trigger,
 	.debugfs_reg_access = &max1027_debugfs_reg_access,
 };
 
@@ -517,6 +570,7 @@ static int max1027_probe(struct spi_device *spi)
 	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
 	mutex_init(&st->lock);
+	init_completion(&st->complete);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1027_info;
@@ -534,7 +588,7 @@ static int max1027_probe(struct spi_device *spi)
 	if (spi->irq) {
 		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 						      &iio_pollfunc_store_time,
-						      &max1027_trigger_handler,
+						      &max1027_ext_trigger_handler,
 						      NULL);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
@@ -561,11 +615,11 @@ static int max1027_probe(struct spi_device *spi)
 		}
 
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
+						max1027_eoc_handler,
+						max1027_int_trigger_handler,
 						IRQF_TRIGGER_FALLING,
 						spi->dev.driver->name,
-						st->trig);
+						indio_dev);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
 			return ret;
-- 
2.27.0

