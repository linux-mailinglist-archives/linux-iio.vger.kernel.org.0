Return-Path: <linux-iio+bounces-11609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6A9B6477
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2F6281C66
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB31EF0BA;
	Wed, 30 Oct 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NJgrbFoZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6D1EBA06
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295884; cv=none; b=CbLyTvf1oR7s9HfzXU+LLl0ZdUdiC/PFqn+wNSEqoLAykMlpUlle0hpHGxH9ZTki4VBfO8WoUZe/TdQmvrKcJZMJdhJw7xDK01znBblRJOtmQJZVQxZbJ5FDBFjuQnKkD+/8HtxHIsYwsiNuvdIw2v4C/iCkmfOXPrqHSF+0AiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295884; c=relaxed/simple;
	bh=XNOgRI6/E6rGpPVTM4KwhIdeiFUpPLgi+/tTI3E/mjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzGc2U/TKVm3rVBEWFcIO3bnw4+3yHNYPMKk6a7q2zEkEr806SP2lTU20Bnh278G8ej3CaauwVaPqbl9FI5UpadlvcvUyoAQZ4ehKAzU8bxH0AHSu0fAiNgfpvfneDOv8BWpunm516gj3654waAhNzcMOqxrQ/iwlnAY/B7ePx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NJgrbFoZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53a097aa3daso5921354e87.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730295879; x=1730900679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iaf1l+bnhiCTU8hwXRtL4ts0yRz9+4XKZaoBPuLyVFc=;
        b=NJgrbFoZaYdjj8sNviivkqclZWcWxkT8mIMfnT4owrkmUCV3njsySksQG/aHN5Nait
         hCkgkb9awLRHD67aoayKoLBuTxQ0HsEY6/vQHc+33oKRZ3fzW+EJrs4/Dgft6nfDqoTl
         pETF+xztHgGKZilDJN8zkIvtQ3vfL3U8+0sWZupuXLcRpqR9z3m0noI3ib3I3AXqhiC/
         0TBnv8x2DdbaOqmlCQeY1b/DLPz+wdXDbD6Z7MXa07vLAzri0RCuUwb+dCNzcfemSbvI
         fQJxWL130x7toFYbYLJcTMXRUYcs/LoP+HvPM7Y98ovFuXKtB79lc/2TtudIDiBPFS5r
         dXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295879; x=1730900679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iaf1l+bnhiCTU8hwXRtL4ts0yRz9+4XKZaoBPuLyVFc=;
        b=iBgC3mHJoNbhqJj070ahItJ0TAlvETUKxn5IA8KpG08ZHmEqNWpaW+YRCZe5HcOhCC
         dMZwrTajhMjcdpz6qV52iTRa+dQ864XQBWkZULxIeRRzOcnjgD9b5jEdLz+jwnzjFyOK
         CaPzAYOdjUWh1Lv0qcN1Cj1R7pRumTMleavIDNPs0+jf6q0/DK4n5w87b5g/Q1TcI6fb
         DxXeY15PNia4CNkPU7+bUU7TnEzx4VnKyZ6ZhX/l4n5pXzn5u5W6Pt9PvebGQRyO5CP8
         OJa+v4hRJek0aCoduELdiXwj4VxfmWHAs6VY3xqIcGF7H/LpHKeseRCwaFX0OZvcfgjb
         nh+A==
X-Gm-Message-State: AOJu0YweW3Xl6degmHJe3ZnUgv8p7ZJjcUbl0qWa/aZyGNOldeOQu+41
	i0nOZy7uT0pC67Jc7iqCHwIZhxSFI0d0p/URjw1rjhetEI3+PjTRWJmG4OlVZ5Q=
X-Google-Smtp-Source: AGHT+IG8QJmX7y8D32rgtAy+irk49ns3+RygZ88fAcd7W5ZJEonrfo6aEX0LrZEQ1zKIpX7vAIosBw==
X-Received: by 2002:ac2:4e0b:0:b0:536:741a:6bad with SMTP id 2adb3069b0e04-53b348c1086mr7961575e87.12.1730295878920;
        Wed, 30 Oct 2024 06:44:38 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d693sm22135175e9.24.2024.10.30.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:44:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 30 Oct 2024 14:44:25 +0100
