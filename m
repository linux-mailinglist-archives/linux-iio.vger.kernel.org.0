Return-Path: <linux-iio+bounces-7327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12E927C65
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E81C223E7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E014779F;
	Thu,  4 Jul 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbFss0iK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19939FC1;
	Thu,  4 Jul 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114936; cv=none; b=WSN1WoBSP3cq9wUmgdVMw+5EjMFlOahYojl4/TgjKzwlVJxeEI5IaN39kvMRXT+X8H7ypVSB79c4GTttVFCnYkUp1psIchlOdcuq5ar4TMpiFQ4S12dqdYIjf9CPs/3Q46I1ri+QE1qiwnzjep33fQCo7C2LXZwJ/DO1n1RjkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114936; c=relaxed/simple;
	bh=lhkjKV6etROwmKYt7ji8RneUVGzDtOb8jYPIZN1kl6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkIaSttvWBs3FFh5RW0alw042y+kXRYm5GvSI/Wshfx2Jwfy6oI5OnZPQKqRDoQb0knAz7prYrvE9okGtdO0X8AuGZKLbZqJNERitN56C053AsDHeqjdque3QUQgbPTGXXQgV7ZPjW9DLa3tLEgH46fFj2ceKjeseKGv/WcYvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbFss0iK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4256eec963eso5722575e9.1;
        Thu, 04 Jul 2024 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114932; x=1720719732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDY0TLQz375z/4v/wiF5RMOfJ90TnWvvIn6hociwdaE=;
        b=dbFss0iKI5vzN5DF69C+ojnzzQ68Z5MsM8FkT0hp4mEJJlpHLOnxqR44TO9MaB9Qg4
         MLuwdGb4e55W9lKhxKx+CXdG0j4AKSf+1HTK216SdCk4ecbwj0Hq7RtNLn87W/1FVtJ+
         mStuzr2NdYSq20jpIp7FvgZHM+jKcBFQsiCNFf0FqXyoGK3U+B/4pjJ/53j14DDRRZQ/
         UqdESlgiLYMeoiugCai/nVk/WmzjNXM2MQC4scwji4DhKeA8+av2GxPyCf6/zXn0mErI
         TT9ofI0KE0iu9nNAhpNEk8a6EiPl1HJqZP7AuFj3KOJs4xMbKOGFwfaI7jvEREw3rz5F
         ZFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114932; x=1720719732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDY0TLQz375z/4v/wiF5RMOfJ90TnWvvIn6hociwdaE=;
        b=D6aV1B8psCEEBT5HTGPUXpBU+yrAWVMZ11owcYWZwfINhYMDo9yYdRPt8o5Lqpzvar
         VjEt4ylQjEsjtvr3Mcqw/DHjx4uHf7LpTZS+e6uU8zULsaQiImTFPbELRp3awTgiwlyx
         G4AszUPMqJl1OTBMJCItlKzQnp8SPbWGs7muQw5XBr9uWMLxn25apje1y3COE9OsSTRM
         q9cnhlQpoZVIScVH5VZUC7ZYLsGmYadVvetp2j7YWX7+Q0+VQ+d7JLf0ldv53SeFRZbB
         oDjY8QbSWmgQT7pRopOnJNvgtlUXX9UJ4PF5s3r/SF1M0FKIi04e+qcV9w/PgzJjzXgV
         ltWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUyfSjWpnJulNN9I9ZQFrCkZ2NfWuDgJgln4/OnZBpv5mGgHTycM++1Hs1MWnxG5xUyqdzJqdoXcbZ15qoEGMhwphJfT9KwYutKUzRsL096ZWf9wSs2hM50KW456IS9l64e85dtzfQ7w==
X-Gm-Message-State: AOJu0YyxhEwOdxL4Al7mD1OobYfjYooZ6nb7P5kKjRbT+6bqiU105Qdu
	KjI15i+XdNr4ZN1XB2iWOp7Ww5n+U8UbR5XrzLRlH2S0nbz0QBDq
X-Google-Smtp-Source: AGHT+IFWiXEkiyUlWgPKEnzDp5P4XmxoVOZj9814mhAsjtvlE3iXD1P+O6ta5BjTJKqlDIwnfEq7cA==
X-Received: by 2002:a05:600c:4395:b0:424:a3d7:2a89 with SMTP id 5b1f17b1804b1-4264a3d8c05mr18404925e9.4.1720114932544;
        Thu, 04 Jul 2024 10:42:12 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42649dfcc73sm17734295e9.1.2024.07.04.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:42:12 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 04 Jul 2024 19:42:01 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add binding for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-iio-pac1921-v2-1-0deb95a48409@gmail.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
In-Reply-To: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.13.0

Add binging for Microchip PAC1921 Power/Current monitor

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
2.45.1


