Return-Path: <linux-iio+bounces-10615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF199E50E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EDA1C238D7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865531E3DE8;
	Tue, 15 Oct 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWIaZynb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E971D8A0A;
	Tue, 15 Oct 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990413; cv=none; b=B1muR/1Qgd6N5AZnqyreTOL41r6PSkYAlNHZuKo5eXcaQl7ppHHbk/V7BuuyRKJcroNtqpD/gqLyYw1tnADKx+/jWRvBOaoJ8QfFWyYzIj2RDM8uKCpQHOQX2h1mCA+68TLamfO3TvuNNAF+9nEHE0dp00F0YBpfiV8xyN+V1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990413; c=relaxed/simple;
	bh=7sklAWXfji9T1wFz6rAfasTB2Thy5tSs15h7yZqzF+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVMcZxbXQ52GDkp2VPIm68w++0chvIGYz8SqJF49XhEPu92VpfIQ6dek5JAVE2J3/Bm1SC4L3k9IlnLJBib/vdIabGIiWUyBeGVrylBXXKMEQKERWH7E6HgU63GRNSQJ9+a3ICWeqRX4oYgoXmqENXM6FfDtiZ0T1YOmU1dgKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWIaZynb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so3166929f8f.2;
        Tue, 15 Oct 2024 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990409; x=1729595209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t1EeivanbjtmiS/C63NeyQb2kGTD8e2hmV9UzO5KnQ=;
        b=YWIaZynbWnCXZIlm6fwCVRp4NOhNNe0oSWAQwPd6CX7pB1cFyAD9tMjDFlYOZzd9P0
         BPeYxWFeH1Ifx8rQS8TNpxHBofgbi3vK5AO84eZmzr/z0AlEA5RQ9DefFxjb+J8hRo01
         9ScECVgK+zqbtTkXxUitgOctn3xmcUAgrNqA7ZxKOCTwBDhic4Mr5QG0UDS397jNgIf2
         kRrDNw2cyfrcL/9m/6PGRwQoHofqiGlk0xeJKBvtD3m8Hgy5LKPrpw/ZE1DUVaAigzSj
         2WekwJYw/SndxNv/zT+aPo77z+skAonWSYDOmztfV0FknkcbgXLw+9tJPYfCYEpkPDUj
         +W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990409; x=1729595209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t1EeivanbjtmiS/C63NeyQb2kGTD8e2hmV9UzO5KnQ=;
        b=uQ95U+NivygQRlznTYibcHkWyGDne3RMg0D6lCwGGWnga+zlS6cqsONzcYjfyzAH64
         UxdlXw9VItgIlXVzo9ruWn+nQ2FMjJGgO0NrD7Uy4kzpMH1Pn5abyyNghZwAP6t0votf
         cje2pmyZ5lwe0mNC+DgGEny9MIDVjkNcGB6wayaLvNDqjf0g54i+8e1Macyme7jjtPDj
         NRcmIVVMVNv5rvuWyYCCMqPazmGLi6/mAyawmUBXaYgoOvSCwKAgeEkmleK10JWmFNo8
         VpP+LRJjgscD0LO8NDej4KzGox7XFcGRZL7wsf4/umZCs2QTCB4le9K/HU9tZ2jvKKfQ
         R17w==
X-Forwarded-Encrypted: i=1; AJvYcCUuQ+2Tj2o9XJzSOBvmlkbI1rq6KxJ/A8dhUtVwqPB9BJXJip6lg2+0KCXZSkZ/JWqQlC+256p5IJvubaM=@vger.kernel.org, AJvYcCVxujSis48qgX8KwR99NfAj8TfP0oodnug9Nk4bvIlKeqLx7y+cOkCPzYkjHJDyPKHvvjhRJk2hNFc=@vger.kernel.org, AJvYcCX6flGAtcrnvwPCKZ729SdozyehY2MqFWeZl/rtUXKk9GawYMX8V7SNeGraOC9/Hve2ttxIsZFIDHcdXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzglGuDY3G69inZNSFa1FnHInhCRXtUrqgcjyWtsMeTtBKtwo
	fiU3rFD5h4byGBvGIc/HCTEnlY7anIGhMsnZfGyEjF1j2Gdc3ayt
