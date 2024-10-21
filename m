Return-Path: <linux-iio+bounces-10869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DB9A6936
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAF1281C89
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233E1F80BC;
	Mon, 21 Oct 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzmgTG/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47A1F5854;
	Mon, 21 Oct 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515391; cv=none; b=s7eBOiwNpeCXoGVFoaYq27FPKatSjHCFdzwTSezW4Q/hCoYkl1k1+UCRI8iqTAeEbDPRFU0F9neFCLDuAAN2c6edy3wWIQxWEEMoQHmwOna3ymEKe9C23UKwAsysCeyhByRsCy9YVrBmo1dckQ17SPk6Xp5E8FI6TwtfvOAF/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515391; c=relaxed/simple;
	bh=JfFB3V4BVK38Q4fAhaF1uwjuIrMsvLUeWs/YXuG+ZFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tkm7vaBb07czw9dMwihWQ4XmqW+gdU+lKNvBhd6W6Ss8ddvBS60Wbg8EngBrkzUibTyy7cOJ9GwMUQa72ls6nAsmJONGpv5EHMMiEBbgLAi25eAG5Gm+WquCcC5Pt6KX+Ig8ChObDwwk5UbP11vajIpYUcg3HAu6dTNZiq73jX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzmgTG/T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso3566345f8f.3;
        Mon, 21 Oct 2024 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515387; x=1730120187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+7zY7pVPoAV0E1XWnpSqHgCSXjFqEo7qS0+dawRshU=;
        b=kzmgTG/T/CidOqKqmgNopTaCVMY44+J3i13SnnOmRTciDnD8ph09VHlDWQWSZa9sRi
         bmk2lCQqonzpcs7ZJdvHT/d5TTP3qdez9Rp13ymC8HtJJOdOXnValtgrysJF9aWJuTGL
         rF4pSuwqHqltbcawK47IFeWxDlZsIfWlwOtQPEdPOsHWJNwg5UjGeA5KMxvDdXRrbsk7
         RK+bQ+Qn5b+Hi+Z6zjFxtU/kxg0iX9niQcqPeKgk6b+Fw3h2ehZwPTLMxPA2mGEKI9yh
         cAPVw7s2ke9p8oshWYHdxgPUpwii6RDp4l8dggsAJrZLzbEh6zHvqqG7pN771D+Vtxqk
         aHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515387; x=1730120187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+7zY7pVPoAV0E1XWnpSqHgCSXjFqEo7qS0+dawRshU=;
        b=euoXT0SX0NHzFbnU3NFTp1YgiZf37KGFTNEozbzCkZYU1xGblhzpFLT4nDFXrRC0EV
         9wBjnVnNmjbiAX8pw9IsXuunrWZJADm7JfdVKbo5PxAHyMu4nFoNlFDSsMyM62UxHXsb
         9iZtBEluHflbj5FTek5ARWFqhXqMjyF7Ljan9YVwYWI9W8ONcEg23I0xj57jxQF7D39m
         wgDWC86FfEBkQQbx3RSVaxq2TGD+J3bx+l+ocEacFYKT80qr+71YJP8cgwYNvNxlCtfU
         qP/z6o36a/xXb0dK5RZ1F1etimhSWCoPD9guexBgnrs2S1cbh1vE2/cKbMS7/9hRt8wD
         1aVQ==
X-Forwarded-Encrypted: i=1; AJvYcCURykNm2wLqV6qPxMtiz8SB+sCNlOfJLDv7WJrZNleKJvxa8OfZXaXXI2dJ8bSvlI/2ZSkjGfaQr70=@vger.kernel.org, AJvYcCWqrGxlIdNN4IBjqZCvHv+fxoxHqUuXoaYXDcJYzzcC9JtXQ+FnEHbbkgar0xjMMBNfubPQL6LcbvTemg==@vger.kernel.org, AJvYcCXW4esQJ++5b/tpu4WRVLyF8XtnAVTODvnWSYzSlsDaXaFQxcL4ViL3StDxkIvQ6/7rBDW1dN/iuqS8MSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbuCyP9TEpPEjhmGnYdPeWz1zR+YomfHa68sQ0zjliu1tJwF1
	HNQPWSVYuG0RFbA6FLYVUU9oO9Vq4EsEY9fMauPtSEoyTh9ZJikP
