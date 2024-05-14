Return-Path: <linux-iio+bounces-5043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036458C55B6
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6681F22EB5
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF244C6E;
	Tue, 14 May 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnkjSMX8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F46F077;
	Tue, 14 May 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688203; cv=none; b=mQd55fOT7Xq7899Sv4UjHFA9+5kXOfTp5CVnCV6i2BERfjtqJUjR+lDU5GFglc83/GGu18DY+yx66031FuTRo2YCWUwguIW4RiI8IIYrY5EtfniSOfKxm2V4RV7xvVfjvFnm+quA4hOxSWML22LkHrsVKWCdQTQXtqg6EbkYutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688203; c=relaxed/simple;
	bh=hPDh075JBpq3peh9Fr0V6GtyB2F0d/4Fij2IT6owDC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TC4d9i75+6cmalgj2zVVBs/TB4NhH184ZRV512G4Rjz2ctCtOXHJwIuiOmqLcX9NpuS9ZHWhLNwGSn2pgtrWWKYbdFZvlVJOK7dn0vSDDK9ZLf2jZ9hI+o8fAjc1hBO9vJqXhdRizqQMamEBtXA15fsNYkk2tBOjEhSSobAewn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnkjSMX8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so4831892f8f.0;
        Tue, 14 May 2024 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688200; x=1716293000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSiIXjI+3kMzFgnCbJIBlPNQooVamTjjn6nT5fcwssI=;
        b=RnkjSMX8FRF+ZNv2sgzNC8B8227Ke1/cBJNBQFRRntYp+Upt0hI78zzn8qgdZM1eL8
         GkOYoFkPhr7lOa//gmKjFuIgU6klbT4blW1ZR3NQug7waKiZ1wovQv3/h485NpfokhQ0
         exDJ9y2OD7hhKJucLinbv+LO9cIwrUK0JAVsdZvmqwlZ0yBrpg7W1805XkYXy08b4lrm
         NM62Ds+UMwn2kmV07O+xU5u4JMO3o7Ny1zNCY+1jLJlgLCYKrvgVxdDP9N9CTVjLZldi
         Ts4Id/6IYWQel15BM7pOPll3T8jNpmwAFENmj2dqsZKx5pCCQxxLFoUhaJ4jOPmsKT4J
         RW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688200; x=1716293000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSiIXjI+3kMzFgnCbJIBlPNQooVamTjjn6nT5fcwssI=;
        b=WE5NScYfOZYv9bw4jdWye8hoEt/b++BLu20ajVZe1oGwnfJf3mqc+snbCRIPOSiJwv
         ydK7Dp4PvYVtpNvKZaDxzlN9CwLtPXH8zQLJ0QGBXqLafmEJQ/+UZbODLYtSSmr40MRq
         BxcbvTFzi3KDE/WgRxbLPtfmBbxsBWeGWbWQOSvqAgBXfZOiytQ/BFzQvzUbjtb01098
         aLd03S7D58em+mH63CVVTCp/YhyHEhUwJOWVDCpKrD6homSK+dk1diQp/N4egcYZvreo
         Bf27IlMNo5EfteYsF2Q4D+17/GT0fm1t+JDqcTd7VI56stfoWp5Ru8wKnxTb9og1H9k2
         HEfA==
X-Forwarded-Encrypted: i=1; AJvYcCVKmvIGh9p07f8d1eIKyWygdjgfigeZzElsmo144svH19G/rjNdUyuFDi9Wr++1RqfVyKL7p3ePbF2OWoASoeAgSFzynioUTRo73cq8J5cNeqnvxMw2Nq4pvBs65VN5IU1MUo+7ICodbjJhNB5fe6Lj/o386cS86gvG0rkc/1+7nsCEYA==
X-Gm-Message-State: AOJu0YwGkyURj/kIuVXP79b9oJjnrdiIz3ROkRBHP64Fh0bxdPB66WOf
	dW3CvVwxS7Fkvl+Cnfx5rD1xGfQrty7yrtcNvqodbcwkbbSrU06F9ho6zXjV
X-Google-Smtp-Source: AGHT+IGlcB6bUZAHpl/7Dlpmh9vhHUtVRRxWrfO5j0lLI0Z3FCwPOSC9HJTJfBNZjY0fb1jCtlmpcg==
X-Received: by 2002:adf:fa4d:0:b0:34d:a8d1:76bd with SMTP id ffacd0b85a97d-3504a73ed8emr12229376f8f.41.1715688199902;
        Tue, 14 May 2024 05:03:19 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:19 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Tue, 14 May 2024 15:02:21 +0300
Message-Id: <20240514120222.56488-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable channels. The user can
dynamically configure them in the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index cf5c568f140a..a03da9489ed9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -21,8 +21,15 @@ properties:
       - adi,ad7190
       - adi,ad7192
       - adi,ad7193
+      - adi,ad7194
       - adi,ad7195
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -89,6 +96,42 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 0
+        maximum: 271
+
+      diff-channels:
+        description:
+          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16.
+        items:
+          minimum: 1
+          maximum: 16
+
+      single-channel:
+        description:
+          Positive input can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16. Negative input is connected to AINCOM.
+        items:
+          minimum: 1
+          maximum: 16
+
+    oneOf:
+      - required:
+          - reg
+          - diff-channels
+      - required:
+          - reg
+          - single-channel
+
 required:
   - compatible
   - reg
@@ -103,6 +146,17 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7190
+            - adi,ad7192
+            - adi,ad7193
+            - adi,ad7195
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]+$": false
 
 unevaluatedProperties: false
 
@@ -133,3 +187,38 @@ examples:
             adi,burnout-currents-enable;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7194";
+            reg = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7192_mclk>;
+            clock-names = "mclk";
+            interrupts = <25 0x2>;
+            interrupt-parent = <&gpio>;
+            aincom-supply = <&aincom>;
+            dvdd-supply = <&dvdd>;
+            avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <1 6>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                single-channel = <1>;
+            };
+        };
+    };
-- 
2.34.1


