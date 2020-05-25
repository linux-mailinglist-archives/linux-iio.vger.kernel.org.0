Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCDA1E116B
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbgEYPOC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPN7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2890CC061A0E;
        Mon, 25 May 2020 08:13:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so13973505qtb.5;
        Mon, 25 May 2020 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=hGkGvRfewXL/XVWCtw/1yM4HGdq4xhSFVnp57d6slIupYO/QR5w7vJivFODHlLHKKi
         h1CqjJY4dfAhIMj1aYJvLOj1Bj+E5cfR30dEJDBuVpvXGoUjk9mEly+3jgnBdwr44e2i
         NmWguyEsnH6vor/uPdkzOIPNh5a/fSfnCq8oa7os3Zhu6QOBNwyOyUdeF4X6K4fvyfaw
         0VIwvas5sfEsTByqiwKzY9wSSzi5wPg04gWyfoYSzvWZ7Ex4emUV25inzq1Y8GKw6K5j
         KANBO0YpDh83xUwgZvQDH5lmChv0m91bdBg2YOO6lHfjjot5kQvKGqcGt+GqOIpDmG5i
         bb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=r3gc+PNhFGt/zfttalcDGTTUB8eGdg1PP2P7kl8r1mT/Gma8/hKdmI/HgFobMVb1ym
         W1LUn02Kmh8p4D2nDwVRn7TZunZnQmCwIBKCV/7t9ScUaW2OrsbFS3PL2LwmHZJEGX5y
         qgbJtVXg5juuIOoFsBMPNMBX7i4A/2jlr02Ris5iVJSnGwj2wXrlgo6qsLec6pR7xSQ5
         wL/lsqA8fsT7envLn2ZN+EdmVEiU9vIQtSALbrvPE+zZXl4A4BJgjze95iuUe0uwgfgP
         ruSaNUoXgHCj5o7L4olTGm37uesvegFyjMOa6kJz0d1F6jy05kcLVcudOWIl6AYlfcKi
         UrVA==
X-Gm-Message-State: AOAM530dOFO0gko5ISawoJ4MbYhTlaKWAmPrsMrvqL6QpQf9BN4AtAR1
        zv27raH3KGJRI+sPKihJvWsenQTd+xI=
X-Google-Smtp-Source: ABdhPJy1vWV3DAXN8xTdYv6MZ+TxlR/V+rZo1l1GwaSal+Gx42Ve0EDaKggl5gGSOvGddZ7GwM8ZuQ==
X-Received: by 2002:ac8:7659:: with SMTP id i25mr16544452qtr.270.1590419637841;
        Mon, 25 May 2020 08:13:57 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:57 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v6 5/5] iio: magnetometer: ak8975: Add gpio reset support
Date:   Mon, 25 May 2020 17:10:39 +0200
Message-Id: <20200525151117.32540-6-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
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

