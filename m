Return-Path: <linux-iio+bounces-21950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDBB108C1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284CE3A467A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CC26CE0C;
	Thu, 24 Jul 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAg18EsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E626A0AF
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355640; cv=none; b=HnLXIBCmtEbKaIcHr+ado3q6cEWYzAtsfe72AiJ3tzFd0XOkUn1yEKq4cutMERBQ1Qkp8BI73fl/GvrAPH10OJP2e24dDcl3rjGSSIZQLO0SGFZS9sRNgSq1/q5fQxVS9FiC0nAY18dGB7La5GQappnTA1ztCCciW21sY+kWTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355640; c=relaxed/simple;
	bh=EzzIiAoijePLKsMHhDEAi/RsAbRH40rRrq9ogMFdd+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il/4Of22L0Rl2EMSXgZDX5aF6BUACGB+tefR0QbioQXAeBYGO0orHs0VxtEFHKOK17u6Uu7HKynJHkxp2AH/LPsack9uuyQQz84d2/LC0Y/F2FDbykZOlQsqb3ExZ51mDGHSlY93cnhYMBJhz4/I/SU3gnNBeZW/rzobVm+YuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAg18EsO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606aadc1433so171415a12.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753355637; x=1753960437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fU1t/gY+fvQSdT58b4/oSddCY0LCDKCOWarJB5CkkMo=;
        b=SAg18EsOLyTlcEIggrJs4dxUidrILahWTxK/qJQ80M93sOUFVd7+t/vtavi0h0SnrP
         k+0xFwfjoMJr2xkwiBNC2qjx3qfs1oXz0Jq4edcFMK0qOAiC3HR0h5vvn0Jq9ow1Oftj
         GJUnzGrfg+vp3kViTzEGOVpEK1Gmexv+QNUsn/DNmse7MsXr7NLv+6txsvO7KoRa+gDP
         rBCxcQxzvbmIWRDOl+BTUDJ/hTuTIAUb0l5T2guaGSepPamskNOCAu2lHHxgkT1ZUbgo
         zmkaH2I2H1Fx5FzoGpthoiaqYQIF1XmMRu0HggPZAsUydA5kebjQIxYsLl9EGD/hQd23
         zs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355637; x=1753960437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU1t/gY+fvQSdT58b4/oSddCY0LCDKCOWarJB5CkkMo=;
        b=q3RehqPZOtpVXW7ruVdQJpf+r6t4jHBJOnorLGEyjIV/cf3oXscBciBiG4MFEDzgq+
         tmniC0xjRHRppztSfMDQt05/PEyVFIFHwLnjmr+siMsTf0Kib02UX0FPIC2B0f9B9S6Z
         iY6SVhxoxNWkhJcIdoxP9qh+dnEtVdBgkWhSuE8+977NcaRb4ALDoWo07TPkU+Z+h8U8
         UaYyBCOXp89V3P+iTxkWh/IVHOFJbboa75cpbV8qutfCD6NUEP4v4hgowup302/KrzGt
         WXuetsY/fAsr6GqNSmNDj95LxwYsD6SGGMSbuXlvBsOClskFMVJIAs6Y/QKTdlQg8zBQ
         aDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrtJfJxn1sAx6a8DPZXZvZh3qVEpSW/lrl4SMC0fYPiTBOyVBlxbgw4vp0bBMjtvUM2GB97OPWrUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya62WGhHessBdtVnJSzGGZIiTOSCPRxrtEVr+/tKIoO0IBZznl
	/LcboElRIMqvN08MxcVkCcrtkJT3CXL2xNrQJS0H2xgv3+B93aNDCyxmaA6H+VbRKwk=
X-Gm-Gg: ASbGncs6Tn14PgyAzJcRWOFFvnkXWz3h8oS27cGnXFzRFZBFYARDdsgrRadPBWyFs44
	M1E7J/oUtBzKi8N3jD4lGZJq8BySBE2YtqVoEJlehzVAW6jCQZGgMnUva/fX6djwKcPTc0GNtN7
	qAcPJ9X176ikEuG/DofgQWC03X2eypeRho5TfreQWyhgmWAGW+dFjJWBa21ZRBbAdaMSdlOd77Q
	9sQHGrIlk9Ke/Y275WYpQYHi79NfPIP9kZuU/mBNyVPS3qtYbC9cpfFi+uFjKOcORVFv17/Z5Fh
	oofof7mwQJtv6qWlz0RsBIli+Yur8ehhZvg5ihe0LkFjQCvppaREoTPKTot6vu/yK+yt6DfNklZ
	fN2hjbmndGy7vxPem2yR6yV9GEqtDUqmT
X-Google-Smtp-Source: AGHT+IFl8bw5VcqnaZyFMvU5N/+Z9FnZSRMF08+PL/sdFu/kNwhhTBGIr/Ez+0UF8NF5JU+4/pUhLA==
X-Received: by 2002:a17:907:1ca4:b0:ae6:eff8:bab0 with SMTP id a640c23a62f3a-af2f927c442mr230489466b.15.1753355636774;
        Thu, 24 Jul 2025 04:13:56 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b416sm98680266b.40.2025.07.24.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:13:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dan Robertson <dan@dlrobertson.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Alexandru Lazar <alazar@startmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	David Heidelberg <david@ixit.cz>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: iio: Drop unused header includes in examples
