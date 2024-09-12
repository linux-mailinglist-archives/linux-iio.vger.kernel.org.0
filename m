Return-Path: <linux-iio+bounces-9472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BBF97735B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8011B22F06
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FD1C2335;
	Thu, 12 Sep 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVI7DMY2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963346F30B;
	Thu, 12 Sep 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175300; cv=none; b=IjguHL+6vReabgABQHLv8GHbYJWum7R/EvLggOrs6EHV7ivMS5WqxFsdjqXWC64sw7VuSAUsQvyBXlnMUM2OKNci12wjgTbfuQ/zJA+LKL0BOClQzXNXJTljtpCQZ5ewVs9JBP562VvtcBmzLg5WksUrkD6pXcxS57Cgi5lEFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175300; c=relaxed/simple;
	bh=oQI72NURFp+bgiD6sXVj2qg4ZaJeJi5b3U4o5u42xEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYy54pLJSsqx1a3hGVh9OeAu5sICE8aCm1sgXHUz3Xoy6rQz4MQDdPBcAUG0zxxP1ZiSW3dX4dTXlM8bb4b+8nfNTqoqyTKxu5xqzXG8s14K9d4oMaoSy++V6M3/wgc6aTFJbijzPrWL1HI7Pb/b15AiF5DcTofTQx90sN1E0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVI7DMY2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581d2b0fbaso1607401cf.1;
        Thu, 12 Sep 2024 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175297; x=1726780097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI5vIgB03b+RRPC5P5FjvKVoLvcCEHnEc2wIMv+7968=;
        b=WVI7DMY2o++C3P9KzQRcI8QMrIw/D0vvKaawszRkq89Nv88mTEr1gmGFTfyiz0mRK1
         KE9BIUdtChQg6vp3c6d/ZbcZsOCxsEEe2ZQs/0wvGMuPUkV+oD1zh3T8xClOHppfIwlD
         533q7l1+2Z8hVPPyyD0sHAD1ijLfPCp+IvUUEJEVKfSt0ED6qkdCXZ32P3Jbce/e6iYa
         gxxCBU04X/KhS32E7CONYnLsNSe75Z7/dPV6fm5gZDe/ufja4QJ5qB+JK0qjP5Bh5rDz
         lFUh2nxu0tgMBVBaE9DYrYiEhhGU4nOtr/eFeRBNEYPX1r78GaIJNSwsq3/BXedSzsFX
         OQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175297; x=1726780097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI5vIgB03b+RRPC5P5FjvKVoLvcCEHnEc2wIMv+7968=;
        b=ErH1SSA1XO+Un0whOCnx1nl/hVuNeWXFVSCN26bY9n9g7jJmRxHmmi4dXmus7tGepT
         dUvwQP0ysafP1vUM3yPi8qvY1WfX5tPuDxQgKb6+rgHIR3e9/wbAZpkicovAk/TNr/05
         Cnme5Ym2BjAfcPypjrHOsHc3XiXn2sRk5WzOnGds4FaaSv5ixNvMIGTsI2RaJeBAAWj9
         rMWTk6UQlcdwUtlTEpER7/TGGM0y2IorUhlVNM/6uGYx/pSAguRFhKDmCLw+CXY1PuFD
         ojRDDhnNKlWweTlseWSxumpTmIzkOp0WFggTtZCXEJw/dGVRZjK1bHepDCQXJwhzje1u
         z9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUYwiFSZes1eUy7yy5/XUbKc2859IWoQYR9lR5IMYeX0dEVkUiJyY04RCfr7r5CQLWVsgmiPTRbzLJI@vger.kernel.org, AJvYcCVguhRjtoxIpd8YKVuxz68AR+n+g55dFbA83XJC6K7+aE+pdoRPDqJpeu3MqiYs8df936gCfdtdOxNTQrc/@vger.kernel.org, AJvYcCXmBbWeKZmvNmtn2Haxo1JQ2QxqwYw4tUWpurkEOurVcl2NXKfKmpXy20PiqVXVQ8/y1SyiyiMWfex8@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGJeKTELUAPRt8Rgv2YTTPhcP/k6d6yr0EAHcIfyt/l8xH1dm
	t6kRXZCX0FPgjtx6m2FlF9aYpu9vhPMhpX1V8D2bHgbrYPicJS77
X-Google-Smtp-Source: AGHT+IH08Q4d4W8M6rAMy3bRhqMB1YQChslJN0IsPv4VjxzP8fHcNkqfGmIn0ue36ApoRXUFSn1t0A==
X-Received: by 2002:a05:622a:1902:b0:458:5b3a:9a1f with SMTP id d75a77b69052e-4599d29f8dcmr6443621cf.43.1726175297495;
        Thu, 12 Sep 2024 14:08:17 -0700 (PDT)
Received: from localhost.localdomain (117.sub-174-193-5.myvzw.com. [174.193.5.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e613eesm56959721cf.12.2024.09.12.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:08:17 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: imu: add bmi270 bindings
Date: Thu, 12 Sep 2024 17:07:18 -0400
Message-ID: <20240912210749.3080157-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912210749.3080157-1-lanzano.alex@gmail.com>
References: <20240912210749.3080157-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the bmi270 IMU

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/imu/bosch,bmi270.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
new file mode 100644
index 000000000000..792d1483af3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bmi270.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI270 6-Axis IMU
+
+maintainers:
+  - Alex Lanzano <lanzano.alex@gmail.com>
+
+description: |
+  BMI270 is a 6-axis inertial measurement unit that can measure acceleration and
+  angular velocity. The sensor also supports configurable interrupt events such
+  as motion, step counter, and wrist motion gestures. The sensor can communicate
+  I2C or SPI.
+  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi270/
+
+properties:
+  compatible:
+    const: bosch,bmi270
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    description:
+      set if the specified interrupt pins should be configured as
+      open drain. If not set, defaults to push-pull.
+
+  mount-matrix:
+    description:
+      an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,bmi270";
+            reg = <0x68>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.46.0


