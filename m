Return-Path: <linux-iio+bounces-7134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B192402E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF11C240D4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCB1BA079;
	Tue,  2 Jul 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM/3BCEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805D1BA87A;
	Tue,  2 Jul 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929635; cv=none; b=q0TOqiNTC+zTWCv3Oi1KSSaOhcBbyE/ocJT81Wnt9qORzUI/bxblOFXpwos8xlPSsXbTeYB0XzBt7D5uce7j8djfkQOmBJMrsNNk+amEAzO4oekmJwRZeiSUawCLoxCBKyqqrW/ZIGxr5i7Tv7sGMPXBB3xa8kCqNxAsKyW2ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929635; c=relaxed/simple;
	bh=zAPjRiUOZ/6A2/c4iRGiRdD6GXZ4rbWY7l8ZUYB4FgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWxKb3iyl2TaskjKisFAYWE3GFYtVsPnsau07mxGoaTbJ5gZmzLJ0BReaIN2In0NZ940jEKVJ+syXMD0sUiByccpn/o3ML5dTkFg/wlmaUtbw9qglvwIfW4/9vqQNFnhDIZDw4Z1lQECnxrcneh1vEg4o+cpE5UfnsrDDaQwdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM/3BCEK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7066a4a611dso2668604b3a.3;
        Tue, 02 Jul 2024 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929633; x=1720534433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edAehwAU6NrW8nvTnX8B7dL5g9EXnVVFYUq9uavQFNw=;
        b=iM/3BCEKlAHsnJ4ZgkRpnDd86uJ9GhcSpP+AM63OUiCT98mSodQqKPjtJ5Itj57S7Z
         0LbaNOCfaEOK9GOhJvavzV/f05elrut6wtk/2I6Bd25HqqlYW6ZOuQE2zaHlotWHTpyK
         z2n4XsXnYI6rT3fCfRO7NBBu6Wh1v+2Gx5RbuEjPo+YZcXexxEN9ucJOu/vyB9kp7ZU6
         hOrOXHTavvg6Ns8NSItVFnSzk3GeZOpS1q6caYfM+xCH5B8V8BgLC00YOzPneV69yvbG
         1O51Q86WuzOgg+KagfgodRnqBF4ccNdAilxZJ0X1hKtjADSOyqVXGw/RzQ1UUHZdTFah
         mWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929633; x=1720534433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edAehwAU6NrW8nvTnX8B7dL5g9EXnVVFYUq9uavQFNw=;
        b=V9S9C7QNQCwCuTb/H5NwCuik0YCrMo9lIkwmhGkt1uZnau8NcHnayoCoKgADkJ0ihZ
         6OWK1+GAEPoLfFbqEWiQdMqa+8mgIaypN7NwDur2fXEN9A9sJpfb8Q7ospTAhn5RUOvc
         otXIAnMGkpM/lXBz3uBzOF8S9+ZWNfBCXMXcNxxWWcC0rTS7fqSl5K+CW5QFUgiKL2RV
         +LS+4mjZ4NKLSWHlRVoKDz4Ld8A7KQBDng76PjOqKe/Uf5uj8oFTfSeiB/u4HLrAvlgm
         iXuN5POnod6YNEqzQ6oV6hbGPj/pUEzJ3MSTVHQ650b10LYiSQaZ88JZ+MfaCk9quGr9
         EeYA==
X-Forwarded-Encrypted: i=1; AJvYcCVKMrlJ4eh6jZTn5Eq4r2m3DzNePOsReYLaD4l5bY1FusI2LakBWPb/7W9oQCPhW7bT/zXPts3loiCHvwtGrRcaS4eKYc7n+ZRf0EjYSDPDoikwuV9z/M1qw5vri2HCyJlrb25mrkbf
X-Gm-Message-State: AOJu0Yw3hEOQbNPhCQwRLRHrWOS9bnlCXZ8MUIX0CduJ2aXbOYv/Nde+
	YWgRAJ3oAmwknmyihHumcwtPE29WqxhxdQVcoHdEUn1imZVxsni/
X-Google-Smtp-Source: AGHT+IFokC3NzXFU2GQDk/TlyJ5Mv6/J7//g4f0NuxjWTykTkwbrs6+Jouqs18X/vtLUMuOTkVQNhQ==
X-Received: by 2002:a05:6a00:218e:b0:706:5f74:b97b with SMTP id d2e1a72fcca58-70aaaf10da2mr7465494b3a.23.1719929632948;
        Tue, 02 Jul 2024 07:13:52 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8547872b3a.163.2024.07.02.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:13:52 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 02 Jul 2024 22:12:33 +0800
Subject: [PATCH v9 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-add-tyhx-hx9023s-sensor-driver-v9-2-c030f1801d9b@gmail.com>
References: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
In-Reply-To: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719929607; l=2748;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=zAPjRiUOZ/6A2/c4iRGiRdD6GXZ4rbWY7l8ZUYB4FgY=;
 b=FpvCDrWLRv7/cwBiAK6GfbqDAAX42kbyPj965XGeyLSP34MdDUV07van3IdbDaQzMQAeliN1o
 e4lH8/SGia6A0dso071M1zs/E4FdgpogxVAbFqMiZ4GdjHTdz7LhXIf
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

A capacitive proximity sensor

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..64ce8bc8bd36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TYHX HX9023S capacitive proximity sensor
+
+maintainers:
+  - Yasin Lee <yasin.lee.x@gmail.com>
+
+description: |
+  TYHX HX9023S proximity sensor. Datasheet can be found here:
+    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
+
+properties:
+  compatible:
+    const: tyhx,hx9023s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[0-4]$":
+    $ref: /schemas/iio/adc/adc.yaml
+    type: object
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 4
+        description: The channel number.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@2a {
+        compatible = "tyhx,hx9023s";
+        reg = <0x2a>;
+        interrupt-parent = <&pio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&pp1800_prox>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+          single-channel = <0>;
+        };
+        channel@1 {
+          reg = <1>;
+          single-channel = <1>;
+        };
+        channel@2 {
+          reg = <2>;
+          single-channel = <2>;
+        };
+        channel@3 {
+          reg = <3>;
+          diff-channels = <1 0>;
+        };
+        channel@4 {
+          reg = <4>;
+          diff-channels = <2 0>;
+        };
+      };
+    };

-- 
2.25.1


