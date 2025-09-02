Return-Path: <linux-iio+bounces-23641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21608B40278
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE92C540181
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F0301471;
	Tue,  2 Sep 2025 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdBMgLtI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A382459C5;
	Tue,  2 Sep 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818966; cv=none; b=WWKhd61ZHQdbFGpr0yfU0vMueSUMIPJ2veY7bBR4zv9Gjg4X0t/vbUZZRpXGp3UHkt63UdV5uqt+2g9aTqYBFxijC6pVypGTuRnVVeWb37sH6XQ3LIwt9mIDHBXf9evgBrib8OtYwn3Ylllqn+F07FnxaTkSrC+aWVsODowcgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818966; c=relaxed/simple;
	bh=DBvPRxc2Xdaxj0STd4exIV8m+LZrWMLAupmTxberStU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGCaoCoyAQ3IK7SRUe/6kr2OGlabmk2s/AECRPZVkl87BWvdNndhRa+6+qzbKt4xMg7uQHXjF8xUoIuEHThYwitdtnEjc5fTWxQN0mP3pXtT0dA/T+zvZhGd/DjbpahLsHJiC6SAt7LL4K9v1sIxoZY+tJ9+mTagakuibG0S/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdBMgLtI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722c8d2694so3270282b3a.3;
        Tue, 02 Sep 2025 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818964; x=1757423764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NjRh+7eenrUTcgc8k/UXnVYX2oM7XtqJi06sxrEvrg=;
        b=FdBMgLtIqSd3JuZtKEW6emYwhSGoUHiYQ/cuNNh6Boq7I68dRcW8+mTc1JMR4zEo3v
         oPj8y/JlS+xiejW7IXmBGuYAIBZKnpipowy/eR7Dv51J2WhgQFd3vbC8SLmV9ChhsYlg
         s9rVP+CIyJp4rbPd7FOG93a7LcrSSWVzmWxlZ4rgVEhH6E324Fk2XoPRscpheyAYPece
         j4bMEJ8gS/dkxscAPDB7qGN7kili0J8uwJFWCUf13c+buuD5FdMekDXK0ZuDtoiZNwJ1
         Rdvnvmg1hnwTN6aVfVGPc3dvQE13hJppCUMC/iwwrb1LKF2BcO4bzu5PGhMHQw7sqbn7
         E6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818964; x=1757423764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NjRh+7eenrUTcgc8k/UXnVYX2oM7XtqJi06sxrEvrg=;
        b=Gz5bzVrRVR6TVGZgiFeQwHaR+rRqjJpztocsVnRi6q4LkaG0gg8D1PbBoLMh8NcRt+
         CREcXzPEf9vYJemoukuKSoICV2kcrgwoQRd8GRYutDyRxKBtO/EEr6skNST7pvQ5k3Qu
         ASzCBtPh+47J2c3OFMLE0UJnjlNOQQz/YUXS0GqpUMB7h4IDZ7/2uqPhBjshPx6jIsP+
         9+1uXjHhCUa6WrEiDghdU7bCEekwce+WN9HJKlo+gGLRZDwS2FwDxZ+ACCR7qjHo1k2d
         bNScS37lMy2HtjWQsEdCYfowc+lqqdsfw+Ogz2V4EFkYX1fVK6CiEg6qwGb3/MagTqcs
         t5yA==
X-Forwarded-Encrypted: i=1; AJvYcCUO1ch3qmZTGPiFyYyQ+JMEltLEoJIY+VdrNv1EPCaVKEk0zRjVF9vhp7GnzGBXhycPx1UU0BpEtB6PmXKU@vger.kernel.org, AJvYcCX0DRygw7hOFJm9LOQNkAg7YQ03s2RuNa/d/KAEzDjPYjM+8vvl+87R5oxbUKGaHH/EhSmqBK8TPlDT@vger.kernel.org
X-Gm-Message-State: AOJu0YyNskHGTGRPDp8rTpkrLc8GHwfGEcXNEqUGnm68G3nJpyQvUMBS
	1u8PMZ+u5ldszLowybkwnQv/ZsUjWT1UU0pvU2JS1zS3VCkk2XyV9WNbe60D1jX92jFyyA==
X-Gm-Gg: ASbGncvi5Gp1CnpeRkqzkNhqH+4SVUVUxbCHvuH7AjaNo3hTSwk2LFUnpoTg5pzMxCA
	EwmuORB2W+l8i3nrmGu/N/1yTczdWV/WL9VuEoj3Xa6KJ92ATWmEgnTBVk1U5HsuOxbesK1Ln24
	5Sf40Qb3fhdQ1peKsn1+pvOa5S//xSZQM505czbY043GwkjjW1mkHJBNXUmRf5nFRaG6nUpqIq1
	L5dVlDSZODBSq/zHVwiQPSXqimxH5L9z+NQhYPKHtmEh5gi7tn9h5aDg07gemQiXRGtWJNdjXPY
	CAC7ra59WUmLbL2VLRbcgdcgzYCUxQ3IZND8gCRGe0yRwM59d0UVKS2Sx7Nc1nyatNgmPFn9TYY
	mtSGvO8Szm0+uUg++QTKCjdKCxSTYyfDovQX4KjCETi0Cz/KOsozBqiA=
X-Google-Smtp-Source: AGHT+IEqd3Jxg+9ymxmYTVcFgyNiljiZrKX6eeI7Aka8qMn9PZlPMi0JQ5hZqhLCVC2RZOIdj3QSDg==
X-Received: by 2002:a05:6a00:811:b0:772:49c2:b5e3 with SMTP id d2e1a72fcca58-77249c2b91cmr10376206b3a.5.1756818963583;
        Tue, 02 Sep 2025 06:16:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:bc66:1b1c:d88:2aac:2997])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77267a225e6sm3712122b3a.94.2025.09.02.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:16:03 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
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
Subject: [PATCH v10 1/2] dt-bindings: iio: adc: add max14001
Date: Tue,  2 Sep 2025 10:15:50 -0300
Message-Id: <34b7cc7226e789acdc884d35927269aa5a0d5e14.1756816682.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756816682.git.marilene.agarcia@gmail.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
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

Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/adc/adi,max14001.yaml        | 79 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000000..ff9a41f04300
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023-2025 Analog Devices Inc.
+# Copyright 2023 Kim Seer Paller
+# Copyright 2025 Marilene Andrade Garcia
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX14001-MAX14002 ADC
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+
+description: |
+    Single channel 10 bit ADC with SPI interface.
+    Datasheet can be found here
+      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
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
+  spi-max-frequency:
+    maximum: 5000000
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
index af1c8d2bfb3d..f145f0204407 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14969,6 +14969,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAX14001/MAX14002 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+M:	Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


