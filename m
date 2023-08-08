Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A4773E23
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjHHQ0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjHHQY4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:24:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125CA24A;
        Tue,  8 Aug 2023 08:50:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso9697855e87.0;
        Tue, 08 Aug 2023 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509810; x=1692114610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XzHVfLhym0LuqU00BeE231PkgNHJaWfk33DM2IsORI=;
        b=enf3BrMMmAGArbTlryg9Vvltd9hvwZJlzyL4e83xsmj/oGQUB0m8oTyEaSTnwcrIlT
         ebOJv3KhV1gKKLN/RnUA0FdksW3VZS72JrhdXCeODY9PrTnLX0ObgP4aAxNQ+0RqHFgv
         tFx5j7+Lx1Wmjf0pUtoQ6472H+gqJKsW9prjzDJb8lnqRtj7GCUG0RTcaf5A5eL9W2up
         cjTm4cjLSMIxEHod0wHilmKeaIaQmX7m3vW6ACp31KsnbJFmlxh/YHZnPYGaCPJAmFHI
         I+LsFiS7zrhN/Lp7KaDzjmEq3pnlNGPfTNy/l5JK9flKRk5Gpg1x2a67ZxMlNsh3f9L+
         9+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509810; x=1692114610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XzHVfLhym0LuqU00BeE231PkgNHJaWfk33DM2IsORI=;
        b=XS6dpjrMSb0CXpnjdBA4UGjqAOGDeq/bGAqFO4ep6C2E71UiH0rVPcnCRfOaNnV+B6
         pSouuMhkkOWsQ08+rdHQmm/TpWod0xig2PITwkdlGasmPslKH9qRnHP4OLwRz9wmbivL
         gCIfhgQx5jN5odOXIZi1tnewJ+s3SF8R2NEJte74pj1zjaa5zLBfdyEKAww8VlCZ7u9M
         osdtkqC3qs9TloaYzoYij88Je1YaEA84z8YzRyERnpoVV0bs4smFMqeQ2tEkEhIgFQXP
         8/JNQRzg0FGF5L/I1QgKPHUOMM66j5t8wDQdl/VR92OAh03pp73i4lhCG9769FweC+wa
         8wdw==
X-Gm-Message-State: AOJu0Yz1TsxMf1eWHa/PYq1QY0Eg4C6A777Jk+idPA2YlJsroMIc1fRY
        rU0+Cy+v5uNwuG6HV+ZJQ4MuJ0n7BzaHdiGq
X-Google-Smtp-Source: AGHT+IFSejz3iUiqIwwDVdsdq7jEaC+Ix01/ibrlx2hqS7ezVY0NY49KumPk16q7t8tfKS4KeuGYNg==
X-Received: by 2002:a05:6512:34d2:b0:4f8:7513:8cac with SMTP id w18-20020a05651234d200b004f875138cacmr6669366lfr.48.1691492574218;
        Tue, 08 Aug 2023 04:02:54 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b004fbad682ffesm1826587lfo.88.2023.08.08.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:02:53 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Tue,  8 Aug 2023 13:04:32 +0200
Message-Id: <20230808110432.240773-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808110432.240773-1-marcus.folkesson@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Microchip does have many similar chips, add support for those.

The new supported chips are:
  - microchip,mcp3910
  - microchip,mcp3912
  - microchip,mcp3913
  - microchip,mcp3914
  - microchip,mcp3918
  - microchip,mcp3919

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - Use callbacks rather than matching against enum for determine chip variants
    v3:
        - Fix cosmetics
    v4:
        - Do not pollute output variable upon error in *_get_osr() functions.
        - Fix cosmetics

 drivers/iio/adc/Kconfig   |   5 +-
 drivers/iio/adc/mcp3911.c | 459 +++++++++++++++++++++++++++++++++-----
 2 files changed, 405 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index eb2b09ef5d5b..9a9838430530 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -774,8 +774,9 @@ config MCP3911
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for Microchip Technology's MCP3911
-	  analog to digital converter.
+	  Say yes here to build support for Microchip Technology's MCP3910,
+	  MCP3911, MCP3912, MCP3913, MCP3914, MCP3918 and MCP3919
+	  analog to digital converters.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3911.
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 8b465d2aad1a..c033e6d29650 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -61,12 +61,55 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
 #define MCP3911_REG_MASK		GENMASK(4, 1)
 
-#define MCP3911_NUM_CHANNELS		2
 #define MCP3911_NUM_SCALES		6
 
