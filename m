Return-Path: <linux-iio+bounces-13914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D011A01AE4
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E6C3A2F5B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315E17BB0D;
	Sun,  5 Jan 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdU+i5RP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43048F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098022; cv=none; b=TZgPbpfBANbpVP0yQb/mlvPGyHHAFX+/8w4XyRJTjShjhOuHsYHn0lZ/WY2XUT25VjoxHFdyLM7F8f82Fqt8/6GnEQeiaq2U2egDkNX11y8pknFlDByPVm/mDkXQCFyAEMK8j221bjCnE1VDsygndHlcN9vcKk6YabnBMzqn8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098022; c=relaxed/simple;
	bh=EzvbwWTBiplbRViuWSzRqII72rV3fPlPSqb2nFGlufQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbXOja5GgUyLleOr3anU30j+nQwEWvQvLTuu6WM41cAg0qIUj3XN6lF+kmVA286H2sqgNg8kha97tdNyob+NbKT2AUQ/RkXoXz5A3RFcX1yUZHqEYrU/s31N8FtPS/izeIaAeH74qLBkZL1SU5l3W/6mOsRm+5np+XICgA90HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdU+i5RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48182C4CED0;
	Sun,  5 Jan 2025 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098022;
	bh=EzvbwWTBiplbRViuWSzRqII72rV3fPlPSqb2nFGlufQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdU+i5RPI5fDh034h22OnMiUld1SeQYvO07H10I9DBg8cFiqzRQxeEN72+NMW9uj1
	 thZMnmvqsREYpH8fKv2em+UFQsAZo+YdScWGo82HE/g9i8T946i/YBg5j0aATzRtf/
	 vwNOhsWL+gBQHt+herRJriKdqMb9r41XP1d0NWcx9mJfVFu0WA/vgk0CZ2NhLaFdaK
	 wi4w2jSeVMJHFg/SXvE9KdZt/JSckV36Wx/2dRf+v/fNlZ7oQfxQvF+xnYSG+0PGxu
	 tHlc5f9Aix378LboZnKI5M6za66ygo9dz4rR/C6p28Yut7FrRVhDojyUlQRjx5+TC/
	 4Ghue2mqa/+YQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 15/27] iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:00 +0000
Message-ID: <20250105172613.1204781-16-jic23@kernel.org>
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
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7779.c | 103 ++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 2537dab69a35..3b132665d24c 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -467,65 +467,88 @@ static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
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
 {
-	int ret;
 	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
 
 	ret = ad7779_spi_write_mask(st,
 				    AD7779_REG_GENERAL_USER_CONFIG_3,
-- 
2.47.1


