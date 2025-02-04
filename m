Return-Path: <linux-iio+bounces-15008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327BA27C61
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46A87A1EF8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF062063CE;
	Tue,  4 Feb 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsxqUqgZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB914B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699451; cv=none; b=qCWsyk2+0k+fblruRVZO1xU6OTXEFXOX31bVJXiPXrMzx6udiOyhx0KWXYlsRZ4BHpECyhMcMHDj+aEccxNVbB5BSnt9yr6SvIcu1ph/643EXSplIG32Gv1TB+mTFZNZ7edjPs0DF0/VVsdcZCezW+AkIsmjmLTJDJtmIMYUHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699451; c=relaxed/simple;
	bh=VQQPgCb9Kml/QSbS6VX5xic4hEioTxLUCGnQvVzAHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nszm0Z/qAvfyAEUnb9CRoza/7loC3HlT2MK6h/WI6kehY50HFqbaCJz8nbGXsUVby7BNODqc0zkwVWMgB6grBV9015Lxsi8deyF3AbGn2apjsdeqgp/5EDlLoVJ7X3Dy+T5x1kB5g7LlZPejh6PPKysSWaik02ij5ZeHN2+xq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsxqUqgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD97FC4CEDF;
	Tue,  4 Feb 2025 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699451;
	bh=VQQPgCb9Kml/QSbS6VX5xic4hEioTxLUCGnQvVzAHlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsxqUqgZTkpnrk4fG32OAjeu/6eNuCDFqQ5xhtlXkJQhzbdjnj5XymrZIw9+vW1Gv
	 t8R2V22TsVjjlhRxmjEB37H/bX6yV3mcPyx2BgfAeOnBnyVETzecrQjaUVd/A7p0az
	 PNXlvihdmkx1cfA8vuvxYiPBQRa2ivJLnUkyfSFQZIgisW1PEMPQU8yphjgTRoEMsm
	 LFjrt0nukkiQCTTFEEACufzD7FO5KgklDfo8z60FFzW2EVIDuwAHqkR9aT3jTe/cFO
	 Dh1XTnXew6CT+MmkZV17OVS8ZttWTBVeEKvXeqYZtIw//Nc9oUb31IQyPqJwkk17rn
	 JIovAbHbZOsxA==
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
Subject: [PATCH 14/27] iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:36 +0000
Message-ID: <20250204200250.636721-15-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>
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


