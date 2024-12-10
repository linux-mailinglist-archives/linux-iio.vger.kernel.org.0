Return-Path: <linux-iio+bounces-13308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF59EAE8F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C97188A08E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FB226527;
	Tue, 10 Dec 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UYr2IZbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E7212D64
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827612; cv=none; b=ITbwVCif29B3iAn4+qWMjrnmaJWyBIkkcbIgoUTmG2TH54hkpZHW2yxDXTNq9kHSRIjy0t3vGnok0DRxu1Teg1AUWC4IqmenGw7w+Z+jdA3TLdd9mFqd/FaXRFidoE7JVB/LRP7uyWUFXu12GMYN4+vMlbAWd0p9r/Tj2g4RjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827612; c=relaxed/simple;
	bh=K0BvGK4oOeIidGmW8aWUPR+jB9kYewVqKo7IDNPdqLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8UCqo1q9lVnVd8iCXlwa38CBTmTcKmXg2UXuRidSe3oa8/h/LVzKO+i/Y5ywPhludqczx1D0x775neIdWAxTYvDov3VU/2+GJem+yazcUliAAvs7EarY1ovZVKhcwFLIb4hAoqkAABh8jJjU342BHMlpmOZ1UKveeFG+jCFoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UYr2IZbG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso52030115e9.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827609; x=1734432409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0F/PaPCmemiFgieAJmds1srxQ0DrRbfktCNGrwXYWA=;
        b=UYr2IZbGY5xcuhCPpCq1wKJUcwtzb2yKzZsHzH0q9kbg+DuywIjz1vvkukC0R3eaiN
         AF6Tl75pfex7tvrCgARP03yN8DS3XfkEmpTwZpLVE+zYH12Uc0vYt+A0qJwYGN5u66k0
         0fM7NMDUkJVg33WkNW6ZfmuWc6jDBJAlbPh7r9of6Ub1ps+18KLFCFpjCV+99oHP5IUI
         QQWlnpV+8MlyebIPljLaad4toXU+eFfPYV9ebrMXQjRMmwhuNyjP8xwqQiDsx+hUbRIN
         7+uggLU7B+EZ00Gd/Oy+G1V1MkKty1dirNJP8a3gH3EjSC0Dhl22RYVwBR7lUc3HEkCI
         gOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827609; x=1734432409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0F/PaPCmemiFgieAJmds1srxQ0DrRbfktCNGrwXYWA=;
        b=B2CizpKSuKrGzbLURU/u8EoZBhHwnu2p7WXFVBx94lsHQPXfgV/X9m2/4Dd86LIA3M
         YPxkSY9C25mzzvsPHONxy+pLgL9NpiyqfWP7ChkzIri+n06s5pkl2XsuK34mc+Psxtqq
         YJ5+N8FIiz5V9RlCpRbqX/GTzlmDDv5GEEpPJu7JIudE7B770uuj4KDgGeBq2jFEmYtM
         UukfHtqaYEjR1lnGbhliICqQlPcmz/PfPHGGEI0bND8E2csuCYw66qOzDevBDoYIx02Z
         Lgsf2d4znsIhVueeiQfI6TnhM+Oq4pOYpaKz0zkXKIoLR+7VMz4exUugmpaTL7qudx/m
         KRog==
X-Forwarded-Encrypted: i=1; AJvYcCV12vxZEfkE60tQi3zQOSzbLe9li0vJe+EfxuwiUt9Q97tdlGS1LMaVGNRR54TOHbDawc1M0+0IVpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0Ull9DYNxy7lN1jng9q2Mg4zlErjLfJZ+wze6BDnsdRXz+b5
	8IEeyFlkD13JY2L4eI3EDWmZPjOb1K7Ff8W39DRn/i3VFw5SZrLtVAMSJpS/x6o=
