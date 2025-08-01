Return-Path: <linux-iio+bounces-22178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D038B18940
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 00:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3E1C82504
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567B22CBD9;
	Fri,  1 Aug 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtV3Kq8C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AB13A3ED;
	Fri,  1 Aug 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754088082; cv=none; b=KKgrHDrbUyPBzb9ZAGx3V9ixccP3qeXqTQzjrsx3rwlnYG2ZleJLkKyCUlTQS2nAeCkWaycG27v+N+e4FBrOLTV1suVTeReZthnivG13CfHG9THFNTM4CdWR6jU83n9f1NmOFNepZui/JKLtnQTOUSAntr7sk92Aj3EtBj3gsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754088082; c=relaxed/simple;
	bh=EYYKnIkppgXALe/Gx0Wv1nuWdfG3J2n2mknHamUBDCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OolEczeRMhWdF+Xdi7KGlf7zB+Y/BAfmljbIbl7+HbJh10F/QmU6zOJlfTRDBFO7xCnlVJvou2LyKk/+hX2/btlDk6fU/wEjminO69yAH628j4v9SyJtppb6dFJX13AjGYeW6rT1i3IEzMzNMsFU67YmK3Y7eupNJovYpJH02Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtV3Kq8C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24014cd385bso17883875ad.0;
        Fri, 01 Aug 2025 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754088080; x=1754692880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ou1Bkf4s0rfmcv0My6BEXk5nSyEnFohDDTyh9gYFuk=;
        b=UtV3Kq8C8vA0izba6xSAspNu1nvnA0WUP924v04umwtUKBFjr5JA72CMoeORPXsDrP
         CBST8M0K/5HawG8oxgHlNOBkx+341o20X2BsdONn1oqXuTtFwd6YZdweFe83HZ1o0ivI
         LXs1nVfZkL2z6cgW5knD+nQRpTQz2CdkkFv7/R4ZjeNYnZS8B4JMk08dpfSbpLZi0QPL
         9bn/H1G+kFlIZkMc1jrx3utjPEy5gs+OKumxjx4x5r6oiJbZAijqxsDhTCSkNq82j8IO
         tLfcbb31xYagrWFtP0x0U78RzDYScywQrKNvf/6n3ZZEQQJTi9qdsAvdzJKxTN98ijL/
         SZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754088080; x=1754692880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ou1Bkf4s0rfmcv0My6BEXk5nSyEnFohDDTyh9gYFuk=;
        b=nfNf5C2K+B0N+YwySdFwa/RjMnNbmlxWM4+tJXH8YjLfHykTcoyXKmu0lKTFhqYCLv
         w3lurbMmB1gIL7XCQmKdMOTwdo9/EP43Ksrr97C+uC0YsKsfoT1egAYDq1wRkHv78/7c
         7xrrWYYqOxuLl2ERjjV52q/Zv+5RCEXBdGf1Zp6+/MCtVSCgEK1hwDIRInxGKbrs2Fb8
         qDpksb1gPH17pZBjor52tzPgdLEySrvdmjMiKIb9FmhU/YMbzMVGl88bKmhRYESWgI+d
         IQ8P7oz9M7nKl/fYVHq1nQUSDTQtVJa7WXMbE+3kDM02bY0qojgqks7+iGUojWCzDVJI
         m0ww==
X-Forwarded-Encrypted: i=1; AJvYcCUtBkzx9Zx7OZw03+8smb+Fn1C1E+cE1Dsmy5f/beR15LIzBDsPsIGubM9y0hw4qOvoKWKDs/gePS4ocfUo@vger.kernel.org, AJvYcCVWV/PAZ5/G9X6JcCxgCKe7ObPAbrI93EGNZc+uqvl70WLKdILoJWR2ibVD0DOqXfWghDLc9AFxRKe0@vger.kernel.org, AJvYcCXJUexXtg+F7dwxzpbbfkDHFk1EswsKobAMytzCcBXi2mOF/jqxJvURZ3ONg53IUztoMt+/fevA/ZiA@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwcMF1+5x/7YZUAnZ1xUkHgh62zB4A28AgN2TAlSXaacUafeZ
	9MBZCEQHlfVH7xD18NdAFqt53RbhCeb0VPu65rnk2DYU9Gpy07Wpqv0r
