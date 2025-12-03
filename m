Return-Path: <linux-iio+bounces-26709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B1CA158B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F04D3016F92
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F3334C2B;
	Wed,  3 Dec 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXgVoxxw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131E3321BB
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789588; cv=none; b=gF6BZ4chv4Yh5shGPJXsiNG9o9QTNfSYL85n78V0B2twqbFQlypzYUxpkeXYoBhuFWCc3e/y3qDQM9DRCOtc7eYLx4lGdyjmhwJC5A93mt2WXoktE0sDufKOClkIKRLjuRPqBU13niw6VS6+1Vb1luQSpP3zM7MWoEv/xgtDf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789588; c=relaxed/simple;
	bh=ucvYi/fPnZwmSrVe8f+rF/TKmEyH9GUn56ivSGU8fjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlKBovAtwTrV/CwSIogi6/GSsxbV0nVGNsMTAqQJO2vSDdNwebMPSfickgz0bDm9Yn9r4pBcMJj3+XQS6AWhTAHe1VtPR0kIYMiKLV/vl+LXX9nyXvdHkEeeBqUuXw/pFtMB+QMvnteiVqmVLHqd5aM+85ycmvrgvAD8MHthxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXgVoxxw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55cda719128so36199e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789585; x=1765394385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dM4HPdX4dOmyhruohtElWZ1/XJUUUMG2tu2VLn0sUYA=;
        b=QXgVoxxwBSm2SkR8ss8oCCp+yd1uUZzkQ2OijWYOa3XOQjAytSOnUqB9bfSnM3vv/c
         8IuTjbONN00l3pGZE97RJjALNssixfSU4lp5L15791HmEQts8ff0CwiuuKFgvDiKC+E3
         e/v4aTcthaBRzY2xG10shIO+XYSaOVw9Fxv0msR6PPwuoZZKhT/YWesGOsryl/mL+ySE
         Pa1pFA4h3A3FBxKeNf3MnE36OK+LWQGNEj5bwl2vxPQ1IzXGpGUrK1E7BxQSgSjruxQM
         /dNQolA0oQzXSZLXp/oOfSUcj/Bd9Jsm0B5gMT9llADhZbS67RwOKgCUfq46JxfJ4Lbk
         /XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789585; x=1765394385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dM4HPdX4dOmyhruohtElWZ1/XJUUUMG2tu2VLn0sUYA=;
        b=r/YPQepE0ZtzmBl+koowGyeIOSthG/SVoimN2EAf4bjog8gWxXwk0EYs71OzFtyrK4
         eHz/pV2tZVfYBc6gHLZf/Psp6BO88wWQww9bPix/gfawjGqMZioaKLOMPZa9QRQrMKqD
         yR20jXy9KesCX2gF7x+j27uzJ+iA1nXmA2WfA5jeZ+eZbmtw2cxifmieq8ib6IBrw8ht
         hTRhasCQqmcdqau9sSi5u329no+KOU2le/B45Bdz/5XnGFMnB/QXFU7JfLQjznRsh3G9
         RSAKuP085ehmW+LDnfJ5AyEDLuKNwaKrjl3vE+4/CpfoLV8Bcu1x6enT8qs/ee6qE1hx
         2xVg==
X-Forwarded-Encrypted: i=1; AJvYcCWnkI0JAsE2pJEhq5HcJD7OrY04U/TkJz2UBr6IUX5wfn7WFa/rCMsgJHw0i6SG/JRYscLJ2r8Chew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjW4X7fbwTE7QhgIfkFJkaNhhnlxCSkQgdFlZUvIXhwf2wRSc
	Jdnz7BqeZdL86uu1EzO32I3eLt1Opz+NHKMVKG1uSJYQje3PGtSttDKg
X-Gm-Gg: ASbGncvZf4CSixN+oCXx3Br1PostyMDUyO3CX1P2cdi1htI430x9pcMcYNnMISN2DPm
	VZyfczPceQtm0mELsWWKxiCX02zwY1fX9ZGLmiqlErG7XmU8iRpJiTN7MaOgZVUeryCaQHjpGTB
	pcIoBv5Me+E85gK/nmqxH7f3Q4mMfSMETaNJm3a9C1UJox/nwT94GSk5yJYhfHPKKVQEOrHqEwI
	8DcFCUK/U/MbJLjPvPAz1bOjPZ0phYAe/GHiMbwjqYDn9Qa0EvmHaBnyAM7tho23QbMjqwJeDLd
	XCB+QG2qfZRTpvnC6YzmMqJeqDxmF3imphXjMvqTow7whW5LtLHJmgmVCW7bvGv64sr460xi/R4
	EAeIJqcD7VVR/MYGW/lNF+iX2LoKVPGbuNzQdz4tPMsjQpkte+5clheU3xZEl5G+1VjmYfD0Lx2
	IYhxDD8+9lNLtq
X-Google-Smtp-Source: AGHT+IH7tjt+w/bV9ZILans2knWsfwOh1Xdu6i3tY896xYt5Nr83RI3AyyRrteVbVislKJyjm479Pg==
X-Received: by 2002:a05:6122:7cb:b0:55b:305b:488d with SMTP id 71dfb90a1353d-55e5c057c49mr1365135e0c.19.1764789585458;
        Wed, 03 Dec 2025 11:19:45 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:18 -0500
Subject: [PATCH RFC 4/6] iio: light: vcnl4000: Use cleanup.h for IIO locks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-4-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ucvYi/fPnZwmSrVe8f+rF/TKmEyH9GUn56ivSGU8fjY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGva72pnZq05I+sjGcXON864Fc5oxsptcTKzWTLX4f3
 bdA5WNbRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEyk4AAjw/MCfY695/fWnr/+
 Zhv7NDHvSuMgW+PPl2b7Rfn4nKqMVWBkeCpgEyckpW5Wuj6dWyv2kPFtma+qqceYOn6eF6l/Ufi
 dCQA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use ACQUIRE() for iio_device_claim_direct().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4dbb2294a843..55e5060ce337 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 #include <linux/units.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -1148,36 +1149,27 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
-	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	if (!iio_device_claim_direct(indio_dev))
+	ACQUIRE(iio_device_claim_direct, busy)(indio_dev);
+	if (ACQUIRE_ERR(iio_device_claim_direct, &busy))
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

-- 
2.52.0


