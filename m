Return-Path: <linux-iio+bounces-24696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305BBB8808
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 03:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8013C4E6119
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4218220F38;
	Sat,  4 Oct 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ironIDZ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF321A447
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543016; cv=none; b=p4bPmidqGMiqJG0nGjxFqnxvEcehcSPD4VWxLjQq3TeiS+47myW3/ky1gDKToxaNb5i25ySFaIXDEocZGR+1u/o0X9flrqtavcTmrZFxITARCvxuPFVI8jjeS/JTtcCQ4N0X4X7RGFSJvjFEaUOBzuk1ngQaMFH1su703oeUKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543016; c=relaxed/simple;
	bh=60sFE8dH95IQRhjstRyY7EVNnqU2lIgts0o7HyQejn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quh2wSVr/eL9y7sunibk9WuvSCiRvYFDGf/5X9RWOl2GfxcuJJC762Cm3NgOF5qFUh8CnrKG8GxqeeDUdJ0cI3+x3Tlim68w9ZHmJ9jmao2rgwkkAjEokHMaLYKIg+A7rIkQvZpEriXKN57vUAuyQT/Os2kyHvQ9s3DIi12sOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ironIDZ4; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32ec291a325so2332027a91.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759543014; x=1760147814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXs1QSVIqrmDB/CsKZ6PEf+V8gETdC9cB2i9VQlHTvA=;
        b=ironIDZ4udqKpjhSZpwBgM5dXqqf6gjHm26vva9HCngT685JrolL9UNhibj0dBlwSx
         l+AKJP2jbVFRSCUtOHvzGDcQ8s5ujWJxPduox8/VF4ydymvgS6SU7/QGtKqC3bTLz5L/
         nK1XtYtyMpw5F8efTW6rxPOniakQxBIcq5Lyr898t4N3FBjorBk0p2qvZr02LkVK4mZj
         9acOYCcHfHoxsQGAnfJc7lTS+vl7IdAuUEEJzl2dQVgmzW1qfEQBzEzReoHc1rXCc2rr
         l/oWm+YAW+0KdQofSBE3HOQGYxIXAKT8wir7eXCwqpZyoMCrhB2urOm3eMxYxT1KJRmU
         DBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543014; x=1760147814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXs1QSVIqrmDB/CsKZ6PEf+V8gETdC9cB2i9VQlHTvA=;
        b=lz8XqF5yjM/amUvZPbtyWnilhLGVDPru82/jW9FdmPZn+v9QGfjljbmVbvMAqhqTqC
         zRLmbeWYb5H9RMF66wIL8ccFAWath+pPfsN2Edd7VrDZ0UqyHf4vRWEZ0+JwtmOO/9gZ
         Pz/Y/oTAWGIRVMHnLp6eaYmwP44EvLlxkqPz+1IE7Y5ROMJVDhpKlc7NimL5vci48kyQ
         eyIwYpAOgz87mTRqlButgete7BAST4hIQjSCYFHc1szMuvlYAakRf+1M8BMRqR9YEqcy
         3RBn77wD0Ueb/gfWepOXlk5s7wwkyBso+p+N0iqBRSe7KQU1wfGA6bEIVgo0qiZNBMF5
         WDwA==
X-Forwarded-Encrypted: i=1; AJvYcCW9PItBWAx7y4x5J3nyIt2wcrqfKimJTGdKmb0yA6Y/GSw8HCgzYoQZ/Gh5FwjLZ1BjssJhQBUNvcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1e/o6St1NJzOuXGz6w/mDS2sG6iwZNyouV/8vk1HeZsfriuG
	HSAtPZT/M2C76JkbWMMNgXJZtyOlW5/6y3O9MEi7lLrpuhXhi8O0AoUslmfPrW3t
X-Gm-Gg: ASbGncsoIJ0IMb/y07Yq82jx5MIlZ+EPPzHeqiku0q6u1h3Bm9yRYrF9EgGPbpD5g43
	Vb7zG5JnfuGg9jvWyKE7UiREWcNEzmoZglWqjKpgPqATiOoFbUnf0wAhu8WgbRSsk4Ju33J4zbR
	No/UJ1iyg3YYjXzYAoobFjiFNgEr/21jc2vlLqRzDEZ2ELOKRTWTDb/X0gqMhjBc+jPmAIoL4KP
	IgcY7FFLGX7VvODavQI+G5Woh/ZxiIWtb+2XQho+DAiOqkZM9m9TKvNKHded32tPrLM9pMGlnVT
	VXmJ3uVWlCfPIS2kcWaudl+3PoGYo8cWLvFhRU6N2UxV2/GU7H+udswPvqoyH3ndpyxWhwtLTlL
	LpDI0K6MxjH/94RsJQyIpbmJBWfwYGttyIMwQspRU3laCk4KDVuVf1zQ=
