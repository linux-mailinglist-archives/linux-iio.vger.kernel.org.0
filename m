Return-Path: <linux-iio+bounces-2666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDA858497
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13BD28377E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E61332A8;
	Fri, 16 Feb 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFWtEGUj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EA13328F;
	Fri, 16 Feb 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106014; cv=none; b=Zj8S18YsUhuY+fRdAC45puJyEipaLKjTqtUTkLQlLVaByHAQ3hTanedY1MYLOD4ytT/MPM/qw79wsDvIDC1SekoiG8vKA10WX1tJp7N20IDDcKe8+12usCOBhZ0P+Dt8YX7GzvutMW1ahIC3XdGytdsWvwL7JF3B7z/Tt4KYSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106014; c=relaxed/simple;
	bh=L/DROO4YPVYunSdXLSEqe6Sr2aGPuWHRhNS+WcDI2Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL9HiqCqEtNJAFn5kOYX8gd997x13C53RAjSM1i9pgvYmbLLwpKseP1EFvvSLPu51zWdIy90Rou8POgTcs3HvgjmQ0RwaR52Bpm91ewo98udilJ/IGd7JyGptEh9VJfyRU7us8RzYyOFOZmkyU2vp1TewjROGync7FAPrVLIYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFWtEGUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4FAC433F1;
	Fri, 16 Feb 2024 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106013;
	bh=L/DROO4YPVYunSdXLSEqe6Sr2aGPuWHRhNS+WcDI2Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFWtEGUjuAQEzN2TjfPkGSniLd+VYSGkIhBmZiD/F2SV9q/JB7mcblF2Uxm3yXtbV
	 6p1+TpY4CUVzIN+Sd9wgUlAO1EAGw6nBrd4p8GUST40C9upbPUIYcL9fUyQtUgPhZP
	 rnVEsNmlnCpb/VRhRVfCbunnrUbESMTyDoxO1nNyTNRwvXPemE6rfWSMUXj3qJtXan
	 WM+h26+fGZjZVEQ+YBMMXgiEUDT6n7Oj7nE8TLzfp8wLN5vtYL9dhwCKRcguIz5hZd
	 PJYTiq4fHyJmOBIV29t5982AtWPRWBSddvbeeFu2t01sP/8hn5BOMzDofH4C77LOCU
	 IqFxXGuY/cPAQ==
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
Subject: [PATCH v3 09/15] iio: adc: stm32: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:15 +0000
Message-ID: <20240216175221.900565-10-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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

Note this includes a probable fix as in one path an error message was
printed with ret == 0.

Took advantage of dev_err_probe() to futher simplify things given no
longer a need for the goto err.

Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-adc.c | 63 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b5d3c9cea5c4..9fd94a792f42 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2187,58 +2187,50 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *channels)
 {
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
-	struct fwnode_handle *child;
 	const char *name;
 	int val, scan_index = 0, ret;
 	bool differential;
 	u32 vin[2];
 
-	device_for_each_child_node(&indio_dev->dev, child) {
+	device_for_each_child_node_scoped(&indio_dev->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &val);
-		if (ret) {
-			dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
-			goto err;
-		}
+		if (ret)
+			return dev_err_probe(&indio_dev->dev, ret,
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
+				return dev_err_probe(&indio_dev->dev, -EINVAL,
+						     "Label %s exceeds %d characters\n",
+						     name, STM32_ADC_CH_SZ);
+
 			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
 			if (ret == -ENOENT)
 				continue;
 			else if (ret)
-				goto err;
-		} else if (ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
-			goto err;
-		}
+				return ret;
+		} else if (ret != -EINVAL)
+			return dev_err_probe(&indio_dev->dev, ret, "Invalid label\n");
 
-		if (val >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
-			ret = -EINVAL;
-			goto err;
-		}
+		if (val >= adc_info->max_channels)
+			return dev_err_probe(&indio_dev->dev, -EINVAL,
+					     "Invalid channel %d\n", val);
 
 		differential = false;
 		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
 		/* diff-channels is optional */
 		if (!ret) {
 			differential = true;
-			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
-				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
-					vin[0], vin[1]);
-				goto err;
-			}
+			if (vin[0] != val || vin[1] >= adc_info->max_channels)
+				return dev_err_probe(&indio_dev->dev, -EINVAL,
+						     "Invalid channel in%d-in%d\n",
+						     vin[0], vin[1]);
 		} else if (ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid diff-channels property %d\n", ret);
-			goto err;
+			return dev_err_probe(&indio_dev->dev, ret,
+					     "Invalid diff-channels property\n");
 		}
 
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
@@ -2247,11 +2239,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		val = 0;
 		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
 		/* st,min-sample-time-ns is optional */
-		if (ret && ret != -EINVAL) {
-			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
-				ret);
-			goto err;
-		}
+		if (ret && ret != -EINVAL)
+			return dev_err_probe(&indio_dev->dev, ret,
+					     "Invalid st,min-sample-time-ns property\n");
 
 		stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
 		if (differential)
@@ -2261,11 +2251,6 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
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
2.43.2


