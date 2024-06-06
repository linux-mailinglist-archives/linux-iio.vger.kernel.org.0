Return-Path: <linux-iio+bounces-5927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA28FF27F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A21F26FE1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF719755C;
	Thu,  6 Jun 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtGuUN19"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8917BC9;
	Thu,  6 Jun 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691420; cv=none; b=eUvknEsESBzDthEUVvRsgUqj11PmfuZjBVezvTKNb7Pg9+gZ9yiXPRKAGON5jJSEjpiEVF3rWbnonqsI+3mAnGoa308nUsdijrKapZ1WgiaYNWJr2h1WExW8KT7KJBzcZ1G3EAOeLHO66bHl3Emla7EhN8wl8KhJ4Z1hfeThsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691420; c=relaxed/simple;
	bh=lPAkVjXgLxFt5LPmzKwEMlabNfBjX6NWCwqF+0qLZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlAaXnU7Q58VEbPO0iNwnCRnDEyVlWIPTHiTvwQSwRm098b6q+gUxbnjkehYSqjMVeiNbg45csBPYxjYmCThkl1OfbjURnG8/lR/m60FXi1gjZlN8dCQ0ZY39cIL/6hVQAk6QwIPSlNPddxfHPIAfsNpttUVSjDTKN16CCWHVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtGuUN19; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so13241705e9.0;
        Thu, 06 Jun 2024 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691418; x=1718296218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqZNbQSETUuCOGmVNmSSKbXWwcQfdigyBoaPoEicrs=;
        b=TtGuUN19w8mMp1fGfSBkzor+sumOvnHAfSxVG640fj4/UO0uACD290KzI8XnQw+Bl8
         7y/19qlKKOuY6Mr1F0Dc8G0usXcy4eE5hGFpHQthMN1cFp4fzqJWTUutkmOUzlalhBRy
         oyMkEeIR3w+GUkRpPjvsVZ8M78ah8X8A0b7Xmo42YYojQFjDnRz86Qaa9DOTzpi+OhRv
         r6gXT2apRh2CsqPdO55JCC53c9TASDHUBhaVAdTzOXNQbStEFjJSX3TPbMkpEBajqufU
         TdRfJdoxHgG/Aw6TD9Mt5CfrkuLfzXdUeRynCkjbYzTBsJ449Ige8USDMd7FHhBLzis6
         LDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691418; x=1718296218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dqZNbQSETUuCOGmVNmSSKbXWwcQfdigyBoaPoEicrs=;
        b=ijH2xHbgYNG75VSZidTEaeMZ0VHOKJIfReb1cvab6Eb4iMlTUhAJO6IcgEsqTfijdM
         z+mxzGxfNdbs9Yv0fAa+SiMYKCUgEjnLjLwpbDQVPKOgX9GrTgPAacbb3NzNPNIMTdmG
         vSNgEK/iGDmO0xSBgSuUQOXgc/sIVzNM+I/LKJcO3fSnE7gRdV6kJGq1jqWnxCf83Mdg
         IrOsxOE0c41BWG0/kH7FOQ/6WV5qv737jYwINGp301J3Zr8DPMA4Wspc0n96Ctb/OwJs
         J8eC7kpP96LFfS8r7/i3DMHT5lKwkF94YxqQkmZTIkWr8ZYY/CYf/N0a/zvONHoiffJ2
         /uNg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Z/alAbX5VqJRYxn/ZqYST/WTJpuEvvaRjLRjFQwCzHZIadacVWqRG7QjzqETSItiU2tGkzJYQl04u4XI3J6qVa1ocU1/1lFP2yNlr/ofR0WoRXhmgA/thuYlrDhVyxcde7a2CzzXggfj5HNrSPase6g3p8refnc/FlD9Sktf5wQzdw==
X-Gm-Message-State: AOJu0YxhdUZVpnYUVVaFenZ7h5bK3C5JHBLakZM3pLS01TimjljcYGKh
	WT7G/VGkCR8tFSmO4ovkgILF0eVgH6vECyo3FPxE36PpmIWbNBLu
X-Google-Smtp-Source: AGHT+IF21gop+b6k0JGHvqQYWZPu6iKxpWuDjEOjifn3fDeBBgYpbJeMFUreivkoDhv2hYUwDRCxRw==
X-Received: by 2002:a5d:65c6:0:b0:354:f622:fc5b with SMTP id ffacd0b85a97d-35efed2cb79mr99952f8f.23.1717691417331;
        Thu, 06 Jun 2024 09:30:17 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29a85sm1978307f8f.10.2024.06.06.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:30:16 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: ivan.orlov0322@gmail.com,
	javier.carrasco.cruz@gmail.com,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Thu,  6 Jun 2024 17:29:41 +0100
Message-ID: <20240606162948.83903-1-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3->v4:
- No changes
v2->v3:
- Move 'additionalProperties' after 'required' block
- Remove block style indicator '|' from description
v1->v2:
- Fix yaml issue: Make `maintainers` a list

 .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..d5338a0af6b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bh1745.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1745 colour sensor
+
+maintainers:
+  - Mudit Sharma <muditsharma.info@gmail.com>
+
+description:
+  BH1745 is an I2C colour sensor with red, green, blue and clear
+  channels. It has a programmable active low interrupt pin.
+  Interrupt occurs when the signal from the selected interrupt
+  source channel crosses set interrupt threshold high/low level.
+
+properties:
+  compatible:
+    const: rohm,bh1745
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        colour-sensor@38 {
+            compatible = "rohm,bh1745";
+            reg = <0x38>;
+            interrupt-parent = <&gpio>;
+            interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
-- 
2.43.0


