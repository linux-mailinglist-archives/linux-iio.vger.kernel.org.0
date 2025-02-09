Return-Path: <linux-iio+bounces-15210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B06A2DFCE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D546D1611D2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172F1E0DE3;
	Sun,  9 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTgvFTRA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31696243368
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124529; cv=none; b=iT6CPdUiwGoebc2eC3t4VAPDTdD/kror1tNdnXQujGf+LVwIQS/XtI8u0Hp37EkGc+BIoJnpp7lAIZuX2XT2SzPgpDZOjQR9vCzDq0YodDL+dTpmyE5y55n/KWLyCX6CrWN4HBP61o/oIfqKkGn57Bk4W8ljv01/zCHr/pm3Chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124529; c=relaxed/simple;
	bh=TwBZho0KVpGyvfn0cH4C4sxkvYc7O+Eft6oo6sJyZj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdDR/HT2JIM+Z/bq6MkEMOtu7HYnG2XPFtack5wJE2AMKtcYqnMe2h8BGqWfZ8BwsMOJWjS9nP+AoFuqSTj9pdgqK2SxMo6eed2cP7RRWVn+726T+mju6RMv/Hbr20GToKZ+8ymGJX0/lWQjd0A/X/wxQwcNewO7hFvP4adEdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTgvFTRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB5DC4CEDD;
	Sun,  9 Feb 2025 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124529;
	bh=TwBZho0KVpGyvfn0cH4C4sxkvYc7O+Eft6oo6sJyZj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTgvFTRAkc0PTXefVhy4q0jFyFKDzK8H/cdg6XWGIqhR6jGVKWFKou5bZabblvFkr
	 mFJf7KR77aIcZjzM+DYDOl6ZTO/fXMxh11Lkwcv+tC6wLOpEc4NvJx8BoP33/uzl7a
	 u5aa7dA/CBlny+6CBDTfEvoDeBDIlr/A3t1hcfs287oK94SVhD5t3Sz9tJdjFDx5EP
	 V+UB4/o+5sPeEagGIhhoo5pUacd0X4ewKfOF8/S9llqGZGNxcu6Xo/Lb84Q95PBPxy
	 lF8u1IU2rpqTDw8QxNIqwmR9MbOHBcHbw3aNycG8S8JULIYhj9cqI/1yACGq0QJk8x
	 PaP8kGsmdNdDw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 17/27] iio: adc: rtq6056: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:14 +0000
Message-ID: <20250209180624.701140-18-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rtq6056.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 337bc8b31b2c..54239df61d86 100644
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
@@ -590,9 +601,8 @@ static ssize_t shunt_resistor_store(struct device *dev,
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
 	int val, val_fract, ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
 	if (ret)
@@ -601,7 +611,7 @@ static ssize_t shunt_resistor_store(struct device *dev,
 	ret = rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fract);
 
 out_store:
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret ?: len;
 }
-- 
2.48.1


