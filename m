Return-Path: <linux-iio+bounces-20953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A322AE74D9
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 04:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542663A3C7C
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 02:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31051B4231;
	Wed, 25 Jun 2025 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPKR5WY3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BD1A76D0
	for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2025 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750818857; cv=none; b=YYhJ8rKurDEGIZ7c/OYfzS431Hi5YclnDYMOrDJ23TnMdUkTjKAMZTp/sTZ8yOWqXqlof4qq4yMBACb+mZD9mngr17rp/IDY+QtucOuVNPC4A6tW4cPnA9F7A+VO+/hZr8FOoHAgS55FDokI/QyBAyOHzOdsJjfzTtHebUAEYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750818857; c=relaxed/simple;
	bh=Ej/HkXaTH5Y+hLurHzKdKBwNSX4lOxX4PzHO3u8YZHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxWQWE7umts+b5mhtwqCZmuYd/woqiENQfOPhqy2oXXO5ghg2FolIfbELebrNm6P2SlA7cgBMhCrYiT62Dh6ZTu58Bcycnr/yn4UqWba/QyP+RnrTyvbu9RfZMgVaJ0jMs8drsZy/eM/Q3oyLc5yUgknFZu2cIBMMQ7LB2w9MSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPKR5WY3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so719371b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750818854; x=1751423654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRn/v09TZuXVYQIp2AYezdwrSRhnW1ZxWwvsm3Rp47g=;
        b=ZPKR5WY30eGRrPkFQjO5h2Gosjg/5OtBVVRz3UcWALkzR1bf3DDMIuX5tnhHH+112j
         oTmBa0Y6GPK9OICnKAnd2R5XMEaOSzJID6XEEjEwEcPJI60XJleyx1f0ucW1L3DZUMvH
         93vpDnjnkPZ8dvRtxjYtlVRg1qjjBx7SFt7bl0O0pm1VXzB5g68jD8SIedWYI4+tPBER
         dqRTUGSH8zhIfLROCg4BecSpVMwNQgucsZm2R3G/9tRa66Ocu3M13+eSjHPQsU2FxR1G
         kwYDl45BVg0oJgth5wUuLlf9FFyPOoVNnJAy5Be12e/9Uvgjkqj4WlJTdw5FncOkx//A
         ZHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750818854; x=1751423654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRn/v09TZuXVYQIp2AYezdwrSRhnW1ZxWwvsm3Rp47g=;
        b=OMSsp7JfORDtTXEHrdLtcsSSQtrkIaqVG28pnbmaLbI+0Vg41yj7Ui3+HjIchfSQLs
         kaQcIN8vUTze78HuihtQqIa6VqTMAF8NKwsEqcEH/sFeRiv86RmczHfLzy/mUcdRAYc7
         XU1IfmDx84ATeDIesS6sIhR3W63cPWpcqdPbzcmwGSLL0E4L2+qk0SLqSdftNSEXh31Q
         JoQfordPAeeSSwxIdVp7hvGGBgFaGLg3+sA9rnEMJvO2JOuOXYTVVdqJLVkdBV8Fp/sh
         0EvGBUBwJdPRSNChEz8tAeGMyUobLKI7mWEUzbmOUMIOX6kubl5ad8b++wVbHTBdw0Vh
         Dz9Q==
X-Gm-Message-State: AOJu0YwMBRSBdN44K6L50pbx9rfgGn7fYXcZa21sjtftI0yONXn3qr3z
	KPJfMe+7A1LG9CdmgmcbUcGzKxgodjUurggDKyv+jOWYJ9Cf24dTlTxi+8gBHMBNdbY=
X-Gm-Gg: ASbGnctLNKOEPf5O3WLWsO4F4tvGWRoouSkuKXkG2rfknG4a2QP3QBSB21+WiesOhIP
	puxG0BG99SRYgipJ/eyTBnVH7/8t0MFVhEHeUyTUtZRlCJIaaqBhuQkiBu8X1Ua6gSRjX4tj4PK
	Y9GI676Tpl2N1zNYwSlVZTXcMPcBc7QFjd+Zyrqvco3CUAytzWK2FarMMLXM9WA6/Ipc9MQ+3Yc
	XYRzdLMFCnPZHcVD/S/nWvtApykQEVJ3fMPyxJjLm2cYmhsnKuIdDTE2jTzNjjh1VGFwczE31Eb
	5eozVUoWT8o1tJRH8r4Q4NQekBqMB1iItwtOwOhc1hF3dZV9nByMiZ2LaXoZnq+SaRyE1jQMVKv
	640AOnb2KAA==
X-Google-Smtp-Source: AGHT+IH2aJrsewxMfvsuNZiJVEnTAZp7ZlXNOfNpO09AVNlzRVFlL6IdNjSwbM4M/UIUkEQLkMpkyg==
X-Received: by 2002:a05:6a00:22ce:b0:748:3849:e790 with SMTP id d2e1a72fcca58-74ad4019d69mr1998563b3a.0.1750818853783;
        Tue, 24 Jun 2025 19:34:13 -0700 (PDT)
Received: from c-sar-augusto-LOQ-15IRH8.. ([2804:14c:73:90b8:4644:12b1:f06e:93a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08c67sm3064372b3a.17.2025.06.24.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 19:34:13 -0700 (PDT)
From: "=?UTF-8?q?C=C3=A9sar=20Bispo?=" <dm.cesaraugusto@gmail.com>
X-Google-Original-From: =?UTF-8?q?C=C3=A9sar=20Bispo?= <cesar.bispo@ime.usp.br>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	=?UTF-8?q?C=C3=A9sar=20Bispo?= <cesar.bispo@ime.usp.br>,
	Gabriel Ferreira <gabrielfsouza.araujo@usp.br>
Subject: [PATCH v1] iio: adc: Use devm_iio_device_register() and dev_err_probe()
Date: Tue, 24 Jun 2025 23:33:51 -0300
Message-ID: <20250625023402.86861-1-cesar.bispo@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace iio_device_register() with devm_iio_device_register() to let the
core handle cleanup automatically. This simplifies the driver and avoids
manual error paths.

Also use dev_err_probe() for improved error handling and cleaner logs
when deferrals happen.

Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Co-developed-by: Gabriel Ferreira <gabrielfsouza.araujo@usp.br>
Signed-off-by: Gabriel Ferreira <gabrielfsouza.araujo@usp.br>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f1..447a924eca6d 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -934,20 +934,18 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 	indio_dev->channels = adc->iio_chans;
 	indio_dev->num_channels = adc->nchans;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto out_disable_vref;
+		return dev_err_probe(dev, ret, "Unable to register %s\n", indio_dev->name);
 
 	ret = pm8xxx_calibrate_device(adc);
 	if (ret)
-		goto out_unreg_device;
+		return ret;
 
 	dev_info(dev, "%s XOADC driver enabled\n", variant->name);
 
 	return 0;
 
-out_unreg_device:
-	iio_device_unregister(indio_dev);
 out_disable_vref:
 	regulator_disable(adc->vref);
 
-- 
2.43.0


