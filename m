Return-Path: <linux-iio+bounces-5808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EE48FC520
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4931C22F87
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EF18FDAE;
	Wed,  5 Jun 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fArANUOv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0318F2FB;
	Wed,  5 Jun 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573968; cv=none; b=lSfLMHHborcaeKH7u7jBBAFKLSnh8lnqnvdNV6XQJttj0TTOtEsYJEu5RhC8fi3NuIvXjvHCbavTM0O+M/YOel3AElBZopQsrCECjgR4QNrAKxdgeLyI050HCMRugoPr8czHI1aDN2PcbV+KZj1HbOrFzcd4L85OMty+il/s/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573968; c=relaxed/simple;
	bh=XrfSRrJ7EF0t1bW4E2n/AMkEy5nbGXCiOMHr7XSDs5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWs/wZh8l/AGNvISKN516pJCnUZtEUoy08rkE0W9oZQ2EKVyzVHLD1OlWg+gy8Md7EfM4fLBrHuCBTb3ucNIjHDXG2qM40kKn3f3GRaLdiFJdz0acc7jiIMZ8X5VugO102rv5olUWKfizyKs4Uu1dOD4YlhxqFxeXOcGdUeOdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fArANUOv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42159283989so1965685e9.3;
        Wed, 05 Jun 2024 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573965; x=1718178765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d938GCY+0VmkKPW+ZUE+VmgbyLC1bhkjlDIYYNMduOE=;
        b=fArANUOv3sZlxcQLsxmsYDE/3vgQIcUp4k5X6wN/nex6zPxCV9H4AOGzegoKQDbjcq
         O5sx6j9MJK4HMcfnR/WbQJwjMTfeqRSHLXwjRJRmbWyV0EcZNMLaAZrQ4XR1UFNNm7CF
         46o6FeWX3FPMdbrz3jLJcvNB+I7JvPQkArk/vmnkOiEvaa0s4Cr7ND/LatSKd7jqWJLL
         LNosjZTgrt2ExWcmbvxAglccwLXWM9cYviditUH6GqNueRwJjrulMV3RxkXDfafNdfat
         g4kuS/xjTUbAWj2RVufpSWyaRwxlotVzWPH7dB7OCXtRKHsDudqeQI4zUmQ9P72mkf96
         PqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573965; x=1718178765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d938GCY+0VmkKPW+ZUE+VmgbyLC1bhkjlDIYYNMduOE=;
        b=iZ2mMhGzdVlfkY77st2IWLefgjXYz7hKw37850dy91R8b/PZnDp0Iy+VrsQtPBlY26
         H6uBTMRAGKIv7LYtqZFD7EZCuZ1gNrLdnCss0HT6g67ho+taKIHM+Ak58uJLHc9UTMAF
         f+dBGLiR4xzRNV3kM79PPcJFOsq2Xj/fkuA1vyW9n03DpdYngOewdnRpXHHyfZEOTHJV
         6bBM9CiqsSRcHIiovC7hApqQmliX28X3086FA2HSdsQnKJTtzncvRGQTLcd7GCBgA38D
         sIyDBbY7KzhVTk5+G9e7ssBDZkrQLcVR+4XAOTxPDwYBdHkC9KruxRf7o++5CGliWhOv
         DUxA==
X-Forwarded-Encrypted: i=1; AJvYcCV9cYKedMqpgOnypiAxRDR1EDyHQnocnGWMt4IVkuEYBaU6+w3uQKzwUuurX7lt3NQjYoVL/kcuf1q6ozUQ6nileadAkXXOnn6vTmhlurz4jN9rV3gCblvIdEWEhlxCbi4qqf9hvZaut1EiGzduclm/WzdyiAfs1BQ/v53e9ohYgFN7uA==
X-Gm-Message-State: AOJu0YwnlIG7bzgOo4UntEwda2CXXANHgDsZ4xQOZcVnkOjHyx133FiA
	AksqdoSj/1btgAAIOlAcuqpnVwDQPStj5BJt4jFblWf4hyZewtsc
X-Google-Smtp-Source: AGHT+IEqdkRRQZGOY6z7/+oi4ovCv5lUjMlYEwAq6t0eHQWU5Ya7uHIO8FFMtBMpIgOR2qabABNsEA==
X-Received: by 2002:a5d:5f91:0:b0:354:f612:5f7e with SMTP id ffacd0b85a97d-35e8ef94989mr1966577f8f.56.1717573964904;
        Wed, 05 Jun 2024 00:52:44 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a10a:2300:8e59:f160:bdc8:6311])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm13760638f8f.23.2024.06.05.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:52:44 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] iio: adc: ad7192: Fix clock config
