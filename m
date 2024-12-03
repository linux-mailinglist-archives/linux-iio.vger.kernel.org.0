Return-Path: <linux-iio+bounces-12997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64D9E1A28
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003272836BB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE81E3DCE;
	Tue,  3 Dec 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vl6X22+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606A1E32C8
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223678; cv=none; b=Sd7WdJLsBkRiIIVoi2JozTHoTaTBwAqWVgmheWRtrWZWDn2hM2zDNCbfJGWSVUP78HRtqqFx+IKAw6pfXdYxenIZtOGOlIdeNyfFU72vqxDLQx8jEvvrkmbVbu0rji3+2tOkMtxUoE9NUOi8LS/QKw99ciaG1+aDmWZYc+dinj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223678; c=relaxed/simple;
	bh=5Tub12uEev+sB+BLTljeut3vy9a9tjb4HivXuPMPSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urqThR1kThZLrOE8CMSVNqHMyAbNlyLTg1QRtdihwJjQLE0b5xh2wylMfqL39mVJRyA5dLq+QhQ9oKMJWVekYea8bC4MjI0+bs8UKIKjfY7xg8f2oDXfHrVClRI/gYY2o8O7rHR24qjs2OgejLPvMkHQtc6O7BWd3b6S3douN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vl6X22+I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434aa222d96so66667715e9.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733223675; x=1733828475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1yb2f09eTG86TeNTZpP/uJcRbKf5ZCi5uBPEVw7FPs=;
        b=vl6X22+In/RyHjlH3qAFvpVdU20MFbahOg1Hfhr6WHohhpL2YsbMmPlLfBnhopB0Sc
         jafdmL8R9sKpvmwcLSn+D2thJr6z0rq2W7sDZR5nwwuFLfvqPK0YYbJw7pMJKxvKfA90
         QTnf7TFkuWuecAj/AAFn/J6A49pwxFAMixB029vYqga9ZKoIBx+ipDfGdovZB26ceIk3
         U57SQXfrkrZi7s5aysAwMfnfkDBtw3YgkctTdJ/i7imFWN+JH0G6nnYxCazBXQd1lzIZ
         tMoGPxMUJyviLlXcPqUoJKvr7sgmhQXoZiYd10QexypjO7OPw3b4uPXeLgt4AfZARY6A
         1SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223675; x=1733828475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1yb2f09eTG86TeNTZpP/uJcRbKf5ZCi5uBPEVw7FPs=;
        b=U3AW2U16gENqBiwk12KwfjTpm46LdGFl55XQvQxC4wckSkL0peuzlNbPRxqk8YkL8B
         4yBrIfF87LoU0COD6SGLFCRJljXroH2yzUGZxtj7qbcCS1WipNRkWefM1rz+gpTMojap
         gl/VVrZw9o1omqhNNT/oVv1qRcNXD1IH0wRC1ZUL2NcgwfhL4UAdNMJiyp8ZU6SSD272
         1QHVlSjPs3MWIneujIz/CWA+LPLNxPWFS6AFIQffcg7vtmFBMDGNTUovxVK0421Gb9fP
         FlFDtaOKH3UvrfFy23AgwJ6T5k8O4ch1Ks0OuIZqOKVvHysoVVBkg8iIIS9xX0m/wTMT
         JuRg==
X-Forwarded-Encrypted: i=1; AJvYcCWRZZ3MwFp8EaC5W85W+ta6l3GhuJt97mYqIITFk7cYH5MEbr05xxlUC6y3TurR7an3l6ZyF0Z5sJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0w9vC4+2m8mpw9YKyiiq2M3fpAKHsbUWG/6VwWCvCpEH2ULDk
	yUwqEemdZaeXHfUWXCeqXbTXuJbTWHQqL1Ee37jDj6tpP99FRyWRMnDTSlWvs9k=
X-Gm-Gg: ASbGnctqwCYsUBb6LeYm1/AnAxh3d4MKYukKB8FK5wKzkvmn99nfOVdRuBnPfdvB/c9
	mrvgeZTEY+icCAWb2awd2shHGM+FalhhmomOHa2t06T0+B45cHqAZw273tXWhB1XMp0S7fUGyH5
	QC8z1cgtOIs8wQCCT33AuvnVsAqaPw45+2y0rb21nHeu/llRen9WGzLgVMguGUTmpUR7UfGzKZM
	6nUOxze5RlRSNyCJYj2eE+tatHtoWFmzfT3jwSoyWL6WLtBl8PleVT59w1gUdR5oB/RJKqEasmp
	9+Fbr/YEMmcqnd2ybSHvct4QKACyq4SGBuR6qCM=
