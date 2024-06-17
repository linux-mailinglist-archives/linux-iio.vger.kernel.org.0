Return-Path: <linux-iio+bounces-6399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1590B4FB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AB1C21817
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC115887D;
	Mon, 17 Jun 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a+70oPMU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B813BC02
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637505; cv=none; b=PxqFAFwV3jTi23xg42qmr2w05OexLTq9I6n1LH7hsruz6uWLHk5HxZBTpG8GdrnkbLbIskvrdSdrfFRhmmTPOoEXSxQR7wR+xSnVSmx83PrILfByCBMg6VyNIiSnL17rFP2qdGmFjx9EpUMlSxOiqyHME4HWQN1scTeJOO6g0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637505; c=relaxed/simple;
	bh=Dtfjmiibyv70CczBYWesrAFMidjZ7VsVwcrW/v6aMN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bv06M5sehlymgNVh2GPG16egw0SgziPuyBAwPtCd+nUrhyb+8xI2ZYjHv4W4lvRUrBr88P1F1eouIPl49DXnuinqkvo94+MMP0rtqcnOYrBhxBOsri+XULdsLt5jVKU8JqNO2MRmUr0vkL/+Ew2Sae1J4ImUJ/YGr1CqqyOTl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a+70oPMU; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d229826727so2552817b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718637503; x=1719242303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqFHaVaNbt8gAYcmaLaicI4T3xsUr/WCZWRgASuEC/s=;
        b=a+70oPMUlgo2jv+0KQrK8hKQ1EjOIFGVdDqguJOdMFVuTUqsv00EryKZKYmRrsP11j
         ueLp2SLBIPXf1odCmfADWqTvY+rDpBPqlzmQB6uXgcM7RG+tNoaJBNrx2H39iIHOkWnR
         CZBDgd46BWeJyK2WL7CjUCJx+LUufQ7v+8RVj/SR8vyeM0IqwHQBQx3qNImK0OUvRr4K
         NTtqDuTdXsgI248CB9c/FCxLJxVJkmojbBiJmvr+sGrDKBLW1g8SY5ptbjEXYyn89oFN
         OMbLCnw+3Yy9RHKyx6mgnyTpeve4yr6kbUOcD2u5HOxuJDns2QO+/x7FX86wTBZA56n1
         MubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718637503; x=1719242303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqFHaVaNbt8gAYcmaLaicI4T3xsUr/WCZWRgASuEC/s=;
        b=q4Wl9ENaaqWPgNw/Ne1Shoh5KmREG1Dl2ibanD8smllmt/4d0yGyaIbyYN5VV904tL
         yNuKy0FK6D1GcGpJFzWgTwgdNBGvxA60Ie1yeK6r8ua+4QdCZfzeJJlo+jHd4hbcRtyE
         QKjSDykMVFSpMjB31ZMEqoDmuiZFZl4js4MbZeplzxL8qeCtEb8yvEu+e6zk16DRKQ5l
         Pzg9z8CO3ZuopMcR/81soRxhWOw6l2lBhOu0F6wukLnKDQTct0PbIke0G0npxq+2IqLf
         mEy3Z+LORXO0alTJ24YgjcXdtonUW2OtY/jET2pmNP3jtGqRPXWvZ8XiEDdryzRjE7qT
         fNug==
X-Forwarded-Encrypted: i=1; AJvYcCUro5CjL9gGdK0CJtr1Fa2Vk6EsqZTX5cv97Tf8yP8a8mXRnSwVS0YpkMgRpPwVjEbLlH0/0bS7cmw5qWjFUcKAF2MzMKta/Jpt
X-Gm-Message-State: AOJu0Ywg3ap7/OragkrkFkSLqm5nlMxfMHEzErhkGufTptNi13Ie/CnE
	+sP11bmVLfCL5CPaR/uMVQTvEpRozOd71W8hmtKVqFWM36+1BYG0lzOZ/81y0Yc=
X-Google-Smtp-Source: AGHT+IGyElQstV3t6uBctyLHT4j9HpM72d7y0GvafAH57GHeiarMjs51iEj2uexrKxq3xWSCFSWR5w==
X-Received: by 2002:a05:6808:1927:b0:3d2:2efd:123a with SMTP id 5614622812f47-3d24e8b9abfmr12625613b6e.2.1718637503175;
        Mon, 17 Jun 2024 08:18:23 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe47f2csm438381085a.116.2024.06.17.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 08:18:22 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: adi-axi-dac: improve probe() error messaging
Date: Mon, 17 Jun 2024 11:18:19 -0400
Message-ID: <20240617151820.3337034-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current error handling for calls such as devm_clk_get_enabled() in
the adi-axi-dac probe() function means that, if a property such as
'clocks' (for example) is not present in the devicetree when booting a
kernel with the driver enabled, the resulting error message will be
vague, e.g.:

|adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with error -2

Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
devm_iio_backend_register() checks to use dev_err_probe() with some
context for easier debugging.

After the change:

|adi_axi_dac 44a00000.dac: error -ENOENT: failed to get clock
|adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with error -2

Suggested-by: Nuno Sa <nuno.sa@analog.com>
Tested-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Added Angelo as Tested-by since he tested the patch on an internal
setup.
---
 drivers/iio/dac/adi-axi-dac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 880d83a014a1..6d56428e623d 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -545,7 +545,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "failed to get clock\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -555,7 +556,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					   &axi_dac_regmap_config);
 	if (IS_ERR(st->regmap))
-		return PTR_ERR(st->regmap);
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
+				     "failed to init register map\n");
 
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
@@ -601,7 +603,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 	mutex_init(&st->lock);
 	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
 	if (ret)
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register iio backend\n");
 
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
-- 
2.45.2


