Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA623B113
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgHCXma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgHCXmM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B15C06179F
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so25113220iow.11
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZXl4w3kDSaErfg2y3h25IQlBp0Egyg38+/XFxCPJ8A=;
        b=fDPbqbsVIqwvebwhjnKfOdnJ0VZAH58mV9zMAwDqxwWIv94r98qP19gFWA8Kv9PkXh
         cl4LzqEudpJe48Af9e9RyOir4bsd6z11BMiyuhcb2wyYZ8pN+oNqQXIvyBgCEdEmktZZ
         zzXcmQw3RVqHDYQKY4IzrpSyT+yyH+2VONVGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZXl4w3kDSaErfg2y3h25IQlBp0Egyg38+/XFxCPJ8A=;
        b=TxnMtj/sU8d2t4iwsagtbSIb24tAieJaYTTFeXygApyJzAJWUdSswfL4A/62BDnb/c
         LJO8mUl0D3n7Iv8EYwU5o42mFTn1Pt0i9hAMSe8q5anIwcZcLqQKc0AtjBHzTYkqLXv/
         hVfcCbnGT5WCAg20hoeHjWtFKaVeI4NmkVZeMNCmDmNBAiHdCPs0eMQ9K4yxlSqIfn+a
         DqR0gkatTEGNpIr7DkwdN3UpM8FbdIqA+Sl3fBqo/lj8iFUUXuROQtZ1BoM5E8Zl8cFa
         iG8hKgKqrzI0WQkU7qE3/ivdnhxBvjzJWQTTMjU+fT5vp3CgTnGuSXzYYOne+hOIED0H
         ZyrQ==
X-Gm-Message-State: AOAM533oP9u0cbENSK8vHZqelg8vykvdpCqQGQQxZ45nJUgWQM+LYve2
        8KkAex3XhsRG3ie1aJfKZhkOGQ==
X-Google-Smtp-Source: ABdhPJzoLMHeensVJ4IokfC6k8cATFGmmq4wlFwJMAEBG3ndJsiRW8PPv/xb9dHaPxCTW7raAkCGcg==
X-Received: by 2002:a05:6638:138a:: with SMTP id w10mr2474380jad.36.1596498131329;
        Mon, 03 Aug 2020 16:42:11 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.10
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
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 12/15] iio: sx9310: Miscellaneous format fixes
Date:   Mon,  3 Aug 2020 17:41:51 -0600
Message-Id: <20200803131544.v4.12.I426355a035f0394dfccba5bb2bc6f8db872c4be3@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Miscellaneous format fixes throughout the whole file.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 8b0e4d4eab5cf7..6395f61b720658 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -90,28 +90,21 @@
 #define   SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT	0x3c
 
 #define SX9310_REG_SENSOR_SEL				0x30
-
 #define SX9310_REG_USE_MSB				0x31
 #define SX9310_REG_USE_LSB				0x32
-
 #define SX9310_REG_AVG_MSB				0x33
 #define SX9310_REG_AVG_LSB				0x34
-
 #define SX9310_REG_DIFF_MSB				0x35
 #define SX9310_REG_DIFF_LSB				0x36
-
 #define SX9310_REG_OFFSET_MSB				0x37
 #define SX9310_REG_OFFSET_LSB				0x38
-
 #define SX9310_REG_SAR_MSB				0x39
 #define SX9310_REG_SAR_LSB				0x3a
-
 #define SX9310_REG_I2C_ADDR				0x40
 #define SX9310_REG_PAUSE				0x41
 #define SX9310_REG_WHOAMI				0x42
 #define   SX9310_WHOAMI_VALUE				0x01
 #define   SX9311_WHOAMI_VALUE				0x02
-
 #define SX9310_REG_RESET				0x7f
 #define   SX9310_SOFT_RESET				0xde
 
@@ -407,7 +400,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
-			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
+			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
 
 	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
 	if (ret)
@@ -434,8 +427,9 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 {
 	unsigned int regval;
-	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
+	int ret;
 
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 	if (ret)
 		return ret;
 
@@ -520,10 +514,9 @@ static irqreturn_t sx9310_irq_handler(int irq, void *private)
 		iio_trigger_poll(data->trig);
 
 	/*
-	 * Even if no event is enabled, we need to wake the thread to
-	 * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It
-	 * is not possible to do that here because regmap_read takes a
-	 * mutex.
+	 * Even if no event is enabled, we need to wake the thread to clear the
+	 * interrupt state by reading SX9310_REG_IRQ_SRC.
+	 * It is not possible to do that here because regmap_read takes a mutex.
 	 */
 	return IRQ_WAKE_THREAD;
 }
@@ -640,7 +633,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 
 static struct attribute *sx9310_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
+	NULL
 };
 
 static const struct attribute_group sx9310_attribute_group = {
@@ -971,7 +964,6 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 	mutex_lock(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl0);
-
 	if (ret)
 		goto out;
 
@@ -1017,21 +1009,21 @@ static const struct dev_pm_ops sx9310_pm_ops = {
 static const struct acpi_device_id sx9310_acpi_match[] = {
 	{ "STH9310", SX9310_WHOAMI_VALUE },
 	{ "STH9311", SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
 	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
 	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
 
 static const struct i2c_device_id sx9310_id[] = {
 	{ "sx9310", SX9310_WHOAMI_VALUE },
 	{ "sx9311", SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, sx9310_id);
 
-- 
2.28.0.163.g6104cc2f0b6-goog

