Return-Path: <linux-iio+bounces-18931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B765AA5CFC
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CC31BC5D6B
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534F226F45D;
	Thu,  1 May 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHgYJjgN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449624E4BF;
	Thu,  1 May 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093733; cv=none; b=QSN5VbPDjs0i9jVpg05Dd/bhFEL5b/2kGlTDXHXtP2mbYUPFjLr+CU7XxUkK4XHPrxnTSMbUBPKNiZFn7XX9l775DqXwrYr78V7hqiHXfbX4JKy8dHn0rLc4cQKXUHJGul8iY+r5bxPI57xKyn5S4GR3yRbfZuMjBU91A3qWkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093733; c=relaxed/simple;
	bh=Se5ban1HaotZFiAJL4wpB/iOS9aHv+cFYzyyHNfd/+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ig32tDzKyIcclfZcCIfKytcm9IZoddh3+w8CS4GM6x2GYuVxVfDx9AxG7S04jU2EV28UCm/1/1yz9NX56o7Vq149itPl8bkSsRJtsmr6LT4q/dHmwVOuWkHf9reewpUqzXLSBQ4f/RQQw2BoozTwFQY48SHMGvJhwxXyAmjTsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHgYJjgN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af908bb32fdso696378a12.1;
        Thu, 01 May 2025 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093730; x=1746698530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIrQBi534yWG846WKR3hztDYNRifTQdAuywGpEqDRS0=;
        b=kHgYJjgN/8LzehZvdIUiinvaFh47WytlgOBNVMzOILUg+TCLj7X1VYWHrgmtex+vYt
         dM0x3Pf/j2TfmWxedRzuVK5tTKS7WI5Ot6RZuNiIt+g01SaTmaXuuubu8nGZCyr+wze0
         Xtt5HJ1nbCXfC+kL7Q/UQMNqxigfmXxRARSbYkVcn5WRCtqMY2sWLsNXFUD/Y9xCvIj+
         oEs4YwkwcmPeJqQf04J52IhJwnu05+8FwgmII4l9/okMp5TVSTNZg76PFBb8qnTo4Xkw
         dLtwmqEQ7aUkKXIz9WbTlqxYaWJsnZMbwSD4VqFB5UQt0O4hy35pjuD9m3MVGKnb9oAZ
         QC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093730; x=1746698530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIrQBi534yWG846WKR3hztDYNRifTQdAuywGpEqDRS0=;
        b=bJL8YYjaPKApRLVjQaM1Zs8Cn7BW9Gg1CPDex2ZBtGntLn037CTg6vBWRutsZZUl0+
         40eKv2JjEfP3/D8pwi+R5b0tkX9jVaq0ceB+nYz8cxMdpVAn8lXIPhqN6XXzecXjHc32
         D/5mSDNMWrSyfvtmzAMNKfQMLsfiKufnO/f35aW8XjWlc6UcHo57kN7jq0AAZM7dT0vj
         Kc7xLZ1ls892Fb9amB0DsODW30wvYj0O31fiPLWyp7UhtLhDB8k/m4jDQaxNMOhw+mtx
         DfbqpieQ369gs26uENOoPjhPO+33ODAbrNngLjX3rp/jVxgqhs6L9iD5MZFtoxbIRZZI
         CZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUCdEZArLeMAjrWWp1RyIyhP+omyOEsRY9r3C1IuQQDT//8O01gkCalLIh6oXeeXAmOY17dDnwYKFZG@vger.kernel.org, AJvYcCXkeAFJ1kApiytuXtWdlPvcwYSaGx/uaeIzODOFEFYxJYlBeAZOLIzSlrUHFgk+eRVnIySi/Nt4dh+kHRP3@vger.kernel.org
X-Gm-Message-State: AOJu0YySaz3zEveF45KcsxdYaWDSHjBBPL2oSStXaM9iTotSlv3Fdyxm
	jHkg6HLjgYmVFlx4BUmJR3RlfgkX6l5ONzLaJKZffEXrfijM25qgUvgUBckJ6N8=
X-Gm-Gg: ASbGnct0doejDFD+5wp8KNeVs/HWxXrYJ98N8WKg88moZwnd076luoU9awMgBwZcV+v
	adXCaNR8PnmIKg1HqTDSK58fSLh2sN/MxEmmW22iBOEkEZYm6+0RbouI8sPUXIswNOVePmZa5tJ
	fYN4f6GKp64PExORqUZ+wh+xv9oKFXFdQJJyjN+tGh+Pks8bQJ/oVzt/FJPXS9CiVOCSIUNhDGh
	EYkBjLoeBfT7CnyF014dTjqoLFMAiRjQXGwT+w5pvmt1HedDWO2ItMon1c17vjpj3KRynpR4Z/5
	ELW8aq/VZ77wWFm+DseGy4Heuh0cxOglDVxuWjtYwU4bI2ffCEND5+P9XQ==
