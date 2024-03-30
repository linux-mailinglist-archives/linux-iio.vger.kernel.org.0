Return-Path: <linux-iio+bounces-3945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEC892CA9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0191C212E9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166743BB3D;
	Sat, 30 Mar 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7dHe0Fn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF922E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824820; cv=none; b=ESPImAwBxSmH2QGk5nuBcfhrjt/6EygIMA2H7YBohgBEAwWAd2FVb9V/87tdQ6mZu8bzT1xRfrQQLwMaNwAxtp9aIa+7ZuWgoNfPlVGT5IpDLMK/LztWJ8a8BFakkf0t97WVLGPvFJ89nvkoJmSpW4ClEu0Rkeo/fnFGCzDwD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824820; c=relaxed/simple;
	bh=GyZokidgfiKOI3dm6Xikc4mrpsDk2vVQCCEtCsT2gqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UayW1Yr8X0xL7ncn7NR4NOf4VVx9sgj4ZoT0bnRHluxziRv1dAfczYKqC9oYMLQhnD5GJMimVsxzWZArTbuVNdclZ+Q6hQaIi4GlJnPb7m+s9W+fLGvdKZ42zdF7b4GDVMFSRiHU74xxoI8dZUN3p7WQT9DbUgLZSuiuTW1jIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7dHe0Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D401C433F1;
	Sat, 30 Mar 2024 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824820;
	bh=GyZokidgfiKOI3dm6Xikc4mrpsDk2vVQCCEtCsT2gqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7dHe0FnnZuLcYUOa8Y1bj/phv/03qUdfH5DGggdFM9kqJwC/RuB78OeuKWouZP3Y
	 sRFgY0CYWEfyWZ0ASaKLYUrodkvrOT2YWeqO3EzFAFJZU3q/QruICnR7n0VRLFOfd4
	 NMj4DXrYbU0TEYCeyR2EaD72CztVCg2/7Ep67h4RK++HzMdTA+GMkWVv3ntTaHWTST
	 kXDtOwrbzQ8lSB1MpRrz4xBG4l6RqmZM0T7JtRAxAWIezJ+18P6MPbT7+AHzm3rfGM
	 derqrCYFkjq2oQHNI5mULAVZGczt+akMh0LVI1mLY1SJ5fwOMM1asy12IEXWzHFR6U
	 W6mMEXTWZXidg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH v6 4/8] iio: adc: stm32: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:53:01 +0000
Message-ID: <20240330185305.1319844-5-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Note this would have made the bug fixed in the previous path much
less likely as it allows for direct returns.

Took advantage of dev_err_probe() to futher simplify things given no
longer a need for the goto err.

Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-adc.c | 62 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 283c20757106..36add95212c3 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2187,59 +2187,52 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *channels)
 {
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
-	struct fwnode_handle *child;
+	struct device *dev = &indio_dev->dev;
 	const char *name;
 	int val, scan_index = 0, ret;
 	bool differential;
 	u32 vin[2];
 
-	device_for_each_child_node(&indio_dev->dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &val);
-		if (ret) {
-			dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
-			goto err;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing channel index\n");
 
 		ret = fwnode_property_read_string(child, "label", &name);
 		/* label is optional */
 		if (!ret) {
-			if (strlen(name) >= STM32_ADC_CH_SZ) {
-				dev_err(&indio_dev->dev, "Label %s exceeds %d characters\n",
-					name, STM32_ADC_CH_SZ);
-				ret = -EINVAL;
-				goto err;
-			}
+			if (strlen(name) >= STM32_ADC_CH_SZ)
+				return dev_err_probe(dev, -EINVAL,
+						     "Label %s exceeds %d characters\n",
+						     name, STM32_ADC_CH_SZ);
+
 			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
 			if (ret == -ENOENT)
 				continue;
 			else if (ret)
-				goto err;
+				return ret;
 		} else if (ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
-			goto err;
+			return dev_err_probe(dev, ret, "Invalid label\n");
 		}
 
-		if (val >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
-			ret = -EINVAL;
-			goto err;
-		}
+		if (val >= adc_info->max_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid channel %d\n", val);
 
 		differential = false;
 		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
 		/* diff-channels is optional */
 		if (!ret) {
 			differential = true;
-			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
-				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
-					vin[0], vin[1]);
-				ret = -EINVAL;
-				goto err;
-			}
+			if (vin[0] != val || vin[1] >= adc_info->max_channels)
+				return dev_err_probe(dev, -EINVAL,
+						     "Invalid channel in%d-in%d\n",
+						     vin[0], vin[1]);
 		} else if (ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid diff-channels property %d\n", ret);
-			goto err;
+			return dev_err_probe(dev, ret,
+					     "Invalid diff-channels property\n");
 		}
 
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
@@ -2248,11 +2241,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		val = 0;
 		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
 		/* st,min-sample-time-ns is optional */
-		if (ret && ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
-				ret);
-			goto err;
-		}
+		if (ret && ret != -EINVAL)
+			return dev_err_probe(dev, ret,
+					     "Invalid st,min-sample-time-ns property\n");
 
 		stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
 		if (differential)
@@ -2262,11 +2253,6 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 	}
 
 	return scan_index;
-
-err:
-	fwnode_handle_put(child);
-
-	return ret;
 }
 
 static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
-- 
2.44.0


