Return-Path: <linux-iio+bounces-14016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A3A05C00
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5DE1888C8E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89B1FBE8B;
	Wed,  8 Jan 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dvn7uwRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD331FBC84
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340588; cv=none; b=On3oeixgmxKE+TDC3QZKJQut1UDq2+sxbu5j71jSWPRK/719HiSa8iftxGMFvKu78Q6tFV4lbt8K7qnDDxHcir5kzggPUfJDHXpdTcw8Kg8nMUGyi8xucbH6pCmSdJzPeKPFMH99Y6b4JrJgj2w1Yp1JSud5xqpOpRgk27jNxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340588; c=relaxed/simple;
	bh=eSSplP/3FY91YR2XwZTXJZ2Ax/rrzWeyNFYg2OhghvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmTcZYatEqlg00eAfV7BQBsZKIa/qbx/Bu5mOCiUFP/l/lb9Q7jbTA0mKfEZ3KpoalBL59eMiLRqb1sD8jDbK9lVqEi1Lbgku1VEG3tP1hxsi+FJ/UPP7tERBJYa9XXBfUKkbi3yEzMoluqipBjS+XJWZYmlUrF495KQZBgPPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dvn7uwRk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso169109945e9.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340584; x=1736945384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ+/3KnECndMbh/2k2JKBTk8y/NjC4Kknkr3b9iFCA8=;
        b=dvn7uwRkNBlbrm7t5WMPyNCh8r8y5JplJKUUuRxEd/0jeXv3Yw6waACxC4KodA8mbQ
         5kBFlBfl7N7V7PwjiexNdMcevr09LYKumWCzVDqQSjh5ZJm1QeJF0BJF5pNe9rPfuDzG
         9YRCxWi7InnvjkismSkIenjoJPbs0fDiANRu064WGTl+xp19MG9lnhbCCRaw4BHRIauk
         JoIeTOew6TeNTmJSgUeK1qBNp/NM/ZmG+CznE/H7dN9UbYeJVFKsPRgC4zz5YKoQPxFj
         qmltgVDeNmy01Jg0i8yv8PWHnjBas/tc1JU9g3WhaK5qmp6vBRg7woeGh7uV4qPnLvai
         pvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340584; x=1736945384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ+/3KnECndMbh/2k2JKBTk8y/NjC4Kknkr3b9iFCA8=;
        b=Iv/tQIj7HjZf6/H001ehyuPFK6Pe+VnMGXspsNCb0HSGY3AZAwou/YAGRdN5Huupo1
         RmOrOG5dtBwUM0eXdviDcJ2mIXiBHKv1arcRdNSOk8Yakmi5G0sYEMcaMQAIFrQCPOCT
         7qP65Or84CNCjPiDgyAoxI61ruqxcAA8UJCxheswI273U2PaYfFUx738+P/l+v7WXWPE
         Wnd63NV85XIw2AdjZAnSp3b4Fo9jFvxHbGkR3uraF58H/aCey2/heB98s5kLyS0Psg1V
         rIOkLZT03oGUYobsAUuUp/Nz+rNW9+ySqcVnySd3DU2d4oOAj68Vo34rFKFLBBGnabNr
         PYsw==
X-Gm-Message-State: AOJu0YzOfQ/qBRW2pDF3I68V13+WcZE+EtLC5SSG+Bqc0NJlOIpwIo/n
	Wd7oGGymwgv9Nb2uHM7wtuzm1K2hZu/1AEttsvsq9y9sRHS3IC4aHvBydhzdmdI=
X-Gm-Gg: ASbGncuTIIvGVnZCzleZkCh9BKdoWJkc4l8hjaCginnyDMBgOQmWYChdnxFrImF9O8c
	U1WgjkaHTv5bR/5EHPU9IoEtYk+ws05oif1byVRYqhdbX8pkhlv7I3w/bgSK8aIa/xZdJW6cdcF
	tDETbgmMmLRMtplimkfZSwIVHZOxPjp99phuEmMEaPLG2zekKItJyN9CDoHInOG/DX0N1wJ2zC9
	pdIy1Go9wtB9gavvPQNDa5DMeVqkSuYzeFqADvoVhplosQPuLEFmjNYHm2qZ32F/W2smcKCO5UP
	4Ath1hD5yw81MFwXqIcVhHsWEpK3jN+ntz5aYU/oMacwtSK3IEZJcA==
