Return-Path: <linux-iio+bounces-22735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93D6B263C1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD21A16D323
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A32F28EE;
	Thu, 14 Aug 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7qTVoxT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67642EAB9F;
	Thu, 14 Aug 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169236; cv=none; b=bBmZ2zXt8i/5eVHZZ0/o9+0xJk1hZ4g/EKu4H4iRO8W76E0WqFoUgXM0UNK6NFuHxqh7rrEwbPuZvv3CTAbUFsjkdiE7JTKT8dxjy2IXCQCyCPldBvNUNU1i98TFmvAalsOZluqPqyjB06/wbPsSr8qPHFMp+L6pJL+fW+l3d9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169236; c=relaxed/simple;
	bh=ha3TYWbV+huAwQsCRTUDSrSg0nq7+oWMtWJZ76ApaJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvj867XdxlqDpOdD6XLBdvqtQktKV4l7mZhWN+k/tX9HnicYr+YVeBRQLisscQJTxrza+u2X+an6drqYWaYu3NVluG/EeeQCx6Sv6Ut2fYw1GcLx1LdCszOUlaaprgHtbgvV36Ir75o87hq2FvoczMh0jVcC4xv6fcy/+asFtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7qTVoxT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb73621fcso116010166b.0;
        Thu, 14 Aug 2025 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755169233; x=1755774033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVqngp6d0YHayShjN7NcmU4rtRaIIuqWkl5dT+TPW6Y=;
        b=X7qTVoxTrnD5iZ4vLXQhCv7dg8n/5otgdhrv3ZjXzQodLLWUW2/x8+l2sM7CwgmZiD
         12QbHgyD3i9MC38NkJ0U6PThONi68zGw6UDdn5yN/mFiLJ+OGpACdmTrbIqTn0T4oAU0
         xd16gyaHZYo0HiDIsKFswUYOa9bQvJcNh37G7mdEe2+bejhqQdgEobeYkaIxCSHi7koa
         ovKuRwayjigJtzve78zkcHpJOaVNjc7dDI3YNfE7Bs9bkwTMdlTyJeVGk8e7Nee26nyR
         7hlAHLwEdmf0A1+e7GMe1drdS9bowgXNpP0E2L1mNuTxcR+MKk9LUVc5CNRlOzPnhrKd
         1aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169233; x=1755774033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVqngp6d0YHayShjN7NcmU4rtRaIIuqWkl5dT+TPW6Y=;
        b=eZ25GEjgdyQz7UQnUiryuzPwQW3QlvxBdWMyL166RRihMd6oVcMXPTNKVbXqOARgGd
         WlGsnb3MNnT/+SWt1ckjrBK1tBH7dJ6CEADuxJ74unyXW0ETVq11DUn7rjaDgLjYk9DN
         6SGp7Eu/DLxa8SILcG5XCL6XUC5MwdXy+ySyaEHDNgnqoyY/MGvHcUJTp1yNyq2hBzKB
         5E++8H59I0P53kt5Foa9FHPWwi83dWPfjsupwkmCMDLdGPvljmrXUgoX17F/pU32SWll
         lWxmKsv1scIaKelptJ/3XyK9SVZ52HsEqzVW4/VY7+HH8qu8DGC7zyz3gHUrm8X7B8yM
         mnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5qmbSk0BXExHSCWygFfRUPWKVURAGc94aI68tBup28PSlPTT7V1hdSeBxru1nzy/7iGMwBC2HADWvXxmA@vger.kernel.org, AJvYcCUdkoZ5+dAvzSiE9SHXxgPwzjPq8+aMkO/AgZd5j1o3+jRQn5BY5lwsRje1bdXotQSGGgY9uT+hYJs0@vger.kernel.org, AJvYcCWBdWgk4y/n+GALc8SrzCR7lkdPcKkxpHL1PmHrcONwaXDZOM3BWMoXH8lQfsoasKkdxCKQpZONz4ir@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaAnDM7X2Mhwy4NM2iQKcyVLQIRqkH6rBOdY8bohrHIAuoQeg
	CbOXu3XFWhe2Wn2SaH9TV/LL7muD+5clgDkHvAT4Yl1Q0gb11EpPMKJ2
X-Gm-Gg: ASbGncuORQ6va4e0VKODOmENhE3CIXSVCEd8lcAk6z/9neHdwEDcdVfQOeRfYvdNyY9
	S2fBLBrfZ2jiPWF2cqkU+9aZj44HmgykV/nNCVOrfd86J/m7Fc93S78gR574Z+8YHFX6AaYQjY2
	P3nLQHMlGskcZJ1mzJy4SVbd54q4vOZw3htZG4MLaWS0k/O/cHYsoTWwaIOv4kuTvw7mhYRnihX
	wHQ5TIlAFa0kzJzt3CC8MXWGdvZklA4/gx5EfuoOR8FlzC7FAkomuPQOKwuheHlmOqRoMoDkc7d
	ZFZeU5evtKDHqBCmFYm4TmAqLCI33oCA0w+B9DilZrJcnr/O7/Fq0Ic5CMwt7nXKcP9nMzkuOQE
	CYAcTGD1VBA5RWyn4AZAYHtwMuSJd
X-Google-Smtp-Source: AGHT+IFb4uqgKytb6JRIALaC3r7ae///g9Z/qOGjhuJ/hLXr/TVNVTsIfJAGTCy8LbQPDjrIaOnPKA==
X-Received: by 2002:a17:907:9487:b0:ae0:ab3f:36b5 with SMTP id a640c23a62f3a-afcb981ee79mr254524466b.4.1755169233178;
        Thu, 14 Aug 2025 04:00:33 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91dfd4b31sm2542980066b.85.2025.08.14.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:00:32 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Thu, 14 Aug 2025 13:00:20 +0200
Subject: [PATCH v3 4/4] iio: adc: ltc2497: reorder struct members to fix
 memory holes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-ltc2495-v3-4-c2a6cecd6b99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755169221; l=1743;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=ha3TYWbV+huAwQsCRTUDSrSg0nq7+oWMtWJZ76ApaJI=;
 b=AAUFkHhsavrGE02LDakST86q8xbNc5p47qQxtm45rVCCHo0N+t1JNejhdY+/4DuJPXDJbui/D
 OW2xs1Rczi/BgFqc/a2zKjM//RR2j8u2LNCKtz9VkkydLJO3bfEwWY3
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
index 65f406bc61c24b912de4beed604a074b3ea9df91..578f55efc5c400980fe8bbd2b220aafb222d6f33 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -10,8 +10,8 @@
 #define LTC2497_ENABLE_TEMPERATURE_CONV	(LTC2497_EN2 | LTC2497_IM)
 
 struct ltc2497_chip_info {
-	u32 resolution;
 	const char *name;
+	u32 resolution;
 	/*
 	 * Represents the datasheet constant from the temperature formula:
 	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
@@ -27,12 +27,12 @@ struct ltc2497_chip_info {
 struct ltc2497core_driverdata {
 	struct regulator *ref;
 	ktime_t	time_prev;
-	/* lock to protect against multiple access to the device */
-	struct mutex lock;
 	const struct ltc2497_chip_info	*chip_info;
-	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
+	u8 addr_prev;
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev);

-- 
2.43.0


