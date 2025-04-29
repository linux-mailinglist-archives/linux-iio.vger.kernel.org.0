Return-Path: <linux-iio+bounces-18808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C387DAA001D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54A63BCA4A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6929DB8E;
	Tue, 29 Apr 2025 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3fKHpbU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76729DB6F;
	Tue, 29 Apr 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745895320; cv=none; b=RfBlPv7S3ZLo08KUCcgZLStZz1DXUiUok5yDhkrVqHAx2EPP5Om5z985JSJ6tSqUklMzJK/Cr9kCsP0A1YKYoephU1djOLsJ+Mj6xIDl5ZPsLZZuprVJPPl25n7keJXvBf348JONe/PAgFZO95nKahneTbLAf4cHQtE8PWs1D2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745895320; c=relaxed/simple;
	bh=u/gkt65YsxAYLVH5HA5xMFkhW9HDYqtz7Kv98T5wR+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rt7yPSCDRg1vm4VaObPMytVzyTaP+/cRl+d97I0AjM9naZ9q2LFkX8q4jutpFxOh26zsQySHpbDRgfUafO54ulhKuzqsxXQ4ch07/w9gY5x0P81I+OskkAYVJAHmGR8boclyAxkxwPEvlI0+WAS6qWbC7SO3g+lVKvWYBXqXZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3fKHpbU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b98acaadso5250038b3a.1;
        Mon, 28 Apr 2025 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745895318; x=1746500118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5QvC8qiqI/gq+6b5wv9UzuN/+HiQgS4AGWjWEZLvDY=;
        b=Q3fKHpbUlkX6T8ScipHqB5iDupIhrhGEDMb1VFz46jwTWi0X3kmpz5BzQgjuNUE+FT
         QRub1m00n+zRiVVNtSwnYItzv5/BzZ/G4CSoA+Ki4XZX2oQVtyNN50W1PZUY8anhjHC2
         LWoDOCXujVcQipT8n48GaMAcEDSs6bdb2ZmbX8FwlPogWPGNwKNSw0Yzlc0rwGDqA9jm
         RI83FOzMjxwMVOlOxFnT43P5yfkSXDgK4UPpmE+yVWnYIvmz0g0koOup2ub8c6Igclxs
         Mo+mx+alhAQ1uq3UfOp320Gb/0ZI8KG1AeNTXbbYXwQnah4Ph9uQ8nLB6y6S2DzOL5n0
         jHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745895318; x=1746500118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5QvC8qiqI/gq+6b5wv9UzuN/+HiQgS4AGWjWEZLvDY=;
        b=ssZBy4PBUs7pgspSiaClcZhphuybHu2DVkuOk8fXRu7ARCSYvRDH03mFVTSpgi9m6f
         sxnWkwTCtRHjwh7TXjXFfrbp6y5OFNy4/n/cq1dyJiJWFvkX/xEfx1+mhUEAJrUXNaRl
         4K9c6rO4T/RHU9XVu9mnnG4xhyOKiqAgRhPBakNa1dWXF9uLRUBGoarIj0fpytigqZm4
         Zxbc8ehHJ8Ppg0HBKeV2KAmtWyTkteZuX88AVcSceWPGeZCTe/Bxa+YW4od6A5Dlxyub
         fy32JRmsLfuJho9IxhDL1U4qSIe2yb6ExKNYoQK5JPsDDlzsk+LLve9yxxbxxjXXRhGi
         beuw==
X-Forwarded-Encrypted: i=1; AJvYcCVJjNhelE1K6xMoAV3Mhk22aYilQvDZMuRJVssahZZ0qkbj+bzQLBAy+J9OG+hrAqEa5bpZ1y+qCQC4KFmT@vger.kernel.org, AJvYcCW9AUeIts9m5BaXLhiieFq9Xq0xU6WrhfjxYZ0jJp6pdCw+9LylNNY2ZPLTouW8N5SsvrQ7mXkG39Sc@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZR0Q4sjCWNjw6evspcRP7Iaem0M3laF4CQwXgArxcp1gngvK
	AqYBWDJW9Kcf39eSIYMPw4y6ypHny4ggRsIkXZrz3HMbG4MCAAJP
X-Gm-Gg: ASbGncvcjfnnllzFs4zkxDXNS2SQBDh7xb6sGURI3oyjrMilhwppPcfaDSV8o8HOJHq
	xUw53Buno22mh7CBmMxgtzstb115M0h4E0SOOqTSVjD6ihrcB5dIdu97clmb2Ax1CW4SpvpWB4B
	ztZIFhQWS5jjK3A5/GHk0y1rjj/tQAA7WmtuZyRnfz+X0HzDlpZEIblMsBatU/C8BRwewIosxbx
	F9UxdeIIwFY03tFmYGOz304ZGpl90A3krTfBKGiBdgfq0UCDg3bSjusGKiA4CAmsDs4mYI6VAQ1
	unHVhQu8htmDYNncYHET3sgCzJTwXShLFqe6lH/EAwB/3tAxPV80EAWdr/kgGVvwrWiByiX+
X-Google-Smtp-Source: AGHT+IEEMsNPh39HCFTepwa6E/0jlVmaAmpHPW18q/Kqr0Jqjh8efv82q7Re5lhqYDCbaWPxVZajYw==
X-Received: by 2002:a05:6a20:9f8f:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-2095d49ca77mr2105970637.35.1745895318350;
        Mon, 28 Apr 2025 19:55:18 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6abcdsm8797905b3a.116.2025.04.28.19.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 19:55:17 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	tgamblin@baylibre.com,
	olivier.moysan@foss.st.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Tue, 29 Apr 2025 10:55:04 +0800
Message-Id: <20250429025505.3278016-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429025505.3278016-1-j2anfernee@gmail.com>
References: <20250429025505.3278016-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bit
ADCs with I2C interface.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk+dt@kernel.org>
---
 .../bindings/iio/adc/nuvoton,nct7201.yaml     | 70 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
new file mode 100644
index 000000000000..8ce7d415d956
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton nct7201 and similar ADCs
+
+maintainers:
+  - Eason Yang <j2anfernee@gmail.com>
+
+description: |
+  The NCT7201/NCT7202 is a Nuvoton Hardware Monitor IC, contains up to 12
+  voltage monitoring channels, with SMBus interface, and up to 4 sets SMBus
+  address selection by ADDR connection. It also provides ALERT# signal for
+  event notification and reset input RSTIN# to recover it from a fault
+  condition.
+
+  NCT7201 contains 8 voltage monitor inputs (VIN1~VIN8).
+  NCT7202 contains 12 voltage monitor inputs (VIN1~VIN12).
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7201
+      - nuvoton,nct7202
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      A 3.3V to supply that powers the chip.
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage.
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1d {
+            compatible = "nuvoton,nct7202";
+            reg = <0x1d>;
+            vdd-supply = <&vdd>;
+            vref-supply = <&vref>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f..f41f886face9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17373,6 +17373,12 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUVOTON NCT7201 IIO DRIVER
+M:	Eason Yang <j2anfernee@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
+
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.34.1