+/* Registers compatible with MCP3910 */
+#define MCP3910_REG_STATUSCOM		0x0c
+#define MCP3910_STATUSCOM_READ		GENMASK(23, 22)
+#define MCP3910_STATUSCOM_DRHIZ		BIT(20)
+
+#define MCP3910_REG_GAIN		0x0b
+
+#define MCP3910_REG_CONFIG0		0x0d
+#define MCP3910_CONFIG0_EN_OFFCAL	BIT(23)
+#define MCP3910_CONFIG0_OSR		GENMASK(15, 13)
+
+#define MCP3910_REG_CONFIG1		0x0e
+#define MCP3910_CONFIG1_CLKEXT		BIT(6)
+#define MCP3910_CONFIG1_VREFEXT		BIT(7)
+
+#define MCP3910_REG_OFFCAL_CH0		0x0f
+#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)
+
+/* Maximal number of channels used by the MCP39XX family */
+#define MCP39XX_MAX_NUM_CHANNELS	8
+
 static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
 static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
+enum mcp3911_id {
+	MCP3910,
+	MCP3911,
+	MCP3912,
+	MCP3913,
+	MCP3914,
+	MCP3918,
+	MCP3919,
+};
+
+struct mcp3911;
+struct mcp3911_chip_info {
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+
+	int (*config)(struct mcp3911 *adc);
+	int (*get_osr)(struct mcp3911 *adc, int *val);
+	int (*set_osr)(struct mcp3911 *adc, int val);
+	int (*get_offset)(struct mcp3911 *adc, int channel, int *val);
+	int (*set_offset)(struct mcp3911 *adc, int channel, int val);
+	int (*set_scale)(struct mcp3911 *adc, int channel, int val);
+};
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -74,14 +117,15 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
-	u32 gain[MCP3911_NUM_CHANNELS];
+	u32 gain[MCP39XX_MAX_NUM_CHANNELS];
+	const struct mcp3911_chip_info *chip;
 	struct {
-		u32 channels[MCP3911_NUM_CHANNELS];
+		u32 channels[MCP39XX_MAX_NUM_CHANNELS];
 		s64 ts __aligned(8);
 	} scan;
 
 	u8 tx_buf __aligned(IIO_DMA_MINALIGN);
-	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
+	u8 rx_buf[MCP39XX_MAX_NUM_CHANNELS * 3];
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -126,6 +170,104 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3910_get_offset(struct mcp3911 *adc, int channel, int *val)
+{
+	return mcp3911_read(adc, MCP3910_OFFCAL(channel), val, 3);
+}
+
+static int mcp3910_set_offset(struct mcp3911 *adc, int channel, int val)
+{
+	int ret;
+
+	/* Write offset */
+	ret = mcp3911_write(adc, MCP3910_OFFCAL(channel), val, 3);
+	if (ret)
+		return ret;
+
+	/* Enable offset*/
+	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
+			      MCP3910_CONFIG0_EN_OFFCAL,
+			      MCP3910_CONFIG0_EN_OFFCAL, 3);
+}
+
+static int mcp3911_get_offset(struct mcp3911 *adc, int channel, int *val)
+{
+	return mcp3911_read(adc, MCP3911_OFFCAL(channel), val, 3);
+}
+
+static int mcp3911_set_offset(struct mcp3911 *adc, int channel, int val)
+{
+	int ret;
+
+	/* Write offset */
+	ret = mcp3911_write(adc, MCP3911_OFFCAL(channel), val, 3);
+	if (ret)
+		return ret;
+
+	/* Enable offset */
+	return mcp3911_update(adc, MCP3911_REG_STATUSCOM,
+			      MCP3911_STATUSCOM_EN_OFFCAL,
+			      MCP3911_STATUSCOM_EN_OFFCAL, 2);
+}
+
+static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
+{
+	int ret, osr;
+
+	ret = mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);
+	if (ret)
+		return ret;
+
+	osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
+	*val = 32 << osr;
+	return ret;
+}
+
+static int mcp3910_set_osr(struct mcp3911 *adc, int val)
+{
+	int osr;
+
+	osr = FIELD_PREP(MCP3910_CONFIG0_OSR, val);
+	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
+			      MCP3910_CONFIG0_OSR, osr, 3);
+}
+
+static int mcp3911_set_osr(struct mcp3911 *adc, int val)
+{
+	int osr;
+
+	osr = FIELD_PREP(MCP3911_CONFIG_OSR, val);
+	return mcp3911_update(adc, MCP3911_REG_CONFIG,
+			      MCP3911_CONFIG_OSR, osr, 2);
+}
+
+static int mcp3911_get_osr(struct mcp3911 *adc, int *val)
+{
+	int ret, osr;
+
+	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+	if (ret)
+		return ret;
+
+	osr = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+	*val = 32 << osr;
+	return ret;
+}
+
+static int mcp3910_set_scale(struct mcp3911 *adc, int channel, int val)
+{
+	return mcp3911_update(adc, MCP3910_REG_GAIN,
+			      MCP3911_GAIN_MASK(channel),
+			      MCP3911_GAIN_VAL(channel, val), 3);
+}
+
+static int mcp3911_set_scale(struct mcp3911 *adc, int channel, int val)
+{
+	return mcp3911_update(adc, MCP3911_REG_GAIN,
+			      MCP3911_GAIN_MASK(channel),
+			      MCP3911_GAIN_VAL(channel, val), 1);
+}
+
 static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     long mask)
