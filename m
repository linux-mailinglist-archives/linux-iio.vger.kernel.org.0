Return-Path: <linux-iio+bounces-25812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBEC2985B
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED55C3AEE88
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 22:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54350224225;
	Sun,  2 Nov 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxkFtCeU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC22222B7
	for <linux-iio@vger.kernel.org>; Sun,  2 Nov 2025 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121825; cv=none; b=ZI+VfrmCbE8e8kpvNrFjt5LANC2uGvaVe7f3Otc/acuvzuWDAYT442p73wMpKjJVMbejgp3sCq/jFi+ilAE7t+fy+DRcCZgxvVfuCwB1GvMtFoyTKCm/tFO0z7bja1jhq8WaS8h6U+X6KHlF7Qu89bWfcK5FO+8wbuxQXBUJNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121825; c=relaxed/simple;
	bh=IQsghSGvLe3p8fZkTsq1elt5Nv2/GiuRfy/EmyAJNFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlnWrl7x54v5U8duETS+JAzUmPZLyTzZO1Uf5YZDocibMhJj7j1WaAZKtC0+FEI5gKGvRiht9D1AiFVtXeLqU0/G/tiP05XR8E1ZoNu1PlNo9JU7HXD/c61ZoIeDJ/h7COonDkq85p8hFDasw/OelBMOMs2Uqva24qvSLH9aOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxkFtCeU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2952048eb88so35478255ad.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Nov 2025 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762121823; x=1762726623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47gxy7zp7dlvgIc5dJ/R0rsLAgFmWqzWMMGs9uW3ML0=;
        b=JxkFtCeU3lMNq9SuwBaNM+UoJA+iU5NBKWt7Ibx5G8oNxWAJ2OxCwYH5RBTR3K9JD2
         skIHF/K7V5ur/TXSRDoEWBN8ayPpu4YaNqNZjEFy+krpIb1MGlSQSJ951g31dmwgbsFu
         YRul0PDR9ABc6K4XAb85lbt6aQ9jXH0NIfPgGkPfZutCqBEnJbdZsYR8318XuvSO56/4
         l0r3s7EAkayC8YznvAbChjarkN2bDaKqsv6WDLcQx25cCHyT/NIaadntTJlrzyO79biX
         iI2g5atS/EtpHiLZUp2NfoiGx6jK4528bwge0nIpNnRQOy4VTG+OjhziRcVom06bjUWt
         P1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121823; x=1762726623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47gxy7zp7dlvgIc5dJ/R0rsLAgFmWqzWMMGs9uW3ML0=;
        b=GSzEnYm7xCABVrEyUwABuNJ/kCRSTVaHJzm7qdJYsCJO9u3IGLU+T7K3+6gyNfxBBu
         vQxDf1lPivJrpZjybDMd4y3GGwirlZ172eBc9ubhVrIwJBEqqeGgzPXxyaWSYfjV9Bul
         RDlzvo9IhzmE+7YLW2fQDKvGQPnz4L7bxyFX1xgWSPKkAbi1nONlTBASAmVXRIlls3Dm
         HZOKIQvy4bArrR5VLaXwwkDl7RPLy+Nhk4gECZ6Mq4DGygiOOb10bmD7ivHaooQ7KuFb
         4M6OtQs5H5BfG529zTK8YDDwdhbtbUjiYq2H8Fh2M8EtfRNQmAfBEuDhfLylXhrH1XSu
         DpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzp9sDXArqgs2UA5y1fGU9C8oXz8rTwHPOiR30HHuiQydsNTJjnjAA6cP4xxvq7gd+xsQs4Cv8+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP59sbCxKXPceU4w1eQlbtEXIGnLe/SpuplUh/+t33Dmhhqguy
	NvDwTeIpXhglKkbAZHGmVXuAbind3EzLaIUTefutgrkcHnRhtMQBrgDS
X-Gm-Gg: ASbGncvs5mHVWs2/EVni0SjR5P5qx4b4rKcV56ARcdh4o606nd7TFmG0bNXWKZZq8A/
	qlZ0TnswJkSIRM9IUYLW6eHFPe91GsHkSvwRx2aNyASuGTLXoz4vvt1BvalDF5mZd/Zij8dDiH7
	5YWjqmgsYE+9axyLBaAXZ80PKgAdk2C+5FAOBxGpc1M0Be94yvfKtZ+qI2yBa+4eKrhSM2CgMwT
	q/7HNhVOaDLEG7fQTTfQm4voKtZ5Piq/uqiXBttjNHe/1MkGy/lgQ9nJVytG2md0d1N5SFNyZqA
	YAoFI85kMC9wJTYPEswTlcmkhvpUr83Dw5lTn7Ex0u5/Lrj/vVdI1SEyeXm4iB0rvObPriC/aoh
	rubhonerTKmW4LPuv4RaH2PDEoOfGK9GlzsEvckJCGHtWuuFMh4LjRqvjpcMWN8zSA0TPTmll/a
	CHVegogjjvvgt5NKTUXBsijjc=
X-Google-Smtp-Source: AGHT+IEFC4JM18TyNOFrkGvzBG1fq/R2wBUS8oX8Gf9AFUcfwbHwXBghvsyHwZcbBHBtEeXO2qd8tg==
X-Received: by 2002:a17:902:db10:b0:295:50cd:e759 with SMTP id d9443c01a7336-29550cded8bmr102841845ad.58.1762121822800;
        Sun, 02 Nov 2025 14:17:02 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295357a1851sm83362835ad.27.2025.11.02.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:17:01 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: iio: proximity: Add Lidar-lite-v2 and v3
Date: Sun,  2 Nov 2025 19:10:27 -0300
Message-ID: <20251102221643.9966-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
References: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v2 is not a trivial device, add it to a dedicated place. The v3 is
similar to the v2 version, so add it as a fallback to the v2. Both versions
are already supported by the driver.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
new file mode 100644
index 000000000000..21c9239c64dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+
+maintainers:
+  - Matt Ranostay <mranostay@gmail.com>
+
+description: |
+  Support for LIDAR_Lite v2 and v3 laser rangefinders. These devices
+  can use a simple I2C communication bus or can operate in a PWM mode using a
+  mode control pin to trigger acquisitions and return the measured distance.
+  It also have a power enable pin, which can be used to shut off the device.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - grmn,lidar-lite-v3
+          - const: pulsedlight,lidar-lite-v2
+      - const: pulsedlight,lidar-lite-v2
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO that can be driven low to shut off power to the device.
+    maxItems: 1
+
+  vdd-supply: true
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+        lidar@62 {
+            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
+            reg = <0x62>;
+            vdd-supply = <&vdd_5v0>;
+        };
+    };
+...
-- 
2.48.1


