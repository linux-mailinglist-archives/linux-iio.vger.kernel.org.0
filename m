Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C504468D1F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhLEUBX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34652 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUBW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3FEEB80ED8
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C484CC00446;
        Sun,  5 Dec 2021 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734273;
        bh=vGLaNuNee7hu8tMavA9rc4pi/SI/cJ9lTgsr9F7NJcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ie8uZ34WG/9dE6MtoZUj3J5SSx8bQHujAlK39QMeSYPxPT2Yes+HDQrAkOERefBbK
         913d20PGeDwOTj9sTsBC1IYXM/x3nT626d9qnSXXNzsykOAuVPSbV6VWPD+GfcWSLH
         DAmDXMrLdY+KTcBrajBsYRicqdiD0fJ6OWZz//yVLX3YjVSdZ0GGkTFnFWmqjqM5YN
         ujpJmbXEg610ichgWXsqm55mUnoAhD9u9pHDw65NS7JBNskYo4iyw81/dzoq+yv0KP
         74ZfOG9lm3/2EVyH5AfCAOyQzEnoVVItRZEX3sbPk7sYF/BDFj2g2NvS0wci3vcW2v
         FyAhsQPR6gAfg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/5] iio: accel: mma9551: Add support to get irqs directly from fwnode
Date:   Sun,  5 Dec 2021 20:02:48 +0000
Message-Id: <20211205200250.2840902-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205200250.2840902-1-jic23@kernel.org>
References: <20211205200250.2840902-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note the interrupt type should be specified by firmware, not the driver
so that is also dropped.

Drop previous gpio based retrieval method. Whilst in theory this
might cause problems with direction if anyone is using ACPI GioIo().
As Andy described in v1, such a situation would typically reflect
a pin that is actually used in both directions (not true here)
or missdesigned ACPI tables.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma9551.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1b4a8b27f14a..537a7a04654a 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -19,7 +19,7 @@
 
 #define MMA9551_DRV_NAME		"mma9551"
 #define MMA9551_IRQ_NAME		"mma9551_event"
-#define MMA9551_GPIO_COUNT		4
+#define MMA9551_IRQ_COUNT		4
 
 /* Tilt application (inclination in IIO terms). */
 #define MMA9551_TILT_XZ_ANG_REG		0x00
@@ -46,7 +46,7 @@ struct mma9551_data {
 	struct i2c_client *client;
 	struct mutex mutex;
 	int event_enabled[3];
-	int irqs[MMA9551_GPIO_COUNT];
+	int irqs[MMA9551_IRQ_COUNT];
 };
 
 static int mma9551_read_incli_chan(struct i2c_client *client,
@@ -400,36 +400,26 @@ static int mma9551_init(struct mma9551_data *data)
 	return mma9551_set_device_state(data->client, true);
 }
 
-static int mma9551_gpio_probe(struct iio_dev *indio_dev)
+static int mma9551_irq_probe(struct iio_dev *indio_dev)
 {
-	struct gpio_desc *gpio;
 	int i, ret;
 	struct mma9551_data *data = iio_priv(indio_dev);
 	struct device *dev = &data->client->dev;
 
-	for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
-		gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
-		if (IS_ERR(gpio)) {
-			dev_err(dev, "acpi gpio get index failed\n");
-			return PTR_ERR(gpio);
-		}
-
-		ret = gpiod_to_irq(gpio);
-		if (ret < 0)
+	for (i = 0; i < MMA9551_IRQ_COUNT; i++) {
+		ret = fwnode_irq_get(dev_fwnode(dev), i);
+		if (ret)
 			return ret;
 
 		data->irqs[i] = ret;
 		ret = devm_request_threaded_irq(dev, data->irqs[i],
-				NULL, mma9551_event_handler,
-				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				MMA9551_IRQ_NAME, indio_dev);
+						NULL, mma9551_event_handler,
+						IRQF_ONESHOT,
+						MMA9551_IRQ_NAME, indio_dev);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", data->irqs[i]);
 			return ret;
 		}
-
-		dev_dbg(dev, "gpio resource, no:%d irq:%d\n",
-			desc_to_gpio(gpio), data->irqs[i]);
 	}
 
 	return 0;
@@ -466,7 +456,7 @@ static int mma9551_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mma9551_info;
 
-	ret = mma9551_gpio_probe(indio_dev);
+	ret = mma9551_irq_probe(indio_dev);
 	if (ret < 0)
 		goto out_poweroff;
 
-- 
2.34.1

