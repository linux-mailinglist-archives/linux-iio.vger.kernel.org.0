Return-Path: <linux-iio+bounces-8684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C395B544
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CC1C23290
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C01C9EC3;
	Thu, 22 Aug 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sezSUqo5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677701C9DFF
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330751; cv=none; b=DkqF6/tlixPlvafzcjiPxOzfhB9SH8Ao3s8Ap7IwbxzM5noGiwjoQjMoKltGaK69hSysRNPGw1zJ0dBkSCvQ67PvoZpXd9uvmUDyYyZECkjmrmPR+GsHLQMiaS9InMSyc1XCTeE0J0SMvVeCXlxrm9COyIZGCjfesYKkNlkasII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330751; c=relaxed/simple;
	bh=fyqXqsZjJrEeXJfQiseBAtwVBgxOvF2ECKQScWgEPdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frXWhdNM1PrQRME90qCKl4MMrf/3qwfPu7uRbwU2no97zlX+40vSA2VCUgQKqQJYILQweWXqiXNj8dxkm2yh3melDcz32rj5V3cxENc2YZ2HBGmwnXN8F0A38sfzTmQK8cOieRsJK8Fbcx0WVTXTnhyv/KeqZq4h5KJgIoUfQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sezSUqo5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42809d6e719so5441365e9.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330748; x=1724935548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBGPvhHLvlJuvRIFNEnpskRGdh1NE27Q73tLCnC4f40=;
        b=sezSUqo5dUTHtUFXhoYWecCnSb+hJVoHVMUcxbwNnxoDHSZEtRVKr9p+g/06f/StWw
         hP9upJfvd532zEgpQiXrWGXx9TvHDugQ0kZw8OTbh+8hb6wkSeG4eL1zlsXwkdMHa6yq
         3ftrf+bUpEaA77b86v0+ZAFE9T6H/4zyNR6ngsdI7IqfVHQusTkim38xXRd4jcfQCZ5E
         Q2LO9ri1D35rqmkMbAjuw6zkGeRFPhtqte526iYzJZaTg1DZyj7S2rN55z/OURdYrbmD
         Gqkc3t4h13/sCYX49Ym1nmxUmSlQjOdrp9Y7I6C6i+NUWEl1+JseQUfwabJM6yNCXn3C
         Nvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330748; x=1724935548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBGPvhHLvlJuvRIFNEnpskRGdh1NE27Q73tLCnC4f40=;
        b=rjOkhiv7TnurrkmmT15L6CD7pMqmncgc7ECcCdTXhx2kFXNn2NCZYwQvMAKxnz66Ex
         20u5rdlJd2Mhull4Nc2k49+ZBrj2IAUNobJGNKRejd25Im5k64HbNGIaT9JkylRx0gQs
         r7dBbUQZcz9joVf7gAdhso6RCgwp+ux+0CXGDIf6EHalCvHWWSBaSPZHhLW7OZdWvTNv
         ZRE5yRs60fyzTaBFlQFrcyXs8DsgR9Bcg0kZOVY+b2uUJeZlzjLfnmYgVOBqcUFkGfFz
         5Vga8kxMyoTt1F2FlY4adiRFWbFqK6ci+SiVQ5DPWc7UB3YnTfYEl/PMxlwrIV2vtISf
         fP1w==
X-Forwarded-Encrypted: i=1; AJvYcCXemcGbCxQ4iw/ijcrkM/6PUG+16+1nMcmschtbNz0A7mdi+AfYuyOFYdgjRbfe2gJ5Qsd9JiQq4lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzDkyeq7B7leOHCuv+ZqiBmh7aposIoIDLOIyCZ+1qo7ZrKFp
	101y62bgZUv0+p1SK5E033+serAaAcfkkxL4tUfkNnS3Yrx6nfUrsw0KT1+Tq5Q=
