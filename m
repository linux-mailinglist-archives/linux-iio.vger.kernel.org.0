Return-Path: <linux-iio+bounces-24149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB12FB593A0
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831A3171807
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B8305E02;
	Tue, 16 Sep 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OqeqPqTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D52F83D3;
	Tue, 16 Sep 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018263; cv=none; b=Gmb1d68rsSFZVu3jylXnz9MJRCzXOxKtphR7AidbS3puQ8VFrmMSCaNOM2BFf/Xel6w+WAFfwoLEK4wHYd5d5PXteG8jRGmH7r9NZJ4tm1607oqQY475+0H8YuXSXrAa9og2h/hKoZQQEv6+HP3ZdaIRmYo8C+S8OTKodUidxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018263; c=relaxed/simple;
	bh=JY0fFNmZkGmq+Wab0Bv84GX2dVej9Vw1GK950MMgu+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7YchVai0Z7RuMCKqbMK5BCDwTj5deXDn1kj2EMF57UKOdRV3l5HAbXnPg146dyQZmZLeydZA4h3TYVaAFuEAYbYoX09yJ4VQkdfQZawvrBUBXa5cqYLGU8Nfq2eY9c3xdhS24oZiwp8TNBq1wB+3qTCwKKf7FLVHDPB2HyWXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OqeqPqTB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 950B24E40BE1;
	Tue, 16 Sep 2025 10:24:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6ABC46061E;
	Tue, 16 Sep 2025 10:24:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CD85102F16E3;
	Tue, 16 Sep 2025 12:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758018257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+w4qyJOBPfboDMhAjnHDcdTXTS+iPutFVtkMdVT7DPE=;
	b=OqeqPqTBJQmL7dz4Ya3Y4NvUZ2Qx3yawiot0xxwi5v33XjNj7OkUDfZvwDrB71ANLTHzz4
	MsI1HCeK51gK6tDryCfoNlxi0ia/2oBZBEFa2Koc0evvx1bBWZtQ5Xr22ucW27hEcYgxB0
	HHb1jJ9/4lKi6iPPKrB+TCajpzuxkyw/vbYmHJ4WZZtyH9RHwsfZ2RzAicjIYIvKAMrYxc
	KOGYOOVGclAXVpjEgcMOZmWHhSTNLlOaMtrJNt7i1ZMWaRZDDg4H2FGdEQNzJ7tXDIRPPl
	2JtPXYPX5PsLNZkzJoAmT1QEe7ZltKAmsLStQuJm6TWGACvWOHEHQ87UwkUR1A==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Sep 2025 12:24:07 +0200
Subject: [PATCH 2/4] iio: add processed write API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
In-Reply-To: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Add a function to allow IIO consumers to write a processed value to a
channel.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 17 ++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c174ebb7d5e6d183674b7ffb15c4ce0f65fa3aed..6486fdb7c66a4c84312541f0f42cc24469972a9c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -598,6 +598,85 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 
+static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
+						 int processed, int *raw,
+						 unsigned int scale)
+{
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
+	s64 tmp_num, tmp_den;
+
+	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
+				      IIO_CHAN_INFO_SCALE);
+	if (scale_type >= 0) {
+		switch (scale_type) {
+		case IIO_VAL_INT:
+			tmp_num = processed;
+			tmp_den = scale_val;
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp_num = (s64)processed * 1000000LL;
+
+			if (scale_val2 < 0) {
+				tmp_den = (s64)scale_val * 1000000LL - (s64)scale_val2;
+				tmp_den *= -1;
+			} else {
+				tmp_den = (s64)scale_val * 1000000LL + (s64)scale_val2;
+			}
+
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			tmp_num = (s64)processed * 1000000000LL;
+
+			if (scale_val2 < 0) {
+				tmp_den = (s64)scale_val * 1000000000LL - (s64)scale_val2;
+				tmp_den *= -1;
+			} else {
+				tmp_den = (s64)scale_val * 1000000000LL + (s64)scale_val2;
+			}
+
+			break;
+		case IIO_VAL_FRACTIONAL:
+			tmp_num = (s64)processed * (s64)scale_val2;
+			tmp_den = scale_val;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			tmp_num = (s64)processed << scale_val2;
+			tmp_den = scale_val;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		tmp_den *= scale;
+
+		*raw = div64_s64(tmp_num, tmp_den);
+	}
+
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+		case IIO_VAL_INT_PLUS_MICRO:
+		case IIO_VAL_INT_PLUS_NANO:
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val >>= offset_val2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*raw -= offset_val;
+	}
+
+	return 0;
+}
+
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 						 int raw, int *processed,
 						 unsigned int scale)
@@ -1028,3 +1107,23 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_label);
+
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
+	int ret, processed;
+
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+
+	if (!chan->indio_dev->info)
+		return -ENODEV;
+
+	ret = iio_convert_processed_to_raw_unlocked(chan, val, &processed, scale);
+	if (ret)
+		return ret;
+
+	return iio_channel_write(chan, processed, 0, IIO_CHAN_INFO_RAW);
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);
+
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6a44796164792b2dd930f8168b14de327a80a6f7..79c4804a73b0652d4c16ee5ad07c4543bccd6c92 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -451,4 +451,21 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
  */
 ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
 
+/**
+ * iio_write_channel_processed_scale() - scale and write processed value to a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value to write.
+ * @scale:		Scale factor to apply during the conversion
+ *
+ * Returns an error code or 0.
+ *
+ * This function writes a processed value to a channel. A processed value means
+ * that this value will have the correct unit and not some device internal
+ * representation. If the device does not support writing a processed value, the
+ * function will query the channel's scale and offset and write an appropriately
+ * transformed raw value.
+ */
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale);
+
 #endif

-- 
2.51.0


