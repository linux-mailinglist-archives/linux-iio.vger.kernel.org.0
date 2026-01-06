Return-Path: <linux-iio+bounces-27497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8ECF7495
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81783151652
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334431D74B;
	Tue,  6 Jan 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvOFiFAw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993931D36B
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686846; cv=none; b=lHUdo++jepyCBIC4sn9uCbglwyalE0PLr5xZ7GiIEdwsaEMdhT/fBjnYlOZKaGpbYVuh6MmPwFJllYPhSM+r0AL7iFjHVpLVbU1YMYSu3aeHNuxEIbI/DvsLxCIy1+YePERMvyFVizxTRgMEl0h6k2RmalutXQQAUM/LAu3Zy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686846; c=relaxed/simple;
	bh=jST8YWaLnMAtgHk7XAcrnI7kPyw94LuFrxCKSJqYUYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aei5wIYE5K1IS0ZBDxo7M0PMh40JqjXZmUw+Ute+sX5YeMZYOD5uOS5En/yZKgm2MZIGToRdWSXkDwkizr1eaCNvYIJWU7F/FUNkP867V+Sq5MQttMTYKzSfeO7/UnGHuPCrGK5r/apw6yYaAYiRqtjQF2BgRPwEO+f6FcZmO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvOFiFAw; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfd0101905so247331137.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686844; x=1768291644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7qfoHuaDZ50kLfHlMteLMtVw6amwlOWFBtzdbbJ0hA=;
        b=gvOFiFAwK/mOnW3Fr/Px5pUVrG+RYb1ltRZt1LoHJkHpznKxVzxmsZPbnx5oLQ7cpD
         a50IPG2JN6Rlgi7gibReN7hBedmDvAxmv7GDyvztgxfYWRlOFrQXCkgxB5kOnDFsslt0
         D8SrBTKg56JFdbmVdWVEltryJaikB5v7TlrHlYCGyVCvFixp74V/gzQdJWXVWrUvpkqH
         J2IfWxYbMOe4FKM/Aqg/5oJtf3YmlgKIAb1qbQYa/Q61+GVoat+GD9PanzmhLNsUl9UL
         t9rTl8AhGvrEsyd78l9K68QcWu8vfUSyrmddPg2hJFZ4H+yHnNjgsqd+YPllbJkJIInS
         ZHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686844; x=1768291644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7qfoHuaDZ50kLfHlMteLMtVw6amwlOWFBtzdbbJ0hA=;
        b=wIt96KF4OM3mf4OZwtumFipvVzlvtxYrVtTr5cDMsw0VY8RaMIbN5ZnB8ZDfTQhDq0
         DB5oD81BWmIWF2V83lf2TzJO+0uYoswfwCrSOO4NsgAz0m81doHfWj9QSciQsOY33+L9
         zm8zGTURIk/6aHe6EKalGVZk0ArzNnI098/EK3YtbCg3v3Uugq48HODXExnxDAi9+5Ww
         9UcbbmJQa48Jcl/qnOaw1tTrGAZnf/F4UnZe04N4AWmgBwcB0J7oBzpurL833sUm9Xto
         RhnPFirqn9HqAGV8aDshw0sDFbnjBJ3MF3DfDDhEu7zpp6H+AyK3XOjWJuXpocJibqHB
         EGxg==
X-Forwarded-Encrypted: i=1; AJvYcCWQgG+D7mTio/TMeIIoFvvlpL1ANvmqOMREb/bbmoSt3Do276sK4rFotxIoVDnF192eRF0erN5UPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCV7i63HoYWZOFJ5HDQO9xY/6AFr7m6UZdZl75wiXMiVSEVIq
	2RnJIO1XYxfMgfkgtR5uxP1dCmUwgmcQs6/W0np8F9nN8gE5Ki48LYN6
X-Gm-Gg: AY/fxX7HSgy59MMbSqsPWI1fMoGm91XiaWxt08nGheA/F1kJ8Kp/myiSBI/BtWXYHG0
	wc42MMLQSSXpooNy7V57PiccAKImmqvQLEIB/EerhCNro7TphnORk7r5YFMwkZ/dHmAqt8tag7U
	s8r8spyYDST0IUFyn/TmBhZXGgXFaXEEKmlIYf/bTbGD3bJ8swycSFDb74U13ynoGUHL3J1Hzqj
	2GQ12PTOVKcwa+56ufCjnpaMNS924cL8QJsQrnTPQSIa6Zzb5SammX/TJvbZrF+WpvKCvx9dBc0
	NT3yRuNhdKBz6EZyK4WDFkDNhFd4ZES8Vlu5ihHFNJ5uVgbQglEbzxSZMTr6Yxzx1C9qo09MXCp
	8Gg1Ghgucb4GIk/4evYqD3Tfyh/kYhf8Vln/Xz0FATYbmIl0m9Vb5wFg27GHuijcFZh5Co2iWuI
	Q8Yto+CDBGf+z3
X-Google-Smtp-Source: AGHT+IEOOxZYpo/K70Y60Wzd+ufz4LlZARi5sg/MPLgZ3kPxbQmLCmg8j1yushcQiANxH1KXvE/Mtg==
X-Received: by 2002:a05:6102:e11:b0:5db:dd12:3d16 with SMTP id ada2fe7eead31-5ec742e6215mr539074137.6.1767686843630;
        Tue, 06 Jan 2026 00:07:23 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:23 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:07:01 -0500
Subject: [PATCH v3 6/7] iio: health: max30102: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-6-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=jST8YWaLnMAtgHk7XAcrnI7kPyw94LuFrxCKSJqYUYs=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxh1ZF8KX8dd8x4/T6/6t/7hG7qST89XfxOuOYGbJWH
 xgbl0036ShlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJqLAxMrxNuGyn+2CLTUPM
 kaXWVy/N3nVVzsDLa5OCx5tj/44a313M8FfmeOMvphX895Ul1zks7Fj4mHO24y2212yLKp/+mL2
 s8RcbAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_CURRENT_MODE() cleanup helper to simplify and drop
busy-waiting code in max30102_read_raw().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/health/max30102.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 6918fcb5de2b..47da44efd68b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -467,44 +467,29 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct max30102_data *data = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		/*
 		 * Temperature reading can only be acquired when not in
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
-any_mode_retry:
-		if (!iio_device_try_claim_buffer_mode(indio_dev)) {
-			/*
-			 * This one is a *bit* hacky. If we cannot claim buffer
-			 * mode, then try direct mode so that we make sure
-			 * things cannot concurrently change. And we just keep
-			 * trying until we get one of the modes...
-			 */
-			if (!iio_device_claim_direct(indio_dev))
-				goto any_mode_retry;
+		IIO_DEV_GUARD_CURRENT_MODE(indio_dev);
 
-			ret = max30102_get_temp(data, val, true);
-			iio_device_release_direct(indio_dev);
-		} else {
-			ret = max30102_get_temp(data, val, false);
-			iio_device_release_buffer_mode(indio_dev);
-		}
+		ret = max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
 		if (ret)
 			return ret;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000;  /* 62.5 */
 		*val2 = 16;
-		ret = IIO_VAL_FRACTIONAL;
-		break;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info max30102_info = {

-- 
2.52.0


