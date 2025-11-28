Return-Path: <linux-iio+bounces-26530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBFC90C93
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 04:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A984E29A7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193B2D7DC5;
	Fri, 28 Nov 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk/gtXCx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA112857EF
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301052; cv=none; b=hQOHIj9kB0hYC8Rt25Iv73cvb9f+XqB3hA2bSj55NBbv+yCZHGgEf5mfUTAFpc7zEPOfWhxCXPTr6qyyt3OfZvtJHWeZ9niEW3dDDysog6VdCwXhSPMKLACyeSh+2/HJyt3MeSZWw2TrAmLdkPvKVvxE5ZVRXkN82Eufb1c33Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301052; c=relaxed/simple;
	bh=zN4mTvAlNG+j5dkz9olyk6N5wrggUvPOvD8a++d87Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qx2DGEldSgPdLVETNMXVQ8qenPOWZ3kKZChxpnvl55ud8JK5mU4orYRzew0TvS6ukgEBKvZ5MQU2VmBMmur4/NhQbn3JD2V2WjMPUU4DdJQuQ1YeBQyuB0/Sp6fMCe1IvKC6k9fXvyrnlWqbQG+Ml0lBbGfn81wsf45C31UlSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk/gtXCx; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so537632137.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 19:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301049; x=1764905849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AABb+J7VAVGq7TKx/cUCiui5FZaOhmyV1W31gf2aLcI=;
        b=Kk/gtXCxyuI/+Zj2QpW4Uuw6gpW57vrQpEg+4OZhQ19oX651avu7+45tOImfkzfXsk
         U1SogdedPMfNRYqwqnMubCD6L4+XZuAZVx9Ta6yamwnZLYS5QCtWiWc0JpazGpa4i/ks
         GkyqAy6ezcj4H/hF7IPAalpFgdSVh9BrnU+9KNKDzPqLLOA5yimDs7Q/FKEbVyIO9s2L
         A9HeiE2NdwbkhC2Q3LC7knJf8CsKqKhfr5RR5HLtxZlcmOQNaRY8e6XMpLCJ8MArmMdO
         7GNJEcgut4TmiSCrefOQ4pyiXtYFJbxtksbnm1FcO6cCnUf1q2VzaSFvTmS/LTodLzF0
         TVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301049; x=1764905849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AABb+J7VAVGq7TKx/cUCiui5FZaOhmyV1W31gf2aLcI=;
        b=uXmjlCvgaHHKQAYKmuTFoDdharjwKlEBm5JCLbR+Ep0To9nd02HJlznaU5e9XNIIh3
         fB/v685DX8toKlOak1MAf4HV3oBlOpJiLJ0X/pFjzCQPu2v77Ob9cF10oXTGhhUdcBvt
         X2mXbxltyjjzMqgCv5wZK78dCBvC6II0mx0fEhkr3lgG9jrvDQzMDGIG2aPc73L2LRmi
         fge6aaBG1cyGsCIa6cX4VAuMYzrLReNGQTZiwH+Hyp2vfvtCzKetfNgNQ7Qtkl74nuRL
         RBd1KRsytZ2bdf8YkjGeHMoUctxLrSdrtPN+PjRRwm11ssOP4amQy/PkFCTopMEJKTV8
         mArw==
X-Forwarded-Encrypted: i=1; AJvYcCULJMxIw/EzbDdiIzDjfk4B3sdxLDdByoAVbfIbBkbREd6qzaNEeAYG/CK5IqU+/lkRsGFHdQqVvOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF1Kyuji0Uhj/dOF18zBubsGfxA4xvhiLo5Fff10LfO8+Wl/J
	vd5waA5wwHp59EgsmaYF4A3C9EhT5FT6Di6McDwVcfUW4c/vB4Qo08oQ
X-Gm-Gg: ASbGncuBdLnu7x5VK59LRD9XByWkOIZ2bhPYPyiKR1Vs08Sjc2dAEpV7200YvwRG8Bt
	ItRzgo7BUkCW2JLM7b9opKxN537BEfup63Gitq6OEXe3zxEaTcm/mYT8Kw+ucDM2/azs0UZypmJ
	28RHaySwJ6lKNCkqTUOsl3t+5VTYxl3QCJ5UTs6mDBW4RMLH3386loAJ2CIzHODVS7kBXefp5gb
	VKwjFr53a2TDmDo6EKyZUJRPoBvqVmXOeCJSqyN0mBcf7kb6aJtoSYsPMeQFRf0m8z0yrL+Kpsz
	0dykuasIvJ6qATJOwOukzCm/DG8pxs+LIJ/1jRcmU64GfXe42ugMydI/7yx21rJ1+bD1nlgwJ8U
	lzDu5vt/s6/nV51p9mCY/OsCuJPp3MiSYHMbQwyx57nBqicwFCozLQUrPQczFD+Mf1Gq+OJd5ZZ
	z+tnnk4ayPZiw1dK5NOtkCz28=
X-Google-Smtp-Source: AGHT+IGwtp7PrAsIHTD4uB2Oxo042oMNiACJI0iD4v9fC+ytl628G33X0a2EjGjxFvkynmU5sWJKog==
X-Received: by 2002:a05:6102:5107:b0:5db:ef30:b74f with SMTP id ada2fe7eead31-5e1de0c07b0mr7355964137.8.1764301049390;
        Thu, 27 Nov 2025 19:37:29 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d94f2d2sm1170483137.8.2025.11.27.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:37:29 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 27 Nov 2025 22:37:10 -0500
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-ads1x18-v2-1-2ebfd780b633@gmail.com>
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
In-Reply-To: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3398; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=zN4mTvAlNG+j5dkz9olyk6N5wrggUvPOvD8a++d87Lc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJmaEl9MrcTCq50kNO+tqjTMcJz2lT+2+0inrqiyrM2jI
 uUXjYodpSwMYlwMsmKKLO0Ji749isp763cg9D7MHFYmkCEMXJwCMJF5JowMt69LnxfetNJtkaKo
 xCXLYF/zEwL1jUufvft8vddqddJ7WUaGMyc4Y20fLz45obPsYaLj4cjYmVIn+DNZ31gkKFkKqS9
 nAwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add documentation for Texas Instruments ADS1018 and ADS1118
analog-to-digital converters.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    | 93 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..021f2a3ca4be
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,93 @@
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - '#address-cells'
+  - '#size-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: true
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
+            #address-cells = <1>;
+            #size-cells = <0>;
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


