Return-Path: <linux-iio+bounces-6246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C81907861
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1818284246
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1A1448ED;
	Thu, 13 Jun 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eFs0LCY7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033D130A79
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296452; cv=none; b=p2NbT1LUIiOgGwEexegAGlKgBWbJoZ9jfag5yGu3dfmN45KaIwCHhJrQtf7TBsZN5hg1fMy5rQHgLYGO20+Dy0vU92XXbboC8Z4yFGUDatwe+7vee/yunOg0xgndeLQD3mpkxWQR0FqqaxnbKNG+kNfek5wDs4HQFQUM8vnC/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296452; c=relaxed/simple;
	bh=TH6yUbejSw9+JlXPysbovmJBDZzKEu7WvN4dTHb6Tok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL4sDjnfAZKSZtc3CuR43EdJP/bfw0bbaGxPX0oedrKYE2dTS/cRR2m2eP02ggt0GCbaeaFc+VwK1a+Qu0MhuWDLXKicKn1Qgxfeo5q5zJ+yRYZ1+FUYS5vVjQ7YPpc/TmMqMUgRxDLZgkRnvOhmYUqrh2/lnoc1xLjEd+AFeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eFs0LCY7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4411fc45fbcso6445111cf.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718296449; x=1718901249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnTqeJui//cZvCx8TIdIEgkp7fczgV1PTRw+9hdKvO0=;
        b=eFs0LCY79hUWbCNK0mgWjc9pyxmcrLfetrN1J7mIB4gERGy/kIxSHeOirM+Zpc0Tpi
         aE8ORly9Mmv9ZYiJzUigNJYFpTlszXyI+xrteHtw+85jvbFUDWEReYijkuGIVOaRWqse
         q1veWdS4UXOgC43WbbRSc015IbkbbBZBpoAEAAQq9Gj3t4+1C3qRcIHoXan6zIn6qyV5
         hErl5Qzdc8JOcFDM2xUfrrslhQSAoIvJFFx/jzyidItPhY8iDpFX2qYVh/2pFH47lufz
         vakSG7x8kjM8LXQXBc5WDc3bYLqzwRoRm4QNxUfZQ10D85VkekA8FXkrGZuuiD0bEwCJ
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296449; x=1718901249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnTqeJui//cZvCx8TIdIEgkp7fczgV1PTRw+9hdKvO0=;
        b=pHR2MqSJvVbSh2dT6MdEDUauoRwN9ekfEleos48cc7p+9/asGrW2MVakMjcAu22ula
         UJCPK9qaf5m7MPp54ElMCghN53rWHuPM6DMa/NuP7FJNPjaoELPRAkZjXwXp4U0qEOBR
         e0sgyiNhnL0LeAl+7p3jqCLMbnZqbhghT9t5cSOLagWsuZ33C2xeZd+Xj06oNKlWzpKI
         A0M2uJgwttCflLohroddDV9syxErj7/6xclPDNSOaDVaqbPfAkvaoi/fkb0Mm8UCGCa7
         p16R21iyKYXV7Te465jUK9/tstdKn21h5X7m29afS5e2eSRdbAUvrL+qUm4sVFwVzljt
         1RWA==
X-Gm-Message-State: AOJu0Yy5Wq04A8/bDuw6xAwY5LC8/k/hKt/W73DT2NwnqEowUDRS4Abn
	puWIB3YGPdbhyVO6ZHMLgIi7pLw5r5mNLWl7zKqoMi+8uJQ1K5xitVyLR7UqIzQ=
X-Google-Smtp-Source: AGHT+IHuqdhXoaTBFdtn9ov3LvddNezgc3CiIjKhWKx8XUQamhaY/ID6htUbUnQzSxu8vYpFzCveXA==
X-Received: by 2002:a05:622a:4cb:b0:440:5275:d435 with SMTP id d75a77b69052e-442168ad9e8mr1673321cf.30.1718296448835;
        Thu, 13 Jun 2024 09:34:08 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4420f96efbbsm5884171cf.54.2024.06.13.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:34:08 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
Date: Thu, 13 Jun 2024 12:34:06 -0400
Message-ID: <20240613163407.2147884-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current error handling for calls such as devm_clk_get_enabled() in
the adi-axi-adc probe() function means that, if a property such as
'clocks' (for example) is not present in the devicetree when booting a
kernel with the driver enabled, the resulting error message will be
vague, e.g.:

|adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2

Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
devm_iio_backend_register() checks to use dev_err_probe() with some
context for easier debugging.

After the fix:

|adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
|adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/adi-axi-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0cf0d81358fd..99998c2769d5 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -292,7 +292,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					   &axi_adc_regmap_config);
 	if (IS_ERR(st->regmap))
-		return PTR_ERR(st->regmap);
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
+				     "failed to init register map\n");
 
 	expected_ver = device_get_match_data(&pdev->dev);
 	if (!expected_ver)
@@ -300,7 +301,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "failed to get clock\n");
 
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
@@ -328,7 +330,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 
 	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
 	if (ret)
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register iio backend\n");
 
 	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
-- 
2.45.2


