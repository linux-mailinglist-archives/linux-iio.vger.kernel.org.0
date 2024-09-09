Return-Path: <linux-iio+bounces-9355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7A970CBC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB26B21E09
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 04:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9A18C933;
	Mon,  9 Sep 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md7eXYql"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C253171E43;
	Mon,  9 Sep 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725856402; cv=none; b=YidOVDHZvoWZvLsepsA83pr3meEmHZ+WiRN7JknIJNsooB5AwgFnz/z1XcsPUT9LSIEGziYQf2jBuQe7zRjH/mlzt4WT3bxEtJvgZBniL1i/epgP2lEUAMXUQWT9ucRfORUkWYRPAxobddP3dVxnfsHIZsFpYXGDXtygBF0KfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725856402; c=relaxed/simple;
	bh=oQI72NURFp+bgiD6sXVj2qg4ZaJeJi5b3U4o5u42xEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzRWYryJ+EPcxCX55XXxqMqAoFH16Pv0+Jc4Bew/3DFpjnMRkdy2EuVJv//8hE/ubeM8Zaheplm7JRMDRiA9V/VEBY8J9YUV8Y8O83j7vCsCrT69Llrzx8WkRy+2iFTXYcgkJUMKquq/MPId4q4RCYrcfeOPTbS3X9pPlYfowgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md7eXYql; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9a3e731f9so109094185a.0;
        Sun, 08 Sep 2024 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725856400; x=1726461200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI5vIgB03b+RRPC5P5FjvKVoLvcCEHnEc2wIMv+7968=;
        b=md7eXYqlLBWbNZ+DCKiCnlPcFF0jI/hTwl/P/mtocpefmBCMXDuibh+yQnmn/AQVZD
         iH6rHBYh1fAnko+pOQ/Xgszpx5nAEZ4muWedpKomt/hDuDGvXq9ustmqFCb7lQZBnFrz
         EYFQwrkIxrHfJf9buovnWseMunCoCOQsrU1oSI6nFVxLSvLp4U02IDMee9py6zTH0j+m
         F1dAqaiaK5Uq6CwgLSPER0e9TH2k8aMPECBehPJe6+carISp7z2JxAHM0m4A6NBfmxMs
         d6DaCZea/YnxEo/Nvd/G4u+3jkotdrmRzTThMiJaDLmE0SmoXkWlAxHUCLH+pilOXhbC
         rFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725856400; x=1726461200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI5vIgB03b+RRPC5P5FjvKVoLvcCEHnEc2wIMv+7968=;
        b=VsO/ghjap7TikHLksBAiBELxAK7BgjIv9rJtO8tavfHvyda6yiIAcz38Ksliknemsa
         ka/ls3xt94OF0YWrHbPshMhR1exv2MQuU46LhEvI6znB6jGIf9aR31v5kDmnPeEaRgbI
         wMyVoPqavdNcVpILhkvTmTKDJQny5R8A0tdRrq91KrS80J++0eLPiVRTHaV9Ms9BhUH9
         G1ITWstV1I78LLTVDmaWqMO+Pg+bJZ8shQSzcCJWT1UrRxeUGInLihK2nvM3gchPXq/1
         0mbP8qzbNxYlVpQ2m8F4N2zn8Mm0p91x+5ogeL+UKiTrQr1bDrPOtPiMoJY0fAJxU37q
         5qJA==
X-Forwarded-Encrypted: i=1; AJvYcCVH8pPdVyigxXb0l/B0nbiSf8cxDoNI5s4/q/3QLpvqL/YQ8S0Sod2DtspYCCx+rb7Pj605NCtZnmZbHOQu@vger.kernel.org, AJvYcCWPUNVRmtIS9vQVjP1Jc3j5FikVGnzEFLL/tGLblPtIrCcM8zEuSw84loQ2t8ESwc2QNjJYO5ZhK3JP@vger.kernel.org, AJvYcCXFLio6JyIxV2qLVakmdU1WX0nUCPq7F+9Ug1VmZ1OBFZJeYVN9D9wjWj8g6/CCjSHDqzsymMU0L93s@vger.kernel.org
X-Gm-Message-State: AOJu0YzEK8+1W/810v63yPvuJEh6bzGl/NKU7x8Q+gvOSbrZMmJJApHn
	1eVUwQHlTFiTPYZtGbORArc9GbaAehKmqvTxpq/viG4fgV0RnuTA
X-Google-Smtp-Source: AGHT+IG8idRuBPJvQcIiBj6IhGqtM2AHATsmcaA0g31q0XAisgaO5fhya6DaZnUc2hZq745W2N0V4w==
X-Received: by 2002:a05:620a:44d6:b0:79f:14de:2a09 with SMTP id af79cd13be357-7a9a3898a69mr809955985a.8.1725856399740;
        Sun, 08 Sep 2024 21:33:19 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a794559bsm180791685a.6.2024.09.08.21.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:33:19 -0700 (PDT)
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
Cc: skhan@linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: add bmi270 bindings
Date: Mon,  9 Sep 2024 00:32:23 -0400
Message-ID: <20240909043254.611589-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909043254.611589-1-lanzano.alex@gmail.com>
References: <20240909043254.611589-1-lanzano.alex@gmail.com>
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


