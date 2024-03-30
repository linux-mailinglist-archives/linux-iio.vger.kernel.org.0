Return-Path: <linux-iio+bounces-3956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3E892CB8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E8E1C2148F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5564084A;
	Sat, 30 Mar 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx2W28Zw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358F200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825764; cv=none; b=JzIVw6ggqSvfDeRyT7zojWVsRkj9uJql1DErWNhm7M1fivVamLBcUOHl8hyoMBgCioRD0Xw1Kxu0YSmPqC1bsUwZRKfU9M82zmGfGYSgT8nZLjVwv9MRpNPW/9DQBTbViw7X0NsZeaMq7r/5PEcup/mZUhqx0EvMT1sYJzzu70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825764; c=relaxed/simple;
	bh=CAkeo+GKk3RatumWU31CHPHEyLJ87H39Sk1V9uNQku4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxf1O2k8duzsuiO9C3IMiiIewLS41fQQX5zp0MXmt08UExuStpBXJPToovck9PT38LD492Vk8WKir+2QYUZjLgInPU3pTB2EsrbSKC1GXNYofT1zjvw+Dk8f045IwaLOl8ODu9AIsiiibIEyDQPjjaAzNcnZIKYm1q5TMwvPtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx2W28Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E3CC43390;
	Sat, 30 Mar 2024 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825763;
	bh=CAkeo+GKk3RatumWU31CHPHEyLJ87H39Sk1V9uNQku4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qx2W28ZwSf+NdI0lgxPF2eOW/c4EsIsgMAKA6oSyvtuUwSrq2Ieln2XxrGtRiEl25
	 E+UFh+d96/glc07dFLCZPONt6LuqYyKrQMm1R6R6Aw+crWl/kIDIxL7wl5tG6icqGi
	 lJGbz//wbflETpCldcCzzRmjCOR36lPi2xIevy0fV2p8vD0ReArtqMdLEUwXrS8GQ9
	 80QGZk0uvrsAhGBvUXUuqA7Z9lhVRAQ8c5CMDZNGW8Lffh8QMNeNUds33G1WmQMh9v
	 qYlQTHGek/b7QukJt91M/QYOu0W8dn0ixtgLov5+Ca5qkffJpQA0AMqSY8Bo3ybTpb
	 VzzvEcVjl0eqQ==
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
Subject: [PATCH 6/8] iio: frequency: admfm2000: Use device_for_each_child_node_scoped() to simplify error paths.
Date: Sat, 30 Mar 2024 19:08:47 +0000
Message-ID: <20240330190849.1321065-7-jic23@kernel.org>
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

This loop definition automatically release the fwnode_handle on early exit
simplifying error handling paths.

Cc: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/admfm2000.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
index c34d79e55a7c..b2263b9afeda 100644
--- a/drivers/iio/frequency/admfm2000.c
+++ b/drivers/iio/frequency/admfm2000.c
@@ -160,26 +160,21 @@ static int admfm2000_channel_config(struct admfm2000_state *st,
 {
 	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
 	struct device *dev = &pdev->dev;
-	struct fwnode_handle *child;
 	struct gpio_desc **dsa;
 	struct gpio_desc **sw;
 	int ret, i;
 	bool mode;
 	u32 reg;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to get reg property\n");
-		}
 
-		if (reg >= indio_dev->num_channels) {
-			fwnode_handle_put(child);
+		if (reg >= indio_dev->num_channels)
 			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
 					     indio_dev->num_channels);
-		}
 
 		if (fwnode_property_present(child, "adi,mixer-mode"))
 			mode = ADMFM2000_MIXER_MODE;
@@ -196,36 +191,29 @@ static int admfm2000_channel_config(struct admfm2000_state *st,
 			dsa = st->dsa2_gpios;
 			break;
 		default:
-			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 
 		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
 			sw[i] = devm_fwnode_gpiod_get_index(dev, child, "switch",
 							    i, GPIOD_OUT_LOW, NULL);
-			if (IS_ERR(sw[i])) {
-				fwnode_handle_put(child);
+			if (IS_ERR(sw[i]))
 				return dev_err_probe(dev, PTR_ERR(sw[i]),
 						     "Failed to get gpios\n");
-			}
 		}
 
 		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
 			dsa[i] = devm_fwnode_gpiod_get_index(dev, child,
 							     "attenuation", i,
 							     GPIOD_OUT_LOW, NULL);
-			if (IS_ERR(dsa[i])) {
-				fwnode_handle_put(child);
+			if (IS_ERR(dsa[i]))
 				return dev_err_probe(dev, PTR_ERR(dsa[i]),
 						     "Failed to get gpios\n");
-			}
 		}
 
 		ret = admfm2000_mode(indio_dev, reg, mode);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.44.0


