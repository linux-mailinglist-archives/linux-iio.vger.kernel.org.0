Return-Path: <linux-iio+bounces-2715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B74859125
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F41C20F0C
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC57D40A;
	Sat, 17 Feb 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ued95WNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCE7D403;
	Sat, 17 Feb 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188276; cv=none; b=DN5hJpeWtlRhwNmyz9dNG/CP5Cf9ew0LPRvV7S2aGA5o0t1G7aeOTLtCe6esf+/5KhonBMiOhnE43k3sGsZpzo3jrU0dxJLV5SyHszo651b3OVO/eArmn6d19HOeTONl0pX/tdknT+jU8LdgBKGjuLgykgLFxA8a0kexT7USFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188276; c=relaxed/simple;
	bh=79c8DCrGZAScdvyIHMIvQJjPXB+eFzdJE93eK/ZtP+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drd+5t7L4aCRqe19yLs+prp0HKdCWIdJnp46F45yRzd5suRDj8RbXjv2CYEFkqns0u40ldkgYRjz+3mf8enX6EdvCdmuHkByOj6JWfqqN9//ToUhOlJAx5fTu4KB48V5M3tD4dW09gKY1mH3Cxl7HWOJ5N76XUmNjHjiZNG2+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ued95WNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B63EC43390;
	Sat, 17 Feb 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188275;
	bh=79c8DCrGZAScdvyIHMIvQJjPXB+eFzdJE93eK/ZtP+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ued95WNsy1SeM7nuVo8E9EIVN+vMLCvjAC5TeM1nIjFmIwKXRmx2r9HlTZG5RNXma
	 6JcHTm7BncwGuCsrW8hrJEuWUfWBjoP50qQIPUBw7zQ+jpf/MU6wBLIElrIn4WQETB
	 33CQsG8IvmndEXgTncNJyzK1tYfu95BWLXpK2YHESn1Q5iEkrdOXtOIw56o4ELGoUk
	 4LZlriMolC1YQViJLhCRfa+NvKvMsj0EY3cy66BNuyvj8tKVAni9+giosYLjhneBM5
	 vO6M8rYB/pvvRa0RBrXQhlKYlgHz9DnNAt8I8YaWbkQ1Qa9llMs0TUjW+Ja3CgPYwN
	 kJ/cXK/a0jGUA==
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
Subject: [PATCH v4 15/15] iio: dac: ltc2688: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:49 +0000
Message-ID: <20240217164249.921878-16-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
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
v4: Moved alignment changes back to patch 4.
v3: Tweaked the alignment after comments from Andy.

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
2.43.2


