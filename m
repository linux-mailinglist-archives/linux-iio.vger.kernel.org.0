Return-Path: <linux-iio+bounces-13067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF269E30D1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B58B250C3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D680376E0;
	Wed,  4 Dec 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpxRobF3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F511078F;
	Wed,  4 Dec 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276189; cv=none; b=TkLfMsYDsg52Crn2rYBrky3E7V6wB3pT3E4qbKI8ZTDeFgOlubfZ1sPPtWBtR7w1Kzp0Nutkqh2rNN95QQsnovuxMDb3o99m5NasziYhny/UN+wVcEVhfo0rZlOaRKCJxqPaHwSVfgXlcljlVkmLs2gvqaP2qOOfb2UusFHhXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276189; c=relaxed/simple;
	bh=1MIHsLPSy27gu43t9ml1sSj+k0Yt18S4T21rqcDaZuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/fgekJkR0VwiS7qTheb6GKLiDLlToBx1fZzHmwKmeYPx/PhGDO+otBYx4AhIARN5sYJT1goZFQvSHthtFU2kyDkhgUXXs5RpsuFeT3IsU/OQzF5ngUpfbexE+8ogPRhv3Fdz2JZBFs0AvJPb7jdrugRqddDHz/OcJzeM4GMYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpxRobF3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276188; x=1764812188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MIHsLPSy27gu43t9ml1sSj+k0Yt18S4T21rqcDaZuk=;
  b=MpxRobF3OyU+b0X/EmXVWlySrJ9JZN18hkxu2uf/8tkj5f62QMPsFDW1
   r1ifRhUJBGYaEzXahheD2KVEaJc9nUdz2ei67FU46wcd8Wm6RoHXTqVey
   rSUa7X+eKbH45Wv5SMnUtTMb7rbG8GWFT87iCwBXd6DUd2OIEX2IiBnFX
   7CfukVyaTQ+mKB3AbKyB3nXtyPCdeSFzzkEEo6mZqPg2mQi5SVtUqWw8x
   VcG3/ti0hc2GBHhjUhXO3JJsYxa3gus00naZD0aTmV4BU7EzLfM4Nh41R
   +NKVFNT47y/4bLcNKVsUn+XG6YcJTLwLD7OEB6IV8Ov0uOZIwrcTP6lL1
   A==;
X-CSE-ConnectionGUID: EZtmPe+zQDiiAK3As+ggSQ==
X-CSE-MsgGUID: fN+Q5olASxSxdGCzeZ8RhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33655193"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33655193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:36:25 -0800
X-CSE-ConnectionGUID: ifHqhnJsTgiYHcoPKNNj2Q==
X-CSE-MsgGUID: QWro1jOZS9eXfD/pFG+9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98600610"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Dec 2024 17:36:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 390D3710; Wed, 04 Dec 2024 03:36:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/4] iio: afe: rescale: Re-use generic struct s32_fract
Date: Wed,  4 Dec 2024 03:33:18 +0200
Message-ID: <20241204013620.862943-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of custom data type re-use generic struct s32_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/iio-rescale.c   | 79 +++++++++++++++++----------------
 include/linux/iio/afe/rescale.h |  5 ++-
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 9d33e7aabe4d..bbc73798082d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,6 +23,7 @@
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
+	struct s32_fract *fract = &rescale->fract;
 	s64 tmp;
 	int _val, _val2;
 	s32 rem, rem2;
@@ -31,10 +32,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*val *= rescale->numerator;
-		if (rescale->denominator == 1)
+		*val *= fract->numerator;
+		if (fract->denominator == 1)
 			return scale_type;
-		*val2 = rescale->denominator;
+		*val2 = fract->denominator;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_FRACTIONAL:
 		/*
@@ -42,8 +43,8 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		 * potential accuracy loss (for in kernel consumers) by
 		 * keeping a fractional representation.
 		 */
