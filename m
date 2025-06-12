Return-Path: <linux-iio+bounces-20535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02CAD6D15
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42241892D75
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3122E3E3;
	Thu, 12 Jun 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGXvsB75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18A22DA19;
	Thu, 12 Jun 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722942; cv=none; b=nQsmEJj2ynEYljPXrixH9FC0XWaBYxhpgQPeB/YgTOr0mOL/lPCf0/93SgzCPY86O2G2Vd+/LalnmIY53F3Yc71T5/oUBVvydvOS8u22vnpFFtcowHd/Fmi60i5EUzxa7HUSqKEoGJeYF/JId3vWUzh1VCl2ksWRLO/Z/YQJEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722942; c=relaxed/simple;
	bh=v/Vpp9tR17Ww7/EZO2RhqR7JDT8kvG52GgzQcO5DhXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eroWiiG5lTWRuPZobtN9soJzOQDp2rpk8WreZWfvUpK5Um4tqDU+siBvHEZJgVzWnPFynQQnjm+fOl/nnP6wOBAcwNpg4TLCTJI5Fk+IjeagfqFe09yCfsLxdib+Tf4qkagdWzqcvVV7jnQZrtoJjfAFxW0Zc2M0q94rr+3ZWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGXvsB75; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235ea292956so7468385ad.1;
        Thu, 12 Jun 2025 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749722936; x=1750327736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDz2yePuf3RsISsJJAU1qMSyIakG6IuwNVN3MZenC5Y=;
        b=fGXvsB75RRc0K2vP575B4yf0n3co/Iz7yAihHDUZkruED54Mq+s5ySlBYLkO/m4Gau
         +HaD5N2+iQqzaaP7s9vBubzCeBH3r7zStEnAQps0yB/OYsjXG5hnq5eQ5T3LRBtrVW0n
         g9beb4sYCQ2A9zWeDN98kaiZvcaVWSdvZrYpNyQtlcBSgyE0eR3OOslX2HgcgvUQ/F1B
         KnGJgRl1K2OIN1oVDHasFDplKXenAt/0u4yQbpR9Vfz7AttIAAS2X7n83KiXsvQOPWHp
         yG4RzZkypYL3rSs1WAG9Xgpws0XwxTc1IKCaIRbv1CHS96hwi7JygY2vF4F8M0wynWAg
         0oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722936; x=1750327736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDz2yePuf3RsISsJJAU1qMSyIakG6IuwNVN3MZenC5Y=;
        b=iut6Df8k2ayRJaHqIcY1+VcBMW1T8IIhr4gYbczvNIdSamL6+HEGbgvFilET/sXtwk
         6+ct3udfvphCXl9fHQMFU8RolMlfPVs+2h3EwjjtLYirQDQ8xYG+tcej002UEYM/iCjN
         icftiUCEuybF4Gh2czhiD4wg2Nr8bSbCqOAQh9sj51UGq4YIFlF7NY2hbYbeXNoSGDpy
         NLc3sjS+0qez7p87YbD0B8/dnHe+lCTAj9LE/TQYTfmKf2QO4N51w2xifEn2qPoBcrSo
         A2ctxbZJ8Mf6J3yLhU08SJZ5zW+CGZOX1L1jzUWyaa1qq9qgGUQBnEyS1180j0KsQWT9
         NrUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGimnmF54+4LpCJC0JQ8Zh0bZzA49LmLXFlgwwP7JX/yP1lKxaU/otExNanG1vn9I6CpIL4jft7dC0hfPv@vger.kernel.org, AJvYcCVLZBv1I/PzUnGjKKgkbIH2IBwtcRVzk88o7JFxf9XkyxJ1jL+bpNm5T/tE/njCPgQ6mHALmCfNx69Z@vger.kernel.org, AJvYcCXy1JkVX8MerZE54XR9ASVW65dOc2Ydkp8yjyS1d/cQ5bVg3N6FMlEheFPpwkLAKoCRr9cNOFZ3GfcM@vger.kernel.org
X-Gm-Message-State: AOJu0YxXR84/gkG9F1CIPy3NIYACpFfvYVpFLhf2XCBm7kn7xP1/ZWZS
	9I+zbOropFJxtgr4lDdtnJbj2dBT48Rr3KtHFZj31xKELltLb4Yt9CVE
