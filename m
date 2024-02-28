Return-Path: <linux-iio+bounces-3153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E686AF08
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 13:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6697D2814D0
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377596CDA6;
	Wed, 28 Feb 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="QkEaFVC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5E3BBFB
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123069; cv=none; b=Dd/thIn10i0reDexPOqt+SA2K7E9Is5BmlTM+VE0k/wV5mWvvcZNukPRDRYm0ZyI4414Ta72IQv3rqW+bgfK+nvLRYJBhPNhE7FLtnrmqjd8V4dIpBBHfv7bMSb1wBqTZy4O5giK2QRcZA98P6C975wtg33A/nobWT3tYtrDjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123069; c=relaxed/simple;
	bh=HOUoZIa3MkZ+KSHWn/PWd1QcEHzU3kYqBJSIQy5PVHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiD/voCKS3nSb1i8MqcvS4PkTg/zTfXpIEhA9K86QaAQW05f9UU5WWWfZnsqTCitRRSJ+Zr3VRw5fpmXzagFapFPWxv/fIeSx0YSWPtXd8nmagaZuj0W21pSwayB06q97ERf3B+CMC4Gd71ambXbd0v7hjCI0+8yX1sy8lxit7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=QkEaFVC8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso4901999b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709123067; x=1709727867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUpx31yvSWfMaXn3gef1SDwAb7zb/rd060Do4+3pH9c=;
        b=QkEaFVC8wAhVjWJ04LL+2Sz2yHlt4Kxn7dAgZ4EZSqznBJWRiCgd5+3KUmFyGd/n+w
         GOZWauNssUQLQn2kSKCtw7D56O1iSxbPRzcenVadCS68DIdGTorm+GAaiU2FxG94c00x
         obu+1PA58WPolh5jOfe8d0pRozJcshuQt1jomFp9S1K5r9wF5zHr2b+1R7Ew5JnKndFp
         oroT3PnwDgvMIGNu87PxIlJC2B0TBj1QKId45LUJIXo9Rf+3wVgSYQdEVOVHD1rYB3lg
         9cYmFNT0641c/M6WM7UF1XAn62xUtQ2Ap2x7N2TvBsc71ExOGHPylztm3Mq0il4tUZCY
         Zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123067; x=1709727867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUpx31yvSWfMaXn3gef1SDwAb7zb/rd060Do4+3pH9c=;
        b=pWgeDQOSENuJwfQ/xI8Attgo5gmV20r5xvo+2iCOCzXM/v/e393lgaR8bX89iCygJ0
         hLCpHtkm7GeSTJWgYgNOJHmXImvaQzGge9yMox3sa+F3uYwDZW9Ews3b9/7lktd2tKX/
         4IlN9WDuWDJIJriVwEoBjQfD/yA6hxtLpHXiCdHvbRltq5KcUzsPvwHMU6B6k+nIVMGP
         a5WI7H3hcjkBGOB4zgvsjH22w7KUDYcESnLR+STnLghB3Xi2btVe79i1jYmQPDnDmmOf
         P+2VDbiZyyjVU9a4v5nXhjxyuzOnJ5w+mhQ1FZFmVhe13tcZwK9xo8j1IHRjQruaqpWp
         hp8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDr9IRc+xkvaGxKXkDV0+yqb7ptMbZoFtDpXdxofdfWfeyml5897bCBrlCzSdeF0RnkZodOWjAzag0mQPJYNrI88BCUCGikKsN
X-Gm-Message-State: AOJu0YzDx7Na+INuUuMeZK+clnRhJ3le1RFwbDlv0kIEHC0V/Q9vkdL6
	1FKSfv3UGs2MztjTuIghLo909fVLIzfLn8QTF0JLCwAzpHw+E0T8Lsv6hGF55Tc=
X-Google-Smtp-Source: AGHT+IEYYJ2V8VKY/vW/qjuf7LtVF78EApZt7fG3uojTxTrno1hrxqJLlBXc4Qr7/bhbLX5er6aj7g==
X-Received: by 2002:a05:6a00:1889:b0:6e5:4451:eb90 with SMTP id x9-20020a056a00188900b006e54451eb90mr7509191pfh.6.1709123066844;
        Wed, 28 Feb 2024 04:24:26 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dde0724247sm7857587pfh.149.2024.02.28.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:24:26 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/5] dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
Date: Wed, 28 Feb 2024 22:54:04 +1030
Message-Id: <20240228122408.18619-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge very similar schemas for APDS9300 and APDS9960.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v7 -> v8:
 - No change

v6 -> v7:
 - No change

v5 -> v6:
 - Write proper commit messages
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

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


