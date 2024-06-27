Return-Path: <linux-iio+bounces-6983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF391A5F0
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCE1F23220
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3514F9CF;
	Thu, 27 Jun 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mj2vNRRZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4B14EC7D
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489580; cv=none; b=Yvj1RRJ/7PuVZbV9b5rfmQ7HbJQwvDH+YlXsuUSuqAuTFWz7veIZCCZMtD7P1X1Qv9Eg7u9vBAJpMCKiavtM/rKDlusHCK6INzXyHqP1oTW2erpaMsyi3e3flc+P7/pLRnJDCO5YPQLPmQL4wat3p/ZQZ+l4lB/GQDIKznm8FGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489580; c=relaxed/simple;
	bh=zDhD9bMPssS6E/uk1KXM8mBkXmjOeauwiaHRs4sJQbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTjzCPqVBKypm3in7dE+HFKQJMf81ODk1EUZY8vkdRW1uH/8h/hpywiPWNWOlH6h16QHfnuUvmI3YyhicT4Fk0P6Tgt7WtIOia6XnZt1m5UfqdDXhFqnuLI7pdDe+6df6M7F1QNKjdW8Fy66qYOmalTLNYtgM/ZcbY+XFJkMf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mj2vNRRZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42565697036so3253035e9.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719489577; x=1720094377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKhxvQFyxUbiQ3O/bZb97hQPbbd79z6UzvDpDY1X4gI=;
        b=Mj2vNRRZWa+ItNVb9LTHiLaxHZHOcp8NJv5DHfRmnuwoQbOoMX8Fy4mWZb5LPA/rtD
         tSQ7wp9+02/iUgczz9HME5/f3vwTW3ps32/BaXvu8ekeGkRvb5wBPPXXbFcqclrpgMA1
         2Y9b+hEyQnbKGr2PIHhY2fhOGSKqphSM8Q8YCMXlGvyRYzZCYvnV6La5irb4mzfES1oE
         B7dBQpWOs30r64I6BBA7LdBkWBvo9o7Klx0f7gijOUmYid6JAfeKDyfpuVMRA74RtA7v
         8sDPOnDRUGi0uCdjcrInTpEHM6YrjLfqkCCIt5oVnEM6OH4OyA9zHwxgnMQUfJfFQFKH
         qJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489577; x=1720094377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKhxvQFyxUbiQ3O/bZb97hQPbbd79z6UzvDpDY1X4gI=;
        b=Jba3PYZR0aYLX89bWtQ7W06a5vS5OXaxlmY1/vwp8KgrmlwtyABIxLHC8yHFAjYT+h
         7uutww2fsoedE5tjmRgZT7HWzdhyeAWav0KdssU48rLDo8Eceikyc/mgcUfmWalfnNc7
         zabOrwpZcNMGJUyMq7PPV2pVmrY5oEeUOZ29gYTkAVi+kvtxSC4Q1IJPVDEzrLhljr4R
         LWr6DdB/PXWgyWQMiGji+GQRBOOZDwO4ecgk7bT7UGfwY0+EH+N0EMsy5idn3mvOu5bF
         60G+1zvJ/axVUNk4Tr3oFiLkClcJtgrgf/COUGWSV0pbXTj79GpdJxeyzlSP2BUii0Pn
         CHKw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxhQ+/Vv474mj7usDMdqaVsg5FCxVdG1tgZMR8CBr0QZJGmQ75lnO54shdAkYZAiDqKxxU13Il+YiLIbR3Dg1axIMgB4Gal+j
X-Gm-Message-State: AOJu0Yye2vRkK8/ob87bwtf4uXGO0vDHTJtlzggU+E+PvkeBUMK9ZAY8
	6Nd/d9muCHt6zu4uTi/keNhPWCIHXExWqKKVNavQr9qOhrDfsLQfZ5myGqUoEqE=
X-Google-Smtp-Source: AGHT+IFvoQO2FFU7vOq7UvighAzf6vFsBI8EBDZpoaGx6tWGnI6YdHfxuwSKF4zrlVUXj/CYk9029A==
X-Received: by 2002:a05:600c:2e0b:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-425630daf0fmr22792665e9.4.1719489577043;
        Thu, 27 Jun 2024 04:59:37 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:4435:7af:3956:8dba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82462a2sm63473585e9.2.2024.06.27.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:59:36 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 27 Jun 2024 13:59:12 +0200
Subject: [PATCH RFC 1/5] dt-bindings: iio: adc: add ADI ad4030 and ad4630
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-eblanc-ad4630_v1-v1-1-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
To: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1719489564; l=4239;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=zDhD9bMPssS6E/uk1KXM8mBkXmjOeauwiaHRs4sJQbc=;
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
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAqPNxWWUrycEJ16KriHB+hh8ak3Z
 azUGK3SNkFl+EBSCY/5UqmwcgWnP9a0DbXJNSOiFpGf8CaW+sLez+H1DSQNH861/x3Gnufw+hfZ
 5I7NLEUnxpnA9W0OWhJG4oAlvLO7VHfUC2+aKc2ySqofVTlIYq/bXFUcW2GHDwRezgbgWJuBcWv
 D3Iy+uiIyjXrZmmIzkyWOkI4vQKkvqGKVN5PfIHB/shx/Kj/9LYgHx5J12SGET4gqCNixSKcV/I
 aLy+OYa763NxRpjhJyMoL5Kn7yzfRktByocApqAOFIa8u1er0ImnkwSBMuPkTwJbepGu0GXpkG9
 lINlVbZGtUlq/8ReVKq7W46Pws/uL8V82yuUxERm8BDxCZTyVqgImSTql4iYgG2zxBSZIVsrGWK
 I75Wln/wxfwyxl9kPMrc6kHNdv/UslNRZ58ctFNisayyOYefzgEkglyUlK+giaAQOV8xzSdO2FM
 8BAv3S4wW65zt4NYbTTWpEfL27Qqoz71wHZ+ftu2nsyPQywcgZLOVI5sPswXZX6OgJL+UzndrIP
 SQ+XkesIaZGoimlbNjWhGxjj51GgWYlBhLRRGCbR2KVlIqPkPyy1rF4rxIoak+/a/GnWx2JXjow
 7vd2lBcAtCuAYRvjgFqvKQfHvmSNmzep/QNmyklZ2dDL7BYO1ucQDimY=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This adds a binding specification for the Analog Devices Inc. AD4030 and
AD4630 families of ADCs.

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
index be590c462d91..8ca5b2e09b69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -412,6 +412,14 @@ S:	Maintained
 W:	https://parisc.wiki.kernel.org/index.php/AD1889
 F:	sound/pci/ad1889.*
 
+AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	Esteban Blanc <eblanc@baylibre.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4630.yaml
+
 AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
 M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.44.1


