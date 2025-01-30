Return-Path: <linux-iio+bounces-14725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40ACA22C33
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15E11887BB6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D551DD0C7;
	Thu, 30 Jan 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IEbIpXJu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD91C1F04
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235333; cv=none; b=CXHmrY1JRKP4ROVq5kkSCRgDZKY6F0f4w9SN9W32jpuOHzsmi2YBHVom7b25KLd0Rmsjrn4D0PoqVrT2p1vhQh9xlHN7Zc3Iz+z2W6G980nihidX4jujpUZeRP5M7iEGgIdGMD0k+ZZtnXlKRN5/b6hVs1U990jWbWh4e7/5mD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235333; c=relaxed/simple;
	bh=xfmK9s8wId2Vg1IQl6Wvtc/c3d0ihGH/76shMd85zP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBdAqixsvT1GcxgpTovBfljjJ/J+fST9qLhIFYKDjLUP+DkoejBhpy9iHpscwv8uRmKJpxRs+4U27mjqYt5FeI2XQMqy7QS3Uyv7yGRSmHqnLpRc7FRvLQOxGrigR/z6FvZ+bA/83hRTkBSBnb68pF+9tDFbSwWqJCXyh02BQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IEbIpXJu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283dedso6617665e9.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738235329; x=1738840129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9AMklAJ2Mv53cAwLoH966kOiYauexcFeYWldqeYOxc=;
        b=IEbIpXJu15CoA8XR4FkAjKXdd156y9xWwaCxI93cN2E8nzzfL3o4kif+KsCYyGG/v2
         vXcTh8exLAY8krGXKDL1lYefSPlrNNeUg/EavtkxUQ3VyztBm9mWB4vHgwVzD65ZRFKv
         pQoD3+6tSF977bYACnHKPBfhSwQnGlrVhgKP6n/K227nNX6pdyaLqvbonsMHG9W1o/T6
         OOu1H/VT7H82EXhXgMWD3PS92DW3Rd25e6nwXZJvIL5EYn+YLRikroHNvWAh0XZl35ob
         fCZBiEIy+05ACTAi2sB6HwPbu06F6Ek8UBEUurrCPxu35GaX9DV0M2QmsjtLdJpGtIrv
         4Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235329; x=1738840129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9AMklAJ2Mv53cAwLoH966kOiYauexcFeYWldqeYOxc=;
        b=ETchIRIfMjAozjv7RYZiEgPuNIJKKoUVXQCwZ4Uuc50wwKqjtqEZ82dUYJgYc50YPR
         4nvWHbvDfzcX0WLWjDySkMcaMcAZ+qJx9YneAaZ3HJPwxKIwJmTVtNsvv/3Kn26CYx6E
         zY8PLjXzR1xNICzw9DnYKoaevjvAe5XqFt+2bNVTTm+gFkvLTtZUqPC0wv/vfoFzDDFM
         SSMmxGFhikTIGywjoeGwrsUayIyQsgc20itpZiqMSwSUpUS3zrFLpQV+J0cK+1kBq26f
         0QWon6KyovdC2hHn0faYU1izw3AM3Mj3irY2xDESNqeEylbFGcOtWni5Vj7tsLWOe4n4
         o1mg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ds2hd1P+xKglAjV90iK6iM6vMHy7CFbLYKak9uO9zY7/ePwYuzaZsPZKs4f+EpmmwEaFd1Tgkck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoQthuOuDb1GXz8VKFtr7xPStYUxsg6hKvTM+hfQPM2+HBfe0
	WjQG4O7X+wBu/qhEcGLl+yRw77WU8Ax/ejRyYCd1kQM6OsEaMgP+/VED2AmIfUc=
X-Gm-Gg: ASbGnctLBYjA6FPR44OPvlWU8sw0siy5qKGUQSMhQLH6yTRyfxWBUcPpANvd6BYM9XC
	QrFxgOZ16xzAupRDXVSYZ/7n+BYmXPS9C8YRtVBDDMrNioRbPJMTwLK7WgkhTmRxtzCK624/AhL
	pd8gpaPwWZcXj26fZZ0MeFZbWvuFjZE5v4iwZWfcgEjOjN60MxlOp7UIhWG2YuQvmK2OGBrw+XB
	62Cr2P76u5eLiM3Cq7zcFh2vTpSOnKM3D6K3Wk6YId9fR9BN99plHZ5YQCbTHX4TAd7wQKXq1N+
	U0VZC1UQYNVJTUmi
X-Google-Smtp-Source: AGHT+IF4C6PETkPaH4I7nCwN4mw1AiWHPGhyx8nc+XH1k37/4DHFRk3X1oY8Wt38ieaKQpsznknZnA==
X-Received: by 2002:a05:6000:1365:b0:38a:888c:a727 with SMTP id ffacd0b85a97d-38c5195dd2amr5217524f8f.25.1738235329359;
        Thu, 30 Jan 2025 03:08:49 -0800 (PST)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:2c72:cd2d:79b2:82ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102bb2sm1689225f8f.34.2025.01.30.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:49 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 30 Jan 2025 12:08:25 +0100
Subject: [PATCH v3 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630 and
 ad4632
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250130-eblanc-ad4630_v1-v3-1-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

This adds a binding specification for the Analog Devices Inc. AD4030,
AD4630 and AD4632 families of ADCs.

- ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4032-24 is a 1 channel SAR ADC with 24 bits of precision and a
  sampling rate of 500K samples per second
- ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 2M samples per second
- ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 500K samples per second
- ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 500K samples per second

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 111 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cef2dc1eefb9126f836794c742b9e471a847296a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+# Copyright 2024 BayLibre, SAS.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4030 and AD4630 ADC families
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Nuno Sa <nuno.sa@analog.com>
+
+description: |
+  Analog Devices AD4030 single channel and AD4630/AD4632 dual channel precision
+  SAR ADC families
+
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4030-24
+      - adi,ad4032-24
+      - adi,ad4630-16
+      - adi,ad4630-24
+      - adi,ad4632-16
+      - adi,ad4632-24
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 102040816
+
+  spi-rx-bus-width:
+    enum: [1, 2, 4]
+
+  vdd-5v-supply: true
+  vdd-1v8-supply: true
+  vio-supply: true
+
+  ref-supply:
+    description:
+      Optional External unbuffered reference. Used when refin-supply is not
+      connected.
+
+  refin-supply:
+    description:
+      Internal buffered Reference. Used when ref-supply is not connected.
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). It initiates the sampling conversions.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      The Reset Input (/RST). Used for asynchronous device reset.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The BUSY pin is used to signal that the conversions results are available
+      to be transferred when in SPI Clocking Mode. This nodes should be
+      connected to an interrupt that is triggered when the BUSY line goes low.
+    maxItems: 1
+
+  interrupt-names:
+    const: busy
+
+required:
+  - compatible
+  - reg
+  - vdd-5v-supply
+  - vdd-1v8-supply
+  - vio-supply
+  - cnv-gpios
+
+oneOf:
+  - required:
+      - ref-supply
+  - required:
+      - refin-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4030-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 0fa7c5728f1e64d031f4a47b6fce1db484ce0fc2..01e76f76b051b566b0aed48011621e170f192a2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1273,6 +1273,15 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 F:	Documentation/iio/ad4000.rst
 F:	drivers/iio/adc/ad4000.c
 
+AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	Esteban Blanc <eblanc@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.47.2


