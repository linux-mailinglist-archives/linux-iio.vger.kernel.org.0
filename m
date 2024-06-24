Return-Path: <linux-iio+bounces-6808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8A914B14
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B82B2486F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA113DDBA;
	Mon, 24 Jun 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCnDgBuH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168B13DBA0;
	Mon, 24 Jun 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233429; cv=none; b=hLy3qI48kPxZcBHUYEI1j0JNPN2Fw2d9NqGPnYUkIRg+SBN3zMPAjWQo39kmyQIZgvb4U4mJY3OZG7IFWuQK55kBLy0bDKA0GudYXRcD1+jJttBUhWwPcZ1SnEXmUP3vYK7OJdA/5ege0jc25B0jvrdMecc8CsJ2dg/MZBwLlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233429; c=relaxed/simple;
	bh=pWCyGoSwbSVi51UcYwjzYptyAKhEQbLVCZhUW0i1vc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QX44KwCmlJ+uU96oBqRUIAUKnhWEDufR2rrK1Zq/feP9LTjrcer8s4vsU2B4KmbAj+pxKPfJeRh1A6bek5i5JkJqnwgrz+z6MZS/wmr+tQpFEwuW8MfPwE4JL4k8pI+23jbjgKjtZ48ZuIB0gqmm3ip/LV/vsWoIp1EVXAIgifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCnDgBuH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso35695255e9.3;
        Mon, 24 Jun 2024 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233426; x=1719838226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIFPwPUe239jQzWzpuE4uB77KNgGi1q0uRESeNjXXyI=;
        b=CCnDgBuHbmriKslf8YSCRqeP1Ur9Xvsaph1pbH+KgS8ZgmEjt5x7kBPB/N+YkTkjCG
         K3l2VJyxfB0u2bBxIIsgR+HwGw3EwGWFvihpSLI1vGlgDXcYPAQTaqIkOr9o77y59SNR
         bvjLqPiEwZBOU1tPaRgtOKlwE3o5Ix8LaJM8vXRhvU1YZfTOToTK751Y+K1/wXFdRlfH
         waxznc3YUqjr2UoZJMzFWd7lm0466VFs0hOwRQ1tG9QCrALKiZajL8CEBfwVts3loF5x
         fN2QGjpJ9aShAlZSijvcXhOF6NvGBwlUs2PNw6GWb8Cj/r7ir2e37uBPK5w4DI+BnZ/+
         Ntjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233426; x=1719838226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIFPwPUe239jQzWzpuE4uB77KNgGi1q0uRESeNjXXyI=;
        b=ocFrAp2cAwAndFYzAIq6xBfDtJLKhVBaU73bliGmrncSBA7QDinN4Y3xzESSIZ9fDh
         v/Vlc/ymmKnUOC2GmLyanqKNjU2IqqERUipHtm4+uqdy+mVJ2RLYa6rGn0nrok8X0Egv
         MunU/MlrMBqvkio5aeOB/VrjwvFxbA0Z/w7/pjJYeXcI8TgW4zrCaQw3pnPM65pxC921
         j0pph5um5HwgI8vPbMN6sb3Jedi0ucAQHXlKCKyB3p4OqVUNrtJx2lHRd/PJUf5IOA5m
         yGL6xU/woNjlqLFYB8lfA87GVd0w4qK5NnQr5P6A+5RaHgQ5ioG/f0WnkD0Ghpms/CyO
         E9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvpr29yXyD55q9zui+y/Rk65WNm9ebgIDmNdsEG3DeVNz3lcGBw+48U4J8QG9vDVNZCSU0aybJHQluM4SpMCXAeLhZun27D8dyWiyIGiQHBXK9ZkJv69wPt5LTnDcZWqqPkxOpSeUIuHQwtO8gd+LWMiPLKalpXGRHopnbmn9FZfpOzA==
X-Gm-Message-State: AOJu0YyUS8tvsY7UybTyDFhfJ93cm7y69yD2KuQnQCaA76LziIAzW7tl
	gy7Tbd9BsK6CXbLjML4x9/SrRMoFYXVxMCl/YEtmQwzWDXUbhuBV
X-Google-Smtp-Source: AGHT+IHmyjK36pKqyTQWC5GhQhakJszDnv0awVLvhIavnLVLWesTt9RnwQUJraKItpMARSmboP0XLg==
X-Received: by 2002:a05:600c:3209:b0:424:7d42:fd7a with SMTP id 5b1f17b1804b1-4248cc2b71cmr29101425e9.15.1719233425580;
        Mon, 24 Jun 2024 05:50:25 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:25 -0700 (PDT)
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
Subject: [PATCH v6 5/6] iio: adc: ad7192: Add clock provider
Date: Mon, 24 Jun 2024 15:49:40 +0300
Message-Id: <20240624124941.113010-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624124941.113010-1-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
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


