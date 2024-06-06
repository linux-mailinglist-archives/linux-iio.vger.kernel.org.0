Return-Path: <linux-iio+bounces-5898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC518FE6C2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A028F1F288F6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE0195B0B;
	Thu,  6 Jun 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIRuFson"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31D180A64;
	Thu,  6 Jun 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677966; cv=none; b=HCnoOgrWDcPhcttenGCt7+1fmhY5+1+oteTHsL/8+VrzMvesXVOe9qbPBZHGj6YpXhzCD4NdpSFl3H5vTn/Z3bjWaUoOy7IL+QhAQX3shRYQQylMLbeNRzWsQlw7Yi5BsjIyyO8sjSCtlPVxFl5BwlbphfwM7X39I9s66DaVe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677966; c=relaxed/simple;
	bh=LX9gBGZTmqvYK9lvvIrBA+wReXBRVnBbIh+Cizc1lB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Be7CT5qVzpq96LFu13van0YPf8Gs4Cv71UwXgIxFWMe+ZjpFJRifkJJ8VR7fvOAd1YGUV2W7FiMIPlnhdczlN2FBSV5U22Qx2ZABROnA9+/SRKxS/v3dTDfuNpHTRfcURcd7C/lf2GyLX8YfZlnT5osIn5+T5S3j6Jn9LrE7w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIRuFson; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso940620f8f.3;
        Thu, 06 Jun 2024 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717677963; x=1718282763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/o+5PqHM76hdZNIjNBK+OLFY8Q56XJEGqjBe5klhOLY=;
        b=HIRuFsonnVclTpKYlab43SL0qx+6Xoa3dsyB0SUBgXxcH6f0YYWTFjEp7uw1WaSdSh
         8pMRt014Lc1HQlgSerdliQsOFGfONwsLE4xTjUjVxS4bXTAXJL6SzbZYB6pNYiOUG+FD
         gjHiGZk0P+QnNZ2a9yFzczygWQLVWlGyD754uPdhZWKYOLAcl4LriMZIvTqi9aRP1GF3
         4Q+W/mEDGwS5mZUkBNfqxHSc53DArfh4Sc+3q3R8REJAms2cdtGiv98CcHrEbKBt2QWP
         91T3OsTeIKzesQi3G+0y+uuUGPgKj4OSbfGD6OUubVbn6YZsBRIqtdUmvnKjilSz8Pxs
         gARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677963; x=1718282763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/o+5PqHM76hdZNIjNBK+OLFY8Q56XJEGqjBe5klhOLY=;
        b=QkQFJ58/71npGMsL/PLHlAH+qXMbxIz07zckl2tfzlC6UCR3EHvaeXdQJE5tlW+L+N
         56Pewdb5Xn/4HPwVzYNQtpYn82/wV9yqjc4eSTCVvjA6evEGlTji4NcafUeT1KUyniwL
         YVV/IXKPAs5+zh6DWD2HFI+n8ruylz4J4U7JCD49zIGH3K5XpPV1Ks5mbChZMlIet5VF
         QGmMZHOroPrgLko3W1REtGExq8lmaEM0qd0YEJ6kXS6wcofylH5ypELElDzBYujykffi
         rSmjgnP9DdyRNIE3oQ/2ENB6/5dw+k2qUc5PNSDzT+GcY4XSMbeHuEi0PFb4n8kOwH62
         rVUw==
X-Forwarded-Encrypted: i=1; AJvYcCWvYUi2Ep9yhJg03M4V8PH5/DrYYs7134e/IGTqAjdb62fEKCRB6SnSXWPCVEbv8EyaH7/62qpBbGjli56F7dQAL3eJeLm5oX8zdkda3tQagr44w/iW3NNOVWTXguioyIjj19IMi2yz5z+/e9zXjBlxG2DjyimijZ3FuMtuOnMWKpMV8Q==
X-Gm-Message-State: AOJu0YyYQPBBWjUlMsCmtMP/w6HVMczvwdgk5BLj/C4xR0WppVSQauQG
	H5AOP8xZf7E1cWOytVqh/dXS0p4sG3TsM5RuFOIQ906NvuKYstL/
X-Google-Smtp-Source: AGHT+IH8eZT87Qw0hHz5zhT5Oc19rcHYLUvlCZfX0lIdybcHZ3pzdEJNG4NfB7EVCkd/wUVZzCJm3A==
X-Received: by 2002:adf:f411:0:b0:35e:1214:8657 with SMTP id ffacd0b85a97d-35e8ef7f1afmr3930353f8f.56.1717677962779;
        Thu, 06 Jun 2024 05:46:02 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4cbb4sm1480316f8f.44.2024.06.06.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:46:02 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: ivan.orlov0322@gmail.com,
	javier.carrasco.cruz@gmail.com,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Thu,  6 Jun 2024 13:45:29 +0100
Message-ID: <20240606124539.60757-1-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2->v3:
- Move 'additionalProperties' after 'required' block
- Remove block style indicator '|' from description

 .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..d5338a0af6b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bh1745.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1745 colour sensor
+
+maintainers:
+  - Mudit Sharma <muditsharma.info@gmail.com>
+
+description:
+  BH1745 is an I2C colour sensor with red, green, blue and clear
+  channels. It has a programmable active low interrupt pin.
+  Interrupt occurs when the signal from the selected interrupt
+  source channel crosses set interrupt threshold high/low level.
+
+properties:
+  compatible:
+    const: rohm,bh1745
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+
+        colour-sensor@38 {
+            compatible = "rohm,bh1745";
+            reg = <0x38>;
+            interrupt-parent = <&gpio>;
+            interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
-- 
2.43.0


