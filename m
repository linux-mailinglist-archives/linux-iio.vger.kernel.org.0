Return-Path: <linux-iio+bounces-22079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213DFB132AA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D517A92B0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86CB72636;
	Mon, 28 Jul 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmEXzFgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AC2EAE3;
	Mon, 28 Jul 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753663250; cv=none; b=KdlH4hdVscjm4REpIv93iunAGYmxPOHGsD8vvVqyKx2h+mEr/m2kPi9KMQjl3lmk+4ONMERDHqYCd2bi4UNusijS13L3IPqVqVzDD1o5n9ZBgPVQqJQFz5WPREmAYwEYzN+qMqiQABMD8ggXljp2yerJeMwGT7/f1w3xFy/bVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753663250; c=relaxed/simple;
	bh=o60Dll9O4EAU54DVF4mqz2Sx8yC6bleB2ld1/34rZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn751/xxBHl0Pu4G9JHMnnXVBuFlUDGOczENfXX2eJ0/ueNb5D4OE1bq/Xh9S8ouzMULisKj0O/+J7Qrn+5Hy4jtUQE+SWT1MPMuFTrCkB9SwFuF57t6oE8nYd6qlG1yEHMBTH+83PO9sIgjDnTAAawomoaja1aLApJl5+Yz9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmEXzFgG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so3259106a12.1;
        Sun, 27 Jul 2025 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753663248; x=1754268048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jN1ybFJ4mjJ67hCFHmSsX1qnjm+wYzVsMcdr0kINfg=;
        b=TmEXzFgGD+RsNMyqMjpIoM98M247CJeipISJ/3rIqQXZ+MJErbUQs/i0rb7ErHmu2Q
         uuXrzVzX0gar36fwwysejw8crpJGg4+RGJ4zus5C+L4ZblMzJFC+c8jDJMCCnB5Qyl+w
         Z8BDvwcu2yP2wqwOK6na8pTpaW2Ed7B/kEYppQ5ChOfrDDuC4l4ks1ORHEY86V2Fhj+l
         qLPdy/4sRS76GJa6uhAH0kzNsq+pI/5zqxw0cGTBADABHxyLgfX9wrDxXd5rjT4200cq
         0n5PCJACK7JARo+aR3q/Mqj6KY3j3Uh8PHKcOG+cdM+BAoWV3aWhcSEVvCWuAe6Z9AEi
         p8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753663248; x=1754268048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jN1ybFJ4mjJ67hCFHmSsX1qnjm+wYzVsMcdr0kINfg=;
        b=Awv6PpmNNLgBNhemZB3fnHD4cUfErZYnCYV4H43vaOc1DVxDAovIuBjwCnEa/6y8kK
         6nqPAz9KJqg7G3HdJSmfeUfpDvJNsl+dow2SpjbD1lxyrys3ogN8Gzp7YkTtvxZO98Wi
         XsuaU1YBWodmoOl80sCgFaRU0koj/VrXyTiKSuwIGwk57pD/tFuLKG11FIKe4ZyfyGjj
         Az6BBtxncAsuUXs6yOuWO4ZZroVLbJtFKYsoRWNtMFpCVW7QmbHIpbqQ78hrICzx2l+t
         w80m6dhmt9s+80n0l2bavOl6w7XinKmVzaWHqyY23RlPazoFET+ArdGi4ITcH9BpR0Sc
         4wmA==
X-Forwarded-Encrypted: i=1; AJvYcCUGu+kBOFAPlXFPCfbQyi9vVc3FHuxT75zPY6+Lk3AGmYxZgdzcyin/TdCb+OOMqrEminj/QD77sbfUfsMI@vger.kernel.org, AJvYcCXBZqHkI5woWZyarWc21uQTbdE2gpwpa//Xv40d3qSTu/6ajFEj2uuE8oVPn1ByQnb+k4HuxdyqMX27@vger.kernel.org, AJvYcCXkLschJqUXIbR3H4YlwI6TXUf51zkPDf7yrhtWZIWnQhJzFxFgY5yjTZ3045AzkF5uiiM1ml797HOO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8a3H/fX4e+fpGcL7vhNnl0tMtznFjr7YP9ybcMEpTeDLCXMa
	zcjaQ05Pxc/kn9kAukajeJ60XKT72M4fInE3ZTcKaBMSGdFjklBR6/l/
