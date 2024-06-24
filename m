Return-Path: <linux-iio+bounces-6852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710AC915951
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 23:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E346B23B32
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D913BAE5;
	Mon, 24 Jun 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE8o37P9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFE13212F;
	Mon, 24 Jun 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266158; cv=none; b=O2om+VIOi11RSXvCtVcbn+m1c0B4AdQ1YkLow6cCECsX2A15XcPqGMVJsyxDGoJZU7y7InguNqDcfEeMsTtH/iDcHT6gOJeC2Td7iFua+UeiI3UUf1pfHG1olXG2AgBZdDSrO0EuQqOIpMXmvLp4YH2sQ0hqtJPN9Uca/nM9tkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266158; c=relaxed/simple;
	bh=nu9hf4zBTCPymUbXOg6ds5DmhO1Tbr0BMjLa9bW/xcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZLYAs5YGKnIRStRcbRM6yvOvMrTjcIfUV1NNgqloalJS3fMKPk9HR4tTRcfZDfm8vOcXMH1F42KomQooUThNerXHt5Xf6OdMejnX3p8FCCiJ1I4Di9zJVcKL74KqcePgHaVoVAH72+xKy5KRHznGOl13iVRFDdERx64Ipw/jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE8o37P9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36279cf6414so3885762f8f.3;
        Mon, 24 Jun 2024 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719266155; x=1719870955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvQNZENemeOjcFKwhYmXalkZhkHi3PnGEf5L9P0Eqbc=;
        b=UE8o37P9MbxXGYzkGW3rv/XveeBtMFceG/QvySc7nZP9CA3tC/T74nAEy5Nd1REB0d
         ZxFtBWX8ukCSCEF2nbP+yKW1eb9aeHt5bZK8P9qzbl827og+KjcNZb/vlgobp4mBA8DQ
         756jNexk6VwpwzvZZf340sUqmIyZRSAw5zP6pReqnfdM+WlijIfkYZjsudgRRkSV5nOR
         Z9j7CG0mUarnhRsCUpWuJTj8NW8EUjYBguCBKxtCFz4Pgk1j6+m8LXJImaDF7ISvRGYm
         6f+ju5/BYA9nzZBGoUwZNbcQe5TPUfIYSUHpeKrNkghq+Lmojg6d6JZYwtxVD5mcmDc1
         mORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266155; x=1719870955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvQNZENemeOjcFKwhYmXalkZhkHi3PnGEf5L9P0Eqbc=;
        b=Fsnvu97mIWT6i6kY/6fmJ9727v04ZvmA6y8ZySoOv7CuD8i53frb7CWLxcLvDlUr7+
         1OBgur4u8l4r/8kUlKnwYpLkzkjKIBP4gzoBRmbAfRNapDpWU1Nk+iwMHiUwz4nUTzrh
         bAqpohFxVRbOwItOms6a9hLEzdD9GN7I4yveU6DVHJyZ1X13XEQ3eHTLEqK7/OrN3q/5
         Sf+Ava3sbWnl2z7MVLQsT5VbV4NbESNe/6c8w2xDFN2rmcsSmYO7UTKC0fiLjh6Zxrop
         1tkON5NjUDw8rE/2JGTVx602X2f6H4uWRjYJnZJDN6HLBTq8q1zuSNxnXLsWGtGJGnhd
         Eldg==
X-Forwarded-Encrypted: i=1; AJvYcCULwbHGfz7PuHXD8JKLyVJEzLkeujT8EPkokjsAgjgo6+CyvLNYcH9+9SI+uAVvpzDNS2z5c4HQzxLL8YXVdUkHj1MmQXFqwlyVP3/ZVs5h+tvNawf8NFoyRDGwkLo5MwKVwn+1yveaAVrkpuiEhNhsKZgvUXk05hBerEhOFsGPXPYVWA==
X-Gm-Message-State: AOJu0YxZ/x3iIuxnPSnaTT+sczx8MEVlxrTz5FtWvzBd8nMWXfeX4J3w
	43FmESo7n9B5h4+y1qJ1xFzvjlSsWSbMDoWbpn/UtLsIzWEHB5khQbUwZ3aSMOo=
X-Google-Smtp-Source: AGHT+IEUPhE47Q9XowXdkVFPo6xDCLln0k8sBFjyTJ126RzwMqjM9A4wDdm8ehLS/kYUTWeOZDnOcQ==
X-Received: by 2002:a05:6000:4006:b0:366:f3b8:14e with SMTP id ffacd0b85a97d-366f3b80284mr3085520f8f.11.1719266154699;
        Mon, 24 Jun 2024 14:55:54 -0700 (PDT)
Received: from localhost.localdomain ([2a10:d582:37c5:0:9794:880d:f77b:f133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366eaa892easm5960859f8f.71.2024.06.24.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:55:54 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: ivan.orlov0322@gmail.com,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Mon, 24 Jun 2024 22:55:37 +0100
Message-ID: <20240624215543.459797-1-muditsharma.info@gmail.com>
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
v4->v5:
- Add power supply info
v3->v4:
- No changes
v2->v3:
- Move 'additionalProperties' after 'required' block
- Remove block style indicator '|' from description
v1->v2:
- Fix yaml issue: Make `maintainers` a list

 .../bindings/iio/light/rohm,bh1745.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..44896795c67e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,53 @@
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
+            vdd-supply = <&vdd>;
+        };
+    };
+
+...
-- 
2.43.0


