Return-Path: <linux-iio+bounces-10269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8997992731
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D64A280AB9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AD18CC10;
	Mon,  7 Oct 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8Gfnctv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F138F97;
	Mon,  7 Oct 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290287; cv=none; b=aQVodw8nYbmaiDh8xbYyS85rIE1i0X64hiWgevDZRJNhefx6aqFdBz1yISjAm1FTq/3ycHnfgCWKkOF4Qhy0NTUlvymxr4yj6efEuBufbCmD/BOwlGrQ7+NruV0DQIviMpZ2wwlkLVSv+/Nix9sWSkHIjIonVLv0QTWuE8mxQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290287; c=relaxed/simple;
	bh=JI696ir0QITrxWEfRcF3ZHdp8+XMqxpwlGo9q4ElXuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3UzMh4CeZk9oOzOY4X/Sq2qbjjbTBZobDXXiXdvxaHCyIAjCPI/WBf4A6gFYJbtBVAO+pY4BowySp+Pk9TG/SlSwUQfwpjy/OMreNFHmVQzbcBW+U//L0dZ6FdepuWysb+AKMvn6arGdE/km8vg/Ep9AXYXYH2qDh9hvh+1s5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8Gfnctv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8ce5db8668so670035366b.1;
        Mon, 07 Oct 2024 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290284; x=1728895084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQLemq3ZBEgFeRrStV/dpS5btl0G+M2whUJOsHCfVSQ=;
        b=k8GfnctvGMYETRPOrT+Mv0ki7Et7bOdKepIsBmx34nnYrciAM8YNdKsiPTtP4dej6y
         HbcimZa+jWSB/JjxJL4TzzQPJR2Z1WacOIyHVLBq71zAHCxZBy8zkDq1sKlmjxGb6HAM
         XnCBHc82AYB3bHYwMv5Oo5ApoF0m1pfLIUcWPaO9xEcjyFnICHtQBRHcPwdR+9C2vDmh
         I5XTfUDYjpIxrCj6NVmG+CrwmRlfIwj+gtESt8y1JPEM5phjFUObDMM7uLP7lNaZ+rXy
         2cPWQhtq1jMZZQG3pd+NFJJ8z9+zr8OfOPVPA79qdjdHHsALf9a2h3S/ifpLBTs/PODq
         9wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290284; x=1728895084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQLemq3ZBEgFeRrStV/dpS5btl0G+M2whUJOsHCfVSQ=;
        b=hbejM0LpW9JKpFxz2d+kAjouBms2K+zlg61KqhJQySxZ1cAXo3ejhgcIEZoH6b7XU2
         6ShzOOXS1HWPBCUnU56eHFSBagS+FESM7w0AZx7/QgmBLknfmBVmYJ3nBlbB4oZy8y24
         1osy+SfGzTQPaVwqLbmTecoJQcWyyejuCOHAi0DwJiz9OybXpMPTWjtSAXO4bKkvs74E
         oPG+QKf8HeJ8O83z+g5deL7+gND3PWSAlSZy9WseA1YVfjhu2h4lhguMjxbsciBeqceM
         //sTZI7tXcvDN1f7W5ygcNJWtM96Ptreb9TvtjIDreQ/rjy19XHV1BIdnwN1RmDZQ93u
         p/NA==
X-Forwarded-Encrypted: i=1; AJvYcCUiatJ88ZbGoWIknKK32vP2AuTGCZs9NSctyjdus/PT3j5rYHKiQpmNgwkj/fzeh+AA3Qa1/Wtoncc=@vger.kernel.org, AJvYcCUuvAGsv/6xjY5k5Pp7fQDh21BJTKAotBjAjci8CRzANz2Xn87jcXEIlXMvFKLwzBvV5NQw4/lnb7MyDA==@vger.kernel.org, AJvYcCVlsBkCG5zJ7gHa/d+K7MXD8Xz/QchbUlvgN+t7isW7BLc30/GoEqNWTe80BhQEmOBfXbDyfvzJDt+STbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnemP82FHtULEQRo2lMZYL+uOMy2el2Q74RLQZ1OARhDC0hmvb
	VUYQB19bFw+2pZ1Uo+SxTiXnUaR92WIVuIwyYusVSEyZUpXPtE/g
X-Google-Smtp-Source: AGHT+IG4CpNC97e+DUqXVQ1IeBS1KYLVurpgEriMmojss7ag+04Zkv78n3EMC8a4tHvLxDox3WcUkQ==
X-Received: by 2002:a17:906:ee87:b0:a8b:ddf4:46f1 with SMTP id a640c23a62f3a-a991c077d4amr1336736266b.63.1728290284134;
        Mon, 07 Oct 2024 01:38:04 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7864besm349494666b.113.2024.10.07.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:03 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:14 +0200
Subject: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
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


