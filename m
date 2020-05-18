Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984E21D7A1D
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgERNh2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNhX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:37:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79773C05BD09;
        Mon, 18 May 2020 06:37:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 50so11862604wrc.11;
        Mon, 18 May 2020 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uGj/EHUKtmvC6mOszdrKA/qYKAYI/PCc4BudRf6DR7o=;
        b=oCucQLvjKY4OgRb/yeNCquPu1c0cwSmKsMn1eifkhfsCMT7XgTaC3u+2ggszg5BT+n
         HMEmbVQY5nDxNDeqCwzHm34KRMITIJkX11EuytyrozUMmAQtYba8i8yPIjNzOCmtlCr/
         iM0iifZJFegEuBiYzcSzOJrr7/3iat4viehMokp20D+xiADDv+r4s0ptvuq9GnS2e3uH
         461Lk8S1uw/fO82Aw3oCfL1XBoE/IPZPy89bSh8rpsbywRDKR4HdfQHuduID17/Mq97U
         irC20Y0orc1g7aqvbW/N1p40d+0j6r5BWOhZQiSXdHBXylQFdZWY1RG3+bqMkf/bcNY3
         ElQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uGj/EHUKtmvC6mOszdrKA/qYKAYI/PCc4BudRf6DR7o=;
        b=Jyo9t5ZtucEljKV9kbsIkaMmT4VyufmfCveAu4WfJusrsvi9Pe/UxJwSYHqotrJD57
         ZcMq2YnBCNWY2BayFZ/crrvmNguS4ntllFasYpV7xXSO7eAsy9sF9Vw7RLjBaEZCDxJ5
         IuMoloP07kGtPX1jcYsuhg3uQ25vo7FSSPw8plh0LUW0MPQ2RRnSQNK2T/YEcCs86Gl4
         63SSBdI4JXtqCE2duzp9uLaymLFCDSob8/+0gJQB3pcFlTnPF8sOZG4yya+glOm/1xfX
         h9dOAdfaAo4v08a6wz2XdFCy4qbLmS3IOUt+J3savrK3IdnqpZ9zknf7ZouAOJLN0ptc
         xWvg==
X-Gm-Message-State: AOAM530YxiMHbdl9kl89sLlFt1kH64/r5L6dA5kIwWTwyvHqnWkgJw2q
        e7YhFlqJpJLjcGTc89iZUWSvu+lWMXk=
X-Google-Smtp-Source: ABdhPJw/jQG4GyBF5BdTtT1sopi05okIYUybE0FoSjCBIwTXlwtXFd401wOtOvd5h2pN6e1s2KB0RQ==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr19518322wrw.17.1589809040661;
        Mon, 18 May 2020 06:37:20 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id o26sm17054328wro.83.2020.05.18.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:37:20 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
Date:   Mon, 18 May 2020 15:36:38 +0200
Message-Id: <20200518133645.19127-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set reset gpio to high on ak8975_power_on, set reset gpio to low on
ak8975_power_off.

Without setting it to high on ak8975_power_on driver's probe fails
on ak8975_who_i_am while checking for device identity for AK09911 chip

AK09911 has a reset gpio to handle register's reset. If reset gpio is
set to low it will trigger the reset. AK09911 datasheed says that if not
used reset pin should be connected to VID and this patch emulates this
situation

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..c1ba5cd2cb6c 100644
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
@@ -384,10 +385,13 @@ static int ak8975_power_on(const struct ak8975_data *data)
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
+
+	gpiod_set_value_cansleep(data->reset_gpiod, 0);
+
 	/*
-	 * According to the datasheet the power supply rise time i 200us
+	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
-	 * total 300 us. Add some margin and say minimum 500us here.
+	 * total 300us. Add some margin and say minimum 500us here.
 	 */
 	usleep_range(500, 1000);
 	return 0;
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
@@ -856,6 +863,15 @@ static int ak8975_probe(struct i2c_client *client,
 	if (eoc_gpiod)
 		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
+	/*
+	 * If reset pin is provided then will be set to high on power on
+	 * and to low on power off according to AK09911 datasheet
+	 */
+	reset_gpiod = devm_gpiod_get_optional(&client->dev,
+					      "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod))
+		return PTR_ERR(reset_gpiod);
+
 	/* Register with IIO */
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -866,6 +882,7 @@ static int ak8975_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->eoc_gpiod = eoc_gpiod;
+	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
 	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
-- 
2.17.1

