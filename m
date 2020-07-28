Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6C230D4D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgG1PNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbgG1PNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D96C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z17so1365836ill.6
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QD2zMnkde3qFVDG/0jVGmkVeNpBgY28HlienvJxu1M=;
        b=U7+6MXXJbfJhJboNeaOQcjn/6u4Z0sOQn4YYtsAU5jeIIHHLmIBWWjhfEptqNyIunS
         lQok0lgKmNtFpnjYFHQihk5T5K7DBgJGj1Q4bRmDXZg5W23G2Vqz9TE6hlZbaDmC7GD6
         nG2wiYdxg6klUZrFlGHPBnqjcoaSXKRx9szvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QD2zMnkde3qFVDG/0jVGmkVeNpBgY28HlienvJxu1M=;
        b=nVM1UcMI4EbRWDzpP8THYVe0k3QTDC9MkEZFDwQVa7d0EQ+o0z6viaeQKzoSpvQYQh
         MXENbt3T0oSBnlFfu+4tTol/lLWDU0v5dbIZF/7sL9UBkBhPfT+MEq02qxNfuysqfJlQ
         tFGUDYXAwx7od/gql2r9PhrMoOJynsVi8wHI4nT+YU0qa7x5F/hxYq33zvVomLv/R1AJ
         clAb/PrVnMIm6ItC5+5U2HVtoQKNfgVCE1DonBwhTHvO6kloau1+bop552Ffo4bo5MzK
         wGDQFcAHbmQYWJgcDIQtDTBTw3Sd7MSmoPbA5AnYx8hQYrRFIqF4xMO6lXB4z5Pj5df/
         kP4A==
X-Gm-Message-State: AOAM532x6t5qeB3A58BoLl7gXxUu6c58dEW/e5JfNQHNgeQI8bx1+VbL
        xvpINRL5jfvL23UVIwHUK1waXQ==
X-Google-Smtp-Source: ABdhPJyXVY5GbwA+/x0E3BUwZmX7S5nD9TvLV4rfdjrILbG+w5vt7+4jxBQT0a0zZbjdnOp8qBvR/A==
X-Received: by 2002:a92:ad01:: with SMTP id w1mr23769254ilh.301.1595949203284;
        Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:22 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 11/15] iio: sx9310: Use variable to hold &client->dev
Date:   Tue, 28 Jul 2020 09:12:54 -0600
Message-Id: <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improves readability by storing &client->dev in a local variable.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 051c6515e62c18..ba383710ef0dcf 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -884,11 +884,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
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
@@ -902,17 +903,16 @@ static int sx9310_probe(struct i2c_client *client)
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
-		dev_err(&client->dev, "error in reading WHOAMI register: %d",
-			ret);
+		dev_err(dev, "error in reading WHOAMI register: %d", ret);
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
@@ -924,7 +924,7 @@ static int sx9310_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -932,29 +932,29 @@ static int sx9310_probe(struct i2c_client *client)
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
2.28.0.rc0.142.g3c755180ce-goog

