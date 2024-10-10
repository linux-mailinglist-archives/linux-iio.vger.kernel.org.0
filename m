Return-Path: <linux-iio+bounces-10422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2B999421
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204741F26B78
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D491EABB1;
	Thu, 10 Oct 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEmucd58"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C01E885C;
	Thu, 10 Oct 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594050; cv=none; b=TPGq6NBmu+YM3bsNIbGG0W4Lt/dj5iEX5RnOKM5AWQKBbuMlZ3M8g2qRzglc9lb2CA6ntOaELhSOfQQWKXSjPwKjHuda/nGeov7KaxaehUXCLWrU0hJ3mA/3Z5ekJ/ZDsGHC10klUXTGhmxzYx5zM4+YeODQ/rStEsxbRZDNNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594050; c=relaxed/simple;
	bh=H/Oh3NFQCKsLBwWTyouem7Lo9ZCIqcLfvcnpwANSZIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1/YzNkadiQlhl1xY9tC430N3R7Xp2rBk8S1EWUTw0VWWgH5Wc9zOEAzos7koQb4ceYQ825eEmxIxS86dK032fwt0+A2wvCKB8vs0HEAWsKH8JLmJofwIUrwROtdfHpopB7USrOkBHPlxm+loFHcplJe3jIKne2bYHgBlVzuBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEmucd58; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53997328633so2275075e87.3;
        Thu, 10 Oct 2024 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594047; x=1729198847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSdbgLR24cpkLSskWjqR+dewrFXV8LMYuCQdNklHO0Q=;
        b=QEmucd58RKwihdMOUAMDtjLjUKIkaJUuGTS+dUEtQv2bnSjyl4T7x1eMXoFzzC8lZd
         +BeSQEQguwQo7hF9uxl9Ehgk6qvOJ4AdBTZ+bdAfSxzN7FlS/9HglbCfOZZ7NBJmwcck
         kvvS1zeRTiowP2IHcNguOQwWJTptM/y0p0y3pD6T7mlRzb4dRfJV6G5WmAcFJhaG5t33
         C7ciC9UzjfA/UM9S2Zz4x1La8ZZyvKMaX799MUtCvim8KSvaPh0ALi1UUYp23S7S1PdE
         qYHLTd8qywESLnyQzUq1p8oFmjDvY7Z6/5D9OBw2Bmxzx21vxYLmFdXN7yrUj9Svdj76
         0wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594047; x=1729198847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSdbgLR24cpkLSskWjqR+dewrFXV8LMYuCQdNklHO0Q=;
        b=sa7gsD3XvdRl9ImsuixEH0Hhj/RCGT05IoacsTiWJmud6dPFYfNWBylArVKvWBK4Th
         ec4u9GkC6dBXpBubUbcb34qCDo6JfkZJn78OfJ8JMlnqXhMLa6aMkrvobcAyf/uCIn8N
         oVt8fQNcxUM/tT0EhQu+3aN/LNbHwRuXreDnrfuqHHgyoLf+OiCtV7dOgCVJG0kKDqk3
         1DzrIG3Gg6F9DHdsc7+Ibe1fOkghMSwaokmXxeHTg5l+cDmn424woLyUBqQldZVbidEJ
         kTzuSlDqO8qNuQN3jcSi3zrZleXbvhtcGdZYbcdr6Qy7Iu8eaXGV7v2i5R/oSMD44Fdk
         TcHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKrAfGtAY92NF0rnhyRWX/KcED5GJ9+oUxbZrURjNr0DBPUmQ7zJjYhOoDOz3kc4yzeNh4Zcxv29Qx@vger.kernel.org, AJvYcCUpvSMlmX5Af6PaeTpfchaHvWHF7asZB5R++kKEEw67v+11PZySnFhxZM8oY3GP5MOn76g6y/OeJ069@vger.kernel.org, AJvYcCV30fFj2WfvwJLZKUhgQd2AKTtAkcv6zF1UxV0uRD45w2yeZz6Xc/13ndKgO8Rcpw/1hUwS1/1EJdBPjEdL@vger.kernel.org
X-Gm-Message-State: AOJu0YwUV+mbs8qFp5c1okVLLajPdR9EumydIDuROkiuJVCevAocHUbW
	0fcMzeUqrpzuKSFHy+3sDQHmKwm844mL0gUS+99YPYn6Ciuhs5lf
X-Google-Smtp-Source: AGHT+IGhdis3wyOKJ+ndw5mOYpSKkBD3jsMxZnwSv1fyhvFpI3trQbf1Z/e5f+NT8pNSbAru0E2b5g==
X-Received: by 2002:a05:6512:3c9f:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-539da3c4ba5mr112324e87.19.1728594047042;
        Thu, 10 Oct 2024 14:00:47 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:46 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/13] dt-bindings: iio: add binding for BME680 driver
Date: Thu, 10 Oct 2024 23:00:23 +0200
Message-ID: <20241010210030.33309-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Add dt-binding for BME680 gas sensor device. The device incorporates as
well temperature, pressure and relative humidity sensors.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
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
-- 
2.43.0