X-Gm-Gg: ASbGncsaHbka7vBMGAX3zXFEwJRv3Z6RHh0JdoFMyTsNv52VG9gk37jOUYUnZBzIptE
	4JB1z5VHvSb/HXFDk80FCPY1Vw1qtyM6TbDPzQkUcLkqJJQGRgO6Hvz25EiQYHKrf5ujZAlZWmy
	wlzdOAk+j33T7HESqIHxD0/BALE4AreSFuRPo1qVaFtVZJ8LbdojYTM/AJYW2O+NIZ4zCPfoB3F
	IJiGt4HeB9JNHPDCRzdQbFZxoUW35bPCiPcKEh48lt1DSWTBpy7lxwDfRtwfLZ8rB6asFayp4Wd
	aokKPN8+mfIiBO6YRBdk1NQsXsIH5289a6lPUvJfrK+1g4a5jWGBJn+LilAwE4s93yVXbDGfn9R
	lLGabBeUA5JCKRO44/760TOsFAQISg4I5F9lE4nob7DrqrSH013ZTHM0k
X-Google-Smtp-Source: AGHT+IHXfj2IOsulIl9Qunemyz2/4DUmKD4gUp/PABDNAJuMStYki+a9G/AZOpBuq19uf1rAcPofGA==
X-Received: by 2002:a17:903:2441:b0:223:619e:71da with SMTP id d9443c01a7336-24247059406mr19782615ad.49.1754088079959;
        Fri, 01 Aug 2025 15:41:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:30ba:c1b2:e5d9:eced])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm52045035ad.99.2025.08.01.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 15:41:19 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: proximity: Add Lidar-lite-v2
Date: Fri,  1 Aug 2025 19:39:15 -0300
Message-ID: <20250801224112.135918-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move existing ABI documentation from trivial to
a dedicated binding file since Lidar is not a trivial
device considering power-enable and mode control pin.

Also, add a fallback compatible for v3, which has the
same pinout and is already supported by the driver.

Fixes: b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property")
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
I was unsure about sending a new v0 patch for this or send a v2. To avoid losing
the lore about this topic, I`m sending a v2. If this is not correct, I can send a
new patch later.

On 7/3/25 18:26, David Lechner wrote:
> On 7/1/25 5:30 PM, Rodrigo Gobbi wrote:
>> The compatible grmn,lidar-lite-v3 is managed by the same
>> driver of pulsedlight,lidar-lite-v2, which is a trivial device.
> 
> As a general rule of thumb, using the driver as justification for
> dt-bindings is never a good reason. The bindings describe the hardware,
> not the driver.
> 
> Assuming I found the correct datasheet [1], I see a power enable pin
> and a mode control pin, so I would say that this isn't a trivial device.
> Therefore this will need it's own new file. We could at least add
> power-gpios and power-supply properties. How to handle the mode pin
> isn't so clear to me though, so might omit that for now.
About the mode control pin and the data being returned within PWM, it`s also
unclear to me how to describe that here. Looking other kind of existing iio
devices, couldn`t find a reference for it so I`ve not described that.

Also, I`m quoting the driver author about this binding due the maintainer ref for it.

Dear @Matt Ranostay, I`ve noticed you were the original driver author.
During the discussion about adding lidar-v3 as trivial [1], we noticed that
this HW is not actually a trivial due other pins like power-enable
and mode control. We are considering moving v2 and v3 (which was not documented)
out of trivial and this is what this patch is trying to do. 
Also, we need a maintainer for the binding file and I`ve quoted you there.
I would appreciate your comments or suggestions over this topic.

Tks and regards to all.

Changelog:
v2: creating an initial binding for lidar v2 and v3 (fallback to v2)
    also, moving v2 out of trivial
v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/#t
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
new file mode 100644
index 000000000000..f49a1c365f3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+
+maintainers:
+  - Matt Ranostay <mranostay@gmail.com>
+
+description: |
+  Support for LIDAR_Lite v2 and v3 laser rangefinders. These devices
+  can use a simple I2C communication bus or can operate in a PWM mode using a
+  mode control pin to trigger acquisitions and return the measured distance.
+  It also have a power enable pin, which can be used to shut off the device.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - grmn,lidar-lite-v3
+          - const: pulsedlight,lidar-lite-v2
+      - const: pulsedlight,lidar-lite-v2
+
+  reg:
+    maxItems: 1
+
+  power-gpios:
+    description: GPIO that can be driven low to shut off power to the device.
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
+        proximity@62 {
+            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
+            reg = <0x62>;
+            vdd-supply = <&vdd_5v0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55..347897b999c9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -313,8 +313,6 @@ properties:
           - onnn,adt7462
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
-          - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.48.1


