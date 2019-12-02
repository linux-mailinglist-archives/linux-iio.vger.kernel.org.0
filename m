Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73810E717
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLBIx4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:53:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLBIxz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:53:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so28511153ljh.5
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rD/83icQLYD3lg0w1d/zsbSrw6+y6oV27CQQJ2Fk28=;
        b=awhsHW4YHbWg0U6KPN5zvdoRuzOv9dI0VxeAa9SweB1+rY49YgMaXiVFgE+lO2um/a
         n3YMiziIw8angJSgQsqEd/Gu4RJlHojSb1BTvj9XOxNJbRBWhPh/4qxZEKNWkblBh4KH
         wBg9OwuwFZq7JSp3WzRRnSjN0u4wx9WTKuYzRs+XW61waKnheTKigXGUTNHbGWCNe9zX
         /rrxQod8/7VXN++f7SstZKwucMZoh0SY4Dq+trn9AZC1qNha7E+qZb933Yq34Mh3mFeb
         1xGEV7kta0PYjP4M1r61DVkKLHzaZNIpn+9U/g6xJhY3GEzYDtPtnB6L7E+QGENoREK7
         am2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rD/83icQLYD3lg0w1d/zsbSrw6+y6oV27CQQJ2Fk28=;
        b=RD5JoBe5jZOsR9GxD8ns7PoHl36RD92Hzc5GraRbp75SDNNYnhFXxaLELHwzyfqeax
         In0uwVrfF2K5vqdHq0lCGVxcVNDz/rowMcvJP78gr55nfY9Na6qLgDdNBAXOktFL7eEJ
         iHwcS0srQgWW3xkXsLPW6O4/kx5XqiD8QWKfBRi82ClUrWBwyi/L8TV4OfREV6GrljmU
         Z2njXXFE9H/qmMS57VflRr3Jw6U+f5ArtVpLCwrMalz0df22Jtzedta3SSIwPXCiBGfs
         uABjwjgE0ejlew9fAVsglMHtnb7G91B7BLrYnrS9NH//BuLKa4DpH6h5OgmTcahQpyZp
         d1kw==
X-Gm-Message-State: APjAAAXBiT8zlY40M1VXpbdZX6O07VM6YbbkiYSJ9rz1gpMCLV83UeHy
        GDJspWJA3hKmVhc2gD/8v6Cz5A==
X-Google-Smtp-Source: APXvYqwa/cwPkMzfa+Lfd4v6K0+MTPk6TzByjz2K9cQMRSX7xnMgWABOMqZw2BDcEAEALq33hsbgMQ==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr16066703ljr.171.1575276832865;
        Mon, 02 Dec 2019 00:53:52 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm14543756ljj.19.2019.12.02.00.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:53:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH] iio: ssp_sensors: Convert to use GPIO descriptors
Date:   Mon,  2 Dec 2019 09:53:50 +0100
Message-Id: <20191202085350.77149-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These three GPIO lines used by the Samsung sensor hub is pretty
straight-forward to convert to use GPIO descriptors.

Cc: Karol Wrona <k.wrona@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/ssp_sensors/ssp.h     | 14 ++++++------
 drivers/iio/common/ssp_sensors/ssp_dev.c | 29 ++++++++----------------
 drivers/iio/common/ssp_sensors/ssp_spi.c |  8 +++----
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index 0a381bb1ae6f..abb832795619 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -7,7 +7,7 @@
 #define __SSP_SENSORHUB_H__
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iio/common/ssp_sensors.h>
 #include <linux/iio/iio.h>
 #include <linux/spi/spi.h>
