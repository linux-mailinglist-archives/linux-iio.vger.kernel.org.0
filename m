Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB322B9EC
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGWXD5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 19:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgGWXDu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 19:03:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE4C0619D3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so3370292plm.10
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhkToc+CMWN7b+jpoCcZqh8Ko/VUL6blm6iscU844Us=;
        b=LW6jPbAGLKnKZoExCXv3jwxiVvPPL2XTR25enHvl7sLKU7QEVGp++aAIwtRBvqopEz
         zAV9WLjSY8TyPFftu3ut2E7GHYe1hjM0rJX51H8NWdfOOOpDl0CgIAHw4OWKjgM+y8XF
         Vn0JxmA3BgAZ3mlS4x+QO0XK3dJELPVO3RCGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhkToc+CMWN7b+jpoCcZqh8Ko/VUL6blm6iscU844Us=;
        b=c3SqTjN7dz5kK//ZsX+UMIXM44hSDNe9jImovaIvip4oB25IEXEYy7WOIQAnYgTHIQ
         xOSUMrRAw2TlMjghJENOmA4bkV8WHSqDH6awnnmu9/AsaLBE8BUr2VNv/VBJZjU5dvN4
         FXnCwnKWWTR+EtNhYgd1KVegfUo5Ghoh3FcHZ08Ke6a81FxvrddD+osJEEqj2ugKm7aW
         B6ft0M1vhnWQNY2rh9v94uZ1sWV0FjShTuhXPImwhqgY/J7sEgSGdPE1riop7uDA6SHZ
         Rn/kR4K6kKH07wXQ5PmxzBXPmdfusmYPn1ZCNz8SsgX6q3Mx238F5JhJ7imyD6hL9VWh
         pt4A==
X-Gm-Message-State: AOAM532qWboIfTOsazTT9py4aXNwXTzvnnR5A4UrFKZ79aDxx4Y3D2RW
        U3Z2Mfuv5a92UPhK9pc4P9YjqA==
X-Google-Smtp-Source: ABdhPJz3a0DnpYC6w/4M5VZwNrDIcMbWdw5d/3vMmuW2A8NKijQMhft0bLzRFYqAaNYt1xkag/9/xg==
X-Received: by 2002:a17:902:368:: with SMTP id 95mr5873078pld.279.1595545429380;
        Thu, 23 Jul 2020 16:03:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k98sm3816070pjb.42.2020.07.23.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:03:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] iio: sx9310: Enable regulator for svdd supply
Date:   Thu, 23 Jul 2020 16:03:44 -0700
Message-Id: <20200723230344.1422750-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200723230344.1422750-1-swboyd@chromium.org>
References: <20200723230344.1422750-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the digital IO power supply (svdd) during probe so that the i2c
communication works properly on boards that aggressively power gate this
supply.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 49 ++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 84c3c9ae80dc..d21c17a4d541 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/buffer.h>
@@ -131,6 +132,7 @@ struct sx9310_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	struct regulator *supply;
 	/*
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
@@ -914,21 +916,31 @@ static int sx9310_probe(struct i2c_client *client,
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
+	data->supply = devm_regulator_get(&client->dev, "svdd");
+	if (IS_ERR(data->supply))
+		return PTR_ERR(data->supply);
+
 	data->regmap = devm_regmap_init_i2c(client, &sx9310_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
+	ret = regulator_enable(data->supply);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret < 0) {
 		dev_err(&client->dev, "error in reading WHOAMI register: %d\n",
 			ret);
-		return ret;
+		goto err;
 	}
 
 	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
 					data->whoami);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
 	indio_dev->dev.parent = &client->dev;
@@ -940,7 +952,7 @@ static int sx9310_probe(struct i2c_client *client,
 
 	ret = sx9310_init_device(indio_dev);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -949,13 +961,15 @@ static int sx9310_probe(struct i2c_client *client,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		data->trig =
 			devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
 					       indio_dev->name, indio_dev->id);
-		if (!data->trig)
-			return -ENOMEM;
+		if (!data->trig) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
 		data->trig->dev.parent = &client->dev;
 		data->trig->ops = &sx9310_trigger_ops;
@@ -963,7 +977,7 @@ static int sx9310_probe(struct i2c_client *client,
 
 		ret = devm_iio_trigger_register(&client->dev, data->trig);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
@@ -971,9 +985,27 @@ static int sx9310_probe(struct i2c_client *client,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
+err:
+	regulator_disable(data->supply);
+	return ret;
+}
+
+static int sx9310_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct sx9310_data *data;
+
+	indio_dev = i2c_get_clientdata(client);
+	if (!indio_dev)
+		return -ENODEV;
+
+	data = iio_priv(indio_dev);
+	regulator_disable(data->supply);
+
+	return 0;
 }
 
 static int __maybe_unused sx9310_suspend(struct device *dev)
@@ -1059,6 +1091,7 @@ static struct i2c_driver sx9310_driver = {
 		.pm = &sx9310_pm_ops,
 	},
 	.probe		= sx9310_probe,
+	.remove		= sx9310_remove,
 	.id_table	= sx9310_id,
 };
 module_i2c_driver(sx9310_driver);
-- 
Sent by a computer, using git, on the internet

