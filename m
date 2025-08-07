Return-Path: <linux-iio+bounces-22369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF2B1D10E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 04:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E6B18C277B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF821E1DFC;
	Thu,  7 Aug 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK4eF9oj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AD1DFDA1;
	Thu,  7 Aug 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535434; cv=none; b=s7YYM2IL39g0UZakwxcuGxdZpNRTEDQykWXcq9Fm16eYl6KiCkA7/VgpTjd0EBRcuMeTtPs6FEt8TEDNUQ42YwEqMxsJVCdz2vX8Caheuj6E/NPylmbj7qVKylztE9RC/RY5LwBk0p+le3V5xHbtAXrpXLMSTk1wPwcEYFjGK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535434; c=relaxed/simple;
	bh=bOLhCcNIxbO/FxlWnwWskZdUyag+PTgwApgoUECAfp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+ikWhT+E0YuJj4zdoV8CXLgFJ8fqZkBdqRYcAwGu1Xp1m4Z3RtFrVSpMjNKV7OOLuSSdEEWThXTB+i3oEBANVut8swYs07hFG32NGqV/EKljORZoiT10IBFXTuzTVSy/KoG2HtaHc2dIK7zudeXQ3qBLwOKWXA6iotqHy50ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK4eF9oj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3220c39cffso510476a12.0;
        Wed, 06 Aug 2025 19:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754535429; x=1755140229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB37SNi4OaidRxCM7g2VptqviWWEfsKIftPlg0cQSZo=;
        b=JK4eF9ojCBl0ZmfngRNX4eMxKShdAuf3R11wEFneVjKA21aS9jlsTMRuOkjE/fD46m
         FTptFh3QJJBmzdcmrp6FtfBuPYSsnSdtBT47J5OkqYYPk2oyrU71bzU1CPfWV3Ik8Ouf
         NynNMf4wbsz781XRBXS+QTJE+nKa6W0EbaIuPsLWMbo5KTrBlbwbggRLnn6Vun/qsyfO
         iMGrQZm+cMEFpAFnyuUrChPzzjsyHt2j0//O11/sA3QBxhbZu2Z1uXUzWixtBSRb4xhO
         flbJFIQKXqnQQHLI0NFS6Yf3ZWY8WYLm067hIFYEaR07AmevZI9vx/BXfqhmM3NmXT8G
         4U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754535429; x=1755140229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB37SNi4OaidRxCM7g2VptqviWWEfsKIftPlg0cQSZo=;
        b=uC7dwB+yzYpykCaPTrxYp/3u042N5PTetnnUhWB+SzcJKpltQvNFUwngAnyR1k3iu4
         arnXGnC3UPJzobji38EIIuUtOVtYNrRWHATAkdK+dNyHOGtVnVxEUbEhSX9AqRxiXUUV
         VRoHWAh0BD8Mcg5q9XSntWuKHXpwwIwi/rJ3HvUpC7LNmvsvm5FUEHKkWoGBFpFITcXu
         fB/aoQZI5VYJyqduigDdNY00K1T9/3Yg07sqJnN/wpGPRLCGJEQ+PfzKzDSbXW+1EJYw
         CWz7CHfDSTsG+Z00LwS27i0Rf2aIXPXBjJ7SIeuCOPTk9blYrXyTdbiOzJGhAk1Ousls
         vGEA==
X-Forwarded-Encrypted: i=1; AJvYcCUwIBASWxAzTOkf2I/aQBnVK9V7yf2ZQ8JpRCeNGwVbSPdzQ1gy8jGhl7Y9MF5DlkGUuqnHsLA2eTMP@vger.kernel.org, AJvYcCXTjjNoP2GQvF/O5KbnodES1wm1RFhfMllAjV8jPpBw09+EBPz2uxr6vEgocKION0TMjSHExLaAY7IH@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcvV6b90s6qZRpe4qdJRTHU1oL3ufjCexUBWidNCqk5O9voTw
	L6no0EWkAwdm6fn4v2yL8wGxUSViyE7LRqIfH5jfRJiq4qk0c8oYSkzl3r6Du1oL
X-Gm-Gg: ASbGncvWNyL1ZlNHvjVcLR2mItQjhFAXMQOs28GPvT2ckT65Jzeovr1KszEdu8H0+W/
	vysEniuT+S/D3QIwi44Xv3Pl6IQqAcKTvCiCXJWPaSmVdDIJhIDslC/VjN8eR8VdyGT5r/2MyQM
	Voq2/0z+4DItMBxqUB/2TWJ59DV9dGiFPRjtyqx6YDqM1tn9dTNWsynPUxyTxF8qQ1OyPs5L8mg
	cUijWvB3wUapyT2oxlJG0e1chXgN4+pWGQTAbgQgbG3vTJEmMaFE9w9dzvxfA1x2pj4GqnNhRcN
	EGIBDPeaXay8nHQG0pQByxIR+wr1Vgtn09CxGu/F7/j8911ErL3Vva4FGr1z4BAZTYW+o7NN4It
	agyZzroZofNU1+b9/UL+/fUFNrTUDous=
X-Google-Smtp-Source: AGHT+IH5N0RbIJtId5GHxBdQ+OPWWu05aLlaAvu5MyjNd5om3qdHE0sCko7v5+zLyTu53BkoNXXl8w==
X-Received: by 2002:a17:903:1510:b0:240:3f4d:b9b1 with SMTP id d9443c01a7336-242a0b70a52mr58416545ad.29.1754535428652;
        Wed, 06 Aug 2025 19:57:08 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:c940:e6ba:2cae:4deb:130b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0bb79sm20885560a91.31.2025.08.06.19.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 19:57:08 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Thu, 07 Aug 2025 08:26:36 +0530
Subject: [PATCH v3 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-tlv493d-sensor-v6_16-rc5-v3-2-b80d2cb41232@gmail.com>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
In-Reply-To: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754535409; l=2726;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=bOLhCcNIxbO/FxlWnwWskZdUyag+PTgwApgoUECAfp8=;
 b=tuE7TuqhsMhNagWYcy+SUWtB/mXN5WM/0eaZrm4rPIWY6i5J9xjWZ/fTDnbN/Yfe5fYnijUsu
 8S/qJrMNne6APD/eiIBR1Mokcz2UXLg5e6sgsD2wCZXnz4b9e6Y6h7U
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
controlled by I2C interface. Main applications includes joysticks, control
elements (white goods, multifunction knops), or electric meters (anti-
tampering).
Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
its documented in this seperate dt-binding file now.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    | 45 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
new file mode 100644
index 000000000000..dd23a9370a71
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d-a1b6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
+
+maintainers:
+  - Dixit Parmar <dixitparmar19@gmail.com>
+
+properties:
+  $nodename:
+    pattern: '^magnetometer@[0-9a-f]+$'
+
+  compatible:
+    const: infineon,tlv493d-a1b6
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: 2.8V to 3.5V VDD supply
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      magnetometer@5e {
+        compatible = "infineon,tlv493d-a1b6";
+        reg = <0x5e>;
+        vdd-supply = <&hall_vcc>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 27930708ccd5..9e0eb5c873d2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -125,8 +125,6 @@ properties:
           - infineon,ir36021
             # Infineon IRPS5401 Voltage Regulator (PMIC)
           - infineon,irps5401
-            # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
-          - infineon,tlv493d-a1b6
             # Infineon Hot-swap controller xdp710
           - infineon,xdp710
             # Infineon Multi-phase Digital VR Controller xdpe11280

-- 
2.43.0


