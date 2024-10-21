Return-Path: <linux-iio+bounces-10903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBA9A905B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CB51F217A5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A91FF02F;
	Mon, 21 Oct 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYOq1kEQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B51DE8A8;
	Mon, 21 Oct 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540425; cv=none; b=ica+tsKLX/veeVE6u6JHo4x3tp+Ij2RmJ02MNULh5pAsowI5moQlBJO9azZgRghcaOWB5c65AJGPXz/aM40UD3U6gNGSCwk2+O0jx4CSgJIQXBf4j6zF7XCIlGleEpPNgvWRqXrRC2FDQ+sQoXq6x0sM9evhTFwlIt8mLnsw6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540425; c=relaxed/simple;
	bh=HuRrGvLfUNfkAK5g4HYaKiG55r68O+ccWYCmax6cs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4+wtlDZ7b+vixaofyYauvLYXBa3VQUenhy9uCxjiA6I61d4Qk8DxgD45neZqqAEFc8gIJMm20ZPzDSChmE6PooBdb2j86DXkFkwzTWp3BGTyBuUOHWuYPNIbT7T0hBHpn1gggejF40ckM5nsCgrSILag/GOAFSo5+jyhGsMbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYOq1kEQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so6172073a12.2;
        Mon, 21 Oct 2024 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540422; x=1730145222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiDiHoQKEX2h2gMZ6AYiTcdgVDx/hK9ufvUgR+J5zhg=;
        b=DYOq1kEQJJ4WVKxPx0e5MqdH42Y/bhszQTmQPIz5l6E+wQL477g9x+AXY0I0DYRwUG
         Cd5qxOUzN81P6AVtQ8Q2O1XP3g6+q/QlIO01HdJZ3iswXsIkloMBeEAn3j38NxadFM+f
         NqPspXBzSQ3M3HZzC+wbFlSCxcy9xDj4EJZNT723XSGWHR2VtNNJCOGPEiymCxwyXzsv
         ehYs+rgt1rEkfxSrqWfzVVxs4Fc8DhKEeaW97OI8U+bPi7lz/94V47b1QaRidJ/LXkVZ
         XYa7qfrE/fJWI0Znp+vEKfBzvo2t+Q+r77DgRqzrW//7cgJLwIexaq1CIK6XIa2Xcx2t
         sfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540422; x=1730145222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiDiHoQKEX2h2gMZ6AYiTcdgVDx/hK9ufvUgR+J5zhg=;
        b=KEuTWVX+pDREi2lzw0xP/Ud1cG1cAQStfNaDYznUii5wY1f8BkNt1Ui0wy0H7haeGr
         YS2PGrKi/OeA15FEmbpLCDR0w9kgi80wDb6XojuT9b4tf5B57nHEX6x+QwnQpMxBJpxI
         ANuyFjAx32Z435d0LamMmklK8qmcvyYlazaZ7BvbDjgryXQmlRxIthMT43PdIRow2zb1
         5pdgt6nqF5ePhPNA/anew3zcAQKEo59O8/1BtG90JG/Hoe+gTlcvd39ZI2SX63olzVbT
         QTmQSPSXd+hoQwwa1XHfGbr6hmY/YadAGHZQ6Atp6om/vjOoWkzoy/wqcICRYtPICOkT
         X9qw==
X-Forwarded-Encrypted: i=1; AJvYcCUe41BQHw4Lb6WBC9ZGerNuQHeidCQAHItThzdv9xNNj8t7ywUFyG1Z64RyQSkoqgmRwRLMTXQ78WfXuVIO@vger.kernel.org, AJvYcCW5rflwdaqiyQKjrnaKV1SyIGRQQ/ilKqPvfj6/tncQwtBmwFyfSS7geWVsJKdhiEb+wSMHTonYYR16@vger.kernel.org, AJvYcCXYmvIk86oTAYJL4ySDL6ZORLjsiW0GTGsfTc/o3Yw8nwtuh6Jwwu2NcN8W8zkLkUZVhGT5aA89Rk+k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nvrzbiynIRLKQ+j0YnNU75M+FqcUPb71RJSgegyjs4MmIkOt
	kjtHUtLOD2WGaAtjzQwrsqvb4v61orth8sAiuwO1zVl7e6njp4YdFMoxzg==
X-Google-Smtp-Source: AGHT+IGZ3G6tkdAZXdOQVSnMdBgIlCvNW0HxUJpss8n0EtF7X5UP6Futk+URaFkK8drWShm5ByfY6Q==
X-Received: by 2002:a05:6402:2313:b0:5c9:6eea:8e06 with SMTP id 4fb4d7f45d1cf-5ca0ae87e13mr9153927a12.24.1729540422010;
        Mon, 21 Oct 2024 12:53:42 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] dt-bindings: iio: add binding for BME680 driver
Date: Mon, 21 Oct 2024 21:53:14 +0200
Message-ID: <20241021195316.58911-12-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-binding for BME680 gas sensor device. The device incorporates as
well temperature, pressure and relative humidity sensors.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
new file mode 100644
index 000000000000..e54df3afa7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BME680 Gas sensor
+
+maintainers:
+  - Vasileios Amoiridis <vassilisamir@gmail.com>
+
+description:
+  BME680 is a gas sensor which combines relative humidity, barometric pressure,
+  ambient temperature and gas (VOC - Volatile Organic Compounds) measurements.
+
+  https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
+
+properties:
+  compatible:
+    const: bosch,bme680
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bme680@77 {
+            compatible = "bosch,bme680";
+            reg = <0x77>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bme680@0 {
+            compatible = "bosch,bme680";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 0108d7507215..3d9c08ed7bce 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -55,8 +55,6 @@ properties:
           - atmel,atsha204a
             # BPA-RS600: Power Supply
           - blutek,bpa-rs600
-            # Bosch Sensortec pressure, temperature, humididty and VOC sensor
-          - bosch,bme680
             # CM32181: Ambient Light Sensor
           - capella,cm32181
             # CM3232: Ambient Light Sensor
-- 
2.43.0


