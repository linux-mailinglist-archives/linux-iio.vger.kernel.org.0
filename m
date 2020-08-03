Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2123B15D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHCX6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgHCX6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7159C061757
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l17so40393647iok.7
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KMpyivRSb9t1ozYXg3Qu6u4uWee/uI+WmauYjOrM+M=;
        b=csdSx6CE8v0jsLZjLsT72GkNNE2TlGv82/7hXbamWCuLj30mvLTxBhYCyBd050Qrw8
         OMEsIquxVJQR83LuOIGAX3Aav+LbVjcK3Qoqqr34MCDSLcSwLBP6FYU83+1ztsLrvvmw
         6s8xM3uCZ+4mh1B4GnNRE2mcgKmo2xTKqxz3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KMpyivRSb9t1ozYXg3Qu6u4uWee/uI+WmauYjOrM+M=;
        b=kTkB6cU/GTfBX/xSFrLsQHvaK6Izp3uRsTS2vTKsiVKBWgH2MYUe8uk0/6pbtDWTAS
         seSAoKDXwg+N5ygffaLyfHuu2+4slegFufywXPw3OOpgVg06UVtZKST/DA5YZ7OLbcgU
         yAt9pph/bBJ9wWlRFQCABK1lrzcWSwwEjSSi0GM0uTwQfQVda0tXuwLyImDtqsDEM5nP
         nua+ul+fPNLBMAc6qfZtAnY90GbeOdggKk0BNAN5OqJDnBTC7sMUyZ+ffZmcI/dbFZJj
         SxFQd9a88aZyKjgS47nuilAwd122CbfiRVHipjakHIx6hRlG8OsYrkGJKcey65tnf8CC
         DGIg==
X-Gm-Message-State: AOAM530jw0bfOywultCHcUJ4wzz2jLwYH+M8MSOD2QcoDSAXsWkvrmOW
        /j5+G3zhLg5DBP/Ev3FXYEkdeg==
X-Google-Smtp-Source: ABdhPJxSKTzbFqcFwQ4MYaT2vPfGVap+/MWo/KK4zlh1BfMLjJ8ZvKLk7ZF5QVc/PPoFtI9QU9JMZg==
X-Received: by 2002:a6b:be81:: with SMTP id o123mr2414732iof.64.1596499111287;
        Mon, 03 Aug 2020 16:58:31 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:30 -0700 (PDT)
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
Subject: [PATCH v5 12/15] iio: sx9310: Miscellaneous format fixes
Date:   Mon,  3 Aug 2020 17:58:12 -0600
Message-Id: <20200803175559.v5.12.I426355a035f0394dfccba5bb2bc6f8db872c4be3@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 589052d2d1146e..e92017b51c6def 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -91,28 +91,21 @@
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
 
@@ -408,7 +401,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
-			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
+			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
 
 	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
 	if (ret)
@@ -435,8 +428,9 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 {
 	unsigned int regval;
-	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
+	int ret;
 
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 	if (ret)
 		return ret;
 
@@ -521,10 +515,9 @@ static irqreturn_t sx9310_irq_handler(int irq, void *private)
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
@@ -641,7 +634,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 
 static struct attribute *sx9310_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
+	NULL
 };
 
 static const struct attribute_group sx9310_attribute_group = {
@@ -972,7 +965,6 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 	mutex_lock(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl0);
-
 	if (ret)
 		goto out;
 
@@ -1018,21 +1010,21 @@ static const struct dev_pm_ops sx9310_pm_ops = {
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

