Return-Path: <linux-iio+bounces-6660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954A911D15
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AB282BDA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1B16D9C4;
	Fri, 21 Jun 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/Pp5/+w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8216D9AE;
	Fri, 21 Jun 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955788; cv=none; b=mR5uJD9UuztK5s56thmHhB5O+tHXRkiHZ63upK8KhKOX8/zoMMMuxCLaQnQSLsSxqZ5uukCy1K1mYBhWYhZC5sVCgS8KTRLyYokeOx+0/fs9G8XWd6zPwR7LJNkGEMUS8z23M6ctPghxQPaYckv5MwKnBS0cMEZwKF0gNLzoD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955788; c=relaxed/simple;
	bh=nKhTdftGN5LFOvVYP4DJOyThrhpz7BmSMtqRAAThS10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdk4ab5tf7nVUViS96+d97S7cbAYPIUDBx7R6UJdRfMmYkUSzeemhDsvrWjix8FaEE1M3rBDwO//lmnb8Jkg0d9D3WAnWw5qCSkMFIxP1fXiPTXBsndb2wkZL4ixQnFb/GYUMrOumsC6bRXY+8HiJMr1pgNMvHOoR+nzR2Fpms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/Pp5/+w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6b0a40721so12857725ad.2;
        Fri, 21 Jun 2024 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718955785; x=1719560585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0E2x5tV4IsDj9PjftpR/M/xCao4oxa4gP24OGm+qfys=;
        b=T/Pp5/+w/TZqck3Wm4Y/IgOrqYh8MwS9hwpPaVkXQylnX60+jQVkSB1R/QnG2xXVJk
         P+UPQwY+nKBK7xbiB7iN05nOny6ccYh3k+uWRBXEemk/s/lbVyTKpZg59K107VtKVC1T
         0sYJ3yrojQVPVx6IhCR+96ZhOY6YYtvd3xTnMcvArCCNHALK8kjxxr64dE1wO0GV1ZDN
         nLa4Jn4itYB8sA9TPAO4rvI7ExUP/nD91oKwcYWCDy8C8yAP2VV9n6uJXmR9zAt6CgjN
         pfRUcz7ttmzC2dpsaAw1mJ/RB36CeDgpP3H6lGshKU+iN8XNQRMUE3akL5OKuFy2TNSC
         SJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955785; x=1719560585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E2x5tV4IsDj9PjftpR/M/xCao4oxa4gP24OGm+qfys=;
        b=cZMB9iwK3ZsTXJqHbtSeNUVvejKixv5PP2wRd8z/vRmnFy0Xd5aaR9oOYuZLIqjTOs
         jPoBX9yoLfS48kPNkdUeFsL1hyfCBVoWMf1F9xC7cI3jh4UQeMR8pyzAJrKXp83GtWxP
         k20MQP0ucVWPBHTAcOuI+/iPCwuNiuf0uoDEIcILebzMWrR3ozy6dMrjgnwXvTBqtRPN
         Uj2tai4+L3lg83ZdvsQmDqHhr34rV6YJjczVEqCANkNVcKikHzotxQTJLvX756cqDZKf
         vU3bJStqn/5+5QIVIgV8qXG4RjZWwljd7pzA1wdu0V9T0h9QBAWIWRvvrJtT/XvYiSca
         tbOg==
X-Forwarded-Encrypted: i=1; AJvYcCUWYtPzyvm8PhrmjoNIoL3z6fhQZ8lgxygIVOr2vJtuuHI5s+xnLI5QLfGR4jriCbtPNzbyRQyhw88dkkJrhYtAgmp7GL2AdKMZYvAOfFuv3o12CC0ZNFLCpew3tjKXjKTfV9LCxa1j
X-Gm-Message-State: AOJu0YwrzLyPkHd5FTuSho5CNgifEiRq9+8R9FA7BbguDHYXtWiGRQhF
	zPG9g3SHrqMRhB7bXry+TRD/Qy7G+D/U22G8kElT4eSqxxwoEFjsQJ2FoK+qqHuAMw==
X-Google-Smtp-Source: AGHT+IHfcgDbMi3+khX7KmOPaTGCyyqtRZQxRDRcfeLvpGYMJ22/ObjDir4LJFXciGqzBDXxy8fbbA==
X-Received: by 2002:a17:903:2441:b0:1f9:d111:8a19 with SMTP id d9443c01a7336-1f9d1118e4amr42139015ad.64.1718955785495;
        Fri, 21 Jun 2024 00:43:05 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5a87sm7893745ad.203.2024.06.21.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:43:04 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 21 Jun 2024 15:40:50 +0800
Subject: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
In-Reply-To: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718955766; l=3122;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=nKhTdftGN5LFOvVYP4DJOyThrhpz7BmSMtqRAAThS10=;
 b=nnKudIGmUZMOSugRtTYgWQxOwMgV0vPQDVkGkSbQFeBpUAbXAJz3mxSTIW7lhRwc9qsUcmz7C
 1zppsZLy44QCz6Y+EczepAmyJWB7awZNHWAaXJoB4x//wSJthHVCL8d
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

A capacitive proximity sensor

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 +++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..beca70ce7609
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,115 @@
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
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
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
+      input-channel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 4
+        description:
+          Specify the input pin used in single-ended configuration.
+
+      diff-channels: true
+
+    oneOf:
+      - required:
+          - input-channel
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
+  - vdd-supply
+  - reg
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
+          input-channel = <0>;
+        };
+        channel@1 {
+          reg = <1>;
+          input-channel = <1>;
+        };
+        channel@2 {
+          reg = <2>;
+          input-channel = <2>;
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


