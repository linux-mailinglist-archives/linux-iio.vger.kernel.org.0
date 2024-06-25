Return-Path: <linux-iio+bounces-6910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA8916DA7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D91F25876
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808317082D;
	Tue, 25 Jun 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnyi+/LP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714101E880;
	Tue, 25 Jun 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331365; cv=none; b=odRz8WipGef2RRKbqakZ/BgCpvSrgDpU2vh51OSmLHRMqdlHugO+iY27ZxfXzS81PgwtxMhAlI+/fB6KphqB37wo13KYm2x3OM0IcaSEXi/yssiv0lTFK651LiUf1ERHpA8D/lb3t7IGKtOiZN8PMKSycoXAPndV8oaE9MTmVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331365; c=relaxed/simple;
	bh=dXw50ZgDxABN/pvcEpbljnSOHQweSrGBLCmoJrmEXlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYGTwjKLkicDNY+eRl40qiDkxGAyJAcTCiMSZR2U2fIP5PmBmGmOQO/NtHPUx7R5AXvReW3PUIkWV29TYGS8zxcNBeU8VyRMTw7h/zRD2JA1NFbBBWjun/fXekgBgN5EetPjlsPjyr71h1kTyYMDR0cPKc8nw0CAsdgGclWsuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnyi+/LP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-707040e3018so3894220a12.1;
        Tue, 25 Jun 2024 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719331364; x=1719936164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NreSPjDJ+OK4rayPLGtCT+qKKKeTwsUT8po4TKrifdU=;
        b=nnyi+/LPQneGA50fZEvRgcmsoVbcbIJIoR9pKCDkwlOrbOWoPjSLD7LzFLG5bxeTSG
         2suXXv9shUoZQbdCOptM+wlB71sNmi9elQ44uOKz40nPz1gyYGYvIxTQ6dJik0B4pWeH
         FuR8sNx5frSmtcMyyl2AKvBoc/qniZdyN294VjAX7+hKCrFNy5sXHDVpo4zxLVXwko6b
         oyHSBZwQOhMFIewsb2RY/AWvsXNPSFf3wEddKAV9u9zSydbNM1j8g2LtmHxobaJB3gNG
         N5BtMgqaOD/8Q1ZSPO0Bc5yCQYPvuGXcMocff2fNvm4rkihq41HqUcIR6aQWaWt9xsPS
         OGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331364; x=1719936164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NreSPjDJ+OK4rayPLGtCT+qKKKeTwsUT8po4TKrifdU=;
        b=PJGpyjASn1kQJ72pLpFEYXVqxgegM9MtGr1mAbHa/oYKnJwfjfYf1wtruvP/m7sXiE
         abrTaab4WibTqHixblFfVGTEVadSVf4r0ZixVYb9jWDzQkNESC9Cd4VLwfimvkWYUFak
         kew1LqOi9Frlwq+Koi7AxtoPVjLZ4njvu0nugC/7QFabOeIrF62TM10qr/wtgjdmMOSl
         bhV/vCP+kv74Bi1a0PW0yom8tDf00zCtoJxFQnYNOzRihC3PJjsrckCGCQF9g6y8Tt70
         o9RXXhDO7z81AFkSY4KKvhiv85PmHta+6QdlUzMIacKa7iB6CxLgDQG13QGtd0tJIUyT
         KVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjlADC0CICnzcw18N1vf0SMG1RYBYecHkLqpR/z2AvEth3xMe02D+r2HAfCh7mz+LTmIYFO778jM5cYSrdTF2tuFk852mLPfJabsLsicPtonIEutpO/OwlLcUe1vvGS7WPFIZlpOLD
X-Gm-Message-State: AOJu0YwFeHvQHBPs/9447eyyWDiwY4nU85jtGAgzAxmrQcZs1fHATxN6
	prBIPggEP7mY+MWP1a6GHxnO9tH0DI3/lcGfsMYZ9KD8S9r5Jmgvu4gf580781wSVpIjsSU=
X-Google-Smtp-Source: AGHT+IFLSSdELSscD7k6UDZPE26Xw3jTiMadzQauhvFLwZFmrtAf0UiS68A2uDTVOGhEui3pRRbKqQ==
X-Received: by 2002:a17:90b:3eca:b0:2c8:660d:cc2 with SMTP id 98e67ed59e1d1-2c8660d0f29mr6731320a91.4.1719331362485;
        Tue, 25 Jun 2024 09:02:42 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9de9sm10904009a91.37.2024.06.25.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:02:41 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 25 Jun 2024 23:58:53 +0800
Subject: [PATCH v8 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v8-2-0c224e3bddbc@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719331342; l=2681;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=dXw50ZgDxABN/pvcEpbljnSOHQweSrGBLCmoJrmEXlY=;
 b=gvUL6jlHiXFRCR2BOWP4vZcVF4FmGdCJHKb0oLEXQaKCM/Xwa9NCO4f4Jk5QnXW7yXiXPeLMo
 qM5q9o/iTZpDa+GmCbmX9W9F7djUWjNcPYVnIFG/OnhC9FhTlq3YFx2
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

A capacitive proximity sensor

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


