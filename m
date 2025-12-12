Return-Path: <linux-iio+bounces-27034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F99CB7B40
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05B6301FF54
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47B22D7B9;
	Fri, 12 Dec 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eeox+jI8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206129B778
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507547; cv=none; b=olsgWOVZnCNhR0J+qJPCKDkbqv66oOiDEmSCdlJqyjYVHUeV5buzHUHDRrpPa3UMmmyHSJjNDSRnJ0rXLmE+DKqy/l47HO5yTQioV12eZMd4rvbDljTC7DquhPBx8Yi1W+Z/t7SzoAgZZgaMLFrPlJOJtEa2eh6H0myg2LaZrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507547; c=relaxed/simple;
	bh=q6gZRxmz6cKGnQKSSxqxXmYWJF1PKw60AF3Tc6GXjyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1+41PuP7PRZ/kHtwdK+4FCy6KKsnxmjPFaCGcDBXFUq+jGC1qgym6UjMSoAWHeEWp6VnrRRIqqfworuTALSknObnnQ2wgVPiDi5lCy6REBIMyMDJHbBxvvfb1vBgOhTffk/TEF9GsHjFspvA2b0Ce6IavGgayw1owa7t0HZQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eeox+jI8; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-941063da73eso184962241.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507544; x=1766112344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wlEL307B3m+aaEYqQkKNwT5MYGrgAWckQlDU+pQY6Q=;
        b=Eeox+jI8BVgYj0ocaM/sv2Pmo7rIzRsgKWxKGmvfoxWWz+IUzb8oDXp0LGyKEIzTDu
         sTDuxEKTAPDO98qUrbB6Mg7cV+QkeYyk2+il+RQorZHkxoccR+DcP9Ft4DmbRm0FjIol
         nLV3caqqUt4Yeohip9qFo+RkCC3nJLirlivunOpcD1tZq12SKATFRqbEfkrDBj1mAFd5
         Q4hIZK07gse1ARkFaZ6yh40cVrTp4t6MUOXifMXtpCS+uRBx8gpjkTPjQcmEGOMk7/C/
         vserRBdSt5Hrwecu579NFLr7vPudTHd+BX/BhXKPZkHmVQ1dAjN7oLdSYeNQwSAxB4vJ
         r5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507544; x=1766112344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wlEL307B3m+aaEYqQkKNwT5MYGrgAWckQlDU+pQY6Q=;
        b=LmL6rBxW//EDH+F4e+OObuAVFz8OQdLKn8E/gvZPvmjV7OxI9757UoS4lc7Vo5/sf7
         b1x6gk/RYZlT0TObn817EZkVXT2WQ7ca0Ke/bGV+VIPMNzfSR/TDMCZs1/nmDjw+pFkS
         t6ECt+QWSRXdKJ8Z3cf7qcGeyO2bqVQs67/1she6cfaHVtKKLHV8Nlyma88bjiqdWU4r
         Mo2pU5ICj5wMmWRNqbR/COPhe/KD0W7oNIX7JvZLLH26wkBgywqGPsCeQFOSVGc96KEy
         DsT/AWHb1S214lDEBtS9rzPxert8YWYmBn3Z35fDNqQuuEsVdvjKIDhoAolr1yocNeKq
         5Kwg==
X-Forwarded-Encrypted: i=1; AJvYcCU06XWpbzxI4VnKzk0u3AaLBohYbuz1g9aDFZ3Pazjb9Xe6p5x7UrAtnX3wFFGyqYbEeM17Cd+KavM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+FGRqC6+GGGQtBsBg7UYLGqZ/fRExxrrjGVqOQfaLItnZL8x
	VLfwQt7YG53ItX22RVr+sVEpvo1yLQQjtasUBgrsehSwPO4UBa3l+yjC