X-Google-Smtp-Source: AGHT+IFykikG05A6FIfUfj6dC5zqXw1kDM+wSIizc/FZisl7WKKVtJFV/fgamnXt7DR6w1KSHIAoxA==
X-Received: by 2002:a17:90b:57d0:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-30a4312b904mr3036583a91.2.1746093730247;
        Thu, 01 May 2025 03:02:10 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:02:10 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] dt-bindings: iio: adc: add bindings for TI ADS1262
Date: Thu,  1 May 2025 15:30:43 +0530
Message-Id: <20250501100043.325423-6-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding documentation for the Texas Instruments ADS1262 ADC.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
new file mode 100644
index 000000000000..8c4cc2cf6467
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ADS1262 32-Bit Analog to Digital Converter
+
+maintainers:
+  - Sayyad Abid <sayyad.abid16@gmail.com>
+
+description: |
+  Texas Instruments ADS1262 32-Bit Analog to Digital Converter with,
+  internal temperature sensor, GPIOs and PGAs
+
+  The ADS1262 is a 32-bit, 38-kSPS, precision ADC with a programmable gain
+  amplifier (PGA) and internal voltage reference. It features:
+  - 11 single-ended or 5 differential input channels
+  - Internal temperature sensor
+  - Programmable gain amplifier (PGA) with gains from 1 to 32
+  - Internal voltage reference
+  - GPIO pins for control and monitoring
+  - SPI interface
+
+  Specifications about the part can be found at:
+  https://www.ti.com/product/ADS1262
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1262
+
+  reg:
+    maxItems: 1
+    description: SPI chip select number
+
+  spi-max-frequency:
+    maximum: 7372800
+    description: Maximum SPI clock frequency in Hz (7.3728 MHz)
+
+  spi-cpha:
+    type: boolean
+    description: Required for SPI mode 1 operation
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO specifier for the reset pin (active low)
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC reference voltage. If not specified,
+      the internal 2.5V reference will be used.
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
+  ti,pga-bypass:
+    type: boolean
+    description: |
+      If true, bypass the PGA. If false or not specified, PGA is enabled.
+
+  ti,data-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description: |
+      Data acquisition rate in samples per second
+      0: 2.5
+      1: 5
+      2: 10
+      3: 16.6
+      4: 20
+      5: 50
+      6: 60
+      7: 100
+      8: 400
+      9: 1200
+      10: 2400
+      11: 4800
+      12: 7200
+      13: 14400
+      14: 19200
+      15: 38400
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - '#address-cells'
+  - '#size-cells'
+  - '#io-channel-cells'
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@([0-9]|1[0-1])$":
+    type: object
+    additionalProperties: false
+    description: |
+      Represents the external channels which are connected to the ADC.
+      Channels 0-9 are available for external signals, channel 10 is AINCOM,
+      and channel 11 is the internal temperature sensor.
+
+    properties:
+      reg:
+        description: |
+          Channel number. It can have up to 10 channels numbered from 0 to 9,
+          channel 10 is AINCOM, and channel 11 is the internal temperature sensor.
+        items:
+          - minimum: 0
+            maximum: 11
+
+      diff-channels:
+        description: |
+          List of two channel numbers for differential measurement.
+          First number is positive input, second is negative input.
+          Not applicable for temperature sensor (channel 11).
+        items:
+          - minimum: 0
+            maximum: 9
+          - minimum: 0
+            maximum: 9
+
+      ti,gain:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 5
+        description: |
+          PGA gain setting. Not applicable for temperature sensor (channel 11).
+          0: 1 (default)
+          1: 2
+          2: 4
+          3: 8
+          4: 16
+          5: 32
+
+    required:
+      - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ads1262: adc@0 {
+        compatible = "ti,ads1262";
+        reg = <0>;
+        spi-max-frequency = <7372800>;
+        vref-supply = <&adc_vref>;
+        spi-cpha;
+        reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+        ti,pga-bypass;
+        ti,data-rate = <15>; /* 38400 SPS */
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+
+        /* Single-ended channel */
+        channel@0 {
+          reg = <0>;
+        };
+
+        /* Differential channel */
+        channel@1 {
+          reg = <1>;
+          diff-channels = <1 2>;
+          ti,gain = <2>; /* Gain of 4 */
+        };
+
+        /* Temperature sensor */
+        channel@11 {
+          reg = <11>;
+        };
+      };
+    };
+...
-- 
2.39.5