X-Google-Smtp-Source: AGHT+IEoXsHLS8o7z5iCEiyyiL0ZFhc40N2Au+1imc8POcWS0RbWlRKMFq7dyIPKcXhKRHZc6/k1Ww==
X-Received: by 2002:a5d:6da4:0:b0:386:605:77e with SMTP id ffacd0b85a97d-38606050b61mr994019f8f.49.1733223674729;
        Tue, 03 Dec 2024 03:01:14 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df69feaasm12306869f8f.5.2024.12.03.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:01:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	devicetree@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v5 03/10] dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications of a gpio for irq line
Date: Tue,  3 Dec 2024 12:00:23 +0100
Message-ID: <20241203110019.1520071-15-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6969; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5Tub12uEev+sB+BLTljeut3vy9a9tjb4HivXuPMPSPc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTuTNNTqsRL8hAaWaOKYVUCPFcr816hVSkYjcx ZUd58ppUqqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ07kzQAKCRCPgPtYfRL+ TuU9B/9/g1XaXscsZ5SZs74BVOxKsUNZVYEvgqQ1NgA3SjRhmhukkC1ywSdwThBTSAPdgLQAuN2 04GB4INgMwuRyh7+eaO/7j4J0xjzU83k75V/herGlDc8a3QKmnboarEpjBYngQooTNGekU6ZWHO C2fM984u9E6fIpDj1VfM6kInGUv7Z7/Br3U4cU6dXZEJAotOQY4lmLIP/aKnKqxsrPh+jv0aIyN KCua2u7KuCL3V/+gZbSk0T1IBvf2fJBpiHkcpi9f/M9+dVSxef0QXwzS9cYrAWxaReOQPaaOdzC h4lqz6tSWoIH2udA5E0fviEMbUroO37zM9u8AG44cDzIhQXi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For the AD7124 chip and some of its cousins the logical irq line (̅R̅D̅Y)
is physically on the same pin as the spi MISO output (DOUT) and so
reading a register might trigger an interrupt. For correct operation
it's critical that the actual state of the pin can be read to judge if
an interrupt event is a real one or just a spurious one triggered by
toggling the line in its MISO mode.

Allow specification of an "rdy-gpios" property that references a GPIO
that can be used for that purpose. While this is typically the same GPIO
also used (implicitly) as interrupt source, it is still supposed that
the interrupt is specified as before and usual.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml   | 13 +++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml   | 12 ++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml   | 15 +++++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml   | 11 +++++++++++
 4 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 35ed04350e28..d7b4676ecc65 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -37,6 +37,17 @@ properties:
     description: IRQ line for the ADC
     maxItems: 1
 
+  rdy-gpios:
+    description:
+      GPIO reading the ̅̅R̅D̅Y line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/̅R̅D̅Y toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -111,6 +122,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -121,6 +133,7 @@ examples:
         spi-max-frequency = <5000000>;
         interrupts = <25 2>;
         interrupt-parent = <&gpio>;
+        rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
         clocks = <&ad7124_mclk>;
         clock-names = "mclk";
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 17c5d39cc2c1..155a6b280aaf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -133,6 +133,17 @@ properties:
   '#clock-cells':
     const: 0
 
+  rdy-gpios:
+    description:
+      GPIO reading the ̅̅R̅D̅Y line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/̅R̅D̅Y toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 patternProperties:
   "^channel@[0-9a-f]$":
     type: object
@@ -440,6 +451,7 @@ examples:
         interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
         interrupt-names = "rdy";
         interrupt-parent = <&gpio>;
+        rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         spi-max-frequency = <5000000>;
         gpio-controller;
         #gpio-cells = <2>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 66dd1c549bd3..6f584830ace1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -106,6 +106,17 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+  rdy-gpios:
+    description:
+      GPIO reading the ̅̅R̅D̅Y line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/̅R̅D̅Y toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 patternProperties:
   "^channel@[0-9a-f]+$":
     type: object
@@ -181,6 +192,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -195,6 +207,7 @@ examples:
             clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
@@ -207,6 +220,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -224,6 +238,7 @@ examples:
             #clock-cells = <0>;
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
index be2616ff9af6..28a384adb5aa 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
@@ -63,6 +63,17 @@ properties:
       marked GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  rdy-gpios:
+    description:
+      GPIO reading the ̅̅R̅D̅Y line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/̅R̅D̅Y toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.45.2


