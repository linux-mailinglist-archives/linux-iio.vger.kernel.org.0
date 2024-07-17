Return-Path: <linux-iio+bounces-7663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714C9343D7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F55285FAA
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48E18EA74;
	Wed, 17 Jul 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW6eKiP5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00055186E48;
	Wed, 17 Jul 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251567; cv=none; b=EC7uuDsUWGQ+jMfyCXl3HII4UCiQFRu5Kxow0MVCW2abxRmpOSxKqHYRsg1TzQPZqpxfPnwBAcEbc2ZK6s/BAfPl7EUZiHFajrlZXQdY0O0mOYLP6dP5LYm7/Pqo95JgX27NZKmWVwWmvJ1gf59Rir76S/NgxUqJMZs5XsLhZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251567; c=relaxed/simple;
	bh=OYZ4Lp+LsKfB963iUHxM1nUX0jbGE/poJifLj3btfQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nG+sAPithfurUHNTfjHzwAatuP2kXUsMAakf5gsGHVowyuS7tzX9w7eNWMDJjHEC5BxTM/KEIUlD74vkya4Noisc8SrekO18yuPV7cQZ7WnvrJu4mGE9M00XoGqrydekL8dNHoBeeMy34lbWAME47pWKfqh761MRxTc9/8NRTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW6eKiP5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so867645e9.1;
        Wed, 17 Jul 2024 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251564; x=1721856364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjTTLNALQlo0+Bax0fTOpezWlVszgVp9jzrNq2e7X+M=;
        b=bW6eKiP5S+7NNsyBu5VQhtwI2qIEfHO+q8ldaUYY35VqV2huooipx58YXc0+1vSxH5
         4ePvbqellPGdUhAnwSotXq/abC5p5oCj/y1/MC5xSuTB/0NnsSwXgcuO+J9ZxURfpZxg
         estj4FrakZy52JVUwJZdU38fXubQrl89PA+OZe32jeHbz6JSKbGmTh8ObHA0Pbr6+N/0
         YvFT8dIUNHeoCuawrSW5uHaSdMxXO7Qa1rwD4/YATugHQPvDEH5SBSFfzA/T+AvMbI18
         JxM4hgjyMZDvQt1qtlDvxzwYUEGiJA6zXom49d223uQDhkSVBkO+Vh/u1qeymSPtRsOR
         XyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251564; x=1721856364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjTTLNALQlo0+Bax0fTOpezWlVszgVp9jzrNq2e7X+M=;
        b=otIz2r+hDsVGhrFxwD9xXlngOcutIidK0m87CA/4qo0XgFqp85b3ETSsdn/uAoJwQK
         xyAlSN2odOOW2f0Xy+vdkp8yGytEAlhLa6Ga38qDcd4gEwrOVUhOO8AJjNXZad7YvLl6
         XhSb2bq9Iz7RrgU5DG36+SOlVdSqe4acVxuJ3KWptGTtlNuV7wmJfk4akHLkJbhVlruJ
         L5idJJr/3IDl4PFQnsn+LbbKel8pUxKDuPhATM2l2AJRVjP1pkJ0qIis9x+/PM/zVJfN
         J3aMZ4UpSnutAWCC+2hXR5iyYyHGX7DT0vc+bF60R1ljqSTI0YvpMtM/twJGyA4vN40s
         wTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW74Perpjhg6HcwZmyHRiu6r7V7Plpkq62VRb+LsgWAPRnYawR0a3ytUg/o2FT+kAJ7IMtFG6P+hDW6dgaWgmHI1IYPcUGV30FeLIWsAZx5qrR/IzEdDVIWzhiJAUALVs59Q6aV6gdw7dhL0CfKf0KklTIeS4Sqp5D/a1wcX0WbnOcG+g==
X-Gm-Message-State: AOJu0YyeZeG8xyYX3SxRwnHeEgfH2dLrjrskCezvhw3mmxxiyG7WxM5w
	QZcn2yQg/8lPWR/AZdtLviybj7zwzeVNnPEg79CChr9lP+RLNguV
X-Google-Smtp-Source: AGHT+IHQVgh0uOb82kEziBzXJYj5fYIPt6ZSjzoHJBgc1tRu2d6lV/BbXSIrNGNIMO/2jiUKn2UJgg==
X-Received: by 2002:a05:600c:4e90:b0:426:6617:ae4a with SMTP id 5b1f17b1804b1-427c2cbd731mr19414705e9.22.1721251564274;
        Wed, 17 Jul 2024 14:26:04 -0700 (PDT)
Received: from spiri.. ([86.124.123.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10532735e9.17.2024.07.17.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:26:03 -0700 (PDT)
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
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v7 4/4] iio: adc: ad7192: Add clock provider
Date: Thu, 18 Jul 2024 00:25:35 +0300
Message-Id: <20240717212535.8348-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717212535.8348-1-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality when clock cells property
is present.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 92 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 042319f0c641..3f803b1eefcc 100644
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
@@ -201,6 +202,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct clk			*mclk;
+	struct clk_hw			int_clk_hw;
 	u16				int_vref_mv;
 	u32				aincom_mv;
 	u32				fclk;
@@ -406,6 +408,91 @@ static const char *const ad7192_clock_names[] = {
 	"mclk"
 };
 
+static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
+{
+	return container_of(hw, struct ad7192_state, int_clk_hw);
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
+static int ad7192_register_clk_provider(struct ad7192_state *st)
+{
+	struct device *dev = &st->sd.spi->dev;
+	struct clk_init_data init = {};
+	int ret;
+
+	if (!device_property_present(dev, "#clock-cells"))
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
+				   fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
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
 static int ad7192_clock_setup(struct ad7192_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
@@ -446,6 +533,11 @@ static int ad7192_clock_setup(struct ad7192_state *st)
 	if (ret < 0) {
 		st->clock_sel = AD7192_CLK_INT;
 		st->fclk = AD7192_INT_FREQ_MHZ;
+
+		ret = ad7192_register_clk_provider(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register clock provider\n");
 		return 0;
 	}
 
-- 
2.34.1


