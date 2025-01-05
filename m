Return-Path: <linux-iio+bounces-13917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6243A01AE6
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6461882D9B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBAD188717;
	Sun,  5 Jan 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onaDFXqS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE638F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098030; cv=none; b=saY54+1X9yQuATYS8FEep6dwl0N326BLOuMCwHiVSObi2OaB3H0k0070dRqfbA3kOAaScFpvacLo1KQ7wMESiOFN8wJ/wnukyKD+Bk9gmX8jQc5kHSJHBx/i6wFaiUK0ILGYjZMmrkzADyloDYH2Y9hkCn+ZQdXq+kDmuMxlZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098030; c=relaxed/simple;
	bh=imrV38BBD1D7gAE5+2EjqleqAlmXUiTC1u+Xo3E+w3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE/7e87mGc896cYYXc/PIK8ww/bVAdEZjSKGMEqXeRG/VSCPw87Cz6thiIpQYWIrc3k1oQ0zAfTSXDdVfEGLbTMBEztVGOQMKGSFSBA+t54twYIABQ+ajkDGWWPMpWO1t4EwMQXSgawuIcLCbzMhDvqXQY3H30CBChmliGwjg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onaDFXqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A6DC4CED0;
	Sun,  5 Jan 2025 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098030;
	bh=imrV38BBD1D7gAE5+2EjqleqAlmXUiTC1u+Xo3E+w3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onaDFXqSjvjCYqoXLZJoFMW/fz7ICFQNfNBWOMLYGXdOZl/WDgBdGPdUM5BfQ+6ZQ
	 /Aeeowm1bLdEz85DA2gdpiCeMd4mxvE+qXJY7+Adm4px/F4DqzOzU6I5yCiw7lrdBB
	 smtcizP2jgrtOzdr41n2QQ1RWcsJJYgXeRt+CwH4cW8FfwEjsFI+1nZo59PduDihoB
	 45xdz+yJsQgD3Ix7M8F9BzpdfMrMYJhnZEgbP3s7R3gEKwApTajpkh0XZj7l5LXTHG
	 903/D8UjROCuFCFirK32c6w3fR2hBJuU5u6MDrS0HiGPw9DJIOXZHZEg60jnn3OUo6
	 s1h2lrGmTv71w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 18/27] iio: adc: rtq6056: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:03 +0000
Message-ID: <20250105172613.1204781-19-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rtq6056.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 337bc8b31b2c..4cb9add4682f 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -514,26 +514,37 @@ static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
-static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
-				 struct iio_chan_spec const *chan, int val,
-				 int val2, long mask)
+static int __rtq6056_adc_write_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan, int val,
+				   long mask)
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
 	const struct richtek_dev_data *devdata = priv->devdata;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		switch (mask) {
-		case IIO_CHAN_INFO_SAMP_FREQ:
-			if (devdata->fixed_samp_freq)
-				return -EINVAL;
-			return rtq6056_adc_set_samp_freq(priv, chan, val);
-		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-			return devdata->set_average(priv, val);
-		default:
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (devdata->fixed_samp_freq)
 			return -EINVAL;
-		}
+		return rtq6056_adc_set_samp_freq(priv, chan, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return devdata->set_average(priv, val);
+	default:
+		return -EINVAL;
 	}
-	unreachable();
+}
+
+static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int val,
+				 int val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __rtq6056_adc_write_raw(indio_dev, chan, val, mask);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
-- 
2.47.1


