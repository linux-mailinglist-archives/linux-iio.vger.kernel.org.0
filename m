Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8573F0065
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhHRJ2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 05:28:43 -0400
Received: from first.geanix.com ([116.203.34.67]:37262 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232078AbhHRJ2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Aug 2021 05:28:37 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id AC9D1440E67;
        Wed, 18 Aug 2021 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629278879; bh=7OexsiGMFhZSZqpYn/nK8lxHAvclLOclVQX7QSOOPaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Rgo74AymfXsdhXPBH6obrbDp3P3yrpQOwHbf0iE+RHh/4A5mNsMKcmCeDEX6oc4Du
         dHecSedW8I/UDTK5Y+c7pNcfL/rROMr7O4tgM9thG6UzCWLoOkjFE3sNsyqkQAYlaf
         2ol1VWBhDibxwxeDqnSYFUtwSlZD5HcMlU5bH2IyiY9F2EN5DaQIzNontbhBhLPZHJ
         /Bk+98frl+t69+j+g0IL7tFgJg9/vmC7j9fk32Qssh2JPBn06wgGPEYzJotYgV0rjW
         KDW8BZzSpVWYigzB3YUWpXJId5mjlc5bqn85XODCDNb5jSTdZNmtHCXabKqeq0dv/S
         HDXDLVWHQLuOA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: accel: fxls8962af: add wake on event
Date:   Wed, 18 Aug 2021 11:27:41 +0200
Message-Id: <20210818092741.2114155-2-sean@geanix.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818092741.2114155-1-sean@geanix.com>
References: <20210818092741.2114155-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.
If the buffer is enabled it will be deactivated before suspend, as the
buffer is quite small.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 48 +++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 1b97c82b5b05..60d50759de12 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -160,6 +160,7 @@ struct fxls8962af_data {
 	} scan;
 	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
+	int irq;
 	u8 watermark;
 	u8 enable_event;
 	u16 lower_thres;
@@ -1114,6 +1115,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1183,6 +1185,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	if (dev_fwnode(dev) && device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
@@ -1208,9 +1213,48 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
 	return fxls8962af_active(data);
 }
 
+static int __maybe_unused fxls8962af_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+
+	if (device_may_wakeup(dev) && data->enable_event) {
+		enable_irq_wake(data->irq);
+
+		/*
+		 * Disable buffer, as the buffer is so small the device will wake
+		 * almost immediately.
+		 */
+		if (iio_buffer_enabled(indio_dev))
+			fxls8962af_buffer_predisable(indio_dev);
+	} else {
+		fxls8962af_runtime_suspend(dev);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused fxls8962af_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+	if (device_may_wakeup(dev) && data->enable_event) {
+		disable_irq_wake(data->irq);
+
+		if (iio_buffer_enabled(indio_dev))
+			fxls8962af_buffer_postenable(indio_dev);
+	} else {
+		fxls8962af_runtime_resume(dev);
+	}
+
+	return 0;
+}
+
 const struct dev_pm_ops fxls8962af_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend,
+				fxls8962af_resume)
 	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
 			   fxls8962af_runtime_resume, NULL)
 };
-- 
2.32.0