X-Google-Smtp-Source: AGHT+IHbd06YGB6Br+qw3ogI8F5eEDdorrA+TMPvBg6KlnNLQoKMOS+asZKXizlk+ay5W6eg9Wecvg==
X-Received: by 2002:a5d:55c9:0:b0:37d:446b:7dfa with SMTP id ffacd0b85a97d-37d5ff6ccf4mr7370889f8f.39.1728990409190;
        Tue, 15 Oct 2024 04:06:49 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a173sm1293664f8f.15.2024.10.15.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:48 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 15 Oct 2024 13:06:35 +0200
Subject: [PATCH v3 2/5] iio: consumers: copy/release available info from
 producer to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-iio-read-avail-release-v3-2-ac3e08f25cb3@gmail.com>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
In-Reply-To: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
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
 drivers/iio/afe/iio-rescale.c          |  8 ++++
 drivers/iio/dac/dpot-dac.c             |  8 ++++
 drivers/iio/inkern.c                   | 68 ++++++++++++++++++++++++++--------
 drivers/iio/multiplexer/iio-mux.c      |  8 ++++
 drivers/power/supply/ingenic-battery.c | 17 ++++++---
 include/linux/iio/consumer.h           |  4 +-
 6 files changed, 90 insertions(+), 23 deletions(-)

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
index 7f325b3ed08fae6674245312cf8f57bb151006c0..7f50e33dc5084673aa66c25731add0c314cb477d 100644
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
@@ -820,24 +842,31 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			if (val2)
 				*val2 = vals[5];
 		}
-		return 0;
+		ret = 0;
+		break;
 
 	case IIO_AVAIL_LIST:
-		if (length <= 0)
-			return -EINVAL;
+		if (length <= 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 		switch (*type) {
 		case IIO_VAL_INT:
 			*val = max_array(vals, length);
+			ret = 0;
 			break;
 		default:
 			/* TODO: learn about max for other iio values */
-			return -EINVAL;
+			ret = -EINVAL;
 		}
-		return 0;
+		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+out:
+	kfree(vals);
+	return ret;
 }
 
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
@@ -876,24 +905,31 @@ static int iio_channel_read_min(struct iio_channel *chan,
 			if (val2)
 				*val2 = vals[1];
 		}
-		return 0;
+		ret = 0;
+		break;
 
 	case IIO_AVAIL_LIST:
-		if (length <= 0)
-			return -EINVAL;
+		if (length <= 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 		switch (*type) {
 		case IIO_VAL_INT:
 			*val = min_array(vals, length);
+			ret = 0;
 			break;
 		default:
 			/* TODO: learn about min for other iio values */
-			return -EINVAL;
+			ret = -EINVAL;
 		}
-		return 0;
+		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+out:
+	kfree(vals);
+	return ret;
 }
 
 int iio_read_min_channel_raw(struct iio_channel *chan, int *val)
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
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..3db000d9fff9a7a6819631314547b3d16db7f967 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
+#include <linux/slab.h>
 
 struct ingenic_battery {
 	struct device *dev;
@@ -79,8 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 		dev_err(bat->dev, "Unable to read channel avail scale\n");
 		return ret;
 	}
-	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
-		return -EINVAL;
+	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	max_mV = bat->info->voltage_max_design_uv / 1000;
 
@@ -99,7 +102,8 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 
 	if (best_idx < 0) {
 		dev_err(bat->dev, "Unable to find matching voltage scale\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Only set scale if there is more than one (fractional) entry */
@@ -109,10 +113,13 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 						  scale_raw[best_idx + 1],
 						  IIO_CHAN_INFO_SCALE);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(scale_raw);
+	return ret;
 }
 
 static enum power_supply_property ingenic_battery_properties[] = {
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


