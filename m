Return-Path: <linux-iio+bounces-6506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494BD90D589
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC2B285EC6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C550116132B;
	Tue, 18 Jun 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZsQSh0T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1A1607A3;
	Tue, 18 Jun 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720539; cv=none; b=nzXZQtjLw2kTRvU8NjWQyIwvI7Z6/Q6ZWVp+WZwghPCrtDYjSW5iayFk6a8zSBFWPQ8/WXWuRoUFmfohxdfBawrCCMKAHQ7CVt8GHXF/W6kEjH6TXXlmQ4zwOA9TZ6BxuRtmS7LOSiHnLRYiYKdxGn8NZ9tyBydVnnRMstREo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720539; c=relaxed/simple;
	bh=pWCyGoSwbSVi51UcYwjzYptyAKhEQbLVCZhUW0i1vc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+Er+vzM2T7apxFLkg1rGk2ujnjc33VKY3RujTrMRXUcU7jra36l2ab0xPm0ULxZeFb7RvqOnOIen3cv5jC3HGApYlH+42n4Ew3obVkccgzmsbsiNmWTIL/SHqqCRYkqj5Ws/lBHpCx1jBZQVhHSl0mheWfvALvIEjNTctM8k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZsQSh0T; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso6727720a12.1;
        Tue, 18 Jun 2024 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720536; x=1719325336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIFPwPUe239jQzWzpuE4uB77KNgGi1q0uRESeNjXXyI=;
        b=GZsQSh0Tn2cHx94L2CO8Zx8REuUG2QmXKvPNal9n2b78Po1P9Bf+rTSmXucTz4ljdH
         wsic0Goo1GBtd5G/rHtT9Xr8QVam2CpzpXBCfgJLFBzTwk/ypIioi1YhbnbtkS2RnZuP
         KI05OvWfOCQSWszXYy3R8r9/Tkp51r/DTUBeYoS20Hbbs18sxPnyYJBqGRpA3+IsD/cU
         VP9LNRtCA++xgoKPFEuvBO8TRIyhcVSsKH+Q0vhiTDM7k1MdSAmqxOGX7RSdfZpZUksS
         oWtXCV7h/v+AW0zjhXmPLwHxjbCOtQpGpnm2/AX6ViyC4/7WUqh1ia//8lXaFRy90XDd
         Q2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720536; x=1719325336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIFPwPUe239jQzWzpuE4uB77KNgGi1q0uRESeNjXXyI=;
        b=N3kdJLV37gmlW4IKMGY/I7tOjuQLfAJBcK1rwGXI1W62ndpyDvz76jQtL9yr9P136C
         UX9vMYCCFpsDUVk4HHVbi3kOMPij9HR+JfQXPyPvKrWROnIDPylGlraEFr+tzIxgWy9f
         Ltpdg/qBTfhMRY9dUXSAFgrPwlIrBdXWRRtCbqcPzOiDBo+Jt4iVgLWb3SSzqOJ2HypP
         K29pc5w1WbnpCDw+EAV1cFYcm2rLn6EnbQAfxrj9A//A9VRIHMQypRlKphZKzpdTlqcW
         HA3imSM2qbWeU/SwumWGE1xUa/bwpNQiVuKlVIl+3UIVSYM/ojAEoE5Uu6qTj1Up/P3S
         HTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtuBws6t04QuDz8Eou2uDd4PegRJTJMtra9nBw/s854wFnZTh7j0cLb8kNOsoKp2alPi2lJhb5MMg8TuoaEboxWdYSgh3nADFKgXBe1nQBe5AsDmu4zs0CVBnof49mvzgrvVVkK6udGzoNsiCM2kWusH0LKEobKr+YpfdBbqsnCXTloQ==
X-Gm-Message-State: AOJu0YzFrXIeLtYJamzB+Ot9wKT7c04myEyjzQMYy82pZrk7oqGxFwUq
	GfhzKU6pI2kXzQxQHpz3Hq75zMYGHjjtO7VmmtTTNpmdahZ4N4Op
X-Google-Smtp-Source: AGHT+IHZqDV+PjG+eAB4RT1GWSB/ryp4aqtKy4krGNAkERhPctlhLcy3lQdrd3961cy6kTMGmoxXBg==
X-Received: by 2002:a17:906:a45a:b0:a6f:5f26:4d91 with SMTP id a640c23a62f3a-a6f60de27c5mr882207366b.69.1718720535578;
        Tue, 18 Jun 2024 07:22:15 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:22:15 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 5/6] iio: adc: ad7192: Add clock provider
Date: Tue, 18 Jun 2024 17:21:37 +0300
Message-Id: <20240618142138.520192-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 940517df5429..90763c14679d 100644
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
@@ -401,6 +403,88 @@ static const char *const ad7192_clock_names[] = {
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
@@ -412,6 +496,11 @@ static int ad7192_clock_setup(struct ad7192_state *st)
 	if (ret < 0) {
 		st->clock_sel = AD7192_CLK_INT;
 		st->fclk = AD7192_INT_FREQ_MHZ;
+
+		ret = ad7192_register_clk_provider(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register clock provider\n");
 	} else {
 		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
 
-- 
2.34.1