X-Google-Smtp-Source: AGHT+IFkvcg76qipc69NuQnIWNLwlZfZsq2gWo9bV8jdBE0nvip+ixi0boun0gdtaOb85HXiysRS2w==
X-Received: by 2002:a17:903:40d1:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e9a55c07fmr62108745ad.24.1759543014242;
        Fri, 03 Oct 2025 18:56:54 -0700 (PDT)
Received: from Ubuntu24.. ([157.33.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d134859sm63197485ad.57.2025.10.03.18.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:56:53 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 2/2] iio: health: max30100: Add pulse-width configuration via DT
Date: Sat,  4 Oct 2025 07:26:23 +0530
Message-ID: <20251004015623.7019-3-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004015623.7019-1-raskar.shree97@gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX30100 driver previously hardcoded the SPO2 pulse width to
1600us. This patch adds support for reading the pulse width from
device tree (`maxim,pulse-width`) and programming it into the SPO2
configuration register.

If no property is provided, the driver falls back to 1600us to
preserve existing behavior.

Testing:
Hardware: Raspberry Pi 3B + MAX30100 breakout
Verified DT property read in probe()
Confirmed SPO2_CONFIG register written correctly using regmap_read()

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/health/max30100.c | 39 +++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 814f521e47ae..2b3348c75beb 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015, 2018
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
- * TODO: enable pulse length controls via device tree properties
  */
 
 #include <linux/module.h>
@@ -54,6 +53,9 @@
 #define MAX30100_REG_SPO2_CONFIG		0x07
 #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
 #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
+#define MAX30100_REG_SPO2_CONFIG_200US		0x0
+#define MAX30100_REG_SPO2_CONFIG_400US		0x1
+#define MAX30100_REG_SPO2_CONFIG_800US		0x2
 #define MAX30100_REG_SPO2_CONFIG_1600US		0x3
 
 #define MAX30100_REG_LED_CONFIG			0x09
@@ -306,19 +308,52 @@ static int max30100_led_init(struct max30100_data *data)
 		MAX30100_REG_LED_CONFIG_LED_MASK, reg);
 }
 
+static int max30100_get_pulse_width(unsigned int pwidth_us)
+{
+	switch (pwidth_us) {
+	case 200:
+		return MAX30100_REG_SPO2_CONFIG_200US;
+	case 400:
+		return MAX30100_REG_SPO2_CONFIG_400US;
+	case 800:
+		return MAX30100_REG_SPO2_CONFIG_800US;
+	case 1600:
+		return MAX30100_REG_SPO2_CONFIG_1600US;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int max30100_chip_init(struct max30100_data *data)
 {
 	int ret;
+	unsigned int pulse_us;
+	unsigned int pulse_width;
+	struct device *dev = &data->client->dev;
 
 	/* setup LED current settings */
 	ret = max30100_led_init(data);
 	if (ret)
 		return ret;
 
+	/* Get pulse width from DT, default = 1600us */
+	ret = device_property_read_u32(dev, "maxim,pulse-width", &pulse_us);
+	if (ret) {
+		dev_warn(dev, "no pulse-width defined, defaulting to 1600us\n");
+		pulse_width = MAX30100_REG_SPO2_CONFIG_1600US;
+	} else {
+		pulse_width = max30100_get_pulse_width(pulse_us);
+		if (pulse_width < 0) {
+			dev_err(dev, "invalid pulse-width %u\n", pulse_us);
+			return pulse_width;
+		}
+	}
+
 	/* enable hi-res SPO2 readings at 100Hz */
 	ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
 				 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
-				 MAX30100_REG_SPO2_CONFIG_100HZ);
+				 MAX30100_REG_SPO2_CONFIG_100HZ |
+				 pulse_width);
 	if (ret)
 		return ret;
 
-- 
2.43.0


