Return-Path: <linux-iio+bounces-13096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9B9E445F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C38DBA1FE4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF91F5432;
	Wed,  4 Dec 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Isj71JC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0461C3C01;
	Wed,  4 Dec 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336714; cv=none; b=eWmlZ0gTrLigaTRo6GBtPPJuyWRJieOqbd4Ak+z66LddyDByu7AhuIvQDU1Cb5MPjHEG36urrPY84XaH9nEnAzFCHmklnpUTK596JsFQX/I/gFcWhxc1GFXu7E/lLdtUYZNHpfwzMVisMbGp+eQzS49gmmP4kcbo47bBaiXgcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336714; c=relaxed/simple;
	bh=zbFy/cRHMsKtsS6MBJ522L4RfoZH1lwPSDpEDSOUF3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7a3mF5l65x7L8ZMTMFsLzNWTK6MtQAWG9VF9aeRWGdbUa0ngd/FhQu/v2EJ0Qk/1GmL1SWBNsPP/eitfV5trC4reL5e8tQEfX2p1y47DyIdvO47Hj9IFM3FTThgfYec0KPscoijFKD7VIKr/yorOGDQBlVyuNj74i/EWNWUo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Isj71JC3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1095fe4so98075e9.1;
        Wed, 04 Dec 2024 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336711; x=1733941511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAvJZxpxE2h2mD5CczkRDaQ3jMJAQT+3HBKnhDyYiwU=;
        b=Isj71JC35SM+1dlw/2YVAAbEeKiAj/dQHHeARTpPQp/a+no6Pd235XyfD1w8/e0I0b
         8oOmagd+k/0ik1muSvary2t0ezYdjkEZHQURo1e7/Tg772aIjuPiGwkZwiQPs3gFzE7z
         69jLuVTQcd0XhExNd83JLWYRKiyKKiwFYzljYhs1t6HwWqMEbSK+AEr5LcU+EmULN+pK
         5aHpE29YzZElSvAQ1Fv/Uwuqv1pdQEMfXHkWD6dC8D9sCGnckYzpfg/R71sEg/0ZQT98
         eImMTdwYXTsUd5RIfIBq05Xh4PIB68cIG4QGYoBOAAQvFoog2IqWPqwAltu7TJAYJDHR
         eF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336711; x=1733941511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAvJZxpxE2h2mD5CczkRDaQ3jMJAQT+3HBKnhDyYiwU=;
        b=GoIPGPou9Cffse9xYm+7RZ/xrOFhPnG9PEKx5DMGyuW6SopPjhhxjIB6IWApAViAiS
         VUTf+Fj3o8dhlxTWeAcx4GsKMbQ0nQzX0e7UkXUSN4bW5jU68E09I3+g4V8txUUYN5IA
         rL2nuDZAYpSUPVtxEbE1Df5g6HeSh1fWX5oDrmKvViGShXI1Se7CjPhmrVb5lquFouhP
         djSuUxGJFMLnOH0sYycxHMlozvn5nDUJtkHGUw/6IisU2tENSDY+2wED1zg2htKDAS40
         gjW31LKFj1IDh5bJc1UT1CYdv/TBE3vVSs/vKG4/ExWKmJuknHum+PnQASj/43g/UFhv
         qhNg==
X-Forwarded-Encrypted: i=1; AJvYcCUyWXpRfdMJ6EnWyL4NeC/o/kCn+/as34Q6DY0NYao5U0/D3lS3SYZ+htzxlXyLULPFm4qrzWlM3NA=@vger.kernel.org, AJvYcCVaiCturdPnXF9XLJItXXMeBZW1D0KjaMao9XMDRcnea5dNHFnLpnyO6UmuEEV0r2Q5cgMYA7LM1fZETZwp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01Cy+xHptXGfRvnxgNluTMDUahSiMT+vGNLTY/U71eHZRZxfz
	Y/lK7LeMWN2S94RT8UD+VL7F7HGx1dAjMK0KqjkAI+VYML6T564oVDTYgg==
X-Gm-Gg: ASbGncsJ1mCJw8Gd1enJA2G1rH6JVWHsKyc6nyYNF0/mUbEm6b8PrWfHR2DMxEoVzbl
	ozzmyVf+JAf0gDKjCNp0OtkJHHBNBNEDSmI7tX81gxwnnsVpS9MOziw7XIMemRaTEYQouhMX03a
	CKBi3QyXGCC0cRUGq/FqPOH48FLMlGFen0AE94W78z5gQdAZn8UfdXhl5XqisI/PJbChi7p91dX
	7kbhWudcfICGn519sJSxvWG3E6xvVcA6fAHPUjNFNvCL18dXIRo489P9krrsFDw6mQb16K1hEQp
	klbl54kAmgweGqx0tmhoEfVuO+2S
X-Google-Smtp-Source: AGHT+IGintvniezClYarfwLLOi6+0Ps55YJtVGp+lecYNoe85bxNVbzZxGxD3L/eo5m8iOivrMpMug==
X-Received: by 2002:a05:600c:1c02:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-434d0a38d88mr26622525e9.9.1733336710693;
        Wed, 04 Dec 2024 10:25:10 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:10 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 06/10] dt-bindings: iio: accel: add interrupt-names
Date: Wed,  4 Dec 2024 18:24:47 +0000
Message-Id: <20241204182451.144381-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt-names INT1 and INT2 for the two interrupt lines of the
sensor. Only one line will be connected for incoming events. The driver
needs to be configured accordingly. If no interrupt line is set up, the
sensor will still measure, but no events are possible.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479ef5..a4c2cefe1a4 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,15 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    description: Use either INT1 or INT2 for events, or ignore events.
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
 required:
   - compatible
   - reg
@@ -61,6 +70,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -79,5 +89,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.2


