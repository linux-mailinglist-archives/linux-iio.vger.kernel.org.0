Return-Path: <linux-iio+bounces-13740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4C9FA188
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64873188E52F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA581632E6;
	Sat, 21 Dec 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic0gLw6F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123F1514EE;
	Sat, 21 Dec 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796788; cv=none; b=BLccMi0egOcp+XHErTyCc3cqarPzVq2rKoPC9WtfKUwTujhkF7+RdoYDvcPMwHJD88wCvlWNXC6ve5BRG55pYfex3k9LKQSAwT1DEF3luFKOnKj554qm+48mDqVshqoVQh/EbrdgPUxNysQkcntFHgTIQ7MHC7BST4b29E9aVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796788; c=relaxed/simple;
	bh=BWRo00L4YOq659NAOqch2NdNSSUriQZWcRXZbX7j8S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxMcMWeFgGLN+N2nlm42h7IdOnxUyFEtsLa5gECQEFFTCkBx7Kww/TzahD3YKTd7eGWHuqBbLUSCHBZMds8dgVFUcHZaKKT6wKEm74GZ8yGlR1qSY2YKtCTjnvsGZVEGZ8qxrTV4c1yDBS2FP6T7cBPRrJgMmuaOFbkz2FIo9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic0gLw6F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-432d86a3085so19601995e9.2;
        Sat, 21 Dec 2024 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734796784; x=1735401584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQr77TH9VYWfmDTvYOTdxgYPOzNN/LBkXMrm7mrcnPw=;
        b=Ic0gLw6FLGzMpHWxMvSa20lcvaJvEzjaMUtqUR2hjUlRcHB7ZtD4CHja+Rk15YnJzN
         p1wYv3CfhmUMa+bnFB4VQNKHuHrMJ+IhrH1aL1zAO/zDbo/y6iKRNRxA2wKDhyxP4ZAz
         s/B0sH6yWFwQalBOyjIGMXWDRxSnYrIKAsmHt9f36O9KbpUOsKSRnamtPdGZemG8e/IR
         A3xm7Lwf+96itrjJialSy7O8AT+mxJ4j0WgfSP4qeaK9lZebUMjA7xVs9N23LhEMng5G
         tU7Vrc5nhfV5+GxDr2nXb/3UZWtpUckAEXktCKMLwGhlQLJ2ULly5HOmPcGsPMjlrnen
         Xfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734796784; x=1735401584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQr77TH9VYWfmDTvYOTdxgYPOzNN/LBkXMrm7mrcnPw=;
        b=F8wHEu8yVvn7msJ2p0FZs/EPI6yGC2VXB19KPm5465Y3fu+DcYkLIMVDB+VP90ibwP
         /NogYU8QBZX9+IB9ylyWkx2/DwX9Pdo57+8SYdtuUmSBi/WY9UUNfWRcU2ZPbTgihJWt
         2f46Khjl+SToRk4lznSf8BxM9krWSjeLAcWzstOaUacOtr0MjJmNjWXh5Cdo81z5wtm1
         2F+iVwOEF9ERMluArnGpI+SlWSg6SiwksFFMlosiuvZcWE9afAb/k0gkWGSRuG8WiYWK
         Vjlwi3+Bo6bmKbPi4DjLrDsLP/o5AU7dBKtRhalbH+7LY6iO+dWNOzMqayKRzMotLStD
         5YzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU13zgOdw5V7LQua84tTY9bP8bsNWc22coTH78HSq4a6dkra0v22sz3GfILKWLsJwTOxpkw3CRP46HxuOdT@vger.kernel.org, AJvYcCV4Alino9FBFDR0ENlsQBEIUKLjuWm1DcJ/Wv/xB8k+LYfhLHbrdfO1gJAVYHgDGd4dkhzps2KcUsIh@vger.kernel.org, AJvYcCXY+fFcYN4tSl+MwTONvl92xVFqLHvDwxd1myLqeb7JBs5tekOK06/PLTh7TWnoEV/zOjPCXdhy1DcS@vger.kernel.org
