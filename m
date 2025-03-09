Return-Path: <linux-iio+bounces-16598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A2A585EB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CC18832CE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF51DF745;
	Sun,  9 Mar 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO1NCHfK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA9748F
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539523; cv=none; b=tQlhTSkQFn8mW5CghRlnZJBAfuV0OSt3vCFhW6tX18wsSnEDhOw45UHRQ9MUaKWKtrJV8DRTyLHe32gLpvFI/oCAvR4b50Ot4Y31v8Y7+wnfG2jfxL6mqnwCOnqM+8z4r7hfkGfqnyDUNG7SvX1chdhMCxudQyBz4/sOly8z+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539523; c=relaxed/simple;
	bh=dS884o12D4Ym3Y5x7dNzCZ5wCxhW/0mdNkDtjuNEGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ84P+UrV+Z2Uy/m74ZaesdKZcENNttoYmQZPHKtLiTA6FurAka+UP6ZXPKmfDTSsRKR9yVB+e9JqzF4Sujs2zqaaUGJfgEy+4Gve8HN5I4Rzz3PQzZFBHDx5+oR/pFeacBmZwvbZC8PMaj4ykTiOCW/TmbwDcg/HkauYvSPPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO1NCHfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F897C4CEE5;
	Sun,  9 Mar 2025 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539521;
	bh=dS884o12D4Ym3Y5x7dNzCZ5wCxhW/0mdNkDtjuNEGEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CO1NCHfKsNHajquds34Ck7azGuEa6mXfC9uyxshsYeSXYqut3zQr1cOvFMxnmAruz
	 SQTocOoG1w1mNtbPT+prYyIHflJ2k3nGfDv39ao71f3coZGY00BjM86LDblQypwnLn
	 epipnS9NmWSExj7efPEwJuyDPqW612aDlmoHj3Ki27cExjYcVPJJHKWqOx74GvCreF
	 el+rEQ89gXmT8EH7lBB4OkvisYJMsPJ5bRKi6spvx3MT0wPv91WWHNwFNAhXNpwGgU
	 eP651jLE7lUHgC4aCWmOXCC16JLDu3uFt+AbBpjRVp4TT6dIExpj/Xcw9keeXtq39o
	 c6GJ7KrMvNMuw==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/8] iio: adc: vf610: Move claim of direct mode to caller of vf610_read_sample and use guard(mutex)
Date: Sun,  9 Mar 2025 16:58:12 +0000
Message-ID: <20250309165819.1346684-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These two changes allow direct returns in all paths, improving code
readablity.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 513365d42aa5..57a22e31cfc7 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -630,36 +631,29 @@ static const struct attribute_group vf610_attribute_group = {
 	.attrs = vf610_attributes,
 };
 
-static int vf610_read_sample(struct iio_dev *indio_dev,
+static int vf610_read_sample(struct vf610_adc *info,
 			     struct iio_chan_spec const *chan, int *val)
 {
-	struct vf610_adc *info = iio_priv(indio_dev);
 	unsigned int hc_cfg;
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&info->lock);
+	guard(mutex)(&info->lock);
 	reinit_completion(&info->completion);
 	hc_cfg = VF610_ADC_ADCHC(chan->channel);
 	hc_cfg |= VF610_ADC_AIEN;
 	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
 	ret = wait_for_completion_interruptible_timeout(&info->completion,
 							VF610_ADC_TIMEOUT);
-	if (ret == 0) {
-		ret = -ETIMEDOUT;
-		goto out_unlock;
-	}
+	if (ret == 0)
+		return -ETIMEDOUT;
 
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		*val = info->value;
-		break;
+		return 0;
 	case IIO_TEMP:
 		/*
 		 * Calculate in degree Celsius times 1000
@@ -669,17 +663,10 @@ static int vf610_read_sample(struct iio_dev *indio_dev,
 		*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
 				1000000 / VF610_TEMP_SLOPE_COEFF;
 
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-out_unlock:
-	mutex_unlock(&info->lock);
-	iio_device_release_direct_mode(indio_dev);
-
-	return ret;
 }
 
 static int vf610_read_raw(struct iio_dev *indio_dev,
@@ -694,7 +681,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = vf610_read_sample(indio_dev, chan, val);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = vf610_read_sample(info, chan, val);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