Date: Thu, 24 Jul 2025 13:13:46 +0200
Message-ID: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13440; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=EzzIiAoijePLKsMHhDEAi/RsAbRH40rRrq9ogMFdd+Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghVp1lbwagOVzqnb4D4tPHa76QycwmUcOD8wG
 rj1LtwZ+vyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIVaQAKCRDBN2bmhouD
 13FoD/43m/JIqB7zoemYOwgQTGXeBr2NHqZX3JjU1PNOPdslHa6EEIzjX9tPb84kF5Y3xi1LeHy
 hv/4VRTOzK3anln9OLWQCpNvOe9DKZAQBLPbA0TbvUB0Q960y/xUjwFNUH54C9dQDbxJTrTDzxz
 jAC14J5MbleGVZ9wh1eLFN8kRo2kUxcoG0AhkIC2KPncOCLDa8v4LwsEDdKhZaOwzBC+Rwax27A
 JYQeOzUCHOF96sj1TT03AugZHXGbvMLR4b4KyAPEuW6S7lrb+ou6nT5LfnC9UyFAkCxgp+zCzVh
 4EeIzgZZ86ChXCF3JEuVEuA/P5BRmCFvZIXbdDn8iOgBKrgpFuoVdCY90DvOo3L4FGPQbfz1nw3
 FTVpdwglTDSDct0eDWw8RunTiavSfgmrc9si53ghRwX9Mc54xsf9APpRiV4r2B3+UrWVFNUuF2Z
 mRN36MocYerVvVC+azuA3RqoYGq75hrElFxtHXP5QJRHvEskyGtvLmUR+kwh+Yl30gKgjKb3woC
 CGABbDDz6cvHXwrwKSWa+XnYH4phU7sVHcROxQWdamZnrYnfWusRIHDmVYXZZqLOadUHIXhQqyE
 KcKz4F3CMJ0XF5p5YWuZgpm9d6QYksD8isNOm7ZRGLUe0QrvAH7UKdh1yW6/hq2+brXKjMeWBDk cFazX3wrd9S/cEA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Drop includes of headers which example code does not use.  No functional
impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml  | 1 -
 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml    | 2 --
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml    | 2 --
 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml    | 2 --
 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml    | 2 --
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml   | 1 -
 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml   | 1 -
 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml   | 1 -
 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml     | 1 -
 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml       | 1 -
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml   | 1 -
 Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 1 -
 Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml    | 1 -
 Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml       | 1 -
 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml    | 1 -
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 --
 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml     | 2 --
 Documentation/devicetree/bindings/iio/light/st,vl6180.yaml      | 1 -
 .../bindings/iio/magnetometer/voltafield,af8133j.yaml           | 1 -
 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml      | 1 -
 20 files changed, 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index 5887021cc90f..3dc973b98f81 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -37,7 +37,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
index 0c5b64cae965..3a8c69eecfde 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -57,7 +57,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -73,7 +72,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 84d949392012..a23a626bfab6 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -56,7 +56,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -72,7 +71,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
index c07261c71013..f39e2912731f 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -58,7 +58,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -74,7 +73,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 62465e36a590..88aa67bf2280 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -37,7 +37,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -52,7 +51,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 457a709b583c..85c9537f1f02 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -107,7 +107,6 @@ examples:
         };
     };
   - |
-    # include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
index 8723a336229e..c5fedcf998f2 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
@@ -40,7 +40,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
       #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
index f64d99b35492..53de921768ac 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
@@ -57,7 +57,6 @@ examples:
         };
     };
   - |
-    # include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
index ddec9747436c..705adbe88def 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -93,7 +93,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 21ee319d4675..62d906e24997 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -379,7 +379,6 @@ unevaluatedProperties: false
 examples:
   # Example AD7173-8 with external reference connected to REF+/REF-:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     spi {
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index c28db0d635a0..b9dc04b0d307 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -278,7 +278,6 @@ examples:
   - |
     #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
     #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
 
     pmic {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
index 2a8ad4fdfc6b..f0a1347ba4db 100644
--- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
@@ -50,7 +50,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
index 775eee972b12..044b66a3b00c 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -44,7 +44,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
index bf5a43a81d59..71f9f9b745cb 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -59,7 +59,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
index 4cacc9948726..3a725ece7ec4 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
@@ -44,7 +44,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index d4d4e5c3d856..119e28a833fd 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -74,7 +74,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -91,7 +90,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index 688100b240bc..2930b3386703 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -47,7 +47,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -63,7 +62,6 @@ examples:
         };
     };
   - |
-    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
index 27c36ab7990d..8598fb631aac 100644
--- a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
+++ b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
@@ -32,7 +32,6 @@ required:
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
index b6ab01a6914a..ed42dc5afb99 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
@@ -44,7 +44,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 706b7e24f182..b9ea37317b53 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -109,7 +109,6 @@ examples:
     };
   - |
     # include <dt-bindings/gpio/gpio.h>
-    # include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.48.1


