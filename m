Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E227148B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 15:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITN17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 09:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgITN16 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:27:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DD521D42;
        Sun, 20 Sep 2020 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600608477;
        bh=JgLm+j74F6WXeyVFEYg4oB4A1WyYbFLJ6fshxKiapxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXqthgvcIvW56fs9sQDSJuIlZGdpNG1NQ0aVGvAxrfYgPSIRRdccY/gei9q8DoC7G
         IhDcAZNrtD1ZBTQzhCE0LHK0PasPGj1+cn251D/3DsHknmV/OS7C7Qq0jjYOiQzlTR
         HK2oqi0BbYGMDa8nAi4SgyU5P7GC+xub542+jG+k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Oder <me@myself5.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: [PATCH 2/2] iio:trigger: rename try_reenable() to reenable() plus return void
Date:   Sun, 20 Sep 2020 14:25:48 +0100
Message-Id: <20200920132548.196452-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920132548.196452-1-jic23@kernel.org>
References: <20200920132548.196452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As we no longer support a try again if we cannot reenable the trigger
rename the function to reflect this.   Also we don't do anything with
the value returned so stop it returning anything.  For the few drivers
that didn't already print an error message in this patch, add such
a print.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Christian Oder <me@myself5.de>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nishant Malpani <nish.malpani25@gmail.com>
Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>
---
 drivers/iio/accel/bma180.c             |  9 ++++++---
 drivers/iio/accel/bmc150-accel-core.c  | 12 ++++--------
 drivers/iio/accel/kxcjk-1013.c         | 10 +++-------
 drivers/iio/accel/mxc4005.c            | 16 ++++++----------
 drivers/iio/adc/at91-sama5d2_adc.c     |  8 +++-----
 drivers/iio/gyro/adxrs290.c            |  6 ++----
 drivers/iio/gyro/bmg160_core.c         | 12 ++++--------
 drivers/iio/imu/kmx61.c                | 10 +++-------
 drivers/iio/industrialio-trigger.c     |  4 ++--
 drivers/iio/magnetometer/bmc150_magn.c | 10 +++++-----
 include/linux/iio/trigger.h            |  4 ++--
 11 files changed, 40 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 6b74c2b04c15..71f85a3e525b 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -959,17 +959,20 @@ static int bma180_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return bma180_set_new_data_intr_state(data, state);
 }
 
-static int bma180_trig_try_reen(struct iio_trigger *trig)
+static void bma180_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bma180_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return bma180_reset_intr(data);
+	ret = bma180_reset_intr(data);
+	if (ret)
+		dev_err(&data->client->dev, "failed to reset interrupt\n");
 }
 
 static const struct iio_trigger_ops bma180_trigger_ops = {
 	.set_trigger_state = bma180_data_rdy_trigger_set_state,
-	.try_reenable = bma180_trig_try_reen,
+	.reenable = bma180_trig_reen,
 };
 
 static int bma180_probe(struct i2c_client *client,
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 24864d9dfab5..5561a8b62a5f 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1125,7 +1125,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
+static void bmc150_accel_trig_reen(struct iio_trigger *trig)
 {
 	struct bmc150_accel_trigger *t = iio_trigger_get_drvdata(trig);
 	struct bmc150_accel_data *data = t->data;
@@ -1134,7 +1134,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
 
 	/* new data interrupts don't need ack */
 	if (t == &t->data->triggers[BMC150_ACCEL_TRIGGER_DATA_READY])
-		return 0;
+		return;
 
 	mutex_lock(&data->mutex);
 	/* clear any latched interrupt */
@@ -1142,12 +1142,8 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
 			   BMC150_ACCEL_INT_MODE_LATCH_INT |
 			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 	mutex_unlock(&data->mutex);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "Error writing reg_int_rst_latch\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
@@ -1187,7 +1183,7 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
 	.set_trigger_state = bmc150_accel_trigger_set_state,
-	.try_reenable = bmc150_accel_trig_try_reen,
+	.reenable = bmc150_accel_trig_reen,
 };
 
 static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index beb38d9d607d..9a58ea86f5cf 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1066,19 +1066,15 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int kxcjk1013_trig_try_reen(struct iio_trigger *trig)
+static void kxcjk1013_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
@@ -1122,7 +1118,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
 	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
-	.try_reenable = kxcjk1013_trig_try_reen,
+	.reenable = kxcjk1013_trig_reen,
 };
 
 static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index f877263dc6ef..0f8fd687866d 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -310,19 +310,15 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int mxc4005_clr_intr(struct mxc4005_data *data)
+static void mxc4005_clr_intr(struct mxc4005_data *data)
 {
 	int ret;
 
 	/* clear interrupt */
 	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
 			   MXC4005_REG_INT_CLR1_BIT_DRDYC);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(data->dev, "failed to write to reg_int_clr1\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int mxc4005_set_trigger_state(struct iio_trigger *trig,
@@ -353,20 +349,20 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 	return 0;
 }
 
-static int mxc4005_trigger_try_reen(struct iio_trigger *trig)
+static void mxc4005_trigger_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mxc4005_data *data = iio_priv(indio_dev);
 
 	if (!data->dready_trig)
-		return 0;
+		return;
 