@@ -182,20 +324,18 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OFFSET:
-		ret = mcp3911_read(adc,
-				   MCP3911_OFFCAL(channel->channel), val, 3);
+
+		ret = adc->chip->get_offset(adc, channel->channel, val);
 		if (ret)
 			goto out;
 
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+		ret = adc->chip->get_osr(adc, val);
 		if (ret)
 			goto out;
 
-		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
-		*val = 32 << *val;
 		ret = IIO_VAL_INT;
 		break;
 
@@ -226,9 +366,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			    val2 == mcp3911_scale_table[i][1]) {
 
 				adc->gain[channel->channel] = BIT(i);
-				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-						     MCP3911_GAIN_MASK(channel->channel),
-						     MCP3911_GAIN_VAL(channel->channel, i), 1);
+				ret = adc->chip->set_scale(adc, channel->channel, i);
 			}
 		}
 		break;
@@ -238,24 +376,13 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		/* Write offset */
-		ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
-				    3);
-		if (ret)
-			goto out;
-
-		/* Enable offset*/
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
-				     MCP3911_STATUSCOM_EN_OFFCAL,
-				     MCP3911_STATUSCOM_EN_OFFCAL, 2);
+		ret = adc->chip->set_offset(adc, channel->channel, val);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
-				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
-				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-						     val, 2);
+				ret = adc->chip->set_osr(adc, i);
 				break;
 			}
 		}
@@ -326,12 +453,60 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	},						\
 }
 
