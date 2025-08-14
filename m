Return-Path: <linux-iio+bounces-22733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7C8B263BB
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB2317EA89
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46C2F7446;
	Thu, 14 Aug 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZvwjUbh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6F318159;
	Thu, 14 Aug 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169229; cv=none; b=n7dOeaSLt5Q5OkheaEm0olX24zdrzfxMsxumWmI0nkpHzgL4yDdiEvaAxQPWsDqkTGfratOoGWy6tNMsSXEi5ErnuPJOE15INRXXRlAJOtmej5XCOc4elrXU67q+cXzc6WrxIk/v5BJmYij0oASW4Ed9yx2fyLOWGh+LsDdOEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169229; c=relaxed/simple;
	bh=7dL620a4ki2oCdeq6jvorfDoA7+7B+wm9Jmm2GXEtLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lclYnye6SwrURefgJ/ceSmBqm+k0W0dgjA3TaMdBtUR7nfm7cUIZTS+43xrBOGF8GbI8jLFH/040CoCZ73THKF+EQWZ3A6s9PBwQZoNo76pVdARO/LwgQTg4owcYAEgQZeJ4kkYhKMNPtyzJ1HRTpnCfVfPDq2g/Bq9PvScCpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZvwjUbh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae31caso134223866b.3;
        Thu, 14 Aug 2025 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755169226; x=1755774026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEhRKi0HmzptgOPz8lO5moCSp0j9P7xyPzVGCUEQhMI=;
        b=JZvwjUbhqYRzgAKz/GSxl/rgKQLH4/NIMQLrAdP3yR0TFRU7C3I6xQ67TlBzXzZJgJ
         6KuDiC0pHW8Jk/NyIH+oHSfG2/AEK0ppHp/TXf7YTgRA3MeDMux4UEFC3h0QHwpSs/yP
         0ZYtKeIyzIFwlbNVWbeRGx2uuVFqu4jc4nG2Dr9Xow098xSzQ+5Vz1q3dT+ABO9M2Mt8
         WwCLoqlWNaAPv7FsvPPIW/2DZ5Vj0akaXlF0hNnFqM1E4YgldqgUSbA+QQUUcq2JC6Ia
         fOwSG+NOnXiYn5kvam9Hv/yKyPklD4G2bZBB1j7kIm1CHfiieZFyYqY5xBnSj/O/TGcv
         SgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169226; x=1755774026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEhRKi0HmzptgOPz8lO5moCSp0j9P7xyPzVGCUEQhMI=;
        b=RbJnMUE29wTVOdVwyC+Uld4VQi7nQxlWP8VgejwBeqm0AvvwCVH3/nA2Cz8A+wxlnn
         R6txjnHVNlK82JDfCnxPQwYhI7P24XPbsygHY133gotJKmQJp+jDrdCm9Ly6Bx3yYS47
         +XQFe5MAkrMoUf+vaVmq/LsGmMeWq6gEHLq1QS/Wryp+nGG8Joffv5jL13cePlnVn+cq
         /WLflKrsB8rd8nHcwR9j5N6M2Xu12+xshJphlOMkH7Znpi3/S6qnP6wMZAZS7/iHLBbv
         06D43qQaFO3bX2t75rqK0Keb81katggmty5fPMBUpAzMDxLGmVsxG6PFiAq2lR6WWEP2
         Xnpg==
X-Forwarded-Encrypted: i=1; AJvYcCVP5S/O+7A3+moS/E3+/zYJGG6Yv4h2yWTYh3B+OrF088fug+IQZOoVladdsc6/y3+jdE8JNH7l3cRF@vger.kernel.org, AJvYcCVaMwu/gAtc5nZXPdJbAA3mSCQFDxGaYl7flQa+JjhLqeqzhXd8y6R8rtg08r0+usY1uFKUHwWbamPQ@vger.kernel.org, AJvYcCXBE4MwDvv3SRFBH9SEsNMs8GI+s2QDomAWmFeJWqZpsJ/nhQsdi5S1Hig8OCutZw3cZ5e3Ydet3EaoDVJo@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1CjUgsI97YniW7Et376haT7b57tMFYCy40uSzPGb1rISQiLU
	HfW7LlG2oTrZbzXlv2umcLlV/2msJ6s50MCmtq2TqaEwo8J5iuT8oxwS
X-Gm-Gg: ASbGncsRQzJCgczMCNEC0P7SFpmaBtfEVrsNMQR6uGZGD+ZYza1/MfFuufH+xr52p0C
	d0lmmbzZ5I+YAmACcUyH5lNNBby5uI38202z0FYMrjeBxooNKqcewwpRC/xUld/yg5u+AxZQmHT
	yKYpgI8FSr3G1xupCkCxHWmv48fjDglaty7L7d4ae06NJHR4Pfy42y1wG4fRkkYEst5B5ItjzUY
	VwyCn1vdgQJJPEjlyNhxDlT0P2WL2fz3mGtdsC575/XpSowbmXkRU9QuBpWrYlMlBnMeaSbLmW/
	PKY70p1WaFcyC5KUIFvTL88WNr3wJTiWcCxEQhZ/Z5IP4qlTwwJxb7oFADWuAxpFxnBhCsy/5vT
	VNmszrFRMWy3oenRxfjgDM0V6TLzv
X-Google-Smtp-Source: AGHT+IGpy7AcomOG/iirooZ0YvCAWeXA8dWfouEtFX/dDgW1yuQGdQaKNHMtlTNXifnaHsiJk3/ATQ==
X-Received: by 2002:a17:907:7241:b0:ade:8634:7b24 with SMTP id a640c23a62f3a-afcb9398044mr248048266b.1.1755169225500;
        Thu, 14 Aug 2025 04:00:25 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91dfd4b31sm2542980066b.85.2025.08.14.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:00:24 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Thu, 14 Aug 2025 13:00:18 +0200
Subject: [PATCH v3 2/4] iio: adc: ltc2497: add support for LTC2495
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-ltc2495-v3-2-c2a6cecd6b99@gmail.com>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
In-Reply-To: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755169221; l=1588;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=7dL620a4ki2oCdeq6jvorfDoA7+7B+wm9Jmm2GXEtLw=;
 b=ZXQ9yA0JvgKaKvwfDWCsimXZts/WH/Z81TKnKQZoob3XZ2KalnOJXqQfR5utMxnb13AGxGR9s
 UWAYTxdVyqcA2FWWKnKW3Q01dG3jE8Gm1ngDe8uiaUaQ7hLGbQiNtJ6
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Update the LTC2497 driver to also support the LTC2495.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index eb9d521e86e54def0493ea0e81f63b37900c56a5..8f4665547b5b0d32084599f8557c40102c37a4ce 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -19,6 +19,7 @@
 #include "ltc2497.h"
 
 enum ltc2497_chip_type {
+	TYPE_LTC2495,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -131,6 +132,10 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2495] = {
+		.resolution = 16,
+		.name = "ltc2495",
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -142,6 +147,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ "ltc2495", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2495] },
 	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -149,6 +155,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2495", .data = &ltc2497_info[TYPE_LTC2495] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }

-- 
2.43.0