X-Google-Smtp-Source: AGHT+IHP7sHgIC6w6W7OP4fpp7leuM9MQnc1DMJ3jIsQEduXzpQ2ws49ONw1AkmemZt1VIkFsmoeuQ==
X-Received: by 2002:a5d:60cd:0:b0:37d:52d0:a59d with SMTP id ffacd0b85a97d-37eab72732cmr7286276f8f.10.1729515386783;
        Mon, 21 Oct 2024 05:56:26 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc401sm55615835e9.43.2024.10.21.05.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:26 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 21 Oct 2024 14:54:15 +0200
Subject: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

Consumers need to call the producer's read_avail_release_resource()
callback after reading producer's available info. To avoid a race
condition with the producer unregistration, change inkern
iio_channel_read_avail() so that it copies the available info from the
producer and immediately calls its release callback with info_exists
locked.

Also, modify the users of iio_read_avail_channel_raw() and
iio_read_avail_channel_attribute() to free the copied available buffers
after calling these functions. To let users free the copied buffer with
a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
consumer helper that is equivalent to iio_read_avail_channel_attribute()
but stores the available values in the returned variable.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/afe/iio-rescale.c          |  8 +++
 drivers/iio/dac/dpot-dac.c             |  8 +++
 drivers/iio/inkern.c                   | 99 ++++++++++++++++++++++++++++------
 drivers/iio/multiplexer/iio-mux.c      |  8 +++
 drivers/power/supply/ingenic-battery.c | 22 +++++---
 include/linux/iio/consumer.h           | 28 +++++++++-
 6 files changed, 147 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 56e5913ab82d1c045c9ca27012008a4495502cbf..78bb86c291706748b4072a484532ad20c415ff9f 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -249,9 +249,17 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static void rescale_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static const struct iio_info rescale_info = {
 	.read_raw = rescale_read_raw,
 	.read_avail = rescale_read_avail,
+	.read_avail_release_resource = rescale_read_avail_release_res,
 };
 
 static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index f36f10bfb6be7863a56b911b5f58671ef530c977..43d68e17fc3a5fca59fad6ccf818eeadfecdb8c1 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -108,6 +108,13 @@ static int dpot_dac_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
+					    struct iio_chan_spec const *chan,
+					    const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
@@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info dpot_dac_info = {
 	.read_raw = dpot_dac_read_raw,
 	.read_avail = dpot_dac_read_avail,
+	.read_avail_release_resource = dpot_dac_read_avail_release_res,
 	.write_raw = dpot_dac_write_raw,
 };
 
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7f325b3ed08fae6674245312cf8f57bb151006c0..7b87d1c57d6fd1258d254192835aa6cb9355f859 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -760,12 +760,56 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	if (iio_info->read_avail)
-		return iio_info->read_avail(chan->indio_dev, chan->channel,
-					    vals, type, length, info);
+	if (iio_info->read_avail) {
+		const int *vals_tmp;
+		int ret;
+
+		ret = iio_info->read_avail(chan->indio_dev, chan->channel,
+					   &vals_tmp, type, length, info);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Copy the producer's avail buffer with lock_exists locked to
+		 * avoid possible race with producer unregistration.
+		 */
+		*vals = kmemdup_array(vals_tmp, *length, sizeof(int), GFP_KERNEL);
+		if (!*vals)
+			return -ENOMEM;
+
+		if (iio_info->read_avail_release_resource)
+			iio_info->read_avail_release_resource(
+				chan->indio_dev, chan->channel, vals_tmp, info);
+
+		return ret;
+	}
 	return -EINVAL;
 }
 
