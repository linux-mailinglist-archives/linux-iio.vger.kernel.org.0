Return-Path: <linux-iio+bounces-7251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BCA9261EE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D91C21D8A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E217B423;
	Wed,  3 Jul 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ8luxTL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866C17A59B;
	Wed,  3 Jul 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013749; cv=none; b=TVb4filTKBLyV73ewmuQLwQydJxSmg6aPqLe/7D1GHlRsoRzMsoGbRQePFaLTDUC1n1IlWVl3V0OYoj1+IRIIdT6vT/OSyAwfIDeFE8ZnH3MhZaNrm6v4SXkVczdcvCTKS2xvkm/JVZI8IF3/4Xo4VV20bQi1r4mzZ9qBbcZ1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013749; c=relaxed/simple;
	bh=8LEcgGgFlMZVXZi64aKuS209KW5liqB3GgP0Pc4iaoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orGdm9PvpXnqVpWpE5dULdKKnCO7xIsbqHbY+HNAzJrAZ1WZtrtcyUKiBZ8BMOyzN/0WHr7NBtA4THSAtLV5DX29UuT02LTzfP1WggLmeYuf3emaqWuFGEcZZ+VvJhM452aF0tlBYhn2/xPANsIhKcqxQI1C2bEfcHgz6SZZNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ8luxTL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42562fde108so38672885e9.0;
        Wed, 03 Jul 2024 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720013746; x=1720618546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL5Vau0sZINA4xysArRTiaKWm66o/hXdj9QvS01zIcA=;
        b=RZ8luxTLgnCmH7ihmLRT7Qb08zMLoSw0Q3MisBHT+XufWfKCAcPqUu/nzG/lBteVN1
         FhCyEln4GjAXZ9zBQvJ5ouCXn8DsMrpPFTpFGx7QQF8wybsoMJihbpcTfpDfXsFiWksN
         xp8lomcJm+hKr1nMEQ/fJz4oxrDstexlKCMRAe89MMSOvtobGWEWTwV8d8G+LhjguNL3
         +rZkD5Imx6DyGg/Bm2eYA37D3yo0kRhMmxRRpu8896XXXd+oGIsmugWWFWXp3XXEYBxu
         4WJoPf87bpJkxN+K6A3Zlo/Zo82V/Ad7/gLrrEZluevjoww2b+PG0xBVKbU74wcmU9t8
         oFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013746; x=1720618546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL5Vau0sZINA4xysArRTiaKWm66o/hXdj9QvS01zIcA=;
        b=Mapw5XqF2tX26vnRM3zJJlUj1NeV+TzgmUhP1CZW/VSq5Ny2wx8702+O5A/+Z5mNyF
         3P9o1AZ8883zex3N6R222nE5sWzB6aip/QeoRlT81juFnxBtch0ndglQGZv9eYEpzZGD
         CeOSe7i5v4Lams5a5oAHj4OAPlyCB/VCnArZAW9nPHZEa+zYDEKsd0gKV+rdOaQRvBG2
         dpKIJudD0FH4/L1Moy6I0wSBQ9UvTYlPTxIBdLmWto4yrOYCNqcIzJKvDRGGaQyHrCMY
         QAtpKFkG71A7tuTGtHs9ffIRH618YmgBd4F2AsQfGRanq28zi5QbmpTogNEqiif9YXp8
         KQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl74yIS/z6Me5cV6emukhG38aFW/z5GBmg7u2gtnEA/3O2nRcOWjypMiTPUQ7V2h/wrJQnRHiQUhnQZqzjq9L70Z6vDAbVc4D1iGoeMqTQR+HXki52IKrUC7eVjrKMd12q/ecYpClsEw==
X-Gm-Message-State: AOJu0YwywjNZIX40rs/ym5JHQCyuRvDrN8ngFqeoqbrChUBhZ7B2Zt6M
	Nsluz+fCo2dyEiP0CdE97kYZl7lShguP9zQDq7VkPkxn9P3wIGpG/Cz5kbs0
X-Google-Smtp-Source: AGHT+IEVPJe0z0vhIhUAR6RpoPGD48OVvbHMzjp/htyjYMvl7pbxoqZg79hMLxT1Maf4AqZoOyoD7A==
X-Received: by 2002:adf:f606:0:b0:367:8a20:b1be with SMTP id ffacd0b85a97d-3678a20b2cdmr2644392f8f.35.1720013746136;
        Wed, 03 Jul 2024 06:35:46 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb92fsm16046586f8f.88.2024.07.03.06.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:35:45 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Wed, 03 Jul 2024 15:34:35 +0200
Subject: [PATCH 1/2] dt-bindings: iio: adc: add binding for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
In-Reply-To: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.13.0

Add binging for Microchip PAC1921 Power/Current monitor

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../bindings/iio/adc/microchip,pac1921.yaml        | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
new file mode 100644
index 000000000000..ec08228dcc16
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
@@ -0,0 +1,79 @@
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
+  microchip,dv-gain:
+    description:
+      Digital multiplier to control the effective bus voltage gain. The gain
+      value of 1 is the setting for the full-scale range and it can be increased
+      when the system is designed for a lower VBUS range.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+    default: 1
+
+  microchip,di-gain:
+    description:
+      Digital multiplier to control the effective current gain. The gain
+      value of 1 is the setting for the full-scale range and it can be
+      increased when the system is designed for a lower VSENSE range.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    default: 1
+
+required:
+  - compatible
+  - reg
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
+            #io-channel-cells = <1>;
+            label = "vbat";
+            reg = <0x4c>;
+            shunt-resistor-micro-ohms = <10000>;
+            microchip,dv-gain = <4>;
+            microchip,di-gain = <32>;
+        };
+    };
+...

-- 
2.45.1


