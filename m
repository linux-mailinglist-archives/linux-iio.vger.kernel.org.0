Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBC592974
	for <lists+linux-iio@lfdr.de>; Mon, 15 Aug 2022 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiHOGMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Aug 2022 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiHOGMD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2022 02:12:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080119002;
        Sun, 14 Aug 2022 23:11:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u3so9380371lfk.8;
        Sun, 14 Aug 2022 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9vLo5VCBrLN9JauNmLfJu8z7xDOsGmoQq1BFjC9IoVE=;
        b=DbgWAT6m6vUcM1CWVcOkJqaoK+Vs9e/rg6a/NNYrdcVq1UKVWV+qtUQABJqVFvnISD
         59K2ojwgVMJVrp3lJsfripz1orYD3Yf68LYx/TphuKdJlXPM3y9jLuy1o7BCfAETrBHP
         bnP4Ld+R+PJBaSZ7F1TJOaO+wFW6WKwcZO9urGx9Yv7tXMgVO7NVxdozttiiYyjXl2P4
         ljYQtvGzl36toLw7gAG87gaPtvmKLlG6FnZ4rS/DDtQpKqFsd4yqObjHCOi4kZn+Xj3e
         G0OvbcpfUx/NE3CGOh0LIb9evnqq2umnDgx6AUjkUCseIej7g/L9wyK+K6t4K8zlH8Sb
         AUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9vLo5VCBrLN9JauNmLfJu8z7xDOsGmoQq1BFjC9IoVE=;
        b=71Q53NgiqTIxsNLp9biaPaJifWAe4uhYWRBZIQSXyRGgrI/9/5bUP1RbdCzvwrp24y
         1aa6Dd0FmAVceUGs8H/uMM2cUPmJYdSgVsRyU0Ht3Bxr2YMt1a5ZxjDPyueuyo+EYnhX
         N+mGJMs4+Un0sXn3Y84PQ6L6hXSipXI2xg3Xssmh81Ah21uAv0NRKP3FY6IKzGUQJHZs
         mAmfx5l6Ujti4RrS8Td5MyfqduFtbyOcgyWXR343rPZudqZ5S4OZCG95tzLS0FnllJy6
         +qM7CirN9Ld6XebLSngFkXQZ4Bv5qA4Tg9aSEmykvLUBkWfkS7G3xZ1p+HTQ4H2Kw4yh
         rcSg==
X-Gm-Message-State: ACgBeo3H7qG65unrYm671GpoURJ8q7MmOpQbifSNvI23BcDZMO7CEXOD
        g4oXbcSra39z4nuj3LhZHsI=
X-Google-Smtp-Source: AA6agR4DwQWYjGhaIOs+PM97rH3f8bIXhmMizRmoUZrcDjAJlvaZcRcD4azIW5gYtuVrK67LueR+Uw==
X-Received: by 2002:a05:6512:31d0:b0:48d:81b:7054 with SMTP id j16-20020a05651231d000b0048d081b7054mr5511875lfe.116.1660543917864;
        Sun, 14 Aug 2022 23:11:57 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:57 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] iio: adc: mcp3911: add support for oversampling ratio
Date:   Mon, 15 Aug 2022 08:16:24 +0200
Message-Id: <20220815061625.35568-9-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chip supports oversampling ratio, so expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b76d825c984d..0151258b456c 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -41,6 +41,7 @@
 #define MCP3911_REG_CONFIG		0x0c
 #define MCP3911_CONFIG_CLKEXT		BIT(1)
 #define MCP3911_CONFIG_VREFEXT		BIT(2)
+#define MCP3911_CONFIG_OSR		GENMASK(13, 11)
 
 #define MCP3911_REG_OFFCAL_CH0		0x0e
 #define MCP3911_REG_GAINCAL_CH0		0x11
@@ -59,6 +60,8 @@
 
 #define MCP3911_NUM_CHANNELS		2
 
+static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -117,6 +120,36 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+}
+
+static int mcp3911_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*vals = mcp3911_osr_table;
+		*length = ARRAY_SIZE(mcp3911_osr_table);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp3911_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -145,6 +178,15 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+		if (ret)
+			goto out;
+
+		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+		*val = 32 << *val;
+		ret = IIO_VAL_INT;
+		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (adc->vref) {
@@ -204,6 +246,17 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+			if (val == mcp3911_osr_table[i]) {
+				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
+				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
+						val, 2);
+				break;
+			}
+		}
+		break;
 	}
 
 out:
@@ -216,9 +269,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.indexed = 1,					\
 		.channel = idx,					\
 		.scan_index = idx,				\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -278,6 +334,8 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
+	.read_avail = mcp3911_read_avail,
+	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
 static int mcp3911_config(struct mcp3911 *adc)
-- 
2.37.1

