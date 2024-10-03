Return-Path: <linux-iio+bounces-10079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E754F98F555
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51C02817A2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA151AC43B;
	Thu,  3 Oct 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpmGUrx0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752E1ABEA1;
	Thu,  3 Oct 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976892; cv=none; b=GkOck/g2/klAJzmrpt+ofJZ8TUYaVe//elGnFKt9d3MXvmEFBWq1T92epGOuKFl+z083or5+RqCMOmx9oRAHRTZMnU0oUs1KWHWO1ma8ys3NgFH8fNVWqzkpAaMDgXbobVCm2iY0q7zd5hrSnMHbVptsPQmEfqzYb0Se8va6H88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976892; c=relaxed/simple;
	bh=JI696ir0QITrxWEfRcF3ZHdp8+XMqxpwlGo9q4ElXuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjgYTHJ4XB2DJgNuVHF879Z5J/WN9VxGYfjPDW0rmynRm6xwFKwsnw7X1Y6xN/4OmYWCfJ/i/l6ixft48uv7viU67N4SWrMcCI9GGRH0Ryf4zQNuoK2qCm03W7CPW5Av/aCSrV+Z3Lmd8MfY+f7VMu+A5zubDuY0CPb+CJiBF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpmGUrx0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb806623eso10208715e9.2;
        Thu, 03 Oct 2024 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976889; x=1728581689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQLemq3ZBEgFeRrStV/dpS5btl0G+M2whUJOsHCfVSQ=;
        b=MpmGUrx0m//kfyQbrdm9l+dary9yMIzKIq629v47umAV+4EI9i0Z5+uGKx58yv9s05
         yIni+55i5gambxiam/BEeReWew0SdeTQ6ydZQHS8/TaZLcT34vEnj+ZAel2osSqHXMi1
         Vwm2y+MzzxqvCNuPwxL3jC32Q2Tqax0Jl526croxnygUZssb1tMMWYrg/z6QSmvMAzEw
         45TSDhyem7+G2pSYY4qaxQIIJOBf4Zci56kZB1CCRiGOswuk3HO3pcI07EdRIUz7k5yd
         qpitKXJkNFylXIbXGAFHUael/nsl3EBbCulmx7d2uqRBbCIi5DZSNlifuhQO+S8hsmHC
         qnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976889; x=1728581689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQLemq3ZBEgFeRrStV/dpS5btl0G+M2whUJOsHCfVSQ=;
        b=H8RSdpewlkRshwNluWImK5OiSf0FF8ZzKc/Jtl3f8Oq8lkzfJNsp96srWiXT079h3E
         YsWAhQW+DjyrPDEKxyoOjmByTPta5WDE9FfacNSyP+chSwoPfauyWIea60fg7yEMw3HL
         kVkF1giAfLAgRwntzYfxQ6oJ4czEiiYNVRVrbsb8mqt4JtR66lqR2QavrJsGtigqmxiH
         mqhyyyxQDxRVmACSrSi2z1r4URIzYyv9BOmpEypjHTS0RlnM8NXKvcUTgJeVbHW/GYzh
         X8NRNmBYfr6Eiz3zmdjwmY6s4wvox62e0Uqd4Mj0NFLD2n6NI/cew3tPLnOOM/Epd3++
         Zh7A==
X-Forwarded-Encrypted: i=1; AJvYcCVsinTDeIHvtuKDe2iHagBtOV43IiF559xWbviSsMqzzp/YNjwFz2FWAl1EN8OXOBpskbVs4+SOp4G7744=@vger.kernel.org, AJvYcCW946HTkbmD2EGxakMnqEsKVPkkRxOCXptnNE789fp+Y4o40FvAfh/zcHoDqoBA6D5hhp8NENyAQMs=@vger.kernel.org, AJvYcCWTlhGfijAx8/gfvIL5BPOkwZ0M4cCcSuTzRS7HCztFXjaY9gYwJB/GM+FermvLzdU8oiq20xZqnUvhLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jMmVAk/n4tB5uFpTm2w1F/Vg8gAP4KuPIrkRLFFEj3076uId
	2T3vNzMH+YbKumSX/InXVy98vIXTs3LVse75OD+MkO0PbGxx12Xr
X-Google-Smtp-Source: AGHT+IGAma1RySn1IK/rp0LtN48vO0lX02UU0J0RCmsTD86qOQ0N6ZY4suhHS5IMu/uczXymL5Wx4g==
X-Received: by 2002:a5d:6506:0:b0:371:8c61:577c with SMTP id ffacd0b85a97d-37d0e7373dfmr115647f8f.26.1727976888631;
        Thu, 03 Oct 2024 10:34:48 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6de8sm1713425f8f.114.2024.10.03.10.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:47 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:10 +0200
Subject: [PATCH 5/7] iio: inkern: copy/release available info from producer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-5-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
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

Consumers need to call the read_avail_release_resource after reading the
available info. To call the release with info_exists locked, copy the
available info from the producer and immediately call its release
callback. With this change, users of iio_read_avail_channel_raw() and
iio_read_avail_channel_attribute() must free the copied avail info after
calling them.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/inkern.c         | 64 +++++++++++++++++++++++++++++++++-----------
 include/linux/iio/consumer.h |  4 +--
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e168007a447ffc0d91 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct iio_channel *chan,
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
 
@@ -789,9 +805,11 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
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
@@ -820,24 +838,31 @@ static int iio_channel_read_max(struct iio_channel *chan,
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
@@ -876,24 +901,31 @@ static int iio_channel_read_min(struct iio_channel *chan,
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
2.46.2


