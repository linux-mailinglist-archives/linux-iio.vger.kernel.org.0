Return-Path: <linux-iio+bounces-5807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6378FC51C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E81F24685
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218918F2F1;
	Wed,  5 Jun 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9+lbNik"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78718C33F;
	Wed,  5 Jun 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573965; cv=none; b=jDmvM+0kki2XFlHi6R1UEK031mCIos6wwsLL5jaLxxtUWtSWbcj5rxqaoVcXSHiXUz/6PW5gDhqTPJHw6u1F2JYs8k6b8jqyyuGF+v1RaL1KXl50SiQE+e6wpXjpHmbSwTrA2OpCZHxK+AuauwcDOANnlsmkqqjKa4ij8SX1F6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573965; c=relaxed/simple;
	bh=jPUgkSBxATucwUxWafWmlqxBz0OSUifDCiSpBBgJwH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4AcQQd5HgeINxqLpJdZHVfiX/EPPlxmz/NEvGM04CK3iqXxCYIZk/vcwb8Af42/qbViLjfF3NOREwwCZonD3z3l3OLinxLrESaiqZ4pRJebNs+3BnHZeVFbpU0kc80BYsgjKxew7sbONVO35YgEBuEebw5xhGlcoIKou1u/SCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9+lbNik; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35dcd5377c4so5567362f8f.2;
        Wed, 05 Jun 2024 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573962; x=1718178762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2b7Zi6ItOQugitQ2hTpkJ8GSL/WqmFJBbmRgWJQowA=;
        b=V9+lbNikOyWYVMgeiB6B5hCBJMdQ1ZITH5gZobTrLPAy29DvaL1qZdbOcmxAPSpfTp
         fCaGYFl6uw/Jxjj8MVlATwJYQEMFsm61nI1hEyCmoHZJF8NG26losSx9GYBegJSGO1tO
         HMfnWSNDaRTIwR6FyKgGAfOSYOyAsXVX9vPj4v5DoorW4lk3w1dY8HI9rZwlMwW70HwB
         S1EegPBR157pPnqNOfasQL394JRKvmFdQpV47ebb6J3+0b7aBZCRtYJtbYrIQoxeGgAh
         PeboObmLOHhgj0ccfb95VxLXn48/wISZyOn/SRaKDBcByoqaGBw3m64slzv8AqBpQ9Mz
         P4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573962; x=1718178762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2b7Zi6ItOQugitQ2hTpkJ8GSL/WqmFJBbmRgWJQowA=;
        b=PALPWxi4wiJjdOO60QYWTSpu6+sMrItDzdrFycYBI4xd2L2/isy3ezWA8zgySfkBE4
         nKhoCLWLPmaM3GYoPdY3Q33ZdM9lMVswl4kVRvultYxeT4qx58Wp1t42awfilzDTTqAp
         yMPC+Q31CJfNrh6vaM/yojPcHrJe3dS0pjMv8WQ3tD2NMrZHdq9MgGr9Yj446SHhHYgB
         RcZN7qjfonu5ZT5ktoewMLz3GG93xXEkQmkmaEs4w9R5iRyclotsiWFkr7sVBncDaSkU
         R3ZTp3bqKxYDtdISbQ7AiA0cXjIH/+p7uLyEwjB4Wtt4rMTyDLQfhgCAgGn6IPHF2QiV
         WU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCVc+b57XlijXxcfixGTs4Asi0PsgiCYcP+NIoQnjNngrnTbO1pE+o9lNMaby9YHi/w5ZmlJnVFmjfxIeLe0An3bvPiCDRTmSStgB618E9NlWcbcobXXQT6dYt31YECe7grzeiAHfmH/RtYd9h443aSo1HJRLE9WAyRCjfjSUa71QvWQ==
X-Gm-Message-State: AOJu0YwHRjo6hZ1/0XKTvJdOPl7R/Qo0vO6cRUehkWHLbnbVwdaTbBY2
	1ssjfAiPQLCWe3h2xlei88Px0HL5iLMGQJodO0LCRdvvobebofQX
X-Google-Smtp-Source: AGHT+IFeYAv5XHs9dIgE01OIwEguLUrOD8obikIjrUdHmUJBbLI8DE8obLxtF9Z3txTba8cY4EvV1g==
X-Received: by 2002:adf:f803:0:b0:351:c7c7:985f with SMTP id ffacd0b85a97d-35e8ef7e9eemr1402234f8f.53.1717573962115;
        Wed, 05 Jun 2024 00:52:42 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a10a:2300:8e59:f160:bdc8:6311])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm13760638f8f.23.2024.06.05.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:52:41 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: ad7192: Fix clock config
Date: Wed,  5 Jun 2024 10:51:53 +0300
Message-Id: <20240605075154.625123-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605075154.625123-1-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock, which can
be made available on the MCLK2 pin.

The presence of an external clock is optional, not required.

Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..c5a4219a9388 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,16 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: |
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used which can be made available
+      on MCLK2.
 
   clock-names:
-    items:
-      - const: mclk
+    enum:
+      - xtal
+      - clk
 
   interrupts:
     maxItems: 1
@@ -135,8 +140,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
@@ -172,8 +175,8 @@ examples:
             spi-max-frequency = <1000000>;
             spi-cpol;
             spi-cpha;
-            clocks = <&ad7192_mclk>;
-            clock-names = "mclk";
+            clocks = <&ad7192_clk>;
+            clock-names = "clk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
@@ -202,8 +205,6 @@ examples:
             spi-max-frequency = <1000000>;
             spi-cpol;
             spi-cpha;
-            clocks = <&ad7192_mclk>;
-            clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
-- 
2.34.1


