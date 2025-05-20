Return-Path: <linux-iio+bounces-19759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34062ABE7A4
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F95D3BDEF3
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5245269D1F;
	Tue, 20 May 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoqFiNw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF442257AEE;
	Tue, 20 May 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781452; cv=none; b=DHkszDIu9mqXyzyhS/OxnWrmZFk9I9tFZOln2AMniRf2HQModgwkEEPvey3ze6mM0Se7bK3wlx6dACz049z2OC+WMrUED39gJrybzIFxYruPok0XcK7hKdpazGWeriUOCJ1dtMlGA/p5xSXm8kNhKaGlrsDkePiQSTzity/RWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781452; c=relaxed/simple;
	bh=ViUgs8SXYjeDhq3OT6Jz0RPEfnAHuEc8AIUQHzSbjYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjmL3ZU8d+5vaZhI7HFdgUcNuOQLfhI3Td1ZVc2CYZdgo07iJzoEkK8ykbdiiHfVFJsetEumtQVqKiq2O2B0YVyzQHhtHgB+FEWzi+kgWXnSQjfpVYD/0BwDD8InHhhAa/Nnyxhh3y36af+Dzn6xYhK8G/YT8C1UohlsRgSr8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoqFiNw9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a36561d25cso529875f8f.1;
        Tue, 20 May 2025 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781449; x=1748386249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyr3AfSNWGXRiE2Vy39bcelF+i2ZJ1+soIKZvFdpcvA=;
        b=JoqFiNw9Lf40pRFGl4gQUv3gmCtosWoHIUpu25M35Z5CMoMOgK9piJseB5/nm+tfVY
         DzpxX3UsodT3It9AyTJNtUzebRIpHAzyPnAyjEuZ8DPe1TyS94Y8Eg2pzsYQsNZ6jMIZ
         K04QCT/6I9+u55SXvv97LmUzRZyFqpZB3Dk6fJP/nrvC5MTQ0i4SCgCPhNt9hXQhj8AY
         XhPz0V+kP11thP555I8hqVC/TZI2X74XeCDcK2Qsvf0mNRQcBsnivkEynxMb54lfeIpY
         1AsmbaS94kcWtVLwG67570a7+CYcDS10SNfxq8YJlQnUft8ys236OvVl7Z9VbIX/DSv+
         hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781449; x=1748386249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyr3AfSNWGXRiE2Vy39bcelF+i2ZJ1+soIKZvFdpcvA=;
        b=oJBQgbsXedyZcF8ZcE6G+VQcYYprxCRN+gTs0zw45OLckaQaw2t7eDQtGUYaYxaAHI
         63kfLxS3GsjLTHNMo95i2MLZgq3qK5ADXhT8vut8BL59PVuFxvfg4lP7C+Y8vkgAC3Fq
         hf0MWmgUnsY5t4jUioEbUYjx/2z6LxlVA9M57iZbqUVDE58xeHA+9zdzp9m6oTZ2LDgm
         udDSn/4TXLDRVDygtDEX3GFKkm7vW8fSx/GJV/dLd1VpZoq8DC7GTjXBJdrt1bxK+qBE
         eCh0qvXUHNfFczF7Wbeu03zWJeqkUOl50gt1Sx+Vushkh2vG1YvA69dUYFcuUx3Mnc7I
         a+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOodGa1Hv698sjz6PfnnYNRsZggw2G6fWnRFZvht7I4+gG7NU5W/9IhjsM5LqlAZBat1rve/ZEB5s=@vger.kernel.org, AJvYcCX3SUZOX5NCxBgMKZtNBUmGSQVfF7Fz1jUsxtXORBViZCTWT5H4yc6MBIKSdRwvSUi1fmWWYud11OizGhqz@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3E9qvutxtKFm7fZchNK2J4+74ciNpT/SDGoEDNBcyS4K4urV
	4UOSO8t5owr5n/HeiZAPpASPY+4XmvGWE8P2h8BTBMCVoJurVeUPMA85
X-Gm-Gg: ASbGncuL7OTRKggU++9hDxWBqKFf0gYTwD9p5xlbSK1HSBzyFmwzKflkH2I/v5oYsKW
	8jDufm1GPt+80aoBl4tEVJY2sVau0ROmfzW/+8bLivuPGj1QtNcPUY0idlATHVzQ21TqiFPEXMQ
	NpZaoGupyjoYEBeDB5Kui4aV/YlMYb9WcWB/813WPCZeZaO5qSbXN7XQyQc43KsgEXYB8gtO9Tl
	xS3i7PWoNMx6zHaDde0cmglA07YK7V4prLB+QRJyyebWgBskBSwvD2MjjeUEWmXgudoUfOjClHM
	DpMpm7Yy8ZiZ0jNbkNpBivjPtncQMgpWoqiA/Qb+CEodZaQ5e7bMKawO9/WArfWkmEVAwfVQ1RN
	6RNSfTBNqMDEQsFOBpW8sLQ==
X-Google-Smtp-Source: AGHT+IEyO67MvAyotqGnCEuNvR9Br6Cp7SLyGm/jsuZXnjt3kfdCcjw28RyCyA1VtWBCwCvjJmo2KQ==
X-Received: by 2002:a5d:64c5:0:b0:3a3:6964:57c8 with SMTP id ffacd0b85a97d-3a369645a0fmr4221589f8f.5.1747781449083;
        Tue, 20 May 2025 15:50:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] iio: accel: adxl313: implement power-save on inactivity
Date: Tue, 20 May 2025 22:50:06 +0000
Message-Id: <20250520225007.10990-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link activity and inactivity to indicate the internal power-saving state.
Add auto-sleep to be linked to inactivity.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +++
 drivers/iio/accel/adxl313_core.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 1398ac54d19b..eafdf8f57816 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -41,6 +41,9 @@
 #define ADXL313_RATE_BASE		6
 
 #define ADXL313_POWER_CTL_MSK		BIT(3)
+#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
+#define ADXL313_POWER_CTL_LINK		BIT(5)
+#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
 #define ADXL313_MEASUREMENT_STANDBY	0x00
 
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 7356aacd8874..2b24e6b01f1f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -390,6 +390,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
+	int act_en, inact_en;
 	bool en;
 	int ret;
 
@@ -418,9 +419,31 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 		en = en && inact_time_s;
 	}
 
-	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
-				  adxl313_act_int_reg[type],
-				  en ? adxl313_act_int_reg[type] : 0);
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type],
+				 en ? adxl313_act_int_reg[type] : 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Advanced power saving: Set sleep and link bit only when ACT and INACT
+	 * are set. Check enable against regmap cached values.
+	 */
+	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	en = en && act_en && inact_en;
+
+	return regmap_update_bits(data->regmap,
+				  ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_INACT_MSK,
+				  en ?
+				  (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK) : 0);
 }
 
 static int adxl313_read_raw(struct iio_dev *indio_dev,
-- 
2.39.5


