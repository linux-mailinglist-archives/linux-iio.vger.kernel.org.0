Return-Path: <linux-iio+bounces-12672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC79D92AE
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 08:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B94BB24552
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD131ABED8;
	Tue, 26 Nov 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERMPOivL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B80194AF3;
	Tue, 26 Nov 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606867; cv=none; b=e6IVK/m26TvwWndgnkk+RuirCM8fwNu62USipc9Fxo9kIjouXhmw1HwdVKg3NyOakBxiLkQTbohbOv2YW4hM8VCcrFp/8cY3+E6rB0qNheg7euJVYkxfDk3ntTR0jEgRNDRERkeThXDyYSNVWYIGoGYxt2U6PY+LSnuZbQPkG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606867; c=relaxed/simple;
	bh=a0S2h+HquNX2P4TfysL0lbpYy2+rPAK24EDAP/jUhvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qp4E6SvCxEBHZagbKms9uLUqK+LhK20jtiiC/gt8+dJxlL/qtF5Hf9KRR3bN7fSIVe5eGZ/sc0qap7TB3DH3Tv4ILydhIqm0yn/uut6/XN8liXJxpv1ZpGPS6VToRJCje0w8fzVJYrGyzIiOMgeTTAzAgTTtiHjjqySC+cM9zEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERMPOivL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21210eaa803so48642815ad.2;
        Mon, 25 Nov 2024 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732606865; x=1733211665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF70OefSGboIJ2k1be6QYu7GqrmQKMS3faKndr9lWr8=;
        b=ERMPOivLBD6yfMgNgvhcRaS5KEkvP3YUQERh/VOIAwuol5GBuNGt2zAXhQ9NOa3aiK
         7H0Qi1sd9Bh2CEjnuhxcYQrLFfQCEEThEs5YMPX+KsVdWEOcLsje7HskOj1cfeO0AscD
         YjNUkRZqejO6O9WZ6mBeEcJkiidjWZDMIsUX7jw/36Y4TiuwwLbiLqV/j5u+VCVO72Ew
         QhRJwCnZy5ySv8/6WEPI9XdW5TxDD4kurSSYSLYy/y86Pg6qz5EyVQdZpK0v6G2ptFWe
         NXu8uu8V20seILhZnrJf31yAAUSzTpGoXhgD6M2n9cfVHhexRVBgqYrgXKFZHqrcpZy7
         CJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606865; x=1733211665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF70OefSGboIJ2k1be6QYu7GqrmQKMS3faKndr9lWr8=;
        b=YkUA1iwo+dK0T5ik/U2scoVSNqVVTCrIwrNy2B17fxCSbD8oBa/b3J0OeEbZA3JIWt
         jqwnRTispuizVi2fN5FLMNp/08he+Xxk9V+AN3fvNW+c37jgtsu+C2u2XZmPc6hRnKcD
         mMoaMOJEPlrTVlIeCX/wtb3NTGlFeWVDs0tFwEFrOSGrUOc0G3YXeKRdqqI98JXIAm/N
         bYGx0r5p0+NW+G+mSmUFBHv8P90FTKHYHiGDoUYKY0ZwmA8yHMf2EDtFOXS9ATMH6W+S
         LymrTBzIyu8as2M/jDFQMSlRxirZRgpflIKQVljZ7YirZNqRNhDtchFHOxgO/Kw3dxqi
         DSOg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZrPJfRoSkizoL/iTcJ/6esV235warODLCOpSQUSjY7LwrYYd911CXXOX3oDVRMMw46A6HU/N2f6z@vger.kernel.org, AJvYcCVCiLVppwlwglsIAX6aPpd9PQC2owW5EJC5FhiKic6CCH1J3HCvvD9yqArifo/MletXEWjUwnn+kqua1PSA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1P1wDzmausI/L+CZj+z3Tv9xBb11oENEZ28+ccIPI0YJfcFBW
	H6ktMcDN01f3CR+FHzKc6AmEbVLXFItZIMdCRDjR0YkSK+dJDHq5
X-Gm-Gg: ASbGncvK6/O59h59Mg9mL4V9+uXtRXZ7XlmgSMi7hskQUGXcurG1dLJrQEn1Q83VuLh
	kfOwJUhzU5h3wInHxXAIDXSae6R/P7uPnnYzPz2bzOSQP8roysLEVLHTYw9a0a0n/73lm5NTXDx
	0ee+fe8BQ9TT46tG1awdXj25AuYNAJAio1dff5Ojt73HxdvvUE4hdilBDP2ccXBN2mU0KkF1M+x
	ZpeKjBym+c9UbXDu0tzauxFvvZL5t9Q3vxRuBQ24lr0oogb16JTFWRFPjaSjfUcw5uLSFNn/ikn
	IYRY1zCCQqmj
X-Google-Smtp-Source: AGHT+IGpIkB5qOrN9co7HMqAsdV206MZ94+G7LbM7LOGQe46lQ8LvDX3oUoZMYrrrFnSoZtJsQc0oA==
X-Received: by 2002:a17:902:f681:b0:212:37e:3fd4 with SMTP id d9443c01a7336-2129f2b7457mr202815825ad.57.1732606865582;
        Mon, 25 Nov 2024 23:41:05 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2ceb3sm76237235ad.283.2024.11.25.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:41:05 -0800 (PST)
From: Ming Yu <a0282524688@gmail.com>
X-Google-Original-From: Ming Yu <tmyu0@nuvoton.com>
To: tmyu0@nuvoton.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cmo@melexis.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: temperature: Add support for NCT7718W
Date: Tue, 26 Nov 2024 15:40:04 +0800
Message-Id: <20241126074005.546447-2-tmyu0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126074005.546447-1-tmyu0@nuvoton.com>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding document for Nuvoton NCT7718W thermal sensor.

Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
---
 .../iio/temperature/nuvoton,nct7718.yaml      | 44 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
new file mode 100644
index 000000000000..a3573e3d454d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/nuvoton,nct7718.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7718W Thermal Sensor IC
+
+maintainers:
+  - Ming Yu <tmyu0@nuvoton.com>
+
+description:
+  https://www.nuvoton.com/resource-files/Nuvoton_NCT7718W_Datasheet_V11.pdf
+
+properties:
+  compatible:
+    const: nuvoton,nct7718
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
+        temp-sensor@4c {
+            compatible = "nuvoton,nct7718";
+            reg = <0x4c>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 67d2159406c2..6d147ce6b060 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16541,6 +16541,12 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUVOTON NCT7718W TEMPERATURE SENSOR DRIVER
+M:	Ming Yu <tmyu0@nuvoton.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
+
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.34.1


