Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAF4113B0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 13:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhITLn6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 07:43:58 -0400
Received: from first.geanix.com ([116.203.34.67]:37318 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhITLn6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 07:43:58 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 9FE81ADE05;
        Mon, 20 Sep 2021 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1632138149; bh=FvlJ1iLvu/RZEsLAfmQZG1jlMm8ygoGampYDb5LBODY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WHOjbhp/Wjamd1O6l6BZHZnWOz+g1EgaPUYOzF7hUudmbws4xtBJFz5L8UPkbCic/
         6oFXezHOfeSXw3jA522O1xHZldEHcAIFQ8M4wcLGSfsctUf6ofDXB+a3q/FqiIV/e7
         nQOZK6nQCCFi+dcAlA/qbEy1RHNLHmBNl1Z8VDBZ1hPO8z7pZiZVKoETcF+YXt5QPC
         xKzE2frHQxJdVHSb9K82R8PVb5TS9WFritMBU/+MALxANdhlM5CEcTh79sSox9wgz6
         EeCcUmN5jJsbTpEmxX1A1RwJhiR+NyFJdZF01T6rNL7Qn8EDR4ZJIIoPDgCcqVY7AF
         dVxeS395v2KOg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH v5 2/2] iio: accel: fxls8962af: add wake on event
Date:   Mon, 20 Sep 2021 13:42:21 +0200
Message-Id: <20210920114221.1595543-2-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920114221.1595543-1-sean@geanix.com>
References: <20210920114221.1595543-1-sean@geanix.com>
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
Changes since v4:
  - None

 drivers/iio/accel/fxls8962af-core.c | 46 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index b55b73fbfe4e..32989d91b982 100644
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
@@ -1156,6 +1157,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->irq = irq;
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1225,6 +1227,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
@@ -1250,9 +1255,46 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
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

