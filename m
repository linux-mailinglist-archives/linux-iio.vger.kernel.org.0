Return-Path: <linux-iio+bounces-7368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A78928F23
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC071F23D2E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 22:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A42144D23;
	Fri,  5 Jul 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJTUUPVn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7613C904;
	Fri,  5 Jul 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216896; cv=none; b=Cej8cm1zkmmjFYIu0PFUJhmMjbaEpCAL9GSOPmQ6gm1Bqq7HgjzenJK2R/GFFQzrZF6q23Jp65XgQ/p6flA65BnZJFGXgSEcItzLsEOF5n5zCzFM4qPILEccAAXTEbkHa04mbRPPvVsy4W/X8xNnyjPgiLPVnxFDiuZxz/K8BZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216896; c=relaxed/simple;
	bh=SAuIWm3wPtG2dnwpUNYqAR/1tQpz+ysEG2E2wedoVow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNXQP+2eeVVBLmu6Dz+rIN7XX5+62SvM8anJm0h9nlUhtauradeJJ2AI1UA4DuQTCXDay6BRsLtw3UsnaFP0VMXFdkAoSBa0Yfh9hi3XKCJcqAP8aYgBe4OP211FdCLr+SSPsmhlajnj9Y10BBgk3o/l2P4n8sEjSxaoBOkNAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJTUUPVn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a464e200so859270f8f.2;
        Fri, 05 Jul 2024 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720216894; x=1720821694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9lFkgeeclSskF6UcXnmfoFAFXtci4Vlps2yKhXYf0E=;
        b=MJTUUPVnpgVLFPoFU6FbGcIOYVzBtTWotzR03ftlcV0ud2mS95kCMQTZt4Do2ZySCP
         6iZQ6HX/hxsU1AzIgExHBpsrK2WMQnmzRVEEnZNEBYdC4qiwYn9HtJYCm0YRsOsIIZsw
         B/fi3Tq4+LIBpw7HO6l/aVCtM3I7PMPy6kT417Fvjm9zDZ+i2tA5xhIvBilumOw9mQNy
         UoOi7x9Xermve73sNGKBOdsYaDUKXtAhKAsKOeXT79mXNxOqU81FlajduF8Ydaa58ZcU
         wq9X88kUT42JK0Tofb8mvjDHkP64/yg2EyeGiKR6muJ/1/ZM+NtwXOXlo8EmRXhQQx8p
         6IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216894; x=1720821694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9lFkgeeclSskF6UcXnmfoFAFXtci4Vlps2yKhXYf0E=;
        b=qxPnsX8iDeyUTNchkAd5qP+QuhssOnp4OANb5kqVyQ0qqDagyOiPXXqESM2z3iQRtb
         KDaRUXb3ERK/K2dChp+6CAajUqYQNcd7eLMF0mUBigNEve3QdhPW4vRvnfVmzl2YwvWa
         2HRMUZdn+wcVRGOIMBgpfSYCrTnEYvf0RQtYr/5NeGZ1xZ9hnRO0S9z8AW2KzhmOnUxz
         ZnfZplb2r579qiWVrI/YwklhC92FS+T3/NPoxJ9iDXDPylJXfz1n3FPyavRoAKrI8coR
         /H9btGKudc78/BexcWLN6WK9K8dPuEgivHxAWFNUytGlE7Ou2OWnZ+TOXn/Eoo8Qov1T
         7usw==
X-Forwarded-Encrypted: i=1; AJvYcCVt4nKJMBSovijQVeDaSlckQfw/WvRH0PvDA1UrOW7iCFhtW3YNn5hGtdEmSlR2UaWdHKw6asAtlHpvHn+WjN6+F3b7PQt/tXkdT5krqAnb4oVznvDNagVkBhwZBPSD8pJQiiZst1wHKP4DL/drvip0xwcXDBWaEawbgjGsXcVWSVFizg==
X-Gm-Message-State: AOJu0Yw5uldb1wPO7ebHIWzs3VL2xl3obnINvgITGKj5kfGtM08zUbfC
	KN0Y591sP8XotuD6r1FoyF5rog/ffnllmTU98MlSeUTFGfFUE9P2
X-Google-Smtp-Source: AGHT+IFY+m4FLaNedzQANSY7YrWfKtoOsSmG4g8tV814E+53QEEAPkP/6sYGPWlb/SwEJ53Qal1z1w==
X-Received: by 2002:adf:eeca:0:b0:362:d875:6dab with SMTP id ffacd0b85a97d-3679dd2b1b2mr3949311f8f.25.1720216893156;
        Fri, 05 Jul 2024 15:01:33 -0700 (PDT)
Received: from localhost.localdomain ([2a10:d582:37c5:0:7569:beb6:ad56:8719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc9besm75443385e9.43.2024.07.05.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:01:32 -0700 (PDT)
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
Subject: [PATCH v7 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Fri,  5 Jul 2024 22:59:07 +0100
Message-ID: <20240705220018.414771-1-muditsharma.info@gmail.com>
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


