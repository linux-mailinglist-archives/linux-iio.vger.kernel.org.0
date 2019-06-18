Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1249C9B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfFRJHO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJHN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:13 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7551F285312;
        Tue, 18 Jun 2019 10:07:11 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] iio: common: cros_ec_sensors: move registration to core
Date:   Tue, 18 Jun 2019 11:06:34 +0200
Message-Id: <2edb6d26030dbde1952bc1b25b6ca666233adfac.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to simplify derivated drivers from cros_ec_sensors_core,
a new core function is created to registered IIO stricture.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  9 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 97 ++++++++++++-------
 drivers/iio/light/cros_ec_light_prox.c        |  7 +-
 drivers/iio/pressure/cros_ec_baro.c           |  7 +-
 .../linux/iio/common/cros_ec_sensors_core.h   | 16 ++-
 5 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 897dc83a3355..c4bee9265246 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -14,7 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
+
 #include <linux/kernel.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
@@ -233,12 +233,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-			cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(pdev, indio_dev);
 }
 
 static const struct platform_device_id cros_ec_sensors_ids[] = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index e5181e007dd7..3880849c5cca 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
@@ -95,6 +96,67 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
+/**
+ * cros_ec_sensors_capture() - the trigger handler function
+ * @irq:	the interrupt number.
+ * @p:		a pointer to the poll function.
+ *
+ * On a trigger event occurring, if the pollfunc is attached then this
+ * handler is called as a threaded interrupt (and hence may sleep). It
+ * is responsible for grabbing data from the device and pushing it into
+ * the associated buffer.
+ *
+ * Return: IRQ_HANDLED
+ */
+static irqreturn_t cros_ec_sensors_capture(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->cmd_lock);
+
+	/* Clear capture data. */
+	memset(st->samples, 0, indio_dev->scan_bytes);
+
+	/* Read data based on which channels are enabled in scan mask. */
+	ret = st->read_ec_sensors_data(indio_dev,
+				       *indio_dev->active_scan_mask,
+				       (s16 *)st->samples);
+	if (ret < 0)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
+					   iio_get_time_ns(indio_dev));
+
+done:
+	/*
+	 * Tell the core we are done with this trigger and ready for the
+	 * next one.
+	 */
+	iio_trigger_notify_done(indio_dev->trig);
+
+	mutex_unlock(&st->cmd_lock);
+
+	return IRQ_HANDLED;
+}
+
+int cros_ec_sensors_core_register(struct platform_device *pdev,
+				  struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
+
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 				 u16 opt_length)
 {
@@ -380,41 +442,6 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
 
-irqreturn_t cros_ec_sensors_capture(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->cmd_lock);
-
-	/* Clear capture data. */
-	memset(st->samples, 0, indio_dev->scan_bytes);
-
-	/* Read data based on which channels are enabled in scan mask. */
-	ret = st->read_ec_sensors_data(indio_dev,
-				       *(indio_dev->active_scan_mask),
-				       (s16 *)st->samples);
-	if (ret < 0)
-		goto done;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
-					   iio_get_time_ns(indio_dev));
-
-done:
-	/*
-	 * Tell the core we are done with this trigger and ready for the
-	 * next one.
-	 */
-	iio_trigger_notify_done(indio_dev->trig);
-
-	mutex_unlock(&st->cmd_lock);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
-
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 32ea5afd495f..682dc19c2bf3 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -215,12 +215,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(pdev, indio_dev);
 }
 
 static const struct platform_device_id cros_ec_light_prox_ids[] = {
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 8718036d74d2..9d3745bc2fba 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -152,12 +152,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(pdev, indio_dev);
 }
 
 static const struct platform_device_id cros_ec_baro_ids[] = {
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 485c649b421f..60f40d253f4a 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -116,18 +116,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      bool physical_device);
 
 /**
- * cros_ec_sensors_capture() - the trigger handler function
- * @irq:	the interrupt number.
- * @p:		a pointer to the poll function.
- *
- * On a trigger event occurring, if the pollfunc is attached then this
- * handler is called as a threaded interrupt (and hence may sleep). It
- * is responsible for grabbing data from the device and pushing it into
- * the associated buffer.
+ * cros_ec_sensors_core_register() - registration of the core structure
+ * @pdev:		platform device created for the sensors
+ * @indio_dev:		iio device structure of the device
  *
- * Return: IRQ_HANDLED
+ * Return: 0 on success, -errno on failure.
  */
-irqreturn_t cros_ec_sensors_capture(int irq, void *p);
+int cros_ec_sensors_core_register(struct platform_device *pdev,
+				  struct iio_dev *indio_dev);
 
 /**
  * cros_ec_core_channel_init() - initialize channel
-- 
2.20.1