X-Gm-Gg: AY/fxX4qfL/YPO7Lmv4XkIFF5Bp7Gm5Dm/ku3dg9C+E6g94OpaiuGy+xRCu9QnChG4S
	G6/+ml7+LbYsnM4wn1Ms9pNK6Ch+3g71wDwcH6a+CJog49kKarmMrvv0KiofupL1zm0pKF+krOR
	jdjhaKZ58laMtueOMEs6/DrWpNNbZQA6L3X8TDIJAdW9Y9po6L8MTgmNosfAgGIKDsFSBxxMwb5
	DEHJiE1H1fM0oBJJCN0H9FLNFl8JpRGzFbyfaacCVr3gcv7hn48u0HZsf/QRr6/s3w4C51h8cxP
	mPgpbAU5BRutAkCIdsa2anJhIOx0+GMGm3eMdMbFHB0Zq/oPNyvHf3CxQmbJcnIfAMG6yUlMhP3
	kxvkoQsTYYXBc2R+DF4WOEixUQjFhTVEb/rh89AKSgjqsXErVVBcq1fBgEWzcGvKHnW/3fPc7mu
	IyAWHRIV3M4H8RclywwgRuSwQ=
X-Google-Smtp-Source: AGHT+IG0wdLgjzf9Ktth3/5kZmD0HDcUqwfLcmvB1VHLyGx97sarm2rz4f/F64/HbgrAXqumKQeOKg==
X-Received: by 2002:a05:6102:945:b0:5db:f615:1821 with SMTP id ada2fe7eead31-5e8276b6fecmr140118137.10.1765507543991;
        Thu, 11 Dec 2025 18:45:43 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:43 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:23 -0500
Subject: [PATCH v2 5/7] iio: light: vcnl4000: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-5-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
In-Reply-To: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=q6gZRxmz6cKGnQKSSxqxXmYWJF1PKw60AF3Tc6GXjyU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSdTFecdzhNMZ5e0WlEw07Hnq8fE7OMHH9+5uOVkb
 czi+ZMkOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi9xoZGS4HJzyYUb40KfdQ
 0MacMHGmjX8yPY2vWaXsTn6bldDZ/Jbhr/Cx/rqAJafilN97XlsRo+Wy3PizUvI+2e3PNbVTz9x
 05wEA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release direct
mode.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 49 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4dbb2294a843..4184104ac8f2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1078,20 +1078,17 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	case IIO_CHAN_INFO_SCALE:
-		if (!iio_device_claim_direct(indio_dev))
+	case IIO_CHAN_INFO_SCALE: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_ERR(&claim))
 			return -EBUSY;
 
 		/* Protect against event capture. */
-		if (vcnl4010_is_in_periodic_mode(data)) {
-			ret = -EBUSY;
-		} else {
-			ret = vcnl4000_read_raw(indio_dev, chan, val, val2,
-						mask);
-		}
+		if (vcnl4010_is_in_periodic_mode(data))
+			return -EBUSY;
 
-		iio_device_release_direct(indio_dev);
-		return ret;
+		return vcnl4000_read_raw(indio_dev, chan, val, val2, mask);
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PROXIMITY:
@@ -1148,36 +1145,27 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
-	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	if (!iio_device_claim_direct(indio_dev))
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_ERR(&claim))
 		return -EBUSY;
 
 	/* Protect against event capture. */
-	if (vcnl4010_is_in_periodic_mode(data)) {
-		ret = -EBUSY;
-		goto end;
-	}
+	if (vcnl4010_is_in_periodic_mode(data))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PROXIMITY:
-			ret = vcnl4010_write_proxy_samp_freq(data, val, val2);
-			goto end;
+			return vcnl4010_write_proxy_samp_freq(data, val, val2);
 		default:
-			ret = -EINVAL;
-			goto end;
+			return -EINVAL;
 		}
 	default:
-		ret = -EINVAL;
-		goto end;
+		return -EINVAL;
 	}
-
-end:
-	iio_device_release_direct(indio_dev);
-	return ret;
 }
 
 static int vcnl4010_read_event(struct iio_dev *indio_dev,
@@ -1438,14 +1426,13 @@ static int vcnl4010_config_threshold_disable(struct vcnl4000_data *data)
 static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
 
 	if (state) {
-		if (!iio_device_claim_direct(indio_dev))
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_ERR(&claim))
 			return -EBUSY;
-		ret = vcnl4010_config_threshold_enable(data);
-		iio_device_release_direct(indio_dev);
-		return ret;
+
+		return vcnl4010_config_threshold_enable(data);
 	} else {
 		return vcnl4010_config_threshold_disable(data);
 	}

-- 
2.52.0


