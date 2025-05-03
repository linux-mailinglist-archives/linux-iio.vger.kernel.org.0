Return-Path: <linux-iio+bounces-19015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5BAA7FD1
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 11:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4451BA1E79
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3821DB92C;
	Sat,  3 May 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhloYE4A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D54315F;
	Sat,  3 May 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266142; cv=none; b=OOCpc1vDvhzFDq1oMnKKrnj31jr0iea7NPThDGyiMXccbkXUkRqvRLMoBQJDbpv+SFCjEKLeI+/0Bt1y/UD8K00okpFz4eBcCRhGIhUyFMCTJZqzo2KAc8iPGtMyYESTn2HpgtbQSR/H6DLxRLr0Ryqnn98wdkQSYSX8aJ5VkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266142; c=relaxed/simple;
	bh=QsjQOqs9rNCb6wlXwkkUKTzyWATUgzGPtz62hjqj04U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqQyPg0MtJXRDu9DD+xW/Czcwt0YcNm4Bi8JN07abGki1ASgDHxygcawSuOpzve0JPkha9hMf1BJx2s8n5ggXDxfxJkugl+LLc5OZoYSGc7mN7+AVObYIoQbDkMZ2DPWgtpqr3JdZ2UNtK2iXAG/BT14fTBzUvRcpxy5g5I3IUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhloYE4A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso35483265ad.1;
        Sat, 03 May 2025 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746266140; x=1746870940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2FFqPQS0cGePNUSaEag1bMy/aHVdoE23x6HNRbtcvE=;
        b=VhloYE4AigwI2KLyD9tQKWesvuj6kG+sZJUrABWgVFBfBt7mZOW1yfyIM/9IxrgEjS
         Q9bo1Ji+tqjGo0q46MvBX/bOpo+xyURWjwdj/dw+tAKZV2V+Qz58nRDM7TEn0RcKAOmL
         olotzhQeNRdC3NWRDlmQGYgQWsLYJpqnnLZ11t5kd1DMkOjmpmfhPTLSiy0MlKsgrZN9
         PhNm/ckG13aX4IW+LxUUPFwvXKHFOhFRpHn7Pyf5iZ2H7WwlQLMGvIDDShYCBF993ic0
         GTG7RxLN3078F+JYAQKMaIzCqzkdHoYTjPtFzAJWVLrCQ6Yh0V8FrCgGQtaTSiHSo8HL
         3Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746266140; x=1746870940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2FFqPQS0cGePNUSaEag1bMy/aHVdoE23x6HNRbtcvE=;
        b=KgUa1o5DCX4xvJaXuyQ5v9TcEvwFB8D+HFWaS58m/VJZOly3PUDuFwQQdLIERjJsdQ
         1mxsAToTKUWfpPUZJrpE+IVI5G4U04tl8mv+vP/Eh3GtNTLjGqaoUS3lwPC+wJ8DRZOK
         BvR3my7TeNn+Ww12AGldsTak8bNXDEM0Q/NLQJlE8WOPyO8ILrl3NyuIIiTVi9LWiY/z
         cCt00BdLKxZF5Xe1hcjbWkoAGWzkVjLG7rqwTjzc27g8kKeqB8Jm4prcPOkNAm9/UHT8
         KgMIik/X2wlvWtWU0IXGXaGxR0MOmADwwiUSkhq5eFAIoKHMRwpEra0Rubx/B0cVZTTf
         FB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP5W5JnEkgF2TUltocG8e5dTb3LqvSitrKsKbanvABsqghQ4Ys5UdGUSnE9S4O5DRqDec57QmR1BcqjoZ8@vger.kernel.org, AJvYcCUZTgcLDi5x96fTTg3Du1pRyolp0PG6LAbtU6KBH5hgckxs6R0K4SEkn9Z0UIW01g/MyLFwETUDTCvw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pvdBIgBVgpgW4J0ndFCBkzSYVm1va3caEAwRmKPdhmJKFRC2
	2IeWJAHsliXWK9eGyXNRT61yd5ixTmJlhJMzgVa2ZpcGzC6F8xA+
X-Gm-Gg: ASbGncvgCBRq2fo66ToCrcb7q8VlchWo9L8Nbhpe5DcBhACb55ObPFIBD7W4XWlS7VN
	ryajGjVaMN/A1PF49687usbLRYXAxGTQRFxErsNJnpWzM5XfC6ZZ0XjM1TgS2uH5kquRUI8dVvA
	TwLg0EC18e5auwsi1vsG+zbMjkkQBceYtec9j3sDSxLI1K0uct/Cq95x7QyI6lDTNQZ5gV65Exc
	anqIdq9MJWQLwrzY26AaMktwf/tBJz9zRTh1KPbM2R81WVwFApdjGX/51NJzs/u4lUG1jQZg6PW
	9hYdLhf7d8YmJWwq/BQKhUvPDKS+1B8TKj4CmrSCsSxT5oKl0rV5goqNuw/2
X-Google-Smtp-Source: AGHT+IHdkFFj/To09DWxc81m7ALbu06mLkZUP8cKiy8xtrdnioKoWhr5mFDpUzvkl43XFEATvCd9tg==
X-Received: by 2002:a17:902:e750:b0:223:fb3a:8631 with SMTP id d9443c01a7336-22e1030a3afmr120736405ad.24.1746266140170;
        Sat, 03 May 2025 02:55:40 -0700 (PDT)
