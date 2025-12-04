Return-Path: <linux-iio+bounces-26763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0403CA4DD5
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC7073090D40
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE03570D2;
	Thu,  4 Dec 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC2A73zZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81763559E6
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870982; cv=none; b=d48wX/3kOu66ho4QQqBaqy95dM3EsM/PTfcNwa+7N01cxdgiLiu4rHjbQfLOccnKJpnrsbKWDgcSkzGVqfDmb4xN7EcdSaif+wlsPIXV50myNTeH+CEaNF43CFjPFv2VZy/lXaTm3ugGwxavhRMCfny5FffhclhPQ2hSCoe0qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870982; c=relaxed/simple;
	bh=VsKMfePN7JjgmEwgQW457cXjo1Jn7sfHu3mU8ne1Azc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALmYHgsfBqAFKkO282txkZum4weErKrPxK2byfoSRoOak1++Yl7O/oVQMXb11rUjPD/+BuCibZvn0oUdm1Awq5aUX1CwSqtL+vjkeDGGGbiKCbeCei5rQ4Dk5e1VGibG7rR2XfeDXNMVLN64HQJMNe9vaC5krU9xouXNtEsj2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC2A73zZ; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5598b58d816so903314e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870980; x=1765475780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=GC2A73zZEBQ8iGMqIQ2bEO87Us4VDHna1I7bmL4IO1/BPkRNVpw2haw3SqfmIhvL1r
         ngxoz16XUOonCRtcU6z9XbGHB+cEuJHKR+3XoNcEdJnH/yefLIy5Go3vJZja+D4BVEoP
         aSGY5uHGn9Rl3yjYNmKzag26CB+mFVaQIOJixLaAhHZgxUSWbVuDCKdiMo3fM0VU/mdZ
         VGs82Ffb+BdCx5F5KrkQydV+Q0+Iuh2RgVDnh82W7W2giuizRAh8wbHZGDMIUXGOvffc
         MW2purPAMsOkGkIihZL5g22DLOs7uYRFE/CTGjMwZP9DphnEnRsMtIWcxsoacFTVUOtu
         RAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870980; x=1765475780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=Ly+omkTpVtafEgj+ZOm2CAMC6agkENsFLfwqZrc+aoI647a21wVmvJqw+34Y23OoE3
         BMAJYeRDiWhIz6ImjedImE7WynDT+7o4hB8q42lWdUho3BxH+r3OJ5uoqrfqjlj60xbS
         1nGcW/2rDB99Fly/vTI9Fu0DkQv1ZFf4fUCqXArjhYCzU/4bbu+jx6qlKHwJ79iZnJKp
         Bzf15ruzZQYSlV9ZeeSkDor8dtpoqZa61BR+2yr/3C2X/5ps1Uqqj+aNI8+PS9QhmQYj
         CvvGrboypPbiRH6la3u0jsHoDdIBvTHzLoFQzpTjGULYbF4leyejBEhN1gYaDy31Pvtv
         RAWg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuA22SKxzPrQxf1zJ1imzU+F+43g/PLCLC9iL+LqRC2Xdl8mR0hF8D0rhOoGBFF/8JXE1/U03R24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeqOuv8VRwPmcuAG1p2r4f7VY9trncS4b4WC771IP+RqhC+/S
	GftO5s6ULRyj/zeCQgOnfyfiZMoKrxELSTSdwoCokOlHpz64EafDfvdg
X-Gm-Gg: ASbGncs/dhoszE1Jepryi3uUj2W1mTXwuJUcPG5cRH6+a3VACYnoIFSm/G2f5rWC5NB
	bxsmw889hF4B5Mu+YfkFJzqfFfUpGYt8J8FrAjxYR4haIRJsFfEOhIFUjj2o3ZklTlXUnKi0Jzp
	k1jHtCKKqXqbLcDfHUh2/agWRl3s4nQfv4feG81JYpckE+EIhvHQ+64tCxl/enh1VqwfEa/GeI4
	jf6B9qLAzg7pSbFmtuiJYbJ48hhoGTkW875SlQYUN5b3+FqDI9rltNionRsX6gLT/EGCKWwnlcx
	vokTxvyC2EIBJNfjkvUcbsPloGmw2SzaTZRiZUT+w1dIjpfINPS51UIIpn+H12Ivu3igaEqit3N
	Re8x7CkCbYecKVvr6cggICXC+Ep0R+1BhY9L7gjC7HOCUtVflfq8tRePdrkaKy6zgxImLcwyvAs
	MOKP3D64GIfCRN973+BbR5P7ocYA==
X-Google-Smtp-Source: AGHT+IEBYz6Ptvq7oAJo1RbJPG/cMIJwkXR5nGzD5jFubyG3aAZLAGKUMrQpgqep5ih3OLVh+d8GXA==
X-Received: by 2002:a05:6122:2221:b0:55a:e007:4c7e with SMTP id 71dfb90a1353d-55e5be6cc4emr3007058e0c.6.1764870979714;
        Thu, 04 Dec 2025 09:56:19 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c97cea1sm921105e0c.17.2025.12.04.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:56:19 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 04 Dec 2025 12:55:41 -0500
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-ads1x18-v5-1-b6243de766d1@gmail.com>
References: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>
In-Reply-To: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=VsKMfePN7JjgmEwgQW457cXjo1Jn7sfHu3mU8ne1Azc=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGkxyz+iN6LNvge40UWneTNJCw9XghMCo2eOqXqumFjuppK/t
 4h1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmkxyz8ACgkQFmBDOPSf1GYv4gD/dHJM
 Hq2hd0Kf8SdVrWnQFGaPE0u5b/ewEE8ERQQZQVIA/RsO+c/NX1DxdcnQQc6Nu5jXDYA00joxhmN
 pjxx0F+UE
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add documentation for Texas Instruments ADS1018 and ADS1118
analog-to-digital converters.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..93c9b2921a54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1018/ADS1118 SPI analog to digital converter
+
+maintainers:
+  - Kurt Borja <kuurtb@gmail.com>
+
+description: |
+  The ADS1018/ADS1118 is a precision, low-power, 12-bit or 16-bit, noise-free,
+  analog-to-digital converter (ADC). It integrates a programmable gain amplifier
+  (PGA), voltage reference, oscillator and high-accuracy temperature sensor.
+
+  Datasheets:
+    - ADS1018: https://www.ti.com/lit/ds/symlink/ads1018.pdf
+    - ADS1118: https://www.ti.com/lit/ds/symlink/ads1118.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1018
+      - ti,ads1118
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  interrupts:
+    description: DOUT/DRDY (Data Out/Data Ready) line.
+    maxItems: 1
+
+  drdy-gpios:
+    description:
+      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
+      distinguishing between interrupts triggered by the data-ready signal and
+      interrupts triggered by an SPI transfer.
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1118";
+            reg = <0>;
+
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+
+            vdd-supply = <&vdd_3v3_reg>;
+
+            interrupts-extended = <&gpio 14 IRQ_TYPE_EDGE_FALLING>;
+            drdy-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d98efb1ad1..3d5295b5d6eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25646,6 +25646,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS1018 ADC DRIVER
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org

-- 
2.52.0


