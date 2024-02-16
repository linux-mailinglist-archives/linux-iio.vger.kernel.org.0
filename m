Return-Path: <linux-iio+bounces-2672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A28584A6
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DD1F22636
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EC133401;
	Fri, 16 Feb 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1F1pqyj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFA13174F;
	Fri, 16 Feb 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106053; cv=none; b=eEdT2cXRQwDJWF8BZWtgcJlDR6Qo6h4GG6b6q2GFTuRSGBd/Pm56vntj0fouCvKd2FAr4IgraPmMt0w/g/8cR4tiwd1PPvNTpCyUfBWKI7uQ47GokNEwhfEmR3NUkUr3Kb0ClBXbwuwgvber2sB6A0HCpQeXzSWTg/NDrO+Y2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106053; c=relaxed/simple;
	bh=EfkH807/eaVFKqbyI8JzEQiNG2vd/Mt7Rvy6pBl8J9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxFIBq+wy9GDvEuE9C6DTnQbpcbnSMamdrFzBuPUEslYAzfqoL9Eo1G6Kas5TjL1Pm6Ya8gzMmDUxW7+o/sQuWQUq/JNt+gInkG9ZYqDacdKZ0f09NIXumT97yLXY2XVs8B6Uys7K8SiV2zWqBxMCNNuImxSpG97reUMHMgH2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1F1pqyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF279C433F1;
	Fri, 16 Feb 2024 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106051;
	bh=EfkH807/eaVFKqbyI8JzEQiNG2vd/Mt7Rvy6pBl8J9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1F1pqyj2NnDZagKQprFkPm8Q65Zvzq5YleuPNecSjUsBZw+LAQYGm8dBtt7ty6DV
	 Etbu8gcq9V6zgxEs3xlWL7mRa+8guhwVh8e/jcrtT3zlNmRLfWvrYKq+9wqkNtSwBf
	 5sITLqmyleOj+GgQwhW7JJGFQhoiJl4a5CGc4hxXIYj2Pi7ZWvQ+F3W18OMozTkSZ4
	 cHPUeM/r1MWOgnPsdqWsBAt+RZsYsnKBvnBBH23ObozETjLQVtdBtO5Pie04gSIrz1
	 ZGKNqmXZGOo5AJIsQ4Lhvy33282mDlHGSevc3pQNLy6Q1hRS4iVbw2dJrn8AiHwuW5
	 W1k04qHC+oZrQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 15/15] iio: dac: ltc2688: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:21 +0000
Message-ID: <20240216175221.900565-16-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Tweaked the alignment after comments from Andy.
---
 drivers/iio/dac/ltc2688.c | 24 ++++++------------------
 include/linux/property.h  |  6 +++---
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index fc8eb53c65be..b71df03fc13b 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -746,26 +746,21 @@ static int ltc2688_span_lookup(const struct ltc2688_state *st, int min, int max)
 static int ltc2688_channel_config(struct ltc2688_state *st)
 {
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *child;
 	u32 reg, clk_input, val, tmp[2];
 	int ret, span;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct ltc2688_chan *chan;
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to get reg property\n");
-		}
 
-		if (reg >= LTC2688_DAC_CHANNELS) {
-			fwnode_handle_put(child);
+		if (reg >= LTC2688_DAC_CHANNELS)
 			return dev_err_probe(dev, -EINVAL,
 					     "reg bigger than: %d\n",
 					     LTC2688_DAC_CHANNELS);
-		}
 
 		val = 0;
 		chan = &st->channels[reg];
@@ -786,12 +781,10 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 		if (!ret) {
 			span = ltc2688_span_lookup(st, (int)tmp[0] / 1000,
 						   tmp[1] / 1000);
-			if (span < 0) {
-				fwnode_handle_put(child);
+			if (span < 0)
 				return dev_err_probe(dev, -EINVAL,
 						     "output range not valid:[%d %d]\n",
 						     tmp[0], tmp[1]);
-			}
 
 			val |= FIELD_PREP(LTC2688_CH_SPAN_MSK, span);
 		}
@@ -800,17 +793,14 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 					       &clk_input);
 		if (!ret) {
 			if (clk_input >= LTC2688_CH_TGP_MAX) {
-				fwnode_handle_put(child);
 				return dev_err_probe(dev, -EINVAL,
 						     "toggle-dither-input inv value(%d)\n",
 						     clk_input);
 			}
 
 			ret = ltc2688_tgp_clk_setup(st, chan, child, clk_input);
-			if (ret) {
-				fwnode_handle_put(child);
+			if (ret)
 				return ret;
-			}
 
 			/*
 			 * 0 means software toggle which is the default mode.
@@ -844,11 +834,9 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 
 		ret = regmap_write(st->regmap, LTC2688_CMD_CH_SETTING(reg),
 				   val);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return dev_err_probe(dev, -EINVAL,
 					     "failed to set chan settings\n");
-		}
 	}
 
 	return 0;
diff --git a/include/linux/property.h b/include/linux/property.h
index 421ccfd43fb1..4d3fc4edabbc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -183,9 +183,9 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	     child = device_get_next_child_node(dev, child))
 
 #define device_for_each_child_node_scoped(dev, child)\
-	for (struct fwnode_handle *child __free(fwnode_handle) = \
-	     device_get_next_child_node(dev, NULL); child; \
-	     child = device_get_next_child_node(dev, child))
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		device_get_next_child_node(dev, NULL);			\
+	     child; child = device_get_next_child_node(dev, child))
 
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 						  const char *childname);
-- 
2.43.2


