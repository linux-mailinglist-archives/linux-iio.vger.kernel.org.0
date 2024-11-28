Return-Path: <linux-iio+bounces-12791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3743C9DBC82
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F208164958
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F91C1F2E;
	Thu, 28 Nov 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2INZbYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597CAD4B;
	Thu, 28 Nov 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822382; cv=none; b=uOnPIep8/W5jscVg6LwIWTYZGgQiJRx/NQAMSbuskK4isIgrrPENJ1/Q9Af/Jut7P6xVSpMv9EICY5WhjnLKtQ6NuU0wnftZnxUk6SpunG7y417aHLi655qbbwUVvwyl653K/PMRuZUrTXJ4X6oNCF40ain1MuDErl6H7azRlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822382; c=relaxed/simple;
	bh=n7T92YggRAuP3R5wCfxRp6kzech/Kx6Vgv2R1+J3Bro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0Wt3wOcAi24LcJCmsRN9beOIe1qAY/qCUGBY8lTQivgICB3NekIVPei6aNXptoOboRxjQS0RhJ2YJZqWRhY4j+o1Rf5A5uiPkduHC0fX0WCKgbaNqDDu/OeeCzrPPG8abLMfSi/qz8Bg9vZviXrMS5j10GPf+QOoewESdbr8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2INZbYm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so10344975e9.2;
        Thu, 28 Nov 2024 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822377; x=1733427177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mINgVsR+9ZHzOoyqP/s/zmpdc0F/7r3SD5kpKvEC3qg=;
        b=T2INZbYmjGIi965Te6qv0938VFkko8wH8pejQVkDtJMz6Rp9J9B7BxPZiACJR9hXFT
         RniMeqL9UFuetOdvV1ltL/lou0+LhO7Hik6AMfX6dnh9bGS9fWW1e7M+Ein40Egri0mu
         cryMyXPeVtTXQLsIBa8JNoLpul3Ss+vk6QOFWYwOweaFt2yKHOp8A/dPiM30o0gs0N3a
         8DuYuKqJFTEkAzVd+annzidswuOaZ7DzzhQauYMhKWzD+eL5WIRQSgSVL4w4q49b7xMh
         3nx+8V09nH16YNfdhQqiA0LiJAbtrYrqdCzt3eRfY72T4HR8WljMLGtpJaW0aKYUKxzR
         KUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822377; x=1733427177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mINgVsR+9ZHzOoyqP/s/zmpdc0F/7r3SD5kpKvEC3qg=;
        b=iKUGwYmdiMX1jwFT4kT45zvR2eDkVspHSeYaxT0IbHQMM5mhB//mg6SR57Qw/g+uxl
         QbeRPZ4D4Bt6skWdgMfYyaNp1X4MmJmSMTu04p2Opy74lgPE5Ccx/J7cYrpyTGSnDmTJ
         r+XLo4Z2GViB7wg3eNXMsvpEPEHH7wOqLGHgMhHLCU4p0luLeOvjXkjuWTcUiMF0NI4x
         GnYBXuzo/rWHfwiTR6SYziUvPJ15dZk3AxoZ/nm9rp3dTJwkczLBOWBKT/0fhokzq00z
         FPlj4UVGoOAK+Td3fNgITvFjfudqwzcp1Bi3ZbWzd69YPP0YJHmS8lMj1PclNDKnVgDX
         srNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/deWYACgQZy2ab9nRmZAUlV7MF4LAT78KmAG41JsiL20ZuY8Tarl3FsjNiA6NulloqEY0rFcIF3Vv@vger.kernel.org, AJvYcCUWC+5K+TaOjy1ugs8/jll4SBnbRmoSAto8SdvGgrbAq1KJK3RIT15MygdsGqpA/crZXmpLUdn+Rwio@vger.kernel.org, AJvYcCW+7jttB9p/qHBu4kCb8dFpqkHRHAlzS6Ft1pjW+HGJn+fxcrrQG8S42u/33jBHFCTbsO2cK2ENjizeIPHM@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZeAz6zxjzLS6lGRpUuUIMHlC21DSSdbM7b9drbZDKRwxNQtA
	2PrhvUVorsmmXwXhbcfEAyGe1EiGPnXwwoEj6SmTaK59luTfex1L
X-Gm-Gg: ASbGnctBfA0zE+WFMtnTc9mnQjU5iV4JBuQgRHExw+wmqJlNsteNFBgLSc198e05J0l
	/31i7go7wd1kS7t+ku/ZpLUCG6xw3RY9OTrb/o+EyXhky/1uyVs9i1TpYXJEkoE/5EGpCSCz43/
	Vm6eo/1jV9x/uZvsDYx60m8uge1IBUHTPHkaq0kKvKysonkmFvJbSDHkEmmh0peUDa0CvWm53Cd
	2pRiHD1ntVJOhj7gHi5ZvYG5jXvN2qdVCokU8tikCxfC4tRWHvK5D73+pQ7o68=
X-Google-Smtp-Source: AGHT+IEXvwW6EWyAkvdpW7OvIexEwiKXK++sM1WMw4EDwG1Vplt8P7Ei7sYUwykakHvrh8yFiElJiA==
X-Received: by 2002:a05:600c:1ca7:b0:434:9f1e:2c2e with SMTP id 5b1f17b1804b1-434a9dcd8fbmr84720585e9.15.1732822377059;
        Thu, 28 Nov 2024 11:32:57 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm30557855e9.10.2024.11.28.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:32:56 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: iio: bosch,bme680: Move from trivial-devices and add supplies
Date: Thu, 28 Nov 2024 20:32:44 +0100
Message-ID: <20241128193246.24572-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128193246.24572-1-vassilisamir@gmail.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move dt-binding for BME680 out of trivial-devices.yaml and extend it by
adding the missing supplies.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/chemical/bosch,bme680.yaml   | 62 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
new file mode 100644
index 000000000000..0eac22e465e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
@@ -0,0 +1,62 @@
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
+description: >
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
index 9bf0fb17a05e..b651826e2d21 100644
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


