Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A9A1E654B
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbgE1PBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403800AbgE1PBm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 11:01:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6ACC08C5C6;
        Thu, 28 May 2020 08:01:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n141so3384388qke.2;
        Thu, 28 May 2020 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=gY02BO7j1hfkO7xiJppNT1VA/huyBuSeTxCzHxMDgCdPs2hZPHZA4Hb7RDN99RAwXo
         1vUp0AIkVEQUKHMxpcD6hKK5H9YHqVfOLUE9MjorAy2+YVsApWCC1b0daaq2OkVcbRSr
         wSFH89UeUm16lCXZl9woAiO2O/I4azVKFzv6hUoC6P1fl+HY1brKQOW5+9yCP4+qCtwJ
         spX281uWTwZT2YgeT+7Wc70mhxexRyF8381oySA42ZwfnIcClWlUdQrnMexX6SlZA/1B
         bgjtAWVQmuFPWPT1rB+/SfWq2tE4hCV7WqEEIBYo6gei70YU3XPbmsjQv1KurdJ3g6Kj
         UIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=HFa6UZgLYA/5LrJ0uxm0LIKiyDetGe0/AQxxcGAY0T1CUB+lAd/KuDMQwFcXVUWTcp
         9RKvYuakHVR2GmasfHra1/9IAmKKeowkdlfuV15LOphjYMeU3/dR77rMb+2OCKinEyuZ
         bfoNK9EhaJ7wpaUF51wDVwjpRgGabfN+Qv/aa0efRecJttEh/yN34DWtdwcp8cdsKMhJ
         H8vTd8Z8i8lYXbHdpm5VyjIl2F0+9bQnKVAQIC4XHILTPQ7ogT4ME/7eQnkTNH4bnEfP
         uD/pMf7A4VEfLnsJZ6LqW36FTuRbMl63Citu7WXq8VvXC+cfbG/x56H+HAg7xXcatudW
         cF2w==
X-Gm-Message-State: AOAM532OrfFVlZedUB2Y6QBeTLno4MbwrD8APETc0wBdBP86g6YeSh26
        H7lVBj+42Nh/X5smyT6KoWrBhFsaSLs=
X-Google-Smtp-Source: ABdhPJymSeEM3dwFkTKYe6p4AbCg0clNODe/pHDF4729SUqxt3feu2P4iGlIHeubzLIqkRrS/cMq+g==
X-Received: by 2002:a37:7745:: with SMTP id s66mr3231700qkc.429.1590678099683;
        Thu, 28 May 2020 08:01:39 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q32sm3901881qtf.36.2020.05.28.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:01:39 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v7 5/5] iio: magnetometer: ak8975: Add gpio reset support
Date:   Thu, 28 May 2020 17:01:05 +0200
Message-Id: <20200528150106.12022-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to AK09911 datasheet, if reset gpio is provided then
deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am() while checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheet says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/magnetometer/ak8975.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index fd368455cd7b..a23422aad97d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -358,6 +358,7 @@ struct ak8975_data {
 	u8			asa[3];
 	long			raw_to_gauss[3];
 	struct gpio_desc	*eoc_gpiod;
+	struct gpio_desc	*reset_gpiod;
 	int			eoc_irq;
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
@@ -384,6 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
+
+	gpiod_set_value_cansleep(data->reset_gpiod, 0);
+
 	/*
 	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
@@ -396,6 +400,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 /* Disable attached power regulator if any. */
 static void ak8975_power_off(const struct ak8975_data *data)
 {
+	gpiod_set_value_cansleep(data->reset_gpiod, 1);
+
 	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
 }
@@ -839,6 +845,7 @@ static int ak8975_probe(struct i2c_client *client,
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
+	struct gpio_desc *reset_gpiod;
 	const void *match;
 	unsigned int i;
 	int err;
@@ -856,6 +863,16 @@ static int ak8975_probe(struct i2c_client *client,
 	if (eoc_gpiod)
 		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
+	/*
+	 * According to AK09911 datasheet, if reset GPIO is provided then
+	 * deassert reset on ak8975_power_on() and assert reset on
+	 * ak8975_power_off().
+	 */
+	reset_gpiod = devm_gpiod_get_optional(&client->dev,
+					      "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod))
+		return PTR_ERR(reset_gpiod);
+
 	/* Register with IIO */
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->eoc_gpiod = eoc_gpiod;
+	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
 	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
-- 
2.17.1

