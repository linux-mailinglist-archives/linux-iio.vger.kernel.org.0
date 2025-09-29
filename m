Return-Path: <linux-iio+bounces-24546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1EBA80A7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 07:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CA93BC230
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3D29C343;
	Mon, 29 Sep 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3TUobub"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE627F163
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125569; cv=none; b=iIryha3B6/G4fjk4Z/k0YXa7mDg7QMJic8Qbdfaluv7sP762x3oWEZGLwDEozm6Brkt3izAHsgLmnQCRhvq2M57CV1oIaZIygPmuOBHu+aRAP3HyO1tjsAq+g4PwRjtOvTbbE3s6nFBwVMaXsNuJTvZRCc8HxgvGhD+VR1H6p2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125569; c=relaxed/simple;
	bh=Hpbsw+Og6s9yKgaYsaTWo582+rMNy7Y/tZsPq9IdEuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V2eihywdepgqwYgh1MKyZ3gwf8EVdLvnbXKNfi57oyCOsuV2wryOiEDHvguPRjpP8Zq0gObZ8mVdNsn96b2naUMfY1aJGGNeQwfC+0RXLzJ7Mgo8mbjWjyQCBqbth68syOm9aLNVcMfPSUiUEb+VIz82A5lk2KdkAzFIcJqp2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3TUobub; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2697899a202so37540975ad.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 22:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759125567; x=1759730367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oJNfpk8MW5Bw6kfx3xSXkQNJdPPXDdao0EQbasGVIk=;
        b=Z3TUobubZ5/2G8ZssS8Y6Sx83eC5njXJ7KyDwNALkOc/zhjYhK2Csr8J+Wcab1j6+y
         T5obBZeCMm11a7PGgBFcpjtdbbfJSCQ1K3DxY4q7Y7cM+3Gr86KnyiYOFAB3JJbyX892
         I/LsuHnW4hy10Rm3xoAy5i7487ghvNKl4VR6XYOZt/L/avMGc032DjD0rBaIm7QQ/5Of
         Ndz/vwoYxw45lXBitNz4aNhTKmLFixJrV6SBPbso6A3dcHS7VswPELYhcvCPOjsiAaA1
         xuRNA2bZODUmWMgQK2GiVDN04Y3Hn3E0k5JX3rNnALAmVctTd3jUo2SOz5Ui4MVCocg5
         MJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125567; x=1759730367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oJNfpk8MW5Bw6kfx3xSXkQNJdPPXDdao0EQbasGVIk=;
        b=JrxS4SYbx/IdwBO/iXCy3ipX9mbFd2kzD0++NH2yGul5kbJ2WnCoitxhnu/l33ORRI
         6iNM4aaQmW65tp7Yv15Lmj7WTrI8R3DGc3fGI5njfVwU53H1GJaSXMDWiWJgER1YTLPt
         3M9lls74q1WrPHCwgVT+Fn8Gqgv0AoE07yXtW/5urDWoHglG7ubwq4XV66KSh70wc9/O
         W4CyqaRF02diCa06ucUiAK7tUx5AB8vG4yVgI3iwqibfWY7a41aADXPWVypjbEhHvUYZ
         o+1Ylo3F4PZn57YhxH9+SzbiXv6oCp0X5LSBKsvtcBBNJQr5aj7NUYuXEDKBhF7zrXJV
         /bSA==
X-Gm-Message-State: AOJu0YwH7fRtU0Mxf+DzjTtwD2fvZ49aB4OFEe6kNunDLpQScAuRKQIf
	6JmjJFklsjjRpI7nxDItjcn7MpVoHMl9m2hCa9TmW+pW86x2e3QoFbKpR6MF/OoB
X-Gm-Gg: ASbGncttu4zXw38pJ8cu0F3JOH7n3lPR7Y+k8gncDZ9zShaXq2BD3bsM/Fv0r+c1ImR
	IgUL7Kl44gpUUG54NAMQbwrXIVMGySbGXaT8FjlwtxxCAmsLtPokflgofAuudGJWdd/b/6BhRr7
	7p/SGsMWyuLHaSI6Ig2+dB27SY8os2VPRVskUbfkUL89HrPojyqAuwx+D0wD0b69l/MnwfGMoWI
	a8Kpp5/umvCmzuFs4mC1//vYqdJmbSQCzCydJbx+YNEj2VtU+XIAblkOJMLiAPzw84BYWCVlhlw
	DTXcgg17krSHPJNCNIRF7kYILXqrZec42ZqBnY0/juCyD26q/qSfhZsV93fEABqxzm5qYFEkEDt
	u+fGo3GuhtY1LmGLqwEvbvq+zJZ4T9ewTnZVRudQyBjy2Fw==
X-Google-Smtp-Source: AGHT+IEV93Vc2c3TbwmaCoYkatVxk5uPZc3HoZY/BjqH2ZibvSGmWfVd6Kj7GpzQeMwI8HqVi8okAw==
X-Received: by 2002:a17:902:e741:b0:24c:db7c:bc34 with SMTP id d9443c01a7336-27ed6df3f40mr178509295ad.13.1759125566572;
        Sun, 28 Sep 2025 22:59:26 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:fda4:f56e:95d0:3775:a428])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bc295sm119371015ad.123.2025.09.28.22.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:59:26 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v12 1/3] dt-bindings: iio: adc: add max14001
Date: Mon, 29 Sep 2025 02:58:38 -0300
Message-Id: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add device-tree documentation for MAX14001/MAX14002 ADCs.
The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
converters with programmable voltage comparators and inrush current
control optimized for configurable binary input applications.

They share the same features, but in the MAX14001 the inrush trigger
threshold, current magnitude, and current duration are all programmable,
whereas in the MAX14002 these parameters are fixed.

Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---

Hello maintainers,
Thank you for reviewing v11 and for your suggestions.
I believe I have addressed the requested code changes in this v12.

Notes:
- I have not removed the “|” in the interrupt descriptions because the
descriptions were changed as requested, and I think they now need to keep it.

Changes since v11:
- Added spi-lsb-first in the example.
- Improved the interrupt descriptions.

Best regards,
Marilene Andrade Garcia

 .../bindings/iio/adc/adi,max14001.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000000..7b3a72dd0b0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,89 @@
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
+    oneOf:
+      - const: adi,max14002
+      - items:
+          - const: adi,max14001
+          - const: adi,max14002
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
+  refin-supply:
+    description:
+      ADC voltage reference supply.
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: |
+          cout: comparator output signal that asserts high on the COUT pin
+          when ADC readings exceed the upper threshold and low when readings
+          fall below the lower threshold.
+      - description: |
+          fault: when fault reporting is enabled, the FAULT pin is asserted
+          low whenever one of the monitored fault conditions occurs.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: cout
+      - const: fault
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
+        compatible = "adi,max14001", "adi,max14002";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        spi-lsb-first;
+        vdd-supply = <&vdd>;
+        vddl-supply = <&vddl>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f090c2f6e63a..1e1a30f77a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14922,6 +14922,14 @@ S:	Orphan
 F:	drivers/video/fbdev/matrox/matroxfb_*
 F:	include/uapi/linux/matroxfb.h
 
+MAX14001/MAX14002 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+M:	Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+
 MAX15301 DRIVER
 M:	Daniel Nilsson <daniel.nilsson@flex.com>
 L:	linux-hwmon@vger.kernel.org

base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
-- 
2.34.1


