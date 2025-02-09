Return-Path: <linux-iio+bounces-15207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D938A2DFCB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9811885391
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F21DF246;
	Sun,  9 Feb 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rekn3A5U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A821DFFC
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124507; cv=none; b=hzx16KiD3j8KR8hffHQiFMN6iv79c36sv1E5nqrZVZ9CHCJxlTqik4/0rj39Ztwua3NTUAlJX6Cfb2URLfS1dZf9Ohv+8Eawbs/8AGHfxadBCy/SZpANwhD/UjyXS1X4AoI3IhyOi9hqif8rN2vpINKI6obPMoxc6LYtkQgkd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124507; c=relaxed/simple;
	bh=DW8uzfPqEnxUX9IBGunQvIjVtRRub3vUZUhwubMZZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGQpevTEekcXtkZrxVqMmwtCd1/pIbRXfNVfF6sGGE2op0pgSHJIWfgln8jUHOyTQfEZPVSY2Z4OT+mWFOG+9LiCsYnlZb2BYIMqXKYExp04oOITsgK7uahcp5z/vFa8k6gIZKf3YbuPq2ibX9WTFybr6pf9tv4SSH2wXkd6WfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rekn3A5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF976C4CEDF;
	Sun,  9 Feb 2025 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124506;
	bh=DW8uzfPqEnxUX9IBGunQvIjVtRRub3vUZUhwubMZZZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rekn3A5UuKebb5HwqdZ5kSEXOi7jL+9TMel+6JPl2Psn+0gFkiqrfJna0Wcucqaa1
	 fhMLWhizW4SxVT09jqHgDc38WbAj8C2kaLVvGfNBhB/eRocYP0ei5R4I9YoZbQd5Vl
	 wPkohbgZxvX8V9klF50Dv4zx8dmxuKJS8uOoKAl4im44zKidA+TS7R05S4wl+mZvuI
	 Isma4JwC4ACnzAWTIKvoza6ycCpYobVurn737QFkrIO/Afj8eKmsPGXw4RGOabYNjv
	 k0l/ypA5rfluGpRUHI/2EzmRX88muius60x+HMjVE5fD589tCJtJoRE2O5FpvOZv3Q
	 fDs/NvUuIdpmA==
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
Subject: [PATCH v2 14/27] iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:11 +0000
Message-ID: <20250209180624.701140-15-jic23@kernel.org>
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
to check for unbalanced context.

Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7779.c | 101 ++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 2537dab69a35..a5d87faa5e12 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -467,59 +467,82 @@ static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
 				calibbias[2]);
 }
 
+static int __ad7779_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = ad7779_get_calibscale(st, chan->channel);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		*val2 = GAIN_REL;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = ad7779_get_calibbias(st, chan->channel);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->sampling_freq;
+		if (*val < 0)
+			return -EINVAL;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7779_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	struct ad7779_state *st = iio_priv(indio_dev);
 	int ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		switch (mask) {
-		case IIO_CHAN_INFO_CALIBSCALE:
-			ret = ad7779_get_calibscale(st, chan->channel);
-			if (ret < 0)
-				return ret;
-			*val = ret;
-			*val2 = GAIN_REL;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_CHAN_INFO_CALIBBIAS:
-			ret = ad7779_get_calibbias(st, chan->channel);
-			if (ret < 0)
-				return ret;
-			*val = ret;
-			return IIO_VAL_INT;
-		case IIO_CHAN_INFO_SAMP_FREQ:
-			*val = st->sampling_freq;
-			if (*val < 0)
-				return -EINVAL;
-			return IIO_VAL_INT;
-		default:
-			return -EINVAL;
-		}
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __ad7779_read_raw(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int __ad7779_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2,
+			      long mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad7779_set_calibscale(st, chan->channel, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad7779_set_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7779_set_sampling_frequency(st, val);
+	default:
+		return -EINVAL;
 	}
-	unreachable();
 }
 
 static int ad7779_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val, int val2,
 			    long mask)
 {
-	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		switch (mask) {
-		case IIO_CHAN_INFO_CALIBSCALE:
-			return ad7779_set_calibscale(st, chan->channel, val2);
-		case IIO_CHAN_INFO_CALIBBIAS:
-			return ad7779_set_calibbias(st, chan->channel, val);
-		case IIO_CHAN_INFO_SAMP_FREQ:
-			return ad7779_set_sampling_frequency(st, val);
-		default:
-			return -EINVAL;
-		}
-	}
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __ad7779_write_raw(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static int ad7779_buffer_preenable(struct iio_dev *indio_dev)
-- 
2.48.1


