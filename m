Return-Path: <linux-iio+bounces-12961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D089E0ADA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A766281FFB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8D1DE3AD;
	Mon,  2 Dec 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMQUHe4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D21DDC2D;
	Mon,  2 Dec 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163563; cv=none; b=NnkhELP0+DXKOJhAe9GlIcaz9y2iwxtZZL0ObxRddM4+fi0+k3ritazUCq0iYpxcCzbhSyXTU3jL5t1fLNXCElxIp8nObxjR/PzV2xgi28m8S2Uihw7SCvP0ccX5ZERonVyjVkoXix5McmWyAFL5TUpDFxZ5u84PaVrbTfhadAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163563; c=relaxed/simple;
	bh=8cfqVcuvu6Dd7DohWdDqpCnMytrUlELdFITjfBYZfII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHK1kxo44yY+3Th3jneUPWiKP7nO+DtGQtL0s2XS0FIFf+UM7qfMmTIZCgG/SZ7eJO/NZv52+NbepaUl8+ACPEm+6P6b86B0et0708MwZC8BSMtu5gkmGDPBoYXJzwTD7J3plO5VMPq8ElUn8k8o0mcl5jwPal1dYZbdCjqf/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMQUHe4o; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385eed29d17so1064988f8f.0;
        Mon, 02 Dec 2024 10:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733163560; x=1733768360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZI+PX4giaZn5+7rofJ1gQ2SKwa0tGnvULF4f5VsZys=;
        b=TMQUHe4oKbpXntQpjm5oMdYnxN6VWF+R0PEJTs1WvE8x7twxuuUCV7cWNF/Dzbm8hA
         FjsCgRmegpVQcaZy32nq+lSHG/Y56jJXyWyslqExUYj15POFgKLzaq5R2mYihVhBGRai
         XleFoV6xdcWMkg1UKiFCLc7X2MersE6FNKz3HFMYsMVFoqUqLMORGjeO1zkoaHboOGcd
         s2SmimkxkuIhT9+IS6WJScGzXYecxnyW9jfqPMack/xJcUINDXB2NzOgnnj1l8EH9zjw
         s2dwznuu154GV7KHq+eKFg24qQ2mKgWX7k5z1xzsuqYLkRkTbrR3IY70xP1eV1kokG8D
         ejlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163560; x=1733768360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZI+PX4giaZn5+7rofJ1gQ2SKwa0tGnvULF4f5VsZys=;
        b=F33CnqMT0VxRGOaKWHyaw7c+DwfxMbZeTAvFEnUXIYpntTdE+hG41ONk/5tnuucb3j
         kokDTntOpSy/UEEUlAAnj9qFo2MVCelvlY1CviEfuBbblOSpRW+KCzgV8zMFmHUiy4I7
         rhuLmsjDRd4Q35FsazZvVep2VgnPlFQvE5Lef81oYYdc+ShCioK3VtsjqhXpzv/g22iG
         AL1KJGmcATRRAyAyCSLmOevYlmMbS8w/LaUI2v62aGDcHZVZJYHS4k/jxfLSMEmh6ov+
         Uxu0IZXcOFEroY65BP4nrhhLO79UdwgNnm6M4p1ENQd3WwH2K5ceeL67/BSazJINmjss
         RFkA==
X-Forwarded-Encrypted: i=1; AJvYcCUglO3SHslnz29DrT714/MpRYnEZHvBtC6XwVMnbjKaEEsDoE7/OUZsw8gwpY5S9qBq0zidGyMz+J05vGG/@vger.kernel.org, AJvYcCUp5XPtD36NzGeKEpNz+pharBkmyMicrxcvAC8W9BHiHle1qAvAII1Ikbcq6pOwxTGovjPRi8SE+5Gn@vger.kernel.org, AJvYcCXrzvPgs3omv8fjNF/h588xoRRcQ9rBBEacqXX4OnrkjgB/we1xMGEL3s97an34hIOl7m8xZLsyzxkv@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8vMk/U6T4xRCIsSdw9RegSGvQBkiI5iQbqKRjFbL4HzAv8Zp
	OzGvd8zxpWzL98s91CU4rnsBYhMbfu5W59qzRAjl2kDL94fPsG4d
X-Gm-Gg: ASbGnctXBzgVO8pFz7DdIHCrwY2WBMrDm7RgRJ3n9QfVlDwdvghXWFnAu84I5bHEkmn
	MrHD00pZGBUVzcxYNuxavLVGSqr2zcQuuY5L64UJBAT43kM2H5QV2/qfwSLhpIYtZOpAVzka2DA
	AeF5FqODfJ7341ehTZulJmxWT+qOK6G4mu8NgI0wAQhIgmQQyP9kTk1azhOVdz6/odONsjNHRw2
	EdgTDpFsJCqnNQwmhj4WoXltHgFats7aLB0VPoEOGnfuu910MKXdoCZu8O3XjI=
X-Google-Smtp-Source: AGHT+IFRCfmBA9Br+e9+cpC0O5nJA9Ktgj/g+LYDzfon53L7mLFMHNjZ0IASQZv0OK5POXVzle2Nlg==
X-Received: by 2002:a05:6000:4010:b0:385:f0d4:d5ed with SMTP id ffacd0b85a97d-385f0d4d7fbmr5194789f8f.22.1733163560243;
        Mon, 02 Dec 2024 10:19:20 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385d7d4d9b0sm11659108f8f.65.2024.12.02.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:19:19 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 2/3] iio: pressure: bmp280: Use sizeof() for denominator
Date: Mon,  2 Dec 2024 19:19:06 +0100
Message-ID: <20241202181907.21471-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202181907.21471-1-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using magic number 2 as a denominator, make it intuitive by
using sizeof().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 2df1175b6b85..a3631bc0e188 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -470,8 +470,8 @@ struct bmp280_data {
 		/* Sensor data buffer */
 		u8 buf[BME280_BURST_READ_BYTES];
 		/* Calibration data buffers */
-		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
-		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / sizeof(__le16)];
+		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / sizeof(__be16)];
 		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
 		/* Miscellaneous, endianness-aware data buffers */
-- 
2.43.0


