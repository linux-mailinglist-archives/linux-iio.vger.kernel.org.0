Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3830B1A5FE1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgDLShb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLShb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 14:37:31 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA427C0A3BF0;
        Sun, 12 Apr 2020 11:37:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BDC20705;
        Sun, 12 Apr 2020 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586716651;
        bh=it8QlahmZA3lvTA658uiqgPpSb81WQy97HOPvQ/Hc04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsE9fr8+x3mgdGPQIejvlvXuVBSRnDgWg4Y3VwQnKxbXG/1CnkQclqb7nvLvpxDL9
         52CEhXf9PJd9F0M5Obw3J8uvIJ3CXCxH2WR1peCIcT72Zh6qSQjwHhq91UOnSluRUc
         0tYccQjkwBDV38CwU6J7UWuekr7RlW80O1ol2MRQ=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 2/3] iio: chemical: Add support for external Reset and Wakeup in CCS811
Date:   Mon, 13 Apr 2020 00:06:57 +0530
Message-Id: <20200412183658.6755-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412183658.6755-1-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

CCS811 VOC sensor exposes nRESET and nWAKE pins which can be connected
to GPIO pins of the host controller. These pins can be used to externally
release the device from reset and also to wake it up before any I2C
transaction. The initial driver support assumed that the nRESET pin is not
connected and the nWAKE pin is tied to ground.

This commit improves it by adding support for controlling those two pins
externally using a host controller. For the case of reset, if the hardware
reset is not available, the mechanism to do software reset is also added.

As a side effect of doing this, the IIO device allocation needs to be
slightly moved to top of probe to make use of priv data early.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/chemical/ccs811.c | 88 +++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 2ebdfc35bcda..6cd92c49c348 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -36,6 +37,7 @@
 #define CCS811_ERR		0xE0
 /* Used to transition from boot to application mode */
 #define CCS811_APP_START	0xF4
+#define CCS811_SW_RESET		0xFF
 
 /* Status register flags */
 #define CCS811_STATUS_ERROR		BIT(0)
@@ -74,6 +76,7 @@ struct ccs811_data {
 	struct mutex lock; /* Protect readings */
 	struct ccs811_reading buffer;
 	struct iio_trigger *drdy_trig;
+	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
 };
 
@@ -166,10 +169,25 @@ static int ccs811_setup(struct i2c_client *client)
 					 CCS811_MODE_IAQ_1SEC);
 }
 
+static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
+{
+	if (!data->wakeup_gpio)
+		return;
+
+	gpiod_set_value(data->wakeup_gpio, enable);
+
+	if (enable)
+		usleep_range(50, 60);
+	else
+		usleep_range(20, 30);
+}
+
 static int ccs811_get_measurement(struct ccs811_data *data)
 {
 	int ret, tries = 11;
 
+	ccs811_set_wakeup(data, true);
+
 	/* Maximum waiting time: 1s, as measurements are made every second */
 	while (tries-- > 0) {
 		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
@@ -183,9 +201,12 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	if (!(ret & CCS811_STATUS_DATA_READY))
 		return -EIO;
 
-	return i2c_smbus_read_i2c_block_data(data->client,
+	ret = i2c_smbus_read_i2c_block_data(data->client,
 					    CCS811_ALG_RESULT_DATA, 8,
 					    (char *)&data->buffer);
+	ccs811_set_wakeup(data, false);
+
+	return ret;
 }
 
 static int ccs811_read_raw(struct iio_dev *indio_dev,
@@ -336,6 +357,42 @@ static irqreturn_t ccs811_data_rdy_trigger_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int ccs811_reset(struct i2c_client *client)
+{
+	struct gpio_desc *reset_gpio;
+	int ret;
+
+	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+					     GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(&client->dev, "Failed to acquire reset gpio\n");
+		return -EINVAL;
+	}
+
+	/* Try to reset using nRESET pin if available else do SW reset */
+	if (reset_gpio) {
+		gpiod_set_value(reset_gpio, 1);
+		usleep_range(20, 30);
+		gpiod_set_value(reset_gpio, 0);
+	} else {
+		static const u8 reset_seq[] = {
+			0xFF, 0x11, 0xE5, 0x72, 0x8A,
+		};
+
+		ret = i2c_smbus_write_i2c_block_data(client, CCS811_SW_RESET,
+					     sizeof(reset_seq), reset_seq);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to reset sensor\n");
+			return ret;
+		}
+	}
+
+	/* tSTART delay required after reset */
+	usleep_range(1000, 2000);
+
+	return 0;
+}
+
 static int ccs811_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -348,6 +405,27 @@ static int ccs811_probe(struct i2c_client *client,
 				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
 		return -EOPNOTSUPP;
 
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(data->wakeup_gpio)) {
+		dev_err(&client->dev, "Failed to acquire wakeup gpio\n");
+		return -EINVAL;
+	}
+
+	ccs811_set_wakeup(data, true);
+
+	ret = ccs811_reset(client);
+	if (ret)
+		return ret;
+
 	/* Check hardware id (should be 0x81 for this family of devices) */
 	ret = i2c_smbus_read_byte_data(client, CCS811_HW_ID);
 	if (ret < 0)
@@ -367,17 +445,11 @@ static int ccs811_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
 	ret = ccs811_setup(client);
 	if (ret < 0)
 		return ret;
 
-	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	ccs811_set_wakeup(data, false);
 
 	mutex_init(&data->lock);
 
-- 
2.17.1

