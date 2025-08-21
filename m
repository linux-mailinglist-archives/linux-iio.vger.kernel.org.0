Return-Path: <linux-iio+bounces-23105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18FB2FB2A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D96F188AB6E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D82DF6FE;
	Thu, 21 Aug 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LySTfn6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0D2DF6E3;
	Thu, 21 Aug 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783540; cv=none; b=V/4oXk6Gd8SfLzb0NAHdQ2UJPvFq3c2aZ8Y2Yp/36RQEwASIbqGcyAXg7zArhlK5L+3DQE8t+vGzl1/X0VucF0I8GYDV+tOcce9vbSB8lCmM8VQUt4IOn74B+mKPBEgmz9JNoxsEmxZRY6/L2JSLCGPgITUbmZERLXZV69aSJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783540; c=relaxed/simple;
	bh=vNxmtOYWyGVlY71wEigPlq9/vwDTFMewLOFRAJfjS/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4bmr8Z2in/ZZ+6Y20XuDYzrHNYq0AxVYsE1ExndQNJ7BbQ/xvUevzMYmVR6usy2NVmz9LyyCRYrQU9skOWaRwGnoaU79OF/P7YYJP9fGGkwYa1IqPrQ8K/nUjur4OhjFoCmtuLqUvpiV1Zto7IdZtl7YfIrX9E3L6BjJDDCGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LySTfn6Y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso754566b3a.3;
        Thu, 21 Aug 2025 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755783538; x=1756388338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC5HIeoKlqWIPDxGYt100JjNVUchz8i0fd74NghcA18=;
        b=LySTfn6Yn0dV+79XWzPti0G746ZYl1CQsU7guB0ZK9Zgtxa9X+0bcXPp474GhcR0HO
         P3Frz+9pTqjvir+O1O5KnwQzxK2r8RtfLYf2QIzmbFQZSGDCzELtFFuEOTWoFKcHoz89
         5HdqvCIzYMl8AMF04A/u9dY1lKmRzoOvOgaAnWbyye2RbSq9C5HMkYBXuf2NpG0IMUgb
         gVAI8UL8UXHF4VywzTUA9AV76w2e952bywfOn5Ra33pwdqvBUZuY7ipjCZIl77QgRVHv
         lZ5f+zr4H8oelfPJwZjQN+HdO7GJXvayR3FENYwnSakLUsbV188b1aQLiPsIlLAVVieL
         eePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783538; x=1756388338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WC5HIeoKlqWIPDxGYt100JjNVUchz8i0fd74NghcA18=;
        b=kibPWTX5htyHP6uzjjq1kUeCvUnqlxDNPmuRbLMsoQ1G3feQmwG4YpTCiVB1G4xbHm
         aOVwa3qZqmUD1nR8CPxyi7ZjQb43AsSrarzOIRd7VUhuviDOgcmKP/+Cgzu8hhg9+LXj
         EF6lzFY2+tHrbOIUoMUunza//hdg2R/8w45cODIxUaozb4lmKictxmEXuoBKNecOcHbb
         u05AGXRGEjKQ1zpCEHwZtAbY4hg2vekpxSjgoRCjB3PW31bQqJcwynNLdUP1PNVB26OX
         0s9On76yalacMj25e3wD+Y3xkUdgNfkqbSf6oGT3B6bhMxnaGy5tjrs1tsyxGpA/ACId
         HqVw==
X-Forwarded-Encrypted: i=1; AJvYcCUe5pfGJmp9c71Hz3xEGFaVE12csUxutlhN18hzjdKMs5NtfV1ss3//FmtmisRWbHO7siOyW8se5QpZBc60@vger.kernel.org, AJvYcCVq7YW5S2uI4oVxu3Wq0OORWZjJWyzZvm3lTZ8M3Jv+X17/TIP12Tzi3Gn5WvRiqkTXXYwnWE47Ozwk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4B3CgzOxvM2uA23lCNVHCp/HGn2+QJXzO9nr2RjA0zkx3WKs
	2BgFPNktkBM1Ovxm6j5p0TRRGL9vnG2KmczS9HcQvVWg3OwOf1JTr2CA9zOFDeEZzi8=
X-Gm-Gg: ASbGncvWsHBet4YS8QNGWqQA6rGAL+plxO+/iDj3VFYa7fZiGp4YzGM4msCiSajcfWL
	TntjGKDlDgaShrRMbv95B8AtwxyRiWK2AThsXJKmzd/DtEvP9PKbN+rn9Ndxs95n6SyL0Br/A0I
	8LpQpr4iUeGXqugy+ioFsWd8rOz2BhPn8lNh389201oVb3p+Gvy0/mYKBQ7OpIVQwR8YlGsRsov
	h+K9IigVbw8Y5lgFjokdzJlloUXFoOEoWrCOo0dc4XOUru0LpJGAQS5I0Di7gmmhrBSXCXr0UA6
	S1z4H+3tTyE24BLH1L/iYmljhuXhMiBO6+B7GxrVED2ZkzG6cF5Jf5RW2VechxEtYjIDy1ayRZ3
	aOjEj/2R01zwuKn9SFAVuZOPiYxW6tfDjj7YMWGZ1MvPuOw==
X-Google-Smtp-Source: AGHT+IG8pKkKE9A/JIwVakm04v0QUopDZay2Ywry025O2igO65hDaoPh0fCNn2egyt6qIboGQ5OsFg==
X-Received: by 2002:a17:902:d4cb:b0:242:fe99:eb20 with SMTP id d9443c01a7336-245febd9ae5mr28021135ad.9.1755783537666;
        Thu, 21 Aug 2025 06:38:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:9c08:cdb4:8bd9:b0e0:e77c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm55816325ad.128.2025.08.21.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:38:57 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add MAX14001
Date: Thu, 21 Aug 2025 10:38:29 -0300
Message-Id: <6690320bcf9f0b8a5bf58048673e4f6a884c724b.1755778212.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755778211.git.marilene.agarcia@gmail.com>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree documentation for MAX14001/MAX14002 ADCs.
The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
converters with programmable voltage comparators and inrush current
control optimized for configurable binary input applications.

Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---
 .../bindings/iio/adc/adi,max14001.yaml        | 78 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000000..3b2a2e788a17
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Marilene Andrade Garcia
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX14001-MAX14002 10-bit ADCs
+
+maintainers:
+  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+
+description:
+  Bindings for the Analog Devices MAX14001-MAX14002 Configurable,
+  Isolated 10-bit ADCs for Multi-Range Binary Inputs.
+
+  Datasheet can be found here
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,max14001
+      - adi,max14002
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Isolated DC-DC power supply input voltage.
+
+  vddl-supply:
+    description:
+      Logic power supply.
+
+  vrefin-supply:
+    description:
+      ADC voltage reference supply.
+
+  interrupts:
+    items:
+      - description: |
+          Interrupt for signaling when conversion results exceed the configured
+          upper threshold for ADC readings or fall below the lower threshold for
+          them. Interrupt source must be attached to COUT pin.
+      - description: |
+          Alert output that asserts low during a number of different error
+          conditions. The interrupt source must be attached to FAULT pin.
+
+  spi-max-frequency:
+    maximum: 5000000
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddl-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max14001: adc@0 {
+        compatible = "adi,max14001";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        vdd-supply = <&vdd>;
+        vddl-supply = <&vddl>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3d..0aeab5dbd39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14984,6 +14984,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
 F:	drivers/iio/adc/max11205.c
 
+MAXIM MAX14001/MAX14002 DRIVER
+M:	Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+
 MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
 R:	Iskren Chernev <iskren.chernev@gmail.com>
 R:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.34.1