X-Gm-Gg: ASbGncsA/X0rB6nv+zVO4ZaKIpo8pK+0QzEqeGtWDA+q3Xzw4jvIpHnUrWNMyFu6rNC
	T8QDWnu65Wy8J+ReNh8Xznhu1XvP/xsdrhJlVG567W5VNCqYfe9WXqzPtbG/NR9eQpsTNFFUlUn
	qfpcDPwkoa7B2/Pm3JHf9ZCZ7oD/qIGfnH2gj8oi8bBoM+FyKomOQzzWfUMN3bsmixw9D/0scl2
	3zLKPrFOKp9RbRe3BYfHyB/VJQFzoI4TdPtd4VN+3kT9Zknfo/yzeAM0PSTDN1aAM7CBGTp84D6
	qJvZI3f47zkGYEDdJu9HJssg0CawkS1v9JtwISoMCxbLaxzpO3zJWNNziSKot49tvyAlQeEjBA=
	=
X-Google-Smtp-Source: AGHT+IGCXRdB1xtXVI3Z69EBCji6ru8onsozSIQlXurQWgQHYr5HxQENpQsF60g1z/iV0nz44ylLQA==
X-Received: by 2002:a17:902:d4cc:b0:234:cc7c:d2fc with SMTP id d9443c01a7336-2364d8b7c7bmr34298665ad.27.1749722936188;
        Thu, 12 Jun 2025 03:08:56 -0700 (PDT)
Received: from localhost ([2409:4071:4d30:50e6:899a:ff8f:cff5:9bba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd62937c0sm824259a12.49.2025.06.12.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:08:55 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: [PATCH v2 2/3] dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
Date: Thu, 12 Jun 2025 15:37:45 +0530
Message-ID: <20250612100758.13241-3-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612100758.13241-1-surajsonawane0215@gmail.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Add device tree bindings for Sharp GP2Y1010AU0F optical dust sensor.
The sensor measures particulate matter concentration via infrared
scattering with pulsed LED illumination and analog output.

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: https://lore.kernel.org/lkml/20250425215149.49068-1-surajsonawane0215@gmail.com/ 
V2: 
- Updated timing properties to match datasheet exactly
- Added reg property for multi-sensor support

 .../iio/chemical/sharp,gp2y1010au0f.yaml      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
new file mode 100644
index 000000000..b4e5110d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sharp,gp2y1010au0f.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2Y1010AU0F Optical Dust Sensor
+
+maintainers:
+  - Suraj Sonawane <surajsonawane0215@gmail.com>
+
+description: |
+  Optical dust sensor measuring particulate matter concentration via infrared scattering.
+  Requires ADC for analog output and GPIO for pulsed LED control with strict timing.
+  Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
+
+properties:
+  compatible:
+    const: sharp,gp2y1010au0f
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  led-gpios:
+    description: GPIO connected to the sensor's LED control pin (V-LED)
+    maxItems: 1
+
+  io-channels:
+    description: ADC channel connected to the sensor's analog output (Vo)
+    maxItems: 1
+
+  io-channel-names:
+    const: dust
+
+  sharp,led-on-delay-us:
+    description: |
+      Delay in microseconds after turning the LED ON before reading ADC.
+      The datasheet recommends 280µs after LED ON for accurate measurement.
+      (See Section 6-1 of the datasheet: Sampling timing = 0.28ms)
+
+    default: 280
+    minimum: 0
+    maximum: 320
+
+  sharp,measurement-window-us:
+    description: |
+      Duration in microseconds the LED remains ON for measurement.
+      The recommended pulse width is 320µs ±20µs. (See Section 6-1)
+
+    default: 320
+    minimum: 300
+    maximum: 340
+
+required:
+  - compatible
+  - reg
+  - led-gpios
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dust_sensor {
+        compatible = "sharp,gp2y1010au0f";
+        reg = <0>;
+        vdd-supply = <&vcc>;
+        led-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+        io-channels = <&adc 0>;
+        io-channel-names = "dust";
+        sharp,led-on-delay-us = <280>;
+        sharp,measurement-window-us = <320>;
+    };
-- 
2.43.0


