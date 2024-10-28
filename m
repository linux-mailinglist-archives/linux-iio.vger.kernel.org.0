Return-Path: <linux-iio+bounces-11494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABFB9B36BB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0274285F89
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFE1DF248;
	Mon, 28 Oct 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zGw4ABcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2B1DEFD2
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133505; cv=none; b=L5UaiRgUH3VWCN96PXtM97gCF2J9t/Zst+4RAdt5h5qUccZ1/0OrYkcBpn+oZQEaVNJHs/n2V5ErzfvADzoaDnqN73xmEWi2z7XWz8tKWiWi0JCR6fT/hlwCCoUd/pIYG24KzYizMEbg8GxZ08od/aCSWd88p/2eaKITm2Lyb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133505; c=relaxed/simple;
	bh=GwmLKGWq7SnAKEHzZ7mh55t2QhA4SepsZELQACv3lyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFyC2IpTTHAEotLSmA2hwGM/Xt1MokuSVmA8T0HqxTzdzRI0a1upLJ7g9EM41Ek+XwL6g+b39WOWvY7gxGqJm2p6W94cOaNCGrevA5OVyDfCrHpFvwOjplWMxGAJLOpMr1lGaijm0pU5rVomWQvxh7kMTbjNUaxj7tPAKBQKQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zGw4ABcS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43152b79d25so42106125e9.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730133502; x=1730738302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8d/8BdE9Dg0MG57NehuCwwrXsMFrv7Nxa30bsUkjf8=;
        b=zGw4ABcSo28XlzJw1u158HcVTqWt3k3MblDch96Fo130WrEEC0RQIEIjDT7HaSThIy
         sT9DriHfG500/bhAdtgfXbrXjOVWd4Q/7Ci4OTOXAz5Jz1AyGHS18vP89CVAzBED1pQZ
         wZ1AZ5y/tt+3HBrkPp/fikqAY7ggjnSjPZRPM8mwkJksyY9Rr49AWNVtoyNlNt4EDr52
         X5e9keKNkAYJcOMoTeC6lrhVAn1BTvqD1l/3a1jRQdoW0sISx/UTGM4VpnsNK/zXOnbF
         f+J24UnYE1aFgUXu24H7zECA7cVR0dEZXBiQOieU7LHoNjAJYF0oF6CXBzkd5LtBrGy6
         cyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133502; x=1730738302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8d/8BdE9Dg0MG57NehuCwwrXsMFrv7Nxa30bsUkjf8=;
        b=S7++t7CiwREHCO8i3I9babczotoq+4EMNkG5n/NdxHN4BRvhvCaF5F4YqJ84HpJezf
         4syrUTSXWqnTMGCxSvKjfo3r42r3WozgJa0UYBFCzhauj7N6nyJVh++mp51N8IFVioJx
         GlNHidINO5op/itByQvInmOrSabiakjy26l/pFv07MM3QfrVfcec3t3hWH4hSBsiT7S6
         7qIaQFZBfrqxD/7t/NUmPzULcAIoUJJU/GF33KjyA67N0u1mkQiHR64d0lSYBwb0Meca
         dBImSFaDuZ9q8asXwOm7aJvd9sQ7tm3MFh1ydntvb9A01+1GwVVJaPwowipMr9dhmcx0
         8Bmw==
X-Gm-Message-State: AOJu0Yxu1kbeBEt3Hmk9BhA1Tk4o+ZcfqwOwIUK+gFqj9rO+UMxewgmM
	udUHtSHYjfnICTyVmVYiN3IjednAf/4WA+SivIg7d6yXfZ9bbvqNkb0Z/DpTwuI=
X-Google-Smtp-Source: AGHT+IEcZL/+CpoQeWxFOiE+FPUFyoFFNn0hz6i51bN2N293qZI4uF4f2vK6C5Wn+vImxGpl1A9iMQ==
X-Received: by 2002:a05:600c:3b94:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-4319ac7409amr66295955e9.4.1730133501663;
        Mon, 28 Oct 2024 09:38:21 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm147308435e9.11.2024.10.28.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:38:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Oct 2024 17:38:12 +0100
Subject: [PATCH 2/2] iio: adc: ad7280a: use IIO_DIFF_EVENT_CODE macro
 helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-2-b452c90f7ea6@baylibre.com>
References: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
In-Reply-To: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

The IIO_DIFF_EVENT_CODE macro helper was introduced to provide a more
specific alternative to the generic IIO_EVENT_CODE macro for handling
differential channels. This commit updates the code to use
IIO_DIFF_EVENT_CODE for better clarity and maintainability.

However, the current implementation incorrectly sets both chan1 and
chan2 to 0. To maintain compatibility and avoid breaking existing
user space applications, this behavior is preserved for now.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7280a.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index 35aa39fe4bde62290996abd3076ac350eedf1052..f9f32737db8079a5b96847442a64fea811438363 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -822,17 +822,15 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i]) <=
 		    AD7280A_CELL_VOLTAGE_6_REG) {
 			if (val >= st->cell_threshhigh) {
-				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
-							 IIO_EV_DIR_RISING,
-							 IIO_EV_TYPE_THRESH,
-							 0, 0, 0);
+				u64 tmp = IIO_DIFF_EVENT_CODE(IIO_VOLTAGE, 0, 0,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_RISING);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
 			} else if (val <= st->cell_threshlow) {
-				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
-							 IIO_EV_DIR_FALLING,
-							 IIO_EV_TYPE_THRESH,
-							 0, 0, 0);
+				u64 tmp = IIO_DIFF_EVENT_CODE(IIO_VOLTAGE, 0, 0,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_FALLING);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
 			}

-- 
2.47.0


