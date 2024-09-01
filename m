Return-Path: <linux-iio+bounces-8948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F25967C3A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 22:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F471C20E5B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D87137932;
	Sun,  1 Sep 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOpXV3CE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7176558BA;
	Sun,  1 Sep 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224069; cv=none; b=afejT/AfFsR1QFk7VbveGTybv5bss7/i46MU6VKrMjEB4CfU0XcPJFw02Hp1r6OmDs4ny620TP9tf3blZNezhR+QFVUCUyFI6Yjn9fps7RnBUNWCFzOA5v03YHBWAUhv4V2AmDGoOGqps5EN6FTV0gLZY/rC/2GODEPlNUuPpqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224069; c=relaxed/simple;
	bh=WNzE4K93vihn1kuliBM+l/p1UdrmkNoDHWFCaTLi2dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH+myBSAbALnsdkSHaPRYo4yOW6x+zq5D8AuUXzuydlXxJOlhtebY1lOxBispGHtWMr8DwHtXh5rL0U9Mzppn9d1zvGvDc3t5655PBqzcyB6NxJPsQCc2viVCnBjjPfd6s2HUOO4ZR3Zh6PL0YOYCWRM16tgNGFoZvp5adht4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOpXV3CE; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fcf40c9ed3so1370521e0c.2;
        Sun, 01 Sep 2024 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725224065; x=1725828865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oORM99D8qtvmeHR9Wi2UXcr+FXwZ5BI+zGdd++zYdE0=;
        b=VOpXV3CEqgjDHUVzGTm0B/wjMjLJjZJvYfW9cvUuGrf+vV91hbl/6WaEwUoYje93xI
         bMgpASEbl+GRYjGbN6LCSSG6Ks7jyElQjfAMkybn2q0fVd1Vz+lND0zRhay3CUh8neeL
         9bx4Z22NSLKzFCVQiMiGV0/JoNgkfsBwRxp7fg8vSUGmcBRV9goTNkxX2ikespGA9aWy
         9RN/gQydh+9Pc33cC9mj4VJoiOqlkXQTVxDlLD1t1CahUfDcsorkH/TAfuiN3f2+IGnn
         E0uJXe6Q/WH4yWzON974dsNz9EauJHqFXdEfrqVjUqSmsV3+XrlFWsMD0kR5IYtChNuo
         tf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725224065; x=1725828865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oORM99D8qtvmeHR9Wi2UXcr+FXwZ5BI+zGdd++zYdE0=;
        b=J3As6BR7M2aHezP6OUpQkpdcJ2u9Qf4LlFaaaY5B6YwXsX6vuozKDao2H8CGhAsagP
         7gbJ9fwrd0epTZ6ho0JN672JQKBy0y1PQ89E5nNgXGfaqfHc/5ojOwCGG28T9tIzRa12
         rNtr4oDq49Tbdkga9Aaya+GYPjQ8SGcruVLGe67v2PjUSer3GM3r6/mwwUTjp03eeieK
         e+oTxuPQFcwJ3YfEKpj1MODc2kWjt+8/S1YuNswNqDotemBD4553lh0yHtDXVpk/nr+U
         ZTIlgnZ8NVUWbwRht21y1IEWNiCqc32ulYXvoccYQDd2cDIZVSSr381pjcRt4bZ8sV6u
         sjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbRdiF1LxZzTMj5l0CArXfAHGOUriTFLAV9Do+wnWfbZagTjNoajK536FCRHsFV184u1jAjyFIBKtEbjFT@vger.kernel.org, AJvYcCXJ9vVdwyAuctCDGMRPy8JWe1+ctQrI0FwAVsPwcNQXXvNvs5QP8j+oP9BRQbOkajSvHttswOhe+ttG@vger.kernel.org, AJvYcCXSXBAAZB4NPnsydnm0c6LjoRyxdlwcCBpOkDdqcO+kniqRvRGkhb5nfMZjrga2ba0zZkKuTMAEcECV@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQnD8D+lejsbCA5WCH2iChqvOh2CUSRozIC5SPvNX+XKhmqUI
	/ZtfYTo0VP7h3/JMFWrx6YyweaC9Y5J6xMcDZLgpHDzsC7p5uaD6
X-Google-Smtp-Source: AGHT+IG+Dvmq+hEtRSBEcaVTVaFuH2eUI0v6DLuubJCxlw1QGJEJNU64FmplcaTa/A0YMbNh56BC9A==
X-Received: by 2002:a05:6122:2013:b0:4ed:52b:dd29 with SMTP id 71dfb90a1353d-4ffe4a5d3bfmr15391409e0c.3.1725224065571;
        Sun, 01 Sep 2024 13:54:25 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9a148sm34148231cf.32.2024.09.01.13.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 13:54:25 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: imu: add bmi270 bindings
Date: Sun,  1 Sep 2024 16:53:23 -0400
Message-ID: <20240901205354.3201261-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901205354.3201261-1-lanzano.alex@gmail.com>
References: <20240901205354.3201261-1-lanzano.alex@gmail.com>
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
 .../bindings/iio/imu/bosch,bmi270.yaml        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
new file mode 100644
index 000000000000..44534ef36378
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
@@ -0,0 +1,80 @@
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
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,bmi270";
+            reg = <0x68>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bmi270@0 {
+            compatible = "bosch,bmi270";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.46.0