-		if (!check_mul_overflow(*val, rescale->numerator, &_val) &&
-		    !check_mul_overflow(*val2, rescale->denominator, &_val2)) {
+		if (!check_mul_overflow(*val, fract->numerator, &_val) &&
+		    !check_mul_overflow(*val2, fract->denominator, &_val2)) {
 			*val = _val;
 			*val2 = _val2;
 			return IIO_VAL_FRACTIONAL;
@@ -51,8 +52,8 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
-		tmp = div_s64(tmp, rescale->denominator);
-		tmp *= rescale->numerator;
+		tmp = div_s64(tmp, fract->denominator);
+		tmp *= fract->numerator;
 
 		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
@@ -84,11 +85,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		 */
 		neg = *val < 0 || *val2 < 0;
 
-		tmp = (s64)abs(*val) * abs(rescale->numerator);
-		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
+		tmp = (s64)abs(*val) * abs(fract->numerator);
+		*val = div_s64_rem(tmp, abs(fract->denominator), &rem);
 
-		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
-		tmp = div_s64(tmp, abs(rescale->denominator));
+		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(fract->numerator);
+		tmp = div_s64(tmp, abs(fract->denominator));
 
 		*val += div_s64_rem(tmp, mult, val2);
 
@@ -96,7 +97,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		 * If only one of the rescaler elements or the schan scale is
 		 * negative, the combined scale is negative.
 		 */
-		if (neg != (rescale->numerator < 0 || rescale->denominator < 0)) {
+		if (neg != (fract->numerator < 0 || fract->denominator < 0)) {
 			if (*val)
 				*val = -*val;
 			else
@@ -323,6 +324,7 @@ static int rescale_configure_channel(struct device *dev,
 static int rescale_current_sense_amplifier_props(struct device *dev,
 						 struct rescale *rescale)
 {
+	struct s32_fract *fract = &rescale->fract;
 	u32 sense;
 	u32 gain_mult = 1;
 	u32 gain_div = 1;
@@ -345,16 +347,16 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * numerator/denominator from overflowing.
 	 */
 	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
-	rescale->denominator = sense / factor;
+	fract->numerator = 1000000 / factor;
+	fract->denominator = sense / factor;
 
-	factor = gcd(rescale->numerator, gain_mult);
-	rescale->numerator /= factor;
-	rescale->denominator *= gain_mult / factor;
+	factor = gcd(fract->numerator, gain_mult);
+	fract->numerator /= factor;
+	fract->denominator *= gain_mult / factor;
 
-	factor = gcd(rescale->denominator, gain_div);
-	rescale->numerator *= gain_div / factor;
-	rescale->denominator /= factor;
+	factor = gcd(fract->denominator, gain_div);
+	fract->numerator *= gain_div / factor;
+	fract->denominator /= factor;
 
 	return 0;
 }
@@ -362,6 +364,7 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 static int rescale_current_sense_shunt_props(struct device *dev,
 					     struct rescale *rescale)
 {
+	struct s32_fract *fract = &rescale->fract;
 	u32 shunt;
 	u32 factor;
 	int ret;
@@ -374,8 +377,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 	}
 
 	factor = gcd(shunt, 1000000);
-	rescale->numerator = 1000000 / factor;
-	rescale->denominator = shunt / factor;
+	fract->numerator = 1000000 / factor;
+	fract->denominator = shunt / factor;
 
 	return 0;
 }
@@ -383,26 +386,25 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 static int rescale_voltage_divider_props(struct device *dev,
 					 struct rescale *rescale)
 {
+	struct s32_fract *fract = &rescale->fract;
 	int ret;
 	u32 factor;
 
-	ret = device_property_read_u32(dev, "output-ohms",
-				       &rescale->denominator);
+	ret = device_property_read_u32(dev, "output-ohms", &fract->denominator);
 	if (ret) {
 		dev_err(dev, "failed to read output-ohms: %d\n", ret);
 		return ret;
 	}
 
-	ret = device_property_read_u32(dev, "full-ohms",
-				       &rescale->numerator);
+	ret = device_property_read_u32(dev, "full-ohms", &fract->numerator);
 	if (ret) {
 		dev_err(dev, "failed to read full-ohms: %d\n", ret);
 		return ret;
 	}
 
-	factor = gcd(rescale->numerator, rescale->denominator);
-	rescale->numerator /= factor;
-	rescale->denominator /= factor;
+	factor = gcd(fract->numerator, fract->denominator);
+	fract->numerator /= factor;
+	fract->denominator /= factor;
 
 	return 0;
 }
@@ -410,6 +412,7 @@ static int rescale_voltage_divider_props(struct device *dev,
 static int rescale_temp_sense_rtd_props(struct device *dev,
 					struct rescale *rescale)
 {
+	struct s32_fract *fract = &rescale->fract;
 	u32 factor;
 	u32 alpha;
 	u32 iexc;
@@ -440,8 +443,8 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 
 	tmp = r0 * iexc * alpha / 1000000;
 	factor = gcd(tmp, 1000000);
-	rescale->numerator = 1000000 / factor;
-	rescale->denominator = tmp / factor;
+	fract->numerator = 1000000 / factor;
+	fract->denominator = tmp / factor;
 
 	rescale->offset = -1 * ((r0 * iexc) / 1000);
 
@@ -451,6 +454,7 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 static int rescale_temp_transducer_props(struct device *dev,
 					 struct rescale *rescale)
 {
+	struct s32_fract *fract = &rescale->fract;
 	s32 offset = 0;
 	s32 sense = 1;
 	s32 alpha;
@@ -464,11 +468,10 @@ static int rescale_temp_transducer_props(struct device *dev,
 		return ret;
 	}
 
-	rescale->numerator = 1000000;
-	rescale->denominator = alpha * sense;
+	fract->numerator = 1000000;
+	fract->denominator = alpha * sense;
 
-	rescale->offset = div_s64((s64)offset * rescale->denominator,
-				  rescale->numerator);
+	rescale->offset = div_s64((s64)offset * fract->denominator, fract->numerator);
 
 	return 0;
 }
@@ -550,15 +553,15 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale = iio_priv(indio_dev);
 
 	rescale->cfg = device_get_match_data(dev);
-	rescale->numerator = 1;
-	rescale->denominator = 1;
+	rescale->fract.numerator = 1;
+	rescale->fract.denominator = 1;
 	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
 		return ret;
 
-	if (!rescale->numerator || !rescale->denominator) {
+	if (!rescale->fract.numerator || !rescale->fract.denominator) {
 		dev_err(dev, "invalid scaling factor.\n");
 		return -EINVAL;
 	}
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 6eecb435488f..d6998806b4f5 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -6,7 +6,9 @@
 #ifndef __IIO_RESCALE_H__
 #define __IIO_RESCALE_H__
 
+#include <linux/math.h>
 #include <linux/types.h>
+
 #include <linux/iio/iio.h>
 
 struct device;
@@ -19,12 +21,11 @@ struct rescale_cfg {
 
 struct rescale {
 	const struct rescale_cfg *cfg;
+	struct s32_fract fract;
 	struct iio_channel *source;
 	struct iio_chan_spec chan;
 	struct iio_chan_spec_ext_info *ext_info;
 	bool chan_processed;
-	s32 numerator;
-	s32 denominator;
 	s32 offset;
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


