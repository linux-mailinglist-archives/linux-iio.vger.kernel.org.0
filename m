Return-Path: <linux-iio+bounces-26950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B4CAE149
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 20:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBDB309C04A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43F2E9EAD;
	Mon,  8 Dec 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2L0W6mx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121A2E54A1
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221910; cv=none; b=MyTgIWMh8w5jpKKnkHk9QG/Et73CMe/53tVxUzWMm3uIvbrQGYn7Ffuxna5JbdGZIbNVvF8tRfAWw9k5XkLffUtxPDVZdKs0ti8BMgAn7qiBUeP6aGzIJcab0zjUEsCxSwiQJDVGvoKQObn1NHa5XIRcp6rCXywDDwb852v3j7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221910; c=relaxed/simple;
	bh=U3tYAeggLNbNZm744LuzUv6Z5oxxrD3QEglW3cU1tc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8ok4QDQlGySaGPkJ6JlEOmT9BgPIDtVhG8Wf2RFBvBAVxMRBB59HeeE8oHWZQDc1vYc2W4f+bRxiXI/4XnQqDOJpxnsx5tcfieiUyPLtAE0sSN6XN4e2rbSP4IXhPhM/YZjQz1IF0UCnJ3gkgNLkd6Xr0M6AHXMy4Zh2I4BObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2L0W6mx; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so1249262e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765221904; x=1765826704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8DFduax6wIBjPqmBoRAeZjbiJY7QM+MIHlbXb+RF2I=;
        b=B2L0W6mx73tC4sF60dk88jeNCIv7Pcz6qfA+2K17ym1NBbysgjsgiKyMOmnXWuzlzy
         jC5M285Fi5li5kQfZs1Adst4N9WQwTBF0MV0oQTYyFVK3TNKx2IryWQwTGT1trw0kL0h
         QTs1mvJcr8ZxQog9JI/+FzRtcQrVwAVWK4XaVxxknH1j1QFl2zjMxxWlqdl1gX/r4Gk1
         /HCJJVTxsMlJbtqo/F0MNxZlOR2exvICDFFbaI7TRd7UnbDCn8Y2WVzW0neS0TIpcs3c
         GcAi5Ubn2haywplAJFEfycaGLxYZC8oyfvymWoGzcoL7GgtBDWEeHN9wr0HPKwPqdKs7
         /DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765221904; x=1765826704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N8DFduax6wIBjPqmBoRAeZjbiJY7QM+MIHlbXb+RF2I=;
        b=uaX9oKNcXUEpPcbOASmRZry1YjiosrB8PuHDgsu5l9mjVxzCLXEe+qZh9lcOSVdHTb
         XVFmtilHBykM6f+3M223O7WNytnkJ2z0i9Qs9OgaK4vNKcGJH4rttEJpSH2Q4w9Vg4rR
         OMmQqRzMXpfnQaQEh6EbwVlp2dC6e7iYgWAAjNWvm4OYh8Sx2GZyQK+qdGLTNXSZkz4U
         8IDTHYCwwEMPwOwHWt+ItW4ImlhQl9zJOb/W6+a1J0nMLe+OdwbooRX3QXwjis2CKlu6
         KQEcGaQDBB4XM32P+hfuO09nKCUQwmWu4GCWGv0q7WZJiGpcGeaHuXgN9Dlnls0BjICT
         agqg==
X-Forwarded-Encrypted: i=1; AJvYcCWE7UB4tuwmSp0Z9srgujNasUNUUf0ArRu4r0c2OwwlZWKwAqcsZoLH5bmQf9mFsMMRfnaLaBKdBsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SUOEf7ele7kCA8S73pgShVFpW8/safrqR+sLLe/7LiC77quc
	BxognFvQAUytEJykT6GYNxglx7QJvyQ86/d1o5wjbvsVgCAURxKZXWWEyioSAQ==
X-Gm-Gg: ASbGncsokNPouGUUhlzK+ETiPONNE13t/ZxZwjo4a7ef/gMDWh448lZmmfNS/Pcg00T
	/h9xrBZo+V0lXeGV6yJDj++Mpyf9lpUsBUng1NsMNCnx31JvaL/X5+4B4snMwB9wMtYCD8qADaQ
	NUCEK7jFWpp28PlhL+twpcW/ij2J84+5anOSDbVSOnOKMlK3qIQcjvaBzP43Yp2vrnK4WQ++mFw
	i3bVuqV0094fXEpunRZLfQ/c2fytnZujt2nUJ0t4R6DWmBc01ksUE/p3JEgaPww0jLz7BMUquu+
	o38TtbHOvE6/qEuGWKOkuw253ImBFHnKWAoV5mgPeQKPn6dBeH22rJoTOSXcFQM8TS26fBfaLfY
	MCLkgezcpjvlwrym5N9F1hi5TsfalWycAwnTEfAIWnGMPPT4Xz0vq1WTArsOBUmb6OKxeqfW5gt
	ZfAv1+DGxJ0l/oLxo=
X-Google-Smtp-Source: AGHT+IGGagaIm32Re721YpnkgajZNaQL9q4bU8vtATK6/4Sg6wIXapXUnvWPwVK7U58AiNakzdUlJA==
X-Received: by 2002:a05:6122:2885:b0:55b:9c1c:85f1 with SMTP id 71dfb90a1353d-55e8457071dmr2561440e0c.1.1765221903959;
        Mon, 08 Dec 2025 11:25:03 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c9c8fafsm6480475e0c.20.2025.12.08.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:25:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 08 Dec 2025 14:24:35 -0500
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-ads1x18-v7-1-b1be8dfebfa2@gmail.com>
References: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com>
In-Reply-To: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=U3tYAeggLNbNZm744LuzUv6Z5oxxrD3QEglW3cU1tc8=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnmatwW068r7Ppz1PNHZ+3mixeFulX7QhQDl105v5JVj
 +G03dxDHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCR+k2MDBfmzQuQuuS9hj2r
 vzT0UX8P3yf3WL/4WVNkzdg0Jn9tZ2Bk2O5qtKlz2r3WZqVpCTlK86dX5R2LF/jTtORfwVshuwP
 rWAA=
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
index 000000000000..81ee024be2e3
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
+  The ADS1018/ADS1118 is a precision, low-power, 12-bit/16-bit, analog to
+  digital converter (ADC). It integrates a programmable gain amplifier (PGA),
+  internal voltage reference, oscillator and high-accuracy temperature sensor.
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


