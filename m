Return-Path: <linux-iio+bounces-11836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E99BA04F
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE451F218B6
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112471AA78E;
	Sat,  2 Nov 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGn5+iFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB219DF4B;
	Sat,  2 Nov 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553215; cv=none; b=brx9whOhRPBPg4+rBcdauh9m+O5GcW2g6ZYXT7o/PAWRqZ46F5SXi3kX0DKHGm97HorrSik7brDNEBlFXTI4MB8YPtkDtvBJgUF90UKAknvoVdGqIZzkDCBs9MeE30awxU3MKYf2auveDyQhMEMpWmrk6bpa6hKXY3TVN88Hch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553215; c=relaxed/simple;
	bh=i0fX1+lyrC4NgLycap4qU/EdlBM9aorbPxUHYhSre4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul+FDau9EbNwHr9CHn/goRskRA39V482iYriAa2Ey0fcebs+NgFahilalFT4RxT6m/jrvTG0ntoJdx4+n+dlShIKoaOBp513EsFQCJI/bYDlTKbHy9PGmA32ruel7GggjAOkaEJ8LUgkLcYHh35lyErTtoiscHwgMCAk2QTZRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGn5+iFO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d47b38336so2063004f8f.3;
        Sat, 02 Nov 2024 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553210; x=1731158010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+XO8GAvfJ1/DzA87LDoicKydO/A50Yh5zO7qiytmXk=;
        b=SGn5+iFOCe/J/W62VnWbD7GiI6ttB+N+ETw8Xxt/xFszFviXOHlZ4L/KuQJlHBVj+R
         bAXRvCivzL7uMWS9S9J47SzqYAPra0O9NB+dQUCDECePwmbXAZywcAHclr+L98Z76HZj
         kqqWD0Bab4x4QUCKHZMBfbsR530lhDiTVx4R+y05KoGm8YZdi1XSchVX67ga/Kh33tSK
         r/B5uDxIq+QJGCMREKNcMoZsYJCAdN4CQoRzDhHUTapeYcJPdHNf9sNwjPIic2Xdy8Lq
         0hhAkTNXtjsk4g7T3YDlQY+Ure5B+dcM5zMfpn2nn+jyyRAbvq3OFGK1ooW3o4TnlCGq
         lTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553210; x=1731158010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+XO8GAvfJ1/DzA87LDoicKydO/A50Yh5zO7qiytmXk=;
        b=nyEbrRhpTlhTqiwfOjTaa6MfNKNMK5GUJwdu+9iUnxFcV/c07QhxApnnUM2tEDTMBf
         69JHtzA/eQ7EeqBQ7wDCcTiBLBR2/+GELd4tJxjytSQsQqgWQARYaPxt6ijTt0ZBv/43
         FiPv/WvB+Hem9FYkS1nCLZaGqom1EU4yjtsRG0IJXVx5GsVIiACLDYoHCXFrpD5JBjTd
         BttLfd60MbBDFnw5EnsDyBpMwDHKTnIlJ58l/cB3eoyzW+20M1Ni9zmva3qZ6sBJ1dWj
         950UcEccBoYk7O2OZ5oNe265MvfEv2/UQpEihxiVclovI4IHWdKb+Kts8cyT4B+Tat42
         PwrA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8ViIzEjPd2Mc9uzeITa9RGqk8dWSFsDevlwurVa+vuE6Y2zlR1WDhM+EZLSJpL7N9wYjqWpMG3QSsnEh@vger.kernel.org, AJvYcCVAMOAfy36s4vD+oVJU8SxXDjrvLe3Dnhv9ILPoZHrcVEioCsOZJSZ8TlKC7w6V38rZNbcukMeIQrDH@vger.kernel.org, AJvYcCXdsaqhG9UEjCGcbfUFzB7qC2pfjFJFP6cFgDcHfuyhWsheed2eIwgmJ4/OrzGFl/G+Fc6GaotqlO1Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtQSeH7EPc/Rh3a7/PHCoIsOAOCmweKpw7Qo7Jdg2yYSlx6BL
	HzQ5Ifq2ukeJJF6PxXsSyF7uzqur3YoxB8JVuCQBu5xTQgX6v42t
X-Google-Smtp-Source: AGHT+IH7Setz+I8lq709NR0+6I/1dZ2krPxiMlgdBIN7IXE/uZkUbAuOFIFMgMlVhFxYgZvVj3eImw==
X-Received: by 2002:a5d:4441:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-3806121fdf9mr17496945f8f.48.1730553209897;
        Sat, 02 Nov 2024 06:13:29 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:29 -0700 (PDT)
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
Subject: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply properties
Date: Sat,  2 Nov 2024 14:13:09 +0100
Message-ID: <20241102131311.36210-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend dt-binding for BME680 gas sensor device. The device incorporates
as well temperature, pressure and relative humidity sensors.

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


