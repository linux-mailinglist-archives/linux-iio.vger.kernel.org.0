Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35BF74741
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfGYGeU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 02:34:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34070 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfGYGeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jul 2019 02:34:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so23020433plt.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jul 2019 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dlVS9wrL3Ud7T0+1eB3/cbuxzq2FNswQPzy/JeSfgyo=;
        b=GTb92mvFVJ+XqMAuo0hSQ52CQEiKhH6k0ygsgBjwYIu1KAV6Ar4Wh6Syq1oy33lL1w
         KCZ/5kMmhXSwPq7ZLDVoSVIvP2NkkCOMylaUszovQObgNwlrgy2LP4YU3qpemN5kYk5X
         vCRwZJnK5timEjLq4RXmoVpDIdD9cS5BRdb17ynBGuSBRokd/ZZDYlYfGabuj6PkoMW7
         Z9gJR0i0IgNdsrrc+syUXjF6A90o5EpBjvH+uM0pl13KrBYDvo5VkxrmCIGKDbMpscT3
         ePIj49uUO06xDNSIMYTqst/Mqt2Pga61KxjukQH9VqDYVL8/yLxYN+F8xMKfl6yIRQ7T
         eKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dlVS9wrL3Ud7T0+1eB3/cbuxzq2FNswQPzy/JeSfgyo=;
        b=PmhTSnoawoFj/BB4y9ahBhi60Ub32YUBDkfyO0tvzl+4Dbb8uoHVdqX56SPKlIOOLS
         dxql86c+/sfdmFVHWbFc05/Xqtdadc+UW6FZKyp5VZItS/a3JVy3jIJns467UdB8HTPp
         MAd/PbH7JB0GG6uslQMgdQp+M+nh7mErWUUodDAxMsBj3rcahS66U+vVl/TYW95McbuS
         gwNuj4i3fcDZU43n/xzQCgAw7RzWfOku4vcw1RxqeWp8KAfLRuMGfuQpLqXxwy4E94GT
         OMGqn39TLz0BdvgTywyc1NEAkXV8T407plh+rmF9Lxa9thRTvO016fXHkWJGvVk35fXf
         UgKg==
X-Gm-Message-State: APjAAAUQIUjTH3wi3ARv8S1zLXxdAk8QK3x6eLgA1K9kNbhoDbwAHGpb
        rDHP/6aaLCFgifwv6UUMQtNZ0g==
X-Google-Smtp-Source: APXvYqyJ++EoPykdk2pIM3XvADy9ZWwV3mqWxefi5d6b190vSrTtW2216BSqfPUHUsDB2YEJo8ZHjA==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr86662809plj.116.1564036458081;
        Wed, 24 Jul 2019 23:34:18 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 81sm43010327pfa.86.2019.07.24.23.34.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 23:34:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     freeman.liu@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sc27xx: Change to polling mode to read data
Date:   Thu, 25 Jul 2019 14:33:50 +0800
Message-Id: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

On Spreadtrum platform, the headphone will read one ADC channel multiple
times to identify the headphone type, and the headphone identification is
sensitive of the ADC reading time. And we found it will take longer time
to reading ADC data by using interrupt mode comparing with the polling
mode, thus we should change to polling mode to improve the efficiency
of reading data, which can identify the headphone type successfully.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/adc/sc27xx_adc.c |   81 ++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index f7f7a189..ea864290 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -3,7 +3,6 @@
 
 #include <linux/hwspinlock.h>
 #include <linux/iio/iio.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
@@ -46,14 +45,18 @@
 /* Bits definitions for SC27XX_ADC_INT_CLR registers */
 #define SC27XX_ADC_IRQ_CLR		BIT(0)
 
+/* Bits definitions for SC27XX_ADC_INT_RAW registers */
+#define SC27XX_ADC_IRQ_RAW		BIT(0)
+
 /* Mask definition for SC27XX_ADC_DATA register */
 #define SC27XX_ADC_DATA_MASK		GENMASK(11, 0)
 
 /* Timeout (ms) for the trylock of hardware spinlocks */
 #define SC27XX_ADC_HWLOCK_TIMEOUT	5000
 
