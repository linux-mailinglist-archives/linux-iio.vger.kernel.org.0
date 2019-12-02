Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6F10E7C0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLBJiP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:38:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46724 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLBJiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 04:38:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so2442106ljk.13
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 01:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LUV27ugeTFPT/CkEZrKm21nKauJGQudNvFvpteUdJQ=;
        b=AyGEFVHhttBEqAsg7YGvv6dy9+lDTszJ6tEMUse1tvTAEB34SikN4LBZ8ODWOWbCuA
         j21UTP0oPSYWCyRc98dLRXSJ4uMLYkiKqL+HrKLcXxYdVIRhgMCrb3D7uCmi8riKKQMu
         0IZAdv0gGOTb8ZtehKtz1THFhfafNgXuR5ukRFCnW5YN/nPt4xRzvwuzg0XCxS7eWRce
         jIm5SNEim6Jp4iS0Fjm3hxOfV9jtCheBKjyf7QvqCSnwuZpZUh3A5/dFHo+bC0tFBJv0
         DE62sPWK8/m0iciRf4LaV4l+gVxtgmK3TAHeVcBTYAFVoaX0Vha0NS0DYzmj9JxQuTnu
         7GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LUV27ugeTFPT/CkEZrKm21nKauJGQudNvFvpteUdJQ=;
        b=FOV2aIfm1GJhhzQr2MDx7ErnSvkysMvcJPuECJWPyMQgLafVo745uNPPHdQskzd7S/
         1wsQhkO+T76xPETr0mVGI97FNagOkpSDmaDemF/ScIdqwm4iZD44XXh49RwplDgsUwJn
         dzfc+K3Gex/VbwWSEqrzhyjZccAvAO4RoGsGflxHU0SyKzU5Vvcr+BCXlNPIPWC3723q
         ynfRxU1bS27BAaKOzDjb5LDDO8lF7ViNFI8NoLz+KEDL7N+ZtBc/8lSZgFppkQrE4Vfd
         gRpHWJmuDQwLFu3eA9SZTRASK+361kO8myUGvitzZWq49LpqQtskAlsHwyXPQCl1sGOq
         hC/A==
X-Gm-Message-State: APjAAAVBP8bH5NDAeXCUcZS8nHWUaGnTuMRUqXdkyjgUOdyywu8lR/e7
        KAquB6Qzxg6T9Dw3ki/IgYYnxw==
X-Google-Smtp-Source: APXvYqylJWPp3H0LrtFCaE1RAydBcex2JF6mZbZUtY55AoYWketuKzpZY0dP4+5ShZKou5XQkIHhAQ==
X-Received: by 2002:a2e:83c7:: with SMTP id s7mr4896073ljh.145.1575279491447;
        Mon, 02 Dec 2019 01:38:11 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a11sm6927439lfg.17.2019.12.02.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 01:38:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alison Schofield <amsfield22@gmail.com>
Subject: [PATCH] iio: ad7266: Convert to use GPIO descriptors
Date:   Mon,  2 Dec 2019 10:38:06 +0100
Message-Id: <20191202093806.93632-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7266 have no in-tree users making use of the platform
data mechanism to pass address GPIO lines when not using
a fixed address, so we can easily convert this to use
GPIO descriptors instead of the platform data integers
currently passed.

Lowercase the labels "ad0".."ad2" as this will make a better
fit for platform descriptions like device tree that prefer
lowercase names such as "ad0-gpios" rather than "AD0-gpios".

Board files and other static users of this device can pass
the same GPIO descriptors using machine descriptor
tables if need be.

Cc: Alison Schofield <amsfield22@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ad7266.c             | 29 ++++++++++++----------------
 include/linux/platform_data/ad7266.h |  3 ---
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c31b8eabb894..c8524f098883 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -11,7 +11,7 @@
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <linux/interrupt.h>
@@ -34,7 +34,7 @@ struct ad7266_state {
 	enum ad7266_range	range;
 	enum ad7266_mode	mode;
 	bool			fixed_addr;
-	struct gpio		gpios[3];
+	struct gpio_desc	*gpios[3];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -117,7 +117,7 @@ static void ad7266_select_input(struct ad7266_state *st, unsigned int nr)
 	}
 
 	for (i = 0; i < 3; ++i)
-		gpio_set_value(st->gpios[i].gpio, (bool)(nr & BIT(i)));
+		gpiod_set_value(st->gpios[i], (bool)(nr & BIT(i)));
 }
 
 static int ad7266_update_scan_mode(struct iio_dev *indio_dev,
@@ -376,7 +376,7 @@ static void ad7266_init_channels(struct iio_dev *indio_dev)
 }
 
 static const char * const ad7266_gpio_labels[] = {
-	"AD0", "AD1", "AD2",
+	"ad0", "ad1", "ad2",
 };
 
 static int ad7266_probe(struct spi_device *spi)
@@ -419,14 +419,14 @@ static int ad7266_probe(struct spi_device *spi)
 
 		if (!st->fixed_addr) {
 			for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
-				st->gpios[i].gpio = pdata->addr_gpios[i];
-				st->gpios[i].flags = GPIOF_OUT_INIT_LOW;
-				st->gpios[i].label = ad7266_gpio_labels[i];
+				st->gpios[i] = devm_gpiod_get(&spi->dev,
+						      ad7266_gpio_labels[i],
+						      GPIOD_OUT_LOW);
+				if (IS_ERR(st->gpios[i])) {
+					ret = PTR_ERR(st->gpios[i]);
+					goto error_disable_reg;
+				}
 			}
-			ret = gpio_request_array(st->gpios,
-				ARRAY_SIZE(st->gpios));
-			if (ret)
-				goto error_disable_reg;
 		}
 	} else {
 		st->fixed_addr = true;
@@ -465,7 +465,7 @@ static int ad7266_probe(struct spi_device *spi)
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
 	if (ret)
-		goto error_free_gpios;
+		goto error_disable_reg;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -475,9 +475,6 @@ static int ad7266_probe(struct spi_device *spi)
 
 error_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_free_gpios:
-	if (!st->fixed_addr)
-		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
@@ -492,8 +489,6 @@ static int ad7266_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	if (!st->fixed_addr)
-		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
diff --git a/include/linux/platform_data/ad7266.h b/include/linux/platform_data/ad7266.h
index 7de6c16122df..f0652567afba 100644
--- a/include/linux/platform_data/ad7266.h
+++ b/include/linux/platform_data/ad7266.h
@@ -40,14 +40,11 @@ enum ad7266_mode {
  * @range: Reference voltage range the device is configured for
  * @mode: Sample mode the device is configured for
  * @fixed_addr: Whether the address pins are hard-wired
- * @addr_gpios: GPIOs used for controlling the address pins, only used if
- *		fixed_addr is set to false.
  */
 struct ad7266_platform_data {
 	enum ad7266_range range;
 	enum ad7266_mode mode;
 	bool fixed_addr;
-	unsigned int addr_gpios[3];
 };
 
 #endif
-- 
2.23.0

