Return-Path: <linux-iio+bounces-23351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDDB3B136
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 04:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370D0A028D4
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 02:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48431223DF1;
	Fri, 29 Aug 2025 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVJD8yiv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E121FF41;
	Fri, 29 Aug 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436044; cv=none; b=ITv2FlbbGFDaRuRbE+a0U/agbRiKzCZj5CH+gKSOTm+DDB3DToo7Hj+K8XNdam7xOwk/tGWS00k8luCAxm6UORTx/1dUnLJlwnIWwpndITuAZFun+MnICXVKKVbrRlVhwhx+jZ/4WQFt+gzgmrPg25jAZFUJhwTZNlF83grBaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436044; c=relaxed/simple;
	bh=DUD+i5GUorzmyFBIbvOlFraLYTZ2PMn7XBjxYVx4gNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFV5ixZ5PpBavqJ26zlobBWJf/W4jBBoz+Fo5x/pExFkYUqUuRjhpC40qPthTk00/+OmWNVQZuIh1Geo/+bjoSRyjToowURVi2liSyzJCdCVtuN9ubtlnV3g156qB7mkEtW8RTUXbLki0eobSMa+kl0W7Tc00WypYrvgsSltGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVJD8yiv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24664469fd9so15178205ad.2;
        Thu, 28 Aug 2025 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436042; x=1757040842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcSr48CYfkXX8nf/xlhKJbn2nmydypNX8xOgSCNkXgQ=;
        b=DVJD8yivkgpXh7n5Kzr5e8WDWdhPCn/eN5ek4gf0iqBd9aFhaH35fUMdYmajOfgt40
         ITbuTxKhMiIYxP53A5kFIHMoID7PCGUhx3NBMG+xYE4+HHqFS1iE7e8mGRnquyN2Xjud
         NYzU9NiI2LG6l7OcVAmEF7haTg55wmfF7MYHJxkebfEtF9QTAcHYG5m6rfqB3jBDasWG
         AOtp5RmpIwWSEwpGKWpuWLMG4JJG0rkNdrJG49cKB9jpU8TpBks41UE0Q9zVKXkHgdH5
         SQ1BDH3p3gtvHaZK2y2idKTc8vYnSB84pVzTJz9r8Hpc5ufuS8xyd2JmF4pcJLyySgIi
         COYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436042; x=1757040842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcSr48CYfkXX8nf/xlhKJbn2nmydypNX8xOgSCNkXgQ=;
        b=RpmeuzCCk87E5KZv1DMjReomw4+bQrKmDgJ33WQkLRsqFTyf88H3fSftfVHG3YhyYc
         CVBtf9rFGmGMis734k1EQjCoOCI2z2//XDE9duXB4dNiewbiYuGnsYmhN5DUkavpK5SO
         1bwHq7TlliZUgLanFU3tKKzI1k1mYT7fE4eZjsKJ5Mau+/5yz1aj4hGwhgZQzkgNCj04
         afbCBr2+wOKUnKy5zkn8FBMmUH9r01AYqbBp9U4kTufXqV+HIh8/S+onMApGa1zyIj98
         MKbi8zu1RDQxWq0lswXMWiDEfdOc3a+7UeBGeKS39afrd3GF0Mydqa7DGct4hnBC8QCN
         cT6w==
X-Forwarded-Encrypted: i=1; AJvYcCVRH0e0o8o++uMCZKtarzam9PMPGv+F6cpbvgXzlb29n24ipusZEA4psowf+urijvlcti2ghsMUK9FQ@vger.kernel.org, AJvYcCWX3eHM6g3dDQ1ZolYIBnq/aVt5ViPdJ2oE7uhPYzhn7kEiZALi4BzGmjmV2uJez+0oG2XGf7g774L0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ekqc8WnZGJxVNaSQsdKX0Sv1E8OJTraf40J+IeHW9F2cDIyT
	E+1RQE5vxRQexltLxM5z7vHw416Vow5ZRy0wqdWIlMIrqi6n6W4d4JAw
X-Gm-Gg: ASbGncsSNg8DOUVxcq4lbq9/bkjHtGuZOoiYcAew1LcgWaLwbV9Qk2ni8p0Tt3AuuTN
	m7ExZAb1939OljBIRgsS/4sjsINFI4LNyjRh8yh5J9DwBEAkAuHw+xUrLXGM8GoOAC/cXtNdoWU
	obi66oQjG3Ek6K8D7KUn1vBh8yFJlkCE1wzz418ycALxus6NQYOLZ9rBkKQpWzLDD8V0m+6BQGQ
	Y+qAGUGOGtiZmYWl/AQNtNySjxb3E+iMe4epfuUfAUOm/UJmRsxx1EvyX8sdfT26YMpR9jWEvCh
	AfaNpuXkD9/U9TlVUbAD3xkIXxhVFXNwKRry/s/0iYZyLAfPPha+427CwgtfqWG6zgW83XTg0Oo
	fZMAkKsp523PiqlMUE/W+W7uULAfcLw==
X-Google-Smtp-Source: AGHT+IFvKjnULNN7spTEYINKRgDs1O9te9P2KpJCX2IWaeQTVgyMM1rkGHWhuc842FXyNe1GDbRFgQ==
X-Received: by 2002:a17:903:1acc:b0:246:6442:19e4 with SMTP id d9443c01a7336-246644231c4mr276089645ad.58.1756436041826;
        Thu, 28 Aug 2025 19:54:01 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c45:7912:56c:6aaf:9eff:c2ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm9581335ad.14.2025.08.28.19.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 19:54:01 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 29 Aug 2025 08:23:43 +0530
Subject: [PATCH v5 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-tlv493d-sensor-v6_16-rc5-v5-2-746e73bc6c11@gmail.com>
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
In-Reply-To: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756436024; l=2793;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=DUD+i5GUorzmyFBIbvOlFraLYTZ2PMn7XBjxYVx4gNA=;
 b=HTlOsLiTiR7A0V8vU8Uzr5avZy0fVI952f0cDhMWBxsuzmRqGTeBiNFCUz9h1P7proRfQKeEr
 43XAwQRIBLPAtvi0EJkME1ipOnbBc9IdOpZiF800Fak4BIowhoZXbo8
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
controlled by I2C interface. Main applications includes joysticks, control
elements (white goods, multifunction knops), or electric meters (anti-
tampering).
Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
its documented in this separate dt-binding file now.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


