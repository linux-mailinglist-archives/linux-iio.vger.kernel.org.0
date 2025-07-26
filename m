Return-Path: <linux-iio+bounces-22026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E611B129EF
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 11:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0EB54681E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93C22D4FF;
	Sat, 26 Jul 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqzSq6l4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760DD22B8A6;
	Sat, 26 Jul 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753522659; cv=none; b=ZrwLLA4sJ7M4D+ZMQcor1uhvPoYx/equPcfC4q6AVjOx1BtPCV8dmX361RtQrT+fZAc2dpK4ZsvmpyMs3uxUYDFqsqGfUKpN7AtTdB3UuZC1oqZgqKkeGOIGZFv6GhKPji5viXZscxFPvdwSy11cJhiEWrqnwdP2PktHZvvYsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753522659; c=relaxed/simple;
	bh=YikUiqRA8xpKT5soIZ9OGXpDgD93HOToMkMKiaqpL0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6vm4UHcdLa8mBfwQjvkVbz7McW+TB8TVcYLOTAkJ165Q4k/Yd4tOePFVsvty4fNx7UpOUTcsbqUjTBZAfCK2vl8T/h3zsluSK5TDOr04Vp/y3TLPo4tFJ1Oj8vqgqFQQd0PtqNlHWOOOkwMCNQu5J3rVYQqRTN04uUwySBLvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqzSq6l4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b9dfb842so25958015ad.1;
        Sat, 26 Jul 2025 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753522655; x=1754127455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8FJXyZKQ6+wLHT3l8uRuQR29jGu7fgr0VsD5wmepaE=;
        b=QqzSq6l4/QvGxG3jKPs6e289p9ffvKbHjK/DqdgoBRTM42Ow7cEuvWtKp59CVW2GtB
         3O7gpi1Y65jjzBxMxp8HhoI6zRoDohD5IowwY/ddbADY+SdCXwVGKvlmdLNHk//yH8ni
         OaeyaZdyxqcla9i/q6OD49YfglPOnNGxJ1tjhuO2XLMCERvHfCitBb20ntqQEHgRLtvF
         UA5NMasYujD/PH4w5OfhxZxy7XVPiaYxWymlfQ17s/GkH9mE6psw4DIOg2dNVehNevvY
         5PqoliRZr7iOLAywpEpbUNSN4PPkP5mVFcrdN4AjRAwrZIdLFn1MKoiB6+xNHDgbpc+E
         Y1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753522655; x=1754127455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8FJXyZKQ6+wLHT3l8uRuQR29jGu7fgr0VsD5wmepaE=;
        b=ZAX8Xzs2gF91BKMSZp4Sxm37fsD5K8OiAq36Ida4pc61j8qC+dn4DP9/gPZN4NfVac
         hRYFdJTCWH2N0DhvmVhzdSiBo519DUKBTT8R4b2+EFY0ZORa6zxSMyN5BtzkGpTMl0DZ
         WAVR+Ipw2casP9wVr+vd0DHQhpx+/ka90dUVpq/UUc6Ujdj9rk8P88Z3EWBFgXOmD+ZA
         QFe6JqIR6PS0kueQt8Svn2lwb7sIlZVLUXXqgW71aCh2VHh9lpWg/lXl+Y3IIDasm9Q0
         n/P51SbY/ag2jEWfgAJaOtI+Rz5w/0UPcXdOjZ+GphqHO6T2BONogkHBnaR8GwQ+S4QL
         k8pw==
X-Forwarded-Encrypted: i=1; AJvYcCUZijSq2XVZP7bAp32I9OXS/rbkbIapCRNpRuwiE6xhKz9G3RT6hFaZz6KQSSiMIUnt+WZUzZ4qJSUw@vger.kernel.org, AJvYcCXg4EyJk2VRUidrhFNHn61Q50A7J5Fd1kG+kq1+5TniaqNnNQWCqdaxrGCVCobyvUWpHxFp8/p+4Lw8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxb6pP3Zyy/LGh18ln2Zqj/6fWDNX7nF0fMO/aAtU6+U+X61uY
	6R6smSLeLHmXumAvTH/rdkyaMuwTjbkxmYFGkW9dce5GM04gW2csKXv+irxqD47D
X-Gm-Gg: ASbGncsvKkMdadUDM9rEiw4LU1fpQRf40MGahQh8Ja2tVWDI4XS31/yl1J0/Yqabs0A
	px9ZiP4rofYkGlyjc+r6Hc+Bnmrs6uHdekAJ4b7FrWCBxYnzQLDqQYKY3S9M3ZzNPpKy4e7Z0Z6
	3Zc0UtYKyTFOh/yyuqEfIiwkk5+KKLsydmcKcBBUWzBglvitk9h939UPE4ww7jz3Y2W4pZgQtq8
	lgwSP1fTgZTemcsoH+dCxVSNJEXQapA3za+EztCinXXwLWuRae1pwzLmdDMg2VbmozOFRCQm7C4
	oTEL8PtpSF0N1vwf43Gq74zf762Lk5TmlszjaKtloR3ihiN6qSOFaEukbs8w5FBpFmRa30UE7XO
	yHm7vjExrA+vMOYnFeN7MVRmXB3pEFws=
X-Google-Smtp-Source: AGHT+IGE5xASJDt5h3p0OipW4BKu/vecS45qnGYwVFx4ajTK+ocIv65jrhErr+MuEYCGzszU7z46NQ==
X-Received: by 2002:a17:903:1b6f:b0:234:bca7:2920 with SMTP id d9443c01a7336-23fb31570d1mr96622025ad.24.1753522655433;
        Sat, 26 Jul 2025 02:37:35 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:9097:1e31:2e60:cd61:c2c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30ff62sm14038745ad.38.2025.07.26.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:37:35 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 26 Jul 2025 15:07:02 +0530
Subject: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753522640; l=2536;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=YikUiqRA8xpKT5soIZ9OGXpDgD93HOToMkMKiaqpL0s=;
 b=k5sp40Qv72w7LhnPbkTsqoHMxdZDa8/UQCXJIb7Ll+WiyEu/4yxkPALxH1eExOGwpwK30/Arh
 SUUs1md90/hBH3G/K2yZJMZoH/MYRztNJtamiIvL+siaHQ+cXVWpyWM
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
controlled by I2C interface. Main applications includes joysticks, control
elements (white goods, multifunction knops), or electric meters (anti
tampering).

The device can be configured in to different operating modes by optional
device-tree "mode" property. Also, the temperature sensing part requires
raw offset captured at 25°C and that can be specified by "temp-offset"
optional device-tree property.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 .../iio/magnetometer/infineon,tlv493d.yaml         | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
new file mode 100644
index 000000000000..0442cf41503b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
@@ -0,0 +1,57 @@
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
+  vdd-supply:
+    description: 2.8V to 3.5V supply
+
+  mode:
+    description: Sensor operating mode. Must be one of the defined enum values.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # Power Down Mode. No measurement.
+      - 1 # Fast Mode
+      - 2 # Low-Power Mode
+      - 3 # Ultra Low-Power Mode
+      - 4 # Master Controlled Mode
+    default: 4
+
+  temp-offset:
+    description: Raw temperature offset at 25°C to apply before applying scale and correction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 340
+
+required:
+  - compatible
+  - reg
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

-- 
2.43.0


