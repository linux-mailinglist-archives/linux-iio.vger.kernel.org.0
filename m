Return-Path: <linux-iio+bounces-22762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70947B27DE6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEA6AE6682
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9D2FF64A;
	Fri, 15 Aug 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaKXJR+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886A2FE06D;
	Fri, 15 Aug 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252132; cv=none; b=kEPOOqKmJTkjJyOCbFBoMmY0qInC0oQ5fRp1pVKGn12aqElg2C2sRuHBuCQE/8sJ+M5lVV/Tgxc4aRukoCFWNi3AbvG8vyIdwJrz19FqYUPczIfa/mWfHJtotDZVheNK4HLAG1tuHvyhlpdeEfH1aTyCO+auNE/Hzwikc8L33qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252132; c=relaxed/simple;
	bh=sw/GxrjNBfbj/4YWc+dvIqX6eB1g/so/jFMom8jSTms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FA8HxsV2YLQyhUCGegDV8/cLbSEkoTeBsEDiDDQLrWovIxW0RrTTH2kjzMTWrMMiS8bk9XVITX0/K5IskKwTxVoTujLGKktfZC4wOMev6F+64VYnLzGFv4Co38ovKyASdr0Edjua9ZeXjU6hWZKZ4hGozt6W213j5Geoe8cFu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaKXJR+4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb731caaaso245985166b.0;
        Fri, 15 Aug 2025 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252129; x=1755856929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSHiYv82zlQIjN/InQskDU2zSOHyGcoOeUDBehBVTYs=;
        b=UaKXJR+4Qao7Db1GQsHwiJGhOiDFtFvdfSy0Fmtedgv5q0SfYKjAMNfbw0K+y+QJYC
         oGaR6GLWSy5DPbmDRiU+7XOreFJ7JZ6Jyre8iyCCT2YOXEBssXVjPBZzuosJuZsYkafB
         Ve4QnrE7MOKIRjOPsQtkqjI3L7yXF2Csoh0OMGKAiMij4oxbPyP1LB0x/uyxO8mG79rd
         TfWJz2hln9UsChiegWe0+f205gecUvULQVl1o04as1jc0Cm2fgS08y5tK8lV58LU00+Y
         7pAZTQOBPeMd+vOuosVMSsUy8ZOu0C2oLaKlWZynW7ZEOGAgNyTAhQopdmGRnXxDURoO
         0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252129; x=1755856929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSHiYv82zlQIjN/InQskDU2zSOHyGcoOeUDBehBVTYs=;
        b=jM6nz/xy65Xrt9F9LW5IwmtQSu3ctzk9F3fL8BBOclWCzsZmyA/W88znSuMow/Ojox
         T0RzSDCG2hp7qYzpKl0NTucoY9jDjYw9AYdiibwRBZLVRVExwaHoJuaaCzpShbn2zPyf
         5bBtzM7KQDXb7wZRHHQL0j1h9gURwkybkmpAOwJ1TLoGcXfo9crr3m1LTmzAFnhSrXgf
         IWhomuRzqalXBa9R+SmA35mzC9br8xGivJqNqzqqru53BWYAEFamKjI5FOYd71nCO61W
         xH9YAUx+pnzkTcCGRcqAEDqD5yQCq3WW9ydNzUcuyOb0Nvkln/3at76+oLl56N5ZAHF9
         VCPw==
X-Forwarded-Encrypted: i=1; AJvYcCU/jcI+MDXTJNJSKhJ4vTPyltr4aBX3gqXiwkhlujzkEt5ScY74u3inxJ0Yt7T3k95tlnCgvmJt+ocSMsv+@vger.kernel.org, AJvYcCUz585K39GW9JfFKpF0a/WHorugpzD1qDA3wEvtC3k3znl1Ka5rcJUTWcDGiRzDRtTxgcrIxRosPcYn@vger.kernel.org, AJvYcCWOVbU/PNbug4x9KJzV6ZyK7ZxyGKxS2TDpNsexBD34wEDHDGOkbM51nWnrU+Tm9wMQhYa3Sxl7tw/P@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/cx/+u436qYAi3G6b5RgFa/6+FndEfXhQgSlzqa37XTsM0R0
	cfxqJx8qkGaBxoVuriYPfnO5gXH663cOH2N1RbcTY0NQYcUe7dhgmfnN
