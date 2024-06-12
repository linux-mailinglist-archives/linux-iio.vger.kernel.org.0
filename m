Return-Path: <linux-iio+bounces-6208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC09054E5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FD71F21E48
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F717E46E;
	Wed, 12 Jun 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo+/6qxV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9D537F8;
	Wed, 12 Jun 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201838; cv=none; b=uCo1XqJUD1UWmcrZslwecctzsKQyeZPWaCcOLLKSTSwEXCibOzdjRC14DR2k2PcKWB6BwfCcAMBb69xjkWOuDGjirX5wcEVs3qkOn7LT4Jz2HYoOMWe8iAcxiaDoChdlg90Cpo02BHAuncHm1/8PK3G8q1Wt1nVpy5/Mb69fWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201838; c=relaxed/simple;
	bh=roWzss0vJGjW6W+tGthUvuXeLsz8axOFf5uPVRA86wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYqH3EYPFXZOkupZ3+j9x1nRANg+3vC0V334H2hVHRCKUhmrqY56cZtKq61yuhmsqu+HqA1AM3f1jU8qeHXmzOwfpGnR0EDQ/ollWaIy0o05h3woZYKbdaza7kdYvwWP0Yjg5eLHSs+IItmqkRmzC+PaY7FZWDzJ7My1U5gUGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo+/6qxV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c8973ff29so2535900e87.0;
        Wed, 12 Jun 2024 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201835; x=1718806635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGXyp+8grZX5kqeubbRu/5Vc2BZPvTPFKx6FshTXStI=;
        b=Xo+/6qxVpInrT0U4+bNjYBeZFo7nRKdCQYTdgwdF3vIXVGN8tt6Vtl8TvtvvvcClbs
         wJj4C0EKlSFWYfu3GdNIvBV/XGiKFl5eWk4Nz8A7MCDVrEsyw9EOS+GHqsqc67DPWsn0
         a27THw5W7EDVVA15Z9ICn8jKYKPp5ln3NN/3olY8hxfyqLSNrmOtdXxZe3xtxgywEoJ0
         gYFs9z+VrQn1/WXQX9eNJiznuhg+vOWlAcJ08WXlRJeHxDeWsBS1siqlqmcVFZ9XbJNy
         2aFTOJyYrEgPxDZjML2DbWQoSENuwGvbuU11Sryjbsr5uYCDyULR5mpB8sqHtVRM4Mfp
         /5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201835; x=1718806635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGXyp+8grZX5kqeubbRu/5Vc2BZPvTPFKx6FshTXStI=;
        b=UMAauYnjK4S7KVF3w1QeCwgLmodojb1eHjB7N2jgmFx6jb2nkt0QYSrGPOKWQtkpw+
         pjl0YxcSkllGC2OYa6EXAy9ppcjt0bWGjanMLw2b+mn+Md2D7R2pZisvifqPuKfn6wTo
         U0isJxogzu/4/TuxQeEes3nFxVxFo0jsF8EVJt4vY5edvyvgLNwK3ZjM+hMO/ju1NJT+
         HoGi51Ge9WSRc2PeUXWsm4oxNaMQePRIvdkM+v9HBWOQH8K1HqM5FwGvcAuJf155btbc
         emhirFpJvkjqHg66nMoEPGkHGo8flj44BuxvoUR77YZN2Q9p/925WGm318E650W27LHO
         Cz5w==
X-Forwarded-Encrypted: i=1; AJvYcCWGH9zBTSK8Xdl9KC4Z+70N5+pJbh5Vypc8ZWKczVfzePqwZB3rbYg7F8utO4D4R3NdGFJRu8ZnZuWa6I5/NlD+du8YZB7aGuExrTA6lLow0zVzNs6pih2oMGBwG0CEJQ+zwqn9iEvIQwSDZC0Hh/4IRNtFwQhhwf8czbLUs3zoCqZ0yg==
X-Gm-Message-State: AOJu0YzIRZQ8geHHd+FQ+2DpWfhLA5R59s9h6njM7Q+DHBc2WyjmXPsU
	XPjsB6ZtXrzBvXPSd38GQLYeu+Sahv40o//KhkvVrqBXN0IPO2d2
X-Google-Smtp-Source: AGHT+IGMy5XVJyf5me5arp13EdP0RyPj4mlacXegAwc359jEoKwQrgSqFh4Ejnw66JmeZ+CGv2gfJQ==
X-Received: by 2002:ac2:5196:0:b0:52c:851a:a0f6 with SMTP id 2adb3069b0e04-52c9a3c74e5mr1134498e87.18.1718201834569;
        Wed, 12 Jun 2024 07:17:14 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm27876655e9.9.2024.06.12.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:17:14 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ad7192: Fix clock config
Date: Wed, 12 Jun 2024 17:16:36 +0300
Message-Id: <20240612141637.175709-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612141637.175709-1-alisa.roman@analog.com>
References: <20240612141637.175709-1-alisa.roman@analog.com>
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
pin. The other 2 modes make use of the 4.92MHz internal clock.

The presence of an external clock is optional, not required. When
absent, internal clock of the device is used.

Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..3ae2f860d24c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,15 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: |
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
 
   clock-names:
-    items:
-      - const: mclk
+    enum:
+      - xtal
+      - mclk
 
   interrupts:
     maxItems: 1
@@ -135,8 +139,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
@@ -202,8 +204,6 @@ examples:
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


