Return-Path: <linux-iio+bounces-14492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97AA16B0C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB46C1693F5
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1671B413E;
	Mon, 20 Jan 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myAYez3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DB187872;
	Mon, 20 Jan 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737370488; cv=none; b=Xp64jEBOBr5JTsjgv3ytZrWh2qwpgjWTrL3mIdNbN4taZRcv7BRzFdp22jTo17s3eJe894Wbx3rlQiksAE9+DC2Kfssg95C518kcyG07oF7a9ne5HutsVryDc8bfPplOZ4eR0XnQLykWIGHwoOFK4vUcAahd3bnnSIBycfbxTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737370488; c=relaxed/simple;
	bh=NnMvYOF3JLr4MV9bxzclHulHO40ErNKUGvG/q0bZVn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkLGG4wPHAgGMYPNioa+3/QrGnzb0Za5bRvvE5Be+M6lWR6zreBUD7tx2UUuGrs7Dtp1aZgE0XVD+Vz4PKDFU/tU9VgvFna5Lz6sbdZ8brjnUvbPdtf1wvfHpM/mQESJVkQ6hayTNAME0jwOuPiLpi8n7lu189TXEPM5KHEiAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myAYez3B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361815b96cso29342185e9.1;
        Mon, 20 Jan 2025 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737370485; x=1737975285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpwHR+jTEkOihBQGXcwVdD8ptWqMifoht0tZ1GdpMfs=;
        b=myAYez3BTbaPxGaEk8ac+bMSikSOWzuisbc0cRtibuf/xs4F4vHD+LAb0xfi6yyvNg
         ssIQEkpLKd6qF4+3YwirgYUoZoSLFucBF2stpi0XEMWtoWTxqm/S0o5DQIIQiUXMRPxs
         XzmP4gVfUyzw9I88g/6YzaN/HRzMWf+hIwG6YONZ6XFTKttr0nkSqvTxd5s7oYzsk5WV
         c1DaF+nlA63v6/f2AwJAqHPukf42Uj1s81gL1B3tGDF/sL39CMJRmU8qxHrC0PPey3Up
         JghyD7PI1Lj/zKjT/+JEps2jD+Sm3rFaxJZRlPjh2L3ArfuUKIpd+AOyvM8lH4PMC3aU
         bVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737370485; x=1737975285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpwHR+jTEkOihBQGXcwVdD8ptWqMifoht0tZ1GdpMfs=;
        b=Qdj23F1Dv8tDy/zAksx26ug3baqscuTBmQx5pQgostzGPCxygx8zqI90iT/duP+Gev
         0OFtE2RL9y4cRJ/Zpq+CPdyIfxXbTX3q2/N/shXvMwj3BZr/CJ77ZbeAd4Age/rr1NJW
         cV6vUM1L1IvZ954V8+vMRRnVwZDf8dLUmeUwq1o0r23OOrfXyioXjlPFWZo3iAm3bzm6
         /VLMdPbOySw4wHo5ui+mDkf01rwnTxjYm8EXty0olCZgJGXQ4wxsHOI6sqZrBayUybAQ
         k8JGoX9Y34/uxk3ADYtRaypCaMrDSa+VWE6tKsfO2TdFuVf0oQ5S4EDkLms017HEGdr4
         i7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU5qZGf7m4Lo3NpswavqRZIHQ6Vkt9u5heyLU2GuPv0vlEZjrAh17RxKcaHBy8ht3VC+NhINoKPYdg7uA==@vger.kernel.org, AJvYcCVeuq1BMph4BntnRrqg8acVItewvOGL4WTh8ZJ5FF/Zy/4KEDYa0tFKJpWdGZsjMZeaDXCcSg2Vz2rQBJ7W@vger.kernel.org, AJvYcCWUkfgWBJXiJMsq/zcfJBq8Gt/yhT+j/X6wa55rAawv3JDPPk8Aelx1W15W19mxPlgrRsGP74ANnWfv@vger.kernel.org, AJvYcCX3j1EPluzo+6vujvC1EFpvJWNUrn4IOitrE+yYW0kGSfnboQpuQCya9X16PIYQGY9h/H2fzfN8tLh3@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAYyWlfW35JoE7X/V6I46c3bJqRVbNgavjtWsc+Za79gSF7Um
	1LTP1Q+eyf6VadAdPXYKMw1F0VrQp8d7szbQGPjZxPgDBo4OHf5pWixpqw==
X-Gm-Gg: ASbGncs1f/XEjVM6G+XLjveOHe5M2L1URijpxsriRLcaI4Mz7qPU58J6jviNyMPb6JG
	ne9dXbb4n/jBk1x+NBbvSwAUHxjZd8xy6W02SGJ6MCta99CkxZYSRA/pu4vE9gkCSC+ypLXkbNa
	2kctfsG3SEk9RszmjI2ShxLy2JCszmUibhHx2XBr9eBINfH3fwI67Rin+fysE3Bsdw9+JHEBqhN
	z4wRzL6q9haM0ch/3lYmEqATU1knameG5V4vhc/qXdfEj3V3gIygCF2M/FF1M6rEBxaIHGT64rJ
	NTUECw==
X-Google-Smtp-Source: AGHT+IF8ZG5TPPQK00mQUY7XfxEgCiDcyTtDrGq9i0kkjbdhbzw9TleO3gk9skl8mHshEktkZQW0KQ==
X-Received: by 2002:a05:600c:4fd6:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-43891436690mr95144905e9.25.1737370484444;
        Mon, 20 Jan 2025 02:54:44 -0800 (PST)
Received: from demon-pc.localdomain ([86.121.79.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321537dsm10222411f8f.13.2025.01.20.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:54:44 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: amplifiers: add ADA4255
Date: Mon, 20 Jan 2025 12:54:24 +0200
Message-ID: <20250120105429.183004-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADA4255 is a  precision programmable gain instrumentation amplifier
(PGIA) with integrated bipolar charge pumps.

With its integrated charge pumps, the ADA4255 internally produces the
high voltage bipolar supplies needed to achieve a wide input voltage
range (38V typical with VDDCP = 5V) without lowering input impedance.

The charge pump topology of the ADA4255 allows channels to be isolated
with only low voltage components, reducing complexity, size, and
implementation time in industrial and process control systems.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 .../bindings/iio/amplifiers/adi,ada4255.yaml  | 83 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml
new file mode 100644
index 0000000000000..7ae752a63b111
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4255.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADA4255 Programmable Gain Instrumentation Amplifier
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  Zero Drift, High Voltage, Programmable Gain Instrumentation Amplifiers.
+
+  ADA4254
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4254.pdf
+
+  ADA4255
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4255.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ada4254
+      - adi,ada4255
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  clock-output-names:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  avdd-supply: true
+  dvdd-supply: true
+  vddcp-supply: true
+  vocm-supply: true
+
+  adi,excitation-current-microamp:
+    description: Excitation current to apply to IOUT.
+    enum: [0, 100, 200, 300, 400, 500, 600, 700, 800,
+           900, 1000, 1100, 1200, 1300, 1400, 1500]
+    default: 0
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ada4255
+    then:
+      properties:
+        adi,charge-pump-freq-hz:
+          description: Frequency at which to run the charge pumps.
+          enum: [8000000, 16000000]
+          default: 16000000
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      amplifier@0{
+        compatible = "adi,ada4255";
+        reg = <0>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e8e67cd31961e..be46db0866011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1405,6 +1405,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADA4255 DRIVER
+M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4255.yaml
+
 ANALOG DEVICES INC ADF4377 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.48.1