-	return mxc4005_clr_intr(data);
+	mxc4005_clr_intr(data);
 }
 
 static const struct iio_trigger_ops mxc4005_trigger_ops = {
 	.set_trigger_state = mxc4005_set_trigger_state,
-	.try_reenable = mxc4005_trigger_try_reen,
+	.reenable = mxc4005_trigger_reen,
 };
 
 static int mxc4005_chip_init(struct mxc4005_data *data)
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index de9583d6cddd..1de865bac799 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -742,26 +742,24 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static int at91_adc_reenable_trigger(struct iio_trigger *trig)
+static void at91_adc_reenable_trigger(struct iio_trigger *trig)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(indio);
 
 	/* if we are using DMA, we must not reenable irq after each trigger */
 	if (st->dma_st.dma_chan)
-		return 0;
+		return;
 
 	enable_irq(st->irq);
 
 	/* Needed to ACK the DRDY interruption */
 	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
-
-	return 0;
 }
 
 static const struct iio_trigger_ops at91_adc_trigger_ops = {
 	.set_trigger_state = &at91_adc_configure_trigger,
-	.try_reenable = &at91_adc_reenable_trigger,
+	.reenable = &at91_adc_reenable_trigger,
 	.validate_device = iio_trigger_validate_own_device,
 };
 
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index ca6fc234076e..c45d8226cc2b 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -478,7 +478,7 @@ static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return ret;
 }
 
-static int adxrs290_reset_trig(struct iio_trigger *trig)
+static void adxrs290_reset_trig(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	int val;
@@ -491,14 +491,12 @@ static int adxrs290_reset_trig(struct iio_trigger *trig)
 	 */
 	adxrs290_get_rate_data(indio_dev,
 			       ADXRS290_READ_REG(ADXRS290_REG_DATAY0), &val);
-
-	return 0;
 }
 
 static const struct iio_trigger_ops adxrs290_trigger_ops = {
 	.set_trigger_state = &adxrs290_data_rdy_trigger_set_state,
 	.validate_device = &iio_trigger_validate_own_device,
-	.try_reenable = &adxrs290_reset_trig,
+	.reenable = &adxrs290_reset_trig,
 };
 
 static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 8ddda96455fc..2d5015801a75 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -893,7 +893,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int bmg160_trig_try_reen(struct iio_trigger *trig)
+static void bmg160_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmg160_data *data = iio_priv(indio_dev);
@@ -902,18 +902,14 @@ static int bmg160_trig_try_reen(struct iio_trigger *trig)
 
 	/* new data interrupts don't need ack */
 	if (data->dready_trigger_on)
-		return 0;
+		return;
 
 	/* Set latched mode interrupt and clear any latched interrupt */
 	ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
 			   BMG160_INT_MODE_LATCH_INT |
 			   BMG160_INT_MODE_LATCH_RESET);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "Error writing reg_rst_latch\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
@@ -961,7 +957,7 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops bmg160_trigger_ops = {
 	.set_trigger_state = bmg160_data_rdy_trigger_set_state,
-	.try_reenable = bmg160_trig_try_reen,
+	.reenable = bmg160_trig_reen,
 };
 
 static irqreturn_t bmg160_event_handler(int irq, void *private)
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 61885e99d3fc..4377047d503a 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1063,24 +1063,20 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return ret;
 }
 
-static int kmx61_trig_try_reenable(struct iio_trigger *trig)
+static void kmx61_trig_reenable(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, KMX61_REG_INL);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_inl\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static const struct iio_trigger_ops kmx61_trigger_ops = {
 	.set_trigger_state = kmx61_data_rdy_trigger_set_state,
-	.try_reenable = kmx61_trig_try_reenable,
+	.reenable = kmx61_trig_reenable,
 };
 
 static irqreturn_t kmx61_event_handler(int irq, void *private)
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f902be90980b..ea3c9859b258 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -203,8 +203,8 @@ EXPORT_SYMBOL(iio_trigger_poll_chained);
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
-	    trig->ops->try_reenable)
-		trig->ops->try_reenable(trig);
+	    trig->ops->reenable)
+		trig->ops->reenable(trig);
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fc6840f9c1fa..e22e99bbd66e 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -766,20 +766,20 @@ static int bmc150_magn_reset_intr(struct bmc150_magn_data *data)
 	return regmap_read(data->regmap, BMC150_MAGN_REG_X_L, &tmp);
 }
 
-static int bmc150_magn_trig_try_reen(struct iio_trigger *trig)
+static void bmc150_magn_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
 	if (!data->dready_trigger_on)
-		return 0;
+		return;
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_magn_reset_intr(data);
 	mutex_unlock(&data->mutex);
-
-	return ret;
+	if (ret)
+		dev_err(data->dev, "Failed to reset interrupt\n");
 }
 
 static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
@@ -817,7 +817,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
 	.set_trigger_state = bmc150_magn_data_rdy_trigger_set_state,
-	.try_reenable = bmc150_magn_trig_try_reen,
+	.reenable = bmc150_magn_trig_reen,
 };
 
 static int bmc150_magn_buffer_preenable(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index cad8325903f9..5ba4fd171aa4 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -21,7 +21,7 @@ struct iio_trigger;
 /**
  * struct iio_trigger_ops - operations structure for an iio_trigger.
  * @set_trigger_state:	switch on/off the trigger on demand
- * @try_reenable:	function to reenable the trigger when the
+ * @reenable:		function to reenable the trigger when the
  *			use count is zero (may be NULL)
  * @validate_device:	function to validate the device when the
  *			current trigger gets changed.
@@ -31,7 +31,7 @@ struct iio_trigger;
  **/
 struct iio_trigger_ops {
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
-	int (*try_reenable)(struct iio_trigger *trig);
+	void (*reenable)(struct iio_trigger *trig);
 	int (*validate_device)(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev);
 };
-- 
2.28.0