+static const struct iio_chan_spec mcp3910_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
 static const struct iio_chan_spec mcp3911_channels[] = {
 	MCP3911_CHAN(0),
 	MCP3911_CHAN(1),
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct iio_chan_spec mcp3912_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct iio_chan_spec mcp3913_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	MCP3911_CHAN(4),
+	MCP3911_CHAN(5),
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static const struct iio_chan_spec mcp3914_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	MCP3911_CHAN(4),
+	MCP3911_CHAN(5),
+	MCP3911_CHAN(6),
+	MCP3911_CHAN(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const struct iio_chan_spec mcp3918_channels[] = {
+	MCP3911_CHAN(0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_chan_spec mcp3919_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -343,7 +518,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 			.len = 1,
 		}, {
 			.rx_buf = adc->rx_buf,
-			.len = sizeof(adc->rx_buf),
+			.len = (adc->chip->num_channels - 1) * 3,
 		},
 	};
 	int scan_index;
@@ -383,26 +558,9 @@ static const struct iio_info mcp3911_info = {
 
 static int mcp3911_config(struct mcp3911 *adc)
 {
-	struct device *dev = &adc->spi->dev;
 	u32 regval;
 	int ret;
 
-	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
-
-	/*
-	 * Fallback to "device-addr" due to historical mismatch between
-	 * dt-bindings and implementation
-	 */
-	if (ret)
-		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
-	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
-		return -EINVAL;
-	}
-	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
-
 	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
 		return ret;
@@ -439,7 +597,101 @@ static int mcp3911_config(struct mcp3911 *adc)
 	regval &= ~MCP3911_STATUSCOM_READ;
 	regval |= FIELD_PREP(MCP3911_STATUSCOM_READ, 0x02);
 
-	return  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
+	regval &= ~MCP3911_STATUSCOM_DRHIZ;
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		regval |= FIELD_PREP(MCP3911_STATUSCOM_DRHIZ, 0);
+	else
+		regval |= FIELD_PREP(MCP3911_STATUSCOM_DRHIZ, 1);
+
+	/* Disable offset to ignore any old values in offset register*/
+	regval &= ~MCP3911_STATUSCOM_EN_OFFCAL;
+
+	ret =  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
+	if (ret)
+		return ret;
+
+	/* Set gain to 1 for all channels */
+	ret = mcp3911_read(adc, MCP3911_REG_GAIN, &regval, 1);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < adc->chip->num_channels - 1; i++) {
+		adc->gain[i] = 1;
+		regval &= ~MCP3911_GAIN_MASK(i);
+	}
+
+	return mcp3911_write(adc, MCP3911_REG_GAIN, regval, 1);
+}
+
+static int mcp3910_config(struct mcp3911 *adc)
+{
+	u32 regval;
+	int ret;
+
+	ret = mcp3911_read(adc, MCP3910_REG_CONFIG1, &regval, 3);
+	if (ret)
+		return ret;
+
+	regval &= ~MCP3910_CONFIG1_VREFEXT;
+	if (adc->vref) {
+		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
+		regval |= FIELD_PREP(MCP3910_CONFIG1_VREFEXT, 1);
+	} else {
+		dev_dbg(&adc->spi->dev,
+			"use internal voltage reference (1.2V)\n");
+		regval |= FIELD_PREP(MCP3910_CONFIG1_VREFEXT, 0);
+	}
+
+	regval &= ~MCP3910_CONFIG1_CLKEXT;
+	if (adc->clki) {
+		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
+		regval |= FIELD_PREP(MCP3910_CONFIG1_CLKEXT, 1);
+	} else {
+		dev_dbg(&adc->spi->dev,
+			"use crystal oscillator as clocksource\n");
+		regval |= FIELD_PREP(MCP3910_CONFIG1_CLKEXT, 0);
+	}
+
+	ret = mcp3911_write(adc, MCP3910_REG_CONFIG1, regval, 3);
+	if (ret)
+		return ret;
+
+	ret = mcp3911_read(adc, MCP3910_REG_STATUSCOM, &regval, 3);
+	if (ret)
+		return ret;
+
+	/* Address counter incremented, cycle through register types */
+	regval &= ~MCP3910_STATUSCOM_READ;
+	regval |= FIELD_PREP(MCP3910_STATUSCOM_READ, 0x02);
+
+
+	regval &= ~MCP3910_STATUSCOM_DRHIZ;
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		regval |= FIELD_PREP(MCP3910_STATUSCOM_DRHIZ, 0);
+	else
+		regval |= FIELD_PREP(MCP3910_STATUSCOM_DRHIZ, 1);
+
+	ret = mcp3911_write(adc, MCP3910_REG_STATUSCOM, regval, 3);
+	if (ret)
+		return ret;
+
+	/* Set gain to 1 for all channels */
+	ret = mcp3911_read(adc, MCP3910_REG_GAIN, &regval, 3);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < adc->chip->num_channels - 1; i++) {
+		adc->gain[i] = 1;
+		regval &= ~MCP3911_GAIN_MASK(i);
+	}
+	ret = mcp3911_write(adc, MCP3910_REG_GAIN, regval, 3);
+	if (ret)
+		return ret;
+
+	/* Disable offset to ignore any old values in offset register */
+	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
+			      MCP3910_CONFIG0_EN_OFFCAL,
+			      MCP3910_CONFIG0_EN_OFFCAL, 3);
 }
 
 static void mcp3911_cleanup_regulator(void *vref)
@@ -476,6 +728,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
+	adc->chip = spi_get_device_match_data(spi);
 
 	adc->vref = devm_regulator_get_optional(&spi->dev, "vref");
 	if (IS_ERR(adc->vref)) {
@@ -511,16 +764,24 @@ static int mcp3911_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = mcp3911_config(adc);
+	ret = device_property_read_u32(&spi->dev, "microchip,device-addr", &adc->dev_addr);
+
+	/*
+	 * Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation.
+	 */
 	if (ret)
-		return ret;
+		device_property_read_u32(&spi->dev, "device-addr", &adc->dev_addr);
+	if (adc->dev_addr > 3) {
+		dev_err(&spi->dev,
+			"invalid device address (%i). Must be in range 0-3.\n",
+			adc->dev_addr);
+		return -EINVAL;
+	}
+	dev_dbg(&spi->dev, "use device address %i\n", adc->dev_addr);
 
-	if (device_property_read_bool(&spi->dev, "microchip,data-ready-hiz"))
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				     0, 2);
-	else
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				     MCP3911_STATUSCOM_DRHIZ, 2);
+
+	ret = adc->chip->config(adc);
 	if (ret)
 		return ret;
 
