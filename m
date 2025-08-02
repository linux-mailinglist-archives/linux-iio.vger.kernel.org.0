Return-Path: <linux-iio+bounces-22181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6EB18AEC
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4553162849C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A771F419B;
	Sat,  2 Aug 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC/ArMwZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AC1F3B8A;
	Sat,  2 Aug 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117091; cv=none; b=qvJA9YhaaUqE+kys57xmv2Gie6CT5SSNs8cXumekQpg9ln2/Ao96DUisHuJXaLmTnPoixXjBEZYS4gXXbW+A7wEGleIeOnHg1GPLpWMpjbFj0NVNz3N8m9/I6lLJSZpGscBNej1oqX4Xay7PHndDBA8/V2S9Z8W7CYDsJbKMPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117091; c=relaxed/simple;
	bh=5hAiE8yc4J2ZieVatB39vSlcnUHlw+uPSENDsajjkAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Omjwb7K9fM3IT99rwQ5blsT/SCcZgRvIOdVKns1cej/+uKNVkZdz+JnlXzcAt25gplD6f3fKb/FUPU7RohvILs6GOis6pz6fUqVegynid9Bynx0G3iVee0FNiUjcRhSMpbUWfn8zE/Jeuj61uhaezDznLiZpPPhULtUXfm3Poys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC/ArMwZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bc61152d8so2616447b3a.2;
        Fri, 01 Aug 2025 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754117089; x=1754721889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sALIksJdZiO/I2QuUa/2yG42xlm2I2ciXwgUed1B/JM=;
        b=fC/ArMwZyFzKJrrgozSGyRfT/qQozDXX2LjdlkJwg3vSCtTKal9Pw+7bhHnioHGgsD
         HQa6MCuc9bKxzRsG0JWXMeR5ArgYMe2tBtklxOyzmd2tFtrL5LISv10539BfRqzHGF8N
         QY3olMqFK8PUtlx3SMeETppuEACRi1w+W84iJ2Qgd5bcM0IsJ8PS+fLrSn2Mt8NEsJ2F
         TsA+9vp3RMmLVZ1Vm2FMXyTbad7Y4ln+kaCQGv5CNU+sdkFHCo8+L3Zcd50WrI/HU7oV
         Fvq0bcj4VZxQXpCdzmoXSxLzkeMPwu5Xdx30Ebb9nkq0K/H0d7R7PMBcwm3jC9FfNSbV
         SZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754117089; x=1754721889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sALIksJdZiO/I2QuUa/2yG42xlm2I2ciXwgUed1B/JM=;
        b=C5BvKooOKDhtZMy3kjtw9BD9WXjjhj5RGphxPA99u/wCadU5cmFJ2ETC87Exo8zxH5
         4octb1Ii6K5fqeAI99/k2BEaMHvEn69b6fcBgjYbdCYbf30LWEmA32lgW9H/C/X6BmyD
         /M+UwQKFRmiP2EQuWO/Ekm/tiaw520nOjg0eKFFGc1p0nRDKKkvOt8bMKkMpjOog73Pf
         t7et/af0poW/2qTAv++2xI+2xlNdhHsaXNi6oWywhVX/Un1if5yCMBcaI2r5HKtRTepF
         oULBm3xH2Ux13Larwh3pzuSLpLI2gug20v1Gh2QZ2jrT2JiXAWhiF90fd5QIlQo4TfOj
         MJdg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SKCMiiDITb+N2o9XJko4ICkVzHLVgahQ03m288FAph3hPLAaVEGfyByE9DV5V3vPhnGorcuiCMXQ@vger.kernel.org, AJvYcCWmzoo1jIQS/mzoqqorIHRK2Glpi5FGCF41v6ZSMqXDLw5wz6C0iYNtycSVbbopEjJesbBRvDOQwTzF@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9xJDCyjPVnPQaKDSELht7YjNGaGylgWCqRdVWJLjZ809/Kds
	K6YmQXCQIFOf38SSp7oDKyZeyI00fHLqkAMgdxakLBPlUmobLCO7KunFB4FfJab3j5Q=
X-Gm-Gg: ASbGnctzzbDdbjvbYbNy6Rw1T+JdsD+cRboTfM+d9ebSZItmu40qcBqYwcCmW9uH8IU
	o3Pq/T1cyaOXrbu0zEu1uiWFkIX1NqwnCCjE63/bNusdzogJ/lHMpkCakHB6mSJ8My3x2O4wSI6
	a6lsnY3o2o0CWKm416rR5e2RU3QdwiSbSr1AuRmGuZO3EBGuzK6S+2FziAWoMpqL2nTOGi+lyVm
	vofv+LSEAfMsj051MvsCjd5FY6lbDGXmsC67sIc1YJjKTeXTY/vJ1GrWrtQtkgck/1/OTe88Jim
	LCKe71XGk6WBsO4vL25zjPaAF56UGmnq1Qr8nlOuwcQOygmqN4mReNRKqy3jdzUBDJcGJ7Tz44H
	wJFd+frAiuIro1D7IaFN31FJtCuoVuOw=
X-Google-Smtp-Source: AGHT+IHUF2Py6OtHYf64+9507Sam91o2LQeeQYIoTEGq+P17Bvpek3mVB8CoNICmhxdUgySrnHJz8Q==
X-Received: by 2002:a05:6a00:391d:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-76bec352e73mr2541416b3a.10.1754117089312;
        Fri, 01 Aug 2025 23:44:49 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c43:2e47:cb90:ffcc:76af:a5b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9003sm5639676b3a.125.2025.08.01.23.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 23:44:48 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 02 Aug 2025 12:14:28 +0530
Subject: [PATCH v2 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
In-Reply-To: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754117073; l=2677;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=5hAiE8yc4J2ZieVatB39vSlcnUHlw+uPSENDsajjkAc=;
 b=VfyY3L8EYvv1bAMGzL3h9UYCx0UOG7l/EAE1k5SNCiVym51nK1hMPbgJhNR0l5+IKQCI87Nhq
 0HX8CZoW8bDBIF1etwwBoDTpM0+tMjcCdc1Gp9pdbtMIdj6otCZhwcT
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
controlled by I2C interface. Main applications includes joysticks, control
elements (white goods, multifunction knops), or electric meters (anti-
tampering).
Drop duplicated entry for infineon,tlv493d from trivial-devices.yaml as
its documented in infineon,tlv493d.yaml now.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 .../iio/magnetometer/infineon,tlv493d.yaml         | 45 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
new file mode 100644
index 000000000000..ebcf29067a16
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#
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
+  vdd:
+    description: 2.8V to 3.5V VDD supply
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd
+
+additionalProperties: false
+
+example:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      magnetometer@5e {
+        compatible = "infineon,tlv493d-a1b6";
+        reg = <0x5e>;
+        vdd = <&hall_vcc>;
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


