Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73EE1DB9A6
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETQfN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgETQfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 12:35:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4FC061A0E;
        Wed, 20 May 2020 09:35:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f189so4189491qkd.5;
        Wed, 20 May 2020 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=Nlq5nfjdQYcHX7zuihr1ObqPMAidDgxveeyFHIQQ7O9LGWYgpBFhwvwsgqqYMjwc5s
         RA2apLZKDvKsPMKXMg/AE4qFdbrEI1TZw96L5ME1jwd6CcnN/YvSgi4ZcyXxpvrftE2D
         9FKSV7VtZ9Wm5bliE6BjuHB97TJzdramHadvRcVHq9FXeo+KPe5OZVByx3eJJGg2kVEa
         sJbJNSAzopb/Rzy9cTjpnFAbe/r3b6Huh7UwSS1YvOZjsAFj55pZNHF0J9eXbJP6b5Vr
         3j5xaZc+CSPb4DE1rbqFVNtgiqHcwPzDj3fYw5riUITT8pwaYauKrjLcGRE6Ht99+O8q
         RilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ru/VedSe7R+1+BFX/X1C1fyozp4gv15sJxfe6kqv7eI=;
        b=tGhRy7GmU0pPP2QRdOQVFbhcZ9Imp3YhwcC96pwFMP1aD2M3xiUTehsqdrimnI0s41
         MsnuRG7VJ1V4whTlw0cm5uFHyLrujHseIluTxsQ7ne2jEs1IEKZ1EGJb6wvo3poj8wzd
         pPO5vted8y/QIb27iE7nQbnZOKwt/w7PbQF2y9tFskdim1RNLltH6MG5+xDWCG7a019T
         EOOPMo1XHuarWzWIqXLk7gmAXqrOhglTUKISXN8UsRmU9ss3hw/4dLGJiF7gR5kvKIzq
         kV1GQkZysSNQ0295WLcAvnbk6gVwHlOujVYafu0j+FQeOBdVHpbbGGgTfX/KDBg+JAeA
         I9Bg==
X-Gm-Message-State: AOAM5306kIRX629nX1luGrczYAFz3B5KPTkrXK1Po/wQlgv/1N/aDXN9
        NeW6PIIzDu03mO/HJ0UhNG6yq84KDiQ+cQ==
X-Google-Smtp-Source: ABdhPJwgqPZSyTS3lDP8SPde5lXqTuj9YJ2uc8noId+dOCF8OR+0eN0IGtVc5ore5UFo4ycYXVwv0A==
X-Received: by 2002:ae9:e854:: with SMTP id a81mr5759199qkg.396.1589992511156;
        Wed, 20 May 2020 09:35:11 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q59sm2803261qtd.73.2020.05.20.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:35:10 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 4/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Wed, 20 May 2020 18:34:09 +0200
Message-Id: <20200520163417.27805-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
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