+/*
+ * iio_channel_read_avail_retvals() is equivalent to iio_channel_read_avail()
+ * but stores the pointer to the buffer of available values in the returned
+ * variable. Since such buffer must be freed after use, this function lets the
+ * user declare a cleanup local variable, e.g.:
+ * const int *vals = __free(kfree) = iio_channel_read_avail_retvals(...);
+ */
+static const int *iio_channel_read_avail_retvals(struct iio_channel *chan,
+						 int *type, int *length,
+						 int *avail_type,
+						 enum iio_chan_info_enum info)
+{
+	const int *vals;
+	int ret;
+
+	ret = iio_channel_read_avail(chan, &vals, type, length, info);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	*avail_type = ret;
+
+	return vals;
+}
+
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
 				     const int **vals, int *type, int *length,
 				     enum iio_chan_info_enum attribute)
@@ -780,6 +824,25 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
 }
 EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
 
+const int *
+iio_read_avail_channel_attr_retvals(struct iio_channel *chan, int *type,
+				    int *length, int *avail_type,
+				    enum iio_chan_info_enum attribute)
+{
+	const int *vals;
+	int ret;
+
+	ret = iio_read_avail_channel_attribute(chan, &vals, type, length,
+					       attribute);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	*avail_type = ret;
+
+	return vals;
+}
+EXPORT_SYMBOL_GPL(iio_read_avail_channel_attr_retvals);
+
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length)
 {
@@ -789,9 +852,11 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
 					       IIO_CHAN_INFO_RAW);
 
