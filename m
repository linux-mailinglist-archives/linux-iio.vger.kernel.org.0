Return-Path: <linux-iio+bounces-3957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF677892CBA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A45B22079
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763E40846;
	Sat, 30 Mar 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo9RHRe4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4B200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825767; cv=none; b=rl+92ybSo7T2fXUMOT36XEBRtXuNHLmpi23TapahRy/r+FBnzeUbbQe57iYwZ8x2rsrVxOiKrJTmmfjJqapo4GPP86Ge8dfl1+dPRS0KssDbrF/CKVeulcJxjP17xlb2B5Cmxx2zawyB2xKlABKAx9KF4F48kPQyn3LQPCyY+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825767; c=relaxed/simple;
	bh=qf+vFt4eHBKb9wC1ML+JrZeUlBlFfrqpC/PNsmXCNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4vGKihNJiN3qcrCD7oXN2xZwGHjh1vIxnyWUJMqYa9GV9dwhOqwFLKwHDQitXmxDE2kTn21AUUhhcor00Wv5VqaUUkeJ3kok0h/S8PT5CyDbkTQtiA90dKN7UYWTiqyxkt4LRCrFXRCUyYw5uHIoEQ9zqsMD2/rRoWED6M/o88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo9RHRe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64283C433F1;
	Sat, 30 Mar 2024 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825767;
	bh=qf+vFt4eHBKb9wC1ML+JrZeUlBlFfrqpC/PNsmXCNhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uo9RHRe4DIrrcBYYkXjFVCXY9HnZki/b3Wu4w9depCOHFFim0Hbsy3KIDikSqbBSQ
	 gDsZNhwZKpuaiCQ6CBoBgAvx9XXuR9QnY19AS+NOYrDNN3oPbWlE/U1g6hfSkw+ZHf
	 gZiW71YEw+LNYQezyvE0PMib0KhmNTy2I4XAH997vDFfGYjduYBcz0NJSoa23RVG8J
	 6o3Gh0GPmAMmJ4mNTFjjh1EcO1ujOEBAmES2k2mDBifeA0E4d4nBKo9nMPRa+TSXZG
	 SPQmgf9UxdRC62ftSYJwNg6izFruGuHN0DwjyZW/edyIQ6uyM2oUe58Mm4+/R87y5i
	 oGk4TK+HhfGEA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: dac: ad3552: Use __free(fwnode_handle) to simplify error handling.
Date: Sat, 30 Mar 2024 19:08:48 +0000
Message-ID: <20240330190849.1321065-8-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

By using this scoped based cleanup direct returns on errors are enabled
simplifying the code.

Cc: Mihail Chindris <mihail.chindris@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3552r.c | 59 +++++++++++++++------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e14a065b29ca..8aa942896b5b 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -801,51 +801,45 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 					 u32 ch)
 {
 	struct device *dev = &dac->spi->dev;
-	struct fwnode_handle *gain_child;
 	u32 val;
 	int err;
 	u8 addr;
 	u16 reg = 0, offset;
 
-	gain_child = fwnode_get_named_child_node(child,
-						 "custom-output-range-config");
-	if (!gain_child) {
-		dev_err(dev,
-			"mandatory custom-output-range-config property missing\n");
-		return -EINVAL;
-	}
+	struct fwnode_handle *gain_child __free(fwnode_handle)
+		= fwnode_get_named_child_node(child,
+					      "custom-output-range-config");
+	if (!gain_child)
+		return dev_err_probe(dev, -EINVAL,
+				     "mandatory custom-output-range-config property missing\n");
 
 	dac->ch_data[ch].range_override = 1;
 	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
-	if (err) {
-		dev_err(dev, "mandatory adi,gain-scaling-p property missing\n");
-		goto put_child;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "mandatory adi,gain-scaling-p property missing\n");
 	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
 	dac->ch_data[ch].p = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
-	if (err) {
-		dev_err(dev, "mandatory adi,gain-scaling-n property missing\n");
-		goto put_child;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "mandatory adi,gain-scaling-n property missing\n");
 	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
 	dac->ch_data[ch].n = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
-	if (err) {
-		dev_err(dev, "mandatory adi,rfb-ohms property missing\n");
-		goto put_child;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "mandatory adi,rfb-ohms property missing\n");
 	dac->ch_data[ch].rfb = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
-	if (err) {
-		dev_err(dev, "mandatory adi,gain-offset property missing\n");
-		goto put_child;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "mandatory adi,gain-offset property missing\n");
 	dac->ch_data[ch].gain_offset = val;
 
 	offset = abs((s32)val);
@@ -855,21 +849,14 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
 	err = ad3552r_write_reg(dac, addr,
 				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
-	if (err) {
-		dev_err(dev, "Error writing register\n");
-		goto put_child;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Error writing register\n");
 
 	err = ad3552r_write_reg(dac, addr, reg);
-	if (err) {
-		dev_err(dev, "Error writing register\n");
-		goto put_child;
-	}
-
-put_child:
-	fwnode_handle_put(gain_child);
+	if (err)
+		return dev_err_probe(dev, err, "Error writing register\n");
 
-	return err;
+	return 0;
 }
 
 static void ad3552r_reg_disable(void *reg)
-- 
2.44.0