@@ -529,7 +790,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		return ret;
 
 	/* Set gain to 1 for all channels */
-	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
+	for (int i = 0; i < adc->chip->num_channels - 1; i++) {
 		adc->gain[i] = 1;
 		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
 				     MCP3911_GAIN_MASK(i),
@@ -543,8 +804,8 @@ static int mcp3911_probe(struct spi_device *spi)
 	indio_dev->info = &mcp3911_info;
 	spi_set_drvdata(spi, indio_dev);
 
-	indio_dev->channels = mcp3911_channels;
-	indio_dev->num_channels = ARRAY_SIZE(mcp3911_channels);
+	indio_dev->channels = adc->chip->channels;
+	indio_dev->num_channels = adc->chip->num_channels;
 
 	mutex_init(&adc->lock);
 
@@ -583,14 +844,98 @@ static int mcp3911_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct mcp3911_chip_info mcp3911_chip_info[] = {
+	[MCP3910] = {
+		.channels = mcp3910_channels,
+		.num_channels = ARRAY_SIZE(mcp3910_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+	[MCP3911] = {
+		.channels = mcp3911_channels,
+		.num_channels = ARRAY_SIZE(mcp3911_channels),
+		.config = mcp3911_config,
+		.get_osr = mcp3911_get_osr,
+		.set_osr = mcp3911_set_osr,
+		.get_offset = mcp3911_get_offset,
+		.set_offset = mcp3911_set_offset,
+		.set_scale = mcp3911_set_scale,
+	},
+	[MCP3912] = {
+		.channels = mcp3912_channels,
+		.num_channels = ARRAY_SIZE(mcp3912_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+	[MCP3913] = {
+		.channels = mcp3913_channels,
+		.num_channels = ARRAY_SIZE(mcp3913_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+	[MCP3914] = {
+		.channels = mcp3914_channels,
+		.num_channels = ARRAY_SIZE(mcp3914_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+	[MCP3918] = {
+		.channels = mcp3918_channels,
+		.num_channels = ARRAY_SIZE(mcp3918_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+	[MCP3919] = {
+		.channels = mcp3919_channels,
+		.num_channels = ARRAY_SIZE(mcp3919_channels),
+		.config = mcp3910_config,
+		.get_osr = mcp3910_get_osr,
+		.set_osr = mcp3910_set_osr,
+		.get_offset = mcp3910_get_offset,
+		.set_offset = mcp3910_set_offset,
+		.set_scale = mcp3910_set_scale,
+	},
+};
 static const struct of_device_id mcp3911_dt_ids[] = {
-	{ .compatible = "microchip,mcp3911" },
+	{ .compatible = "microchip,mcp3910", .data = &mcp3911_chip_info[MCP3910] },
+	{ .compatible = "microchip,mcp3911", .data = &mcp3911_chip_info[MCP3911] },
+	{ .compatible = "microchip,mcp3912", .data = &mcp3911_chip_info[MCP3912] },
+	{ .compatible = "microchip,mcp3913", .data = &mcp3911_chip_info[MCP3913] },
+	{ .compatible = "microchip,mcp3914", .data = &mcp3911_chip_info[MCP3914] },
+	{ .compatible = "microchip,mcp3918", .data = &mcp3911_chip_info[MCP3918] },
+	{ .compatible = "microchip,mcp3919", .data = &mcp3911_chip_info[MCP3919] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
 
 static const struct spi_device_id mcp3911_id[] = {
-	{ "mcp3911", 0 },
+	{ "mcp3910", (kernel_ulong_t)&mcp3911_chip_info[MCP3910] },
+	{ "mcp3911", (kernel_ulong_t)&mcp3911_chip_info[MCP3911] },
+	{ "mcp3912", (kernel_ulong_t)&mcp3911_chip_info[MCP3912] },
+	{ "mcp3913", (kernel_ulong_t)&mcp3911_chip_info[MCP3913] },
+	{ "mcp3914", (kernel_ulong_t)&mcp3911_chip_info[MCP3914] },
+	{ "mcp3918", (kernel_ulong_t)&mcp3911_chip_info[MCP3918] },
+	{ "mcp3919", (kernel_ulong_t)&mcp3911_chip_info[MCP3919] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp3911_id);
-- 
2.40.1

