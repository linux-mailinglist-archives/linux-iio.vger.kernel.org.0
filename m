Return-Path: <linux-iio+bounces-7833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77393AE4F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E796B281258
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB21509A4;
	Wed, 24 Jul 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8HQGI4r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A802C1A5;
	Wed, 24 Jul 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812152; cv=none; b=b6Ji9k97pd/PFPIF4uSxGQxc7IRxiq6yGvlsN804fMgYoAD7FH4L7TMka+1WO+jXZLXcuhUuyew7tVjRlH/ZMqgxeZGKCSFN845UQzu40ICdAHTavvjY1z5rIvPLf4Fl8o88xLEM9+X8+upYN5yh2ZLn0JrdGSZ10Zj2crdfolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812152; c=relaxed/simple;
	bh=1ibcJMw5r1LiPdN6w26WAInNcxnWLbS54ysXD0qG/Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQU2NEUmsgIKDF4ZXo7KbTIRzKOkt50Kc2CBtLRt56yH6yEgPW0UQSWBucoqUJ1Swp9cZCgdC4rIzPNcDMM09+M0ApHGue70zR0OmKM0N5NZ2cGhgyONIe1YwTTdvKCZaOgjiXcuIvc84a2qr79v0u+zF2mxU5A2bsYoTWIHg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8HQGI4r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368313809a4so401987f8f.0;
        Wed, 24 Jul 2024 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721812150; x=1722416950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLEddhztZC5qsHgleGZvWV3x/LXcD+KsVlwJy5ByJ+A=;
        b=X8HQGI4rFYx0+br08/kgMpZt16aMNtSwNrQMLLbrGylt+rduOtcZHiF+Ndg0vDD8af
         ijWI2lskvF/xs8iqWJQR2w5uDs0MbbreplKp0I/WNam5RovClTef/bxdO7fKM5yRsVUU
         1tnLBdk5br1I/Q5amn+0blarrIaWVs90xx/54q/PL0zVxxN3WRfLmP/zwXIt1br2+a9K
         oqA7PGBCypHjf/3mqDqFjm/137rpAVf9Ba4lwsDJJsY48gDs/eI+HIWN4uiHRLSLvsJX
         sjed8BYjE4dOxHZo+69EPwTFtY3yVMg2TRbasEsikx2bZIPR5WqThMzMeMRMr2WgfHrp
         VOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721812150; x=1722416950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLEddhztZC5qsHgleGZvWV3x/LXcD+KsVlwJy5ByJ+A=;
        b=dEQtfGaPaft5dYWvWoZR/zhpRpM0xc9s1mjv7RVySbSdCObdY76ClyDPL/a1BZjsEI
         zS1eRnxBlJXf+VjQyVfqmP/Hq+9XmCNLJTRoSpVQ6jtAv2mIIe2I7OlAhpcFnBjd+nxr
         vHVOoALfGwgTTBgcMN6mb74bV7VvTU3AVfrgUFygA24vGqv/Ypo4fBuaCo/IUzIjvXpL
         DuCM+HNtwh1nyguDo01xfjU3ZpsvGG4VZQrvXnITClZMuQGn8EX3MVF0DSyDQEKnCzxN
         BWXo/1GYd0SQlF8cxVe653ZohrqjgkXchLCX+ftjE148EFjTEzC17MSQXiGl9/9ozu/y
         uTuA==
X-Forwarded-Encrypted: i=1; AJvYcCWVXXIbPouxY8GajvIjuKzN6IE2uvOh0fLUMvGXtKsTtgAxLPEHGqspTBKk9LZkFR9ZG0I2zTujKhItPQATk5U2bBSH/7ksOYn1L92roeJuzolbpktDolIOHDX+oxnFX5OyPM008XL2fQ==
X-Gm-Message-State: AOJu0Yyoc+hOGBylN8aceQe6w5WbaYR4Uji68vjTGrFUEgS+F++605A/
	6ifiUYFX987UTnJToN2JCZMojlrZMEVO8GkV88FguYSFLpJBGQPe
X-Google-Smtp-Source: AGHT+IFmTsR+2rzMSFxemDNBAWtpPmYSng7vdiDngTidEkrwQcVGu+qJqvdRQ7dEI4/EnDE/V+rDpg==
X-Received: by 2002:adf:fe43:0:b0:360:8c88:ab82 with SMTP id ffacd0b85a97d-369f6705c6bmr810530f8f.30.1721812149598;
        Wed, 24 Jul 2024 02:09:09 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684801sm13840155f8f.11.2024.07.24.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:09:09 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Wed, 24 Jul 2024 11:08:31 +0200
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: add binding for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-iio-pac1921-v4-1-723698e903a3@gmail.com>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
In-Reply-To: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

Add binging for Microchip PAC1921 Power/Current monitor

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../bindings/iio/adc/microchip,pac1921.yaml        | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
new file mode 100644
index 000000000000..12e56b1b3d3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1921.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1921 High-Side Power/Current Monitor with Anaog Output
+
+maintainers:
+  - Matteo Martelli <matteomartelli3@gmail.com>
+
+description: |
+  The PAC1921 is a power/current monitoring device with an analog output
+  and I2C/SMBus interface.
+
+  Datasheet can be found here:
+  https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS20005293E.pdf
+
+properties:
+  compatible:
+    const: microchip,pac1921
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value in micro Ohms of the shunt resistor connected between
+      the SENSE+ and SENSE- inputs, across which the current is measured.
+      Value is needed to compute the scaling of the measured current.
+
+  label:
+    description: Unique name to identify which device this is.
+
+  read-integrate-gpios:
+    description:
+      READ/INT input pin to control the current state of the device, either in
+      the INTEGRATE state when driven high, or in the READ state when driven low.
+      When not connected the pin is floating and it can be overridden by the
+      INT_EN register bit after asserting the READ/INT_OVR register bit.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - shunt-resistor-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@4c {
+            compatible = "microchip,pac1921";
+            reg = <0x4c>;
+            vdd-supply = <&vdd>;
+            #io-channel-cells = <1>;
+            label = "vbat";
+            shunt-resistor-micro-ohms = <10000>;
+        };
+    };
+...

-- 
2.45.2


