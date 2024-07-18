Return-Path: <linux-iio+bounces-7706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4993707E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE69CB21641
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CC145B30;
	Thu, 18 Jul 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jciSS3Dw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33D143891;
	Thu, 18 Jul 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340150; cv=none; b=Z7lyo/QIeT7EgLr/bzN38YtZBECAatKOyI7ZPcMgCZenPn4JlZIq9agiWmuT4CujC10JjCrRGBoL3c1y62yN9yngu5yPSKFE/sRwQsblZO4d0d5PwitB1IIbVHUtJhGU6wpGY260Gd7Aa0dbbdcDjA7tTT4mqoyH0gbXUKOWeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340150; c=relaxed/simple;
	bh=mJorrD2tnuyN7ngnHQjsdGPkLJyryGhiaujRYaKwy2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNrv7xVHziiZjcSveM8W/6ke8WoYckkBgVOuCkKrOQycI/RQqA7cC8axxEwUGYVdZcLU5DYg0k745Og2wJ2joora8NWYwDMBNLCmHNrgPaO/E/JYilQVh48wx0yax6XWMwBs2mqTfFG/A8V7cAxELGpzlDTQDMQjaaxQ+6o2Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jciSS3Dw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so6006695e9.1;
        Thu, 18 Jul 2024 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721340147; x=1721944947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UitsaCex0rhKIBN25ncNSW34VIXCM0DAlM4U4CaOTtU=;
        b=jciSS3DwJ9Cnc8O9W3ktdD2pYZsFAnc1PrEq+IgzTy5XuMVt9TONxO7ZUisZ80zPgZ
         Rnt1LBthbOZHQ2EjqEYfi/YbbKpR9nfOYw19TkoVgZXf4dR+WXPivxcmEHwFCoGnfwX8
         eC6qf4sJ2ROlHzkTJOliUzx/FwbNb2/lawOVdpkVZJofSt3R2ub9oFwTIJD7HkP/a/X7
         AF0iZ+cAJ3tPSOisRi1ENpxHDJ8F2GpjMefOj4e1Gi0Z6D8jN4XukCbFzTjg6Uk2kFxP
         0u9ARmxQqNDHGJuznBnk2LyF+IjxYMvvxbodRcishNN4V8FlMh+yWr8N2PLY9SVVRCZU
         c8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721340147; x=1721944947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UitsaCex0rhKIBN25ncNSW34VIXCM0DAlM4U4CaOTtU=;
        b=YILDa3djLTGe2bfwBz74Jfy0w8sdKST/fdtgMBZNPmtPqUeUhBJgY3CbS+Ze1vPrAF
         IRyptOMicD4aK+lFDtCd+GKDZ2Tczp+UsR2T7bYKWO1HJqYElwUiMwuOdUtNyn5jPQHa
         zafK+joPDJbit7Q4TSBinn+mykkdr2v5eGYe1eCfZmCM/har1nuAtVGwq56TdtEci/HC
         NNPvH+Bk0ioII/1nhyOk9nZqHYqLYPS3kjxKu4GrRsjZBw3vUeYTdk9DMxkvpjnrcFPh
         85AA3QhFNWRwx0Ob0RhIEo0YE+aweiuiIZbvpGmlRmfBvpULf9xal6NgxjuZyGJrF/UA
         6RZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDrlO7iuJsSTHXRRErZfVtuS/a/EUGtpI9GzTPtC+rYPgr2J/fQzfwtvuU4wnU8TwKEK55qXpTVa0ZJKpMtL5HJVqK11k+nvInIpaxj4MxUVURZPAvej7D8PKdKRk/U8d6WhfzFPYXzsN4CTGYR3jM/OAiNDPwXPfBp6osssI2Tb6txg==
X-Gm-Message-State: AOJu0YzGHF1g+9fZRPKZm2IdGSysbm/p5ZsBDvJBa9LtQ5ouephYNMlg
	yKqqGFybPVNkO36wzQTF2iN8K7nqSTCc9wshsdmc9B7L/f/VzuW7
X-Google-Smtp-Source: AGHT+IHhRQpjIqehS6RkFcjaxgF9L+d7kAwxV2D46PfGVsMhKByv0SHLBGn5drvJhiejRoCZ3FjSPA==
X-Received: by 2002:a5d:4cc4:0:b0:367:f054:7aba with SMTP id ffacd0b85a97d-3683175ce54mr4102591f8f.41.1721340146741;
        Thu, 18 Jul 2024 15:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2a10:d582:37c5:0:2ab4:ee:97a:e67f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936d62sm2739765e9.42.2024.07.18.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 15:02:26 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Thu, 18 Jul 2024 23:02:05 +0100
Message-ID: <20240718220208.331942-1-muditsharma.info@gmail.com>
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
v7->v8:
- no change
v6->v7:
- no change
v5->v6:
- no change
v4->v5:
- add power supply info
v3->v4:
- no changes
v2->v3:
- move 'additionalproperties' after 'required' block
- remove block style indicator '|' from description
v1->v2:
- fix yaml issue: make `maintainers` a list

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


