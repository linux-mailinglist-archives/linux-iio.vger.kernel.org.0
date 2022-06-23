Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1155841E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jun 2022 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiFWRkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jun 2022 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiFWRiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2022 13:38:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BE517F4;
        Thu, 23 Jun 2022 10:07:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s14so17321366ljs.3;
        Thu, 23 Jun 2022 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Buq93uC223YN7gDu+OZOG27+jvtgYZSgy8F1DGxsPvY=;
        b=h+XVLeEjU4ZDDxHet9bxgDp2Rg3mEyuWA4cLjmZ6bS+2YNZvOrAfSoWnBR3DEtIGdu
         OR7GmIZqqmzhdSXWOHcPOJC6c67LkBLz6qnbOPBxkDHLKc8EUBXhFybAyxYh2ATiq3vL
         /tpBNSUCkZJ9nbM3/MEshdvXhKv//ubkd7GEJbcJon0vyUsdUIRJjJksDYoitqrdLBe3
         OzPPddVOnKwj9QzQhLKmU4v4oujPiS54YhElaGgMmTmTI+Izfe/jYSSvSTAULYWGR9zO
         6FOMOxF+ZCvlTqyBbRc/KKcLbf6cmL6MydSgsK5LedMxYiT8433y+ExZ69PRzB7dFsat
         gz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Buq93uC223YN7gDu+OZOG27+jvtgYZSgy8F1DGxsPvY=;
        b=woa8n6nAvqCQq+obNp+hkVgQXC+vhHVIODOwSiB4Suvj4PFmJA9HwWVzIT9vLnRAO1
         TJZqNbBxw8KKRWehWCanv79PgUSmIxyhA2O5CgfIEfq6WsEunoVfpTWHWTn15RnC2onu
         X7uG/2Qsrs4fGzPiqiIdwkdRj7YHqHiDmPCbPd+fV09SJ2ApSzdMpKfkJpAph9dmmyWW
         ivnXMQLof4HB9i7M+LkVRanEDZS9G2RhllaimOX7nAqgJe8tbZVfsfeMaI6bBKJf2tm9
         O08k+/JNXhrq9nKkHW+kqxgJpQXXwtoAMaY5qz4qVp+xlhpiIrTuj4efx+EaTySVTy+m
         GbRQ==
X-Gm-Message-State: AJIora+NZUt2/jdHlV8vcFkd4cbedrM8wI6uRzOgsARwyc9IuaJl4zX6
        cC4umE3EwZ++LDvzPtZf2++BeE5jEZ+NQA==
X-Google-Smtp-Source: AGRyM1uz4+ft3o2Wx7KjcSnvtK4U/kgA0UmYvAX8dk8vkCbHkmGTkJTjjy9DHcgDlpQQ4Xxx00I39g==
X-Received: by 2002:a2e:a7c7:0:b0:255:8ecd:14b0 with SMTP id x7-20020a2ea7c7000000b002558ecd14b0mr5442305ljp.472.1656004038484;
        Thu, 23 Jun 2022 10:07:18 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:17 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iio: adc: mcp3911: add support to set PGA
Date:   Thu, 23 Jun 2022 19:08:44 +0200
Message-Id: <20220623170844.2189814-10-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
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

Add support for setting the Programmable Gain Amplifiers by adjust the
scale value.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 135 +++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 084f6d1aa6d1..631015ead8e7 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -26,6 +26,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
+#define MCP3911_GAIN_MASK(ch)          (0x7 << 3*ch)
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3*ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
@@ -55,8 +57,10 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
+#define MCP3911_NUM_SCALES		6
 
 static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
+static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
 struct mcp3911 {
 	struct spi_device *spi;
@@ -65,6 +69,7 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
+	u32 gain[MCP3911_NUM_CHANNELS];
 	struct {
 		u32 channels[2];
 		s64 ts __aligned(8);
@@ -113,7 +118,35 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_get_gain(struct mcp3911 *adc, u8 channel, u32 *val)
+{
+	int ret = mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
+
+	if (ret)
+		return ret;
 
+	*val >>= channel * 3;
+	*val &= 0x07;
+	*val = (1 << *val);
+
+	return 0;
+}
+
+static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+}
 static int mcp3911_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
@@ -125,6 +158,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
 		*vals = mcp3911_osr_table;
 		*length = ARRAY_SIZE(mcp3911_osr_table);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (int *)mcp3911_scale_table;
+		*length = ARRAY_SIZE(mcp3911_scale_table) * 2;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -180,29 +218,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_SCALE:
-		if (adc->vref) {
-			ret = regulator_get_voltage(adc->vref);
-			if (ret < 0) {
-				dev_err(indio_dev->dev.parent,
-					"failed to get vref voltage: %d\n",
-				       ret);
-				goto out;
-			}
-
-			*val = ret / 1000;
-		} else {
-			*val = MCP3911_INT_VREF_MV;
-		}
-
-		/*
-		 * For 24bit Conversion
-		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
-		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
-		 */
-
-		/* val2 = (2^23 * 1.5) */
-		*val2 = 12582912;
-		ret = IIO_VAL_FRACTIONAL;
+		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
+		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
+		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
 	}
 
@@ -220,6 +238,19 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&adc->lock);
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+			if (val == mcp3911_scale_table[i][0] &&
+				val2 == mcp3911_scale_table[i][1]) {
+
+				adc->gain[channel->channel] = BIT(i);
+				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
+						MCP3911_GAIN_MASK(channel->channel),
+						MCP3911_GAIN_VAL(channel->channel,
+							i), 1);
+			}
+		}
+		break;
 	case IIO_CHAN_INFO_OFFSET:
 		if (val2 != 0) {
 			ret = -EINVAL;
@@ -290,6 +321,49 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int mcp3911_calc_scale_table(struct mcp3911 *adc)
+{
+	u32 ref = MCP3911_INT_VREF_MV;
+	u32 div;
+	int ret = 0;
+	int tmp0, tmp1;
+	s64 tmp2;
+
+	if (adc->vref) {
+		ret = regulator_get_voltage(adc->vref);
+		if (ret < 0) {
+			dev_err(&adc->spi->dev,
+				"failed to get vref voltage: %d\n",
+			       ret);
+			goto out;
+		}
+
+		ref = ret / 1000;
+	}
+
+	/*
+	 * For 24bit Conversion
+	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
+	 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
+	 */
+
+	/* ref = Reference voltage
+	 * div = (2^23 * 1.5 * gain) = 12582912 * gain
+	 */
+	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+		div = 12582912 * BIT(i);
+		tmp2 = div_s64((s64)ref * 1000000000LL, div);
+		tmp1 = div;
+		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
+
+		mcp3911_scale_table[i][0] = 0;
+		mcp3911_scale_table[i][1] = tmp1;
+	}
+
+out:
+	return ret;
+}
+
 #define MCP3911_CHAN(idx) {					\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -302,8 +376,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_type_available =		\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_type_available =           \
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)	\
+		.info_mask_separate_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),		\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -356,6 +432,7 @@ static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
 	.read_avail = mcp3911_read_avail,
+	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
 static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
@@ -482,6 +559,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		goto clk_disable;
 
+	ret = mcp3911_calc_scale_table(adc);
+	if (ret)
+		goto clk_disable;
+
+       /* Store gain values to better calculate scale values */
+	mcp3911_get_gain(adc, 0, &adc->gain[0]);
+	mcp3911_get_gain(adc, 1, &adc->gain[1]);
+
 	dr_hiz = device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz");
 	if (dr_hiz)
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-- 
2.36.1

