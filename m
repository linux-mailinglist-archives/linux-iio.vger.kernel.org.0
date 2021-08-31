Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4476D3FC8F9
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhHaN5q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 09:57:46 -0400
Received: from first.geanix.com ([116.203.34.67]:37288 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhHaN5n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Aug 2021 09:57:43 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 4BE93440FD0;
        Tue, 31 Aug 2021 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630418206; bh=R7AxTPP5V7lzyhlJUMko65FkbDRkKnRDQwmxFPAI5pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dfKMWV14ddjlbgrkEI+XCp+pNA5g9Gzj66WIAHl4dprnH4YQm2tRXhPelSa3qjIY0
         6mgweH0hOreFlZCEePJkcUvxwgzEthVufQAryNskIDZVB3+9Jsc6c/FNMiu6zKj7x6
         xd5jwvT8nkXp9DoK27oIxIECuxAcNnW8M1zX6LhPPgmhF8kUhg982xBQYnwm5GivTr
         apdz1Dk0mlr1ypwQrtRFfg9kEjhXMW2NuOMznOdMPKIithFvBd9/ID4ReloJlBuZsb
         x3gkTxGF73Lvy36vDeZxfl1v9nl+chRoKXrzPNLw2wN8FXV7g65NQWnA/oep1S08SH
         Mgr+dagP3y4UQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH v4 2/2] iio: accel: fxls8962af: add wake on event
Date:   Tue, 31 Aug 2021 15:56:38 +0200
Message-Id: <20210831135638.173276-2-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831135638.173276-1-sean@geanix.com>
References: <20210831135638.173276-1-sean@geanix.com>
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

Changes since v3:
 - None

 drivers/iio/accel/fxls8962af-core.c | 46 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 857940529e7d..4f7adba4fb3a 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -166,6 +166,7 @@ struct fxls8962af_data {
 	} scan;
 	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
+	int irq;
 	u8 watermark;
 	u8 enable_event;
 	u16 lower_thres;
@@ -1160,6 +1161,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1229,6 +1231,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
@@ -1254,9 +1259,46 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
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

