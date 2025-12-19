Return-Path: <linux-iio+bounces-27222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94CCD08FF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897C430198D4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A33043CF;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1LjBpfZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0061D5CDE
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158798; cv=none; b=RWMsXeYEnzMkabOsdKukUIltwLihXlQbOvxusFtvmB4YI3DQEoF6m0lluMf2B/AAeEVquY8xGJwei99GsE5ASd8uZW5jyndpDkqwbD/ya74L+xnNqd90Yx2y9ztkrEYm+x286dbdpcmNn+kogmtXfnmAUkM2NQWX5R91qSqVcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158798; c=relaxed/simple;
	bh=MsgS3V6nKY3NhR+38S5yI6d0j6nouq3oZOuFX0shz4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTaSUGaIvxacovWDHuyFIvR3W65M/8yNQYYk2GQaSd+YF04JoW6TtHl6YgAyWf/etkuyz+xJdjx3u4/eY3r/iyAcnzPQ3F+GIhqN4Pafhi80VJO6k+mhKNtvOzz63lha8EUT7CtWnrQPiz3Cn25rvtymMPhY98RLOd3Shix6czs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1LjBpfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44CB5C116C6;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158798;
	bh=MsgS3V6nKY3NhR+38S5yI6d0j6nouq3oZOuFX0shz4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i1LjBpfZQnbd0IhutFP0g850NaLo9TpKoRkzzn4Am/7+E/jyKECopqIHxdw4BUQlP
	 sMSWV0ApNp4CI081hPQDzRL4GZY12/J6WJLqZJKe7pUwJY+JWrFlsf2SieKsWCFNQ9
	 FDw/x7Y8w6sYkvhPJqcysXwHZPv3PAL2cu2wlCkKN/1Q95/zaF+S+ybJSiaVPkcxDa
	 5hAPAI/SoJ34XW6UR/9hyUe+07trQFdUcKCD5kF3eylkUggVtIRx1rwEXqv3dAI71e
	 EH/c9PrgWwP85MFK3fqsIS9BjAE4xum7jTsf2EVn0u/OTNKYA2eCf69OgsJic9vf2z
	 7qOxEPpQZkggw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3CBD7878F;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:40:38 +0000
Subject: [PATCH v2 1/2] iio: adc: adi-axi-adc: Make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-axi-adc-minor-change-v2-1-9d8e7270d19a@analog.com>
References: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
In-Reply-To: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158839; l=4565;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oHs2gO9Z+A4UBC3gUh/2igVe4IU86xADf2YizQZ15C4=;
 b=tHOxdkTxf6j531HokggW4owFLqxnmrPbD2D+w/wLoRatq3CklK/O2jfIB1ziXIcbN463rRMZL
 Uu9mIzesrt+DiNSqgtYQI5WDgXJnwL/5VZgdWCazhhLizI6igG+1c4s
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Be consistent and use dev_err_probe() as in all other places in the
.probe() path.

While at it, remove the line break in the version condition. Yes, it
goes over the 80 column limit but I do think the line break hurts
readability in this case. And use a struct device *dev helper for
neater code.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 55 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b9..fef4fdedb976 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -674,13 +674,14 @@ static const struct iio_backend_info axi_ad408x = {
 
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
 	struct clk *clk;
 	int ret;
 
-	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
@@ -688,20 +689,19 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	st->dev = &pdev->dev;
-	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					   &axi_adc_regmap_config);
+	st->dev = dev;
+	st->regmap = devm_regmap_init_mmio(dev, base, &axi_adc_regmap_config);
 	if (IS_ERR(st->regmap))
-		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
-	st->info = device_get_match_data(&pdev->dev);
+	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
 
-	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "failed to get clock\n");
 
 	/*
@@ -716,47 +716,42 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
-	    ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
-		dev_err(&pdev->dev,
-			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
-			ADI_AXI_PCORE_VER_MINOR(st->info->version),
-			ADI_AXI_PCORE_VER_PATCH(st->info->version),
-			ADI_AXI_PCORE_VER_MAJOR(ver),
-			ADI_AXI_PCORE_VER_MINOR(ver),
-			ADI_AXI_PCORE_VER_PATCH(ver));
-		return -ENODEV;
-	}
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version))
+		return dev_err_probe(dev, -ENODEV,
+				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
+				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
+				     ADI_AXI_PCORE_VER_MAJOR(ver),
+				     ADI_AXI_PCORE_VER_MINOR(ver),
+				     ADI_AXI_PCORE_VER_PATCH(ver));
 
-	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
+	ret = devm_iio_backend_register(dev, st->info->backend_info, st);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to register iio backend\n");
+		return dev_err_probe(dev, ret, "failed to register iio backend\n");
 
-	device_for_each_child_node_scoped(&pdev->dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		int val;
 
 		if (!st->info->has_child_nodes)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "invalid fdt axi-dac compatible.");
 
 		/* Processing only reg 0 node */
 		ret = fwnode_property_read_u32(child, "reg", &val);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "invalid reg property.");
+			return dev_err_probe(dev, ret, "invalid reg property.");
 		if (val != 0)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "invalid node address.");
 
 		ret = axi_adc_create_platform_device(st, child);
 		if (ret)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "cannot create device.");
 	}
 
-	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
+	dev_info(dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
 		 ADI_AXI_PCORE_VER_PATCH(ver));

-- 
2.52.0