X-Google-Smtp-Source: AGHT+IGLddsqdBqwYxq4wvo0WyS+Tg8NBcgZQmI1jPpH0BHxiDNsCxrgTGTIbmcMHWcZGs8SoH6vsg==
X-Received: by 2002:a05:600c:b4c:b0:428:2433:1a07 with SMTP id 5b1f17b1804b1-42abd264786mr37820265e9.34.1724330747784;
        Thu, 22 Aug 2024 05:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:47 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 22 Aug 2024 14:45:17 +0200
Subject: [PATCH 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630 and
 ad4632
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240822-eblanc-ad4630_v1-v1-1-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330730; l=4807;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=fyqXqsZjJrEeXJfQiseBAtwVBgxOvF2ECKQScWgEPdw=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAj1q4EMIcf1j8mI9ZLN/B2YN8M0n
 7krasqxgoc5GlCcQDKWm3N4Flp8PDc9j0e5w6bNV0XPDkeSypx9SoLCQZOFZb6LUTDgPGpjSZtJ
 YEc1uGWQk5b+nOwBtLw9HP3yryUY9DqD2aC9jvU9fl/T2wRBW9E6D+9on0JD0MBtx+KaaeMBhE/
 5U0UuzKrbHsXiXx4EffqorAeDmu8ZB0Q8/CPTCk8+xDKXkSpHXTgv+1fG+8M1O8b58Qc/P19U0l
 Lv6j2JEd6l52SIoFO2UNZW9eWZ10pTKfdckx1KGCbKm2vPUX2FhWunBphKn4zDYDO5hZRedBIuu
 bxf84MGZWf+rulgNBbbhWdGW6YvOCCpfj5glnTpT+alb1jTmwESlkD0/R++U4rfE+8jWJ4xT8SL
 LHafmaYUI60z1MJOJAQmuT811M5tiHFvCRvB1hgSnpRv+c+Yvhg5WSDta+gLDdU3Ahazen2RouP
 gGhHYPrRPHoEyqQYfHn5MWBbPVVGFEhBCyjE+MO5aZn21zbZfkuNVwfOdHNbLbBJJXH6OovedCl
 cbboaFyh4TQhNdS7EjYk5Qja/M6EBxMnrwg4bE4qKmbLq5S6uqB7k6M0zz9pQjXw9fnPxwdDsa5
 KgADJ2K+hVrCBjh54bUEtuvYEuBtmvEFjh8WGmrpNJbyNNMvKtwEP3mI=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This adds a binding specification for the Analog Devices Inc. AD4030,
AD4630 and AD4632 families of ADCs.

- ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 2M samples per second
- ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 500K samples per second
- ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 500K samples per second

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 113 +++++++++++++++++++++
 MAINTAINERS                                        |   8 ++
 2 files changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
new file mode 100644
index 000000000000..7957c0c0ac7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+# Copyright 2024 BayLibre, SAS.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4030 and AD4630 ADC family device driver
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Analog Devices AD4030 single channel and AD4630 dual channel precision SAR ADC
+  family
+
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+
+properties:
+
+  compatible:
+    enum:
+      - adi,ad4030-24
+      - adi,ad4630-16
+      - adi,ad4630-24
+      - adi,ad4632-16
+      - adi,ad4632-24
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
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
+  cnv-gpio:
+    description:
+      The Convert Input (CNV). It initiates the sampling conversions.
+    maxItems: 1
+
+  reset-gpio:
+    description:
+      Reset Input (Active Low). Used for asynchronous device reset.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The BUSY pin is used to signal that the conversions results are available
+      to be transferred when in SPI Clocking Mode. This nodes should be connected
+      to an interrupt that is triggered when the BUSY line goes low.
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
+  - cnv-gpio
+
+oneOf:
+  - required:
+      - ref-supply
+  - required:
+      - refin-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+            cnv-gpio = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 417c6751c0dc..f17c42bea19c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -413,6 +413,14 @@ S:	Maintained
 W:	https://parisc.wiki.kernel.org/index.php/AD1889
 F:	sound/pci/ad1889.*
 
+AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	Esteban Blanc <eblanc@baylibre.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+
 AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
 M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.44.1


