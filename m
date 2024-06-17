Return-Path: <linux-iio+bounces-6419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4890BB84
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF61F228AF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BD18FDD4;
	Mon, 17 Jun 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IL+ETVQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD318C32D
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654228; cv=none; b=eK4lqQIkpCb5DDeSH6m1g02GDY2Ki6geWuEjAQGWi9IQhJQe2Qj8946T4xcHBK2lh2T3DI6joUqtPuwJ9Cgd6AWbVNTrVZbKU2oV/Pi6A8nR0HHSqOzkiewmlrI0rMBOIojjrXGzuK9ffyUlz3+81w1+TQJzWIJjr4PEKsdueKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654228; c=relaxed/simple;
	bh=jScWXZuvaWjSAFEiWaupZAThEoVcoon0zQGVLdc0A1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZciewkWTZOlnhamDmhN35Kv39fSqcDSNhfewH0h3GK/vAPIL8FrfUlH7Ib6+0rwVrFN4djtVQ6xvAIldM/IgwT215Z8vpxbuNcwXNbN/aIGX//A0BS4ZzKiHEIVnf10uqmxakmOZXjyixgqAc8bYQ6cSK44wQKHwanWmQgz9cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IL+ETVQC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d229826727so2698426b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718654224; x=1719259024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrRBqxwVs7CBe0YJasS3fr3W7QeSqhkSq6F67UEuwqE=;
        b=IL+ETVQC6K+FIUS3EXg2ysa6Keym8mVMFZhnzSRsDyAiSnWMn6yC2ddwJ7kh2yRCL0
         Yhv/ZsiMUTJv0bIl4/7kJq2Q9vkNFAQHJLt6zIFHAsRkv8DMn0oVyZGynKthyDAE2yKm
         frohGFeVLZpgsrq8fJ6ka7IFg+j4c40nhcopok0ELWWGix+/+xDjjn/quFgBhBQuY/qO
         nuzhPWW38yYwA1oN8xwHxrZ7Ea+PgecHYSOGaQ5WuPJll0RxntQXBUXgkEihHa/O/y24
         yixIe9ViAgDYJL3jN7RLASjiVa3HGn7E3wKPQe1pxjKIXBZA6S6fS9CiwVu9MilelKEM
         OLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654224; x=1719259024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrRBqxwVs7CBe0YJasS3fr3W7QeSqhkSq6F67UEuwqE=;
        b=ou00JJTCq7TMz/96dlLfeAQncI8VDwSiq36gUyejoFil6iwkrohC9u8wCCGvC3k3m0
         rtN7aQloKrF+GBOEC+5dc58mARJIwh2VZVK4CSL/ieXgfI7cndxI08gc1FIL7NaRxyfA
         UfSCTVzLM4fWVd9QrJ6CYy0n07UT0rS+jVwTL1sq0h06BxsyjdSU7W9IVaEbiJ8jNl6d
         PKCIxLzO7UVokfabYC6dWv2V5wfNwIFGuignsa5hKtYunrUWTJPQB2m1cI8w3lSQKamg
         u5fcawGddwkzaOftT7+hB1lBTCzmWpfaTiVdde4GOugDoQGlimCd9MA8jNrX7ZuJjhSY
         8kpA==
X-Forwarded-Encrypted: i=1; AJvYcCWZpN/heyo63nYqFhSB8q6s3IxpdtpO0J3L6KtjlQhlH5E3AHoOm8MEgqqe7Xox+f1+VBKfDUVIpzhZwj/1BQvtXu7L1gqjmmd6
X-Gm-Message-State: AOJu0YwwwhxfDMBn7Ne5jJd6INHr28qYsNnQTONW9UA9+ZuNd3OOgk+d
	4m5jaD0J+HToZqH3GKMDAh9YPld5QwXBvAcdl+Wt70HPOuLJsYJTl9h6SR3vEZg=
X-Google-Smtp-Source: AGHT+IF8ILTn3vu+tnQOCuOLX+Ku/Fsn+Mt/SN0qHyjrHs2KJOG1P6fZj8lyjr3OZe4xAU4//J1khQ==
X-Received: by 2002:a05:6808:23c8:b0:3d2:1e98:cb04 with SMTP id 5614622812f47-3d24e8b9a3amr12599646b6e.7.1718654224542;
        Mon, 17 Jun 2024 12:57:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e2fa4sm1579492b6e.52.2024.06.17.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:57:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar ADCs
Date: Mon, 17 Jun 2024 14:53:13 -0500
Message-ID: <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Add device tree bindings for AD4695 and similar ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Drop *-wlcsp compatible strings
* Don't use fallback compatible strings
* Reword supply descriptions
* Use standard channel properties instead of adi,pin-pairing
* Fix unnecessary | character
* Fix missing blank line
* Add header file with common mode channel macros
---
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 +++++++++++++++++++++
 MAINTAINERS                                        |  10 +
 include/dt-bindings/iio/adi,ad4695.h               |   9 +
 3 files changed, 309 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