X-Gm-Gg: ASbGncvvyvV2SgyZkDtuxwIWzsnB2pzKf41RRd/s/oBh3hXqwdgYl7sT2X5/X5fape1
	7wSE/Ig1Fo3MvkVT3ZQMX855IMQ3zK3TaJLUNfY3g64rtP21RpFQXaCcvwwZ3//RjRWi+fEsgTd
	Lb9BVimpExWf9TjGimLFx5EMY0OsBy2WHCdTax0rzdyxoKmmH66mzurxgUyPZURtnlQHqPR9Eox
	TGNpHJsv0e/E1v4JHdnXycoCOCx+hgl+6+DJxq8dRK9RHnY1JQCosq994QLpFvjpaptJ81fyuTs
	Hw==
X-Google-Smtp-Source: AGHT+IEjvvkVPGCQ4q4RgZA4PhkuYbvY9MlZVkehC9Ab60KIvM9AxWyfKNE3bO1mbffmlAVgIlitgg==
X-Received: by 2002:a05:600c:3550:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-434fff9c1femr29024255e9.26.1733827608472;
        Tue, 10 Dec 2024 02:46:48 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:48 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:45 +0000
Subject: [PATCH v2 5/9] iio: adc: adi-axi-adc: Add platform children
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-5-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=4154;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=K0BvGK4oOeIidGmW8aWUPR+jB9kYewVqKo7IDNPdqLw=;
 b=QvXIoMpjAs3QFvOmcJLXDrJoy19P239MzZoKZ/6dDHf31sx/QoIun+q5eaFSt37jjNUhpp2Dy
 519K9hJbc84CW3gLgWTOogPrX6iDvyaddjtg8ZKryCiLGGHD44LDzf9
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This is a preparation for the next commit adding support for register
read and write functions on AD7606.
Since sometimes a bus will be used, it has been agreed during ad3552's
driver implementation that the device's driver bus is the backend, whose
device node will be a child node.
To provide the special callbacks for setting the register, axi-adc needs
to pass them to the child device's driver through platform data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/adi-axi-adc.c | 75 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f8..7ff636643e56 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -80,7 +80,18 @@
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
+struct axi_adc_info {
+	unsigned int version;
+	const struct iio_backend_info *backend_info;
+	bool bus_controller;
+	const void *pdata;
+	unsigned int pdata_sz;
+};
+
 struct adi_axi_adc_state {
+	/* Target ADC platform device */
+	struct platform_device *adc_pdev;
+	const struct axi_adc_info *info;
 	struct regmap *regmap;
 	struct device *dev;
 	/* lock to protect multiple accesses to the device registers */
@@ -325,6 +336,40 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.reg_stride = 4,
 };
 
+static void axi_adc_child_remove(void *data)
+{
+	struct adi_axi_adc_state *st = data;
+
+	platform_device_unregister(st->adc_pdev);
+}
+
+static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
+					  struct fwnode_handle *child)
+{
+	struct platform_device_info pi = {
+		.parent = st->dev,
+		.name = fwnode_get_name(child),
+		.id = PLATFORM_DEVID_AUTO,
+		.fwnode = child,
+		.data = st->info->pdata,
+		.size_data = st->info->pdata_sz,
+	};
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_full(&pi);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	st->adc_pdev = pdev;
+
+	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, st);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct iio_backend_ops adi_axi_adc_ops = {
 	.enable = axi_adc_enable,
 	.disable = axi_adc_disable,
@@ -370,7 +415,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
-	expected_ver = device_get_match_data(&pdev->dev);
+	st->info = device_get_match_data(&pdev->dev);
+
+	expected_ver = &st->info->version;
 	if (!expected_ver)
 		return -ENODEV;
 
@@ -408,6 +455,25 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	if (st->info->bus_controller) {
+		device_for_each_child_node_scoped(&pdev->dev, child) {
+			int val;
+
+			/* Processing only reg 0 node */
+			ret = fwnode_property_read_u32(child, "reg", &val);
+			if (ret || val != 0)
+				continue;
+			ret = fwnode_property_read_u32(child, "io-backends",
+						       &val);
+			if (ret)
+				continue;
+
+			ret = axi_adc_create_platform_device(st, child);
+			if (ret)
+				continue;
+		}
+	}
+
 	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -416,11 +482,14 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
+static const struct axi_adc_info adc_generic = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &adi_axi_adc_generic,
+};
 
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
-	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
+	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);

-- 
2.34.1


