Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7662A23497D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbgGaQtQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbgGaQtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE11C0617A0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t15so23359554iob.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYy6g4g12hDeaNHzULjsE2Gx5xOjOf8JvHxpoCRhqgA=;
        b=Cusy9I04L3C4Pk0XG3iyhL5cF11kukZlfyMtPKvU2HLhhoSOhTi6Z/ma3n9SCUECbl
         kvIkhlG4ksTkmp7nF0iAKbcCNpRgs7vJG5V6fcNIPkd1xi714JOXaIiPXx9BccC5mK8u
         tfQH+HRiNWNMWWwIFzBFza/O3HHY4F88w+8y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYy6g4g12hDeaNHzULjsE2Gx5xOjOf8JvHxpoCRhqgA=;
        b=HTw9jifRXSrbWHCdCc6MD8MabmqZWn/JIVZOz+SNHOujwOyuou/aQ0pNGyP9QtPv47
         L+V1CnKOU6BUw9rp2Nq3ytjUVULAArc50b/hTqnb0hxiynUidkvWBqmOfmYs9ULo1or4
         Gi4FJ/gsXYlSnqLDjex8fUFkMVvPH0x44GL+UUU6Ka82NCYMjhYSIog8vWlZgT7qb4Oc
         q3ujQ0BsSyq8ptIF5jStm6Ae5yQizSPwpJ5DtRlLe6zPz4Lb8pPZTOwvI0Oh6bINsbZ7
         Aa+UDYyiTy6/3eSw7KllMgZyHoyMHM+EOwHiV3d6YntQSGO91Nxa+USWVuE2/9rLB5Wz
         gAnw==
X-Gm-Message-State: AOAM532DwJ+DpLH3LXWBbq+eTWMGmxl/K+ntfswKAZJCzk0O/ATD8syl
        hmIpzHW8kXdX7LjUZt+B7X6iHQ==
X-Google-Smtp-Source: ABdhPJyKO2BFy/coo6T6rN0z/NhnWlfECEuyb9vgR9Qvikn+kFWqE8MjhZFuMBGRZVN+udxu87y71A==
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr4381030iod.63.1596214148903;
        Fri, 31 Jul 2020 09:49:08 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:08 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 11/15] iio: sx9310: Use variable to hold &client->dev
Date:   Fri, 31 Jul 2020 10:48:48 -0600
Message-Id: <20200731104555.v3.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
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

Changes in v3: None
Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6c5425c6fe0d03..feb5bbff56f447 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -890,11 +890,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
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
@@ -908,17 +909,16 @@ static int sx9310_probe(struct i2c_client *client)
 
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
@@ -930,7 +930,7 @@ static int sx9310_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -938,29 +938,29 @@ static int sx9310_probe(struct i2c_client *client)
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

