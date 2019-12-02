Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDCE10E6CF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBIRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:17:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41269 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBIRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:17:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so2501153ljc.8
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJ8UgxperAgADvBnPM4gmSAcq2daXprYdA2O12IF9GA=;
        b=bTn3iMsxL1ZF+H7Am2WxvExaEa6PWZzvRUHUyCXgEh7G7K0kDg4bW08AyxQGDF8RrW
         NV2guh5yod6z1fVnK16+eRY5IgBA2zP00uN8nuNu4LzhZnnIVGvGGAEiIT9DraX7DvQF
         uZFBg/CNbVb8dzM5Re8bdFA8PibV0Kcw8G7Vx4qh04HmLiTcj69kyDAr6FwMvY65SDbm
         iSpzRuNlb+kkNtz99NmsnurHn6pjxNOqDCInFgLL6+8iEyfEGSkuVvwWBs3TolxMyLVI
         ppZDMcH4RJqSBFUb7ISZrcww0u7vws6ku//FWqMD/aCnW/hJHiQooD7Qwxmq/I9TJ1CP
         zJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJ8UgxperAgADvBnPM4gmSAcq2daXprYdA2O12IF9GA=;
        b=PCLnbGo4v/K1SijpNiAqDb6wYysOiULqsu4VUHCRZ5iq8FAEzlY2w9XBbcBz7C/vpW
         tvIyuywI2U1y//G5kmAy1Z86elpJQnAIQ3cLc8Rl75KjqOmxLeeuTK0kW+5bszoazQtz
         jkNLp5Cgpbhv6iwR3PiT5jaYukgqls36Eng7pSDeOHEHYCFSzO9rbGU9Psr1Nk4Plq8w
         jE/BqyTKgBL0zRa5qAnFeIXhOfoPDKqoykGSZnhDPaPQk1DQEMwNF8WoUzoeyfz5wr8c
         xprUhT3OZm7UgogRNrFJITvs8CyBnSfJ4K3P2G3iUo35FUC5vMFZ8B+dm5BlDdWlOYDA
         P+5Q==
X-Gm-Message-State: APjAAAURrqhEdjxGmaCSokSA3kZadB8OZetjRhLLN3n+HrGK7KUA53GO
        oTqvtsFvVv9B7wjyWKgB/buI8eJgzto=
X-Google-Smtp-Source: APXvYqzK2XmbZpcexUVMoOUpV2GzFAMq8g3CbUdaW86R1qGSHEW/JOZzZpMH91D1BcsFRJn9kIXIXg==
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr32384037ljj.1.1575274654145;
        Mon, 02 Dec 2019 00:17:34 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 30sm16142380ljv.99.2019.12.02.00.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:17:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: ak8975: Convert to use GPIO descriptor
Date:   Mon,  2 Dec 2019 09:17:30 +0100
Message-Id: <20191202081730.61707-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The end-of-conversion (EOC) GPIO line is better to grab using
a GPIO descriptor. We drop the pdata for this: clients using board
files can use machine descriptor tables to pass this GPIO from
static data.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c       | 54 +++++++++----------------
 include/linux/iio/magnetometer/ak8975.h |  2 -
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 893bec5a0312..da5d75afb536 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -16,8 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -360,7 +359,7 @@ struct ak8975_data {
 	struct mutex		lock;
 	u8			asa[3];
 	long			raw_to_gauss[3];
-	int			eoc_gpio;
+	struct gpio_desc	*eoc_gpiod;
 	int			eoc_irq;
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
@@ -498,15 +497,15 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	if (client->irq)
 		irq = client->irq;
 	else
-		irq = gpio_to_irq(data->eoc_gpio);
+		irq = gpiod_to_irq(data->eoc_gpiod);
 
 	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
 			      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 			      dev_name(&client->dev), data);
 	if (rc < 0) {
 		dev_err(&client->dev,
-			"irq %d request failed, (gpio %d): %d\n",
-			irq, data->eoc_gpio, rc);
+			"irq %d request failed: %d\n",
+			irq, rc);
 		return rc;
 	}
 
@@ -549,7 +548,7 @@ static int ak8975_setup(struct i2c_client *client)
 		return ret;
 	}
 
-	if (data->eoc_gpio > 0 || client->irq > 0) {
+	if (data->eoc_gpiod || client->irq > 0) {
 		ret = ak8975_setup_irq(data);
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -574,7 +573,7 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 	/* Wait for the conversion to complete. */
 	while (timeout_ms) {
 		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		if (gpio_get_value(data->eoc_gpio))
+		if (gpiod_get_value(data->eoc_gpiod))
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
 	}
@@ -646,7 +645,7 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	/* Wait for the conversion to complete. */
 	if (data->eoc_irq)
 		ret = wait_conversion_complete_interrupt(data);
-	else if (gpio_is_valid(data->eoc_gpio))
+	else if (data->eoc_gpiod)
 		ret = wait_conversion_complete_gpio(data);
 	else
 		ret = wait_conversion_complete_polled(data);
@@ -856,36 +855,23 @@ static int ak8975_probe(struct i2c_client *client,
 {
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
-	int eoc_gpio;
+	struct gpio_desc *eoc_gpiod;
 	int err;
 	const char *name = NULL;
 	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
 	const struct ak8975_platform_data *pdata =
 		dev_get_platdata(&client->dev);
 
-	/* Grab and set up the supplied GPIO. */
-	if (pdata)
-		eoc_gpio = pdata->eoc_gpio;
-	else if (client->dev.of_node)
-		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
-	else
-		eoc_gpio = -1;
-
-	if (eoc_gpio == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	/* We may not have a GPIO based IRQ to scan, that is fine, we will
-	   poll if so */
-	if (gpio_is_valid(eoc_gpio)) {
-		err = devm_gpio_request_one(&client->dev, eoc_gpio,
-							GPIOF_IN, "ak_8975");
-		if (err < 0) {
-			dev_err(&client->dev,
-				"failed to request GPIO %d, error %d\n",
-							eoc_gpio, err);
-			return err;
-		}
-	}
+	/*
+	 * Grab and set up the supplied GPIO.
+	 * We may not have a GPIO based IRQ to scan, that is fine, we will
+	 * poll if so.
+	 */
+	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
+	if (IS_ERR(eoc_gpiod))
+		return PTR_ERR(eoc_gpiod);
+	if (eoc_gpiod)
+		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
 	/* Register with IIO */
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -896,7 +882,7 @@ static int ak8975_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	data->client = client;
-	data->eoc_gpio = eoc_gpio;
+	data->eoc_gpiod = eoc_gpiod;
 	data->eoc_irq = 0;
 
 	if (!pdata) {
diff --git a/include/linux/iio/magnetometer/ak8975.h b/include/linux/iio/magnetometer/ak8975.h
index ac9366f807cb..df3697183800 100644
--- a/include/linux/iio/magnetometer/ak8975.h
+++ b/include/linux/iio/magnetometer/ak8975.h
@@ -6,11 +6,9 @@
 
 /**
  * struct ak8975_platform_data - AK8975 magnetometer driver platform data
- * @eoc_gpio:    data ready event gpio
  * @orientation: mounting matrix relative to main hardware
  */
 struct ak8975_platform_data {
-	int                     eoc_gpio;
 	struct iio_mount_matrix orientation;
 };
 
-- 
2.23.0

