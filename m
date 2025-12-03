Return-Path: <linux-iio+bounces-26656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85880C9DC6B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 05:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62C7734B534
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621E2848A8;
	Wed,  3 Dec 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiAhjC6N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97B27EFEF
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737803; cv=none; b=Z9PhJeYB62XTPbTjS1ObSgbF3CgowQ+PdrcDmuIxPJF9IyjCLVsj7Yp8ySck+P/IhcEjYSWDJMAS6+iYgDpw1b8l3XjHf9EtAIJzU95a4Lfybpqtf974DFaXgGZ4p1V1zUzXZGF7KL72XPBI4mvd6KuFeU9FRuol8b6UccImDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737803; c=relaxed/simple;
	bh=VsKMfePN7JjgmEwgQW457cXjo1Jn7sfHu3mU8ne1Azc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTcSVTGJlLPalSva2GQB4GW7ahhB+bgwqKOATMi1mKu0RYPAvDrPioLN52M1SMj3n61GxgXxHxOysqp/BlFfoXAzAKrtUIOgpI4VzINWKkOr8VoeO3XEagEHz6Oyy27vpKEvLXWZgLhCqsLf1Nyx1LCzP60Bfwn4Uxg8uhq34o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiAhjC6N; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93754419e10so3555163241.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 20:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764737800; x=1765342600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=DiAhjC6Nx1jR3A0vsUy1gy/4gF0a9tz0t3NAvnF72vbXXpxwdZFYRMOApbtYWWiGNd
         j5dBlxD0PLNcrmrlzkO6jGG8kg34p8CO8b2Op6pkzt4Fm+SgaaVciklFpjlouoPW7Z1P
         JprcWVTpQeZikDC+P9AK3i9o/KwBW7VyrppxL3zDz/q3z/8HOQ5wgIeSRmDd8j85oWx9
         2b3aZL5+roaphzZNPpcsDErjI8OBpSN3XG9IKGsdXE/ptNb/U+b9OxT1GLQMCZmLceBr
         QYid6z2jesb6m55F30DZmnbqms06fOmReuz+1fc7qsmogrIN5GvWdifKSwrKZrlQDauF
         nEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764737800; x=1765342600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=jMXB/qVo62f3z0DNAt+R8QvCd2pnw0zAWql/uxTyeGTKQ5X6VYFRzH3BuY9m5uRtzv
         Pt/jjSmSd6S+EnRrD7tu/QHwY4hO2UYDgXvwP02TU5bmvscX9qt570y6+4ktQRvkCqQZ
         XuAVPqBKfmsUy84kJylmbzpqEcseu8PI10x/6QmtvGCPSk0v3wQbKzqDSpUXcUB5q1zx
         PFM9Vi0XlkSev9IcruU7/FjKzVrhjrcjGhixm+txbSpsvMNFpurGFShPsqsCMcTrTvPq
         qS2mkxloPBTV3d+POjwvyMxH/PZv33xyqj0UzdxBdH88mmjhfpfk+jRk73KK6+wGjrQC
         gRBg==
X-Forwarded-Encrypted: i=1; AJvYcCUVdGsjdVXpnDIU9eG72dzY95DeR152AA+Bf31KZvnqyM6YCjVduzBLxYT7uqStssAtBPyMZ2HF4gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1b27TFmMoYsPI5LIQFWdI97CfHtVEvIc4PrW8C9RWexv0ptd4
	YxcD1s6wa3kQLu9P/SB9aA0GvCbTz0GIwxTKcgpxk89RBGEMG7w4J+xJ
X-Gm-Gg: ASbGncvjHNBKOYqhGx3KU7jaDtH4l2q9czcmZ3Eqyqq04n+YasAlY4H2OItMgKxtMQP
	axVwaDZJcGuIocFbKC+stQ/r6AHKj9/nOfjVfxzsY5NCmXI6TFLGxnhqhMnXWEW/uUIe2Wn69vU
	WaP09hGAsKQechTAibtdZ71/VKH4k9hbH+QHqeXr9F4lRIwByswH0fw3MlkCNt+sCb3ecwKXBPQ
	uyAwU6Qg9VWq6+Zr6RXcFj1LVaBlcu9qBU2ThzMg5bpDDksQsstLeH0G9yAZoUS0QAyw7KKgDMM
	+TS3UCrrM6B+29KmI/8qqlbtTHykgukbuEwp+2ElWr1rxSPX1Lc/Lrz05/Tf/cfeYg/npXhjHKo
	Vnvv9z92/Q0PSe/EE+DCP+9ssxbisgzfRbcdZ5I+NoLOoqDQvS/DiX7qQnoU/SE1Q9u89zPCKiV
	7Kp9h7xh2kDEpVkMUQE74bV/c=
X-Google-Smtp-Source: AGHT+IFHxTjlVAgICj/yjx6oV5U1MRjndSC4TrrnPw7FeJW62AiXsQwgbwaG4pGl3j3qddD01qmQWw==
X-Received: by 2002:a05:6102:9d7:b0:5db:cfb2:e60e with SMTP id ada2fe7eead31-5e48e3d475amr247205137.44.1764737799713;
        Tue, 02 Dec 2025 20:56:39 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6c6802asm7535496241.3.2025.12.02.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 20:56:39 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 02 Dec 2025 23:56:18 -0500
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-ads1x18-v4-1-8c3580bc273f@gmail.com>
References: <20251202-ads1x18-v4-0-8c3580bc273f@gmail.com>
In-Reply-To: <20251202-ads1x18-v4-0-8c3580bc273f@gmail.com>
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
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn6h5nFLtTkGeTtuLeuZapyUKdkdo8s5xnv5JaNHLZqs
 1oXrDrbUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABMJXcPIsNs01yNS9928Bsl1
 03bvyOOMEL9flJ4Wa6eqs6+Yzby+j+GfokBefpv9TYVHpzrTTUujZT6eO1brny3Cw9VuUNTj1cc
 AAA==
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


