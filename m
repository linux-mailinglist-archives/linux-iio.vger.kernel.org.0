Return-Path: <linux-iio+bounces-7005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F491C17E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883551F263AA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6A1C2311;
	Fri, 28 Jun 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rQDJLkCf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA81C0079
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586122; cv=none; b=JU9CR5JNbWNfVwTq6LPyqE5S7giZ2uW+bQfCCa7BWyjkXA/K1xvfzX4BciEIj+u+47QOltXsAL2QvqlRHRzVWhy6nf72bHUjHwFVVi5lEoaIA9wzmPINMoADyKN2MUeudX0a09ZKNYcfhPeQwoaWS7t7RennoSAglT8h0DAuAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586122; c=relaxed/simple;
	bh=fMDqf1KM7W/RA77rezMz3nE602KNHtmJiEMO09XyypI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/L/LmiN0T0tGp6rM5unabnvCXgcepwVOv4kuwGZ6ArO2WILB4n4+apg6ul76R6lbAeLHFiBBidLzkd/tXx9Q3k9kvHo4RcJwA7v1WdDvvQQmPjzidhsab4hFdRMVVgMePJzbkX1KPKezcZX4Or+6i7fDU2eMUVMBHE7kqBkhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rQDJLkCf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42564a0d3ceso4938685e9.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586119; x=1720190919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=rQDJLkCfkKgZBhUyezQ/lYW8Bm2E98zhIHYDXpcmGmzwuGPkPKPrDNV0K2EFopvKN8
         Dh6qbxDhP1CY1qZqDJpfGEIwiVeLM+OyL883tBiWGCDkjPpfoa/Zhf9B2KGoCgcsjtQT
         AONy8QGXS5M6RdwtTXqO/ixoTFKDrna/+/I0Z+RzpJTrAkVUbFKVdNv7AABjWSPXNkiX
         tuw/cbaM2EgkTQgkaQx1LMx7UyVH46WsKBPZKRTxcB4LTEfMCXahdUjkAbLCWAlC0UvP
         sx3r8Va61F5qhYEG29cy799StWXiIdtBzKcZRAMsGgoOrVN5vEX2j+6DNEsIlIAD3uFX
         fmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586119; x=1720190919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=hnOxEW1o3Cq3G1cDQzpkHaXSPAVyO+LGGbikykU6mfOsZs/xv8nqnsOj/+9C5QBIWi
         f+KxcT69u9swLz47oqH0W+jZJyguaAHcUxCqaS3LRfDqVQfMD36r57TMkYhoVLRZljXW
         G05FRM4Lgu68p4x2GtIabtlqoFXMYYMZ0WbVU7Gd4FjlfrFEgFGsa4HZlfHMyV57LOwj
         mRHzpFLRsNUz8GPewRloM8TW9zaqIsoSFMtL2KLjHHvBiVtPy1dAvms1XrwNemuacBni
         FNSzggioeit7ncqa77sHtbMU9cpv0/MaTbX+AWRnIHuh0QU6yx+7M0Vt4YUAFveAbSlK
         FIzQ==
X-Gm-Message-State: AOJu0Yx8K2aPmyGxBpntXLO4M6rAjuWleZUOFrVicLiKP/SHKpAIwYWb
	eQ3yfVo5vM7RsErNr1lqe2y5lLzlq9AT35lXa8cI57aDEmfbFa2T0RaVlUGAhqM=
X-Google-Smtp-Source: AGHT+IFAh8zWamkAmBF1B+P2cbfd5WXLJvJUkgL28xwo0GsXojl2TjxPdeR9K2+uX0bS9r7zxwwE2Q==
X-Received: by 2002:a05:600c:438a:b0:425:5fa2:60a8 with SMTP id 5b1f17b1804b1-4255fa261c1mr53186065e9.24.1719586118790;
        Fri, 28 Jun 2024 07:48:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:20 +0000
Subject: [PATCH v2 02/10] dt-bindings: iio: adc: adi,ad7606: comment and
 sort the compatible names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
to avoid confusion. Also the compatible names were not sorted by
alphabetical order.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index d55c58400df5..00fdaed11cbd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -20,9 +20,9 @@ properties:
   compatible:
     enum:
       - adi,ad7605-4
-      - adi,ad7606-8
-      - adi,ad7606-6
       - adi,ad7606-4
+      - adi,ad7606-6
+      - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
       - adi,ad7606b
       - adi,ad7616
 

-- 
2.34.1


