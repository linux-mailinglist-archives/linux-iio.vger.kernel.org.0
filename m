Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2168638DBE7
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhEWQZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 12:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhEWQZc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 May 2021 12:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C73D610A0;
        Sun, 23 May 2021 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787046;
        bh=d5O9xGV535ammETxSNzdmMqaH6P52vOlfmbm7tfvxes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+1Jm8ezqT4fh9Qw0hHsS/l73hJATjKSHK2c7p0FSZCd09It3iLfB+eIdo/Mn5XCQ
         zxwm4UJsCPVwQ6xzE0FYC5vbtOG67qNrLYaZlBXGEhIqirA89GGvI06miyqArwxTDB
         saQ+2UQ08n9+okB9a3+dmuczfm+V315brrsOaud6ZYm/8IHSfQPIHVm6MS9jAlUgKg
         lrAqlMSkGIobeuSobcXCyMdeROhv92gIVM7pIJ9RAnEh5mj5yXpZDcsJW1f5CNkkFG
         x25I0jwCiuWGoIJk0P+lQYsPtnQceqyLrnNE4eXCdfNN+J028RoUbuAeh+mGhdPMyd
         fxJ2YTbn4xJ/w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/5] iio: accel: mma9551: Add support to get irqs directly from fwnode
Date:   Sun, 23 May 2021 17:23:13 +0100
Message-Id: <20210523162315.1965869-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523162315.1965869-1-jic23@kernel.org>
References: <20210523162315.1965869-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The driver previous supported using GPIO requests to retrieve
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
 drivers/iio/accel/mma9551.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1b4a8b27f14a..a0bb4ccdbec7 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -406,30 +406,37 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	int i, ret;
 	struct mma9551_data *data = iio_priv(indio_dev);
 	struct device *dev = &data->client->dev;
+	unsigned long irqflags = IRQF_ONESHOT;
 
 	for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
-		gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
-		if (IS_ERR(gpio)) {
-			dev_err(dev, "acpi gpio get index failed\n");
-			return PTR_ERR(gpio);
-		}
-
-		ret = gpiod_to_irq(gpio);
-		if (ret < 0)
+		/* GPIO provided for backwards compatibility reasons */
+		ret = fwnode_irq_get(dev_fwnode(dev), i);
+		if (ret == -EPROBE_DEFER)
 			return ret;
 
+		/* fwnode_irq_get() returns 0 for not present on OF, and -EINVAL for ACPI */
+		if (ret == 0 || ret == -EINVAL) {
+			gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
+			if (IS_ERR(gpio)) {
+				dev_err(dev, "gpio get index failed\n");
+				return PTR_ERR(gpio);
+			}
+
+			ret = gpiod_to_irq(gpio);
+			if (ret < 0)
+				return ret;
+			/* GPIO interrupt does npt have a specified direction */
+			irqflags |= IRQF_TRIGGER_RISING;
+		}
 		data->irqs[i] = ret;
 		ret = devm_request_threaded_irq(dev, data->irqs[i],
-				NULL, mma9551_event_handler,
-				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				MMA9551_IRQ_NAME, indio_dev);
+						NULL, mma9551_event_handler,
+						irqflags,
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
-- 
2.31.1

