Return-Path: <linux-iio+bounces-14493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AAA16B0F
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B6169390
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA291C1F08;
	Mon, 20 Jan 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8eua7+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65D1B87CA;
	Mon, 20 Jan 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737370491; cv=none; b=c7EtcYRHRjCzl+jrW2hKwNtAPFQErycvVsovT9ZL919ykM+qTxzE18YfcVPLJ0KBDNwhvBWACSLJSCIEaIaibMuquHQojmq1bHFA8a7+drbuEGqXYRVqcoqnxTuNpkyFqUUar9XqVN3MO8yRVp5onnQurSOoJsqExi2LqHVtfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737370491; c=relaxed/simple;
	bh=r6C51u+gCX/5goFNLJ9mAzdiixcXdSV0hpGNrdl+ce4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFJQeFBq/qRI9leCnvLA9h9k/evoKf61WbXtAy4m/DNBbUrNBpmQVhf5k1+8hd2wGyfseUwEIBkvexYFT1qHjcp/zShRa47V5TMXElnDk8zUhISNAHJEnduZg1JsstV0rhxK/hPDD3bNsGshhI7/9Mo19euW0lPMzvKatbyukQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8eua7+4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2340171f8f.0;
        Mon, 20 Jan 2025 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737370487; x=1737975287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAX3Sjpxb6oQ6j2BvFefxhVSpgJex7rin6i104p1qxA=;
        b=Z8eua7+4juwpYB/bwfLVmTId0Hr/nmmrKEaEnAM8SFnFfROzkVrYc6/IJbJ6WZSgQL
         B0WBcTVg3XAYVhrh1AUsntWqYaJV6eSZ+5YnZYlv2DzYFcE+gA808S8ym+94gPmenotQ
         Fd05otjvbODhhKTx/e21FiZAWb3t25s7mNmwUppfv6c0caactKtUmgJ9sqSKYnhg/+xH
         PwLvjCek9r/5/SZvbUAy/tX40gaD+r16dMqiaJeNBmpP3sVAzTF3+B3Nq52njBQcu/bC
         tczP0MkTr3ANGcDvvySt85sxAoCBkEQlecvT4ewEj80WEFzVqL3Kf9Zg0jzcIlEEzq5H
         VS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737370487; x=1737975287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAX3Sjpxb6oQ6j2BvFefxhVSpgJex7rin6i104p1qxA=;
        b=h7VuC8lbMtYC+EF2fA+V0A0NSKqU9BmgseCpe7m05suc+P0bR71zVC2RFw0r0QDCTf
         9vmfImB5cZiCJk4OLomRq+oUMpsxx4iqEINKbg6oPOLdyqyPmANmeq1FkhP39Uyu7zDe
         jZ8h5tY2KHMoSsCcRD1m3oAFB1pkzaI2YnaeqpbupPXAGsFwQWVBilJN2uEuupO4q4go
         TuYwXxdiRmK/N8xMjjvn04J8tw0oyGDOqR1+TrKBKQkrqmfXY7bSIiYDYJwKMBZR/wn4
         lw0CUXpHBEhJ8/yP2t+B4gkP2+UqKenD0XoPpeX7NXY5u2W7/2otpNfJDD9t7vqa7VE+
         3LBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1xmB68aMOFQbgUIHU29MXdUNqLPQ9K4Xt9Xxzy1BBdhKB7nEmSDpqwaPN3DNba2HdG3ZMmQEnry2tSp+p@vger.kernel.org, AJvYcCVLTzGoQo/W/K7tI9x0kcUAS31nXXGqBqxHM5wxjYj+4tYUih/sR2tDtyxgel8tLWNyr9tDA7EPk+aW@vger.kernel.org, AJvYcCXbUlkN90f1fUgHgWpmhfOomuPt0J/4ip5rHfBPOjE92GSvBtmO/tNJHsaJOtlO8fTKa+FslUE0G/o7/g==@vger.kernel.org, AJvYcCXcaFQ0GrNv6rTQZ7xmZ6aq6ZF1wDpveOArj61mQq82Db3lYXYco8Dco9yzSF3NwR6iSvgSC369iIP6@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcandVDePMNKmaFLAr6zuxO0rG+Vt0RKAbC41mKOhxlDvkM2R
	LMDfr+ziwQGYoeVPOIZzwC4cV/CucGdOJ4Kc12BrdUa8yru2cTZM
