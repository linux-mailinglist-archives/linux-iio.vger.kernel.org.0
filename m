Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73E39AA79
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCSwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSwZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B4D613F1;
        Thu,  3 Jun 2021 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622746240;
        bh=vMj7iCITCCOc4D1CwIKKTbe7SZV6Jxwa3hxBvfq8WHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2U1Mgih/a271twHuFlo3xnKoha0MmdPFEJYbN0oQ8VUVXQhDrWObXteRG+PlxNed
         Po+8KK/ZKybzHiUNb0o2GJHQI/bP8Rwd/rpTJYu4FjOCkxKefCg3jvdJkHLW3sCgze
         kNAWiZ8BmMLF36ub61jyi5/zT1C8Nut1eoHm/KD9JXbM/ychRM/tGH/YqYOgnnQDxo
         Fd/j9KLE5jUmd9TUYpURhmf/aPovXLfDoqU/mUhDf7R+fZBKKkF/1MuBKXMcv6kvSR
         kG9JUAqgRHK1oikOMlcfOcIlZ+CUbK9ElhrL4/U6PueMmN383XUk6bWDVjMgTx5NyJ
         aSs9fbIcsagyQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/5] iio: accel: mma9551: Add support to get irqs directly from fwnode
Date:   Thu,  3 Jun 2021 19:52:05 +0100
Message-Id: <20210603185207.3646368-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603185207.3646368-1-jic23@kernel.org>
References: <20210603185207.3646368-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The driver previously supported using GPIO requests to retrieve
multiple interrupt lines.  As existing firmware may be using
this method, we need to continue to support it.  However, that doesn't
stop us also supporting just getting irqs directly.

The handling of irqflags has to take into account the fact that using
a GPIO method to identify the interrupt does not convey direction of
the trigger that fwnode_irq_get() will. So we need to set the
IRQF_TRIGGER_RISING in that path but not otherwise, where it will
cause an issue if we reprobe the driver after removal.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Drop the original gpio based support.  They are only used as interrupts
    so lets treat them like that.

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
2.31.1

