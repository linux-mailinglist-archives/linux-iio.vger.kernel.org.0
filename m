Return-Path: <linux-iio+bounces-14510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24909A17467
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD181188ACE4
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050DA1F0E4B;
	Mon, 20 Jan 2025 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFBryyXk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600B23A9;
	Mon, 20 Jan 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410210; cv=none; b=YKjZHvlS9HKvQ/9wB5Cxx7Kawpy1wSnGsziqfoLGiSzQH0vSeyXj3KXs/KzcI+J1TOdQ6W6nwyESK5DZrDAghDgeT2jCwdKb1jjjpr/78j4vUmDY0xNl73FQvxDSqBz2AjgiI0tFrhN34IclrFUuocv4vQmv5ONwTbcapl8jB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410210; c=relaxed/simple;
	bh=ar1h2TcY1mxL038b/A8b51EXhxGPSiLsQ3DDoDy9mUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ho+I/5QpbrZ5TU60FGpBVuq1PblexYgbCMfWMctmeadxzl0DYGL/7UZ3GKZfmy0N+z7HwAVIBbRVoB5m7k5vPEP2Y4sS7hJiz9P4FvEp2SVMdu3uNB7puZMfBx7iuJXijnnLlBTOE7TmqV5P8jYpMN+GpIQo6LGGJxnmoZ87nD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFBryyXk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2249814f8f.3;
        Mon, 20 Jan 2025 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737410207; x=1738015007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDhogYmxn9nFFr/Cayc1gvX78+DR1DlL9ARkoQx2kco=;
        b=VFBryyXkjdlSJ+EZaiXrmOK0mP30Wo93YfJeQZs2k03mJYfwaaaBsFn/jBKMd10Sje
         bCAaEYd5A5v5S8lOObHrtLVzVr0ytIichH++YKxWGlDE3/dUcK8y3rhhmRw/G0/UnToF
         0S99QxfAT3sl9zFaXlWzKna6RcU4lCUdytDTD7YUHXS1qWkJbOY83gsd717HQkjBf2D7
         CG+MiKr73rp2eI6z0XXHY5HRlZ3eLINwVt/o8hUqya8H9c6WQNQgCbX7z1c5hhrjwuFT
         aY8UGySTyoCeJDkCxL201ew98XLiOsFyQWq66dcbmYlCTthWmxpd8m9e+Gx1qRI6hP78
         vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737410207; x=1738015007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDhogYmxn9nFFr/Cayc1gvX78+DR1DlL9ARkoQx2kco=;
        b=KIUHk9Ut8eLM5wjEUmgg4DDgsJdI56Ziu0AV66TZ2TckEFCoXzOhjy605o5Vg0XOTW
         r1xlBRJr/OF6Rrbr0GI8qBpnAJjRd7HxjilawhLtTADFf6CLxcIp40Yqfr/gwgbFCkU0
         7xACZP1DS18fA/fOmKr2VlMaz/vjCMJxX2RLcJGwKfuBJfAg3KRkA7m3R4fdkSaMBWji
         SOm0PRaDGgRchIFFQlDcKHqv+0gNgHoLX2aQPFDjv3tCZoB9hp175mPIpCPcgtsV/+Ak
         pC2QTR8XVUonyCkRiuymJOYPESa39TYcVIoDMCFtIvhCJZktfxB7W21hQPDUI/ry4iMq
         f/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUj5ixCaYOgDf1qhsvvOu7mcXSKQLbAvYEz2U+SbYfa2CRmjgO9F3vAabXx2vlKAHk3evglIwVHAMvu@vger.kernel.org, AJvYcCUjj7fUNv6OUsGqDuXKD2S85+EuCboOF0IGFRYhnq2bwRtRCfCPjpW4FK55CfLut2doGrTKgYa9FSep@vger.kernel.org, AJvYcCVzO5Xf+sGfHICp6a9gJvgoGhs1S8YLModRK5NEmyiVIMWxj0CKC57+TehMDQRI+/odYEpCaREgOaWtWSXL@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOaoPyaCQ/NF0XMQnskNtuqQsQj6BT61IsqDa9iNEl0grSi95
	7Zj+4UVE3mI16KMfK0aQOyibBEqtxXbTydinGeQC7IVA4UMLq4Dh
X-Gm-Gg: ASbGncvEfsYVGQQwuA4ptjaqYQ+h7U1naro9bBj1LvdlFhint4IEzafExACAh3jjz+x
	Qv23EwStmOPp0R/wnHDaX0Xu95wnv8vQE0hWzgyVdSA0cc2ePLmyjxdJPpaNM5jZgsRYF+u4Ts6
	uWgAARTUAquXvTsGVQeQ7lwfulZIHUnnERl1nr7OyAdhqlZQG61nFg3GRF3ym9OgXlL4dZsSjnM
	DXFyJ0I2q2ynpdENU9VV13hhvRWGEwk+ZA7okNFZviQiiBJ3cOuuWShlBfu/1fMoVe3PrU6hjUC
	qRMSZQUXtA==
X-Google-Smtp-Source: AGHT+IGfg424YbJwLwTrZvwaTx/CCNiZAi+pSxcqkX4Msf0M2MFRyjL+/crcGMf2GThqcbn/DFZejQ==
X-Received: by 2002:a05:6000:4012:b0:38a:9f27:838c with SMTP id ffacd0b85a97d-38bf57ce8b8mr13753626f8f.55.1737410207010;
        Mon, 20 Jan 2025 13:56:47 -0800 (PST)
Received: from localhost.localdomain ([37.161.88.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dd34sm11374345f8f.83.2025.01.20.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 13:56:46 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	icenowy@aosc.io,
	megi@xff.cz,
	danila@jiaxyga.com,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: magnetometer: add binding for Si7210
Date: Mon, 20 Jan 2025 22:56:19 +0100
Message-Id: <20250120215620.39766-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250120215620.39766-1-apokusinski01@gmail.com>
References: <20250120215620.39766-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silicon Labs Si7210 is an I2C Hall effect magnetic position
and temperature sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../iio/magnetometer/silabs,si7210.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
new file mode 100644
index 000000000000..d4a3f7981c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Si7210 magnetic position and temperature sensor
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
+  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
+
+properties:
+  compatible:
+    const: silabs,si7210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        magnetometer@30 {
+            compatible = "silabs,si7210";
+            reg = <0x30>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
-- 
2.25.1