X-Gm-Message-State: AOJu0YyIiGmiHLrEENXuZ7yMPUB1EcIOG16Dpa5fwLLYBtHFVYSdfube
	7PIi9ffTjP15/sXOIGIPjaoFQGJTQWefG5MWNm1tx9X1FW55PIhX
X-Gm-Gg: ASbGncvHxcCgi9yKzey4M9gDbVi9EKp686tfhgzWbPqomJ8PmjNpH4Ttk3ucN3kDFnG
	8NZQCqCSMXi9nUujoKXrKqI/uTvH1KryABySmcy5rNSEQG/QT53OjeueMkrTpsXZgyj11VvG51S
	dtloxp8fSMA0acWaJQMq9FNEDl46JoQw6lymmmlWUkSHv0IDi8/vgA0RNdIB14eKGJzgEO28WSj
	Da/WUG/aKUxKAUJnVuJuJP+TegLfTQP1BZw7jr7RJ0Mu9ZI6WIa1OR8
X-Google-Smtp-Source: AGHT+IEwb8qFwuKRp4K9PQ0deZY1vviG8JCNj3TeJyywMzWKY+jDPcVqbfCZ0waxAaO+P91gbdiDkQ==
X-Received: by 2002:a05:600c:1550:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-43668b5f6a5mr53903525e9.26.1734796784286;
        Sat, 21 Dec 2024 07:59:44 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:604:8900:a4e6:d95:2e66:864e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8b874asm6751081f8f.109.2024.12.21.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 07:59:43 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 2/3] dt-bindings: iio: adc: add AD7191
Date: Sat, 21 Dec 2024 17:56:01 +0200
Message-ID: <20241221155926.81954-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221155926.81954-1-alisa.roman@analog.com>
References: <20241221155926.81954-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
designed for precision bridge sensor measurements. It features two
differential analog input channels, selectable output rates,
programmable gain, internal temperature sensor and simultaneous
50Hz/60Hz rejection.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7191.yaml          | 128 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
new file mode 100644
index 000000000000..f3e596918c22
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7191 ADC device driver
+
+maintainers:
+  - Alisa-Dariana Roman <alisa.roman@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
+  found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7191
+
+  reg:
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  clocks:
+    maxItems: 1
+    description:
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply:
+    description: AVdd voltage supply
+
+  dvdd-supply:
+    description: DVdd voltage supply
+
+  vref-supply:
+    description: Vref voltage supply
+
+  odr1-gpios:
+    description: GPIO connected to ODR1 pin for output data rate selection
+    maxItems: 1
+
+  odr2-gpios:
+    description: GPIO connected to ODR2 pin for output data rate selection
+    maxItems: 1
+
+  pga1-gpios:
+    description: GPIO connected to PGA1 pin for gain selection
+    maxItems: 1
+
+  pga2-gpios:
+    description: GPIO connected to PGA2 pin for gain selection
+    maxItems: 1
+
+  temp-gpios:
+    description: GPIO connected to TEMP pin for temperature sensor enable
+    maxItems: 1
+
+  chan-gpios:
+    description: GPIO connected to CHAN pin for input channel selection
+    maxItems: 1
+
+  clksel-gpios:
+    description: GPIO connected to CLKSEL pin for clock source selection
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - dvdd-supply
+  - vref-supply
+  - spi-cpol
+  - spi-cpha
+  - odr1-gpios
+  - odr2-gpios
+  - pga1-gpios
+  - pga2-gpios
+  - temp-gpios
+  - chan-gpios
+  - clksel-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7191";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7191_mclk>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            vref-supply = <&vref>;
+            odr1-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+            odr2-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+            pga1-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+            pga2-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            temp-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            chan-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+            clksel-gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e5167443cea..254fbfe6144f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1302,6 +1302,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
+ANALOG DEVICES INC AD7191 DRIVER
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


