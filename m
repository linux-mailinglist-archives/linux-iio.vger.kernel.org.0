Return-Path: <linux-iio+bounces-23823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3734B46A32
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 10:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDC7B2042
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64162D0605;
	Sat,  6 Sep 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fniX6pfk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E42C236E;
	Sat,  6 Sep 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757147890; cv=none; b=tey9VcOtIBMIKAairHbD3a4kudtOYxtzXJjF3plOgyDZqbIdvre1rl+6owEEpNW8rn1/LxvW5MRXyS0hA4dKPPA9cqpbBZY76DEAr3O51agd7GBe0FIdN7dF2QFNvOxiE6QD+Gy2vy+ijP+wt2MUBwySikKksoAgeIUMMH23MJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757147890; c=relaxed/simple;
	bh=2AkjPsVosZ9eloTgE1E+83+bxmH17+ZZrK8WnotgKaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kitz3fJWpfG71viDCHB/iCD1XtWEQP2C6FKI7C/33dDHOdWsVLSYyB92D74CfnwlwP9JKJhR3669aLxxy4eracxAaPMk1SILcvdDtwWo18jW+Mt+SsRBegtHeTkZy3kIRD1psnaA8AnCarM57NgKyP9sI8u7GT6EXJ+KGjsCDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fniX6pfk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2de2e427so21137765ad.2;
        Sat, 06 Sep 2025 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757147888; x=1757752688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBxZY+8Ag+mmRsTTSHl3uoKMcvxb89P67hpimiu1QCM=;
        b=fniX6pfksq0zAbcTlYqBtr7ywZeFY4TEsxenD9iXI/+iJZ146G7K8Hh5HKQAuCTJPj
         OiVgub6GuNxJUeFqk7u2saPAgv43Y/zLfDSXBUuthW4FLPWoxArWKIKp7IHpU1jSoSCp
         Gp6QYqh3MN6XuOljObQ8LPIFBT0Fjp8GiA9PwBkiwTEFWmYdIzTntV4cO1wScDwk5bNp
         oivlLOhIS41VrcJy6hs5Lq0NcSo7212FSc2OAVYZHpn6iR3D8YModl+5y9ACSTwkjAS4
         oL7ldigETJz5ivuLYjl0Il/fYHXl7LQ4gsaZQ01Kv98TQjhTlcCrpXMCeDUeUIEsE+rj
         NcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757147888; x=1757752688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBxZY+8Ag+mmRsTTSHl3uoKMcvxb89P67hpimiu1QCM=;
        b=C9utvTh5mkXSfpEDS/kavqR5CKkJeKKnzuI3A5CCqfZizyTiqI0qNq7mb2w9d/Bt7G
         qgWpkO9shjC/J2IG2yoYPRd1MiCM1ha7N1COSGwNsLfYfpuBJCFJ4H0gpXC1cml0kPUR
         oWO38VAq0mYMPB0i1+mNpzXFKFhaP99ika5qSlk4rZd5EuWeoerJrWV3VoVVsAHqraLf
         DbW4sxYutYHP7QEJBmdYoawSVJ6U5nlLZ61vd03CQTcSUeuy3SrbUbhQVfDBlZxD4WOe
         tnmusjUaMT6FPz3XvZ5PIZJg/+iphEPZkpOKhStFXUs72d/NG7J6LzWUUb6Q42pN30fG
         yc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcAWyBxm6nFGSaGckhztSuuIh60dC33EpbQq019zwPbaci2uQAHCHfNtDNYC+bY3gMOTGyNNhQX6V4@vger.kernel.org, AJvYcCWn1Hkx5xsk4FBWAyJxHm7KZOFPT71EhiOSEk0ITOE8CQIoy7Hdy+heOS2pfIziy6nT1MiA5/OS51C6@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvZzVfSRmsEHT0KUO6MvVkq/0Cw1ptfK9RDn5aS3pPi5W531E
	H5mmKqgKpcDv5BBy/VOhLo3/h07th9jLO06RoTEsp42/lfrAMrZ6fXsV
X-Gm-Gg: ASbGncuAf04fxCCnRlf3ooqfBeNrOgK9Zpm31b3yMkD3YEEKOrnpHR5bZsrP8B/vCm+
	LN78thWL0dV/9tmLkeqk7yI8c9YMfXYVrP2H6aVqPYa9y8zvh0oyMLBB+3EG+rJAef4jHeoSGg6
	ggTYLRAT7VRLinaGZeAvcyR0eKbs4U2e1bKo2x9JipvFiMKo1jCYTStqLJAu1wpl9o//m5rK36t
	xQ6jgZuaXjAsVV7ntdyO9Er8bIQkbIYweQIOpoe9J04fOjeA494f0EX6wpTM7NKSz/hdCD3zR7/
	D18JcZDFrfeANQp28BwZBDhTtHqEWFZFpXfzgukeEO/8Adz689GUHrKXV8xA/B62mnrLVMXcb9R
	9onyCX72mMetX+w9KxfJiPKuEPyC6RMjHzzRLQaWFXA==
X-Google-Smtp-Source: AGHT+IHI+AyDRJ8i6pH9ZbZHkMSDBqwZzXiq2xUke54xeKI8CKJ/67YApAzGtD1fHYbYpjm0RC/Jow==
X-Received: by 2002:a17:902:d541:b0:24c:d717:71a8 with SMTP id d9443c01a7336-25172b49a1amr21746545ad.48.1757147888268;
        Sat, 06 Sep 2025 01:38:08 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:6dc9:9ee4:9664:de3c:82ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e480sm116577765ad.130.2025.09.06.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 01:38:07 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 06 Sep 2025 14:07:56 +0530
Subject: [PATCH v6 1/2] dt-bindings: iio: magnetometer: Infineon TLV493D 3D
 Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757147878; l=3403;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=2AkjPsVosZ9eloTgE1E+83+bxmH17+ZZrK8WnotgKaM=;
 b=zYg8BuhYyvtpNxqcbhIznVan7e9BXGsaTSInew64MeEXooYUm9r7hyo6RUSLu+1GFrvQMRS6t
 3dGbE6zgLSXCsd5jhurTH4LCN1MrRtJmmOri7FNEHYFk1tSenYsSxOF
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
controlled by I2C interface. Main applications includes joysticks, control
elements (white goods, multifunction knops), or electric meters (anti-
tampering).
Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
its documented in this separate dt-binding file now.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    | 45 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 MAINTAINERS                                        |  7 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..35990c2701f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11843,6 +11843,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
 F:	sound/soc/codecs/peb2466.c
 
+INFINEON TLV493D Driver
+M:	Dixit Parmar <dixitparmar19@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://www.infineon.com/part/TLV493D-A1B6
+F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
+
 INFINIBAND SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Leon Romanovsky <leonro@nvidia.com>

-- 
2.43.0


