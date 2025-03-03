Return-Path: <linux-iio+bounces-16308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFAFA4CF70
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 00:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EB53ACA05
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D931F3D56;
	Mon,  3 Mar 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpAeOByV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD31F0E38;
	Mon,  3 Mar 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045765; cv=none; b=TKUJnCXgWFEzupGWPuxIeOTIjhlpUB4DcDEAh+sOnTx1CUf5dsZikuVkxqpcB8vhgiNIrViDlcySXaeoFvAMUVlaTSawRXzh9x5L8Ezj5iotHA8Bhu0MJCJAZpU4nnw9XZ2I2c2xGj7pYG1EpXld/R1R8HQPIWCB6LT5AtrUEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045765; c=relaxed/simple;
	bh=oUi0jUhO0onTNNPUZafZGwsnGSvTxM55zWWRbgJAGRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YhwyJ/7pPO8g0dBK2034khqEeSIN/fzyBTNBplZMKqyHq560y2trKdCgif85AzF5/KHcE19i83rw38uH9f7yzV3PVGAAhcD3r4P/7j9bAlICmZeKwXmuSejZQs+uUGmh1js1wFxZF/Khvj08Cqh8EjLmwaLOZO5U3RpJnQtpeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpAeOByV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232b12cd36so67719915ad.0;
        Mon, 03 Mar 2025 15:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741045763; x=1741650563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYJ1AOOF6Fuast7FuJwQwgJn1W/QJXvpVCQfOQs8dx4=;
        b=ZpAeOByVEihWEdORJ4naq8Hj75jm5Od2h6bTClAwBAP3SGFxndv4SePRrm/hEyNPhV
         G+HRJGsbdxq9TSMFJ7RHne4vDBL6bZsA62aW7DklbLfmbPXqwIfnEjeVie4sOJKIpilN
         MODKY81RQ7s3CmVha1UnOyEI61aP7neYEaOAkCVZH/U4fp7NeP10zI7gjsp7vUIRQUTC
         jfPFC1HAidnK4MP6OrOeK5TyE98n2Py/mx+oMK4pDjC0oZj/NfWp/DAd8lqybxUvHEBt
         8SgFJS99ayHRcYywUSvImsZo1j1qyM0cSpiq4zghYG8+OMmao/Q2IllyCjNeiQJKzBlz
         Xg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741045763; x=1741650563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYJ1AOOF6Fuast7FuJwQwgJn1W/QJXvpVCQfOQs8dx4=;
        b=rWkzU6Lq+nKc+S/YAM7Ake5s2zAJRj3syhe/qOStslURIIkRH7txHAHuhNB2AStc1n
         y+VwQzZnWy5xc/l8G+j3wdA0DqhEfowogX7Aw9+oZ+cDbwAGAmg5QZjZHhdTL/M94pNV
         tLm33UDxwaDMIqA6cXRVWqEtp6wHSF5IfSyqJHfQbkL7Hm8DX2th18/UpwMWUXeXzy6J
         3lTdB2lAj9FptXhtBCjjZpgV3gS7ht1QNd+z4hkUXVL8em+B03jaa8FGM8TUoo2q4Qnr
         ZXA04vRuIf9FZws55V+yx6orlmpsNWBuGf2AmnrbVZCeyYksolPEdg8YSRsLxZ7uHzRk
         A2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUxilFUtIiIx0MeaRxPHOi7NFMIotkevfbk7u2N49xlWP2OEY78SMQ0W1CHxz4F4VUDYw5RFW7L743G@vger.kernel.org, AJvYcCVa5kgTj31a4PqsCLFPWSXyouykjqwP3pLHwzNqwEXRB/vy8kWn09olahr1PUj0ghK3WOfKgBkCXknD@vger.kernel.org, AJvYcCVmbnUKc9tP+MtZqAeruJO4NG6ISgmCCgNG27PACQbXGpS8Vu+vXTjFm63xM8+R0Wk0zKsJBdv71v7SiVet@vger.kernel.org
X-Gm-Message-State: AOJu0YzLz4fZri65+ehL12EbzPxKft9UAksDvOQz/fYYSC7rE2RNBTay
	7DwLLQoy+dykK29SedR070rm2gRrnFegz//QKAmXWUa5e9Nk343r
X-Gm-Gg: ASbGncsBHCEMML0NL1ZnAiNF3QqQSfs8hge+OlE2cxOMmVUspfbN0PuBMDini263wNc
	3eN0kZvzCTG67nJVirNk94cMRgSNPu4pFzuPz96Gz6vpIA9ypM3F4QOU4bYV1bBX8PuujEejIaR
	InblB24naFmO9Lj9WmEFxKsJPSuhoylisYbYb5uGw7BzC//cDsCpz8jQHxXiCYEWtH8d2CF8Gpy
	OFQfe8Hz7jyJzPDVxFXExp+wFpxClWY7QQU6l8+Eo9v0XQI3yR2F+SFNiwqeJNJjAUOtHm0nC2f
	2b6ztTp0cSlIy3tOfflvnj0k4yg4NTAR6W55+myND4h0ZKZ5e1GciNLDNA5Z+4K3DZ2E
X-Google-Smtp-Source: AGHT+IGud6PYFMMPUpGldM4VW41ELjduKt3ffPZ3XDhZP9ZtgQhTGW1FAO3MuExVyqDYgDsAPDZcwQ==
X-Received: by 2002:a05:6a20:3946:b0:1ee:ace8:8181 with SMTP id adf61e73a8af0-1f2f4d1d213mr26375064637.21.1741045762741;
        Mon, 03 Mar 2025 15:49:22 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af180155f85sm5689283a12.62.2025.03.03.15.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:49:22 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	21cnbao@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] dt-bindings: iio: accel: add binding documentation for ADIS16203
Date: Tue,  4 Mar 2025 05:19:13 +0530
Message-Id: <20250303234913.66614-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add device tree binding documentation for ADIS16203.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
new file mode 100644
index 000000000000..e67e856266f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer
+
+maintainers:
+  - Barry Song <21cnbao@gmail.com>
+
+description: |
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adis16203.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16203
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@0 {
+            compatible = "adi,adis16203";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.34.1


