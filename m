Return-Path: <linux-iio+bounces-7780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7216938D24
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646FD285EFC
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685016CD3B;
	Mon, 22 Jul 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMyHohQ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2716CD01;
	Mon, 22 Jul 2024 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642627; cv=none; b=Y8axOxrV1A1LBiay5uTSu0orvTRVjSjDLdOLnlYUEVk0sFd1waP2d15a7LgtWg0r13dF+AxxKAJ85jjzYDGIfCspMX108NGMgLfx1gwOZ90drlF2cLWB3ykfLwGBWPFGTjLy959Gc95RkHr9Bi5Qdcae0DLO2IcCM738SpfWRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642627; c=relaxed/simple;
	bh=Sp0lS/4ZgcNnr89NcDKRsei/HaSU82qxPlAmH4lQFWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBX0moV2LrzlIqEWWw34Qj9BTWH1/AvXoyBtsA3Cxky97Kq73ybAeM2CTLl2RyX8hIaFHfRuitMOdOkmASJmbIHxuSROFYJZD6dQxw+TJj/mR8cRlykVC10gqAeDgCjG3l8kpm8Gah4LrUSCU3Pya1abL+ePuoZcfHztmO3+Dec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMyHohQ/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so19116655e9.0;
        Mon, 22 Jul 2024 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721642624; x=1722247424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAKsVDrmX4xQCdqDG+6w6ygld9B0t91ecMBwqG6r4fw=;
        b=UMyHohQ/ISohh+15dlsy9pR2tFi9Gj+lzqQmOVV6q4n5tZ9aXYkenqAdg2wfwFhjcV
         3uvw0X1YMqG0gH09W9EqjTD+2QXswFOn48Vk1tl6m/vWzjgHzbZe1BUi4dMOKHe2jqD6
         oTWTUcGKg/0Z9CXQoCZFkPwoAXVaYjI0lQrZUZ9IkjtwjAcW+yVzNr/OzewHYeUpmJl4
         rWeZrhhwG62uYmsJMHUyNCDvwZmYrcIIF/Z0qU7SOLt/SwGi9f2dPar1Fq890lIzth78
         sI/IT8p4WtSYm5XSaK6exiGwWOPqmbN7L1III3WOOAFDhWJoGkcx614XT6h9fVYhtuuF
         A9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642624; x=1722247424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAKsVDrmX4xQCdqDG+6w6ygld9B0t91ecMBwqG6r4fw=;
        b=HDlsF2AMmlU4Jfg00AIVamcwKAp/tANj5silrMjS3PZ7vNApl4BKAaEAGfrDJRzW8w
         Homcw7KtYzZweUh9C5/Ftm8RgC83N72rXlhvrOBfsgUKyTssgljFpiFo2pJVahO9N85Q
         86dMOLR4TBFHeWRuBVh4nDcRXx6DBM9/EebcZ+tWppziqD+HyIjrJewRDHaiGj7AWM9Z
         gAlUyPDbxpxT+Fb7yvK5YqYITtr7wni41wCn3Tkkf+mjs/AlskpHiM/qqjir5dNiGVcr
         nXly6oKOCihrOQGbRAvm4sshwpqIh9XAK4zLi+uU6GY1DZbn4um2TqP5lLYY6Gf2vaVm
         +N0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4PHDazynGaFd84ltXYZcBDwbCLTu2ZwQTVhI5YfXl5k8+fNqHyovkTfOOvVLWbyVkq8wySRalvoXlF4q1BidKGWzynXjnq3bpZz9yKA/bLVCgwuG5JrTRQc/LAYO7Zoo+SG012rC4Wg==
X-Gm-Message-State: AOJu0YxH6qH3RiLYFLRoA3DT9uGRYvvikbIKf3+0mng5oWPbI7rwPe2T
	/XlmDkdp3KNGO1+0CSGBTjpWifcA6pQj1P/TpsdTyj4+ek4AXRM5
X-Google-Smtp-Source: AGHT+IHcO6RJ0OO3yoIJkUcbgrqrx8l4GgeicGn/p6aUvE2dQAjv70sH5rHEBzbhduAtlCZ59d1SqQ==
X-Received: by 2002:a05:600c:1c15:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-427d2ac0092mr79326495e9.14.1721642624152;
        Mon, 22 Jul 2024 03:03:44 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa394sm120808055e9.3.2024.07.22.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:03:43 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 22 Jul 2024 12:03:18 +0200
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: add binding for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-iio-pac1921-v3-1-05dc9916cb33@gmail.com>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
In-Reply-To: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.0

Add binging for Microchip PAC1921 Power/Current monitor

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../bindings/iio/adc/microchip,pac1921.yaml        | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
new file mode 100644
index 000000000000..b6f01b79b91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1921.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1921 High-Side Power/Current Monitor with Anaog Output
+
+maintainers:
+  - Matteo Martelli <matteomartelli3@gmail.com>
+
+description: |
+  The PAC1921 is a power/current monitoring device with an analog output
+  and I2C/SMBus interface.
+
+  Datasheet can be found here:
+  https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS20005293E.pdf
+
+properties:
+  compatible:
+    const: microchip,pac1921
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value in micro Ohms of the shunt resistor connected between
+      the SENSE+ and SENSE- inputs, across which the current is measured.
+      Value is needed to compute the scaling of the measured current.
+
+  label:
+    description: Unique name to identify which device this is.
+
+  microchip,read-int-gpios:
+    description:
+      READ/INT input pin to control the current state of the device, either in
+      the INTEGRATE state when driven high, or in the READ state when driven low.
+      When not connected the pin is floating and it can be overridden by the
+      INT_EN register bit after asserting the READ/INT_OVR register bit.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - shunt-resistor-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@4c {
+            compatible = "microchip,pac1921";
+            reg = <0x4c>;
+            vdd-supply = <&vdd>;
+            #io-channel-cells = <1>;
+            label = "vbat";
+            shunt-resistor-micro-ohms = <10000>;
+        };
+    };
+...

-- 
2.45.2


