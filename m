Return-Path: <linux-iio+bounces-12779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C89DB826
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D670163DBB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB651AA1DD;
	Thu, 28 Nov 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Z8AwcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978541A9B59;
	Thu, 28 Nov 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798716; cv=none; b=rchfLgM69A5PBMoZIfNcqCdbpdTS2l1eAGFn7LDIoedGw9mGnvIVdqkxv4zfJtgQ5BY+hZT3AcAp4LQQqVR1BX/wfA5X0xnEgfJtPY9xrIj1CDAS0T6IciI+FI1eME5JAIUtA1HpL14TSYjyinnSpDAOH0PglCj6wiZLCoCnnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798716; c=relaxed/simple;
	bh=y6ARW7jwOnB9s9Q7vQ2VFZdk1e6GcROGNYG+IZP7w1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBgkIztHqU1p1ikktowEjPVb3fj2lPLc29r/Kx7VA5Q62dgnXzD6uEMHOB+HxV6t5Vhgt7Oil0bcKQVM3hWC6HPJzQHeAQarl4gum4qo2PGeVkg6p0qtETc/GIu3oA4AjlyU9iaq5+PgVI2nfBTELVEWsxjfmxBLNncLdYdM/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2Z8AwcB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so543468f8f.2;
        Thu, 28 Nov 2024 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732798713; x=1733403513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irkHT9QLfhUmX9zXxtTyZkxthUZ9+/+vuANslCRONZM=;
        b=D2Z8AwcBSszgj7ClBa5frB21A6yy+pO8fKS89rdxtcvWL38qCl1/vD8NHriNuLEHq7
         G52ZeShYyIf0yDQ2uLdaffyogo9Ln9K5o5zKxhfWGx9P4itKgOU31THiTZ52658s2ngB
         gbP5FV/nRupnQ7n/YtFMSpmCzJOlFJsgheefw1MS4JW6mNgbRgmQRDQ0TWXC7INrmJim
         c9REBA4bm0ojd6mieBqzrO0hPlkAqhymMA4EPeLQCm1lvmfnD0e8LoxJbBhX88+6qjFb
         be9V6xeZimkZbGzvMN6Xr/2Ai12CpNoA0gEAsLrIsAaxMMcdIpgpzPPTecJo9xzPVWGe
         w/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798713; x=1733403513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irkHT9QLfhUmX9zXxtTyZkxthUZ9+/+vuANslCRONZM=;
        b=VuynAMu8F0O0T3yRcCym6ZiHoeRyewLhc/itq7ejH5EYoC3BQUpmZKMiw7eUjx2CBV
         ikJib28wx8SqfjqlRoMq5r/pfCm5pSe/QigjqTrSueW3htWmu9H5bUMQwSk/T9tMolzP
         nciPSbt4+NUf4rc3cLBpl8QSFGFNdkABee3HN1guH0cxAv238G6TU/enslKHXL3zC0YK
         mXZJS9IACMK6dFM0ElFSqkBlWG+871TCNNzGf9C2eAccszB3k7v1vC4Ciie1PUuNdAJd
         yKsJqBcxJzHVKoJK2gnBQlkqN0lJOkkO5EaNeLDIOMaheaUy9zRFslQhrn4Yx+gE9noZ
         vXgA==
X-Forwarded-Encrypted: i=1; AJvYcCUO64MkVmxs2gx3TwTWN3PnwUI9Q8zoaAuKdunB/PThbStTN3YzMl9GOw2cX//2WlE0e6mXsHPUcAoK@vger.kernel.org, AJvYcCVALzIxB98Tt26Ec+XbOKb9gYVQ73Rmgqr0Snb1HkzHuL4cPKCKkGcW1VmVVYZvcLcUArdykLYLbyTb07kB@vger.kernel.org, AJvYcCXroC+ZatW6GiBV9jk0IamW+hZt/5AkP7HTPa3m4aKeVZmx1qs5jZf/BXrMMCUTpOniRI4dQ6sLwKb3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrQjl1NxqH1nwaup2cEN4CJHnYJXCnrcdu3amP6kGk55XtrrT
	N+Y+XogUGIG/eQOHjmvwqxnb//48mRoP/LTu0MR0/86cqrJuovJmi9mrB1LT
X-Gm-Gg: ASbGncuxRDCX8NU1WTgaaIKaJ4/yh1dHNnoyjb5SxzEBtreq0vFfcUr2TF8MsvFFAzZ
	tib9I8TWvJuw9ROOKEetsP7U2aaEUvWxa5uJldL06uQ2DKp2c6Ksse/rxxDXMAPCXzkhjmJUQyd
	GGIiRrwT0kwXQcfjyjEgRVUt0jCW+ygo3ovCdGHIYUSgpcBzkOExhZA0C+ABon297KlhXpg2cFZ
	VopsFTJ+jljHYN/4FcaRO7xGXSE/WjAXKxkqVZjVSCEdlXqUxDc
X-Google-Smtp-Source: AGHT+IHvoYRXmIawy7MgbZGpQ7dgNR35LsP2fDwjO9gG1TlMIkq0Cn92wmNeStATm3Ygwii7GD6s9A==
X-Received: by 2002:a05:6000:2d12:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-385c6ebae04mr4724248f8f.26.1732798712792;
        Thu, 28 Nov 2024 04:58:32 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:3506:d600:5f69:ea1c:6c79:3753])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68d08sm1611853f8f.70.2024.11.28.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:58:32 -0800 (PST)
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
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 2/3] dt-bindings: iio: adc: ad7192: Add sync gpio
Date: Thu, 28 Nov 2024 14:55:02 +0200
Message-ID: <20241128125811.11913-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128125811.11913-1-alisa.roman@analog.com>
References: <20241128125811.11913-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SYNC pin GPIO specification in the devicetree
bindings. This pin allows synchronization of digital filters and analog
modulators when using multiple devices. Update the examples to
demonstrate the usage of the new property.

Also update the interrupt type in the examples to use the proper
IRQ_TYPE_EDGE_FALLING macro instead of the raw value.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index f70caefdace7..1cd0fd13bc42 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -59,6 +59,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  sync-gpios:
+    description: |
+      Optional GPIO spec for the SYNC pin. The SYNC pin allows synchronization
+      of the digital filters and analog modulators when using multiple AD7192
+      devices. When SYNC is pulled low, it resets the digital filter nodes,
+      filter control logic, calibration control logic, and holds the analog
+      modulator in reset state. Only specify this property if you need to
+      actively control SYNC for multi-device synchronization, otherwise it
+      defaults to HIGH.
+    maxItems: 1
+
   aincom-supply:
     description: |
       AINCOM voltage supply. Analog inputs AINx are referenced to this input
@@ -182,6 +193,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -194,8 +207,9 @@ examples:
             spi-cpha;
             clocks = <&ad7192_mclk>;
             clock-names = "mclk";
-            interrupts = <25 0x2>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio>;
+            sync-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
@@ -208,6 +222,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -223,7 +238,7 @@ examples:
             spi-cpol;
             spi-cpha;
             #clock-cells = <0>;
-            interrupts = <25 0x2>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
-- 
2.43.0


