Return-Path: <linux-iio+bounces-1663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCF82D1B3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78AEBB21221
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D4747A;
	Sun, 14 Jan 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0rRQTcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F679DB;
	Sun, 14 Jan 2024 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B51BC433C7;
	Sun, 14 Jan 2024 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252899;
	bh=4zh9/4F6fmtvl9cxLEHeu+OT6eosb1NjKDCeK0qyyJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0rRQTcEPvuvcxErZf8zQQGzDHKBRVqhBKkvMV41eg9ktZMS8OYTaMpuROdJM0tzl
	 ++cadBXqF56SLJ11tJ2LuKHaz5UFKfDl6fMdxH5NsKYijQ1gfpNWUpOUxsHcl5JcZM
	 ZzBV4aWeTJzIjmc++U+9Fs+LsSzRBK9MfpeICofb6eu54Ah5e0JsKsGFyqnLDorG2A
	 pA0AMxS9ysJ3LjZWzdZL+oTzTevr2IwS7LS8lsUKvXBjmMHWN1zvOVpa0Pzp5BkCzM
	 864evP1B7SzygUrj5Kr9aajOtxHGh0jjNkW1RxV/Qm8V8ax23nU7zOMlZdgXE4MJsO
	 MUSyHrnb7FIlw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/13] iio: dac: ltc2688: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Sun, 14 Jan 2024 17:20:08 +0000
Message-ID: <20240114172009.179893-13-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ltc2688.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index fc8eb53c65be..e8add3636af9 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -746,7 +746,7 @@ static int ltc2688_span_lookup(const struct ltc2688_state *st, int min, int max)
 static int ltc2688_channel_config(struct ltc2688_state *st)
 {
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 	u32 reg, clk_input, val, tmp[2];
 	int ret, span;
 
@@ -754,18 +754,14 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
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
@@ -786,12 +782,10 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
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
@@ -800,17 +794,14 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
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
@@ -844,11 +835,9 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 
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
2.43.0


