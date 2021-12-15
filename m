Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56A475B99
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbhLOPNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:52 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43817 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbhLOPNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:51 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 05C24200006;
        Wed, 15 Dec 2021 15:13:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 06/10] iio: core: Hide read accesses to iio_dev->currentmode
Date:   Wed, 15 Dec 2021 16:13:40 +0100
Message-Id: <20211215151344.163036-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to later move this variable within the opaque structure, let's
create a helper for accessing it in read-only mode. This helper will be
exposed and kept accessible for the few drivers that could need it. The
write access to this variable however should be fully reserved to the
core so in a second step we will add another helper, not exported to the
device drivers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/accel/bmc150-accel-core.c |  4 ++--
 drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
 drivers/iio/industrialio-buffer.c     |  6 +++---
 drivers/iio/industrialio-core.c       | 11 +++++++++++
 drivers/iio/industrialio-trigger.c    |  2 +-
 include/linux/iio/iio.h               |  9 ++++++---
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index b0678c351e82..0a191463d462 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4c922ef634f8..2b7f6371950e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1117,7 +1117,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, true);
 
 	/* if we are not in triggered mode, we cannot enable the buffer. */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/* we continue with the triggered buffer */
@@ -1159,7 +1159,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, false);
 
 	/* if we are not in triggered mode, nothing to do here */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e180728914c0..f4dbab7c44fa 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 			goto err_disable_buffers;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
 		ret = iio_trigger_attach_poll_func(indio_dev->trig,
 						   indio_dev->pollfunc);
 		if (ret)
@@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	return 0;
 
 err_detach_pollfunc:
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
 		iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 	}
@@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
 		iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 	}
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 463a63d5bf56..a1d6e30d034a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2057,6 +2057,17 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
 
+/**
+ * iio_get_internal_mode() - helper function providing read-only access to the
+ *			     opaque @currentmode variable
+ * @indio_dev:		IIO device structure for device
+ **/
+int iio_get_internal_mode(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode;
+}
+EXPORT_SYMBOL_GPL(iio_get_internal_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b23caa2f2aa1..71b07d6111d6 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -411,7 +411,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	int ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 0312da2e83f8..dcab17f44552 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -677,15 +677,18 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
 struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
+
+int iio_get_internal_mode(struct iio_dev *indio_dev);
+
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @indio_dev:		IIO device structure for device
  **/
 static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
-	return indio_dev->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
-		   INDIO_BUFFER_SOFTWARE);
+	return iio_get_internal_mode(indio_dev) &
+		(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
+		 INDIO_BUFFER_SOFTWARE);
 }
 
 /**
-- 
2.27.0