Date: Wed,  5 Jun 2024 10:51:54 +0300
Message-Id: <20240605075154.625123-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605075154.625123-1-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock, which can
be made available on the MCLK2 pin.

Rename mclk to ext_clk for clarity.

Note that the fix tag is for the commit that moved the driver out of
staging.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 153 ++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index f06cb7ac4b42..75b0724142b1 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -202,7 +203,8 @@ struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
 	struct regulator		*vref;
-	struct clk			*mclk;
+	struct clk			*ext_clk;
+	struct clk_hw			int_clk_hw;
 	u16				int_vref_mv;
 	u32				aincom_mv;
 	u32				fclk;
@@ -398,27 +400,6 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_clock_select(struct ad7192_state *st)
-{
-	struct device *dev = &st->sd.spi->dev;
-	unsigned int clock_sel;
-
-	clock_sel = AD7192_CLK_INT;
-
-	/* use internal clock */
-	if (!st->mclk) {
-		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
-			clock_sel = AD7192_CLK_INT_CO;
-	} else {
-		if (device_property_read_bool(dev, "adi,clock-xtal"))
-			clock_sel = AD7192_CLK_EXT_MCLK1_2;
-		else
-			clock_sel = AD7192_CLK_EXT_MCLK2;
-	}
-
-	return clock_sel;
-}
-
 static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
@@ -1194,6 +1175,96 @@ static void ad7192_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
+static const char *const ad7192_clock_names[] = {
+	"xtal",
+	"clk"
+};
+
+static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
+{
+	return container_of(hw, struct ad7192_state, int_clk_hw);
+}
+
+static void ad7192_clk_disable_unprepare(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static unsigned long ad7192_clk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return AD7192_INT_FREQ_MHZ;
+}
+
+static int ad7192_clk_output_is_enabled(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+
+	return st->clock_sel == AD7192_CLK_INT_CO;
+}
+
+static int ad7192_clk_prepare(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+	int ret;
+
+	st->mode &= ~AD7192_MODE_CLKSRC_MASK;
+	st->mode |= AD7192_CLK_INT_CO;
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret)
+		return ret;
+
+	st->clock_sel = AD7192_CLK_INT_CO;
+
+	return 0;
+}
+
+static void ad7192_clk_unprepare(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+	int ret;
+
+	st->mode &= ~AD7192_MODE_CLKSRC_MASK;
+	st->mode |= AD7192_CLK_INT;
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret)
+		return;
+
+	st->clock_sel = AD7192_CLK_INT;
+}
+
+static const struct clk_ops ad7192_int_clk_ops = {
+	.recalc_rate = ad7192_clk_recalc_rate,
+	.is_enabled = ad7192_clk_output_is_enabled,
+	.prepare = ad7192_clk_prepare,
+	.unprepare = ad7192_clk_unprepare,
+};
+
+static int ad7192_register_clk_provider(struct iio_dev *indio_dev)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct clk_init_data init = {};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name = fwnode_get_name(fwnode);
+	init.ops = &ad7192_int_clk_ops;
+
+	st->int_clk_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &st->int_clk_hw);
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1312,20 +1383,34 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
-	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad7192_clock_names,
+						    ARRAY_SIZE(ad7192_clock_names));
+	if (ret < 0) {
+		st->clock_sel = AD7192_CLK_INT;
+		st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->clock_sel = ad7192_clock_select(st);
+		ret = ad7192_register_clk_provider(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Registration of clock provider failed\n");
+	} else {
+		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
 
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
-		st->fclk = clk_get_rate(st->mclk);
-		if (!ad7192_valid_external_frequency(st->fclk)) {
-			dev_err(dev,
-				"External clock frequency out of bounds\n");
-			return -EINVAL;
-		}
+		st->ext_clk = devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
+		if (IS_ERR(st->ext_clk))
+			return PTR_ERR(st->ext_clk);
+
+		ret = devm_add_action_or_reset(dev,
+					       ad7192_clk_disable_unprepare,
+					       st->ext_clk);
+		if (ret)
+			return ret;
+
+		st->fclk = clk_get_rate(st->ext_clk);
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return dev_err_probe(dev, -EINVAL,
+					     "External clock frequency out of bounds\n");
 	}
 
 	ret = ad7192_setup(indio_dev, dev);
-- 
2.34.1