new file mode 100644
index 000000000000..e5dafb1f6acf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -0,0 +1,290 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4695.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Easy Drive Multiplexed SAR Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  A family of similar multi-channel analog to digital converters with SPI bus.
+
+  * https://www.analog.com/en/products/ad4695.html
+  * https://www.analog.com/en/products/ad4696.html
+  * https://www.analog.com/en/products/ad4697.html
+  * https://www.analog.com/en/products/ad4698.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4695
+      - adi,ad4696
+      - adi,ad4697
+      - adi,ad4698
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 80000000
+
+  spi-cpol: true
+  spi-cpha: true
+
+  spi-rx-bus-width:
+    minimum: 1
+    maximum: 4
+
+  avdd-supply:
+    description: Analog power supply.
+
+  vio-supply:
+    description: I/O pin power supply.
+
+  ldo-in-supply:
+    description: Internal LDO Input. Mutually exclusive with vdd-supply.
+
+  vdd-supply:
+    description: Core power supply. Mutually exclusive with ldo-in-supply.
+
+  ref-supply:
+    description:
+      External reference voltage. Mutually exclusive with refin-supply.
+
+  refin-supply:
+    description:
+      Internal reference buffer input. Mutually exclusive with ref-supply.
+
+  com-supply:
+    description: Common voltage supply for pseudo-differential analog inputs.
+
+  adi,no-ref-current-limit:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When this flag is present, the REF Overvoltage Reduced Current protection
+      is disabled.
+
+  adi,no-ref-high-z:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable this flag if the ref-supply requires Reference Input High-Z Mode
+      to be disabled for proper operation.
+
+  cnv-gpios:
+    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
+    maxItems: 1
+
+  reset-gpios:
+    description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description:
+          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
+          condition.
+      - description:
+          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
+          condition.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: busy
+      - const: alert
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is the GPn number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+    description:
+      Describes each individual channel. In addition the properties defined
+      below, bipolar from adc.yaml is also supported.
+
+    properties:
+      reg:
+        maximum: 15
+
+      diff-channels:
+        description:
+          Describes inputs used for differential channels. The first value must
+          be an even numbered input and the second value must be the next
+          consecutive odd numbered input.
+        items:
+          - minimum: 0
+            maximum: 14
+            multipleOf: 2
+          - minimum: 1
+            maximum: 15
+            not:
+              multipleOf: 2
+
+      single-channel:
+        minimum: 0
+        maximum: 15
+
+      common-mode-channel:
+        description:
+          Describes the common mode channel for single channels. 0 is REFGND
+          and 1 is COM. Macros are available for these values in
+          dt-bindings/iio/adi,ad4695.h.
+        minimum: 0
+        maximum: 1
+        default: 0
+
+      adi,no-high-z:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Enable this flag if the input pin requires the Analog Input High-Z
+          Mode to be disabled for proper operation.
+
+    required:
+      - reg
+
+    oneOf:
+      - required:
+          - diff-channels
+      - required:
+          - single-channel
+
+    allOf:
+      # bipolar mode can't be used with REFGND
+      - if:
+          required:
+            - single-channel
+          not:
+            required:
+              - common-mode-channel
+        then:
+          properties:
+            bipolar: false
+      - if:
+          required:
+            - common-mode-channel
+          properties:
+            common-mode-channel:
+              const: 0
+        then:
+          properties:
+            bipolar: false
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vio-supply
+
+allOf:
+  - oneOf:
+      - required:
+          - ldo-in-supply
+      - required:
+          - vdd-supply
+
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+
+  # the internal reference buffer always requires high-z mode
+  - if:
+      required:
+        - refin-supply
+    then:
+      properties:
+        adi,no-ref-high-z: false
+
+  # limit channels for 8-channel chips
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4697
+              - adi,ad4698
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 7
+            diff-channels:
+              items:
+                - maximum: 6
+                - maximum: 7
+            single-channel:
+              maximum: 7
+        "^channel@[8-9a-f]$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adi,ad4695.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4695";
+            reg = <0>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+            avdd-supply = <&power_supply>;
+            ldo-in-supply = <&power_supply>;
+            vio-supply = <&io_supply>;
+            refin-supply = <&supply_5V>;
+            com-supply = <&supply_2V5>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* Differential channel between IN0 and IN1. */
+            channel@0 {
+                reg = <0>;
+                diff-channels = <0>, <1>;
+                bipolar;
+            };
+
+            /* Single-ended channel between IN2 and REFGND. */
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+            };
+
+            /* Pseudo-differential channel between IN3 and COM. */
+            channel@2 {
+                reg = <2>;
+                single-channel = <3>;
+                common-mode-channel = <AD4695_COMMON_MODE_COM>;
+                bipolar;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c870bc6b8d63..19d4bc962c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1209,6 +1209,16 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
+ANALOG DEVICES INC AD4695 DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+F:	include/dt-bindings/iio/adi,ad4695.h
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/include/dt-bindings/iio/adi,ad4695.h b/include/dt-bindings/iio/adi,ad4695.h
new file mode 100644
index 000000000000..87a1b94af62c
--- /dev/null
+++ b/include/dt-bindings/iio/adi,ad4695.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ADI_AD4695_H
+#define _DT_BINDINGS_ADI_AD4695_H
+
+#define AD4695_COMMON_MODE_REFGND	0
+#define AD4695_COMMON_MODE_COM		1
+
+#endif /* _DT_BINDINGS_ADI_AD4695_H */

-- 
2.45.2