Subject: [PATCH v4 1/5] dt-bindings: iio: adc: ad7380: add adaq4370-4 and
 adaq4380-4 compatible parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-ad7380-add-adaq4380-4-support-v4-1-864ff02babae@baylibre.com>
References: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
In-Reply-To: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
acquisition signal chain μModule solutions compatible with the ad738x
family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

To select the gain a new patternProperties is added to describe each
channel. It is restricted to adaq devices.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 0065d650882489e21b952bb9fb25f1e3a070ee68..ada08005b3cd1ce7ba13f96484a33fdee0e83a1c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -25,6 +25,8 @@ description: |
   * https://www.analog.com/en/products/ad7386-4.html
   * https://www.analog.com/en/products/ad7387-4.html
   * https://www.analog.com/en/products/ad7388-4.html
+  * https://www.analog.com/en/products/adaq4370-4.html
+  * https://www.analog.com/en/products/adaq4380-4.html
 
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
@@ -46,6 +48,8 @@ properties:
       - adi,ad7386-4
       - adi,ad7387-4
       - adi,ad7388-4
+      - adi,adaq4370-4
+      - adi,adaq4380-4
 
   reg:
     maxItems: 1
@@ -70,6 +74,20 @@ properties:
   refin-supply:
     description:
       A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+      For adaq devices, a 5V supply voltage. A 3.3V internal reference is
+      derived from it. Connect to vs-p-supply for normal operation.
+
+  vs-p-supply:
+    description:
+      Amplifiers positive supply.
+
+  vs-n-supply:
+    description:
+      Amplifiers negative supply.
+
+  ldo-supply:
+    description:
+      LDO supply. Connect to vs-p-supply or a 3.6 to 5.5 V supply.
 
   aina-supply:
     description:
@@ -97,12 +115,45 @@ properties:
       specify the ALERT interrupt.
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
 required:
   - compatible
   - reg
   - vcc-supply
   - vlogic-supply
 
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: adc.yaml
+    type: object
+
+    properties:
+      reg:
+        description:
+          The channel number. From 0 to 3 corresponding to channels A,B,C,D
+        minimum: 0
+        maximum: 3
+
+      adi,gain-milli:
+        description:
+          The hardware gain applied to the ADC input (in milli units).
+          If not present, default to 1000 (no actual gain applied).
+          Refer to the typical connection diagrams section of the datasheet for
+          pin wiring.
+        $ref: /schemas/types.yaml#/definitions/uint16
+        enum: [300, 600, 1000, 1600]
+        default: 1000
+
+    required:
+      - reg
+
+    additionalProperties: false
+
 unevaluatedProperties: false
 
 allOf:
@@ -140,6 +191,7 @@ allOf:
         aind-supply: false
 
   # ad7380-4 uses refin-supply as external reference.
+  # adaq devices use internal reference only, derived from refin-supply
   # All other chips from ad738x family use refio as optional external reference.
   # When refio-supply is omitted, internal reference is used.
   - if:
@@ -147,6 +199,8 @@ allOf:
         compatible:
           enum:
             - adi,ad7380-4
+            - adi,adaq4370-4
+            - adi,adaq4380-4
     then:
       properties:
         refio-supply: false
@@ -156,6 +210,27 @@ allOf:
       properties:
         refin-supply: false
 
+  # adaq devices need more supplies and using channel to declare gain property
+  # only applies to adaq devices
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,adaq4370-4
+            - adi,adaq4380-4
+    then:
+      required:
+        - vs-p-supply
+        - vs-n-supply
+        - ldo-supply
+    else:
+      properties:
+        vs-p-supply: false
+        vs-n-supply: false
+        ldo-supply: false
+      patternProperties:
+        "^channel@[0-3]$": false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -180,3 +255,48 @@ examples:
             refio-supply = <&supply_2_5V>;
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq4380-4";
+            reg = <0>;
+
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+
+            interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            vcc-supply = <&supply_3_3V>;
+            vlogic-supply = <&supply_3_3V>;
+            refin-supply = <&supply_5V>;
+            vs-p-supply = <&supply_5V>;
+            vs-n-supply = <&supply_0V>;
+            ldo-supply = <&supply_5V>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,gain-milli = /bits/ 16 <300>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                adi,gain-milli = /bits/ 16 <600>;
+            };
+
+            channel@3 {
+                reg = <3>;
+                adi,gain-milli = /bits/ 16 <1000>;
+            };
+        };
+    };

-- 
2.47.0