X-Gm-Gg: ASbGncvp2hW40OR1lYrxPi5IgfkjWvXTJEDvvRpu/T3DgWtbkildDMDZ3Lhm9LwQhDj
	4oVTsr4Gi7WUG/bXlthCd7ZFut0+3THLMpK+kF8RxRCaljQU8fdCBoef7ZSIlkITxoOjOcyEZIS
	wICUMA8HjxVk3km+nuHbiwnkPElj/DTyDV49TuYAeY0W9/xWeCR6A5jU7Ea0OjtawSrC/pAFnhm
	lkIFaFdcNMFfqzTdhDaH3idTE7nzUy/jcGVd2fFxY4BO0DkvZ+S1krUNqJwJXePlvSVZ3A7B1Xk
	5SPQ1/lle86JXPfnhS3LuWT1ir1W10Nq7veR6HMTyk4r0yI8VM5Awm03RCZV4box3zhPB2SgmOH
	0cq06PKH1t1QnqzICRckOm3iFRv0ylAf+usWrg6KlFPZ9jQ==
X-Google-Smtp-Source: AGHT+IFQOo3nYh+Ds3CoNN3ioRG8uZVkPbRyQMR++/clkWEuffto6B6YCIo4wAepXcWGc/hME0pZ3w==
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d455 with SMTP id d9443c01a7336-2401f25d734mr36642185ad.50.1753663248068;
        Sun, 27 Jul 2025 17:40:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4bc4:d34b:cde0:106b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fcd8fb34asm36275515ad.33.2025.07.27.17.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 17:40:47 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	robh@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: pressure: add invensense,icp10100
Date: Sun, 27 Jul 2025 21:32:02 -0300
Message-ID: <20250728004039.8634-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no txt file for it, add yaml for invensense,icp10100
which is already used in the driver. Also, document other compatibles
for ICP-101xx family and add invensense,icp10100 as a fallback.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Just for the record from v2:

On 7/3/25 04:38, Krzysztof Kozlowski wrote:
> On Tue, Jul 01, 2025 at 07:05:43PM -0300, Rodrigo Gobbi wrote:
>> +$id: http://devicetree.org/schemas/iio/pressure/invensense,icp10100.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: InvenSense ICP-101xx Barometric Pressure Sensors
>> +
>> +maintainers:
>> +  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>> +
>> +description: |
>> +  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
> 
> The problem with title and description here is that they do not match
> compatible. oneOf:
> 
> 1. Your statement is correct, but then compatibles are incomplete and
> will encourage people to use incomplete compatibles for e.g. ICP-10111.
> 2. Compatible is correct but your statement is not correct, so then fix
> the statement - drop other devices.
> 
> Assuming 1 is closer to truth, then I suggest to express it with
> documenting these compatibles and using invensense,icp10100 as fallback.
> 
> 
> Best regards,
> Krzysztof
> 
...reviewed the datasheet again and I think we should go with 1. I`ve changed that,
documented the rest of the family and added a fallback for it.
Tks and regards.

Changelog:
v3: add other compatible names and add a fallback for it
v2: https://lore.kernel.org/linux-devicetree/20250701221700.34921-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250626212742.7986-1-rodrigo.gobbi.7@gmail.com/
---
 .../iio/pressure/invensense,icp10100.yaml     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
new file mode 100644
index 000000000000..df875d6d03dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/invensense,icp10100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICP-101xx Barometric Pressure Sensors
+
+maintainers:
+  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
+
+description: |
+  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
+  Those devices uses a simple I2C communication bus, measuring the pressure
+  in a ultra-low noise at the lowest power.
+  Datasheet: https://product.tdk.com/system/files/dam/doc/product/sensor/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - invensense,icp10101
+          - invensense,icp10110
+          - invensense,icp10111
+      - const: invensense,icp10100
+
+  reg:
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@63 {
+            compatible = "invensense,icp10101", "invensense,icp10100";
+            reg = <0x63>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
+...
-- 
2.48.1


