Return-Path: <linux-iio+bounces-6930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3091740E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2EB1C20E87
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0A149E14;
	Tue, 25 Jun 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROdjBxp5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9E8F48;
	Tue, 25 Jun 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353026; cv=none; b=qaDJwl0vO77N5wgjFlmVe2rbQp57F0FZ4XCf4ve77yscOO4Z4IoajUysFChGHlPxJIctuLK9+9zS3iEOfQvr7I6EcTuZ3mBRQRY8Do5OXbBnVwsACB486Kf1lKON1dxmecHX/4H26x8FuQJ1Sb+0ghtQX9W08DZt6dLTNBY3p20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353026; c=relaxed/simple;
	bh=QkOxhTrH0i1RsTB3PxVtQSLNoC6QZXmPEeY35XpGx8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ+jeHjoJ+hDXLZB225y9kDgpiMkS+JNqle0JshmTDthIwKm6HwkLvnpl1LlwTJEuPoPrljxPuQTjZGM93nunW4HTagiF3+VCT1m4vaq4UFm7c9a7EYJpS5Nic3ByvQ3Lt5knq1uS9wopFWBfeTpblwu31WK+gfxNWCdnnuadV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROdjBxp5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd717ec07so5193134e87.0;
        Tue, 25 Jun 2024 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719353023; x=1719957823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=so4pkPseZc+1L10dmvmn3CAtUkLyXo31V8uQ7StjmkA=;
        b=ROdjBxp5sqJs2qQ8KQnKOa86MDId/V3at0yNykXDD01uDXnmmJTrYjuSSH1soCyRzR
         fBM8INMyKqAtNrpD2PRxCxK5hKA2PI7KELGs4HaKum8793yCAfO6Bfx92wVl5r5zskQB
         TbC0pohEp9d4narEIqN/0tT0SgnF29sxSuIgw8gh4lhm4P4SYuMGOevduP+tfKZ4tNXM
         i1rATnBNCFgbem0g396Ubvxgg04nNneJqgcb/h0tk80OS7RfXCWZCA+4YvEfQ7tDGJHN
         vIIslBBultXkQeWQnFRgkLsjfbOZ0FF2rZQ0Ar0vJ7rm1YTQiPL0iH4FAumPBwrw8o9v
         juQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719353023; x=1719957823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=so4pkPseZc+1L10dmvmn3CAtUkLyXo31V8uQ7StjmkA=;
        b=n8O1b4ejcK6qHSC2lFLogMVmB8qlLLZht2jGoCM+2cIOitsoe+sWCBWF7jCCO2TZ8J
         GNxdYmblwPgGCc4Dmr6b8qlce7tQteXXucsE/sgPynvVddRT4OJchBEb9ftE1drXrYJJ
         ewbzLUW2UPrd4mq0zUeSEsme1vpUuyXvACAs4yT7fTyUvj1yT3Q6PH6ACxrXOj+uoIxk
         J8HNcVxMneumepHAbNUMHy1rftfyKMTrMducuiNjF5A6X9LvlZaE3qWt6GRGbOrDRhvd
         fWwSpojHiTLPJm8c0Rk5XB3lMEarYR5aMNsuvpaf7vRpvxW4Ss72Lq8tgOI2iX1VQ2eT
         6ZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlZHm+CZRmT5xZejgl9DjsB0jQge8sZCcsajtGptxPAcNvYI7YS/CR45FbqJowc+ijcMG7uMMmaxFlh3ek3ELLx79xEyMlvZviuR8RbCrdG4dy9lebDTRSGL2ZkZt/2Dou6NiOFUTulAdadBZi3mzcTK1xLDDJX8TL5NgmhMXAfH9VfQ==
X-Gm-Message-State: AOJu0YwgxLacnIz2bkyiS4cy4/BLw8JtzX9bvVF/Ksd+2PvMKkBj1SxW
	Amtn9g0vP2NcRFYF6ixF33S9vzGkdAOXpG3y9t8gHiD6Oq7espeYYc6mSDj0ze0=
X-Google-Smtp-Source: AGHT+IGA41boEzk5lnOvJt1ESJdPvG2Qfe4DARVFgcuCZcvkAg74Weiy4tvuMgFP6cxTu8/dWt1uZQ==
X-Received: by 2002:ac2:4244:0:b0:52b:81de:1125 with SMTP id 2adb3069b0e04-52ce186142dmr5480005e87.61.1719353022577;
        Tue, 25 Jun 2024 15:03:42 -0700 (PDT)
Received: from localhost.localdomain ([2a10:d582:37c5:0:a86b:b44f:15fa:ccf9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638e90ccbsm14031999f8f.59.2024.06.25.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 15:03:41 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: iio: light: ROHM BH1745
Date: Tue, 25 Jun 2024 23:03:25 +0100
Message-ID: <20240625220328.558809-1-muditsharma.info@gmail.com>
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
v5->v6:
- No change
v4->v5:
- Add power supply info
v3->v4:
- No changes
v2->v3:
- Move 'additionalProperties' after 'required' block
- Remove block style indicator '|' from description
v1->v2:
- Fix yaml issue: Make `maintainers` a list

 .../bindings/iio/light/rohm,bh1745.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..44896795c67e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,53 @@
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
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
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
+            vdd-supply = <&vdd>;
+        };
+    };
+
+...
-- 
2.43.0


