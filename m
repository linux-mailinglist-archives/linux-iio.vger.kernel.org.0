Return-Path: <linux-iio+bounces-25294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D96BF35B8
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D518351029
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653A248176;
	Mon, 20 Oct 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQUzqk/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB82D3220
	for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991455; cv=none; b=QWRfDymb0F3vu43bRAMU2TWGe1Kj69RQ3FLbDJoCdyuIFv90VVIj0yg3UhIK9XSCQEt1NEIx32q9M+l5fqXIMkcUjIJ/zmAcag+rNs9clW39pI3GwtM11tRbPkBAeIshpVVdBLsihXqUVI2G09ARi4hCgZvy80q//E49Z7kySaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991455; c=relaxed/simple;
	bh=C4n75EtUZau6mSTuBCJYnmGv0sbGRgbQfabkJqiKw1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddXzKxCGijBq5fcWvAIfD1mUkEsfyN33shEL12rAxHYvHwHmJH9BPo4TbYnJoeVJEA9Lmk5o0DZe614d1Vc8fLFwsW+i4op4yTmfm8XhqXGCDPMEFK+GSWbpdCUar9PA5Qt5FKvJucmoia5vXs9OWFuWycVTbPt6cFYVw1uv0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQUzqk/C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so4883918b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991453; x=1761596253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uga9JOHOylm5AvbLQFDeQho/nQbtIcGlvKSVVqsfm7U=;
        b=YQUzqk/CZe3lHRMkExNVSqK/8lJ9F+m2cvlHjncSJVgsiHre5LJ/kzQ2CtUs1qhv/5
         wLblmxGhCKO/ZXKECtBd34UFHrQNMLCY6FNje6o+tEMJS/S373yQgpCdfbsOLm5dR+jv
         RQvcqFPHPYX24iIXDOYO8jpB1zYE9VpR4N/aU24WnesYhd2nMZhnOCJElKuXWx/bogKz
         Bo+5OM06+qZlpSy1Efd/ZNTOZ5TP0Y9nV+aZLkoEFl9TI3j5IKeTQ1Orhshz9qB4cRg4
         5chXYJP5wZGl1K/2hJ82+HQ3eFXBmUfpA1Q56KP6fm448BVMGPhOMr7NbkWaDb8FpSzO
         goww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991453; x=1761596253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uga9JOHOylm5AvbLQFDeQho/nQbtIcGlvKSVVqsfm7U=;
        b=n9ZXlYoEFlAyYPwcup6s6YtU40PZq4yAzqU4Y6/i8gaF+vqlmjA44Z/l7fQkRdWcce
         e2qTP4vHGKLoo78S1WxbsK7OEqDf7cV0pObCVZoiJesgdJM9uK5KeQcs6LE90eazTEio
         iDUW8Bq6T1wkZvQ780a5dovW9rBkM/bwqcdXbJlHdFE7h5v9BHOU5Om5dqBF2GODcgW8
         +On/0sBTDVjfQvpFTRocX1Mqt0h4ykX2f7vpcCoipp9//BCT3VlckKX8fzWcQdeFX/8w
         2mGDbEjY5LtjEZGhPxzI4S808z88BLpV2+1JcY4AL6p3DaeE5WTAEK5WWyUr4QNswhMH
         T5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUMoCHOv5uETPV1gD1Kls4lEaErNJEPDoO5dq9tfLUIrGsxZeX8vAxKf8DS1RpsLlJXyG+++N2HzDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9USlmcFFNwIlP/rbpH3ig+FNOC3+2fnfrLtEXJQanTH5G8IHt
	we+6t4mTs/Y0H5T0PWaysc8LAQ+QcHy/jNqNiF0bjOR1CtrDsr/zaSWO
X-Gm-Gg: ASbGncsEfcuqn8w25q5FgetJQ439AwP0vd5Qy2PsVkenWZ/VdgTIm+rVk+oC03kTLqS
	iytaCmb0nsphHg3aa7XjejH73ZgUMQ4Ysyon9Aevh5YfY4xujSJ5ihTgbXRiyfePn8bpgVdEojx
	7d1KgD1CXI9Zag7nmOWxWfQlvXEGopwQlDhBBshHPyEo822AT2htI0IEMl/368xnQ6/4lB0uYz8
	GVjOT8Zo5hwac/khn7+AzVln0IHZFlAZlh9MAQfGm+XSNz2OgVttjtym4qyvQS1vH0bIY0xNXbt
	a9X0EHcAnA3hw7BMg0mYKHtcfxbHxvFUbMLTY9mRaoVrTPNnZsT49rYhH87mYmOvbZz82KUq41S
	HAEJJcf1nArK85+/jwMid+dGfnPy9yi6U8sofPoub98Y0nH6O2zzzckAeFz4OdrjDu53d5HiwTM
	Gpb/uguX109u8=
X-Google-Smtp-Source: AGHT+IFcbeiHhVChHhGgVr+DQLb033/vhWJVXc5f9BaiGvg1ErIjX25PrUAwPKcLPmdEptL7IJdg2g==
X-Received: by 2002:a05:6a00:194b:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-7a21fa1434cmr17940908b3a.9.1760991453355;
        Mon, 20 Oct 2025 13:17:33 -0700 (PDT)
Received: from pop-os.. ([106.222.200.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm9104263b3a.59.2025.10.20.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:17:32 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Zago <frank@zago.net>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: position: Add ams AS5600 Position Sensor
Date: Tue, 21 Oct 2025 01:46:52 +0530
Message-Id: <20251020201653.86181-2-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020201653.86181-1-duttaditya18@gmail.com>
References: <20251020201653.86181-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AS5600 is a Hall-based rotary magnetic position sensor using
planar sensors that convert the magnetic field component perpendicular
to the surface of the chip into a voltage, or a numerical value
available through i2c.

Add dt-bindings for the sensor.

Datasheet: https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 .../bindings/iio/position/ams,as5600.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/ams,as5600.yaml

diff --git a/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
new file mode 100644
index 000000000000..d4c92dd41dd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/position/ams,as5600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ams AS5600 Position Sensor
+
+maintainers:
+  - Aditya Dutt <duttaditya18@gmail.com>
+
+description: |
+  12-Bit Programmable Contactless Potentiometer
+
+properties:
+  compatible:
+    enum:
+      - ams,as5600
+  reg:
+    maxItems: 1
+    description: |
+      The I2C register address of the device. Typical address for AS5600: 0x36.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ams5600@36 {
+        compatible = "ams,as5600";
+        reg = <0x36>;
+      };
+    };
+
+...
-- 
2.34.1


