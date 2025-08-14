Return-Path: <linux-iio+bounces-22707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FAB259A4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9DD58290C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611725CC40;
	Thu, 14 Aug 2025 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR6tajBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928725A2A7;
	Thu, 14 Aug 2025 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140062; cv=none; b=GURvsMibw9CB3MPwyJfatAXkOQu3TaB/LpW13ubdAUAnH75QfvaCAQwqfeJx5AMdh62MoXfPSzzNgetHChbXwjh23J76nQuIF28ixYyfq85pPJakyzWxbkXJzkAPsng9KsU/OHvlsfPm3Qj11sIhstalfapMGcwBygGLI0Qy54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140062; c=relaxed/simple;
	bh=DUD+i5GUorzmyFBIbvOlFraLYTZ2PMn7XBjxYVx4gNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ffnzng3vIe42OjwS1ircvbjTcZmvP5sxW6xfGSCatU3peK46HCb2EOrLRAwP6L19U7iPxkrEShZ+J1R3NmJXQd9g1/S7vMwr+J5WLLqJQYqcCAhI5C7GW225v0H9eAjVWpWwp48dOuqGZww2nw8v0E9kOJKM/937lKqE0H8G4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR6tajBe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e614b84so542559b3a.0;
        Wed, 13 Aug 2025 19:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755140060; x=1755744860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcSr48CYfkXX8nf/xlhKJbn2nmydypNX8xOgSCNkXgQ=;
        b=bR6tajBehw+q5/lVVjX9Ge+9B+ZrP/dMW/TqQxvMOY72BO4SSckYFOT4wZwMi4nOzX
         kiSR8BvhnEsbPgE/bnem4Y3hEM9PU95nXVBJXHfG8Xef2ltUzd0Pjt5rPjhk4s0OaDBl
         LBXv0zFRH6LBT6jegV4dGM+ODz2kKTL/qAwWTFWR/NF4AjMmyrvw9QXP17MLjafFt4r8
         1TluBBaPv1qyk+AT1T0xHj8gwocAiMz88Oxp9bDh5iFFIe0au+YKXaPPC3QAIsfm0gjw
         e/WVeyus7HTg0o/wnfQgc/NdB3uH0/ybaFSmENML8aFFrNY8TTumJHb2Tojt9g+kVrdQ
         wqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755140060; x=1755744860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcSr48CYfkXX8nf/xlhKJbn2nmydypNX8xOgSCNkXgQ=;
        b=V5wzDG7tAbz9sz+4p64xZNVx+XNYfECJaciIIiwv/sSIEegivsssdRJjUJji5/u851
         UcflXGdmOnTkycIPbNVwSHgU6HTqN+yqAxXP1dEmpn09o7C0mc+7d2ed/zxTUinjGScG
         0OY39GrLmWueRabRuTg1Fy3yuKdZm84fbTGUwSGIa+uu2uQjLdm9sMIwKprgbrzLfT7G
         lEJIhWnx0nMLee9gK6TnAN4VAFpLsEVUXB6n4A0ovlrOqi/cRZqm3lX/3aaFoquLn1aS
         MBnAgazR1+zctWDYEBWBUjLF3Hh+vPG4Yc9GWWfOawxDpIpehEQMpO1Khdo31TgUs/6H
         YUbg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xQl3ifVVQ/fflJ2S+G2I9t6l0qf9gesHDdcNWkg1it4+GOrqFNVwnZKf0rrZ4B7ItHgoCdBYqPx+@vger.kernel.org, AJvYcCXaCle4ldoscoYg1B4fku1W5ld7RMvKFujViciOcawfLx/6dwVGKbfZsDQyzZIhq68Fo55eaQeejJ8v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxhiu1GR091E6OgUt7MsRYuBSP/1CFt2b82EneKregVc3kLd5V
	0IL8mjpvttPtV70Tajc0Hr065pHFZrSJq4/R1U13WvutZdxpTy7Wbfhv
X-Gm-Gg: ASbGncuRGL6GWiu5kojPEjibXdamZzbUN2GwiS2ipINqRnEvRjXPUkKaxUGCxmzo/GJ
	N5kzRTP70/+MOg8K/iIQcOpupp37zhPufReET50BK+4kwaBHoQWiDBmmBgxw/3K7Y+GH2u+FVM8
	OaI0urjWBAt6uRjpPJGO669IOWsoFVoo+1KmDNGnCGTHgEXAfbwZkfqFOgXtmKTrsYGgRLHXiMs
	zMAwKR7jqDhzJVOeaITkigXNgLciN8xh1QsoRiBOVcc1CzSslddDWy0kwh/v2LEPhcxAmInfr6M
	BstvMkuh8v3PYqVAHk3gSTYu3C1fVahDNavXhIwMsHyFEZ1EDMxfg0i8XIPV3BEnx8tgRuVEAn3
	f2slpZaxHEjjIanci+j8vxie2WqPm6A==
X-Google-Smtp-Source: AGHT+IElBKzQsJtO7lQISS0E15pxdO9aXaHMpROIQ192oq/xulwkXmjJ3tYdIcSz+3pkY6DlmwYArg==
X-Received: by 2002:a05:6a00:a29:b0:76b:f01c:ff08 with SMTP id d2e1a72fcca58-76e2fbe9206mr2083620b3a.2.1755140059842;
        Wed, 13 Aug 2025 19:54:19 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c45:768d:a218:ee72:b12d:78b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c09adf8efsm24716473b3a.68.2025.08.13.19.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 19:54:19 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Thu, 14 Aug 2025 08:23:44 +0530
Subject: [PATCH v4 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-tlv493d-sensor-v6_16-rc5-v4-2-81b82805aae0@gmail.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
In-Reply-To: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755140034; l=2793;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=DUD+i5GUorzmyFBIbvOlFraLYTZ2PMn7XBjxYVx4gNA=;
 b=fKg+LPMNgMuRk1CcfnY3/tDWxLXHdQ5qWhJcu9wUbiWhO7/eZI8pdTnvLcpg5mS1kUxdhMW9/
 rbWwEcVUvETC2CmZpQYfaUzqZRB60T/A9wNYR2pOcv2LP/oQd1k8uZS
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


