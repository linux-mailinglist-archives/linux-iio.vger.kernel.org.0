Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097883FB240
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhH3ILh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 04:11:37 -0400
Received: from first.geanix.com ([116.203.34.67]:37282 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhH3ILh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 04:11:37 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 824E3440FC4;
        Mon, 30 Aug 2021 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630311042; bh=s4tYH4Giuh1CLDhJGNE+WCwXBKDCpOjjIvEe3tEDNk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RYy4HQqTD1CyUZKrUiXxUpZ0xqC3UF7350RfEp/hbczTloEN0SYBv018Xzvdg5ong
         ynhSzZqC9CKTuKXdLbIFucTZ1HPaJia2y1zWlOD2Lxyqe6hi7JzQjE75TMyppj8Lpu
         gFZNUnyVmF0txrRnbY2QbhG3MJ9yeYJb/PUy+EySrAmFdy4a8CIANPj9gDKpjJNfPD
         JsnMY1g0gjkQFGH0TLJalAVw/8lTVRqS+Ie4dHmtYeYTOL08bcA5Id3hEQ8swMBdxl
         5ZwU5VGnZdLa4dFwUd2yssb52lho1paJYHvUsqAOxlB/WWIA8BH7WLlTP7q5Vnr8rr
         rpZ7ybRzECWzQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: accel: fxls8962af: add wake on event
Date:   Mon, 30 Aug 2021 10:10:32 +0200
Message-Id: <20210830081032.267891-2-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830081032.267891-1-sean@geanix.com>
References: <20210830081032.267891-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.

If buffered reads are enabled they will be deactivated before suspend.
As the onboard buffer is only holding up to 32 12-bit X/Y/Z data
triplets.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v1:
 - Fixed comments fron Andy (Thanks)

 drivers/iio/accel/fxls8962af-core.c | 46 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index dd639420fb0f..ef0f6560953c 100644
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
@@ -1123,6 +1124,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1192,6 +1194,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
@@ -1217,9 +1222,46 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
 	return fxls8962af_active(data);
 }
 
+static int __maybe_unused fxls8962af_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
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
+	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
 	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
 			   fxls8962af_runtime_resume, NULL)
 };
-- 
2.33.0

