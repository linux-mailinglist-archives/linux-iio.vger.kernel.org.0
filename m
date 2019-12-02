Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5A10E6FB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLBIig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:38:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43947 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBIig (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:38:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so15846980ljm.10
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMOcH9pMmMXHI5CztkZLb9q8iTf5AqxD3GM1vR/f3lk=;
        b=Z4XLnWga6lz1baZHPzfEpnwUgpS//cZKtNTWIEBX+luLcdobWIvbo0+G9KJvVCt1AG
         W6wo7yGIPr4Zidvw+Lu84GEK1kd0YFHjCuqcofZLO9E/Ulf+FwbubEYFbLnl9V2aFFY9
         g4mLQZ/m9Ti0NOKQoMou0Sb8lKZQE0dSOVYLRwWu1/yPxpzrRLgGWVvGiy0YqIDHIDgP
         KRNX7t9Ifuegjr1qO5Ou6JGjjbtjfB1Cqp1HKWHX3UN+jSYVcJcnYHosuJuXHw8yCxlB
         7uAjvZaF9kMw8GuJhQyjTlHm6GSybpBmdD+6fmVFyiqRI6JMPeyKd9pIoE/QjnXE7U2+
         Jtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMOcH9pMmMXHI5CztkZLb9q8iTf5AqxD3GM1vR/f3lk=;
        b=TntpF2SHieaPIM6cBtLQI6cQ96Y8kQqz9JU/otDpNxlHbLE6QE01Iz909yeFYYJRca
         28QOEQ/wYyaZ3sr/xTCrwmC8mtKd/vc+hB5EAFUq3eXbxBNQsdTEhdAx/4n52NRLjLvG
         lMieKD/9Dud/0eIZK1OhpwoZwyxSmCi13GUJu1gKq1Eh7EtQ/cUUtoetCDS76q6+v8m2
         YlBdpxro0rZW/GmuCihHweREX2rZpgVgqCLttVTT97PyToJtFntJOmZGoAet5DjIIAzz
         1oGW620aaIyUay8j2zNYUzu7c5oUpe2Hi1JwuGY5g68F2EPFTh8Iki53+lRZJ1uAIWXQ
         Vang==
X-Gm-Message-State: APjAAAXeew81D3il9P+V3bdvDMxOFZKaeGI8sxs7ZYJfbuvik2Suec9K
        Y0upXLEmxkdpidKo3vuDxoGwUQ==
X-Google-Smtp-Source: APXvYqyzyq29gH77bdJY9igA9QUyGIEqPMy4ZPPeWlUxzakMDxfhVvqvl6u0hMHYjQueCeEOOwVr8g==
X-Received: by 2002:a2e:7816:: with SMTP id t22mr6256364ljc.161.1575275913680;
        Mon, 02 Dec 2019 00:38:33 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z26sm2553737lfq.69.2019.12.02.00.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:38:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Date:   Mon,  2 Dec 2019 09:38:30 +0100
Message-Id: <20191202083830.71572-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The lock detect GPIO line is better to grab using
a GPIO descriptor. We drop the pdata for this: clients using board
files can use machine descriptor tables to pass this GPIO from
static data.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/frequency/adf4350.c       | 30 +++++++--------------------
 include/linux/iio/frequency/adf4350.h |  4 ----
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index ae0ca09ae062..1c2dc9b00f31 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -14,11 +14,10 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/gcd.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -34,6 +33,7 @@ enum {
 struct adf4350_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
+	struct gpio_desc		*lock_detect_gpiod;
 	struct adf4350_platform_data	*pdata;
 	struct clk			*clk;
 	unsigned long			clkin;
@@ -61,7 +61,6 @@ static struct adf4350_platform_data default_pdata = {
 	.r3_user_settings = ADF4350_REG3_12BIT_CLKDIV_MODE(0),
 	.r4_user_settings = ADF4350_REG4_OUTPUT_PWR(3) |
 			    ADF4350_REG4_MUTE_TILL_LOCK_EN,
-	.gpio_lock_detect = -1,
 };
 
 static int adf4350_sync_config(struct adf4350_state *st)
@@ -317,8 +316,8 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
 			(u64)st->fpfd;
 		do_div(val, st->r1_mod * (1 << st->r4_rf_div_sel));
 		/* PLL unlocked? return error */
-		if (gpio_is_valid(st->pdata->gpio_lock_detect))
-			if (!gpio_get_value(st->pdata->gpio_lock_detect)) {
+		if (st->lock_detect_gpiod)
+			if (!gpiod_get_value(st->lock_detect_gpiod)) {
 				dev_dbg(&st->spi->dev, "PLL un-locked\n");
 				ret = -EBUSY;
 			}
@@ -381,7 +380,6 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct adf4350_platform_data *pdata;
 	unsigned int tmp;
-	int ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -401,12 +399,6 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 	of_property_read_u32(np, "adi,reference-div-factor", &tmp);
 	pdata->ref_div_factor = tmp;
 
-	ret = of_get_gpio(np, 0);
-	if (ret < 0)
-		pdata->gpio_lock_detect = -1;
-	else
-		pdata->gpio_lock_detect = ret;
-
 	pdata->ref_doubler_en = of_property_read_bool(np,
 			"adi,reference-doubler-enable");
 	pdata->ref_div2_en = of_property_read_bool(np,
@@ -561,16 +553,10 @@ static int adf4350_probe(struct spi_device *spi)
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
 
-	if (gpio_is_valid(pdata->gpio_lock_detect)) {
-		ret = devm_gpio_request(&spi->dev, pdata->gpio_lock_detect,
-					indio_dev->name);
-		if (ret) {
-			dev_err(&spi->dev, "fail to request lock detect GPIO-%d",
-				pdata->gpio_lock_detect);
-			goto error_disable_reg;
-		}
-		gpio_direction_input(pdata->gpio_lock_detect);
-	}
+	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
+							GPIOD_IN);
+	if (IS_ERR(st->lock_detect_gpiod))
+		return PTR_ERR(st->lock_detect_gpiod);
 
 	if (pdata->power_up_frequency) {
 		ret = adf4350_set_freq(st, pdata->power_up_frequency);
diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
index ce9490bfeb89..de45cf2ee1e4 100644
--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -103,9 +103,6 @@
  * @r2_user_settings:	User defined settings for ADF4350/1 REGISTER_2.
  * @r3_user_settings:	User defined settings for ADF4350/1 REGISTER_3.
  * @r4_user_settings:	User defined settings for ADF4350/1 REGISTER_4.
- * @gpio_lock_detect:	Optional, if set with a valid GPIO number,
- *			pll lock state is tested upon read.
- *			If not used - set to -1.
  */
 
 struct adf4350_platform_data {
@@ -121,7 +118,6 @@ struct adf4350_platform_data {
 	unsigned		r2_user_settings;
 	unsigned		r3_user_settings;
 	unsigned		r4_user_settings;
-	int			gpio_lock_detect;
 };
 
 #endif /* IIO_PLL_ADF4350_H_ */
-- 
2.23.0