-	if (ret >= 0 && type != IIO_VAL_INT)
+	if (ret >= 0 && type != IIO_VAL_INT) {
 		/* raw values are assumed to be IIO_VAL_INT */
+		kfree(*vals);
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
@@ -801,15 +866,16 @@ static int iio_channel_read_max(struct iio_channel *chan,
 				int *val, int *val2, int *type,
 				enum iio_chan_info_enum info)
 {
-	const int *vals;
 	int length;
-	int ret;
+	int avail_type;
 
-	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
-	if (ret < 0)
-		return ret;
+	const int *vals __free(kfree) =
+		iio_channel_read_avail_retvals(chan, type, &length,
+					       &avail_type, info);
+	if (IS_ERR(vals))
+		return PTR_ERR(vals);
 
-	switch (ret) {
+	switch (avail_type) {
 	case IIO_AVAIL_RANGE:
 		switch (*type) {
 		case IIO_VAL_INT:
@@ -857,15 +923,16 @@ static int iio_channel_read_min(struct iio_channel *chan,
 				int *val, int *val2, int *type,
 				enum iio_chan_info_enum info)
 {
-	const int *vals;
 	int length;
-	int ret;
+	int avail_type;
 
-	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
-	if (ret < 0)
-		return ret;
+	const int *vals __free(kfree) =
+		iio_channel_read_avail_retvals(chan, type, &length,
+					       &avail_type, info);
+	if (IS_ERR(vals))
+		return PTR_ERR(vals);
 
-	switch (ret) {
+	switch (avail_type) {
 	case IIO_AVAIL_RANGE:
 		switch (*type) {
 		case IIO_VAL_INT:
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..31345437784b01c5d6f8ea70263f4c2574388e7a 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -142,6 +142,13 @@ static int mux_read_avail(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void mux_read_avail_release_res(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int mux_write_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 int val, int val2, long mask)
@@ -171,6 +178,7 @@ static int mux_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info mux_info = {
 	.read_raw = mux_read_raw,
 	.read_avail = mux_read_avail,
+	.read_avail_release_resource = mux_read_avail_release_res,
 	.write_raw = mux_write_raw,
 };
 
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..5d82c799ba5af3302bfcdfadb5f57adf6b12b353 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -6,12 +6,14 @@
  * based on drivers/power/supply/jz4740-battery.c
  */
 
+#include <linux/cleanup.h>
 #include <linux/iio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
+#include <linux/slab.h>
 
 struct ingenic_battery {
 	struct device *dev;
@@ -62,8 +64,8 @@ static int ingenic_battery_get_property(struct power_supply *psy,
  */
 static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 {
-	const int *scale_raw;
-	int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
+	int scale_len, scale_type, scale_avail_type;
+	int best_idx = -1, best_mV, max_raw, i, ret;
 	u64 max_mV;
 
 	ret = iio_read_max_channel_raw(bat->channel, &max_raw);
@@ -72,14 +74,18 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 		return ret;
 	}
 
-	ret = iio_read_avail_channel_attribute(bat->channel, &scale_raw,
-					       &scale_type, &scale_len,
-					       IIO_CHAN_INFO_SCALE);
-	if (ret < 0) {
+	const int *scale_raw __free(kfree) =
+		iio_read_avail_channel_attr_retvals(bat->channel,
+						    &scale_type,
+						    &scale_len,
+						    &scale_avail_type,
+						    IIO_CHAN_INFO_SCALE);
+	if (IS_ERR(scale_raw)) {
 		dev_err(bat->dev, "Unable to read channel avail scale\n");
-		return ret;
+		return PTR_ERR(scale_raw);
 	}
-	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
+	if (scale_avail_type != IIO_AVAIL_LIST ||
+	    scale_type != IIO_VAL_FRACTIONAL_LOG2)
 		return -EINVAL;
 
 	max_mV = bat->info->voltage_max_design_uv / 1000;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 333d1d8ccb37f387fe531577ac5e0bfc7f752cec..188cc64609bd1fd8e0522e69f0b65a73b9b1606d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -316,7 +316,7 @@ int iio_read_min_channel_raw(struct iio_channel *chan, int *val);
 /**
  * iio_read_avail_channel_raw() - read available raw values from a given channel
  * @chan:		The channel being queried.
- * @vals:		Available values read back.
+ * @vals:		Available values read back. Must be freed after use.
  * @length:		Number of entries in vals.
  *
  * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
@@ -334,7 +334,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 /**
  * iio_read_avail_channel_attribute() - read available channel attribute values
  * @chan:		The channel being queried.
- * @vals:		Available values read back.
+ * @vals:		Available values read back. Must be freed after use.
  * @type:		Type of values read back.
  * @length:		Number of entries in vals.
  * @attribute:		info attribute to be read back.
@@ -345,6 +345,30 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
 				     const int **vals, int *type, int *length,
 				     enum iio_chan_info_enum attribute);
 
+
+/**
+ * iio_read_avail_channel_attr_retvals() - read available channel attr values
+ * @chan:		The channel being queried.
+ * @type:		Type of values read back.
+ * @length:		Number of entries in vals.
+ * @avail_type:		Available type of values read back
+ *			(IIO_AVAIL_RANGE or IIO_AVAIL_LIST).
+ * @attribute:		info attribute to be read back.
+ *
+ * This function is equivalent to iio_read_avail_channel_attribute() but stores
+ * the pointer to the buffer of available values in the returned variable.
+ * Since such buffer must be freed after use, this function lets the user
+ * declare a cleanup local variable, e.g.:
+ * const int *vals = __free(kfree) = iio_read_avail_channel_attr_retvals(...);
+ *
+ * Returns a pointer to negative errno on error otherwise returns the available
+ * values read back that must be freed after use.
+ */
+const int *
+iio_read_avail_channel_attr_retvals(struct iio_channel *chan, int *type,
+				    int *length, int *avail_type,
+				    enum iio_chan_info_enum attribute);
+
 /**
  * iio_get_channel_type() - get the type of a channel
  * @channel:		The channel being queried.

-- 
2.47.0