X-Gm-Gg: ASbGncvMOydxfw9ctQbmlZeQbhBQw/XRhML57qeOSqemX8bgDBSlutApYeQgp3zvAPX
	J8OZ3mFAZwKjbWv2rFxvLdoN0LT+tvrrHwVHn3g78yCSgDAPNwmrad2ZEtXNiQxeQunwy8izeFn
	/vSPx/yCvOyt60Jj9UvsJn83eB4AaTviFaNlosEu48sF8ShoXYp4Iclepch2UIc1kn4vNkkKouo
	WLCNHL9DjsXPcnzCOZKnDJhC4xY+iAq/6i3oOr8rV5af7QroedFMwsglKKpaaS5Rz7AD3P/gqfa
	P/D70A==
X-Google-Smtp-Source: AGHT+IEaxxZJakUkLpwqr3Dz2xQ4nD/6k6K8zinMZ3+ojHxsG4ohMWrO9yokOt/ze3uP67WRc/UTrg==
X-Received: by 2002:a5d:588a:0:b0:387:8752:5691 with SMTP id ffacd0b85a97d-38bf57c0879mr9983627f8f.47.1737370486631;
        Mon, 20 Jan 2025 02:54:46 -0800 (PST)
Received: from demon-pc.localdomain ([86.121.79.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321537dsm10222411f8f.13.2025.01.20.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:54:46 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 2/2] iio: amplifiers: add ADA4255 driver
Date: Mon, 20 Jan 2025 12:54:25 +0200
Message-ID: <20250120105429.183004-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120105429.183004-1-demonsingur@gmail.com>
References: <20250120105429.183004-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADA4255 is a  precision programmable gain instrumentation amplifier
(PGIA) with integrated bipolar charge pumps.

With its integrated charge pumps, the ADA4255 internally produces the
high voltage bipolar supplies needed to achieve a wide input voltage
range (38V typical with VDDCP = 5V) without lowering input impedance.

The charge pump topology of the ADA4255 allows channels to be isolated
with only low voltage components, reducing complexity, size, and
implementation time in industrial and process control systems.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 MAINTAINERS                      |   1 +
 drivers/iio/amplifiers/Kconfig   |  12 +
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/ada4255.c | 937 +++++++++++++++++++++++++++++++
 4 files changed, 951 insertions(+)
 create mode 100644 drivers/iio/amplifiers/ada4255.c

diff --git a/MAINTAINERS b/MAINTAINERS
index be46db0866011..f16c0ba60e53f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1411,6 +1411,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml
+F:	drivers/iio/amplifiers/ada4255.c
 
 ANALOG DEVICES INC ADF4377 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index 55eb16b32f6c9..4fad09f8bddd3 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -36,6 +36,18 @@ config ADA4250
 	  To compile this driver as a module, choose M here: the
 	  module will be called ada4250.
 
+config ADA4255
+	tristate "Analog Devices ADA4255 Instrumentation Amplifier"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4254 and
+	  ADA4255 SPI Instrumentation Amplifiers. The driver provides
+	  direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ada4255.
+
 config HMC425
 	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
 	depends on GPIOLIB
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index 2126331129cf6..3a43a42106d23 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -6,4 +6,5 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
 obj-$(CONFIG_ADA4250) += ada4250.o
+obj-$(CONFIG_ADA4255) += ada4255.o
 obj-$(CONFIG_HMC425) += hmc425a.o
diff --git a/drivers/iio/amplifiers/ada4255.c b/drivers/iio/amplifiers/ada4255.c
new file mode 100644
index 0000000000000..8d25ffa7baa6c
--- /dev/null
+++ b/drivers/iio/amplifiers/ada4255.c
@@ -0,0 +1,937 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+
+#define ADA4255_GAIN_MUX_REG			0x00
+#define ADA4255_GAIN_G4_MASK			BIT(7)
+#define ADA4255_GAIN_G3_0_MASK			GENMASK(6, 3)
+
+#define ADA4255_RESET_REG			0x01
+#define ADA4255_RESET_MASK			BIT(0)
+
+#define ADA4255_SYNC_CFG_REG			0x02
+#define ADA4255_SYNC_CLK_CP_SEL_MASK		BIT(7)
+#define ADA4255_SYNC_CLK_OUT_SEL_MASK		BIT(6)
+#define ADA4255_SYNC_MASK			GENMASK(2, 0)
+
+#define ADA4255_GPIO_DATA_REG			0x05
+
+#define ADA4255_INPUT_MUX_REG			0x06
+
+#define ADA4255_GPIO_DIR_REG			0x08
+
+#define ADA4255_SF_CFG_REG			0x0c
+#define ADA4255_INT_CLK_OUT_MASK		BIT(5)
+#define ADA4255_EXT_CLK_IN_MASK			BIT(4)
+
+#define ADA4255_TEST_MUX_REG			0x0e
+#define ADA4255_GAIN_G5_MASK			BIT(7)
+
+#define AD4255_EX_CURRENT_CFG_REG		0x0f
+#define AD4255_EX_CURRENT_SEL_MASK		BIT(6)
+#define AD4255_EX_CURRENT_MASK			GENMASK(3, 0)
+
+#define ADA4255_IN_GAINS_NUM			12
+#define ADA4255_OUT_GAINS_NUM			3
+#define ADA4255_GAINS_NUM			(ADA4255_IN_GAINS_NUM * \
+						 ADA4255_OUT_GAINS_NUM)
+
+#define ADA4255_GPIO_NUM			7
+#define ADA4255_GPIO_MASK(x)			BIT(x)
+#define ADA4255_GPIO4_OFFSET			4
+
+#define ADA4255_CLK_FREQ_HZ_MIN			800000
+#define ADA4255_CLK_FREQ_HZ_MAX			1200000
+#define ADA4255_CLK_DIVIDER_MAX			5
+
+#define ADA4255_NAME				"ada4255"
+
+#define ada4255_from_clk_hw(hw) \
+	container_of(hw, struct ada4255_state, int_clk_hw)
+
+struct ada4255_chip_info {
+	const char			*name;
+	bool				has_charge_pump;
+};
+
+struct ada4255_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct clk			*mclk;
+	const struct ada4255_chip_info	*chip_info;
+
+	/*
+	 * Synchronize consecutive regmap operations.
+	 */
+	struct mutex			lock;
+	struct gpio_chip		gc;
+	struct notifier_block		ext_clk_nb;
+	struct clk_hw			int_clk_hw;
+
+	bool				gpio4_clk_en;
+	bool				int_clk_out_en;
+};
+
+/*
+ * The following table is generated by iterating through all the available
+ * output gains (1 / 1, 5 / 4, 11 / 8), and available input gains (1 / 16
+ * through 128, in powers of 2), and multiplying them together.
+ */
+static const unsigned int ada4255_gain_tbl[ADA4255_GAINS_NUM][2] = {
+	{   0,  62500000 },
+	{   0,  78125000 },
+	{   0,  85937500 },
+	{   0, 125000000 },
+	{   0, 156250000 },
+	{   0, 171875000 },
+	{   0, 250000000 },
+	{   0, 312500000 },
+	{   0, 343750000 },
+	{   0, 500000000 },
+	{   0, 625000000 },
+	{   0, 687500000 },
+	{   1 },
+	{   1, 250000000 },
+	{   1, 375000000 },
+	{   2 },
+	{   2, 500000000 },
+	{   2, 750000000 },
+	{   4 },
+	{   5 },
+	{   5, 500000000 },
+	{   8 },
+	{  10 },
+	{  11 },
+	{  16 },
+	{  20 },
+	{  22 },
+	{  32 },
+	{  40 },
+	{  44 },
+	{  64 },
+	{  80 },
+	{  88 },
+	{ 128 },
+	{ 160 },
+	{ 176 },
+};
+
+/*
+ * G5 bit is stored in a separate register compared to the rest of the gain
+ * bits. G4 is functionally grouped together with G5, while being stored in
+ * the same register as the G3 to G0 bits.
+ * Keep a table containing all the gain bit values for the corresponding
+ * gains for simplicity.
+ */
+static const unsigned int ada4255_gain_reg_tbl[ADA4255_GAINS_NUM][3] = {
+	{ 0, 0, 0 },
+	{ 1, 0, 0 },
+	{ 0, 1, 0 },
+	{ 0, 0, 1 },
+	{ 1, 0, 1 },
+	{ 0, 1, 1 },
+	{ 0, 0, 2 },
+	{ 1, 0, 2 },
+	{ 0, 1, 2 },
+	{ 0, 0, 3 },
+	{ 1, 0, 3 },
+	{ 0, 1, 3 },
+	{ 0, 0, 4 },
+	{ 1, 0, 4 },
+	{ 0, 1, 4 },
+	{ 0, 0, 5 },
+	{ 1, 0, 5 },
+	{ 0, 1, 5 },
+	{ 0, 0, 6 },
+	{ 1, 0, 6 },
+	{ 0, 1, 6 },
+	{ 0, 0, 7 },
+	{ 1, 0, 7 },
+	{ 0, 1, 7 },
+	{ 0, 0, 8 },
+	{ 1, 0, 8 },
+	{ 0, 1, 8 },
+	{ 0, 0, 9 },
+	{ 1, 0, 9 },
+	{ 0, 1, 9 },
+	{ 0, 0, 10 },
+	{ 1, 0, 10 },
+	{ 0, 1, 10 },
+	{ 0, 0, 11 },
+	{ 1, 0, 11 },
+	{ 0, 1, 11 },
+};
+
+static const unsigned int ada4255_ch_input_mux_tbl[] = {
+	0b01100000, 0b00011000
+};
+
+static const unsigned int ada4255_excitation_current_ua_tbl[] = {
+	0, 100, 200, 300, 400, 500, 600, 700, 800,
+	900, 1000, 1100, 1200, 1300, 1400, 1500
+};
+
+static const unsigned int ada4255_clk_cp_sel_hz_tbl[] = {
+	16000000, 8000000
+};
+
+static const unsigned int ada4255_int_clk_rate_hz_tbl[] = {
+	1000000, 125000,
+};
+
+static int _ada4255_find_tbl_index(const unsigned int *tbl, unsigned int tbl_len,
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
+#define ada4255_find_tbl_index(tbl, val, index)	\
+	_ada4255_find_tbl_index(tbl, ARRAY_SIZE(tbl), val, index)
+
+static int ada4255_gpio_set_output(struct ada4255_state *st, unsigned int offset,
+				   bool output)
+{
+	return regmap_update_bits(st->regmap, ADA4255_GPIO_DIR_REG,
+				  ADA4255_GPIO_MASK(offset),
+				  output ? ADA4255_GPIO_MASK(offset) : 0);
+}
+
+static int ada4255_gpio_init_valid_mask(struct gpio_chip *gc,
+					unsigned long *valid_mask,
+					unsigned int ngpios)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+
+	assign_bit(ADA4255_GPIO4_OFFSET, valid_mask, !st->gpio4_clk_en);
+
+	return 0;
+}
+
+static int ada4255_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADA4255_GPIO_DIR_REG, &val);
+	if (ret)
+		return ret;
+
+	return val & ADA4255_GPIO_MASK(offset) ? GPIO_LINE_DIRECTION_OUT
+					       : GPIO_LINE_DIRECTION_IN;
+}
+
+static int ada4255_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+
+	return ada4255_gpio_set_output(st, offset, false);
+}
+
+static int ada4255_gpio_direction_output(struct gpio_chip *gc, unsigned int offset,
+					 int value)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+
+	return ada4255_gpio_set_output(st, offset, true);
+}
+
+static int ada4255_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADA4255_GPIO_DATA_REG, &val);
+	if (ret)
+		return ret;
+
+	return val & ADA4255_GPIO_MASK(offset);
+}
+
+static void ada4255_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct ada4255_state *st = gpiochip_get_data(gc);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADA4255_GPIO_DATA_REG,
+				 ADA4255_GPIO_MASK(offset),
+				 value ? ADA4255_GPIO_MASK(offset) : 0);
+	if (ret)
+		dev_err(dev, "Failed to set GPIO %u output value, err: %d\n",
+			offset, ret);
+}
+
+static int ada4255_set_gain(struct ada4255_state *st, int val, int val2)
+{
+	ssize_t tbl_len = ARRAY_SIZE(ada4255_gain_tbl);
+	unsigned int i, g5, g4, g3_0;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ada4255_gain_tbl); i++)
+		if (val == ada4255_gain_tbl[i][0] &&
+		    val2 == ada4255_gain_tbl[i][1])
+			break;
+
+	if (i == tbl_len)
+		return -EINVAL;
+
+	g5 = ada4255_gain_reg_tbl[i][0];
+	g4 = ada4255_gain_reg_tbl[i][1];
+	g3_0 = ada4255_gain_reg_tbl[i][2];
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, ADA4255_TEST_MUX_REG,
+				 ADA4255_GAIN_G5_MASK,
+				 FIELD_PREP(ADA4255_GAIN_G5_MASK, g5));
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(st->regmap, ADA4255_GAIN_MUX_REG,
+				 ADA4255_GAIN_G4_MASK | ADA4255_GAIN_G3_0_MASK,
+				 FIELD_PREP(ADA4255_GAIN_G4_MASK, g4) |
+				 FIELD_PREP(ADA4255_GAIN_G3_0_MASK, g3_0));
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ada4255_get_gain(struct ada4255_state *st, int *val, int *val2)
+{
+	ssize_t tbl_len = ARRAY_SIZE(ada4255_gain_reg_tbl);
+	unsigned int i, gain, test_gain, g5, g4, g3_0;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_read(st->regmap, ADA4255_GAIN_MUX_REG, &gain);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(st->regmap, ADA4255_TEST_MUX_REG, &test_gain);
+
+out:
+	mutex_unlock(&st->lock);
+
+	if (ret)
+		return ret;
+
+	g5 = FIELD_GET(ADA4255_GAIN_G5_MASK, test_gain);
+	g4 = FIELD_GET(ADA4255_GAIN_G4_MASK, gain);
+	g3_0 = FIELD_GET(ADA4255_GAIN_G3_0_MASK, gain);
+
+	for (i = 0; i < ARRAY_SIZE(ada4255_gain_reg_tbl); i++)
+		if (g5 == ada4255_gain_reg_tbl[i][0] &&
+		    g4 == ada4255_gain_reg_tbl[i][1] &&
+		    g3_0 == ada4255_gain_reg_tbl[i][2])
+			break;
+
+	if (i == tbl_len)
+		return -EINVAL;
+
+	*val = ada4255_gain_tbl[i][0];
+	*val2 = ada4255_gain_tbl[i][1];
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int ada4255_get_ch_en(struct ada4255_state *st, unsigned int ch, int *val)
+{
+	unsigned int ch_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADA4255_INPUT_MUX_REG, &ch_val);
+	if (ret)
+		return ret;
+
+	*val = ch_val == ada4255_ch_input_mux_tbl[ch];
+
+	return IIO_VAL_INT;
+}
+
+static int ada4255_set_ch_en(struct ada4255_state *st, unsigned int ch, int val)
+{
+	unsigned int ch_val = val ? ada4255_ch_input_mux_tbl[ch] : 0;
+	int current_val;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = ada4255_get_ch_en(st, ch, &current_val);
+	if (ret < 0)
+		goto out;
+
+	if (current_val == val) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = regmap_write(st->regmap, ADA4255_INPUT_MUX_REG, ch_val);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct regmap_config ada4255_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ada4255_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ada4255_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return ada4255_get_gain(st, val, val2);
+	case IIO_CHAN_INFO_ENABLE:
+		return ada4255_get_ch_en(st, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4255_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ada4255_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return ada4255_set_gain(st, val, val2);
+	case IIO_CHAN_INFO_ENABLE:
+		return ada4255_set_ch_en(st, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4255_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*vals = (const int *)ada4255_gain_tbl;
+		*length = ARRAY_SIZE(ada4255_gain_tbl) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4255_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4255_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int write_val, unsigned int *read_val)
+{
+	struct ada4255_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return regmap_read(st->regmap, reg, read_val);
+
+	return regmap_write(st->regmap, reg, write_val);
+}
+
+static const struct iio_info ada4255_info = {
+	.read_raw = ada4255_read_raw,
+	.write_raw = ada4255_write_raw,
+	.read_avail = ada4255_read_avail,
+	.write_raw_get_fmt = ada4255_write_raw_get_fmt,
+	.debugfs_reg_access = &ada4255_reg_access,
+};
+
+#define ADA4255_CHAN(_channel) {						\
+	.type = IIO_VOLTAGE,							\
+	.output = 1,								\
+	.indexed = 1,								\
+	.channel = _channel,							\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE),			\
+}
+
+static const struct iio_chan_spec ada4255_channels[] = {
+	ADA4255_CHAN(0),
+	ADA4255_CHAN(1),
+};
+
+static int ada4255_get_ext_clk_div(unsigned long rate, unsigned int *divider)
+{
+	unsigned int i;
+
+	for (i = 0; i <= ADA4255_CLK_DIVIDER_MAX; i++) {
+		unsigned long scaled_rate = DIV_ROUND_CLOSEST(rate, 1 << i);
+
+		if (scaled_rate >= ADA4255_CLK_FREQ_HZ_MIN &&
+		    scaled_rate <= ADA4255_CLK_FREQ_HZ_MAX)
+			break;
+	}
+
+	if (i > ADA4255_CLK_DIVIDER_MAX)
+		return -EINVAL;
+
+	*divider = i;
+
+	return 0;
+}
+
+static int ada4255_set_ext_clk_sync(struct ada4255_state *st,
+				    unsigned int divider)
+{
+	return regmap_update_bits(st->regmap, ADA4255_SYNC_CFG_REG,
+				  ADA4255_SYNC_MASK,
+				  FIELD_PREP(ADA4255_SYNC_MASK, divider));
+}
+
+static int ada4255_ext_clk_rate_change(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ada4255_state *st = container_of(nb, struct ada4255_state,
+						ext_clk_nb);
+	struct clk_notifier_data *cnd = data;
+	unsigned long rate = cnd->new_rate;
+	unsigned int divider;
+	int ret;
+
+	if (action != PRE_RATE_CHANGE && action != POST_RATE_CHANGE)
+		return NOTIFY_OK;
+
+	ret = ada4255_get_ext_clk_div(rate, &divider);
+	if (ret)
+		return notifier_from_errno(ret);
+
+	if (action == POST_RATE_CHANGE) {
+		ret = ada4255_set_ext_clk_sync(st, divider);
+		if (ret)
+			return notifier_from_errno(ret);
+	}
+
+	return NOTIFY_OK;
+}
+
+#define ada4255_clk_abs_diff(a, b) abs((long)(a) - (long)(b))
+
+static long ada4255_int_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *parent_rate)
+{
+	long closest_rate = ada4255_int_clk_rate_hz_tbl[0];
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ada4255_int_clk_rate_hz_tbl); i++) {
+		unsigned int new_rate = ada4255_int_clk_rate_hz_tbl[i];
+
+		if (ada4255_clk_abs_diff(rate, new_rate) <
+		    ada4255_clk_abs_diff(rate, closest_rate))
+			closest_rate = new_rate;
+	}
+
+	return closest_rate;
+}
+
+static int ada4255_int_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct ada4255_state *st = ada4255_from_clk_hw(hw);
+	unsigned int i;
+	int ret;
+
+	ret = ada4255_find_tbl_index(ada4255_int_clk_rate_hz_tbl, rate, &i);
+	if (ret)
+		return rate;
+
+	return regmap_update_bits(st->regmap, ADA4255_SYNC_CFG_REG,
+				 ADA4255_SYNC_CLK_OUT_SEL_MASK,
+				 FIELD_PREP(ADA4255_SYNC_CLK_OUT_SEL_MASK, i));
+}
+
+static unsigned long ada4255_int_clk_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct ada4255_state *st = ada4255_from_clk_hw(hw);
+	struct device *dev = &st->spi->dev;
+	unsigned int i = 0;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADA4255_SYNC_CFG_REG, &i);
+	if (ret)
+		dev_err(dev, "Failed to read internal clock rate: %d\n", ret);
+
+	i = FIELD_GET(ADA4255_INT_CLK_OUT_MASK, i);
+
+	return ada4255_int_clk_rate_hz_tbl[i];
+}
+
+static int ada4255_int_clk_is_enabled(struct clk_hw *hw)
+{
+	return ada4255_from_clk_hw(hw)->int_clk_out_en;
+}
+
+static int ada4255_set_int_clk_out_en(struct ada4255_state *st, bool en)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADA4255_SF_CFG_REG,
+				 ADA4255_INT_CLK_OUT_MASK,
+				 FIELD_PREP(ADA4255_INT_CLK_OUT_MASK, en));
+	if (ret)
+		return ret;
+
+	st->int_clk_out_en = en;
+
+	return 0;
+}
+
+static int ada4255_int_clk_prepare(struct clk_hw *hw)
+{
+	struct ada4255_state *st = ada4255_from_clk_hw(hw);
+
+	return ada4255_set_int_clk_out_en(st, true);
+}
+
+static void ada4255_int_clk_unprepare(struct clk_hw *hw)
+{
+	struct ada4255_state *st = ada4255_from_clk_hw(hw);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = ada4255_set_int_clk_out_en(st, false);
+	if (ret)
+		dev_err(dev, "Failed to disable internal clock: %d\n", ret);
+}
+
+static const struct clk_ops ada4255_int_clk_ops = {
+	.round_rate = ada4255_int_clk_round_rate,
+	.set_rate = ada4255_int_clk_set_rate,
+	.recalc_rate = ada4255_int_clk_recalc_rate,
+	.is_enabled = ada4255_int_clk_is_enabled,
+	.prepare = ada4255_int_clk_prepare,
+	.unprepare = ada4255_int_clk_unprepare,
+};
+
+static void ada4255_clk_disable_unprepare(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int ada4255_setup_ext_clk(struct ada4255_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int divider;
+	unsigned long rate;
+	int ret;
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ada4255_clk_disable_unprepare,
+				       st->mclk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(st->mclk);
+	if (!rate)
+		return -EINVAL;
+
+	ret = ada4255_get_ext_clk_div(rate, &divider);
+	if (ret)
+		return ret;
+
+	ret = ada4255_set_ext_clk_sync(st, divider);
+	if (ret)
+		return ret;
+
+	st->ext_clk_nb.notifier_call = ada4255_ext_clk_rate_change;
+	ret = clk_notifier_register(st->mclk, &st->ext_clk_nb);
+	if (ret)
+		return ret;
+
+	ret = ada4255_gpio_set_output(st, ADA4255_GPIO4_OFFSET, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADA4255_SF_CFG_REG,
+				 ADA4255_EXT_CLK_IN_MASK,
+				 FIELD_PREP(ADA4255_EXT_CLK_IN_MASK, 1));
+	if (ret)
+		return ret;
+
+	st->gpio4_clk_en = true;
+
+	return 0;
+}
+
+static int ada4255_setup_int_clk(struct ada4255_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct device_node *of_node = dev_of_node(dev);
+	struct clk_init_data init;
+	const char *clk_name;
+	struct clk *clk;
+	int ret;
+
+	if (!of_node)
+		return 0;
+
+	ret = ada4255_gpio_set_output(st, ADA4255_GPIO4_OFFSET, false);
+	if (ret)
+		return ret;
+
+	clk_name = of_node->name;
+	of_property_read_string(of_node, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = &ada4255_int_clk_ops;
+
+	st->int_clk_hw.init = &init;
+	clk = devm_clk_register(dev, &st->int_clk_hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->gpio4_clk_en = true;
+
+	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+}
+
+static int ada4255_setup(struct ada4255_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int i;
+	int ret = 0;
+	u32 val;
+
+	st->mclk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get mclk\n");
+
+	if (st->mclk)
+		ret = ada4255_setup_ext_clk(st);
+	else
+		ret = ada4255_setup_int_clk(st);
+
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev, "adi,excitation-current-microamp", &val);
+	if (!ret) {
+		ret = ada4255_find_tbl_index(ada4255_excitation_current_ua_tbl,
+					     val, &i);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AD4255_EX_CURRENT_CFG_REG,
+					 AD4255_EX_CURRENT_MASK,
+					 FIELD_PREP(AD4255_EX_CURRENT_MASK, i));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AD4255_EX_CURRENT_CFG_REG,
+					 AD4255_EX_CURRENT_SEL_MASK,
+					 FIELD_PREP(AD4255_EX_CURRENT_SEL_MASK, 1));
+		if (ret)
+			return ret;
+	}
+
+	ret = device_property_read_u32(dev, "adi,charge-pump-freq-hz", &val);
+	if (!ret) {
+		if (!st->chip_info->has_charge_pump)
+			return dev_err_probe(dev, -EINVAL,
+					     "Unsupported charge pump function\n");
+
+		ret = ada4255_find_tbl_index(ada4255_clk_cp_sel_hz_tbl, val, &i);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, ADA4255_SYNC_CFG_REG,
+					 ADA4255_SYNC_CLK_CP_SEL_MASK,
+					 FIELD_PREP(ADA4255_SYNC_CLK_CP_SEL_MASK, i));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ada4255_setup_gpio_chip(struct ada4255_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->gc = (struct gpio_chip) {
+		.owner = THIS_MODULE,
+		.label = st->chip_info->name,
+		.base = -1,
+		.ngpio = ADA4255_GPIO_NUM,
+		.parent = dev,
+		.can_sleep = true,
+		.init_valid_mask = ada4255_gpio_init_valid_mask,
+		.get_direction = ada4255_gpio_get_direction,
+		.direction_input = ada4255_gpio_direction_input,
+		.direction_output = ada4255_gpio_direction_output,
+		.get = ada4255_gpio_get,
+		.set = ada4255_gpio_set,
+	};
+
+	return devm_gpiochip_add_data(dev, &st->gc, st);
+}
+
+static int ada4255_reset(struct ada4255_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADA4255_RESET_REG,
+			   FIELD_PREP(ADA4255_RESET_REG, 1));
+	if (ret)
+		return ret;
+
+	/*
+	 * A full calibration occurs after a soft reset and it takes
+	 * approximately 85ms.
+	 * See datasheet page 29, Section OUTPUT RIPPLE CALIBRATION
+	 * CONFIGURATION.
+	 */
+	fsleep(85000);
+
+	return 0;
+}
+
+static int ada4255_probe(struct spi_device *spi)
+{
+	static const char * const regulator_names[] = {
+		"avdd",
+		"dvdd",
+		"vddcp",
+		"vocm",
+	};
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ada4255_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -EINVAL;
+
+	indio_dev->info = &ada4255_info;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->channels = ada4255_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ada4255_channels);
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	st->regmap = devm_regmap_init_spi(spi, &ada4255_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ada4255_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ada4255_setup(st);
+	if (ret)
+		return ret;
+
+	ret = ada4255_setup_gpio_chip(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct ada4255_chip_info ada4254_chip_info_data = {
+	.name = "ada4254",
+};
+
+static const struct ada4255_chip_info ada4255_chip_info_data = {
+	.name = "ada4255",
+	.has_charge_pump = true,
+};
+
+static const struct spi_device_id ada4255_id[] = {
+	{ "ada4254", (kernel_ulong_t)&ada4254_chip_info_data },
+	{ "ada4255", (kernel_ulong_t)&ada4255_chip_info_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ada4255_id);
+
+static const struct of_device_id ada4255_of_match[] = {
+	{
+		.compatible = "adi,ada4254",
+		.data = &ada4254_chip_info_data,
+	},
+	{
+		.compatible = "adi,ada4255",
+		.data = &ada4255_chip_info_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ada4255_of_match);
+
+static struct spi_driver ada4255_driver = {
+	.driver = {
+			.name = ADA4255_NAME,
+			.of_match_table = ada4255_of_match,
+		},
+	.probe = ada4255_probe,
+	.id_table = ada4255_id,
+};
+
+module_spi_driver(ada4255_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADA4255");
+MODULE_LICENSE("GPL");
-- 
2.48.1


