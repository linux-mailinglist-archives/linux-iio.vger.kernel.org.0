Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4174823B10B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgHCXmN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgHCXmL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A3C06174A
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so28009969ioe.9
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCLYtffRrMc9qxywjxDgyRIEIRkAPxoHu8maaV5aJWg=;
        b=EDkTgSx3ByB9XWQ/01p1l86rRwnIRSTI0xhW+K2n3plr2QZRVutBXTYoeU5ec1W3Tz
         G5YVZTQ2k5BUmowPwuWDTF/OAHN3ftbuJF5LnKr1gR209vP7g7PKSjGRQwHaRz5Ub314
         7rKLsxFW+Enn/59lDX+maCglGbigITKk6JCnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCLYtffRrMc9qxywjxDgyRIEIRkAPxoHu8maaV5aJWg=;
        b=S7vD3XXQ3brSHpyVY0Zs9FOb0kwjLYRXwagm6B2MpXTgZIZOn2LP7Cvff6InEJ5C5c
         vl8jhytVq3vyvoULhAFkjd6lzqgm5Lzup/c80jOC+q8z2/828MN/8oz9o9ALAeL+qyxq
         4de9SO7HOENxzNdxBCVqMbiDsP2eCU0+15JpoGbN2jpmgInSRAAXcXNBp9K6ktDT471t
         kgL14cwRCbeggxzMqRjDtWd5gf8M36M4rxrqAJmUtzTbwaEMSGiieeRAlyFEfe7hvnbW
         9lI93CTr9vDcctVRRDpFbBWydz+Qq8IYSLCnxTBUsMVAQgKDG+BSS24i6T6NuJIFnOMc
         57EA==
X-Gm-Message-State: AOAM532DdMOL+KEV7oXQhszxNhXopfG9LjnpMUyUuHwcc0QnPRuLhBVc
        IQEFN1JgZ5s5wRVNbel/KovRhw==
X-Google-Smtp-Source: ABdhPJzUdE3Zrr6eM+UfrKrRGosXuUSSmWv1dPrc4yWeMlpSOqKpmjaspKxf66hkmDj3OVUNcrJi1A==
X-Received: by 2002:a05:6638:348:: with SMTP id x8mr2483365jap.62.1596498130366;
        Mon, 03 Aug 2020 16:42:10 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:10 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 11/15] iio: sx9310: Use variable to hold &client->dev
Date:   Mon,  3 Aug 2020 17:41:50 -0600
Message-Id: <20200803131544.v4.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improves readability by storing &client->dev in a local variable.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 563ab08de37051..8b0e4d4eab5cf7 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -886,11 +886,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sx9310_data *data;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (indio_dev == NULL)
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
@@ -904,17 +905,16 @@ static int sx9310_probe(struct i2c_client *client)
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
-		dev_err(&client->dev, "error in reading WHOAMI register: %d",
-			ret);
+		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
+	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
 	if (ret)
 		return ret;
 
-	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
-	indio_dev->dev.parent = &client->dev;
+	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = sx9310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
 	indio_dev->info = &sx9310_info;
@@ -926,7 +926,7 @@ static int sx9310_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -934,29 +934,29 @@ static int sx9310_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		data->trig =
-			devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
-					       indio_dev->name, indio_dev->id);
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    indio_dev->id);
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = &client->dev;
+		data->trig->dev.parent = dev;
 		data->trig->ops = &sx9310_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
-		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int __maybe_unused sx9310_suspend(struct device *dev)
-- 
2.28.0.163.g6104cc2f0b6-goog

