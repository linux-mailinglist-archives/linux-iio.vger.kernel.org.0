Return-Path: <linux-iio+bounces-12969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7BC9E0D32
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0AFB34B08
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC41DE4FD;
	Mon,  2 Dec 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuJywA/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE21DE3D6;
	Mon,  2 Dec 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167428; cv=none; b=kWkRIKIOfDR6CjxNXKK+inylKCSmufqhSnZkyWeK8901mDkFJxKSVb2Ipz4MrDkfESJFX9XB6vpPztp5zjAsI4t1SyT1ufOv3+mVIuPquyo2B7Z2Z75wXt3nMdBnSCWWaSf5qxo9nPcd9YEPC2/iHuzhR8jdM5IhIhliCjjDXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167428; c=relaxed/simple;
	bh=D4miNLrdUjNpvgsWdNtGYLIqx0AWqeHKGicEGM4bmIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elzEWZ3q9G+ghcGEP7TYbxJr9TBfcf7T7Hu1v2Dd0+0+1FlSeJqzxw0mCYO4g7THqqa9UlrW3VW9Ax2b4MhJPNf+/OC99867NulPY2ErTbEhHhISwsEgx2E2uBI2QSKnAsG6AwSGFupxVzjav2PpY4m51ITWo8nyaItFw6PFlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuJywA/T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e1721716so1597521f8f.3;
        Mon, 02 Dec 2024 11:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167425; x=1733772225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0lwKiEACMAPvcW411fJIEGRcVHX/+cvcSO0BF6RzuA=;
        b=JuJywA/TREbHKdSuCYz+pBABhV2ShhhWRBv754qtN6zwSbea6cLxXcmi1qdlqLFnxw
         qBVGbHIar/zZM126XdsCxUS+BBnIl+SFY1t3eEvE8NMyGOMDKaGyC4IxfSyhuTF0kCiX
         d4iCTZ0WgxXTLeyELz565cmSEFIEY4W2LMZetuwgGVOdZvz8IgjvlbzeGud58NKdo+o1
         j7M2RCtiX0UPig6tgNGH90JaVhmlKezrjCQVL7UYGHv/SLz5Sww4N7d7WYttOUvQywze
         2iOqJ/hO7888Avk1+ggaOwPZAdXkNMEKfapf7uVu6JGn3a2Mzsffzu9P+GQ6FK8ROxI8
         NJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167425; x=1733772225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0lwKiEACMAPvcW411fJIEGRcVHX/+cvcSO0BF6RzuA=;
        b=oeoveW9ws2Cf6rE8xcuFeW+L7z8gQ3odgCRmpKqf3CEjPH7Uif0JfhdYFkHFnJy3qQ
         FXazYcRjMfB58kAmtIcuYXhn0MzK2w49ULoWcJyBsrJGktr8spigm2qYECJE9DQa/2qW
         ehCJ9MJXDn3/f9E5tHXp4+sXluR8P2PnLH2ooKeY4TJq5c23gmKf6ph3MIqxidVUWAZ6
         GBsbX11SOASOnGYQmdqIbLHmHR118b3YtWko+e7tmpE0t6DY7LSfv7sSax+VIaTlhPWe
         mwMeSXHGZ0RvusZUsAbI259D343aMYcgnmw03II3IXIlN0bcB0Jxr7+5FIY7SlzXmKYl
         jadw==
X-Forwarded-Encrypted: i=1; AJvYcCUh1O+RWMmXkZk3qNZtqMJB6haMWFJ6wSk5i7i5L9KH/9/+dTV5wrVXNIevRk/lmdNJoHgAd5h3oSPR3YnY@vger.kernel.org, AJvYcCVGYyBxkE3juvhm1X5wR1fLf9nPPZ90U64037EwFFZdSNkvyTFsxvdOiR04TawdHNO7OVhN5IYg016l@vger.kernel.org, AJvYcCVIRTeJYpMmWwigcZIF+aOGYf8gz6VzEBdmNKJOvE3eidvVHtiQXLao6wsC57EsxfqTWmjlE47oJvQn@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhOOgknLsn5RzakIhay+/4J4/16sn3uDPRngQaLceJkWYtiVr
	ugBczeGK2mx2KipXuRgz+sfiD6WJiriKoXPx5v1fhgf0ewiBrhkv
X-Gm-Gg: ASbGncsjadbgq7gjb6lbWJG3atzcN/Rjo88CcMwfYol4xyqz5ztNCVMiNAFbpO2YWHE
	SiGDVRPs0XTrorhxRejri4uOCRSekCakRkLIkJ4TbxBGcjVHvlc8uuoVuF3s7FvzPtQtOlDHFXO
	xHpJyCzp9vKtSgEbO8LMCMDgv/egOkMz6rZSvDMejTB2HTt7yOutdGIY5Xtt4nFpldEcw9YBLFV
	eJTWXvje63Fg/81Y1KahUu7WF6KsRLLsrhQ/1rYRJRt/PDW/Gl71uioOc2ZGoI=
X-Google-Smtp-Source: AGHT+IGjsW2s6N2IJOHUo2u3n7scFirGUdP5Jk+yn96iAt82GqGZtL9W1ftePbKjOi0WRMNhr+gJWw==
X-Received: by 2002:a05:6000:71b:b0:385:df59:1141 with SMTP id ffacd0b85a97d-385df5912ddmr12418155f8f.5.1733167424856;
        Mon, 02 Dec 2024 11:23:44 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm832609f8f.20.2024.12.02.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:23:44 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: iio: bosch,bme680: Move from trivial-devices and add supplies
Date: Mon,  2 Dec 2024 20:23:39 +0100
Message-ID: <20241202192341.33187-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202192341.33187-1-vassilisamir@gmail.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move dt-binding for BME680 out of trivial-devices.yaml and extend it by
adding the missing supplies.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/chemical/bosch,bme680.yaml   | 62 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
new file mode 100644
index 000000000000..fe98ec44f081
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
+        co2-sensor@77 {
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
+        co2-sensor@0 {
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


