Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E65231607
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgG1XGC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgG1XFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF8C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so22598309ion.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvUE4fgzf8wh42WxKcUFkplOf94kmyY3rLuYSWpv16M=;
        b=GqzmZka+iawWrW35r3zOl1sHdJcBj2BEYq+myO6YYTRT+NgrX/DOjXdEC2+vsCPkJr
         lGdDaZF145+cHIKk4ku4n046lon+Ta9KN7XLXXVsQW8VFmZfzBGBGz5k2rQjchWawbBa
         0kNkP38j5QGlfPqmRCyJtDSHyEy0GurCj0608=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvUE4fgzf8wh42WxKcUFkplOf94kmyY3rLuYSWpv16M=;
        b=d93ExO5y6k378zz8wrsv4cKkcKiGMv7OK32835Vv3X+e0bprBsAaJJdRevrt9Oe1RF
         5FUEiUfr5EhekeuhL6bPHKAGseiy1LOk5vGMlAZwv1kaN0n9afPwdEPQ0Hr8V9XVnThf
         3Zl/QY/X5YxHc/bNhpKv+LsSEp5sC1hWZcDFKSPllRpItwAU76IJy9uJM41S1NqJnpew
         fDBFb55U+lZdFyJyqHeqfWuCUDu0zOLCtvcoxnEwO0R1WSppnTGnpCZoaZHKf4aVm5zg
         541+c1Si1u64BjWIYxOyNHGbrmspORRlSy2x6Daeh4daz7sMH94D2CKvtbtwcUKKEp7i
         0NrQ==
X-Gm-Message-State: AOAM530984faeqqgT7PGIwRLTMhOMbS07McAZQls1avmw0tgxr1zLHnz
        XJT+i7XBEYsjC0XxsJP+kGI5Jg==
X-Google-Smtp-Source: ABdhPJyQOMAFeMDdZGuEFdgpQnhA9CS/UXR+D1g8OwPag1DusMdMAtJe/5wy6Oj90poMWp381XAfNw==
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr22030784iod.33.1595977545169;
        Tue, 28 Jul 2020 16:05:45 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:44 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 11/14] iio: sx9310: Use variable to hold &client->dev
Date:   Tue, 28 Jul 2020 17:05:17 -0600
Message-Id: <20200728170317.v2.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
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

Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index f43ca6a0acf2fc..517ff76acd00a0 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -885,11 +885,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
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
@@ -903,17 +904,16 @@ static int sx9310_probe(struct i2c_client *client)
 
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
@@ -925,7 +925,7 @@ static int sx9310_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -933,29 +933,29 @@ static int sx9310_probe(struct i2c_client *client)
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

