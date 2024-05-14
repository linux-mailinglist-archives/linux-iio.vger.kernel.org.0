Return-Path: <linux-iio+bounces-5040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66C8C55AE
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D01C21EFE
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D729D06;
	Tue, 14 May 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSD13p/Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B04F602;
	Tue, 14 May 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688192; cv=none; b=hTmeWkNIYI6bXtoZMPngIzp/SBY76ceLVZBtMibtFldcxnai7lPUW279hZXzSYxBwC1G+H6bJNQAIwUkGSpoTTRy2eO/hJyFJNM4EiY+sLbm0iPW8khHxSVyPN8U7/ky7atLVkc7GiW5O/W4GEtG7ynZRq+FcwlVnFjOF41IzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688192; c=relaxed/simple;
	bh=xxXwGUgzcyjKmbdWvmTXYmHdWOU+W3I5jGlXNZcADpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1wc+HeCh7bH2AhviOCiMVXPk7kc51LHX/T+1di3rSp3wbP3W1qg6ekYrDWf93syp1Q6Zz4C79qqPicwrsCZNGPOu6RnNodhkOFCUUj//qEnj+0lqHf9/sRJ/67HPlAmvqhBvWfU3B9PzSOA1CQrqQTF7zbvDbTbesrLJfTXRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSD13p/Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b58c5so13438875e9.3;
        Tue, 14 May 2024 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688189; x=1716292989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHavMm7bNBHTHKKGjlS2nj7k0TOoIyHmRNV2CUCKaX4=;
        b=eSD13p/YtcIR4hYDmxXiZ05Fs/egHReDFm160SNaHwJrGTcjoMhoFbtYUWe2THpJft
         9OecTFJuWnb2rU2BbmRFioETE9xlHZMT8r4cifVsmCNswT4/y/esLHN1GvNiSZ6FkgRF
         tyPxRSscO8oAwRcPv7VxA/GM1g6afd9p6SXDBUibK7itbTH8m2eDBlosmzYtqRKM5VL5
         yD60YbCEQ9p2xntSUvzbsJnVwALpWqIYnG8JeFa8w3kZbwbgIY1ieeUDNS/PrSQ6iamc
         x2XucwtolD9s5u1XpGMToghd8R1Jd2N8bzjiPP88pRxC2otRh4tpUVi99Zxehp/0bKTk
         aDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688189; x=1716292989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHavMm7bNBHTHKKGjlS2nj7k0TOoIyHmRNV2CUCKaX4=;
        b=hNrFyB4kHy2qSEwNEtrpZBg7lTwP/4AEDFQm0PhMcuDdTaBOn8xCr22nKoiDbexGlF
         Xa5HkL8Pm5Q54OHvP8XFVwHokshUFXoetISl0bNX/pJQkWsv/+NZ8GDC3jvqZjmWgLpK
         Avalqui/YHzx2sic2gjk0aVhWPEyhgBWHXOyfYjtCRQW5OEfB4cEBeyCkMnIoyF+9U0D
         7eIriAjqwPoAcRbWIZLZ63psVCwWVZ3TudVZCO1s1+3B9A+AjXsVGxC0W+uWsEhHNIhn
         sXLxfmr05hXD2czZ9eCroimBJnQMzhDGyK9ldQZC7w9DCN9G9CGnWRngHZi6rKNqaZ3k
         i3cg==
X-Forwarded-Encrypted: i=1; AJvYcCVckecw+pEMkQxOprZCUtQT4T1xdulN8JAWlC2go1nSFGOLAFsU6By/kMQ2BaiFiy8OulzG/dDxxJKr1iAAyh/JJlrgXb0GKWCZrYfDfwhOUxo2z+rs933sjIZh4ef+fTRM7jWKsOReXmD7eTx8v0W6jYTvC2W4DRxvz+nn6W2/OyfMoA==
X-Gm-Message-State: AOJu0YzWM6rVSqLkGeJlQjIVc3XD7YeSrKZIvfBGMBHGbTA2+TcWTIN2
	ZFRRkU66IYS9npaRx1Myo4TJoEOC58wl4R+jwZpHrmVQG23IUO6P
X-Google-Smtp-Source: AGHT+IHJOofmHT9w31P5aBOVCtuP1//HCLKm8MNkHj1gB2giujrpiajcutSvE5qnmpVL3tmq+9R/aQ==
X-Received: by 2002:a05:600c:4ba2:b0:41a:9fc2:a6b1 with SMTP id 5b1f17b1804b1-41feaa4352amr93856665e9.22.1715688189156;
        Tue, 14 May 2024 05:03:09 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:08 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 2/6] dt-bindings: iio: adc: ad7192: Add aincom supply
Date: Tue, 14 May 2024 15:02:18 +0300
Message-Id: <20240514120222.56488-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseudo-differential operation mode. AINCOM voltage represents the
offset of corresponding channels.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..cf5c568f140a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -41,6 +41,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  aincom-supply:
+    description: |
+      AINCOM voltage supply. Analog inputs AINx are referenced to this input
+      when configured for pseudo-differential operation.
+
   dvdd-supply:
     description: DVdd voltage supply
 
@@ -117,6 +122,7 @@ examples:
             clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
             vref-supply = <&vref>;
-- 
2.34.1


