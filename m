Return-Path: <linux-iio+bounces-6865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF868915C42
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05337B21EEE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BA43AA0;
	Tue, 25 Jun 2024 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnRT3mL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B14962F;
	Tue, 25 Jun 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282698; cv=none; b=nf7QGy5aRs4SLkafYo6bC9JzkOS8J4OVAb9qmqOMsWuvSXXWc8v7Cx3+pkgm4GldvH53iFKVu228468Fng1WEVzdaF/Fgh23PZIyi+T3DLayjy+mZLBetELgiX7A6gF3mZnzHL7dR2Ic0ztcQRuiV34wMiu/9DcuGXYyGYPyfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282698; c=relaxed/simple;
	bh=3SSgNwSALkBvixzqHG5CsjjXdzHy5W+AgBG7N1AKQDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahq/mTlpL0t4jVu11nxKjftstAb7EL+4obql3f+t7ji8AT9c1Y0pZAqpr21LlpS2uaC19sSfU+u0It4GOQW90VTnp/wCwXHmX2bR14TqQOTjOSzgsjWudwWV72Eat9S2mYCRj9/mK7X/v5CW8qcizfTSwZhBJdV5CSB8cZqhShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPnRT3mL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706738c209bso1394568b3a.3;
        Mon, 24 Jun 2024 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719282695; x=1719887495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlJpgB2FLjvF4sTktAuQ775cbIIWFfqwZwJKPbL5BuM=;
        b=hPnRT3mL6sPhoxXAc6A17aZ1HtrDQiLBcosTu/KjXZxnvheZcfLJc6hdd0RO1WXE7s
         315y2aBq1DCLEOA4dAXoB/0FtJPW4TvoHOEDVNovZz6xjyT3wpPcb6+VBIiRnvj4bhyu
         DAIsirdg2hMMVW/uthv/xFFOyL2ohKVplTko18ebGn/Zi4h81LwyQftMQL667dIjkwhL
         TtoSXfy8hZn3rsMo4I2KoeOco74gk6Foz1LggZbvdmk+ulrTsvp/UJulOiuI8omU8yMC
         IjX3AMdk475fmpjqiboLpnhvubVwIo6eDGKFTCp7DUF/NT9OqfHCZ3XyC+rnxWXrbcf9
         VK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282695; x=1719887495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlJpgB2FLjvF4sTktAuQ775cbIIWFfqwZwJKPbL5BuM=;
        b=DheGFOjcLWXnXoWIqBsxb7fNTcagKaPuUE03OmMJfwH1sYGjhxlkam4RbxK6n2AXx8
         Mk38AvUKxL01A7tb28am6tYPoh3XYtynRhBoX+U2D591dApGWNgSK74ny5XRyCCRu1PX
         EmZbYZjpjc3gTuHogaYYSt5sYu4Gmy5JI8/MCgGaj8pDUNnFnxlrOJc8ROwCRi0kL4ZR
         5b5zirDZSVMJ3Cmawzg70xsze1ymK0DHI0/l3Tw+IGhM3tvsGL/ILRKMzL31OXc2h0K2
         VJYtalOgJiRczKNXDVCsa74xr6ZfrJghjNbiiq4t3JmPZw70IR/FE+8ezugpG6yWMuSe
         rBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsWwMwSFUha/KWHY34i81e/sCbJXmOf/FnLnXG9EJpyMUAtrXqr+6Ue1U6QVuKFTp+Wcnopp2ejouLryTxPcBWJ5FGA1HUxDfr/dP03+M5sn3Jwy0hOLShRoa6C9VFZ3Vj+ailDB5b
X-Gm-Message-State: AOJu0YysxPVfGEoM9TApBZStXpuoxJNwb0zsYJYRWRwAZCgY6QPO/jqT
	ftO4KQlBzVswiuwEZixY36a0RVGl13ilvxnjDVo/NM9h6NCAxtAUUHkQErvQNeKpxwj+
X-Google-Smtp-Source: AGHT+IEjxlXRsKgcl6P2Ewqv/TpsYOKfE6n9f5wZmTciSRMadRgVas+VBGNku0AZJW1M1+9OX6Jhfg==
X-Received: by 2002:aa7:8817:0:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-706746f0a2emr5559681b3a.23.1719282694861;
        Mon, 24 Jun 2024 19:31:34 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70677949b97sm3582945b3a.140.2024.06.24.19.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:31:34 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 25 Jun 2024 10:15:11 +0800
Subject: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Conor Dooley <conor@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719282672; l=3102;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=3SSgNwSALkBvixzqHG5CsjjXdzHy5W+AgBG7N1AKQDA=;
 b=SLS7Cn3/vmozNHIMqUHnTwWRznJRbFmVcrJiLdExqfbVc0Zx/uKzh2fOOtq20Ykgj7+9gjNJL
 r1UAST39bQtB+vAgrrsA5Y18ZUZkzuSr5f7pPVoI1rfkM4pGxjF5ON+
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

A capacitive proximity sensor

Acked-by: Conor Dooley <conor@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reported-by： "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..6f338308664c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,107 @@
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
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 4
+        description: The channel number.
+
+      single-channel: true
+
+      diff-channels: true
+
+    oneOf:
+      - required:
+          - single-channel
+      - required:
+          - diff-channels
+
+    required:
+      - reg
+
+    additionalProperties: false
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