-/* Timeout (ms) for ADC data conversion according to ADC datasheet */
-#define SC27XX_ADC_RDY_TIMEOUT		100
+/* Timeout (us) for ADC data conversion according to ADC datasheet */
+#define SC27XX_ADC_RDY_TIMEOUT		1000000
+#define SC27XX_ADC_POLL_RAW_STATUS	500
 
 /* Maximum ADC channel number */
 #define SC27XX_ADC_CHANNEL_MAX		32
@@ -72,10 +75,8 @@ struct sc27xx_adc_data {
 	 * subsystems which will access the unique ADC controller.
 	 */
 	struct hwspinlock *hwlock;
-	struct completion completion;
 	int channel_scale[SC27XX_ADC_CHANNEL_MAX];
 	u32 base;
-	int value;
 	int irq;
 };
 
@@ -188,9 +189,7 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
 	int ret;
-	u32 tmp;
-
-	reinit_completion(&data->completion);
+	u32 tmp, value, status;
 
 	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
 	if (ret) {
@@ -203,6 +202,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto unlock_adc;
 
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
+				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
+	if (ret)
+		goto disable_adc;
+
 	/* Configure the channel id and scale */
 	tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
 	tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
@@ -226,15 +230,22 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto disable_adc;
 
-	ret = wait_for_completion_timeout(&data->completion,
-				msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
-	if (!ret) {
-		dev_err(data->dev, "read ADC data timeout\n");
-		ret = -ETIMEDOUT;
-	} else {
-		ret = 0;
+	ret = regmap_read_poll_timeout(data->regmap,
+				       data->base + SC27XX_ADC_INT_RAW,
+				       status, (status & SC27XX_ADC_IRQ_RAW),
+				       SC27XX_ADC_POLL_RAW_STATUS,
+				       SC27XX_ADC_RDY_TIMEOUT);
+	if (ret) {
+		dev_err(data->dev, "read adc timeout, status = 0x%x\n", status);
+		goto disable_adc;
 	}
 
+	ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA, &value);
+	if (ret)
+		goto disable_adc;
+
+	value &= SC27XX_ADC_DATA_MASK;
+
 disable_adc:
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
 			   SC27XX_ADC_EN, 0);
@@ -242,32 +253,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	hwspin_unlock_raw(data->hwlock);
 
 	if (!ret)
-		*val = data->value;
+		*val = value;
 
 	return ret;
 }
 
-static irqreturn_t sc27xx_adc_isr(int irq, void *dev_id)
-{
-	struct sc27xx_adc_data *data = dev_id;
-	int ret;
-
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
-				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
-	if (ret)
-		return IRQ_RETVAL(ret);
-
-	ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA,
-			  &data->value);
-	if (ret)
-		return IRQ_RETVAL(ret);
-
-	data->value &= SC27XX_ADC_DATA_MASK;
-	complete(&data->completion);
-
-	return IRQ_HANDLED;
-}
-
 static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 				  int channel, int scale,
 				  u32 *div_numerator, u32 *div_denominator)
@@ -454,11 +444,6 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		goto disable_adc;
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
-				 SC27XX_ADC_IRQ_EN, SC27XX_ADC_IRQ_EN);
-	if (ret)
-		goto disable_clk;
-
 	/* ADC channel scales' calibration from nvmem device */
 	ret = sc27xx_adc_scale_calibration(data, true);
 	if (ret)
@@ -484,9 +469,6 @@ static void sc27xx_adc_disable(void *_data)
 {
 	struct sc27xx_adc_data *data = _data;
 
-	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
-			   SC27XX_ADC_IRQ_EN, 0);
-
 	/* Disable ADC work clock and controller clock */
 	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
 			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
@@ -553,7 +535,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	init_completion(&sc27xx_data->completion);
 	sc27xx_data->dev = &pdev->dev;
 
 	ret = sc27xx_adc_enable(sc27xx_data);
@@ -569,14 +550,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq, NULL,
-					sc27xx_adc_isr, IRQF_ONESHOT,
-					pdev->name, sc27xx_data);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request ADC irq\n");
-		return ret;
-	}
-
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
1.7.9.5

