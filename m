Return-Path: <linux-iio+bounces-8869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D2696448D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656961C2486D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2191AB518;
	Thu, 29 Aug 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2V+wQm2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACB1A38F0
	for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934799; cv=none; b=mlb3DdX0IYt0HxqwFfsIdUO20Gf+c54Xza5hSA1ORCKUXnntFW0cogZthWszaARkwgpJIs0XMEoa1sQSngcAn+xyoiaS1/hJIzgDtudzDZSF3SY/qVjaPSP2CLi+xlu+/xlJh+MOBpUrTKzF2TwN2hqJBT4jr7ckeMnvelq26GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934799; c=relaxed/simple;
	bh=E1ArSvYWlEKg2mj8U4mUHAOngGGn/icyww8fVMtpx+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Js4KSerT0rX/mlKoiv8w3VMkkrxYhaq63VFnkB8QVKMYXEt2zsIXaiYDN7iHQTfg+mzAbgJomIMqSc6ntzI3xy6cmDPzFUeIsfBmaH/MtPohgQJF+h96TBxkvQakY9bxzpC8Gw2nfPXUyQRn1xyYXQwJvyhySli996dhylrxnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2V+wQm2z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371a92d8c90so369637f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934796; x=1725539596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSbzKoZMSzlZLqSuQFsdX/6ISDzmO2lC8VpPGyPhuxI=;
        b=2V+wQm2zT6gV+I9dc2MhicjZTAz2TUjFB4pxuBfiTF4hTg2I65pvfNTd5SGsTuosVo
         FRRaWovJrAiDEXc/Qdmtei8CVQHOc7hZOarKFxkSS72CQbQKarQeHA6dOq6xSxab8cOV
         3O/5gEaqoP5p9frAI9eFEbzReoG62eoi7KLEMDO08izTAjBM7BCtCtqY0/Rnzo8R8Gtg
         5uj6bDDgegh6OpVPhV14hQr+eroPwANtNBLculJ70Q9o17U5pN1uUhnWVjz1qKotOEmI
         mYvoiUeyo2vuC8ZTwN4qHQ54qSCSqgb4DZi3jfqMyO3Pxg04P02I/mSoGbDv/29pmDqV
         YhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934796; x=1725539596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSbzKoZMSzlZLqSuQFsdX/6ISDzmO2lC8VpPGyPhuxI=;
        b=fbJfbIdM02zp07iPxmDY5KLjz1+mrdjtoF15r0moiSrw6bMcg9Jv4pUG90/CsVr4mv
         roErsZfZ+BasY4knoqWxEjvdQwjPisKM2dg/KFT628FpIfsMW5xRfViYEz/xtX2MjpYa
         WClWqKvPk+PMxzvFlCj37bIejxNFMGMd/3FjXa8RxfyRpooQDSswM8Sk15FoabEvUNRP
         PDYv+zG1BtgcmSXswPI+h6P/0T6buymRLd3ayuNF10vZAxbX2VtUb7NCsNVz9RT6jF6H
         38nlEv7idks1+WEh+UZ2r3KIQJM1azx+j4zocqitv+jt5x//FAOHuPYKcIYuw3N43wjC
         VieQ==
X-Gm-Message-State: AOJu0YzN/2cX2lcDJL8HCxqIyshQn6i/2UxD6etl5s5jLQ3PAWIWUbgg
	TvGaXbOz7bwrDSpMtSa7J8nnDb7fuswDscppzqL0mNlnnYK0sqYL0aJkunbY0W0=
X-Google-Smtp-Source: AGHT+IGdX+6BPRfUeoPV/k4K2aySBQ9Gqbyh0fWcL2k663Xqq0qtlZFTMJAWVJqZU/yqDbbxq9Fvzg==
X-Received: by 2002:a05:6000:8e:b0:360:7812:6abc with SMTP id ffacd0b85a97d-3749b5890ecmr1729426f8f.60.1724934795974;
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:31:59 +0200
Subject: [PATCH RFC 1/8] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-1-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version AXI DAC IP block (for FPGAs) that provides
a physical bus for AD3552R and similar chips. This can be used
instead of a typical SPI controller to be able to use the chip
in ways that typical SPI controllers are not capable of.

The binding is modified so that either the device is a SPI
peripheral or it uses an io-backend.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 39 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..1874486229ad 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,12 +60,34 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      An example backend can be found at
+        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
   '#size-cells':
     const: 0
 
+if:
+  required:
+    - reg
+
+then:
+  $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  properties:
+    io-backends: false
+
+  required: [ spi-max-frequency ]
+
+else:
+  required:
+    - io-backends
+
 patternProperties:
   "^channel@([0-1])$":
     type: object
@@ -207,8 +229,6 @@ allOf:
 
 required:
   - compatible
-  - reg
-  - spi-max-frequency
 
 additionalProperties: false
 
@@ -238,4 +258,19 @@ examples:
             };
         };
     };
+
+  - |
+    fpga_axi {
+        ad3552r {
+            compatible = "adi,ad3552r";
+            reset-gpios = <&gpio0 92 1>;
+            io-backends = <&backend>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-5000000) (5000000)>;
+            };
+        };
+    };
 ...

-- 
2.45.0.rc1


