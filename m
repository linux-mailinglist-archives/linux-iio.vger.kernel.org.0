Return-Path: <linux-iio+bounces-1375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43588214AC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EE51F216C0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B158BEA;
	Mon,  1 Jan 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwLBEBUk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2C8BE5;
	Mon,  1 Jan 2024 17:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCAAC433CD;
	Mon,  1 Jan 2024 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130032;
	bh=NoaInyKDXXKAWIBNh2Y6HmB+ZYllxwGac6xFuLVTrLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwLBEBUkzA6FpinDqOCjczE7JwqqSboOG7wX9QCo3Xw4tXRKKuUNJc9iX1OuIDB3S
	 r7dd/jBr3Pym1t09t74rqm0Av5IhDTd75gJTPly1jBbikXJmhUEDH1Lxnql+QnRfIP
	 KaiDvdZY1mehvHfczne/CUfJUBMJ9Mh/0jG6aaHjCMbPwSp/FDnYoi5tJqXXuPgEWF
	 nGElfTeKlppoFxUSvbsM0sIeW7teTqiGlPUmi+8ZW5t3gvnW17Ghe7YyAC/XbPH8Sk
	 9mTPQNUWu2RREsG192Fpjm51CRtWoKQWtli6hZDwpPKMTCQI4V1cHXTXSdRUMekHTT
	 Tkep4ocULYibA==
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
Subject: [RFC PATCH 06/13] iio: adc: stm32: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:04 +0000
Message-ID: <20240101172611.694830-7-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Note this includes a probably fix as in one path an error message was
printed with ret == 0.

Took advantage of dev_err_probe() to futher simplify things given no
longer a need for the goto err.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 62 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b5d3c9cea5c4..c2306aeb5641 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2187,7 +2187,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *channels)
 {
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 	const char *name;
 	int val, scan_index = 0, ret;
 	bool differential;
@@ -2195,50 +2195,43 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 
 	device_for_each_child_node(&indio_dev->dev, child) {
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
@@ -2247,11 +2240,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
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
@@ -2261,11 +2252,6 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
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
2.43.0


