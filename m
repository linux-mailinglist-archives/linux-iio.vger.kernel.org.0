Return-Path: <linux-iio+bounces-111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC007EE1D1
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30B9B20C3A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA230F8D;
	Thu, 16 Nov 2023 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MimALJQB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710419D;
	Thu, 16 Nov 2023 05:47:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507bd19eac8so1065887e87.0;
        Thu, 16 Nov 2023 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700142419; x=1700747219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4riDUNHReIjba9jNFgLy2y8ooHDaaaBbqxL4CyG3VrQ=;
        b=MimALJQBksQ7NPyZHU9nhDmLvep4M9MfIidiPBWuVUdopqzLF36NUHyIKaO8IsrMUG
         U8Sp6Me5k1RNLkshbKnygBGZXn8W9mXuwXWyZYoSbc9ibpmLdZmhbwPWOLPTH6n9LB3J
         60DBa4SMq8XCeU9UDTmMfGQtlO8cBEJ3FpCNc3LRY8m0EHyEEXOLJT8nmp/rqpj6wubC
         pm1xFoXyeTCum6TwZPgKA2s1BQdCoVlJ5QLECTF3qi6vUP6xFI/0HoI1pCrTiztSigON
         +P8DmC1ySRQ0wF+/XIqaXFtcsO0vnAVQQs+vqZ9MqQy467sl/0JciRAdyuY/mdveM3BX
         7bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142419; x=1700747219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4riDUNHReIjba9jNFgLy2y8ooHDaaaBbqxL4CyG3VrQ=;
        b=YidV1e281O4AgBF4uHTFVH8fEFejfR/zcaf1zTen6F7DYIPRqA9If0od9zdOkYnED9
         VWN+wPZWZsnHcK52VOvPKpCyFjtxiC9TihWpbj5hZscdPWAbuP6+iONugBVVjGgsjn/k
         O0L3mYPW4B5m7fKY668PS9qwjDMQwL6WEiWrnMJibUGRtc8g39EuXCv2z3tbkEStTSIm
         bAOnY+7K7f4WDb2C2c9bHGaFtTlaBiwrDAgyX8mSK5gG0j1IGZ+ix6dkIQkRPZ9r7eeE
         XvITZdH1IWRBvUo6umSasQIEHndyBK3Bja1dlF6DuzA7dUQ929oLePpn7xHwHgo6zknT
         6uUA==
X-Gm-Message-State: AOJu0YzbU4hzRfkEi9rOc6a89t3/VuOHgdMiyX8sMVwOdrwIBVh/e3g/
	JxNEYVtJx/3Lth4HgxBkk00=
X-Google-Smtp-Source: AGHT+IFL/NuWsDiaywQTihviTlNe0Yg6vEx4NWx9NSig2wcqKYD7Jxfw5VED8sevA8TPIIufd+tiyw==
X-Received: by 2002:a19:f808:0:b0:500:9a45:63b with SMTP id a8-20020a19f808000000b005009a45063bmr11482079lff.13.1700142418660;
        Thu, 16 Nov 2023 05:46:58 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ov3-20020a170906fc0300b00977cad140a8sm8467005ejb.218.2023.11.16.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:46:58 -0800 (PST)
From: mitrutzceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: mitrutzceclan <CeclanDumitru>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: adc: add AD7173
Date: Thu, 16 Nov 2023 15:46:54 +0200
Message-ID: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dumitru Ceclan <mitrutzceclan@gmail.com>

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # except reference_select
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V3 -> V4
 - include supply attributes
 - add channel attribute for selecting conversion reference

 .../bindings/iio/adc/adi,ad7173.yaml          | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..92aa352b6653
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7173 ADC device driver
+
+maintainers:
+  - Ceclan Dumitru <dumitru.ceclan@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7172-2
+      - adi,ad7173-8
+      - adi,ad7175-2
+      - adi,ad7176-2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  refin-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  refin2-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  avdd-supply:
+    description: avdd supply, can be used as reference for conversion.
+
+  dependencies:
+    refin2-supply:
+      properties:
+        compatible:
+          adi,ad7173-8
+
+  required:
+    - compatible
+    - reg
+    - interrupts
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        items:
+          minimum: 0
+          maximum: 31
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          0: REFIN(+)/REFIN(−).
+          1: REFIN2(+)/REFIN2(−)
+          2: REFOUT/AVSS (Internal reference)
+          3: AVDD
+
+          External reference 2 only available on ad7173-8.
+          If not specified, internal reference used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 2
+
+      bipolar:
+        type: boolean
+
+    required:
+      - reg
+      - diff-channels
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7173-8
+    then:
+    else:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            enum: [0, 2, 3]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7173-8";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <0 1>;
+        };
+
+        channel@1 {
+          reg = <1>;
+          diff-channels = <2 3>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          bipolar;
+          diff-channels = <4 5>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          bipolar;
+          diff-channels = <6 7>;
+        };
+
+        channel@4 {
+          reg = <4>;
+          diff-channels = <8 9>;
+        };
+      };
+    };
-- 
2.42.0