X-Gm-Gg: ASbGnctKsrbTPfkl6ho7oBUFf1zmgoSKdunlgkorciU9tFaLMWBPqYs4UGUpGVg9sbW
	J3QAD7Qm9skXLPESYNQhYml7TN8o8K41LRhJ4lZ0OTSdr3uuQFv2RaGLGuQaQB2BvIRp2xGc3Vv
	+iv1xHrrMFTc8ZweiT+bKqmSyvU0Y4vCxHAkIvv7MVgmuO1rf2ObbFUOXLy1FqpagiuxkQYmPVJ
	CWcG1k3NAtXtSH6Oesi86eqjiYrdscUkMWSUt5HNM7SvheLoWI06oW4jsM12IGl6MTRg3X9zOE4
	W3D+9/GB3eAA6vNMg+0j3Z6RVhtXdYbmmLHIVVBDh33cc4+RmakWsma5W8+iCm7AQD1APITdujj
	u+Vvh3mdLJuGtcc0289B5h2OnlvG2
X-Google-Smtp-Source: AGHT+IEYbc66YvfCs6ShJHKZ/L9mKZnKgiRZcakuMlRBlVprbCd3+5uLUPKmYBIOV4eOJnJJE3XQuw==
X-Received: by 2002:a17:907:961a:b0:afc:d5a3:90c1 with SMTP id a640c23a62f3a-afcdc3f8108mr128940366b.55.1755252128842;
        Fri, 15 Aug 2025 03:02:08 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d5dsm119031766b.37.2025.08.15.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:02:08 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Fri, 15 Aug 2025 12:02:04 +0200
Subject: [PATCH v4 3/3] iio: adc: ltc2497: reorder struct members to fix
 memory holes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ltc2495-v4-3-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
In-Reply-To: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755252124; l=1725;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=sw/GxrjNBfbj/4YWc+dvIqX6eB1g/so/jFMom8jSTms=;
 b=d8g6Yo0+oXnGNBwncQwM8nzxDDbU3Xg4nhfwKFfM0Gd3Z60y0JOkJJalMl1+97MwIdolHEXkr
 XPOsP/1BqziAE0nEMLH4u/RL5aMtRxQL4RVjbRLf3QF11vrwOUecqm+
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Reorder members in the `ltc2497_chip_info` and `ltc2497core_driverdata`
structs to eliminate memory holes identified by the `pahole` tool.

Confirm via the `bloat-o-meter` that this change has no significant
impact on the final code size:

| Object File     | Total Size Change |
|-----------------|-------------------|
| ltc2497-core.o  | 0 (0.00%)         |
| ltc2497.o       | +2 (+0.10%)       |
| ltc2496.o       | 0 (0.00%)         |

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index dfe2d5c30017adeb3f17e57fc5bf1e0e792ff30f..48e9f74870ab489b5df6e69a39446610c6a72b93 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -5,8 +5,8 @@
 #define LTC2497_CONVERSION_TIME_MS	150ULL
 
 struct ltc2497_chip_info {
-	u32 resolution;
 	const char *name;
+	u32 resolution;
 	/*
 	 * Represents the datasheet constant from the temperature formula:
 	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
@@ -20,15 +20,15 @@ struct ltc2497_chip_info {
 };
 
 struct ltc2497core_driverdata {
-	struct regulator *ref;
-	ktime_t	time_prev;
 	/* lock to protect against multiple access to the device */
 	struct mutex lock;
+	struct regulator *ref;
+	ktime_t	time_prev;
 	const struct ltc2497_chip_info	*chip_info;
-	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
 	enum iio_chan_type chan_type_prev;
+	u8 addr_prev;
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev);

-- 
2.43.0