X-Google-Smtp-Source: AGHT+IFwg1bUjwoBd62t98tnLRpUy/beIfCq9zQ1+vKCDUuQw6Mu2z2Mkl61UbqKFZAX4gLat0B9/A==
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr19531555e9.33.1736340583659;
        Wed, 08 Jan 2025 04:49:43 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:43 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jan 2025 13:49:33 +0100
Subject: [PATCH v4 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-ad7380-add-alert-support-v4-1-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Conditionnal scoped handlers are turning out to be a real pain:
readability issues, compiler and linker handling issues among others so
rollback and remove the scoped version of iio_dvice_claim_direct_mode.

To impove code readability factorize code to set oversampling ratio.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 110 +++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4f32cb22f140442b831dc9a4f275e88e4ab2388e..bc7d58850a3e2a84a241d81377e3dc14c43fc101 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -675,15 +675,21 @@ static const struct regmap_config ad7380_regmap_config = {
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 				     u32 writeval, u32 *readval)
 {
-	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
-		struct ad7380_state *st = iio_priv(indio_dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
 
-		if (readval)
-			return regmap_read(st->regmap, reg, readval);
-		else
-			return regmap_write(st->regmap, reg, writeval);
-	}
-	unreachable();
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
 }
 
 /*
@@ -920,6 +926,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
+	int ret;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 
@@ -928,11 +935,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan->scan_index,
-						  scan_type, val);
-		}
-		unreachable();
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_read_direct(st, chan->scan_index,
+					 scan_type, val);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -1008,47 +1020,59 @@ static int ad7380_osr_to_regval(int ratio)
 	return -EINVAL;
 }
 
+static int ad7380_set_oversampling_ratio(struct ad7380_state *st, int val)
+{
+	int ret, osr, boost;
+
+	osr = ad7380_osr_to_regval(val);
+	if (osr < 0)
+		return osr;
+
+	/* always enable resolution boost when oversampling is enabled */
+	boost = osr > 0 ? 1 : 0;
+
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
+				 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
+				 FIELD_PREP(AD7380_CONFIG1_RES, boost));
+
+	if (ret)
+		return ret;
+
+	st->oversampling_ratio = val;
+	st->resolution_boost_enabled = boost;
+
+	/*
+	 * Perform a soft reset. This will flush the oversampling
+	 * block and FIFO but will maintain the content of the
+	 * configurable registers.
+	 */
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG2,
+				 AD7380_CONFIG2_RESET,
+				 FIELD_PREP(AD7380_CONFIG2_RESET,
+					    AD7380_CONFIG2_RESET_SOFT));
+	return ret;
+}
 static int ad7380_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
-	int ret, osr, boost;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		osr = ad7380_osr_to_regval(val);
-		if (osr < 0)
-			return osr;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
-		/* always enable resolution boost when oversampling is enabled */
-		boost = osr > 0 ? 1 : 0;
+		ret = ad7380_set_oversampling_ratio(st, val);
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG1,
-					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
-					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
-					FIELD_PREP(AD7380_CONFIG1_RES, boost));
+		iio_device_release_direct_mode(indio_dev);
 
-			if (ret)
-				return ret;
-
-			st->oversampling_ratio = val;
-			st->resolution_boost_enabled = boost;
-
-			/*
-			 * Perform a soft reset. This will flush the oversampling
-			 * block and FIFO but will maintain the content of the
-			 * configurable registers.
-			 */
-			return regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG2,
-					AD7380_CONFIG2_RESET,
-					FIELD_PREP(AD7380_CONFIG2_RESET,
-						   AD7380_CONFIG2_RESET_SOFT));
-		}
-		unreachable();
+		return ret;
 	default:
 		return -EINVAL;
 	}

-- 
2.47.1


