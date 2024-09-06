Return-Path: <linux-iio+bounces-9254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2196F9A4
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BE5B2421E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C301D45E6;
	Fri,  6 Sep 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3cZnkm+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743251D417E;
	Fri,  6 Sep 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641626; cv=none; b=QaOJLmUJRpzAUtHy2ZwjHNGb2mWZMGS17Sz3wH9hSm1BSw2nsIPQjVJAfl3Tk0KYq5iHcvTvcMZfP8mh7lnQ/57UDjxf55R9dDanqRmOYpgGdIqqRL0yqv/DLJ6nrK/wqrtz2keyVxW8riA8ynyNMJe5ccMeHKMomiAE0h2aEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641626; c=relaxed/simple;
	bh=tvp7pMLUpoQg0LGlfSv6/myiNVUsbTwGtroP3j6/syY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B67Dr13sBsQFX4wvc2EsGvOeXG2qm5J7eFmCsV6uTMdIlTN7Ubn5ejkQ/WK2UZWccicci8BlEmGmpip92bmxdVtDjXPy50ueFtNiVZDeJlouLw6Y2aMhyyLJtUdZk68zlcDJck1Ef0P/Wep7PygAudQxOz1TT1pA2Q3xaHf7U5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3cZnkm+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-457d63d35d3so13366551cf.3;
        Fri, 06 Sep 2024 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725641623; x=1726246423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36b8SeHh3TT9S14jvoavO96Dtza2eqd4/rtyJ/IyB3k=;
        b=l3cZnkm+aaLD5a7sN1y7BDCF16BRhYEbWpt33Zqwqzg02gOYwaccE+S8xEzXj1N/3Q
         zxXQXYLEC4LpRHmE/WpxEQxRDqhqyR3pYcSKMsf1WwXwriKgrU4cRorDJp8OPUDBVAon
         yjV40N9VoE35/cUmkQFfnJ7chAqAioXCYXovFXUW3UIDCRsRrt66DUEstiFGfEC8UXUZ
         MC+9NrusQ3Ij0TNevDCVz5o/PC7hB7yieIQq/VA+8cu9NcIRjpAgggoL86aRdTuXWA6O
         P3IXAxoN4st3Z8RYG4Ec7H8aAo6xXDBkfA3VuOe21Kdrke+czUzx/CXWXSNMkzKReK/L
         6GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641623; x=1726246423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36b8SeHh3TT9S14jvoavO96Dtza2eqd4/rtyJ/IyB3k=;
        b=tupeGmVWaKAtoPp4RfIAXz8IpUvaRcsuJG7wVjvoRovTcekYJoBJWTzoQcFa6I4vSw
         dTSdwT8QBb6SrzAuzDJYqBfNOUpsN4vELmiLLfF7jET+qr0bp4Ea2GkCSKxD2txuBljx
         yW7mX9279YzUYGMURKUkf22ojEIBndsBfH86LQ1pUeYt73a2455o0XJPxkjayPWpiN4Q
         zCuvh+TIH0GC1zkyO8sEtlFETczpVkejKF9u+0LXZHSP9GvHCE677FOX/Kia0DnadokM
         j4tkr/MimMOmXINiIM+NqXlULkDx+uKXuukGTRsaxSPVWpnw2yGWCQ/3xfggD6NipjbY
         0e1w==
X-Forwarded-Encrypted: i=1; AJvYcCV7Xx1goy8z9auarxBveV3NL/olVqhk9EXx6pWUn+0bKK5rG+ZxvlVUuKSIyc74iMI0oY5xZ1pKdSg3Pgz2@vger.kernel.org, AJvYcCV8Gv3Rniyjlc2iwlfpFECGG7GbjOSpb13B4rAH7vO16qxBApqpAVPJjELaaup+Ssv4msBEATNFmyeW@vger.kernel.org, AJvYcCXAnigalx2McDiN7gldtvpLDJFt9POE8p6XzjBBoOlRX+F6CtU5s/ZrmPyTMkjC3F+lrafiEMcP+eB8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2789+1xBrCR9dWskTLVQK+qGGbAgpB8m7Glx19OOxUv1gV1de
	WqwbvRmA/zp/hzJijLqLiczi6rVLsCzIalarmRP3ve+lWLfQPrCD
X-Google-Smtp-Source: AGHT+IHmK3mijD3otFyAQkaRrN5TSQUkGYckhweZ5+8zg91pVIhbXYsrA4TeW1JhYZuQIJWOspacfg==
X-Received: by 2002:a05:622a:210:b0:456:8081:7803 with SMTP id d75a77b69052e-4580c66e4ffmr28972981cf.5.1725641623286;
        Fri, 06 Sep 2024 09:53:43 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b36206sm17580121cf.29.2024.09.06.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:53:41 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jagath Jog J <jagathjog1996@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: add bmi270 bindings
Date: Fri,  6 Sep 2024 12:52:50 -0400
Message-ID: <20240906165322.1745328-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906165322.1745328-1-lanzano.alex@gmail.com>
References: <20240906165322.1745328-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the bmi270 IMU

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
 .../bindings/iio/imu/bosch,bmi270.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
new file mode 100644
index 000000000000..7de35b9bfa2e
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
+      set if the specified interrupt pin should be configured as
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