@@ -168,9 +168,9 @@ struct ssp_sensorhub_info {
  * @fw_dl_state:	firmware download state
  * @comm_lock:		lock protecting the handshake
  * @pending_lock:	lock protecting pending list and completion
- * @mcu_reset_gpio:	mcu reset line
- * @ap_mcu_gpio:	ap to mcu gpio line
- * @mcu_ap_gpio:	mcu to ap gpio line
+ * @mcu_reset_gpiod:	mcu reset line
+ * @ap_mcu_gpiod:	ap to mcu gpio line
+ * @mcu_ap_gpiod:	mcu to ap gpio line
  * @pending_list:	pending list for messages queued to be sent/read
  * @sensor_devs:	registered IIO devices table
  * @enable_refcount:	enable reference count for wdt (watchdog timer)
@@ -212,9 +212,9 @@ struct ssp_data {
 	struct mutex comm_lock;
 	struct mutex pending_lock;
 
-	int mcu_reset_gpio;
-	int ap_mcu_gpio;
-	int mcu_ap_gpio;
+	struct gpio_desc *mcu_reset_gpiod;
+	struct gpio_desc *ap_mcu_gpiod;
+	struct gpio_desc *mcu_ap_gpiod;
 
 	struct list_head pending_list;
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 9c70553994c6..a94dbcf491ce 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -9,7 +9,6 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include "ssp.h"
 
@@ -61,9 +60,9 @@ static const struct mfd_cell sensorhub_sensor_devs[] = {
 
 static void ssp_toggle_mcu_reset_gpio(struct ssp_data *data)
 {
-	gpio_set_value(data->mcu_reset_gpio, 0);
+	gpiod_set_value(data->mcu_reset_gpiod, 0);
 	usleep_range(1000, 1200);
-	gpio_set_value(data->mcu_reset_gpio, 1);
+	gpiod_set_value(data->mcu_reset_gpiod, 1);
 	msleep(50);
 }
 
@@ -441,7 +440,6 @@ MODULE_DEVICE_TABLE(of, ssp_of_match);
 
 static struct ssp_data *ssp_parse_dt(struct device *dev)
 {
-	int ret;
 	struct ssp_data *data;
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *match;
@@ -450,26 +448,17 @@ static struct ssp_data *ssp_parse_dt(struct device *dev)
 	if (!data)
 		return NULL;
 
-	data->mcu_ap_gpio = of_get_named_gpio(node, "mcu-ap-gpios", 0);
-	if (data->mcu_ap_gpio < 0)
-		return NULL;
-
-	data->ap_mcu_gpio = of_get_named_gpio(node, "ap-mcu-gpios", 0);
-	if (data->ap_mcu_gpio < 0)
-		return NULL;
-
-	data->mcu_reset_gpio = of_get_named_gpio(node, "mcu-reset-gpios", 0);
-	if (data->mcu_reset_gpio < 0)
+	data->mcu_ap_gpiod = devm_gpiod_get(dev, "mcu-ap", GPIOD_IN);
+	if (IS_ERR(data->mcu_ap_gpiod))
 		return NULL;
 
-	ret = devm_gpio_request_one(dev, data->ap_mcu_gpio, GPIOF_OUT_INIT_HIGH,
-				    "ap-mcu-gpios");
-	if (ret)
+	data->ap_mcu_gpiod = devm_gpiod_get(dev, "ap-mcu", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->ap_mcu_gpiod))
 		return NULL;
 
-	ret = devm_gpio_request_one(dev, data->mcu_reset_gpio,
-				    GPIOF_OUT_INIT_HIGH, "mcu-reset-gpios");
-	if (ret)
+	data->mcu_reset_gpiod = devm_gpiod_get(dev, "mcu-reset",
+					       GPIOD_OUT_HIGH);
+	if (IS_ERR(data->mcu_reset_gpiod))
 		return NULL;
 
 	match = of_match_node(ssp_of_match, node);
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 7db3d5886e3e..4864c38b8d1c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -155,9 +155,9 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 {
 	int delay_cnt = 0;
 
-	gpio_set_value_cansleep(data->ap_mcu_gpio, state);
+	gpiod_set_value_cansleep(data->ap_mcu_gpiod, state);
 
-	while (gpio_get_value_cansleep(data->mcu_ap_gpio) != state) {
+	while (gpiod_get_value_cansleep(data->mcu_ap_gpiod) != state) {
 		usleep_range(3000, 3500);
 
 		if (data->shut_down || delay_cnt++ > 500) {
@@ -165,7 +165,7 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 				__func__, state);
 
 			if (!state)
-				gpio_set_value_cansleep(data->ap_mcu_gpio, 1);
+				gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
 
 			return -ETIMEDOUT;
 		}
@@ -197,7 +197,7 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 
 	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
 	if (status < 0) {
-		gpio_set_value_cansleep(data->ap_mcu_gpio, 1);
+		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
 		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
 		goto _error_locked;
 	}
-- 
2.23.0

