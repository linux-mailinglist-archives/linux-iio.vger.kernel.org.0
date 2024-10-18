Return-Path: <linux-iio+bounces-10708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A89A3B24
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BD6284118
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752412022CA;
	Fri, 18 Oct 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm7/vvUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54445201251;
	Fri, 18 Oct 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246622; cv=none; b=ZL4oRNMdDlmOLfevBwSwTjsvlzTRt3SHUx/VF1NBBVBSEyYUSOzmAX3DVEyL5LcVJ4aAYa6h/zTVbKiE2Q8hzv+BF+jMGWQG0YgmfmV6IWH/TvDN9+IcjO116fYcwGszlPbHmh5vMp46lenFfcRd/X3B05tTmCw3oOqCfWIcUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246622; c=relaxed/simple;
	bh=skxYbsxlomcPahNBo9EqyYgAPhdvkUeYyQAIxCTJGXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZegG2c+1Hr5oaxKUwfRvh00iY7q/JOAv37isTyzd28K6eGu9DlCJG5G7+Is8HdEpqdsHCKoc7p4K1AEhHDN1z0flL6yZIDcPhFRNM7DLqz03BYKNetflbX62mGNBaWhsDVC3iH3bS37tRZ/a2vV7E5J9Mcu8Ma9LdryLsvGwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm7/vvUu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d41894a32so1304311f8f.1;
        Fri, 18 Oct 2024 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246618; x=1729851418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68F+I2t0jIdksrHXOUU/sZlxHnw1vILpUVDiRtg0A9A=;
        b=Gm7/vvUu6oVYVugkPk9C3YXhjAK9m8qxolrGcATyChgctweZlQFvscLCMbHUr59l2l
         npS4BorZFtOpyQzvBnB/kdoNtLNOaRpOFyLtjSSoXAUot8815W3vhyqk1LBeg2zfjXzs
         4bnJqjcObnnceJ3fzy+CM14zHMIs59UimEhpf7UTQZpFmSghclCWCfaL2pVEi/bsiiXV
         Y/oozq8+Q7uP3xh9qrPFhIYI7UXQyOuNS4nOmPgFqto8B4A0y0IYNTsVnqr00Sj+L1TV
         cfr+XSMJGLJb23qGy2sdEoY4qfAw6NKBCUMQyvc43QexFl7FAuQ5btUoij1JxpKc0AFW
         WOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246618; x=1729851418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68F+I2t0jIdksrHXOUU/sZlxHnw1vILpUVDiRtg0A9A=;
        b=WvYKwbUP7v+X3a+Em/+4eiRrVGoI0N8weoG1tgZeAMzzxzIysNJxr6URpHbHUsGhks
         T9pa9ADgEpJRU9iWf/zUp12nIEYCbjIX+/H2fzdP2ZFAAhvMIXql6pVaa/vxJ1p0zmQj
         R/abXRQfuWZnbsAYgc1uhI4BSf5XGniOAFve0aqLpqhcwIAZOu5EoJ+MconYkoJGj5EL
         /mwa4jkuJlAlWOFWOtuO7dMxhk4WblYs6mOqVxDw8seP78jaZQZYao7a3igDSPaUQ78H
         HziQbZTWnLf/GnIg6rqXECOsfWal5KZM1KJw9fK6lrX5UdlMvjL3SohmpjDCrAOXSIRt
         4EsA==
X-Forwarded-Encrypted: i=1; AJvYcCU5sO58FL3Fk1Ue6MB7i6gAsYiU24kY6xviWifB3cnmh2a/cBQhX+aPlxLQ9VM5mWaSjRuE39so+sY=@vger.kernel.org, AJvYcCX0k8Ea5X6gjeFeLQFO7tymcp+d+H5A+L0USMjzSXQ998JWPjgUc6IW2qMuDzbM/IwG9wVey9YTsRmCbg==@vger.kernel.org, AJvYcCXdSVE3upVuqSylC8/5JnXmN1i+EGKBeYB1c3cFTZW4UYUrXm+tm5NDVR9QKBL5zE+jmc7xvDangqCEqjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK6756lH+J65PtS6MhkFFs4kp/YyDXm24wftOFAaU5jR7MSDe
	Gb/7HvONzX9z8hz/LIIf12qq1/Hxahdw0/o9ZEowDCk17Y9oIBwL
X-Google-Smtp-Source: AGHT+IGzn1OOgQhFIyFCgI1k5wdbR8ibGxMospdE8wD7XTWVSNizom9PDnz6YoodIBC1M+9Y2Kcczw==
X-Received: by 2002:a05:6000:e83:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-37d93e2492bmr4259631f8f.21.1729246618185;
        Fri, 18 Oct 2024 03:16:58 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e4fe8bsm19734805e9.44.2024.10.18.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:16:57 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Fri, 18 Oct 2024 12:16:41 +0200
Subject: [PATCH v4 2/5] iio: consumers: copy/release available info from
 producer to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-read-avail-release-v4-2-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
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
after calling these functions.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/afe/iio-rescale.c          |  8 ++++++++
 drivers/iio/dac/dpot-dac.c             |  8 ++++++++
 drivers/iio/inkern.c                   | 34 ++++++++++++++++++++++++++++------
 drivers/iio/multiplexer/iio-mux.c      |  8 ++++++++
 drivers/power/supply/ingenic-battery.c |  4 +++-
 include/linux/iio/consumer.h           |  4 ++--
 6 files changed, 57 insertions(+), 9 deletions(-)

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
index 7f325b3ed08fae6674245312cf8f57bb151006c0..9af6b33eb8d178ee7b3f5d417ccfa4d0f87835bc 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -760,9 +760,29 @@ static int iio_channel_read_avail(struct iio_channel *chan,
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
 
@@ -789,9 +809,11 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
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
@@ -801,7 +823,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 				int *val, int *val2, int *type,
 				enum iio_chan_info_enum info)
 {
-	const int *vals;
+	const int *vals __free(kfree) = NULL;
 	int length;
 	int ret;
 
@@ -857,7 +879,7 @@ static int iio_channel_read_min(struct iio_channel *chan,
 				int *val, int *val2, int *type,
 				enum iio_chan_info_enum info)
 {
-	const int *vals;
+	const int *vals __free(kfree) = NULL;
 	int length;
 	int ret;
 
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
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..6b7856e69f5fb7b8b73166b9b6825f4af7b19129 100644
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
@@ -62,7 +64,7 @@ static int ingenic_battery_get_property(struct power_supply *psy,
  */
 static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 {
-	const int *scale_raw;
+	const int *scale_raw __free(kfree) = NULL;
 	int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
 	u64 max_mV;
 
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 333d1d8ccb37f387fe531577ac5e0bfc7f752cec..e3e268d2574b3e01c9412449d90d627de7efcd84 100644
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

-- 
2.47.0


