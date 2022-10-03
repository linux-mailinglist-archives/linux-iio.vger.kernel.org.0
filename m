Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE25F2ED1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJCKbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 06:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJCKbF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 06:31:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226832AA7;
        Mon,  3 Oct 2022 03:30:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f1so3642083ejw.7;
        Mon, 03 Oct 2022 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p10h8H7/4IsqfjuN2x7W6DbgITsBkaoHoVMcVH7htbs=;
        b=Fl+AIPBlKRNyTxn140OyITjNePfz54aLpa5MOgkZuHQCiaKRhz1f/uMnZ6A90KrWpx
         YjqMcl0taK0/B1OhQUe1nu5iGXX9OaDjc2T1N3aCzk6Qrp2tsCm/zsiW6ZCe6Jtc1CM2
         iSSUKnQueZElLNBcYFGbXUV3XguEl45nFCV9iNDc/PEvfS5KdwbXRZa0bf6bgOCdCCRI
         k/WP22H0SOzrJm1TyxMADortRhEt3ghzycsYF/C1VmG/jxITcMy+2FYT7Ebm9UhIvxYS
         dCiaoisJTLit8F5UmabiKXgYYCcqJVqw767aA1k129JgL25whcxXi10v3S3UD/s5J/N0
         SkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p10h8H7/4IsqfjuN2x7W6DbgITsBkaoHoVMcVH7htbs=;
        b=awd6KS/TIRg9Aov2GcfA16aS8GNCmrc/HolZBoQcGqHbJblh5wvHr3rkELBGDl2FKW
         yv0r+zQVfx1LH5r2KO2LmC5zPZN35r2EVSS6GLx9drae/Vpzl5PLfNdRXgCX7JilbP6L
         2/J3+x/t6AIWoiJfFsExHxKtDZRqdgNoU36awYmEV/YKcPTzbWIXVSj8kl+HNrZ1eZzo
         rz/oe8+QsGia1U7Ge3UCPic53+rDLpCYDZsHOXuanVDi1gfmJ3UYpQoUrqF4Ofz7KI1G
         GUqjDHi7RugoicrgiZmrEr2P3WCSleCFRSuP8v7qn7eNrcv0X4D7OipYwncORV9aFPAs
         fFWQ==
X-Gm-Message-State: ACrzQf27x3UM/4Xcm2de8h/YUWy1hglvojfRUxVysmjbSn3Sozn5aejv
        lzjedhcFvxCDw7iEOGT50fcttyB49yGl8w==
X-Google-Smtp-Source: AMsMyM7kkvQu2Lag9AVm+mUQImDccorzS0/zmrMmkKZCujpmq8UFmsHZk6Zhl4cJxKHr+CpVbv2tOw==
X-Received: by 2002:a17:907:3d8a:b0:78c:606e:d2d7 with SMTP id he10-20020a1709073d8a00b0078c606ed2d7mr1268971ejc.412.1664793055476;
        Mon, 03 Oct 2022 03:30:55 -0700 (PDT)
Received: from localhost.localdomain ([109.166.136.105])
        by smtp.gmail.com with ESMTPSA id u3-20020a50c043000000b0045754cd5e08sm7232173edd.39.2022.10.03.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:30:55 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: addac: add AD74115 driver
Date:   Mon,  3 Oct 2022 13:30:15 +0300
Message-Id: <20221003103016.195805-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003103016.195805-1-demonsingur@gmail.com>
References: <20221003103016.195805-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The AD74115H is a single-channel, software-configurable, input and
output device for industrial control applications. The AD74115H
provides a wide range of use cases, integrated on a single chip.

These use cases include analog output, analog input, digital output,
digital input, resistance temperature detector (RTD), and thermocouple
measurement capability. The AD74115H also has an integrated HART modem.

A serial peripheral interface (SPI) is used to handle all communications
to the device, including communications with the HART modem. The digital
input and digital outputs can be accessed via the SPI or the
general-purpose input and output (GPIO) pins to support higher
speed data rates.

The device features a 16-bit, sigma-delta analog-to-digital converter
(ADC) and a 14-bit digital-to-analog converter (DAC).
The AD74115H contains a high accuracy 2.5 V on-chip reference that can
be used as the DAC and ADC reference.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 MAINTAINERS                 |    1 +
 drivers/iio/addac/Kconfig   |   14 +
 drivers/iio/addac/Makefile  |    1 +
 drivers/iio/addac/ad74115.c | 2025 +++++++++++++++++++++++++++++++++++
 4 files changed, 2041 insertions(+)
 create mode 100644 drivers/iio/addac/ad74115.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25071e763b33..c5b6d8bbb386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1146,6 +1146,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+F:	drivers/iio/addac/ad74115.c
 
 ANALOG DEVICES INC AD74413R DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index fcf6d2269bfc..2843fcb70e24 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -5,6 +5,20 @@
 
 menu "Analog to digital and digital to analog converters"
 
+config AD74115
+	tristate "Analog Devices AD74115H driver"
+	depends on GPIOLIB && SPI
+	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD74115H
+	  single-channel software configurable input/output solution.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad74115.
+
 config AD74413R
 	tristate "Analog Devices AD74412R/AD74413R driver"
 	depends on GPIOLIB && SPI
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
index 17de20ef0d8e..577777276e43 100644
--- a/drivers/iio/addac/Makefile
+++ b/drivers/iio/addac/Makefile
@@ -4,5 +4,6 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AD74115) += ad74115.o
 obj-$(CONFIG_AD74413R) += ad74413r.o
 obj-$(CONFIG_STX104) += stx104.o
diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
new file mode 100644
index 000000000000..3234b7165b9f
--- /dev/null
+++ b/drivers/iio/addac/ad74115.c
@@ -0,0 +1,2025 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#include <linux/crc8.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define AD74115_NAME				"ad74115"
+
+#define AD74115_CH_FUNC_SETUP_REG		0x01
+
+#define AD74115_ADC_CONFIG_REG			0x02
+#define AD74115_ADC_CONFIG_CONV2_RANGE_MASK	GENMASK(9, 7)
+#define AD74115_ADC_CONFIG_CONV1_RANGE_MASK	GENMASK(6, 4)
+#define AD74115_ADC_CONFIG_CONV2_RATE_MASK	GENMASK(15, 13)
+#define AD74115_ADC_CONFIG_CONV1_RATE_MASK	GENMASK(12, 10)
+
+#define AD74115_PWR_OPTIM_CONFIG_REG		0x03
+
+#define AD74115_DIN_CONFIG1_REG			0x04
+#define AD74115_DIN_COMPARATOR_EN_MASK		BIT(13)
+#define AD74115_DIN_DEBOUNCE_MASK		GENMASK(4, 0)
+
+#define AD74115_DIN_CONFIG2_REG			0x05
+#define AD74115_COMP_THRESH_MASK		GENMASK(6, 0)
+
+#define AD74115_OUTPUT_CONFIG_REG		0x06
+#define AD74115_OUTPUT_SLEW_EN_MASK		GENMASK(6, 5)
+#define AD74115_OUTPUT_SLEW_LIN_STEP_MASK	GENMASK(4, 3)
+#define AD74115_OUTPUT_SLEW_LIN_RATE_MASK	GENMASK(2, 1)
+
+#define AD74115_RTD3W4W_CONFIG_REG		0x07
+
+#define AD74115_BURNOUT_CONFIG_REG		0x0a
+
+#define AD74115_DAC_CODE_REG			0x0b
+
+#define AD74115_DAC_ACTIVE_REG			0x0d
+
+#define AD74115_GPIO_CONFIG_X_REG(x)		(0x35 + (x))
+#define AD74115_GPIO_CONFIG_GPI_DATA		BIT(5)
+#define AD74115_GPIO_CONFIG_GPO_DATA		BIT(4)
+#define AD74115_GPIO_CONFIG_SELECT_MASK		GENMASK(2, 0)
+
+#define AD74115_CHARGE_PUMP_REG			0x3a
+
+#define AD74115_ADC_CONV_CTRL_REG		0x3b
+#define AD74115_ADC_CONV_RATE_DIAG_MASK		GENMASK(15, 14)
+#define AD74115_ADC_CONV_SEQ_MASK		GENMASK(13, 12)
+
+#define AD74115_DIAG_ASSIGN_REG			0x3c
+#define AD74115_DIAG_ASSIGN_X_MASK(x)		(GENMASK(3, 0) << (4 * (x)))
+
+#define AD74115_DIN_COMP_OUT_REG		0x40
+
+#define AD74115_READ_SELECT_REG			0x64
+
+#define AD74115_CMD_KEY_REG			0x78
+#define AD74115_CMD_KEY_RESET1			0x15fa
+#define AD74115_CMD_KEY_RESET2			0xaf51
+
+#define AD74115_CRC_POLYNOMIAL			0x7
+DECLARE_CRC8_TABLE(ad74115_crc8_table);
+
+#define AD74115_ADC_CODE_MAX			((int)GENMASK(15, 0))
+#define AD74115_ADC_CODE_HALF			(AD74115_ADC_CODE_MAX / 2)
+
+#define AD74115_DAC_VOLTAGE_MAX			12000
+#define AD74115_DAC_CURRENT_MAX			25
+#define AD74115_DAC_CODE_MAX			((int)GENMASK(13, 0))
+#define AD74115_DAC_CODE_HALF			(AD74115_DAC_CODE_MAX / 2)
+
+#define AD74115_COMP_THRESH_MAX			98
+
+#define AD74115_SENSE_RESISTOR_OHMS		100
+#define AD74115_REF_RESISTOR_OHMS		2100
+
+#define AD74115_FRAME_SIZE			4
+#define AD74115_GPIO_NUM			4
+#define AD74115_DIAG_NUM			4
+
+enum ad74115_dac_ch {
+	AD74115_DAC_CH_MAIN,
+	AD74115_DAC_CH_COMPARATOR,
+};
+
+enum ad74115_adc_ch {
+	AD74115_ADC_CH_CONV1,
+	AD74115_ADC_CH_CONV2,
+	AD74115_ADC_CH_DIAG0,
+	AD74115_ADC_CH_DIAG1,
+	AD74115_ADC_CH_DIAG2,
+	AD74115_ADC_CH_DIAG3,
+	AD74115_ADC_CH_NUM
+};
+
+#define AD74115_CHANNEL_TO_DIAG_X(x)		((x) - AD74115_ADC_CH_DIAG0)
+
+enum ad74115_ch_func {
+	AD74115_CH_FUNC_HIGH_IMPEDANCE,
+	AD74115_CH_FUNC_VOLTAGE_OUTPUT,
+	AD74115_CH_FUNC_CURRENT_OUTPUT,
+	AD74115_CH_FUNC_VOLTAGE_INPUT,
+	AD74115_CH_FUNC_CURRENT_INPUT_EXT_POWER,
+	AD74115_CH_FUNC_CURRENT_INPUT_LOOP_POWER,
+	AD74115_CH_FUNC_2_WIRE_RESISTANCE_INPUT,
+	AD74115_CH_FUNC_3_4_WIRE_RESISTANCE_INPUT,
+	AD74115_CH_FUNC_DIGITAL_INPUT_LOGIC,
+	AD74115_CH_FUNC_DIGITAL_INPUT_LOOP_POWER,
+	AD74115_CH_FUNC_CURRENT_OUTPUT_HART,
+	AD74115_CH_FUNC_CURRENT_INPUT_EXT_POWER_HART,
+	AD74115_CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART,
+	AD74115_CH_FUNC_MAX = AD74115_CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART,
+	AD74115_CH_FUNC_NUM
+};
+
+enum ad74115_adc_range {
+	AD74115_ADC_RANGE_12V,
+	AD74115_ADC_RANGE_12V_BIPOLAR,
+	AD74115_ADC_RANGE_2_5V_BIPOLAR,
+	AD74115_ADC_RANGE_2_5V_NEG,
+	AD74115_ADC_RANGE_2_5V,
+	AD74115_ADC_RANGE_0_625V,
+	AD74115_ADC_RANGE_104MV_BIPOLAR,
+	AD74115_ADC_RANGE_12V_OTHER,
+	AD74115_ADC_RANGE_MAX = AD74115_ADC_RANGE_12V_OTHER,
+	AD74115_ADC_RANGE_NUM,
+};
+
+enum ad74115_adc_conv_seq {
+	AD74115_ADC_CONV_SEQ_STANDBY = 0b00,
+	AD74115_ADC_CONV_SEQ_SINGLE = 0b01,
+	AD74115_ADC_CONV_SEQ_CONTINUOUS = 0b10,
+};
+
+enum ad74115_din_threshold_mode {
+	AD74115_DIN_THRESHOLD_MODE_AVDD,
+	AD74115_DIN_THRESHOLD_MODE_FIXED,
+	AD74115_DIN_THRESHOLD_MODE_MAX = AD74115_DIN_THRESHOLD_MODE_FIXED,
+};
+
+enum ad74115_rtd_mode {
+	AD74115_RTD_MODE_3_WIRE,
+	AD74115_RTD_MODE_4_WIRE,
+	AD74115_RTD_MODE_MAX = AD74115_RTD_MODE_4_WIRE,
+};
+
+enum ad74115_slew_mode {
+	AD74115_SLEW_MODE_DISABLED,
+	AD74115_SLEW_MODE_LINEAR,
+	AD74115_SLEW_MODE_HART,
+};
+
+enum ad74115_slew_step {
+	AD74115_SLEW_STEP_0_8_PERCENT,
+	AD74115_SLEW_STEP_1_5_PERCENT,
+	AD74115_SLEW_STEP_6_1_PERCENT,
+	AD74115_SLEW_STEP_22_2_PERCENT,
+};
+
+enum ad74115_slew_rate {
+	AD74115_SLEW_RATE_4KHZ,
+	AD74115_SLEW_RATE_64KHZ,
+	AD74115_SLEW_RATE_150KHZ,
+	AD74115_SLEW_RATE_240KHZ,
+};
+
+enum ad74115_diag_func {
+	AD74115_DIAG_FUNC_DISABLED,
+	AD74115_DIAG_FUNC_TEMP,
+	AD74115_DIAG_FUNC_DVCC,
+	AD74115_DIAG_FUNC_AVCC,
+	AD74115_DIAG_FUNC_ALDO1V8,
+	AD74115_DIAG_FUNC_DLDO1V8,
+	AD74115_DIAG_FUNC_REFOUT,
+	AD74115_DIAG_FUNC_AVDD,
+	AD74115_DIAG_FUNC_AVSS,
+	AD74115_DIAG_FUNC_LVIN,
+	AD74115_DIAG_FUNC_SENSEL,
+	AD74115_DIAG_FUNC_SENSE_EXT1,
+	AD74115_DIAG_FUNC_SENSE_EXT2,
+	AD74115_DIAG_FUNC_DO_VDD,
+	AD74115_DIAG_FUNC_AGND,
+	AD74115_DIAG_FUNC_SINK_OR_SOURCE_CURRENT,
+	AD74115_DIAG_FUNC_MAX = AD74115_DIAG_FUNC_SINK_OR_SOURCE_CURRENT,
+	AD74115_DIAG_FUNC_NUM
+};
+
+enum ad74115_gpio_config {
+	AD74115_GPIO_CONFIG_OUTPUT_BUFFERED = 0b010,
+	AD74115_GPIO_CONFIG_INPUT = 0b011,
+};
+
+enum ad74115_gpio_mode {
+	AD74115_GPIO_MODE_LOGIC = 1,
+	AD74115_GPIO_MODE_SPECIAL = 2,
+};
+
+enum ad74115_regulators {
+	AD74115_AVDD_REGULATOR,
+	AD74115_AVCC_REGULATOR,
+	AD74115_DVCC_REGULATOR,
+	AD74115_ALDO1V8_REGULATOR,
+	AD74115_DOVDD_REGULATOR,
+	AD74115_REFIN_REGULATOR,
+	AD74115_REGULATORS_NUM
+};
+
+struct ad74115_channels {
+	struct iio_chan_spec		*channels;
+	unsigned int			num_channels;
+};
+
+struct ad74115_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct iio_trigger		*trig;
+
+	/*
+	 * Synchronize consecutive operations when doing a one-shot
+	 * conversion and when updating the ADC samples SPI message.
+	 */
+	struct mutex			lock;
+	struct regulator_bulk_data	regulators[AD74115_REGULATORS_NUM];
+	struct gpio_chip		gc;
+	struct gpio_chip		comp_gc;
+
+	unsigned int			avdd_mv;
+	unsigned long			gpio_valid_mask;
+	bool				dac_bipolar;
+	bool				dac_hart_slew;
+	enum ad74115_ch_func		ch_func;
+	enum ad74115_diag_func		diag_func[AD74115_DIAG_NUM];
+	enum ad74115_din_threshold_mode	din_threshold_mode;
+	enum ad74115_rtd_mode		rtd_mode;
+
+	struct completion		adc_data_completion;
+	struct spi_message		adc_samples_msg;
+	struct spi_transfer		adc_samples_xfer[AD74115_ADC_CH_NUM + 1];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8				reg_tx_buf[AD74115_FRAME_SIZE] ____cacheline_aligned;
+	u8				reg_rx_buf[AD74115_FRAME_SIZE];
+	u8				adc_samples_tx_buf[AD74115_FRAME_SIZE * AD74115_ADC_CH_NUM];
+	u8				adc_samples_rx_buf[AD74115_FRAME_SIZE * AD74115_ADC_CH_NUM];
+};
+
+struct ad74115_fw_prop {
+	const char			*name;
+	bool				is_boolean;
+	bool				negate;
+	unsigned int			max;
+	unsigned int			reg;
+	unsigned int			mask;
+	const unsigned int		*lookup_tbl;
+	unsigned int			lookup_tbl_len;
+};
+
+#define AD74115_FW_PROP(_name, _max, _reg, _mask)		\
+{								\
+	.name = (_name),					\
+	.max = (_max),						\
+	.reg = (_reg),						\
+	.mask = (_mask),					\
+}
+
+#define AD74115_FW_PROP_TBL(_name, _tbl, _reg, _mask)		\
+{								\
+	.name = (_name),					\
+	.reg = (_reg),						\
+	.mask = (_mask),					\
+	.lookup_tbl = (_tbl),					\
+	.lookup_tbl_len = ARRAY_SIZE(_tbl),			\
+}
+
+#define AD74115_FW_PROP_BOOL(_name, _reg, _mask)		\
+{								\
+	.name = (_name),					\
+	.is_boolean = true,					\
+	.reg = (_reg),						\
+	.mask = (_mask),					\
+}
+
+#define AD74115_FW_PROP_BOOL_NEG(_name, _reg, _mask)		\
+{								\
+	.name = (_name),					\
+	.is_boolean = true,					\
+	.negate = true,						\
+	.reg = (_reg),						\
+	.mask = (_mask),					\
+}
+
+static const int ad74115_dac_rate_tbl[] = {
+	0,
+	4 * 8,
+	4 * 15,
+	4 * 61,
+	4 * 222,
+	64 * 8,
+	64 * 15,
+	64 * 61,
+	64 * 222,
+	150 * 8,
+	150 * 15,
+	150 * 61,
+	150 * 222,
+	240 * 8,
+	240 * 15,
+	240 * 61,
+	240 * 222,
+};
+
+static const unsigned int ad74115_dac_rate_step_tbl[][3] = {
+	{ AD74115_SLEW_MODE_DISABLED },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_0_8_PERCENT, AD74115_SLEW_RATE_4KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_1_5_PERCENT, AD74115_SLEW_RATE_4KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_6_1_PERCENT, AD74115_SLEW_RATE_4KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_4KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_0_8_PERCENT, AD74115_SLEW_RATE_64KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_1_5_PERCENT, AD74115_SLEW_RATE_64KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_6_1_PERCENT, AD74115_SLEW_RATE_64KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_64KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_0_8_PERCENT, AD74115_SLEW_RATE_150KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_1_5_PERCENT, AD74115_SLEW_RATE_150KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_6_1_PERCENT, AD74115_SLEW_RATE_150KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_150KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_0_8_PERCENT, AD74115_SLEW_RATE_240KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_1_5_PERCENT, AD74115_SLEW_RATE_240KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_6_1_PERCENT, AD74115_SLEW_RATE_240KHZ },
+	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_240KHZ },
+};
+
+static const unsigned int ad74115_dac_slew_rate_hz_tbl[] = {
+	4000, 64000, 150000, 240000
+};
+
+static const unsigned int ad74115_rtd_excitation_current_ua_tbl[] = {
+	250, 500, 750, 1000
+};
+
+static const unsigned int ad74115_burnout_current_na_tbl[] = {
+	0, 50, 0, 500, 1000, 0, 10000, 0
+};
+
+static const unsigned int ad74115_viout_burnout_current_na_tbl[] = {
+	0, 0, 0, 0, 1000, 0, 10000, 0
+};
+
+static const unsigned int ad74115_gpio_mode_tbl[] = {
+	0, 0, 0, 1, 2, 3, 4, 5
+};
+
+static const unsigned int ad74115_adc_conv_rate_tbl[] = {
+	10, 20, 1200, 4800, 9600
+};
+
+static const unsigned int ad74115_adc_conv_diag_rate_tbl[] = {
+	20, 4800, 9600
+};
+
+static const unsigned int ad74115_debounce_tbl[] = {
+	0,     13,    18,    24,    32,    42,    56,    75,
+	100,   130,   180,   240,   320,   420,   560,   750,
+	1000,  1300,  1800,  2400,  3200,  4200,  5600,  7500,
+	10000, 13000, 18000, 24000, 32000, 42000, 56000, 75000,
+};
+
+static const unsigned int ad74115_adc_ch_data_regs[] = {
+	[AD74115_ADC_CH_CONV1] = 0x44,
+	[AD74115_ADC_CH_CONV2] = 0x46,
+	[AD74115_ADC_CH_DIAG0] = 0x53,
+	[AD74115_ADC_CH_DIAG1] = 0x54,
+	[AD74115_ADC_CH_DIAG2] = 0x55,
+	[AD74115_ADC_CH_DIAG3] = 0x56,
+};
+
+static const unsigned int ad74115_adc_ch_en_bit[] = {
+	[AD74115_ADC_CH_CONV1] = BIT(0),
+	[AD74115_ADC_CH_CONV2] = BIT(1),
+	[AD74115_ADC_CH_DIAG0] = BIT(8),
+	[AD74115_ADC_CH_DIAG1] = BIT(9),
+	[AD74115_ADC_CH_DIAG2] = BIT(10),
+	[AD74115_ADC_CH_DIAG3] = BIT(11),
+};
+
+#define AD74115_ADC_MINUS_20_TO_30_OFFSET	(-AD74115_ADC_CODE_MAX * 2 / 5)
+
+static const int ad74115_diag_func_offset[AD74115_DIAG_FUNC_NUM] = {
+	[AD74115_DIAG_FUNC_SENSEL]		= AD74115_ADC_MINUS_20_TO_30_OFFSET,
+	[AD74115_DIAG_FUNC_SENSE_EXT1]		= AD74115_ADC_MINUS_20_TO_30_OFFSET,
+	[AD74115_DIAG_FUNC_SENSE_EXT2]		= AD74115_ADC_MINUS_20_TO_30_OFFSET,
+};
+
+static const int ad74115_diag_func_mul[AD74115_DIAG_FUNC_NUM] = {
+	[AD74115_DIAG_FUNC_AGND]		= 2500,
+	[AD74115_DIAG_FUNC_AVDD]		= 50000,
+	[AD74115_DIAG_FUNC_DLDO1V8]		= 7500,
+	[AD74115_DIAG_FUNC_AVSS]		= 31017,
+	[AD74115_DIAG_FUNC_REFOUT]		= 3125,
+	[AD74115_DIAG_FUNC_AVCC]		= 17500,
+	[AD74115_DIAG_FUNC_ALDO1V8]		= 5825,
+	[AD74115_DIAG_FUNC_DVCC]		= 8250,
+	[AD74115_DIAG_FUNC_SENSEL]		= 50000,
+	[AD74115_DIAG_FUNC_LVIN]		= 2500,
+	[AD74115_DIAG_FUNC_SENSE_EXT1]		= 50000,
+	[AD74115_DIAG_FUNC_SENSE_EXT2]		= 50000,
+	[AD74115_DIAG_FUNC_DO_VDD]		= 49200,
+};
+
+static const bool ad74115_adc_bipolar[AD74115_ADC_RANGE_NUM] = {
+	[AD74115_ADC_RANGE_12V_BIPOLAR]		= true,
+	[AD74115_ADC_RANGE_2_5V_BIPOLAR]	= true,
+	[AD74115_ADC_RANGE_104MV_BIPOLAR]	= true,
+};
+
+static const int ad74115_adc_conv_mul[AD74115_ADC_RANGE_NUM] = {
+	[AD74115_ADC_RANGE_12V]			= 12000,
+	[AD74115_ADC_RANGE_12V_BIPOLAR]		= 24000,
+	[AD74115_ADC_RANGE_2_5V_BIPOLAR]	= 5000,
+	[AD74115_ADC_RANGE_2_5V_NEG]		= 2500,
+	[AD74115_ADC_RANGE_2_5V]		= 2500,
+	[AD74115_ADC_RANGE_0_625V]		= 625,
+	[AD74115_ADC_RANGE_104MV_BIPOLAR]	= 208,
+	[AD74115_ADC_RANGE_12V_OTHER]		= 12000,
+};
+
+static const int AD74115_adc_gain[AD74115_ADC_RANGE_NUM][2] = {
+	[AD74115_ADC_RANGE_12V]			= { 5, 24 },
+	[AD74115_ADC_RANGE_12V_BIPOLAR]		= { 5, 24 },
+	[AD74115_ADC_RANGE_2_5V_BIPOLAR]	= { 1, 1 },
+	[AD74115_ADC_RANGE_2_5V_NEG]		= { 1, 1 },
+	[AD74115_ADC_RANGE_2_5V]		= { 1, 1 },
+	[AD74115_ADC_RANGE_0_625V]		= { 4, 1 },
+	[AD74115_ADC_RANGE_104MV_BIPOLAR]	= { 24, 1 },
+	[AD74115_ADC_RANGE_12V_OTHER]		= { 5, 24 },
+};
+
+static int _ad74115_find_tbl_index(const unsigned int *tbl, unsigned int tbl_len,
+				   unsigned int val, unsigned int *index)
+{
+	unsigned int i;
+
+	for (i = 0; i < tbl_len; i++)
+		if (val == tbl[i]) {
+			*index = i;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+#define ad74115_find_tbl_index(tbl, val, index)	\
+	_ad74115_find_tbl_index(tbl, ARRAY_SIZE(tbl), val, index)
+
+static int ad74115_crc(u8 *buf)
+{
+	return crc8(ad74115_crc8_table, buf, 3, 0);
+}
+
+static void ad74115_format_reg_write(u8 reg, u16 val, u8 *buf)
+{
+	buf[0] = reg;
+	put_unaligned_be16(val, &buf[1]);
+	buf[3] = ad74115_crc(buf);
+}
+
+static int ad74115_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad74115_state *st = context;
+
+	ad74115_format_reg_write(reg, val, st->reg_tx_buf);
+
+	return spi_write(st->spi, st->reg_tx_buf, AD74115_FRAME_SIZE);
+}
+
+static int ad74115_crc_check(struct ad74115_state *st, u8 *buf)
+{
+	struct device *dev = &st->spi->dev;
+	u8 expected_crc = ad74115_crc(buf);
+
+	if (buf[3] != expected_crc) {
+		dev_err(dev, "Bad CRC %02x for %02x%02x%02x, expected %02x\n",
+			buf[3], buf[0], buf[1], buf[2], expected_crc);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad74115_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad74115_state *st = context;
+	struct spi_transfer reg_read_xfer[] = {
+		{
+			.tx_buf = st->reg_tx_buf,
+			.len = sizeof(st->reg_tx_buf),
+			.cs_change = 1,
+		},
+		{
+			.rx_buf = st->reg_rx_buf,
+			.len = sizeof(st->reg_rx_buf),
+		},
+	};
+	int ret;
+
+	ad74115_format_reg_write(AD74115_READ_SELECT_REG, reg, st->reg_tx_buf);
+
+	ret = spi_sync_transfer(st->spi, reg_read_xfer, ARRAY_SIZE(reg_read_xfer));
+	if (ret)
+		return ret;
+
+	ret = ad74115_crc_check(st, st->reg_rx_buf);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(&st->reg_rx_buf[1]);
+
+	return 0;
+}
+
+static const struct regmap_config ad74115_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.reg_read = ad74115_reg_read,
+	.reg_write = ad74115_reg_write,
+};
+
+static int ad74115_gpio_config_set(struct ad74115_state *st, unsigned int offset,
+				   enum ad74115_gpio_config cfg)
+{
+	return regmap_update_bits(st->regmap, AD74115_GPIO_CONFIG_X_REG(offset),
+				  AD74115_GPIO_CONFIG_SELECT_MASK,
+				  FIELD_PREP(AD74115_GPIO_CONFIG_SELECT_MASK, cfg));
+}
+
+static int ad74115_gpio_init_valid_mask(struct gpio_chip *gc,
+					unsigned long *valid_mask,
+					unsigned int ngpios)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+
+	*valid_mask = st->gpio_valid_mask;
+
+	return 0;
+}
+
+static int ad74115_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_GPIO_CONFIG_X_REG(offset), &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD74115_GPIO_CONFIG_SELECT_MASK, val) == AD74115_GPIO_CONFIG_INPUT;
+}
+
+static int ad74115_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+
+	return ad74115_gpio_config_set(st, offset, AD74115_GPIO_CONFIG_INPUT);
+}
+
+static int ad74115_gpio_direction_output(struct gpio_chip *gc, unsigned int offset,
+					 int value)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+
+	return ad74115_gpio_config_set(st, offset, AD74115_GPIO_CONFIG_OUTPUT_BUFFERED);
+}
+
+static int ad74115_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_GPIO_CONFIG_X_REG(offset), &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD74115_GPIO_CONFIG_GPI_DATA, val);
+}
+
+static void ad74115_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct ad74115_state *st = gpiochip_get_data(gc);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD74115_GPIO_CONFIG_X_REG(offset),
+				 AD74115_GPIO_CONFIG_GPO_DATA,
+				 FIELD_PREP(AD74115_GPIO_CONFIG_GPO_DATA, value));
+	if (ret)
+		dev_err(dev, "Failed to set GPIO %u output value, err: %d\n",
+			offset, ret);
+}
+
+static int ad74115_set_comp_debounce(struct ad74115_state *st, unsigned int val)
+{
+	unsigned int len = ARRAY_SIZE(ad74115_debounce_tbl);
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		if (val <= ad74115_debounce_tbl[i])
+			break;
+
+	if (i == len)
+		i = len - 1;
+
+	return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG1_REG,
+				  AD74115_DIN_DEBOUNCE_MASK,
+				  FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, val));
+}
+
+static int ad74115_comp_gpio_get_direction(struct gpio_chip *chip,
+					   unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int ad74115_comp_gpio_set_config(struct gpio_chip *chip,
+					unsigned int offset,
+					unsigned long config)
+{
+	struct ad74115_state *st = gpiochip_get_data(chip);
+	u32 param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
+
+	switch (param) {
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return ad74115_set_comp_debounce(st, arg);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int ad74115_comp_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ad74115_state *st = gpiochip_get_data(chip);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_DIN_COMP_OUT_REG, &val);
+	if (ret)
+		return ret;
+
+	return !!val;
+}
+
+static irqreturn_t ad74115_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad74115_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = spi_sync(st->spi, &st->adc_samples_msg);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers(indio_dev, st->adc_samples_rx_buf);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad74115_adc_data_interrupt(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ad74115_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+	else
+		complete(&st->adc_data_completion);
+
+	return IRQ_HANDLED;
+}
+
+static int ad74115_set_adc_ch_en(struct ad74115_state *st,
+				 enum ad74115_adc_ch channel, bool status)
+{
+	unsigned int mask = ad74115_adc_ch_en_bit[channel];
+
+	return regmap_update_bits(st->regmap, AD74115_ADC_CONV_CTRL_REG, mask,
+				  status ? mask : 0);
+}
+
+static int ad74115_set_adc_conv_seq(struct ad74115_state *st,
+				    enum ad74115_adc_conv_seq conv_seq)
+{
+	return regmap_update_bits(st->regmap, AD74115_ADC_CONV_CTRL_REG,
+				  AD74115_ADC_CONV_SEQ_MASK,
+				  FIELD_PREP(AD74115_ADC_CONV_SEQ_MASK, conv_seq));
+}
+
+static int ad74115_update_scan_mode(struct iio_dev *indio_dev,
+				    const unsigned long *active_scan_mask)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	struct spi_transfer *xfer = st->adc_samples_xfer;
+	u8 *rx_buf = st->adc_samples_rx_buf;
+	u8 *tx_buf = st->adc_samples_tx_buf;
+	unsigned int i;
+	int ret = 0;
+
+	mutex_lock(&st->lock);
+
+	spi_message_init(&st->adc_samples_msg);
+
+	for_each_clear_bit(i, active_scan_mask, AD74115_ADC_CH_NUM) {
+		ret = ad74115_set_adc_ch_en(st, i, false);
+		if (ret)
+			goto out;
+	}
+
+	/*
+	 * The read select register is used to select which register's value
+	 * will be sent by the slave on the next SPI frame.
+	 *
+	 * Create an SPI message that, on each step, writes to the read select
+	 * register to select the ADC result of the next enabled channel, and
+	 * reads the ADC result of the previous enabled channel.
+	 *
+	 * Example:
+	 * W: [WCH1] [WCH2] [WCH2] [WCH3] [    ]
+	 * R: [    ] [RCH1] [RCH2] [RCH3] [RCH4]
+	 */
+	for_each_set_bit(i, active_scan_mask, AD74115_ADC_CH_NUM) {
+		ret = ad74115_set_adc_ch_en(st, i, true);
+		if (ret)
+			goto out;
+
+		if (xfer == st->adc_samples_xfer)
+			xfer->rx_buf = NULL;
+		else
+			xfer->rx_buf = rx_buf;
+
+		xfer->tx_buf = tx_buf;
+		xfer->len = AD74115_FRAME_SIZE;
+		xfer->cs_change = 1;
+
+		ad74115_format_reg_write(AD74115_READ_SELECT_REG,
+					 ad74115_adc_ch_data_regs[i], tx_buf);
+
+		spi_message_add_tail(xfer, &st->adc_samples_msg);
+
+		tx_buf += AD74115_FRAME_SIZE;
+		if (xfer != st->adc_samples_xfer)
+			rx_buf += AD74115_FRAME_SIZE;
+		xfer++;
+	}
+
+	xfer->rx_buf = rx_buf;
+	xfer->tx_buf = NULL;
+	xfer->len = AD74115_FRAME_SIZE;
+	xfer->cs_change = 0;
+
+	spi_message_add_tail(xfer, &st->adc_samples_msg);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad74115_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+
+	return ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_CONTINUOUS);
+}
+
+static int ad74115_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_STANDBY);
+	if (ret)
+		goto out;
+
+	/*
+	 * update_scan_mode() is not called in the disable path, disable all
+	 * channels here.
+	 */
+	for (i = 0; i < AD74115_ADC_CH_NUM; i++) {
+		ret = ad74115_set_adc_ch_en(st, i, false);
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
+static const struct iio_buffer_setup_ops ad74115_buffer_ops = {
+	.postenable = &ad74115_buffer_postenable,
+	.predisable = &ad74115_buffer_predisable,
+};
+
+static const struct iio_trigger_ops ad74115_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static bool ad74115_is_diag_channel(enum ad74115_adc_ch channel)
+{
+	return channel >= AD74115_ADC_CH_DIAG0 && channel <= AD74115_ADC_CH_DIAG3;
+}
+
+static int _ad74115_get_adc_code(struct ad74115_state *st,
+				 enum ad74115_adc_ch channel, int *val)
+{
+	unsigned int uval;
+	int ret;
+
+	reinit_completion(&st->adc_data_completion);
+
+	ret = ad74115_set_adc_ch_en(st, channel, true);
+	if (ret)
+		return ret;
+
+	ret = ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_SINGLE);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&st->adc_data_completion,
+					  msecs_to_jiffies(1000));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		return ret;
+	}
+
+	ret = regmap_read(st->regmap, ad74115_adc_ch_data_regs[channel], &uval);
+	if (ret)
+		return ret;
+
+	ret = ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_STANDBY);
+	if (ret)
+		return ret;
+
+	ret = ad74115_set_adc_ch_en(st, channel, false);
+	if (ret)
+		return ret;
+
+	*val = uval;
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_get_adc_code(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	ret = _ad74115_get_adc_code(st, chan->channel, val);
+	mutex_unlock(&st->lock);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad74115_adc_code_to_resistance(int code, int *val, int *val2)
+{
+	if (code == AD74115_ADC_CODE_MAX)
+		code--;
+
+	*val = code * AD74115_REF_RESISTOR_OHMS;
+	*val2 = AD74115_ADC_CODE_MAX - code;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad74115_set_dac_code(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int val)
+{
+	if (val < 0)
+		return -EINVAL;
+
+	if (chan->channel == AD74115_DAC_CH_COMPARATOR) {
+		if (val > AD74115_COMP_THRESH_MAX)
+			return -EINVAL;
+
+		return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG2_REG,
+					  AD74115_COMP_THRESH_MASK,
+					  FIELD_PREP(AD74115_COMP_THRESH_MASK, val));
+	}
+
+	if (val > AD74115_DAC_CODE_MAX)
+		return -EINVAL;
+
+	return regmap_write(st->regmap, AD74115_DAC_CODE_REG, val);
+}
+
+static int ad74115_get_dac_code(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int *val)
+{
+	unsigned int uval;
+	int ret;
+
+	if (chan->channel == AD74115_DAC_CH_COMPARATOR)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AD74115_DAC_ACTIVE_REG, &uval);
+	if (ret)
+		return ret;
+
+	*val = uval;
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_get_adc_rate(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int *val)
+{
+	unsigned int i;
+	int ret;
+
+	if (ad74115_is_diag_channel(chan->channel)) {
+		ret = regmap_read(st->regmap, AD74115_ADC_CONV_CTRL_REG, &i);
+		if (ret)
+			return ret;
+
+		i = FIELD_GET(AD74115_ADC_CONV_RATE_DIAG_MASK, i);
+
+		*val = ad74115_adc_conv_diag_rate_tbl[i];
+
+		return IIO_VAL_INT;
+	}
+
+	ret = regmap_read(st->regmap, AD74115_ADC_CONFIG_REG, &i);
+	if (ret)
+		return ret;
+
+	if (chan->channel == AD74115_ADC_CH_CONV1)
+		i = FIELD_GET(AD74115_ADC_CONFIG_CONV1_RATE_MASK, i);
+	else
+		i = FIELD_GET(AD74115_ADC_CONFIG_CONV2_RATE_MASK, i);
+
+	*val = ad74115_adc_conv_rate_tbl[i];
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_set_adc_rate(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int val)
+{
+	unsigned int i;
+	int ret;
+
+	if (ad74115_is_diag_channel(chan->channel)) {
+		ret = ad74115_find_tbl_index(ad74115_adc_conv_diag_rate_tbl, val, &i);
+		if (ret)
+			return ret;
+
+		return regmap_update_bits(st->regmap, AD74115_ADC_CONV_CTRL_REG,
+					  AD74115_ADC_CONV_RATE_DIAG_MASK,
+					  FIELD_PREP(AD74115_ADC_CONV_RATE_DIAG_MASK, i));
+	}
+
+	ret = ad74115_find_tbl_index(ad74115_adc_conv_rate_tbl, val, &i);
+	if (ret)
+		return ret;
+
+	if (chan->channel == AD74115_ADC_CH_CONV1)
+		return regmap_update_bits(st->regmap, AD74115_ADC_CONFIG_REG,
+					  AD74115_ADC_CONFIG_CONV1_RATE_MASK,
+					  FIELD_PREP(AD74115_ADC_CONFIG_CONV1_RATE_MASK, i));
+
+	return regmap_update_bits(st->regmap, AD74115_ADC_CONFIG_REG,
+				  AD74115_ADC_CONFIG_CONV2_RATE_MASK,
+				  FIELD_PREP(AD74115_ADC_CONFIG_CONV2_RATE_MASK, i));
+}
+
+static int ad74115_get_dac_rate(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int *val)
+{
+	unsigned int i, en_val, step_val, rate_val, tmp;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_OUTPUT_CONFIG_REG, &tmp);
+	if (ret)
+		return ret;
+
+	en_val = FIELD_GET(AD74115_OUTPUT_SLEW_EN_MASK, tmp);
+	step_val = FIELD_GET(AD74115_OUTPUT_SLEW_LIN_STEP_MASK, tmp);
+	rate_val = FIELD_GET(AD74115_OUTPUT_SLEW_LIN_RATE_MASK, tmp);
+
+	for (i = 0; i < ARRAY_SIZE(ad74115_dac_rate_step_tbl); i++)
+		if (en_val == ad74115_dac_rate_step_tbl[i][0] &&
+		    step_val == ad74115_dac_rate_step_tbl[i][1] &&
+		    rate_val == ad74115_dac_rate_step_tbl[i][2])
+			break;
+
+	if (i == ARRAY_SIZE(ad74115_dac_rate_step_tbl))
+		return -EINVAL;
+
+	*val = ad74115_dac_rate_tbl[i];
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_set_dac_rate(struct ad74115_state *st,
+				struct iio_chan_spec const *chan, int val)
+{
+	unsigned int i, en_val, step_val, rate_val, mask, tmp;
+	int ret;
+
+	ret = ad74115_find_tbl_index(ad74115_dac_rate_tbl, val, &i);
+	if (ret)
+		return ret;
+
+	en_val = ad74115_dac_rate_step_tbl[i][0];
+	step_val = ad74115_dac_rate_step_tbl[i][1];
+	rate_val = ad74115_dac_rate_step_tbl[i][2];
+
+	mask = AD74115_OUTPUT_SLEW_EN_MASK;
+	mask |= AD74115_OUTPUT_SLEW_LIN_STEP_MASK;
+	mask |= AD74115_OUTPUT_SLEW_LIN_RATE_MASK;
+
+	tmp = FIELD_PREP(AD74115_OUTPUT_SLEW_EN_MASK, en_val);
+	tmp |= FIELD_PREP(AD74115_OUTPUT_SLEW_LIN_STEP_MASK, step_val);
+	tmp |= FIELD_PREP(AD74115_OUTPUT_SLEW_LIN_RATE_MASK, rate_val);
+
+	return regmap_update_bits(st->regmap, AD74115_OUTPUT_CONFIG_REG, mask, tmp);
+}
+
+static int ad74115_get_diag_scale(struct ad74115_state *st,
+				  struct iio_chan_spec const *chan,
+				  int *val, int *val2)
+{
+	unsigned int i = AD74115_CHANNEL_TO_DIAG_X(chan->channel);
+	enum ad74115_diag_func func = st->diag_func[i];
+
+	if (func == AD74115_DIAG_FUNC_SINK_OR_SOURCE_CURRENT) {
+		switch (chan->channel) {
+		case AD74115_ADC_CH_DIAG0:
+			*val = 2500;
+			*val2 = AD74115_ADC_CODE_MAX;
+			return IIO_VAL_FRACTIONAL;
+		case AD74115_ADC_CH_DIAG1:
+			*val = 3125;
+			*val2 = AD74115_ADC_CODE_MAX * 10;
+			return IIO_VAL_FRACTIONAL;
+		case AD74115_ADC_CH_DIAG2:
+			*val = 2500 * 100;
+			*val2 = AD74115_ADC_CODE_MAX * 138;
+			return IIO_VAL_FRACTIONAL;
+		case AD74115_ADC_CH_DIAG3:
+			*val = 3125 * 100;
+			*val2 = AD74115_ADC_CODE_MAX * 10 * 138;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (func == AD74115_DIAG_FUNC_SENSEL &&
+	    st->din_threshold_mode == AD74115_DIN_THRESHOLD_MODE_AVDD) {
+		*val = 60000;
+		*val2 = AD74115_ADC_CODE_MAX;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	if (func == AD74115_DIAG_FUNC_TEMP) {
+		*val = 1000 * 100;
+		*val2 = 895;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	*val = ad74115_diag_func_mul[func];
+	*val2 = AD74115_ADC_CODE_MAX;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad74115_get_diag_offset(struct ad74115_state *st,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2)
+{
+	unsigned int i = AD74115_CHANNEL_TO_DIAG_X(chan->channel);
+	enum ad74115_diag_func func = st->diag_func[i];
+
+	if (func == AD74115_DIAG_FUNC_SENSEL &&
+	    st->din_threshold_mode == AD74115_DIN_THRESHOLD_MODE_AVDD) {
+		*val = -st->avdd_mv * AD74115_ADC_CODE_MAX;
+		*val2 = 60000;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	if (func == AD74115_DIAG_FUNC_AVSS) {
+		*val = -20000 * AD74115_ADC_CODE_MAX;
+		*val2 = 31017;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	if (func == AD74115_DIAG_FUNC_TEMP) {
+		*val = -2034 * 100 - 40 * 895;
+		*val2 = 100;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	*val = ad74115_diag_func_offset[func];
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_get_dac_scale(struct ad74115_state *st,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2)
+{
+	if (chan->channel == AD74115_DAC_CH_MAIN) {
+		if (chan->type == IIO_VOLTAGE) {
+			*val = AD74115_DAC_VOLTAGE_MAX;
+
+			if (st->dac_bipolar)
+				*val *= 2;
+
+		} else {
+			*val = AD74115_DAC_CURRENT_MAX;
+		}
+
+		*val2 = AD74115_DAC_CODE_MAX;
+	} else {
+		if (st->din_threshold_mode == AD74115_DIN_THRESHOLD_MODE_AVDD) {
+			*val = 196 * st->avdd_mv;
+			*val2 = 10 * AD74115_COMP_THRESH_MAX;
+		} else {
+			*val = 49000;
+			*val2 = AD74115_COMP_THRESH_MAX;
+		}
+	}
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad74115_get_dac_offset(struct ad74115_state *st,
+				  struct iio_chan_spec const *chan, int *val)
+{
+	if (chan->channel == AD74115_DAC_CH_MAIN) {
+		if (chan->type == IIO_VOLTAGE && st->dac_bipolar)
+			*val = -AD74115_DAC_CODE_HALF;
+		else
+			*val = 0;
+	} else {
+		if (st->din_threshold_mode == AD74115_DIN_THRESHOLD_MODE_AVDD)
+			*val = -48;
+		else
+			*val = -38;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_get_adc_range(struct ad74115_state *st,
+				 enum ad74115_adc_ch channel, unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_ADC_CONFIG_REG, val);
+	if (ret)
+		return ret;
+
+	if (channel == AD74115_ADC_CH_CONV1)
+		*val = FIELD_GET(AD74115_ADC_CONFIG_CONV1_RANGE_MASK, *val);
+	else
+		*val = FIELD_GET(AD74115_ADC_CONFIG_CONV2_RANGE_MASK, *val);
+
+	return 0;
+}
+
+static int ad74115_get_adc_scale(struct ad74115_state *st,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2)
+{
+	unsigned int range;
+	int ret;
+
+	ret = ad74115_get_adc_range(st, chan->channel, &range);
+	if (ret)
+		return ret;
+
+	if (chan->type == IIO_RESISTANCE) {
+		*val = AD74115_adc_gain[range][1] * AD74115_REF_RESISTOR_OHMS;
+		*val2 = AD74115_adc_gain[range][0];
+
+		if (ad74115_adc_bipolar[range])
+			*val2 *= AD74115_ADC_CODE_HALF;
+		else
+			*val2 *= AD74115_ADC_CODE_MAX;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	*val = ad74115_adc_conv_mul[range];
+	*val2 = AD74115_ADC_CODE_MAX;
+
+	if (chan->type == IIO_CURRENT)
+		*val2 *= AD74115_SENSE_RESISTOR_OHMS;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad74115_get_adc_offset(struct ad74115_state *st,
+				  struct iio_chan_spec const *chan, int *val)
+{
+	unsigned int range;
+	int ret;
+
+	ret = ad74115_get_adc_range(st, chan->channel, &range);
+	if (ret)
+		return ret;
+
+	if (chan->type == IIO_RESISTANCE) {
+		*val = 5;
+
+		if (ad74115_adc_bipolar[range])
+			*val -= AD74115_ADC_CODE_HALF;
+
+		if (st->rtd_mode == AD74115_RTD_MODE_3_WIRE) {
+			/* Add 0.2 Ohm to the final result for 3-wire RTD. */
+			unsigned int m = 2 * AD74115_adc_gain[range][0];
+			unsigned int d = 10 * AD74115_REF_RESISTOR_OHMS
+					 * AD74115_adc_gain[range][1];
+
+			if (ad74115_adc_bipolar[range])
+				m *= AD74115_ADC_CODE_HALF;
+			else
+				m *= AD74115_ADC_CODE_MAX;
+
+			*val += DIV_ROUND_CLOSEST(m, d);
+		}
+	} else if (ad74115_adc_bipolar[range]) {
+		*val = -AD74115_ADC_CODE_HALF;
+	} else if (range == AD74115_ADC_RANGE_2_5V_NEG) {
+		*val = -AD74115_ADC_CODE_MAX;
+	} else {
+		*val = 0;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ad74115_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		if (ad74115_is_diag_channel(chan->channel))
+			return ad74115_get_diag_scale(st, chan, val, val2);
+		else if (chan->output)
+			return ad74115_get_dac_scale(st, chan, val, val2);
+
+		return ad74115_get_adc_scale(st, chan, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		if (ad74115_is_diag_channel(chan->channel))
+			return ad74115_get_diag_offset(st, chan, val, val2);
+		else if (chan->output)
+			return ad74115_get_dac_offset(st, chan, val);
+
+		return ad74115_get_adc_offset(st, chan, val);
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output)
+			return ad74115_get_dac_code(st, chan, val);
+
+		return ad74115_get_adc_code(indio_dev, chan, val);
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = ad74115_get_adc_code(indio_dev, chan, val);
+		if (ret)
+			return ret;
+
+		return ad74115_adc_code_to_resistance(*val, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (chan->output)
+			return ad74115_get_dac_rate(st, chan, val);
+
+		return ad74115_get_adc_rate(st, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad74115_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val, int val2,
+			     long info)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (!chan->output)
+			return -EINVAL;
+
+		return ad74115_set_dac_code(st, chan, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (chan->output)
+			return ad74115_set_dac_rate(st, chan, val);
+
+		return ad74115_set_adc_rate(st, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad74115_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (ad74115_is_diag_channel(chan->channel)) {
+			*vals = ad74115_adc_conv_diag_rate_tbl;
+			*length = ARRAY_SIZE(ad74115_adc_conv_diag_rate_tbl);
+		} else if (chan->output) {
+			*vals = ad74115_dac_rate_tbl;
+			*length = ARRAY_SIZE(ad74115_dac_rate_tbl);
+		} else {
+			*vals = ad74115_adc_conv_rate_tbl;
+			*length = ARRAY_SIZE(ad74115_adc_conv_rate_tbl);
+		}
+
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad74115_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ad74115_info = {
+	.read_raw = ad74115_read_raw,
+	.write_raw = ad74115_write_raw,
+	.read_avail = ad74115_read_avail,
+	.update_scan_mode = ad74115_update_scan_mode,
+	.debugfs_reg_access = ad74115_reg_access,
+};
+
+#define AD74115_DAC_CHANNEL(_type, index)				\
+	{								\
+		.type = (_type),					\
+		.channel = (index),					\
+		.indexed = 1,						\
+		.output = 1,						\
+		.scan_index = -1,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
+				      | BIT(IIO_CHAN_INFO_SCALE)	\
+				      | BIT(IIO_CHAN_INFO_OFFSET),	\
+	}
+
+#define _AD74115_ADC_CHANNEL(_type, index, extra_mask_separate)		\
+	{								\
+		.type = (_type),					\
+		.channel = (index),					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
+				      | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				      | (extra_mask_separate),		\
+		.info_mask_separate_available =				\
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = 16,					\
+			.storagebits = 32,				\
+			.shift = 8,					\
+			.endianness = IIO_BE,				\
+		},							\
+	}
+
+#define AD74115_ADC_CHANNEL(_type, index)				\
+	_AD74115_ADC_CHANNEL(_type, index, BIT(IIO_CHAN_INFO_SCALE)	\
+					   | BIT(IIO_CHAN_INFO_OFFSET))
+
+static struct iio_chan_spec ad74115_voltage_input_channels[] = {
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_voltage_output_channels[] = {
+	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_MAIN),
+	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_current_input_channels[] = {
+	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_current_output_channels[] = {
+	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_2_wire_resistance_input_channels[] = {
+	_AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1,
+			     BIT(IIO_CHAN_INFO_PROCESSED)),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_3_4_wire_resistance_input_channels[] = {
+	AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_digital_input_logic_channels[] = {
+	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_digital_input_loop_channels[] = {
+	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
+	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
+};
+
+static struct iio_chan_spec ad74115_diag_voltage_channel =
+	AD74115_ADC_CHANNEL(IIO_VOLTAGE, 0);
+
+static struct iio_chan_spec ad74115_diag_current_channel =
+	AD74115_ADC_CHANNEL(IIO_CURRENT, 0);
+
+static struct iio_chan_spec ad74115_diag_temperature_channel =
+	AD74115_ADC_CHANNEL(IIO_TEMP, 0);
+
+#define _AD74115_CHANNELS(_channels)			\
+	{						\
+		.channels = _channels,			\
+		.num_channels = ARRAY_SIZE(_channels),	\
+	}
+
+#define AD74115_CHANNELS(name) \
+	_AD74115_CHANNELS(ad74115_ ## name ## _channels)
+
+static const struct ad74115_channels ad74115_channels_map[AD74115_CH_FUNC_NUM] = {
+	[AD74115_CH_FUNC_HIGH_IMPEDANCE] = AD74115_CHANNELS(voltage_input),
+	[AD74115_CH_FUNC_VOLTAGE_INPUT] = AD74115_CHANNELS(voltage_input),
+
+	[AD74115_CH_FUNC_VOLTAGE_OUTPUT] = AD74115_CHANNELS(voltage_output),
+
+	[AD74115_CH_FUNC_CURRENT_INPUT_EXT_POWER] = AD74115_CHANNELS(current_input),
+	[AD74115_CH_FUNC_CURRENT_INPUT_LOOP_POWER] = AD74115_CHANNELS(current_input),
+	[AD74115_CH_FUNC_CURRENT_INPUT_EXT_POWER_HART] = AD74115_CHANNELS(current_input),
+	[AD74115_CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART] = AD74115_CHANNELS(current_input),
+
+	[AD74115_CH_FUNC_CURRENT_OUTPUT] = AD74115_CHANNELS(current_output),
+	[AD74115_CH_FUNC_CURRENT_OUTPUT_HART] = AD74115_CHANNELS(current_output),
+
+	[AD74115_CH_FUNC_2_WIRE_RESISTANCE_INPUT] = AD74115_CHANNELS(2_wire_resistance_input),
+	[AD74115_CH_FUNC_3_4_WIRE_RESISTANCE_INPUT] = AD74115_CHANNELS(3_4_wire_resistance_input),
+
+	[AD74115_CH_FUNC_DIGITAL_INPUT_LOGIC] = AD74115_CHANNELS(digital_input_logic),
+
+	[AD74115_CH_FUNC_DIGITAL_INPUT_LOOP_POWER] = AD74115_CHANNELS(digital_input_loop),
+};
+
+#define AD74115_GPIO_MODE_FW_PROP(i)					\
+{									\
+	.name = "adi,gpio" __stringify(i) "-mode",			\
+	.reg = AD74115_GPIO_CONFIG_X_REG(i),				\
+	.mask = AD74115_GPIO_CONFIG_SELECT_MASK,			\
+	.lookup_tbl = ad74115_gpio_mode_tbl,				\
+	.lookup_tbl_len = ARRAY_SIZE(ad74115_gpio_mode_tbl),		\
+}
+
+static const struct ad74115_fw_prop ad74115_gpio_mode_fw_props[] = {
+	AD74115_GPIO_MODE_FW_PROP(0),
+	AD74115_GPIO_MODE_FW_PROP(1),
+	AD74115_GPIO_MODE_FW_PROP(2),
+	AD74115_GPIO_MODE_FW_PROP(3),
+};
+
+#define AD74115_DIAG_FUNC_FW_PROP(i)					\
+{									\
+	.name = "adi,diag" __stringify(i) "-func",			\
+	.max = AD74115_DIAG_FUNC_MAX,					\
+	.reg = AD74115_DIAG_ASSIGN_REG,					\
+	.mask = AD74115_DIAG_ASSIGN_X_MASK(i),				\
+}
+
+static const struct ad74115_fw_prop ad74115_diag_func_fw_props[] = {
+	AD74115_DIAG_FUNC_FW_PROP(0),
+	AD74115_DIAG_FUNC_FW_PROP(1),
+	AD74115_DIAG_FUNC_FW_PROP(2),
+	AD74115_DIAG_FUNC_FW_PROP(3),
+};
+
+static const struct ad74115_fw_prop ad74115_din_threshold_mode_fw_prop =
+	AD74115_FW_PROP("adi,digital-input-threshold-mode", AD74115_DIN_THRESHOLD_MODE_MAX,
+			AD74115_DIN_CONFIG2_REG, BIT(7));
+
+static const struct ad74115_fw_prop ad74115_dac_bipolar_fw_prop =
+	AD74115_FW_PROP_BOOL("adi,dac-bipolar", AD74115_OUTPUT_CONFIG_REG, BIT(7));
+
+static const struct ad74115_fw_prop ad74115_ch_func_fw_prop =
+	AD74115_FW_PROP("adi,ch-func", AD74115_CH_FUNC_MAX,
+			AD74115_CH_FUNC_SETUP_REG, GENMASK(3, 0));
+
+static const struct ad74115_fw_prop ad74115_rtd_mode_fw_prop =
+	AD74115_FW_PROP("adi,rtd-mode", AD74115_RTD_MODE_MAX,
+			AD74115_RTD3W4W_CONFIG_REG, BIT(3));
+
+static const struct ad74115_fw_prop ad74115_dac_hart_slew_prop =
+	AD74115_FW_PROP_BOOL("adi,dac-hart-slew", 0, 0);
+
+static const struct ad74115_fw_prop ad74115_fw_props[] = {
+	AD74115_FW_PROP("adi,conv2-range", AD74115_ADC_RANGE_MAX,
+			AD74115_ADC_CONFIG_REG, GENMASK(9, 7)),
+	AD74115_FW_PROP("adi,conv2-mux", 3,
+			AD74115_ADC_CONFIG_REG, GENMASK(3, 2)),
+
+	AD74115_FW_PROP_BOOL_NEG("adi,sense-agnd-buffer-lp",
+				 AD74115_PWR_OPTIM_CONFIG_REG, BIT(4)),
+	AD74115_FW_PROP_BOOL_NEG("adi,lf-buffer-lp",
+				 AD74115_PWR_OPTIM_CONFIG_REG, BIT(3)),
+	AD74115_FW_PROP_BOOL_NEG("adi,hf-buffer-lp",
+				 AD74115_PWR_OPTIM_CONFIG_REG, BIT(2)),
+	AD74115_FW_PROP_BOOL_NEG("adi,ext2-buffer-lp",
+				 AD74115_PWR_OPTIM_CONFIG_REG, BIT(1)),
+	AD74115_FW_PROP_BOOL_NEG("adi,ext1-buffer-lp",
+				 AD74115_PWR_OPTIM_CONFIG_REG, BIT(0)),
+
+	AD74115_FW_PROP_BOOL("adi,comparator-invert-en",
+			     AD74115_DIN_CONFIG1_REG, BIT(14)),
+	AD74115_FW_PROP("adi,digital-input-range", 1,
+			AD74115_DIN_CONFIG1_REG, BIT(12)),
+	AD74115_FW_PROP("adi,digital-input-sink", 31,
+			AD74115_DIN_CONFIG1_REG, GENMASK(11, 7)),
+	AD74115_FW_PROP("adi,digital-input-debounce-mode", 1,
+			AD74115_DIN_CONFIG1_REG, BIT(6)),
+
+	AD74115_FW_PROP_BOOL("adi,digital-input-unbuffered",
+			     AD74115_DIN_CONFIG2_REG, BIT(10)),
+	AD74115_FW_PROP_BOOL("adi,digital-input-short-circuit-detection",
+			     AD74115_DIN_CONFIG2_REG, BIT(9)),
+	AD74115_FW_PROP_BOOL("adi,digital-input-open-circuit-detection",
+			     AD74115_DIN_CONFIG2_REG, BIT(8)),
+
+	AD74115_FW_PROP("adi,dac-current-limit", 1,
+			AD74115_OUTPUT_CONFIG_REG, BIT(0)),
+
+	AD74115_FW_PROP_BOOL("adi,3-wire-rtd-excitation-swap",
+			     AD74115_RTD3W4W_CONFIG_REG, BIT(2)),
+	AD74115_FW_PROP_TBL("adi,rtd-excitation-current-microamp",
+			    ad74115_rtd_excitation_current_ua_tbl,
+			    AD74115_RTD3W4W_CONFIG_REG, GENMASK(1, 0)),
+
+	AD74115_FW_PROP_TBL("adi,ext2-burnout-current-nanoamp",
+			    ad74115_burnout_current_na_tbl,
+			    AD74115_BURNOUT_CONFIG_REG, GENMASK(14, 12)),
+	AD74115_FW_PROP("adi,ext2-burnout-current-polarity", 1,
+			AD74115_BURNOUT_CONFIG_REG, BIT(11)),
+	AD74115_FW_PROP_BOOL("adi,ext2-burnout-en",
+			     AD74115_BURNOUT_CONFIG_REG, BIT(10)),
+	AD74115_FW_PROP_TBL("adi,ext1-burnout-current-nanoamp",
+			    ad74115_burnout_current_na_tbl,
+			    AD74115_BURNOUT_CONFIG_REG, GENMASK(9, 7)),
+	AD74115_FW_PROP("adi,ext1-burnout-current-polarity", 1,
+			AD74115_BURNOUT_CONFIG_REG, BIT(6)),
+	AD74115_FW_PROP_BOOL("adi,ext1-burnout-en",
+			     AD74115_BURNOUT_CONFIG_REG, BIT(5)),
+	AD74115_FW_PROP_TBL("adi,viout-burnout-current-nanoamp",
+			    ad74115_viout_burnout_current_na_tbl,
+			    AD74115_BURNOUT_CONFIG_REG, GENMASK(4, 2)),
+	AD74115_FW_PROP("adi,viout-burnout-current-polarity", 1,
+			AD74115_BURNOUT_CONFIG_REG, BIT(1)),
+	AD74115_FW_PROP_BOOL("adi,viout-burnout-en",
+			     AD74115_BURNOUT_CONFIG_REG, BIT(0)),
+
+	AD74115_FW_PROP_BOOL("adi,charge-pump-en",
+			     AD74115_CHARGE_PUMP_REG, BIT(0)),
+};
+
+static int ad74115_parse_fw_prop(struct ad74115_state *st,
+				 const struct ad74115_fw_prop *prop, u32 *retval)
+{
+	struct device *dev = &st->spi->dev;
+	u32 val;
+	int ret;
+
+	if (prop->is_boolean) {
+		val = device_property_read_bool(dev, prop->name);
+	} else {
+		ret = device_property_read_u32(dev, prop->name, &val);
+		if (ret)
+			return 0;
+	}
+
+	*retval = val;
+
+	if (prop->is_boolean) {
+		if (prop->negate)
+			val = !val;
+	} else {
+		if (prop->lookup_tbl)
+			ret = _ad74115_find_tbl_index(prop->lookup_tbl,
+						      prop->lookup_tbl_len,
+						      val, &val);
+		else if (prop->max && val > prop->max)
+			ret = -EINVAL;
+		else
+			ret = 0;
+
+		if (ret)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value %u for prop %s\n",
+					     val, prop->name);
+	}
+
+	if (!prop->mask)
+		return 0;
+
+	val = (val << __ffs(prop->mask)) & prop->mask;
+
+	return regmap_update_bits(st->regmap, prop->reg, prop->mask, val);
+}
+
+static int ad74115_setup_iio_channels(struct iio_dev *indio_dev)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct iio_chan_spec *channels, *chans;
+	unsigned int i, num_chans;
+
+	channels = devm_kcalloc(dev, sizeof(*channels),
+				indio_dev->num_channels, GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	indio_dev->channels = channels;
+
+	chans = ad74115_channels_map[st->ch_func].channels;
+	num_chans = ad74115_channels_map[st->ch_func].num_channels;
+
+	memcpy(channels, chans, sizeof(*channels) * num_chans);
+
+	if (channels[0].output && channels[0].channel == AD74115_DAC_CH_MAIN &&
+	    channels[0].type == IIO_VOLTAGE && !st->dac_hart_slew) {
+		channels[0].info_mask_separate |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		channels[0].info_mask_separate_available |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	}
+
+	channels += num_chans;
+
+	for (i = 0; i < AD74115_DIAG_NUM; i++) {
+		enum ad74115_diag_func func = st->diag_func[i];
+
+		if (func == AD74115_DIAG_FUNC_DISABLED)
+			continue;
+
+		if (func == AD74115_DIAG_FUNC_TEMP)
+			*channels = ad74115_diag_temperature_channel;
+		else if (func == AD74115_DIAG_FUNC_SINK_OR_SOURCE_CURRENT)
+			*channels = ad74115_diag_current_channel;
+		else
+			*channels = ad74115_diag_voltage_channel;
+
+		channels->channel = AD74115_ADC_CH_DIAG0 + i;
+		channels->scan_index = channels->channel;
+
+		channels++;
+	}
+
+	return 0;
+}
+
+static int ad74115_setup_gc(struct ad74115_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	if (!st->gpio_valid_mask)
+		return 0;
+
+	st->gc.owner = THIS_MODULE;
+	st->gc.label = AD74115_NAME;
+	st->gc.base = -1;
+	st->gc.ngpio = AD74115_GPIO_NUM;
+	st->gc.parent = dev;
+	st->gc.can_sleep = true;
+	st->gc.init_valid_mask = ad74115_gpio_init_valid_mask;
+	st->gc.get_direction = ad74115_gpio_get_direction;
+	st->gc.direction_input = ad74115_gpio_direction_input;
+	st->gc.direction_output = ad74115_gpio_direction_output;
+	st->gc.get = ad74115_gpio_get;
+	st->gc.set = ad74115_gpio_set;
+
+	return devm_gpiochip_add_data(dev, &st->gc, st);
+}
+
+static int ad74115_setup_comp_gc(struct ad74115_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD74115_DIN_CONFIG1_REG, &val);
+	if (ret)
+		return ret;
+
+	if (!(val & AD74115_DIN_COMPARATOR_EN_MASK))
+		return 0;
+
+	st->gc.owner = THIS_MODULE;
+	st->gc.label = AD74115_NAME;
+	st->gc.base = -1;
+	st->gc.ngpio = 1;
+	st->gc.parent = dev;
+	st->gc.can_sleep = true;
+	st->gc.get_direction = ad74115_comp_gpio_get_direction;
+	st->gc.get = ad74115_comp_gpio_get;
+	st->gc.set_config = ad74115_comp_gpio_set_config;
+
+	return devm_gpiochip_add_data(dev, &st->gc, st);
+}
+
+static int ad74115_setup(struct iio_dev *indio_dev)
+{
+	struct ad74115_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	u32 val;
+	int ret;
+
+	val = AD74115_CH_FUNC_HIGH_IMPEDANCE;
+	ret = ad74115_parse_fw_prop(st, &ad74115_ch_func_fw_prop, &val);
+	if (ret)
+		return ret;
+
+	indio_dev->num_channels += ad74115_channels_map[val].num_channels;
+	st->ch_func = val;
+
+	val = false;
+	ret = ad74115_parse_fw_prop(st, &ad74115_dac_hart_slew_prop, &val);
+	if (ret)
+		return ret;
+
+	st->dac_hart_slew = val;
+
+	if (val) {
+		ret = regmap_update_bits(st->regmap, AD74115_OUTPUT_CONFIG_REG,
+					 AD74115_OUTPUT_SLEW_EN_MASK,
+					 FIELD_PREP(AD74115_OUTPUT_SLEW_EN_MASK,
+						    AD74115_SLEW_MODE_HART));
+		if (ret)
+			return ret;
+	}
+
+	val = AD74115_DIN_THRESHOLD_MODE_AVDD;
+	ret = ad74115_parse_fw_prop(st, &ad74115_din_threshold_mode_fw_prop, &val);
+	if (ret)
+		return ret;
+
+	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD) {
+		ret = regulator_get_voltage(st->regulators[AD74115_AVDD_REGULATOR].consumer);
+		if (ret < 0)
+			return ret;
+
+		st->avdd_mv = ret / 1000;
+	}
+
+	st->din_threshold_mode = val;
+
+	val = false;
+	ret = ad74115_parse_fw_prop(st, &ad74115_dac_bipolar_fw_prop, &val);
+	if (ret)
+		return ret;
+
+	st->dac_bipolar = val;
+
+	val = AD74115_RTD_MODE_3_WIRE;
+	ret = ad74115_parse_fw_prop(st, &ad74115_ch_func_fw_prop, &val);
+	if (ret)
+		return ret;
+
+	st->rtd_mode = val;
+
+	for (i = 0; i < AD74115_GPIO_NUM; i++) {
+		val = AD74115_GPIO_MODE_LOGIC;
+
+		ret = ad74115_parse_fw_prop(st, &ad74115_gpio_mode_fw_props[i], &val);
+		if (ret)
+			return ret;
+
+		if (val == AD74115_GPIO_MODE_LOGIC)
+			st->gpio_valid_mask |= BIT(i);
+	}
+
+	for (i = 0; i < AD74115_DIAG_NUM; i++) {
+		val = AD74115_DIAG_FUNC_DISABLED;
+
+		ret = ad74115_parse_fw_prop(st, &ad74115_diag_func_fw_props[i], &val);
+		if (ret)
+			return ret;
+
+		st->diag_func[i] = val;
+
+		if (val != AD74115_DIAG_FUNC_DISABLED)
+			indio_dev->num_channels++;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ad74115_fw_props); i++) {
+		const struct ad74115_fw_prop *prop = &ad74115_fw_props[i];
+
+		ret = ad74115_parse_fw_prop(st, prop, &val);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad74115_setup_gc(st);
+	if (ret)
+		return ret;
+
+	ret = ad74115_setup_comp_gc(st);
+	if (ret)
+		return ret;
+
+	return ad74115_setup_iio_channels(indio_dev);
+}
+
+static int ad74115_reset(struct ad74115_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, AD74115_CMD_KEY_REG,
+			   AD74115_CMD_KEY_RESET1);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD74115_CMD_KEY_REG,
+			    AD74115_CMD_KEY_RESET2);
+}
+
+static void ad74115_regulators_disable(void *data)
+{
+	struct ad74115_state *st = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
+}
+
+static int ad74115_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ad74115_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->spi = spi;
+	mutex_init(&st->lock);
+	init_completion(&st->adc_data_completion);
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", AD74115_NAME,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad74115_trigger_ops;
+	iio_trigger_set_drvdata(st->trig, st);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->name = AD74115_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad74115_info;
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	st->regulators[AD74115_AVDD_REGULATOR].supply = "avdd";
+	st->regulators[AD74115_AVCC_REGULATOR].supply = "avcc";
+	st->regulators[AD74115_DVCC_REGULATOR].supply = "dvcc";
+	st->regulators[AD74115_ALDO1V8_REGULATOR].supply = "aldo1v8";
+	st->regulators[AD74115_DOVDD_REGULATOR].supply = "dovdd";
+	st->regulators[AD74115_REFIN_REGULATOR].supply = "refin";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
+				      st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	ret = devm_add_action_or_reset(dev, ad74115_regulators_disable, st);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad74115_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ad74115_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ad74115_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, spi->irq, ad74115_adc_data_interrupt,
+			       0, AD74115_NAME, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad74115_trigger_handler,
+					      &ad74115_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad74115_unregister_driver(struct spi_driver *spi)
+{
+	spi_unregister_driver(spi);
+
+	return 0;
+}
+
+static int __init ad74115_register_driver(struct spi_driver *spi)
+{
+	crc8_populate_msb(ad74115_crc8_table, AD74115_CRC_POLYNOMIAL);
+
+	return spi_register_driver(spi);
+}
+
+static const struct spi_device_id ad74115_spi_id[] = {
+	{ "ad74115h", 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(spi, ad74115_spi_id);
+
+static const struct of_device_id ad74115_dt_id[] = {
+	{ .compatible = "adi,ad74115h" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad74115_dt_id);
+
+static struct spi_driver ad74115_driver = {
+	.driver = {
+		   .name = "ad74115",
+		   .of_match_table = ad74115_dt_id,
+	},
+	.probe = ad74115_probe,
+	.id_table = ad74115_spi_id,
+};
+
+module_driver(ad74115_driver,
+	      ad74115_register_driver,
+	      ad74115_unregister_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD74115 ADDAC");
+MODULE_LICENSE("GPL");
-- 
2.37.3

