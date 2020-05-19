Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F21D9692
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgESMoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgESMof (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 08:44:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD68C08C5C0;
        Tue, 19 May 2020 05:44:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so15690138wre.13;
        Tue, 19 May 2020 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FM1JmGR/XyNvOFJbZPXQGrpNEzXCNoP8xq4dKDH4+U8=;
        b=A+sT2Y7VObAjcJNLFNTRvXlYLhshYYP1aKVL3dgMUbjJMkZah81uyVIV0BORb9bJx5
         SV9W1fLfpgwPEvF9bk7OpNWl8BsXCMLSbq/wBeborTNW/X44Kw5Cs+rtRG4baePY1KpN
         RsS8FQ6Wz1coqGXhKROfvAMX+wMzAHEqrw3I2AYAlYOTpY9Rb98DMbcgLM2zfnRYoqZk
         lhsI2SHwv/4m7wo7szju6g9L1y3vnXrGRHqD1mzSCl+j8mbamFsOo1Wv6rp1NzLbOmGi
         EPOm/TTgg781bxRn96mH0Qk5LitCkCwDggxGAPxUrf7jz6SnI4ZWI8G0JdEUdUf2XzjP
         O0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FM1JmGR/XyNvOFJbZPXQGrpNEzXCNoP8xq4dKDH4+U8=;
        b=jnBcOEDbvbD+sWs1HLibfRNSxLpLgCGky6RvTY+6MV+6FktzCCcNoG1epT0slY+lkX
         tZ81LYjV4IFY6/p32PuNejAPrwY3hS4B3oF+k5HnrxH7aJOOXPTJWhNbDk84dUVy5RsQ
         ayBTCWH0geFwZAaZCvPn0Iy5hxaf/FHcQHlKPQSjh2hL1xKKSxKbda2aZOd19B55Hrgq
         SeVXxd4FWb8grc9/Oc9JBQYYuwr3em6/go04zZ56C2rqP/9181o03DpXXz6yxrGWApvz
         pzInhtnl/0HHAXmfmZfMYyh+PNwUyxzEKjiSgoj8NlSRw+I8ZNQTuJI5ct0oCd6AC46d
         Te2g==
X-Gm-Message-State: AOAM533hKwnhB5T00sQZCMswIVVdjRz7Ici7W6hIBBROPEhkICYW+DWE
        fPompCffliETNx/RY9Qf0y0MEHKeFqhziQ==
X-Google-Smtp-Source: ABdhPJxHN6++bAS6sIIPL4V8O1yCDlTOnBt1TcBn32R9JK+cLug/0WPY/VXi5Y2DCYQfUBKOmzAlHw==
X-Received: by 2002:a5d:6b83:: with SMTP id n3mr27555402wrx.213.1589892272808;
        Tue, 19 May 2020 05:44:32 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id b12sm3953870wmj.0.2020.05.19.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:44:32 -0700 (PDT)
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
        Jonathan Cameron <jic23@kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH v3 4/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Tue, 19 May 2020 14:43:54 +0200
Message-Id: <20200519124402.26076-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to AK09911 datasheet, if reset gpio is provided then
deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am while() checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