Received: from localhost.localdomain ([36.50.162.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522948csm20883585ad.159.2025.05.03.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 02:55:39 -0700 (PDT)
From: akshay bansod <akshaybansod997@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] iio: dac: ad559*: fixed coding style issue (shorthand unsigned)
Date: Sat,  3 May 2025 15:25:29 +0530
Message-ID: <20250503095532.132041-1-akshaybansod997@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl flagged use of shorthand 'unsigned' as warning
trivial fix: replaced use of shorthand 'unsigned' with 'unsigned int'

Signed-off-by: akshay bansod <akshaybansod997@gmail.com>
---
 drivers/iio/dac/ad5592r-base.c | 14 +++++++-------
 drivers/iio/dac/ad5592r-base.h |  4 ++--
 drivers/iio/dac/ad5592r.c      |  4 ++--
 drivers/iio/dac/ad5593r.c      |  5 +++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 5f2cd5172..9aa051a74 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -21,7 +21,7 @@
 
 #include "ad5592r-base.h"
 
-static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret = 0;
@@ -55,7 +55,7 @@ static int ad5592r_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	return st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
 }
 
-static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret;
@@ -73,7 +73,7 @@ static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret;
@@ -99,7 +99,7 @@ static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
 	return st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
 }
 
-static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
+static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 
@@ -188,7 +188,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 {
 	const struct ad5592r_rw_ops *ops = st->ops;
 	int ret;
-	unsigned i;
+	unsigned int i;
 	u8 pulldown = 0, tristate = 0, dac = 0, adc = 0;
 	u16 read_back;
 
@@ -472,7 +472,7 @@ static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
 };
 
 static void ad5592r_setup_channel(struct iio_dev *iio_dev,
-		struct iio_chan_spec *chan, bool output, unsigned id)
+		struct iio_chan_spec *chan, bool output, unsigned int id)
 {
 	chan->type = IIO_VOLTAGE;
 	chan->indexed = 1;
@@ -489,7 +489,7 @@ static void ad5592r_setup_channel(struct iio_dev *iio_dev,
 static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
 {
 	struct ad5592r_state *st = iio_priv(iio_dev);
-	unsigned i, curr_channel = 0,
+	unsigned int i, curr_channel = 0,
 		 num_channels = st->num_channels;
 	struct iio_chan_spec *channels;
 	struct fwnode_handle *child;
diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
index cc7be426c..d78f5bb72 100644
--- a/drivers/iio/dac/ad5592r-base.h
+++ b/drivers/iio/dac/ad5592r-base.h
@@ -42,8 +42,8 @@ enum ad5592r_registers {
 #define AD5592R_REG_CTRL_DAC_RANGE	BIT(4)
 
 struct ad5592r_rw_ops {
-	int (*write_dac)(struct ad5592r_state *st, unsigned chan, u16 value);
-	int (*read_adc)(struct ad5592r_state *st, unsigned chan, u16 *value);
+	int (*write_dac)(struct ad5592r_state *st, unsigned int chan, u16 value);
+	int (*read_adc)(struct ad5592r_state *st, unsigned int chan, u16 *value);
 	int (*reg_write)(struct ad5592r_state *st, u8 reg, u16 value);
 	int (*reg_read)(struct ad5592r_state *st, u8 reg, u16 *value);
 	int (*gpio_read)(struct ad5592r_state *st, u8 *value);
diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 92d1b629b..a40f590e6 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -30,7 +30,7 @@ static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, __be16 *buf)
 	return spi_sync_transfer(spi, &t, 1);
 }
 
-static int ad5592r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
+static int ad5592r_write_dac(struct ad5592r_state *st, unsigned int chan, u16 value)
 {
 	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
 
@@ -39,7 +39,7 @@ static int ad5592r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
 	return spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
 }
 
-static int ad5592r_read_adc(struct ad5592r_state *st, unsigned chan, u16 *value)
+static int ad5592r_read_adc(struct ad5592r_state *st, unsigned int chan, u16 *value)
 {
 	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
 	int ret;
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 9a8525c61..3bdb54820 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -40,7 +40,7 @@ static int ad5593r_read_word(struct i2c_client *i2c, u8 reg, u16 *value)
 	return 0;
 }
 
-static int ad5593r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
+static int ad5593r_write_dac(struct ad5592r_state *st, unsigned int chan, u16 value)
 {
 	struct i2c_client *i2c = to_i2c_client(st->dev);
 
@@ -48,7 +48,7 @@ static int ad5593r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
 			AD5593R_MODE_DAC_WRITE | chan, value);
 }
 
-static int ad5593r_read_adc(struct ad5592r_state *st, unsigned chan, u16 *value)
+static int ad5593r_read_adc(struct ad5592r_state *st, unsigned int chan, u16 *value)
 {
 	struct i2c_client *i2c = to_i2c_client(st->dev);
 	s32 val;
@@ -102,6 +102,7 @@ static const struct ad5592r_rw_ops ad5593r_rw_ops = {
 static int ad5593r_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
+
 	if (!i2c_check_functionality(i2c->adapter,
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
-- 
2.49.0


