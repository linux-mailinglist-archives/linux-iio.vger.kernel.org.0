Return-Path: <linux-iio+bounces-16307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E951A4CE32
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7169018964B1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486021507B;
	Mon,  3 Mar 2025 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaLuZ1Qy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A61DDA3C;
	Mon,  3 Mar 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040529; cv=none; b=ijdHuyH5wtSXT/WRe/uQ5prPMoWa7CzMBf7fxop4DVrQVP2OLuPmbQl9F4xy8HPx8v1JVt9KkmYC+GWrq7yLGQgZrgI2b5dmvCKhG9eUcvWWA4tWfGN6yCo2wu8PRhXJqvV6W5ludNQ5hbAgIFtHkg7prMWWH3UHfUY3LQ8mocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040529; c=relaxed/simple;
	bh=EF42/1BAIp47aMNnPl3OsqsgIgk+NQtbFmxeddW0ImM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7t0sM7eYWR8vJ0suMjbZnahXBtmyqLNYofSQ9jmE1lsMR9VIq215fN0YnY7ptxx53dC8Iqcwga5/dR4ZqbKOWFn/e3VeIDMTh2+bG7T9D0G3SfOOzSkF/KqTmCn/y2RhpwES6LOjh1NZpmHJZ0TlIR+IyM4B0VI++kshjhjn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaLuZ1Qy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239c066347so36212395ad.2;
        Mon, 03 Mar 2025 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741040528; x=1741645328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXQ7tGOydqTSote4qX7wPBoBmkDsJUvOOycr5KGfYPw=;
        b=UaLuZ1QyLvztUMDtq7Rhc6UgioX1Bwd4NTf2eay5R9C07F5/P4jN5R5x+ge7S7Fzwp
         keyiuEYdmuDEnQIzwghG4oRI5b1zmir0HQ2qlZALbERMLz/MM96eYxorDd5v0AgiqqSm
         kI/vZtNeX8uLWdF3/+WuqqfhjCGkUDd23q9M3xJraBJEsxTVdudm61JWNyUdfJFpQgV1
         y2Z0K/M1Yd7o/9ghSxWb4xXaAxF/VAEx81zoWGkvgvb2rBLCHk+zbZ+hQ5YBxbiU8iTv
         YFhLoV8ywPC5nJ2RIg61GWzexJqzzzIJzmeCid8cEB/t3kJ42AjIfx0O75lVZu7uyZsV
         j6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040528; x=1741645328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXQ7tGOydqTSote4qX7wPBoBmkDsJUvOOycr5KGfYPw=;
        b=wUk0ZMRly8cj+f0U+Y6vLa84AxnYE5kOQr015ws+EiIcUCkR7VCFdAc9nvADljwTq8
         Tekir8HtuEw7t6++JW38I0aWu8I4uJgGgBS3blFfINCM+mKKeQ4DzsZ3DCyGbnfoQC/B
         fI5MBAfMA4TM70fvduEK6Hz3VbejIHaViZ3Z0iD6PvmfEVC89ttoraiHb+1IyBLMIZJS
         RBCEV9xr+mKSh8be1d7UoqDJTBUDDriyFZwp5GP88GtA5/EnjoD38C+XKwg+Lo2idQhy
         AH/Vd6Rlih81h57LlaDKYpDeOnnVSPix/Jy61Wz0q278YInSUGfmGYC1UQA1q9KdBL+8
         CAYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDrs06jTHkMzarq3cFVcqxCwpwq2pLLeFbeat6YhJvOFfJGq69AmbgEz3Uhhfs1Np3AwDvvyCXjQkfJVYk@vger.kernel.org, AJvYcCWmZRHfG2LXyZ+b/5FwN1aN2wWV5ye22oG5OdfH4ax6ugpeHBORTiMd4/mNUJXSg140FtblsgQCLRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3EYHtY6OsAka8ICQZsjS5Qn2s/TQLQYGPCbUpihfXvW8W+uv
	0fuyD0eYRZftp3fVXf+x7+hX+JZIRUrmzMDRYIWUPgcBxNRuIjOd
X-Gm-Gg: ASbGncsehu6ERhGxlCaT1RYQJBjv6hDqLLyCg9Vv0pHJk2tdybBOSMFmzxDW+uT1HHR
	df5rm9FDQM+nWzzE/RfcVK+pQC/7UFf3J0VRLBZ1stL0aAc3fpxYUVwKfxWwoDsuUgchze8rhmb
	1V3A1Jvib5gQ+DM/UuFSEyRNhvdtah9jKT7VQjnNiLGLsvJM3Spj9Nc8i9IKumHwYgsvJNdnLfK
	2sXtEGk1sYxrOuyKGezwlMHSY/qdSlmBdOAQTFDNuMqlRAPswwbaNDxG3aSw/ODQQH8bv2zGJHx
	BtVEaAfz+gyFJ5ZwaYt+BacVlRg/1yFsZRvsM+63wvuil3rOLsqgj90fUgA54qhh3HLV
X-Google-Smtp-Source: AGHT+IF1JzJ+piCUX6XiUl3McqssRafqYyNaw+avOzvMq6yCjPwL6azcpCCODaHmn1A/ZRSEL7fVYg==
X-Received: by 2002:a05:6a00:4b53:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-7366ecd8f45mr1155328b3a.18.1741040527595;
        Mon, 03 Mar 2025 14:22:07 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73519c31931sm7047531b3a.20.2025.03.03.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:22:07 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] staging: iio: ad9834: Use devm_regulator_get_enable()
Date: Tue,  4 Mar 2025 03:52:00 +0530
Message-Id: <20250303222200.34339-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable() to simplify code.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6e99e008c5f4..5da2084c46c9 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -387,33 +387,15 @@ static const struct iio_info ad9833_info = {
 	.attrs = &ad9833_attribute_group,
 };
 
-static void ad9834_disable_reg(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
 
-	reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret = regulator_enable(reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_reg, reg);
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to get AVDD voltage\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev) {
-- 
2.34.1


