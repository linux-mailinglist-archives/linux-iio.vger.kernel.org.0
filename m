Return-Path: <linux-iio+bounces-19780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597AABFD1A
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91AB4E3B6C
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1228F531;
	Wed, 21 May 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys2KMX/w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3D22173C
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853907; cv=none; b=dewlYMqSog2hyeL0ml3kuF0DLLSOAlUVo7N0P1jDuXyGPsPC/l9ScQvv06aWWponvCszceF87uWeBhK/7uhjYuE0L9n7mwAJwJO3UYpJlTrYBGR2jmtIv7O7TN9oSHApeW9JYQIYh3UlUBdaEd41Z2qegVd+sX1yz6zC5Uro4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853907; c=relaxed/simple;
	bh=0rPYxxUuyh7Adx/a7liI0gIl/FroUfk2zHq++KWr2B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhBz5DabNCpx7OnZt3rdzre3fY4nuItWOXV0n9n5bJt2DU3TF7CM/aIpNgNfM3wcNufCHG2B6YCekZMCmZEIHLYEQmBhUg7O1uc+hYXp2gj5zZflAqKGiIuM3F2RhoYS3a5KvTl8+ueYkCr9riHw3dayOVAuQiiRRlS8cHqsas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys2KMX/w; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso1500518241.2
        for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747853903; x=1748458703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20dcCnRWVBhpAKFWh7MOe4Al3icC8I7nkn2n43DxmX0=;
        b=Ys2KMX/wDqgBunEpjFIVMIXBDUqoPS/aUASJ6qRcGuajaFe9x0PsQxf7t7XnhYwqaT
         JfZcN3kyuY2ICqWQi4Po4xUM24LWSpD/aNF1OTT6EQhJ2rKMWSXGguyu91L2VY+Is0FF
         yXhQwNOOQ5HO/QprblUXWJK3hqDyB3AnbUAUZwZdHk5ANjuqwOvfOwD6oeGQRmZTU9Br
         X9t1t/gqpjL5FOnk2a6a23wwzEBPf9qPq/vtJ+1kBJCEl8OnEaH3JX35eSSZ9UbqryUt
         BqBiWJd2WjrurU1VeCRE8PbuGkI+0e7Ux8VIfnFHku6A3wXHhOb4hdgivbSqY+OKZvmN
         lHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853903; x=1748458703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20dcCnRWVBhpAKFWh7MOe4Al3icC8I7nkn2n43DxmX0=;
        b=U+Jk82S4sQGk5q4pPTET72q2EmwPlMVuxBa24h3bWvTO4ZPckRvwTEK19Ug5dhnKgg
         teDaSsPP4avFiyyfFon9E7XAU3ENdThfUSH32PnAYjD9EQwa0/i62u+/O6rdJJPj8bNg
         0CMZLbSCBsgt6CIBZkDcuhs7aEu8s7Ci8g2DcXMZ/0twP91Htew8TjMWTFLceeFpgQtU
         4kF9W1z2MgCVKpSUJj8AGEdTgq8R8N9JdtS9usRtKtUkzcUXCDJDx3Unv5RbxYFz/7yv
         EROIPhYg2P2Z0sTU92GP8k0AGIlflkypRXuMnIIpGMm9yGAsH93qrVbuVwc5o+XkJP6j
         Dg3w==
X-Gm-Message-State: AOJu0YzUuV5kjD8alBF+ZQ7+ZFdorcL65ht8KEGqw77c34szVtscHvF0
	E2ij5/IV442TF+fJI3UGIrx3JdBnedCDz4jpvaICCGhTIDs/7dQXexwz
X-Gm-Gg: ASbGncshpfhU4kXepmPGOtpR6T1P5DAehHrTU2Fgmz82RgLCz0wAsSYM0rYTgEOjSrB
	V6GzwylJkpdZjInamtCW3d9gyyL5PYoOqzoSNOebVinzxwOZdpdGEL9XJQ6Dp3CQ9mBItKCWwyX
	OKWxzSJKbVKwvC8/R1EwH2zIC7iNhYdu1JEiEWesSr3svuDocHLyV6NCLLuOIIPl8VcyMncg592
	sQROiRghjxSnQG5ueu8tcukJ4Wdq41Au2RgykpKqEXMUoyoy74isK94D27Kd7sEYenyExV6WrFt
	9hqnOQoYwVwzeUnjPHHzZlV3ZkF5O9wNoYs+Q2CpoLOzYCY2YQPBbG65ac52nGfe/2BGQaYx2hr
	WvXh5TsjzVso2/98ksZPf3CfYmniS5qutgMv2J8Y=
X-Google-Smtp-Source: AGHT+IHsH5sYndvdUCdo7eNZXGaDE7R1n9tHex+c8YHNJdL27iUdmyWSnIp2iJ7H53H5GSjY6+Kb4Q==
X-Received: by 2002:a05:6102:f14:b0:4dc:9486:b055 with SMTP id ada2fe7eead31-4dfa693fba4mr22136563137.0.1747853903123;
        Wed, 21 May 2025 11:58:23 -0700 (PDT)
Received: from biel.taila13fa3.ts.net (200-161-29-134.dsl.telesp.net.br. [200.161.29.134])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec155e21sm9292048241.17.2025.05.21.11.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 11:58:22 -0700 (PDT)
From: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>,
	Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: [PATCH v3] iio: adc: Modernize single regulartor call
Date: Wed, 21 May 2025 15:54:03 -0300
Message-ID: <20250521185807.139828-1-gabrielfsouza.araujo@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a single instance of legacy regulator with devm_regulator_get_enable().
This change improves code clarity and aligns with modern kernel APIs.

Signed-off-by: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
Co-developed-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
---
The first version [1] did not compile due to incorrect use of pointers and improper
parameterization of the devm_regulator_get_enable() function. 
These issues have been fixed, and the code now compiles successfully.
Additionally, version two [2] had an incomplete patch, which has also 
been addressed in this version.

[1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/
[2] https://lore.kernel.org/linux-iio/20250514185239.10078-1-gabrielfsouza.araujo@gmail.com/

 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f1..a37ba6fad146 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -911,11 +911,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 	adc->map = map;
 
 	/* Bring up regulator */
-	adc->vref = devm_regulator_get(dev, "xoadc-ref");
-	if (IS_ERR(adc->vref))
-		return dev_err_probe(dev, PTR_ERR(adc->vref),
-				     "failed to get XOADC VREF regulator\n");
-	ret = regulator_enable(adc->vref);
+	ret = devm_regulator_get_enable(dev, "xoadc-ref");
 	if (ret) {
 		dev_err(dev, "failed to enable XOADC VREF regulator\n");
 		return ret;
@@ -925,7 +921,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
 	if (ret) {
 		dev_err(dev, "unable to request IRQ\n");
-		goto out_disable_vref;
+		return ret;
 	}
 
 	indio_dev->name = variant->name;
@@ -936,7 +932,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto out_disable_vref;
+		return ret;
 
 	ret = pm8xxx_calibrate_device(adc);
 	if (ret)
@@ -948,9 +944,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 out_unreg_device:
 	iio_device_unregister(indio_dev);
-out_disable_vref:
-	regulator_disable(adc->vref);
-
 	return ret;
 }
 
-- 
2.45.2


