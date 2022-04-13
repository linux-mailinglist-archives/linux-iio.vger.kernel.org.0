Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF374FF3C6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiDMJm4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiDMJmv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 05:42:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BFF35858;
        Wed, 13 Apr 2022 02:40:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s25so1185285edi.13;
        Wed, 13 Apr 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8m9HcSVZHlTdauw4/iQ9uzuItdKxecxfbMhI1h5XXxA=;
        b=fjtQdricTqjG6yYS9k4gW5ihfFmiPz0peQgVzkNgA5yjOQPmuBjbw9V0+zG1Kz0oq2
         dvfHYMfHlWZnjzMvdmyh3ywStk/ff83/9Gt1eLzb2/MdzAmj8Kk77RcwlVIvBp2Ga6zt
         s17Ji5k/yWCVXlEV6y2iAv3ByWBGOdamj+4yI+Klpqad4mTO2k8VmUT+gI9PKrp9oXGr
         BArz31rATWBSMUZ/rc7yDLaZzvU+3h6yWjwTikc3mXZgPBA7UQ6tsLGnQN1QKclunLaC
         +9NJqX2lJ7CuX8kotuOgdWNzeW/W/DznzkG3wniQ0iKwATFtY0G0QyaWWIhPQINOHTZM
         7Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8m9HcSVZHlTdauw4/iQ9uzuItdKxecxfbMhI1h5XXxA=;
        b=bsb6DQnFYCQGFj74vqnwx/v1LDBW/gz13Ydf1+RLVP60ZfOl2a7CfkVMMN5O8Vz1Ed
         OWrML0qM1csqCewKutNt4ztOhdCm2Cdk1H68GWrXgtkeRig/Cdm8/1Kv+CRboCB8bp4U
         rhdmdIzeWKPZ+XmP5B6Zg/yzF3Xi5Dr6R08fCWvlcvGEE+O771xl5PBiMpHmXQ49Bqzg
         jF21DlZtqjhZcDNaK/CQY83riIu3nQs/W6rDvrHSWEwHH5G+Sra6bPm+xMOkAvf+zeY5
         iqIV4XTiMLhZ3E3ujYIQn2mnKkC0hPdv3IOcg79O28QKdzqQi6Ln6uFcJWmTy5nUoVBE
         J4kw==
X-Gm-Message-State: AOAM532U1ZlfdVe/DuuAkhx4SX2/YpR28uneMbg2PMv2dluxrNUCfZz8
        wkgAic+wR/w17NdFU3Eg2TE=
X-Google-Smtp-Source: ABdhPJyIQKPM5NU4xRdbiDZyEFoJAE8q9HcoP6UHdM//TMFaomeuLZsp3M2RH2rkIHlr44lfi88tqw==
X-Received: by 2002:aa7:df15:0:b0:41d:675f:ea9a with SMTP id c21-20020aa7df15000000b0041d675fea9amr22981774edy.148.1649842825557;
        Wed, 13 Apr 2022 02:40:25 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm11403265eje.15.2022.04.13.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:40:25 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Date:   Wed, 13 Apr 2022 12:40:11 +0300
Message-Id: <20220413094011.185269-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413094011.185269-1-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AD4130-8 is an ultra-low power, high precision,
measurement solution for low bandwidth battery
operated applications.

The fully integrated AFE (Analog Front-End)
includes a multiplexer for up to 16 single-ended
or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip
reference and oscillator, selectable filter
options, smart sequencer, sensor biasing and
excitation options, diagnostics, and a FIFO
buffer.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 MAINTAINERS              |    8 +
 drivers/iio/adc/Kconfig  |   13 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4130.c | 2072 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 2094 insertions(+)
 create mode 100644 drivers/iio/adc/ad4130.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a1dfb3fab5f8..8719a246b55d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1054,6 +1054,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
 
+ANALOG DEVICES INC AD4130 DRIVER
+M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+F:	drivers/iio/adc/ad4130.c
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 71ab0a06aa82..2dac0f029c41 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,19 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD4130
+	tristate "Analog Device AD4130 ADC Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4130-8 SPI analog
+	  to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4130.
+
 config AD7091R5
 	tristate "Analog Devices AD7091R5 ADC Driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f6d457..c3aa7e4eca2f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
 obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7192) += ad7192.o
diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
new file mode 100644
index 000000000000..89fb9b413ff0
--- /dev/null
+++ b/drivers/iio/adc/ad4130.c
@@ -0,0 +1,2072 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD4130 SPI ADC driver
+ *
+ * Copyright 2022 Analog Devices Inc.
+ */
+#include <asm/div64.h>
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define AD4130_8_NAME			"ad4130-8"
+
+#define AD4130_COMMS_READ_MASK		BIT(6)
+
+#define AD4130_REG_STATUS		0x00
+#define AD4130_STATUS_POR_FLAG_MASK	BIT(4)
+
+#define AD4130_REG_ADC_CONTROL		0x01
+#define AD4130_BIPOLAR_MASK		BIT(14)
+#define AD4130_INT_REF_VAL_MASK		BIT(13)
+#define AD4130_INT_REF_2_5V		2500000
+#define AD4130_INT_REF_1_25V		1250000
+#define AD4130_CSB_EN_MASK		BIT(9)
+#define AD4130_INT_REF_EN_MASK		BIT(8)
+#define AD4130_MODE_MASK		GENMASK(5, 2)
+#define AD4130_MCLK_SEL_MASK		GENMASK(1, 0)
+
+#define AD4130_REG_DATA			0x02
+
+#define AD4130_REG_IO_CONTROL		0x03
+#define AD4130_INT_PIN_SEL_MASK		GENMASK(9, 8)
+#define AD4130_GPIO_DATA_MASK		GENMASK(7, 4)
+#define AD4130_GPIO_CTRL_MASK		GENMASK(3, 0)
+
+#define AD4130_REG_VBIAS		0x04
+
+#define AD4130_REG_ID			0x05
+
+#define AD4130_REG_ERROR		0x06
+
+#define AD4130_REG_ERROR_EN		0x07
+
+#define AD4130_REG_CHANNEL_X(x)		(0x09 + (x))
+#define AD4130_CHANNEL_EN_MASK		BIT(23)
+#define AD4130_SETUP_MASK		GENMASK(22, 20)
+#define AD4130_AINP_MASK		GENMASK(17, 13)
+#define AD4130_AINM_MASK		GENMASK(12, 8)
+#define AD4130_IOUT1_MASK		GENMASK(7, 4)
+#define AD4130_IOUT2_MASK		GENMASK(3, 0)
+
+#define AD4130_REG_CONFIG_X(x)		(0x19 + (x))
+#define AD4130_IOUT1_VAL_MASK		GENMASK(15, 13)
+#define AD4130_IOUT2_VAL_MASK		GENMASK(12, 10)
+#define AD4130_BURNOUT_MASK		GENMASK(9, 8)
+#define AD4130_REF_BUFP_MASK		BIT(7)
+#define AD4130_REF_BUFM_MASK		BIT(6)
+#define AD4130_REF_SEL_MASK		GENMASK(5, 4)
+#define AD4130_PGA_MASK			GENMASK(3, 1)
+#define AD4130_PGA_NUM			8
+
+#define AD4130_REG_FILTER_X(x)		(0x21 + (x))
+#define AD4130_FILTER_MODE_MASK		GENMASK(15, 12)
+#define AD4130_FILTER_SELECT_MASK	GENMASK(10, 0)
+#define AD4130_FS_MIN			1
+#define AD4130_MAX_ODR			2400
+
+#define AD4130_REG_FIFO_CONTROL		0x3a
+#define AD4130_ADD_FIFO_HEADER_MASK	BIT(18)
+#define AD4130_FIFO_MODE_MASK		GENMASK(17, 16)
+#define AD4130_WATERMARK_INT_EN_MASK	BIT(9)
+#define AD4130_WATERMARK_MASK		GENMASK(7, 0)
+#define AD4130_WATERMARK_256		0
+
+#define AD4130_REG_FIFO_STATUS		0x3b
+
+#define AD4130_REG_FIFO_DATA		0x3d
+#define AD4130_FIFO_SIZE		256
+#define AD4130_FIFO_MAX_SAMPLE_SIZE	3
+
+#define AD4130_MAX_GPIOS		4
+#define AD4130_MAX_SETUPS		8
+#define AD4130_MAX_CHANNELS		16
+#define AD4130_MAX_ANALOG_PINS		16
+#define AD4130_MAX_DIFF_INPUTS		30
+
+#define AD4130_AIN2_P1			0x2
+
+#define AD4130_MCLK_FREQ_76_8KHZ	76800
+#define AD4130_MCLK_FREQ_153_6KHZ	153600
+
+#define AD4130_RESET_CLK_COUNT		64
+#define AD4130_RESET_BUF_SIZE		(AD4130_RESET_CLK_COUNT / 8)
+
+#define AD4130_SOFT_RESET_SLEEP		(160 * 1000000 / AD4130_MCLK_FREQ_76_8KHZ)
+
+#define AD4130_INVALID_SLOT		-1
+
+#define AD4130_FREQ_FACTOR		1000000000ull
+#define AD4130_DB3_FACTOR		1000
+
+static const unsigned int ad4130_reg_size[] = {
+	[AD4130_REG_STATUS] = 1,
+	[AD4130_REG_ADC_CONTROL] = 2,
+	[AD4130_REG_IO_CONTROL] = 2,
+	[AD4130_REG_VBIAS] = 2,
+	[AD4130_REG_ID] = 1,
+	[AD4130_REG_ERROR] = 2,
+	[AD4130_REG_ERROR_EN] = 2,
+	[AD4130_REG_CHANNEL_X(0) ...
+	 AD4130_REG_CHANNEL_X(AD4130_MAX_CHANNELS)] = 3,
+	[AD4130_REG_CONFIG_X(0) ...
+	 AD4130_REG_CONFIG_X(AD4130_MAX_SETUPS)] = 2,
+	[AD4130_REG_FILTER_X(0) ...
+	 AD4130_REG_FILTER_X(AD4130_MAX_SETUPS)] = 3,
+	[AD4130_REG_FIFO_CONTROL] = 3,
+	[AD4130_REG_FIFO_STATUS] = 1,
+};
+
+enum ad4130_id {
+	ID_AD4130_8_24_WLCSP,
+	ID_AD4130_8_24_LFCSP,
+	ID_AD4130_8_16_WLCSP,
+	ID_AD4130_8_16_LFCSP,
+};
+
+enum ad4130_int_ref_val {
+	AD4130_INT_REF_VAL_2_5V,
+	AD4130_INT_REF_VAL_1_25V,
+};
+
+enum ad4130_mclk_sel {
+	AD4130_MCLK_76_8KHZ,
+	AD4130_MCLK_76_8KHZ_OUT,
+	AD4130_MCLK_76_8KHZ_EXT,
+	AD4130_MCLK_153_6KHZ_EXT,
+	AD4130_MCLK_SEL_MAX,
+};
+
+enum ad4130_int_pin_sel {
+	AD4130_INT_PIN_DOUT_OR_INT,
+	AD4130_INT_PIN_CLK,
+	AD4130_INT_PIN_P1,
+	AD4130_INT_PIN_DOUT,
+};
+
+enum ad4130_iout {
+	AD4130_IOUT_OFF,
+	AD4130_IOUT_10000NA,
+	AD4130_IOUT_20000NA,
+	AD4130_IOUT_50000NA,
+	AD4130_IOUT_100000NA,
+	AD4130_IOUT_150000NA,
+	AD4130_IOUT_200000NA,
+	AD4130_IOUT_100NA,
+	AD4130_IOUT_MAX,
+};
+
+enum ad4130_burnout {
+	AD4130_BURNOUT_OFF,
+	AD4130_BURNOUT_500NA,
+	AD4130_BURNOUT_2000NA,
+	AD4130_BURNOUT_4000NA,
+	AD4130_BURNOUT_MAX,
+};
+
+enum ad4130_ref_sel {
+	AD4130_REF_REFIN1,
+	AD4130_REF_REFIN2,
+	AD4130_REF_REFOUT_AVSS,
+	AD4130_REF_AVDD_AVSS,
+	AD4130_REF_SEL_MAX,
+};
+
+enum ad4130_fifo_mode {
+	AD4130_FIFO_MODE_DISABLED = 0b00,
+	AD4130_FIFO_MODE_WATERMARK = 0b01,
+};
+
+enum ad4130_mode {
+	AD4130_MODE_CONTINUOUS = 0b0000,
+	AD4130_MODE_IDLE = 0b0100,
+};
+
+enum ad4130_filter_mode {
+	AD4130_FILTER_SINC4,
+	AD4130_FILTER_SINC4_SINC1,
+	AD4130_FILTER_SINC3,
+	AD4130_FILTER_SINC3_REJ60,
+	AD4130_FILTER_SINC3_SINC1,
+	AD4130_FILTER_SINC3_PF1,
+	AD4130_FILTER_SINC3_PF2,
+	AD4130_FILTER_SINC3_PF3,
+	AD4130_FILTER_SINC3_PF4,
+	AD4130_FILTER_MAX,
+};
+
+enum ad4130_pin_function {
+	AD4130_PIN_FN_NONE,
+	AD4130_PIN_FN_SPECIAL = 1 << 0,
+	AD4130_PIN_FN_DIFF = 1 << 1,
+	AD4130_PIN_FN_EXCITATION = 1 << 2,
+	AD4130_PIN_FN_VBIAS = 1 << 3,
+};
+
+struct ad4130_chip_info {
+	const char	*name;
+	u8		resolution;
+	bool		has_int_pin;
+};
+
+struct ad4130_setup_info {
+	unsigned int			iout0_val;
+	unsigned int			iout1_val;
+	unsigned int			burnout;
+	unsigned int			pga;
+	unsigned int			fs;
+	bool				ref_bufp;
+	bool				ref_bufm;
+	u32				ref_sel;
+	enum ad4130_filter_mode		filter_mode;
+	unsigned int			enabled_channels;
+	unsigned int			channels;
+};
+
+#define AD4130_SETUP_SIZE		offsetof(struct ad4130_setup_info, \
+						 enabled_channels)
+
+struct ad4130_chan_info {
+	u32				iout0;
+	u32				iout1;
+	bool				enabled;
+	struct ad4130_setup_info	setup;
+	int				slot;
+	bool				initialized;
+};
+
+struct ad4130_filter_config {
+	enum ad4130_filter_mode		filter_mode;
+	unsigned int			odr_div;
+	unsigned int			fs_max;
+	unsigned int			db3_div;
+	enum iio_available_type		samp_freq_avail_type;
+	int				samp_freq_avail_len;
+	int				samp_freq_avail[3][2];
+	enum iio_available_type		db3_freq_avail_type;
+	int				db3_freq_avail_len;
+	int				db3_freq_avail[3][2];
+};
+
+struct ad4130_state {
+	const struct ad4130_chip_info	*chip_info;
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct clk			*mclk;
+	struct regulator_bulk_data	regulators[4];
+	u32				irq_trigger;
+	u32				inv_irq_trigger;
+
+	/*
+	 * Synchronize access to members of driver state, and ensure atomicity
+	 * of consecutive regmap operations.
+	 */
+	struct mutex			lock;
+	struct completion		completion;
+
+	struct iio_chan_spec		chans[AD4130_MAX_CHANNELS];
+	struct ad4130_chan_info		chans_info[AD4130_MAX_CHANNELS];
+	struct ad4130_setup_info	setups_info[AD4130_MAX_SETUPS];
+	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
+	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
+	u32				num_vbias_pins;
+	int				scale_tbls[AD4130_REF_SEL_MAX]
+						  [AD4130_PGA_NUM][2];
+	struct gpio_chip		gc;
+	unsigned int			gpio_offsets[AD4130_MAX_GPIOS];
+	unsigned int			num_gpios;
+
+	u32			int_pin_sel;
+	bool			int_ref_en;
+	u32			int_ref_uv;
+	u32			mclk_sel;
+	bool			bipolar;
+
+	unsigned int		num_enabled_channels;
+	unsigned int		effective_watermark;
+	unsigned int		watermark;
+
+	struct spi_message	fifo_msg;
+	struct spi_transfer	fifo_xfer[2];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8			reset_buf[AD4130_RESET_BUF_SIZE] ____cacheline_aligned;
+	u8			reg_write_tx_buf[4];
+	u8			reg_read_tx_buf[1];
+	u8			reg_read_rx_buf[3];
+	u8			fifo_tx_buf[2];
+	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
+					    AD4130_FIFO_MAX_SAMPLE_SIZE];
+};
+
+static const char * const ad4130_int_pin_names[] = {
+	[AD4130_INT_PIN_DOUT_OR_INT] = "dout-int",
+	[AD4130_INT_PIN_CLK] = "clk",
+	[AD4130_INT_PIN_P1] = "p1",
+	[AD4130_INT_PIN_DOUT] = "dout",
+};
+
+static const unsigned int ad4130_iout_current_na_tbl[AD4130_IOUT_MAX] = {
+	[AD4130_IOUT_OFF] = 0,
+	[AD4130_IOUT_100NA] = 100,
+	[AD4130_IOUT_10000NA] = 10000,
+	[AD4130_IOUT_20000NA] = 20000,
+	[AD4130_IOUT_50000NA] = 50000,
+	[AD4130_IOUT_100000NA] = 100000,
+	[AD4130_IOUT_150000NA] = 150000,
+	[AD4130_IOUT_200000NA] = 200000,
+};
+
+static const unsigned int ad4130_burnout_current_na_tbl[AD4130_BURNOUT_MAX] = {
+	[AD4130_BURNOUT_OFF] = 0,
+	[AD4130_BURNOUT_500NA] = 500,
+	[AD4130_BURNOUT_2000NA] = 2000,
+	[AD4130_BURNOUT_4000NA] = 4000,
+};
+
+#define AD4130_VARIABLE_ODR_CONFIG(_filter_mode, _odr_div, _fs_max, _db3_div)	\
+{										\
+		.filter_mode = (_filter_mode),					\
+		.odr_div = (_odr_div),						\
+		.fs_max = (_fs_max),						\
+		.db3_div = (_db3_div),						\
+		.samp_freq_avail_type = IIO_AVAIL_RANGE,			\
+		.samp_freq_avail_len = 3,					\
+		.samp_freq_avail = {						\
+			{ AD4130_MAX_ODR, (_odr_div) * (_fs_max) },		\
+			{ AD4130_MAX_ODR, (_odr_div) * (_fs_max) },		\
+			{ AD4130_MAX_ODR, (_odr_div) },				\
+		},								\
+		.db3_freq_avail_type = IIO_AVAIL_RANGE,				\
+		.db3_freq_avail_len = 3,					\
+		.db3_freq_avail = {						\
+			{							\
+				AD4130_MAX_ODR * (_db3_div),			\
+				(_odr_div) * (_fs_max) * AD4130_DB3_FACTOR,	\
+			},							\
+			{							\
+				AD4130_MAX_ODR * (_db3_div),			\
+				(_odr_div) * (_fs_max) * AD4130_DB3_FACTOR,	\
+			},							\
+			{							\
+				AD4130_MAX_ODR * (_db3_div),			\
+				(_odr_div) * AD4130_DB3_FACTOR,			\
+			},							\
+		},								\
+}
+
+#define AD4130_FIXED_ODR_CONFIG(_filter_mode, _odr_div, _db3_div)	\
+{									\
+		.filter_mode = (_filter_mode),				\
+		.odr_div = (_odr_div),					\
+		.fs_max = AD4130_FS_MIN,				\
+		.db3_div = (_db3_div),					\
+		.samp_freq_avail_type = IIO_AVAIL_LIST,			\
+		.samp_freq_avail_len = 1,				\
+		.samp_freq_avail = {					\
+			{ AD4130_MAX_ODR, (_odr_div) },			\
+		},							\
+		.db3_freq_avail_type = IIO_AVAIL_LIST,			\
+		.db3_freq_avail_len = 1,				\
+		.db3_freq_avail = {					\
+			{						\
+				AD4130_MAX_ODR * AD4130_DB3_FACTOR,	\
+				(_odr_div) * (_db3_div)			\
+			},						\
+		},							\
+}
+
+static const struct ad4130_filter_config ad4130_filter_configs[] = {
+	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC4,       1,  10,   234),
+	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC4_SINC1, 11, 10,   590),
+	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3,       1,  2047, 268),
+	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3_REJ60, 1,  2047, 268),
+	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3_SINC1, 10, 2047, 545),
+	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF1,      92,       675),
+	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF2,      100,      675),
+	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF3,      124,      675),
+	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF4,      148,      675),
+};
+
+static const char * const ad4130_filter_modes_str[] = {
+	[AD4130_FILTER_SINC4] = "sinc4",
+	[AD4130_FILTER_SINC4_SINC1] = "sinc4+sinc1",
+	[AD4130_FILTER_SINC3] = "sinc3",
+	[AD4130_FILTER_SINC3_REJ60] = "sinc3+rej60",
+	[AD4130_FILTER_SINC3_SINC1] = "sinc3+sinc1",
+	[AD4130_FILTER_SINC3_PF1] = "sinc3+pf1",
+	[AD4130_FILTER_SINC3_PF2] = "sinc3+pf2",
+	[AD4130_FILTER_SINC3_PF3] = "sinc3+pf3",
+	[AD4130_FILTER_SINC3_PF4] = "sinc3+pf4",
+};
+
+static unsigned int ad4130_data_reg_size(struct ad4130_state *st)
+{
+	return st->chip_info->resolution / 8;
+}
+
+static int ad4130_get_reg_size(struct ad4130_state *st, unsigned int reg,
+			       unsigned int *size)
+{
+	if (reg >= ARRAY_SIZE(ad4130_reg_size))
+		return -EINVAL;
+
+	if (reg == AD4130_REG_DATA) {
+		*size = ad4130_data_reg_size(st);
+		return 0;
+	}
+
+	*size = ad4130_reg_size[reg];
+
+	if (!*size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad4130_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad4130_state *st = context;
+	unsigned int size;
+	int ret;
+
+	ret = ad4130_get_reg_size(st, reg, &size);
+	if (ret)
+		return ret;
+
+	st->reg_write_tx_buf[0] = reg;
+
+	switch (size) {
+	case 3:
+		put_unaligned_be24(val, &st->reg_write_tx_buf[1]);
+		break;
+	case 2:
+		put_unaligned_be16(val, &st->reg_write_tx_buf[1]);
+		break;
+	case 1:
+		st->reg_write_tx_buf[1] = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spi_write(st->spi, st->reg_write_tx_buf, size + 1);
+}
+
+static int ad4130_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4130_state *st = context;
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = st->reg_read_tx_buf,
+			.len = sizeof(st->reg_read_tx_buf),
+		},
+		{
+			.rx_buf = st->reg_read_rx_buf,
+		},
+	};
+	unsigned int size;
+	int ret;
+
+	ret = ad4130_get_reg_size(st, reg, &size);
+	if (ret)
+		return ret;
+
+	st->reg_read_tx_buf[0] = AD4130_COMMS_READ_MASK | reg;
+	t[1].len = size;
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret)
+		return ret;
+
+	switch (size) {
+	case 3:
+		*val = get_unaligned_be24(st->reg_read_rx_buf);
+		break;
+	case 2:
+		*val = get_unaligned_be16(st->reg_read_rx_buf);
+		break;
+	case 1:
+		*val = st->reg_read_rx_buf[0];
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config ad4130_regmap_config = {
+	.reg_read = ad4130_reg_read,
+	.reg_write = ad4130_reg_write,
+};
+
+static int ad4130_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static void ad4130_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			    int value)
+{
+	struct ad4130_state *st = gpiochip_get_data(gc);
+	unsigned int real_offset = st->gpio_offsets[offset];
+	unsigned int mask = FIELD_PREP(AD4130_GPIO_DATA_MASK, BIT(real_offset));
+
+	regmap_update_bits(st->regmap, AD4130_REG_IO_CONTROL, mask,
+			   value ? mask : 0);
+}
+
+static int ad4130_set_mode(struct ad4130_state *st, enum ad4130_mode mode)
+{
+	return regmap_update_bits(st->regmap, AD4130_REG_ADC_CONTROL,
+				  AD4130_MODE_MASK,
+				  FIELD_PREP(AD4130_MODE_MASK, mode));
+}
+
+static int ad4130_set_watermark_interrupt_en(struct ad4130_state *st, bool en)
+{
+	return regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
+				  AD4130_WATERMARK_INT_EN_MASK,
+				  en ? AD4130_WATERMARK_INT_EN_MASK : 0);
+}
+
+static unsigned int ad4130_watermark_reg_val(unsigned int val)
+{
+	if (val == AD4130_FIFO_SIZE)
+		val = AD4130_WATERMARK_256;
+
+	return val;
+}
+
+static int ad4130_set_fifo_mode(struct ad4130_state *st,
+				enum ad4130_fifo_mode mode)
+{
+	return regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
+				  AD4130_FIFO_MODE_MASK,
+				  FIELD_PREP(AD4130_FIFO_MODE_MASK, mode));
+}
+
+static void ad4130_push_fifo_data(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int data_reg_size = ad4130_data_reg_size(st);
+	unsigned int transfer_len = st->effective_watermark * data_reg_size;
+	unsigned int set_size = st->num_enabled_channels * data_reg_size;
+	unsigned int i;
+	int ret;
+
+	st->fifo_tx_buf[1] = ad4130_watermark_reg_val(st->effective_watermark);
+	st->fifo_xfer[1].len = transfer_len;
+
+	ret = spi_sync(st->spi, &st->fifo_msg);
+	if (ret)
+		return;
+
+	for (i = 0; i < transfer_len; i += set_size)
+		iio_push_to_buffers(indio_dev, &st->fifo_rx_buf[i]);
+}
+
+static irqreturn_t ad4130_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad4130_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		ad4130_push_fifo_data(indio_dev);
+	else
+		complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int ad4130_find_slot(struct ad4130_state *st,
+			    struct ad4130_setup_info *target_setup_info,
+			    unsigned int *slot, bool *overwrite)
+{
+	unsigned int i;
+
+	*slot = AD4130_INVALID_SLOT;
+	*overwrite = false;
+
+	for (i = 0; i < AD4130_MAX_SETUPS; i++) {
+		struct ad4130_setup_info *setup_info = &st->setups_info[i];
+
+		/* Immediately accept a matching setup info. */
+		if (!memcmp(target_setup_info, setup_info, AD4130_SETUP_SIZE)) {
+			*slot = i;
+			return 0;
+		}
+
+		/* Ignore all setups which are used by enabled channels. */
+		if (setup_info->enabled_channels)
+			continue;
+
+		/* Find the least used slot. */
+		if (*slot == AD4130_INVALID_SLOT ||
+		    setup_info->channels < st->setups_info[*slot].channels)
+			*slot = i;
+	}
+
+	if (*slot == AD4130_INVALID_SLOT)
+		return -EINVAL;
+
+	*overwrite = true;
+
+	return 0;
+}
+
+static void ad4130_unlink_channel(struct ad4130_state *st, unsigned int channel)
+{
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info = &st->setups_info[chan_info->slot];
+
+	chan_info->slot = AD4130_INVALID_SLOT;
+	setup_info->channels--;
+}
+
+static int ad4130_unlink_slot(struct ad4130_state *st, unsigned int slot)
+{
+	struct ad4130_setup_info *setup_info = &st->setups_info[slot];
+	unsigned int i;
+
+	if (setup_info->enabled_channels)
+		return -EINVAL;
+
+	for (i = 0; i < AD4130_MAX_CHANNELS; i++) {
+		struct ad4130_chan_info *chan_info = &st->chans_info[i];
+
+		if (!chan_info->initialized || chan_info->slot != slot)
+			continue;
+
+		ad4130_unlink_channel(st, i);
+	}
+
+	return 0;
+}
+
+static int ad4130_link_channel_slot(struct ad4130_state *st,
+				    unsigned int channel, unsigned int slot)
+{
+	struct ad4130_setup_info *setup_info = &st->setups_info[slot];
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4130_REG_CHANNEL_X(channel),
+				 AD4130_SETUP_MASK,
+				 FIELD_PREP(AD4130_SETUP_MASK, slot));
+	if (ret)
+		return ret;
+
+	chan_info->slot = slot;
+	setup_info->channels++;
+
+	return 0;
+}
+
+static int ad4130_write_slot_setup(struct ad4130_state *st,
+				   unsigned int slot,
+				   struct ad4130_setup_info *setup_info)
+{
+	unsigned int val;
+	int ret;
+
+	val = FIELD_PREP(AD4130_IOUT1_VAL_MASK, setup_info->iout0_val) |
+	      FIELD_PREP(AD4130_IOUT1_VAL_MASK, setup_info->iout1_val) |
+	      FIELD_PREP(AD4130_BURNOUT_MASK, setup_info->burnout) |
+	      FIELD_PREP(AD4130_REF_BUFP_MASK, setup_info->ref_bufp) |
+	      FIELD_PREP(AD4130_REF_BUFM_MASK, setup_info->ref_bufm) |
+	      FIELD_PREP(AD4130_REF_SEL_MASK, setup_info->ref_sel) |
+	      FIELD_PREP(AD4130_PGA_MASK, setup_info->pga);
+
+	ret = regmap_write(st->regmap, AD4130_REG_CONFIG_X(slot), val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_mode) |
+	      FIELD_PREP(AD4130_FILTER_SELECT_MASK, setup_info->fs);
+
+	ret = regmap_write(st->regmap, AD4130_REG_FILTER_X(slot), val);
+	if (ret)
+		return ret;
+
+	memcpy(&st->setups_info[slot], setup_info, AD4130_SETUP_SIZE);
+
+	return 0;
+}
+
+static int ad4130_write_channel_setup(struct ad4130_state *st,
+				      unsigned int channel, bool on_enable)
+{
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info = &chan_info->setup;
+	bool overwrite;
+	int slot;
+	int ret;
+
+	/*
+	 * The following cases need to be handled.
+	 *
+	 * 1. Enabled and linked channel with setup changes:
+	 *    - Find slot. If not possible, return error.
+	 *    - Unlink channel from current slot.
+	 *    - If slot has channels linked to it, unlink all channels, and
+	 *      write the new setup to it.
+	 *    - Link channel to new slot.
+	 *
+	 * 2. Soon to be enabled and unlinked channel:
+	 *    - Find slot. If not possible, return error.
+	 *    - If slot has channels linked to it, unlink all channels, and
+	 *      write the new setup to it.
+	 *    - Link channel to slot.
+	 *
+	 * 3. Disabled and linked channel with setup changes:
+	 *    - Unlink channel from current slot.
+	 *
+	 * 4. Soon to be enabled and linked channel:
+	 * 5. Disabled and unlinked channel with setup changes:
+	 *    - Do nothing.
+	 */
+
+	/* Case 4 */
+	if (on_enable && chan_info->slot != AD4130_INVALID_SLOT)
+		return 0;
+
+	if (!on_enable && !chan_info->enabled) {
+		if (chan_info->slot != AD4130_INVALID_SLOT)
+			/* Case 3 */
+			ad4130_unlink_channel(st, channel);
+
+		/* Case 3 & 5 */
+		return 0;
+	}
+
+	/* Case 1 & 2 */
+	ret = ad4130_find_slot(st, setup_info, &slot, &overwrite);
+	if (ret)
+		return ret;
+
+	if (chan_info->slot != AD4130_INVALID_SLOT)
+		/* Case 1 only */
+		ad4130_unlink_channel(st, channel);
+
+	if (overwrite) {
+		ret = ad4130_unlink_slot(st, slot);
+		if (ret)
+			return ret;
+
+		ret = ad4130_write_slot_setup(st, slot, setup_info);
+		if (ret)
+			return ret;
+	}
+
+	return ad4130_link_channel_slot(st, channel, slot);
+}
+
+static int ad4130_set_channel_enable(struct ad4130_state *st,
+				     unsigned int channel, bool status)
+{
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info;
+	int ret;
+
+	if (chan_info->enabled == status)
+		return 0;
+
+	if (status) {
+		ret = ad4130_write_channel_setup(st, channel, true);
+		if (ret)
+			return ret;
+	}
+
+	setup_info = &st->setups_info[chan_info->slot];
+
+	ret = regmap_update_bits(st->regmap, AD4130_REG_CHANNEL_X(channel),
+				 AD4130_CHANNEL_EN_MASK,
+				 status ? AD4130_CHANNEL_EN_MASK : 0);
+	if (ret)
+		return ret;
+
+	setup_info->enabled_channels += status ? 1 : -1;
+	chan_info->enabled = status;
+
+	return 0;
+}
+
+static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
+			      int val, int val2, unsigned int *fs, bool db3)
+{
+	const struct ad4130_filter_config *filter_config =
+		&ad4130_filter_configs[filter_mode];
+	unsigned long long dividend, divisor;
+	int temp;
+
+	dividend = filter_config->fs_max * filter_config->odr_div *
+		   (val * AD4130_FREQ_FACTOR + val2);
+	divisor = AD4130_MAX_ODR * AD4130_FREQ_FACTOR;
+
+	if (db3) {
+		dividend *= AD4130_DB3_FACTOR;
+		divisor *= filter_config->db3_div;
+	}
+
+	temp = AD4130_FS_MIN + filter_config->fs_max -
+	       DIV64_U64_ROUND_CLOSEST(dividend, divisor);
+
+	if (temp < AD4130_FS_MIN)
+		temp = AD4130_FS_MIN;
+	else if (temp > filter_config->fs_max)
+		temp = filter_config->fs_max;
+
+	*fs = temp;
+}
+
+static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
+			      unsigned int fs, int *val, int *val2, bool db3)
+{
+	const struct ad4130_filter_config *filter_config =
+		&ad4130_filter_configs[filter_mode];
+	unsigned int dividend, divisor;
+	u64 temp;
+
+	dividend = (filter_config->fs_max - fs + AD4130_FS_MIN) *
+		   AD4130_MAX_ODR;
+	divisor = filter_config->fs_max * filter_config->odr_div;
+
+	if (db3) {
+		dividend *= filter_config->db3_div;
+		divisor *= AD4130_DB3_FACTOR;
+	}
+
+	temp = div_u64(dividend * AD4130_FREQ_FACTOR, divisor);
+	*val = div_u64_rem(temp, AD4130_FREQ_FACTOR, val2);
+}
+
+static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int val)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int channel = chan->scan_index;
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info = &chan_info->setup;
+	enum ad4130_filter_mode old_filter_mode;
+	int freq_val, freq_val2;
+	unsigned int old_fs;
+	int ret = 0;
+
+	mutex_lock(&st->lock);
+	if (setup_info->filter_mode == val)
+		goto out;
+
+	old_fs = setup_info->fs;
+	old_filter_mode = setup_info->filter_mode;
+
+	ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+			  &freq_val, &freq_val2, false);
+
+	ad4130_freq_to_fs(val, freq_val, freq_val2, &setup_info->fs, false);
+
+	setup_info->filter_mode = val;
+
+	ret = ad4130_write_channel_setup(st, channel, false);
+	if (ret) {
+		setup_info->fs = old_fs;
+		setup_info->filter_mode = old_filter_mode;
+	}
+
+ out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int channel = chan->scan_index;
+	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
+	enum ad4130_filter_mode filter_mode;
+
+	mutex_lock(&st->lock);
+	filter_mode = setup_info->filter_mode;
+	mutex_unlock(&st->lock);
+
+	return filter_mode;
+}
+
+static const struct iio_enum ad4130_filter_mode_enum = {
+	.items = ad4130_filter_modes_str,
+	.num_items = ARRAY_SIZE(ad4130_filter_modes_str),
+	.set = ad4130_set_filter_mode,
+	.get = ad4130_get_filter_mode
+};
+
+static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
+	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
+	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
+			   &ad4130_filter_mode_enum),
+	{ },
+};
+
+static const struct iio_chan_spec ad4130_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.ext_info = ad4130_filter_mode_ext_info,
+	.scan_type = {
+		.sign = 'u',
+		.endianness = IIO_BE,
+	},
+};
+
+static int ad4130_set_channel_pga(struct ad4130_state *st, unsigned int channel,
+				  int val, int val2)
+{
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info = &chan_info->setup;
+	unsigned int pga, old_pga;
+	int ret = 0;
+
+	for (pga = 0; pga < AD4130_PGA_NUM; pga++)
+		if (val == st->scale_tbls[setup_info->ref_sel][pga][0] &&
+		    val2 == st->scale_tbls[setup_info->ref_sel][pga][1])
+			break;
+
+	if (pga == AD4130_PGA_NUM)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	if (pga == setup_info->pga)
+		goto out;
+
+	old_pga = setup_info->pga;
+	setup_info->pga = pga;
+
+	ret = ad4130_write_channel_setup(st, channel, false);
+	if (ret)
+		setup_info->pga = old_pga;
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad4130_set_channel_freq(struct ad4130_state *st,
+				   unsigned int channel,
+				   int val, int val2, bool db3)
+{
+	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
+	struct ad4130_setup_info *setup_info = &chan_info->setup;
+	unsigned int fs, old_fs;
+	int ret = 0;
+
+	mutex_lock(&st->lock);
+	old_fs = setup_info->fs;
+
+	ad4130_freq_to_fs(setup_info->filter_mode, val, val2, &fs, db3);
+
+	if (fs == setup_info->fs)
+		goto out;
+
+	setup_info->fs = fs;
+
+	ret = ad4130_write_channel_setup(st, channel, false);
+	if (ret)
+		setup_info->fs = old_fs;
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
+			       int *val)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4130_set_channel_enable(st, channel, true);
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->completion);
+
+	ret = ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	ret = ad4130_set_mode(st, AD4130_MODE_IDLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4130_REG_DATA, val);
+	if (ret)
+		return ret;
+
+	ret = ad4130_set_channel_enable(st, channel, false);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
+			      int *val)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	ret = _ad4130_read_sample(indio_dev, channel, val);
+	mutex_unlock(&st->lock);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad4130_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int channel = chan->scan_index;
+	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return ad4130_read_sample(indio_dev, channel, val);
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&st->lock);
+		*val = st->scale_tbls[setup_info->ref_sel][setup_info->pga][0];
+		*val2 = st->scale_tbls[setup_info->ref_sel][setup_info->pga][1];
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
+		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+				  val, val2, false);
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		mutex_lock(&st->lock);
+		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+				  val, val2, true);
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4130_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int channel = chan->scan_index;
+	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
+	const struct ad4130_filter_config *filter_config;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_tbls[setup_info->ref_sel];
+		*length = ARRAY_SIZE(st->scale_tbls[setup_info->ref_sel]) * 2;
+
+		*type = IIO_VAL_INT_PLUS_NANO;
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
+		filter_config = &ad4130_filter_configs[setup_info->filter_mode];
+		mutex_unlock(&st->lock);
+
+		*vals = (int *)filter_config->samp_freq_avail;
+		*length = filter_config->samp_freq_avail_len * 2;
+		*type = IIO_VAL_FRACTIONAL;
+
+		return filter_config->samp_freq_avail_type;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		mutex_lock(&st->lock);
+		filter_config = &ad4130_filter_configs[setup_info->filter_mode];
+		mutex_unlock(&st->lock);
+
+		*vals = (int *)filter_config->db3_freq_avail;
+		*length = filter_config->db3_freq_avail_len * 2;
+		*type = IIO_VAL_FRACTIONAL;
+
+		return filter_config->db3_freq_avail_type;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4130_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4130_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int channel = chan->scan_index;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad4130_set_channel_pga(st, channel, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4130_set_channel_freq(st, channel, val, val2, false);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return ad4130_set_channel_freq(st, channel, val, val2, true);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4130_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4130_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int val = 0;
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		bool status = test_bit(i, scan_mask);
+
+		if (!status)
+			continue;
+
+		ret = ad4130_set_channel_enable(st, i, status);
+		if (ret)
+			goto out;
+
+		val++;
+	}
+
+	st->num_enabled_channels = val;
+
+out:
+	mutex_unlock(&st->lock);
+
+	return 0;
+}
+
+static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int eff;
+	int ret = 0;
+
+	if (val > AD4130_FIFO_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Always set watermark to a multiple of the number of enabled channels
+	 * to avoid making the FIFO unaligned.
+	 */
+	eff = rounddown(val, st->num_enabled_channels);
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
+				 AD4130_WATERMARK_MASK,
+				 FIELD_PREP(AD4130_WATERMARK_MASK,
+					    ad4130_watermark_reg_val(eff)));
+	if (ret)
+		goto out;
+
+	st->effective_watermark = eff;
+	st->watermark = val;
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_info ad4130_info = {
+	.read_raw = ad4130_read_raw,
+	.read_avail = ad4130_read_avail,
+	.write_raw_get_fmt = ad4130_write_raw_get_fmt,
+	.write_raw = ad4130_write_raw,
+	.update_scan_mode = ad4130_update_scan_mode,
+	.hwfifo_set_watermark = ad4130_set_fifo_watermark,
+	.debugfs_reg_access = ad4130_reg_access,
+};
+
+static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = ad4130_set_watermark_interrupt_en(st, true);
+	if (ret)
+		goto out;
+
+	/* When the chip enters FIFO mode, IRQ polarity is inversed. */
+	ret = irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
+	if (ret)
+		goto out;
+
+	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WATERMARK);
+	if (ret)
+		goto out;
+
+	ret = ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = ad4130_set_mode(st, AD4130_MODE_IDLE);
+	if (ret)
+		goto out;
+
+	/* When the chip exits FIFO mode, IRQ polarity returns to normal. */
+	ret = irq_set_irq_type(st->spi->irq, st->irq_trigger);
+	if (ret)
+		goto out;
+
+	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
+	if (ret)
+		goto out;
+
+	ret = ad4130_set_watermark_interrupt_en(st, false);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = ad4130_set_channel_enable(st, i, false);
+		if (ret)
+			goto out;
+	}
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4130_buffer_ops = {
+	.postenable = ad4130_buffer_postenable,
+	.predisable = ad4130_buffer_predisable,
+};
+
+static ssize_t ad4130_get_fifo_watermark(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ad4130_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int val;
+
+	mutex_lock(&st->lock);
+	val = st->watermark;
+	mutex_unlock(&st->lock);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t ad4130_get_fifo_enabled(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct ad4130_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4130_REG_FIFO_CONTROL, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD4130_FIFO_MODE_MASK, val);
+
+	return sysfs_emit(buf, "%d\n", val != AD4130_FIFO_MODE_DISABLED);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(AD4130_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       ad4130_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       ad4130_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *ad4130_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int find_table_index(const unsigned int *tbl, size_t len,
+			    unsigned int val)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		if (tbl[i] == val)
+			return i;
+
+	return -EINVAL;
+}
+
+static int ad4130_get_ref_voltage(struct ad4130_state *st,
+				  enum ad4130_ref_sel ref_sel,
+				  unsigned int *ref_uv)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	switch (ref_sel) {
+	case AD4130_REF_REFIN1:
+		ret = regulator_get_voltage(st->regulators[2].consumer);
+		break;
+	case AD4130_REF_REFIN2:
+		ret = regulator_get_voltage(st->regulators[3].consumer);
+		break;
+	case AD4130_REF_AVDD_AVSS:
+		ret = regulator_get_voltage(st->regulators[0].consumer);
+		break;
+	case AD4130_REF_REFOUT_AVSS:
+		if (!st->int_ref_en) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = st->int_ref_uv;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret <= 0)
+		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
+				     ref_sel);
+
+	if (ref_uv)
+		*ref_uv = ret;
+
+	return 0;
+}
+
+static int ad4130_parse_fw_setup(struct ad4130_state *st,
+				 struct fwnode_handle *child,
+				 struct ad4130_setup_info *setup_info)
+{
+	struct device *dev = &st->spi->dev;
+	u32 current_na;
+	int ret;
+
+	current_na = 0;
+	fwnode_property_read_u32(child, "adi,excitation-current-0-nanoamps",
+				 &current_na);
+	ret = find_table_index(ad4130_iout_current_na_tbl, AD4130_IOUT_MAX,
+			       current_na);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Invalid excitation current %unA\n",
+				     current_na);
+	setup_info->iout0_val = ret;
+
+	current_na = 0;
+	fwnode_property_read_u32(child, "adi,excitation-current-1-nanoamps",
+				 &current_na);
+	ret = find_table_index(ad4130_iout_current_na_tbl, AD4130_IOUT_MAX,
+			       current_na);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Invalid excitation current %unA\n",
+				     current_na);
+	setup_info->iout1_val = ret;
+
+	current_na = 0;
+	fwnode_property_read_u32(child, "adi,burnout-current-nanoamps",
+				 &current_na);
+	ret = find_table_index(ad4130_burnout_current_na_tbl,
+			       AD4130_BURNOUT_MAX, current_na);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Invalid burnout current %unA\n",
+				     current_na);
+	setup_info->burnout = ret;
+
+	setup_info->ref_bufp = fwnode_property_read_bool(child, "adi,buffered-positive");
+	setup_info->ref_bufm = fwnode_property_read_bool(child, "adi,buffered-negative");
+
+	setup_info->ref_sel = AD4130_REF_REFOUT_AVSS;
+	fwnode_property_read_u32(child, "adi,reference-select",
+				 &setup_info->ref_sel);
+	if (setup_info->ref_sel >= AD4130_REF_SEL_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid reference selected %u\n",
+				     setup_info->ref_sel);
+
+	ret = ad4130_get_ref_voltage(st, setup_info->ref_sel, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
+{
+	struct device *dev = &st->spi->dev;
+
+	if (pin >= AD4130_MAX_DIFF_INPUTS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid diffreential channel %u\n", pin);
+
+	if (pin >= AD4130_MAX_ANALOG_PINS)
+		return 0;
+
+	if (st->pins_fn[pin] == AD4130_PIN_FN_SPECIAL)
+		return dev_err_probe(dev, -EINVAL,
+				     "Pin %u already used with fn %u\n", pin,
+				     st->pins_fn[pin]);
+
+	st->pins_fn[pin] |= AD4130_PIN_FN_DIFF;
+
+	return 0;
+}
+
+static int ad4130_validate_diff_channels(struct ad4130_state *st,
+					 u32 *pins, unsigned int len)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < len; i++) {
+		ret = ad4130_validate_diff_channel(st, pins[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int ad4130_validate_excitation_pin(struct ad4130_state *st, u32 pin)
+{
+	struct device *dev = &st->spi->dev;
+
+	if (pin >= AD4130_MAX_ANALOG_PINS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid excitation pin %u\n", pin);
+
+	if (st->pins_fn[pin] == AD4130_PIN_FN_SPECIAL)
+		return dev_err_probe(dev, -EINVAL,
+				     "Pin %u already used with fn %u\n", pin,
+				     st->pins_fn[pin]);
+
+	st->pins_fn[pin] |= AD4130_PIN_FN_EXCITATION;
+
+	return 0;
+}
+
+static int ad4130_validate_vbias_pin(struct ad4130_state *st, u32 pin)
+{
+	struct device *dev = &st->spi->dev;
+
+	if (pin >= AD4130_MAX_ANALOG_PINS)
+		return dev_err_probe(dev, -EINVAL, "Invalid vbias pin %u\n",
+				     pin);
+
+	if (st->pins_fn[pin] == AD4130_PIN_FN_SPECIAL)
+		return dev_err_probe(dev, -EINVAL,
+				     "Pin %u already used with fn %u\n", pin,
+				     st->pins_fn[pin]);
+
+	st->pins_fn[pin] |= AD4130_PIN_FN_VBIAS;
+
+	return 0;
+}
+
+static int ad4130_validate_vbias_pins(struct ad4130_state *st,
+				      u32 *pins, unsigned int len)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < st->num_vbias_pins; i++) {
+		ret = ad4130_validate_vbias_pin(st, pins[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int ad4130_parse_fw_channel(struct iio_dev *indio_dev,
+				   struct fwnode_handle *child)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int index = indio_dev->num_channels++;
+	struct device *dev = &st->spi->dev;
+	struct ad4130_chan_info *chan_info;
+	struct iio_chan_spec *chan;
+	u32 pins[2];
+	int ret;
+
+	if (index >= AD4130_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
+
+	chan = &st->chans[index];
+	chan_info = &st->chans_info[index];
+
+	*chan = ad4130_channel_template;
+	chan->scan_type.realbits = st->chip_info->resolution;
+	chan->scan_type.storagebits = st->chip_info->resolution;
+	chan->scan_index = index;
+
+	chan_info->slot = AD4130_INVALID_SLOT;
+	chan_info->setup.fs = AD4130_FS_MIN;
+	chan_info->initialized = true;
+
+	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
+					     ARRAY_SIZE(pins));
+	if (ret)
+		return ret;
+
+	ret = ad4130_validate_diff_channels(st, pins, ARRAY_SIZE(pins));
+	if (ret)
+		return ret;
+
+	chan->channel = pins[0];
+	chan->channel2 = pins[1];
+
+	fwnode_property_read_u32(child, "adi,excitation-pin-0",
+				 &chan_info->iout0);
+	ret = ad4130_validate_excitation_pin(st, chan_info->iout0);
+	if (ret)
+		return ret;
+
+	fwnode_property_read_u32(child, "adi,excitation-pin-1",
+				 &chan_info->iout1);
+	ret = ad4130_validate_excitation_pin(st, chan_info->iout1);
+	if (ret)
+		return ret;
+
+	return ad4130_parse_fw_setup(st, child, &chan_info->setup);
+}
+
+static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct fwnode_handle *child;
+	int ret;
+
+	indio_dev->channels = st->chans;
+
+	device_for_each_child_node(dev, child) {
+		ret = ad4130_parse_fw_channel(indio_dev, child);
+		if (ret)
+			break;
+	}
+
+	fwnode_handle_put(child);
+
+	return ret;
+}
+
+static int ad4310_parse_fw(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	unsigned int i;
+	int avdd_uv;
+	int irq;
+	int ret;
+
+	st->mclk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get mclk\n");
+
+	st->int_pin_sel = AD4130_INT_PIN_DOUT_OR_INT;
+
+	for (i = 0; i < ARRAY_SIZE(ad4130_int_pin_names); i++) {
+		irq = of_irq_get_byname(dev->of_node, ad4130_int_pin_names[i]);
+		if (irq > 0) {
+			st->int_pin_sel = i;
+			break;
+		}
+	}
+
+	if (st->int_pin_sel == AD4130_INT_PIN_DOUT ||
+	    (st->int_pin_sel == AD4130_INT_PIN_DOUT_OR_INT &&
+	     !st->chip_info->has_int_pin))
+		return dev_err_probe(dev, -EINVAL,
+				     "Cannot use DOUT as interrupt pin\n");
+
+	if (st->int_pin_sel == AD4130_INT_PIN_P1)
+		st->pins_fn[AD4130_AIN2_P1] = AD4130_PIN_FN_SPECIAL;
+
+	st->mclk_sel = AD4130_MCLK_76_8KHZ;
+	device_property_read_u32(dev, "adi,mclk-sel", &st->mclk_sel);
+
+	if (st->mclk_sel >= AD4130_MCLK_SEL_MAX)
+		return dev_err_probe(dev, -EINVAL, "Invalid clock %u\n",
+				     st->mclk_sel);
+
+	if (st->mclk && (st->mclk_sel == AD4130_MCLK_76_8KHZ ||
+			 st->mclk_sel == AD4130_MCLK_76_8KHZ_OUT))
+		return dev_err_probe(dev, -EINVAL,
+				     "Cannot use external clock\n");
+
+	if (st->int_pin_sel == AD4130_INT_PIN_CLK &&
+	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock %u for interrupt pin %u\n",
+				     st->mclk_sel, st->int_pin_sel);
+
+	st->int_ref_en = true;
+	if (device_property_present(dev, "adi,int-ref-en"))
+		st->int_ref_en = device_property_read_bool(dev, "adi,int-ref-en");
+
+	st->int_ref_uv = AD4130_INT_REF_2_5V;
+
+	/*
+	 * When the AVDD supply is set to below 2.5V the internal reference of
+	 * 1.25V should be selected.
+	 */
+	avdd_uv = regulator_get_voltage(st->regulators[0].consumer);
+	if (avdd_uv > 0 && avdd_uv < AD4130_INT_REF_2_5V)
+		st->int_ref_uv = AD4130_INT_REF_1_25V;
+
+	st->bipolar = device_property_read_bool(dev, "adi,bipolar");
+
+	ret = device_property_count_u32(dev, "adi,vbias-pins");
+	if (ret > 0) {
+		st->num_vbias_pins = ret;
+
+		ret = device_property_read_u32_array(dev, "adi,vbias-pins",
+						     st->vbias_pins,
+						     st->num_vbias_pins);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read vbias pins\n");
+
+		ret = ad4130_validate_vbias_pins(st, st->vbias_pins,
+						 st->num_vbias_pins);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad4130_parse_fw_children(indio_dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AD4130_MAX_GPIOS; i++) {
+		if (st->pins_fn[i + AD4130_AIN2_P1] != AD4130_PIN_FN_NONE)
+			continue;
+
+		st->gpio_offsets[st->num_gpios++] = i;
+	}
+
+	return 0;
+}
+
+static void ad4130_fill_scale_tbls(struct ad4130_state *st)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < AD4130_REF_SEL_MAX; i++) {
+		unsigned int ref_uv;
+		int ret;
+
+		ret = ad4130_get_ref_voltage(st, i, &ref_uv);
+		if (ret)
+			continue;
+
+		for (j = 0; j < AD4130_PGA_NUM; j++) {
+			unsigned int pow = st->chip_info->resolution + j -
+					   st->bipolar;
+			unsigned int nv = div_u64(((ref_uv * 1000000000ull) >>
+						   pow), 1000);
+
+			st->scale_tbls[i][j][0] = 0;
+			st->scale_tbls[i][j][1] = nv;
+		}
+	}
+}
+
+static void ad4130_clk_disable_unprepare(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int ad4130_setup(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	unsigned int int_ref_val;
+	unsigned long rate = AD4130_MCLK_FREQ_76_8KHZ;
+	unsigned int val;
+	unsigned int i;
+	int ret;
+
+	if (st->mclk_sel == AD4130_MCLK_153_6KHZ_EXT)
+		rate = AD4130_MCLK_FREQ_153_6KHZ;
+
+	ret = clk_set_rate(st->mclk, rate);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
+				       st->mclk);
+	if (ret)
+		return ret;
+
+	if (st->int_ref_uv == AD4130_INT_REF_2_5V)
+		int_ref_val = AD4130_INT_REF_VAL_2_5V;
+	else
+		int_ref_val = AD4130_INT_REF_VAL_1_25V;
+
+	/* Switch to SPI 4-wire mode. */
+	val = AD4130_CSB_EN_MASK;
+	val |= st->bipolar ? AD4130_BIPOLAR_MASK : 0;
+	val |= st->int_ref_en ? AD4130_INT_REF_EN_MASK : 0;
+	val |= FIELD_PREP(AD4130_MODE_MASK, AD4130_MODE_IDLE);
+	val |= FIELD_PREP(AD4130_MCLK_SEL_MASK, st->mclk_sel);
+	val |= FIELD_PREP(AD4130_INT_REF_VAL_MASK, int_ref_val);
+
+	ret = regmap_write(st->regmap, AD4130_REG_ADC_CONTROL, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(AD4130_INT_PIN_SEL_MASK, st->int_pin_sel);
+	for (i = 0; i < st->num_gpios; i++)
+		val |= BIT(st->gpio_offsets[i]);
+
+	ret = regmap_write(st->regmap, AD4130_REG_IO_CONTROL, val);
+	if (ret)
+		return ret;
+
+	val = 0;
+	for (i = 0; i < st->num_vbias_pins; i++)
+		val |= BIT(st->vbias_pins[i]);
+
+	ret = regmap_write(st->regmap, AD4130_REG_VBIAS, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
+				 AD4130_ADD_FIFO_HEADER_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* FIFO watermark interrupt starts out as enabled, disable it. */
+	ret = ad4130_set_watermark_interrupt_en(st, false);
+	if (ret)
+		return ret;
+
+	/* Setup channels. */
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		struct ad4130_chan_info *chan_info = &st->chans_info[i];
+		struct iio_chan_spec *chan = &st->chans[i];
+		unsigned int val;
+
+		val = FIELD_PREP(AD4130_AINP_MASK, chan->channel) |
+		      FIELD_PREP(AD4130_AINM_MASK, chan->channel2) |
+		      FIELD_PREP(AD4130_IOUT1_MASK, chan_info->iout0) |
+		      FIELD_PREP(AD4130_IOUT2_MASK, chan_info->iout1);
+
+		ret = regmap_write(st->regmap, AD4130_REG_CHANNEL_X(i), val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad4130_soft_reset(struct ad4130_state *st)
+{
+	int ret;
+
+	ret = spi_write(st->spi, st->reset_buf, sizeof(st->reset_buf));
+	if (ret)
+		return ret;
+
+	fsleep(AD4130_SOFT_RESET_SLEEP);
+
+	return 0;
+}
+
+static void ad4130_disable_regulators(void *data)
+{
+	struct ad4130_state *st = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
+}
+
+static int ad4130_probe(struct spi_device *spi)
+{
+	const struct ad4130_chip_info *info;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4130_state *st;
+	int ret;
+
+	info = device_get_match_data(dev);
+	if (!info)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	memset(st->reset_buf, 0xff, AD4130_RESET_BUF_SIZE);
+	init_completion(&st->completion);
+	mutex_init(&st->lock);
+	st->chip_info = info;
+	st->spi = spi;
+
+	/*
+	 * Xfer:   [ XFR1 ] [         XFR2         ]
+	 * Master:  0x7D N   ......................
+	 * Slave:   ......   DATA1 DATA2 ... DATAN
+	 */
+	st->fifo_tx_buf[0] = AD4130_COMMS_READ_MASK | AD4130_REG_FIFO_DATA;
+	st->fifo_xfer[0].tx_buf = st->fifo_tx_buf;
+	st->fifo_xfer[0].len = sizeof(st->fifo_tx_buf);
+	st->fifo_xfer[1].rx_buf = st->fifo_rx_buf;
+	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
+					ARRAY_SIZE(st->fifo_xfer));
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad4130_info;
+
+	st->regmap = devm_regmap_init(dev, NULL, st,
+				      &ad4130_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	st->regulators[0].supply = "avdd";
+	st->regulators[1].supply = "iovdd";
+	st->regulators[2].supply = "refin1";
+	st->regulators[3].supply = "refin2";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
+				      st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable regulators\n");
+
+	ret = devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add regulators disable action\n");
+
+	ret = ad4130_soft_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ad4310_parse_fw(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4130_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ad4130_fill_scale_tbls(st);
+
+	if (st->num_gpios) {
+		st->gc.owner = THIS_MODULE;
+		st->gc.label = st->chip_info->name;
+		st->gc.base = -1;
+		st->gc.ngpio = AD4130_MAX_GPIOS;
+		st->gc.parent = dev;
+		st->gc.can_sleep = true;
+		st->gc.get_direction = ad4130_gpio_get_direction;
+		st->gc.set = ad4130_gpio_set;
+
+		ret = devm_gpiochip_add_data(dev, &st->gc, st);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+					      INDIO_BUFFER_SOFTWARE,
+					      &ad4130_buffer_ops,
+					      ad4130_fifo_attributes);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, spi->irq, NULL,
+					ad4130_irq_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	st->irq_trigger = irq_get_trigger_type(spi->irq);
+	if (st->irq_trigger & IRQF_TRIGGER_RISING)
+		st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
+	else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
+		st->inv_irq_trigger = IRQF_TRIGGER_RISING;
+	else
+		return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
+				     st->irq_trigger);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct ad4130_chip_info ad4130_chip_info_tbl[] = {
+	[ID_AD4130_8_24_WLCSP] = {
+		.name = AD4130_8_NAME,
+		.resolution = 24,
+		.has_int_pin = true,
+	},
+	[ID_AD4130_8_24_LFCSP] = {
+		.name = AD4130_8_NAME,
+		.resolution = 24,
+		.has_int_pin = false,
+	},
+	[ID_AD4130_8_16_WLCSP] = {
+		.name = AD4130_8_NAME,
+		.resolution = 16,
+		.has_int_pin = true,
+	},
+	[ID_AD4130_8_16_LFCSP] = {
+		.name = AD4130_8_NAME,
+		.resolution = 16,
+		.has_int_pin = false,
+	},
+};
+
+static const struct of_device_id ad4130_of_match[] = {
+	{
+		.compatible = "adi,ad4130-8-16-lfcsp",
+		.data = &ad4130_chip_info_tbl[ID_AD4130_8_16_LFCSP],
+	},
+	{
+		.compatible = "adi,ad4130-8-16-wlcsp",
+		.data = &ad4130_chip_info_tbl[ID_AD4130_8_16_WLCSP],
+	},
+	{
+		.compatible = "adi,ad4130-8-24-lfcsp",
+		.data = &ad4130_chip_info_tbl[ID_AD4130_8_24_LFCSP],
+	},
+	{
+		.compatible = "adi,ad4130-8-24-wlcsp",
+		.data = &ad4130_chip_info_tbl[ID_AD4130_8_24_WLCSP],
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad4130_of_match);
+
+static struct spi_driver ad4130_driver = {
+	.driver = {
+		.name = "ad4130",
+		.of_match_table = ad4130_of_match,
+	},
+	.probe = ad4130_probe,
+};
+module_spi_driver(ad4130_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4130 SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

