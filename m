Return-Path: <linux-iio+bounces-2436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5937B850B38
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D938C1F23E21
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8805D90B;
	Sun, 11 Feb 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF/6R2H+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5505D478;
	Sun, 11 Feb 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679677; cv=none; b=DLOByX2Q1zSInBt/KO5gqFkU6TdOZzRQELmn+j8lQ55N5FrUhqAI61Lk1CM0SjvmB9LPhUlnPAUEuuk9b4MuNRK5ekQdzIMqBmcCs0lpQSSxcfBQPRUuWLDXWE96O47mb42xjrp3dpS7murR1Ayh6GJjmsZXeprAB3/PFGalqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679677; c=relaxed/simple;
	bh=HkWB5H4zBCE15CCo9JBn41UFUpV14sxEaj2qAo0OdjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3/9ObbX5rIsP03ot3hpsMLYHi94+VbhKHVwg+6t5ghruu/RvW2beQQeIX/fl3xQmSBAIz+SunT6TZQPXzP/BOFzAmP+6JLfgfQFsNdpge58kHFgJ8ygCTjmLnCX9Hv6Tw8Q8WapIwI824ztcAxqmzRfV/phxGFjx0h6h7Kb+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF/6R2H+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A09C433F1;
	Sun, 11 Feb 2024 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679676;
	bh=HkWB5H4zBCE15CCo9JBn41UFUpV14sxEaj2qAo0OdjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sF/6R2H+BFKVTDUf44QTlZ7nOugrL6fEFCgWh3+/xXJmvtgm1fb7+VCFQMv2ZBQSH
	 e8534fSXREa/NjSLS7Msww7ulqv/0hGBwRDkGismZO8ymQ63IM1mJZ1khNVstIMfaK
	 7JFlM4VqLbls6szEn4X/+WDKgRWgCm4YH1QD5MK3IGBcUHrbSarYUQLxzRPYD1slG7
	 DiSI+lG1GMuMrFKgmA0q5rqg+Kp3Vpn3uUYKqZ/bDKM5Bx1dA8qIE8No8W6z0sok5v
	 eQLFhs1k2FKvUr5lUELzB0MvXoi04KiquGCghrBtKGwxpBoLukyRIJ/J6a0H+/NrgR
	 z/Tyokxbay2qQ==
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
Subject: [PATCH v2 14/14] iio: dac: ltc2688: Use device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:40 +0000
Message-ID: <20240211192540.340682-15-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ltc2688.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

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
-- 
2.43.1


