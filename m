Return-Path: <linux-iio+bounces-1775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA783548D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 06:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E00E1F21DBA
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6A364BF;
	Sun, 21 Jan 2024 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="OuGh2J4U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241B364AC
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814276; cv=none; b=Ba784oUsOJo1oCx3By5PNFGAk+14xQuDoVByuezRu3bxExFqSWs4BHnx6WMK7TXlUL2k9TgZ1CfC2hhXmnx3otxUmT/89njLb7IL18PpNuJ02P39XNbt2q2Sov0doxNppfMpUP30a2U8pOXFq6ed8AYQSwlhrRCglEX8xripEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814276; c=relaxed/simple;
	bh=78a/C/pLLexCT+VsDPwJ1QXzt1+JPkuSS1hne9CUx0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/Es/ohswpwmkzygk0iHrG7cV3PcYO1TyRY8YNu+QOPqTaX1qMe1Yv3OzUiQBQRZ1Mdfu9ETdYsan6PjYEWSfar2RhNDqDTy4cjYvCrP8qhB7Z5g+3/vfj4Gfg2aJzxtK9NYTWcnbcHINgUQ8L19D/eBXfiGZvA7ipdwZYw0kWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=OuGh2J4U; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dde290d09eso1520794a34.2
        for <linux-iio@vger.kernel.org>; Sat, 20 Jan 2024 21:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705814273; x=1706419073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUAl0p/EaTR1Qi6adL+zlZovqox3AbpG6qG1zKPGgTM=;
        b=OuGh2J4UZ3I/1Q4K/TvETIejK5An/Doufeix7f++6i5I9+9SnH+S9R/DYV4ciUFllL
         Re3iFK/TsPuARU7fM9hRjVQplnJj1OeiCdyqNVErIlFbpfzpJfUXICV6KHQBAcJCOiKl
         NpnGSp3IUuFyNV0mpy1+9qjmdzD0DU0V+CkotxfupcFvf5eAvyqBmLVK6pCngELVh7y6
         WcdmTn1rw8RbrbrIUBA7KWToDrVC5vodzJQySBZ2HgM1MXpZajTZR9yFjfUXiWWYQi4h
         leFM9juYHBixxwPgQe1aMzyS/W6vOTMSgQf5hV1t3C0+Rnrpdp5Ha3OGB7AhkZKZHE1I
         nLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705814273; x=1706419073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUAl0p/EaTR1Qi6adL+zlZovqox3AbpG6qG1zKPGgTM=;
        b=ocrtnGLA+w9WPXoWHXsTxVJnpvPJaO7qYiiybE2mm1Y0XoBylRqdJbrhb8K8UAySF4
         qclVzHX20VF1fqa7db1UAipK1V5zHua2HLeML25hDlwMip+l3twt635zi9B5DkYt2KZK
         Iax/ujMoJ/vs+7hgcsGYGq+0PKt0QYXW1tQvKiLIw9Ax8T0UCCZJh4nstFQabdEJNHt9
         mGxn/04NDPxMsmREtoaJdcdbSXQFh7zUeFKRqX958O6S/JO4YZGdfFMpoIs9GCGYnJEH
         PCigjlwKIrsPL/NKRp5vZd5/UEw8Akmps2NgKgNRgNthSg5QmV5qNI1yfXUbLnbwtc8i
         MpDA==
X-Gm-Message-State: AOJu0YzAH3ONMXDBBDAZ51g2519rUQlsV8pLh/SOwHLPTzvQW3b3nqrQ
	k4SohfWQLSQ4mgCnboP5hLvcYHbadEWBB38aqfFJY+jZmjCMdlUw/d1yDm+TLW0=
X-Google-Smtp-Source: AGHT+IE1u90tTGCO4HO4Guo7qKAPp4C4EQnQnSCUs0HWpzcRQ0TPib30itAIyPaqyVI1zFjhaFwCDQ==
X-Received: by 2002:a05:6830:3b0b:b0:6d9:db33:39a5 with SMTP id dk11-20020a0568303b0b00b006d9db3339a5mr2452993otb.75.1705814272957;
        Sat, 20 Jan 2024 21:17:52 -0800 (PST)
Received: from localhost.localdomain (2403-580d-82f4-0-3fa1-f9ce-6074-3bab.ip6.aussiebb.net. [2403:580d:82f4:0:3fa1:f9ce:6074:3bab])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006d96d034befsm7547196pfu.30.2024.01.20.21.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:17:52 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: iio: light: Squash APDS9300 and APDS9960 schemas
Date: Sun, 21 Jan 2024 15:47:32 +1030
Message-Id: <20240121051735.32246-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
file and removing the other. This is done as per the below review:
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/

This patch series adds the driver support and device tree binding schemas
for APDS9306 Ambient Light Sensor. It was pointed out in earlier reviews
that the schemas for APDS9300 and APDS9960 looks similar and should be
merged. This particular patch does the first operation of merging
APDS9300 and APDS9960 schema files.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml    | 11 +++--
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 7 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..c610780346e8 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,20 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
-  - Jonathan Cameron <jic23@kernel.org>
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    enum:
+      - avago,apds9300
+      - avago,apds9960
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1


