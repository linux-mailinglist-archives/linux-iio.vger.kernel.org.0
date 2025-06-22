Return-Path: <linux-iio+bounces-20849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05036AE2FD8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC673B32C7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4C1E32A2;
	Sun, 22 Jun 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSRFNQ0A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F201DF268;
	Sun, 22 Jun 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595386; cv=none; b=QdjcP4gLntBBHSAgP6SHi9peckwWgJGMGPbSsdFrxxaBBP7WahOCz3a/AWbU3oJ6G+OtpalD+upyt27xV/dh0lRCD/PomrC6VFcM3kobHkPYUa6NPG8mD6LqFIcApzgl3SoRxhBMF+bDZXsf1TGSyzcoDZw6I3T1F6XoeV9SSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595386; c=relaxed/simple;
	bh=UcgcEqCw0PL7brA0ULNFAVG5OCacnVt1+oGOHEMXQJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N94wQZ5typsil1gDyrEpNTaw2OQ48WqwurgcCkZyrTeVcC8HXSg4cMqrWB3a71MkaIRMa5Sc/zq8UpLQSt6kNSCsAi6blxmSt1ZOCvzFCx1fqyXjtshmnEhCzb+0kOx0zCcHuHZsxqqc0pZS6wPafKs7ETGppt+sDITKH4W31UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSRFNQ0A; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so629716a12.0;
        Sun, 22 Jun 2025 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595383; x=1751200183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1N8Kch7jeHatV5Og/Y1cg3se+x+O0T3ohxb4+AYATE=;
        b=KSRFNQ0AAD6BVaBqjdLZzC0ypCoU2yo74CRNwY6RHv19+0EPA4e4I/1OuOp2sCuR3C
         gIrtFjrf0dYujgrAC+TDxA6MrpevqX5MDidIa3Ln19IiIjbdLOtnZeE0yLrvA9lxqNsk
         3obCNSZPOCdsBgRS88vLLl2TusJApE62hxL1C5X3mUFtjWFhHU4ka0M8LbbYEP0hkaeH
         F7oTVpJllh2LyUJCxuHpwc6mFcy9AVNKvTYy+CqRaSIKimCHW58M+m2LOjnp9QpmhMg9
         nBtVBgR9ZCLkOnghzRfKcOnX5XAJn7OU6+4bmRG+dZu87DGQ2+P8pVZP3pGGd3+VF3rf
         lSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595383; x=1751200183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1N8Kch7jeHatV5Og/Y1cg3se+x+O0T3ohxb4+AYATE=;
        b=Zxvo5eHKYsAR6AOA/4WKCYoLPJe0uSEYzvAROBFS4VpgHyECDycd/a5pPJab2yGH5k
         MHlH7oMrGuUhsQKvctei+0wABGhihWaHfewKRdgebGK9p2shXqgwlWvCnzQJIiIsl0QC
         j+BHTZ+vEw2bgh/E/TIYMfdQwQujjOaYQVVfrg+O6mgxje2A5ei8MBG6GhjYwNtSM8pY
         WY5hBofXTprgFWwLr2RPRs1Y27Ka0l1ux9TZGjhQUVPyWq0zCtCXNIZJCUfWM1aj8i5S
         XNDEQ18aVzNHNKXOeRdWCt+CR+uNMgK6DLm1gCRDf9rkAdyNoioV3B0O84zQ20SNYH+l
         jxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMyLjZbSwP/CaR6PVIIhN+1A0Lmu7XGsG56K7tS07E6wlTGiDmY9paI0vP0eTMflcMYEa9YvgGYh8=@vger.kernel.org, AJvYcCUcuwTM2mE+YM2AkV7WwF4/1F1STd7cS5tn2yZRkB72B1SA+gBmiZtOhtc59RkRHjK/QIrSLEfcfkHe@vger.kernel.org, AJvYcCW137nsJyAMr+5X1NgoaOu/ETka+g8EcGvwhu/HTMbCBJ3gdwidFmkgAnRl/qONwxY9lga0U1myQGECCWDb@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZwvrxajzJZw+eYatLSq6AuFZ5wch1YLZb/qzBWzDzZaKqCb4
	lqzsGs+X6eE9rD9DPY3uYnwPysD++aEkVLhm/i1LNJS4k95B8+AM8pG/
X-Gm-Gg: ASbGncvGsw1fHbrIkeX0DeeuNk4FV6T5iS68+nd0VOu20cRntOKyr58Xv0bJbBNq3s6
	9f2DL0GIeCxjReU9eDCiiYRM7ADsffYv+fchHbQKdAiKBUbQjzvBgn41Gj2FhDl3fe+BmzwUGFs
	mRlDf8rA3foGxGL84EBipgW3mK+a2OxvOoN9wQ58WmAbgJUWZJa1yHWb7S0+ZQ2HgCwG/EuFx0/
	FoE487Fz/AhW+HjejXqNNQjoU0UWxpRyW9xpcBI7+L/J5TdgEzosV/d+hqz45e93f5Tw7s1Jdu6
	kEhKVQfmWDdKM8xH3OYDq9z8Sj/0YZzQg71HsASnDlUSMGzPKmW+PAfBDPE8G3sVakGhEY6IL4M
	Cp6QbDZYEC3tPj2DNyh9UCl/7uPxO8f9N
X-Google-Smtp-Source: AGHT+IGgbo+CyMmgtJwwwuMh/pU6gITZpDTUxtrNwayU3FR0Gk6pS5tnXKxLM8Ia0s6QsOyEwZaqJg==
X-Received: by 2002:a17:906:6a18:b0:adb:2f16:7ba1 with SMTP id a640c23a62f3a-ae0579549b1mr290449966b.6.1750595383091;
        Sun, 22 Jun 2025 05:29:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:42 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] iio: accel: adxl313: add function to enable measurement
Date: Sun, 22 Jun 2025 12:29:31 +0000
Message-Id: <20250622122937.156930-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the control of measurement and standby modes for the sensor.
Instead of directly writing to the register, encapsulate this operation
in a dedicated function that handles enabling and disabling measurement.
This approach will reduce code duplication wherever sensor configuration
changes are required. In subsequent patches, measurement mode will be
set to standby as part of this process.

Additionally, simplify the control mask to include only the measurement
bit. The sleep bit governs a different behavior—putting the sensor into
sleep mode, not just standby for configuration—and is currently unused.
Therefore, there's no need to include both the sleep and measurement
bits in the same mask.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +--
 drivers/iio/accel/adxl313_core.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 2bc86ac8ffd4..6958a00f5e8f 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -37,8 +37,7 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
-#define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 39f16f97bb4a..99a7f3755031 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -64,6 +64,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, en);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -398,9 +404,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


