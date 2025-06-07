Return-Path: <linux-iio+bounces-20281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D0AD0AD5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BC1891F70
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 01:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F722FE15;
	Sat,  7 Jun 2025 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yim21ykR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB343159
	for <linux-iio@vger.kernel.org>; Sat,  7 Jun 2025 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749259150; cv=none; b=Q2yqz39rTA/spr/tqKuG6NroUl2BupgRn8F3HGgPjx2csAQyuoQHfUXxkIS5IttDWNstwO/KQm7T0snv45MDIn/6AL/bnlMsYeHwxZssSTJ2vHrGVFPO2MdU8o7NyLKEMswdGrh8lwcgRFn1RoXoIpFa1nVgkZBs9waYwKbLbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749259150; c=relaxed/simple;
	bh=N0MQfUh3qnDIHKJWPOZW3bZiDg6UBDhCyzXoT12QhXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScFg1fmNRwA9OF3BiX1j/wZ9ZSU3qRB9+p3Q0iLqp4eWETRMnawYlTcfWJBvLP55dkI543Ryh26Lxwi0u2OFyNCpyCGaBVV7WO+o3kch1l9zijySZCIX1QoJf33nEolnE/jY9+6tQWaD/tUGK+neV3HgeExlnzB6Eh08KIc1o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yim21ykR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2320d06b728so24536435ad.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749259148; x=1749863948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUmnt7F6yzpxArYjmde81XGtS7JLzWqQOH4TUzKD8GQ=;
        b=Yim21ykRhVdbYHfioEYJ8yU01dZJ/PfcR+DrTOF4iBzimF/JxUbzvS9RNRFuZeRStn
         P19b60sUFGkXGDExl2mmAqv59EdKjv0XNZXO59Kf+UoXDUOZVLYZvJZH57ijLs7MK5Qa
         n0h0UtojV2dBpB12bSzp5c80O2acshwWBu5aE9pKB9JnWEqJhA+txJadQrzwc/lZ6uQk
         MQEAhtHoXBDLHMrkvG/kKNt64qszLrvOJ8MWUH5ps7HLyGWG9JrLJc8tcIXxHFtDrGQT
         xwz8Vo590F0nb755cRZ8eLkvMoCBKpDXkapp5T3aWynJKZALMAUbIQGoxQHQ9LgLw9UE
         XQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749259148; x=1749863948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUmnt7F6yzpxArYjmde81XGtS7JLzWqQOH4TUzKD8GQ=;
        b=XRnJfiAJAx4hpZTBwD/QCAUdemBIuM5LEfQG+9Knl/7NvlDxkzkI7ld0kePtEsS3bF
         hVUF1fn4LRFvZygbT64s9VNAGtKtWGKy8iHEVdsDVVdXHLlidkWKm3krfZkmbqToTJVl
         r3jj/0mA0EO0/x6WyJA2N2vTEP4liaaDFVyNwj8MngMGPiMk1GjfTDvjVFAnXNtp+Lu6
         btFPVtX0WRMOeg8YpGEkhyGV4A+1QLm1mtrB3MdDC6yO1xV8UZMABO2M9vFRFZAWdmmd
         yzA9mcOqjbCHvnrVrbNYmfBJY71FfH1qtv/ZOgxBI+EltdXNfycxJ6k3m6mOcXnCUCcW
         Yq6g==
X-Gm-Message-State: AOJu0YynuuBJP5OF40MqCnJeboi0lCogUsio9XWwXm4SIgokXRY3ZYIE
	MS9GUMhxk373uqMA0k0Nx0FABsjP8a+LLdRlt6ZsoIaaJ8X1a8WuM+DW
X-Gm-Gg: ASbGncvkEpb5e0E+MOtssnVIZ4DujpWghG9JdwSOjuVKpwqB24+DFt2xgBF/H9iO201
	QwAzAYaXQ8V/lpkdi8ikwegVDkyPoUCJpoSxFZcJiLaNiEnA3gWi5PJyDdkZiVuxizup21vEd33
	ae8h1BVUdoFd7OqqFyG8961bC51E05eXZ6d99JDxxtZkxdkPIDvYtWWrJcEzmGK8Itmq0jimZXC
	HviFG26FIubfRh0TJOVKwJDt9php2HatVUhQkVT4lyqsc+cnwBmbi857EpZ+cuOGJ07UkRjy8oX
	S6UU9KLLiJEMNPhUv4PIRAvmH5hPifIihP46viLrbAcQ7r9b2FVwq1bQvHoj8JYE9fvkKf/UYyL
	4l8Rsv0zDrN9LIq4=
X-Google-Smtp-Source: AGHT+IH/bhWPiy7m8GLa+C1mIouuBQRxHazpfd0QdZKDcJgHm9PFD8X6u/UYnaoCfVK+3ab470QWrg==
X-Received: by 2002:a17:902:fc4b:b0:231:ea68:4e2a with SMTP id d9443c01a7336-23601d74a23mr81789195ad.34.1749259147707;
        Fri, 06 Jun 2025 18:19:07 -0700 (PDT)
Received: from biel.taila13fa3.ts.net ([187.101.32.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360309262asm18498195ad.61.2025.06.06.18.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 18:19:07 -0700 (PDT)
From: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>,
	Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: [PATCH v4] iio: adc: Modernize single regulator call
Date: Fri,  6 Jun 2025 22:15:22 -0300
Message-ID: <20250607011846.50362-1-gabrielfsouza.araujo@gmail.com>
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
been addressed in this version. In version three [3], dev_err_probe() is used for improved error handling.

[1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/
[2] https://lore.kernel.org/linux-iio/20250514185239.10078-1-gabrielfsouza.araujo@gmail.com/
[3] https://lore.kernel.org/linux-iio/20250521185807.139828-1-gabrielfsouza.araujo@gmail.com/

 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f1..ab1ed79f9f39 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -911,21 +911,15 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 	adc->map = map;
 
 	/* Bring up regulator */
-	adc->vref = devm_regulator_get(dev, "xoadc-ref");
-	if (IS_ERR(adc->vref))
-		return dev_err_probe(dev, PTR_ERR(adc->vref),
-				     "failed to get XOADC VREF regulator\n");
-	ret = regulator_enable(adc->vref);
+	ret = devm_regulator_get_enable(dev, "xoadc-ref");
 	if (ret) {
-		dev_err(dev, "failed to enable XOADC VREF regulator\n");
-		return ret;
+		return dev_err_probe(dev, ret, "failed to enable XOADC VREF regulator\n");
 	}
 
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
 			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
 	if (ret) {
-		dev_err(dev, "unable to request IRQ\n");
-		goto out_disable_vref;
+		return dev_err_probe(dev, ret, "unable to request IRQ\n");
 	}
 
 	indio_dev->name = variant->name;
@@ -936,7 +930,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto out_disable_vref;
+		return ret;
 
 	ret = pm8xxx_calibrate_device(adc);
 	if (ret)
@@ -948,9 +942,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 out_unreg_device:
 	iio_device_unregister(indio_dev);
-out_disable_vref:
-	regulator_disable(adc->vref);
-
 	return ret;
 }
 
-- 
2.45.2


