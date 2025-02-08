Return-Path: <linux-iio+bounces-15183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF26A2D8D7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571A97A36E2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998022E009;
	Sat,  8 Feb 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="e3cTbml3"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA423C8B4;
	Sat,  8 Feb 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049402; cv=none; b=VXdljQkmXogB3Z+QisYP59g2OT2ZEV/xWppC9CzCd4fcFeebdepb/djVbzSY6Kx6MFzTAoBhUNzFTM6yuR9F+HURCc0jihxyVn0LJXnZdN8gwpj/O9jB2TBLWrNNJHkUeZV/ba+LGtRyCxE5w6LYkSIFZsFHDErL7d1H7aFzKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049402; c=relaxed/simple;
	bh=KkY7pTunLI4B4jihyD/Ec32+iIry3PghYhfM7cW50Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhj1LJCUdruuvwemeMr9DrJzm65vjJlT+n0XZj3kZhRkeLY2AAfHo5z0pE7GRBT1cBrVN7E6p1QuMYk6z94E8mpVZqElXOCgyraTLqOHoZEFGKq05TjVBsGkFJ/eagJHbzofdJUHB9Ro4dct5jSU8IkujvKs/SXBmnvZDxPIGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=e3cTbml3; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 3045941B62;
	Sat,  8 Feb 2025 21:16:39 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v5 4/8] iio: light: stk3310: simplify and inline STK3310_REGFIELD macro
Date: Sat,  8 Feb 2025 16:13:22 -0500
Message-ID: <20250208211325.992280-6-aren@peacevolution.org>
In-Reply-To: <20250208211325.992280-2-aren@peacevolution.org>
References: <20250208211325.992280-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049400;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=Mx7GsGGiN8qI/cnEK3cRpdvpl4cmkBeU5/Nkgf8DQFw=;
	b=e3cTbml3prtzCmxHCRYg0uCtzSSdKwUHWsADXg8UBkwdCD/d2zABsDeKwSi0A98k2pyaOb
	BgoyVJgFwfO3GBvxhKhBg/CEwRT/Ib/7pYpAsO5SD8uPWRc/RuDRzniMpnNr+DEruN/iLa
	g6OSGRkUZ79xBVXcdsKELaG7qF953YE=

This macro has a conditional return statement, which obfuscates control
flow. Inlining makes the control flow more clear.

This also switches to using dev_err_probe for error reporting, which is
a shorter way of expressing the same logic as before.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Added in v5

 drivers/iio/light/stk3310.c | 58 +++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 9c38ff01fdf0f..2e883e24dc4b2 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -59,17 +59,6 @@
 	"0.023680 0.047360 0.094720 0.189440 0.378880 0.757760 1.515520 " \
 	"3.031040 6.062080"
 
-#define STK3310_REGFIELD(name)						    \
-	do {								    \
-		data->reg_##name =					    \
-			devm_regmap_field_alloc(&client->dev, regmap,	    \
-				stk3310_reg_field_##name);		    \
-		if (IS_ERR(data->reg_##name)) {				    \
-			dev_err(&client->dev, "reg field alloc failed.\n"); \
-			return PTR_ERR(data->reg_##name);		    \
-		}							    \
-	} while (0)
-
 static const struct reg_field stk3310_reg_field_state =
 				REG_FIELD(STK3310_REG_STATE, 0, 2);
 static const struct reg_field stk3310_reg_field_als_gain =
@@ -568,14 +557,45 @@ static int stk3310_regmap_init(struct stk3310_data *data)
 	}
 	data->regmap = regmap;
 
-	STK3310_REGFIELD(state);
-	STK3310_REGFIELD(als_gain);
-	STK3310_REGFIELD(ps_gain);
-	STK3310_REGFIELD(als_it);
-	STK3310_REGFIELD(ps_it);
-	STK3310_REGFIELD(int_ps);
-	STK3310_REGFIELD(flag_psint);
-	STK3310_REGFIELD(flag_nf);
+	data->reg_state = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_state);
+	if (IS_ERR(data->reg_state))
+		return dev_err_probe(dev, PTR_ERR(data->reg_state),
+				     "reg_state alloc failed\n");
+
+	data->reg_als_gain = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_als_gain);
+	if (IS_ERR(data->reg_als_gain))
+		return dev_err_probe(dev, PTR_ERR(data->reg_als_gain),
+				     "reg_als_gain alloc failed\n");
+
+	data->reg_ps_gain = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_ps_gain);
+	if (IS_ERR(data->reg_ps_gain))
+		return dev_err_probe(dev, PTR_ERR(data->reg_ps_gain),
+				     "reg_ps_gain alloc failed\n");
+
+	data->reg_als_it = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_als_it);
+	if (IS_ERR(data->reg_als_it))
+		return dev_err_probe(dev, PTR_ERR(data->reg_als_it),
+				     "reg_als_it alloc failed\n");
+
+	data->reg_ps_it = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_ps_it);
+	if (IS_ERR(data->reg_ps_it))
+		return dev_err_probe(dev, PTR_ERR(data->reg_ps_it),
+				     "reg_ps_it alloc failed\n");
+
+	data->reg_int_ps = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_int_ps);
+	if (IS_ERR(data->reg_int_ps))
+		return dev_err_probe(dev, PTR_ERR(data->reg_int_ps),
+				     "reg_int_ps alloc failed\n");
+
+	data->reg_flag_psint = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_flag_psint);
+	if (IS_ERR(data->reg_flag_psint))
+		return dev_err_probe(dev, PTR_ERR(data->reg_flag_psint),
+				     "reg_flag_psint alloc failed\n");
+
+	data->reg_flag_nf = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_flag_nf);
+	if (IS_ERR(data->reg_flag_nf))
+		return dev_err_probe(dev, PTR_ERR(data->reg_flag_nf),
+				     "reg_flag_nf alloc failed\n");
 
 	return 0;
 }
-- 
2.48.1


