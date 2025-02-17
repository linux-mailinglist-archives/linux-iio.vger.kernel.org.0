Return-Path: <linux-iio+bounces-15673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC780A385C4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F56C7A321F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FC21D5BC;
	Mon, 17 Feb 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt4OUjuQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5F21D599
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801812; cv=none; b=GHfrnPxpRtcuFM2mfI+tHrkp2pMI4T6u8XF4Cnv9kThL0kzJpJbVp86k3RJTAOkIDWghI0hg6FKxBsk9C5ADe9422mpiQcgss63jFozSxry9+6FPf5YQ08Fg3j5OVI1XXLhQCv5P2oXbBCKrdbx2fwbxOK6CUuYzsNaIWFggfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801812; c=relaxed/simple;
	bh=dS884o12D4Ym3Y5x7dNzCZ5wCxhW/0mdNkDtjuNEGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHQ9coQ5eWxnS76jmAZJ8iUzGwWi/1wtEGFhcLChl5hMvSXMcLvvTKw4f9PmetBa4MRnMp0EevnXpk9dCyrdMvvkaW2Ip4gg4cbOKTwn5R+420Kl8OGp6xu7YJZSuarxCz2seqx4e+JK0d2WQIqBCxeAoBhp56JcOZ4y2FxgZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt4OUjuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD861C4CEE8;
	Mon, 17 Feb 2025 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801812;
	bh=dS884o12D4Ym3Y5x7dNzCZ5wCxhW/0mdNkDtjuNEGEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dt4OUjuQoB2YpQBY9FcGIdaPf4YuSIyn4yJTTElJ+hJP4HvbSQdJ664VsejDKSL0E
	 kOuipfTwXIirlwW7PTp/gkgv4tUVrc6J0y+btY03zDoR9T4IDppyZlpYEFOTTudojL
	 j4mxaXMB21Rf8hqMrqSSEo2alrQr9jeTKdjRLpDybEts2IxVqgztgXjsWUEDSH/Zc9
	 dw0lSEmLjP0Q5bLDU0RvF2epgcc9LD3WXd+qNudbl5X2ItrHr5+drAdYzu0qSNuC4D
	 EhBAKQ9wX8k6A63sp6poZU77h2o7/tS30dyxXsYas3w0IDPDUmEKumwVrWmE6MgW4c
	 IGog4eOaVfRZw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/29] iio: adc: vf610: Move claim of direct mode to caller of vf610_read_sample and use guard(mutex)
Date: Mon, 17 Feb 2025 14:16:01 +0000
Message-ID: <20250217141630.897334-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
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


