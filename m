Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8158F23B16C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHCX65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgHCX6b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DD2C0617A3
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so32709049ilh.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJszXsIKyYU0Uv7vZpHtfIjl+uNEiIAtSeERsmAU/hw=;
        b=TQRhsXhY4PVSvvJrMKnsUTwjSX6hVQRoUZ0VJuAJiDcM+qVfEuaSjQCDzvtwgYPhao
         A+WQF0I2E4iWUY4jzDX4Ld1zrYCn/oMHFXxOt4NlxjkWvFixSqgnrxdJxoVg4Ybq8SGN
         Y0Fz0D7caOq0W4OTJcMywQLLmYpTRaI9JKbu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJszXsIKyYU0Uv7vZpHtfIjl+uNEiIAtSeERsmAU/hw=;
        b=DeQl7LxKQRzh6i/eLyASnjDmLp9pwfn2RQXNqZQIK6s/sq2xdQWNV1Jd8KtGSbmHuw
         cJQA0F08AhJYqTbFPb2jxej2yxhQISoVmDGRgkvhLn8Ke61s8UMnx1v9c7LaPtxL6zZZ
         nVQSCR8I1zhEaJpvEtX7Iz3ij8ZCbwChbW7YjV9nr2VS6UnQWdASe28nmWRzAmEQm770
         RMNcyQjz9Uh2Hs6lHpfiQev8OrUgvAeSQ8q12LdRLzOrEKHXhkXXrgvfqTGD+sg+kwVA
         TruiEZUUrcRmnh6ANYz4ZJ41gkLo16Fqgl9mcZI3mz2zKKXuQF/eCUrsaEepW4JsfMZ1
         OLQw==
X-Gm-Message-State: AOAM531ZfJniSZP+F7/lxCgYq3SsMnW3OOiWCwDvMtnAin8goZNZ9H01
        lRYJyV564JDpMKnlrZ9Pjs5pZw==
X-Google-Smtp-Source: ABdhPJzhkMxtx+2V0/8hCJSJxi7ZdMVAiVUfkGHTruG1icoU3xo6IIEf8zcPO+pFUqGXgMsW2id+HA==
X-Received: by 2002:a05:6e02:cac:: with SMTP id 12mr2023360ilg.175.1596499109328;
        Mon, 03 Aug 2020 16:58:29 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:28 -0700 (PDT)
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
Subject: [PATCH v5 10/15] iio: sx9310: Simplify error return handling
Date:   Mon,  3 Aug 2020 17:58:10 -0600
Message-Id: <20200803175559.v5.10.I071b118136317d3ff77fc598079f21e4ed0e347f@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Checks for non-zero return values to signal error conditions.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 87b2de0d7b55a3..adb707e2d79612 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -347,7 +347,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	int ret;
 
 	ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
@@ -363,7 +363,7 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 	unsigned int val;
 
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val = FIELD_GET(SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK, val);
@@ -376,17 +376,17 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 static int sx9310_read_proximity(struct sx9310_data *data,
 				 const struct iio_chan_spec *chan, int *val)
 {
-	int ret = 0;
+	int ret;
 	__be16 rawval;
 
 	mutex_lock(&data->mutex);
 
 	ret = sx9310_get_read_channel(data, chan->channel);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out_put_channel;
 
 	mutex_unlock(&data->mutex);
@@ -400,22 +400,22 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_lock(&data->mutex);
 
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	ret = sx9310_read_prox_data(data, chan, &rawval);
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
 			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
 
 	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out_put_channel;
 
 	ret = sx9310_put_read_channel(data, chan->channel);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	mutex_unlock(&data->mutex);
@@ -437,7 +437,7 @@ static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 	unsigned int regval;
 	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	regval = FIELD_GET(SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK, regval);
@@ -539,7 +539,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		return;
 	}
@@ -573,7 +573,7 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
 	mutex_lock(&data->mutex);
 
 	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		goto out;
 	}
@@ -616,20 +616,20 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 	mutex_lock(&data->mutex);
 	if (state) {
 		ret = sx9310_get_event_channel(data, chan->channel);
-		if (ret < 0)
+		if (ret)
 			goto out_unlock;
 		if (!(data->chan_event & ~BIT(chan->channel))) {
 			ret = sx9310_enable_irq(data, eventirq);
-			if (ret < 0)
+			if (ret)
 				sx9310_put_event_channel(data, chan->channel);
 		}
 	} else {
 		ret = sx9310_put_event_channel(data, chan->channel);
-		if (ret < 0)
+		if (ret)
 			goto out_unlock;
 		if (!data->chan_event) {
 			ret = sx9310_disable_irq(data, eventirq);
-			if (ret < 0)
+			if (ret)
 				sx9310_get_event_channel(data, chan->channel);
 		}
 	}
@@ -668,7 +668,7 @@ static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
 		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
 	else if (!data->chan_read)
 		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	data->trigger_enabled = state;
@@ -697,7 +697,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 			 indio_dev->masklength) {
 		ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
 					    &val);
-		if (ret < 0)
+		if (ret)
 			goto out;
 
 		data->buffer.channels[i++] = val;
@@ -804,13 +804,13 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	unsigned int ctrl0;
 
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &ctrl0);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* run the compensation phase on all channels */
 	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
 			   ctrl0 | SX9310_REG_PROX_CTRL0_SENSOREN_MASK);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
@@ -836,21 +836,21 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 	unsigned int i, val;
 
 	ret = regmap_write(data->regmap, SX9310_REG_RESET, SX9310_SOFT_RESET);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	usleep_range(1000, 2000); /* power-up time is ~1ms. */
 
 	/* Clear reset interrupt state by reading SX9310_REG_IRQ_SRC. */
 	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
 		initval = &sx9310_default_regs[i];
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
-		if (ret < 0)
+		if (ret)
 			return ret;
 	}
 
@@ -904,14 +904,14 @@ static int sx9310_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&client->dev, "error in reading WHOAMI register: %d",
 			ret);
 		return ret;
 	}
 
 	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
@@ -923,7 +923,7 @@ static int sx9310_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 
 	ret = sx9310_init_device(indio_dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (client->irq) {
@@ -932,7 +932,7 @@ static int sx9310_probe(struct i2c_client *client)
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		data->trig =
@@ -954,7 +954,7 @@ static int sx9310_probe(struct i2c_client *client)
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.28.0.163.g6104cc2f0b6-goog

