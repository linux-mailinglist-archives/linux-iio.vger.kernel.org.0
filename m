Return-Path: <linux-iio+bounces-12960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624649E0AD9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21690281EF4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20361DE2D4;
	Mon,  2 Dec 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCh7aRUF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EC1DDC18;
	Mon,  2 Dec 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163563; cv=none; b=OZQFf6V5JVjGRHMOvxxKwb1ve8iGzexUzptvOkjwJOQB5U3v/87ksLWiAI3N9Dvl2spMEBPv8XnWxld2JlxflXcH3X+I6EO9bamKnYHJHjs/aJgdozaEcc0SEauikW5u2yYd/kaW5LPaqny25lSg9AXJRKtOStpZZ/TMUs9HGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163563; c=relaxed/simple;
	bh=g3q9F3nz/BBwL+jGiWySN8SZMNanNAqRFUUhFg0bvO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FItU/4X0z233qhzxsEcLzRfjnhEbnI0eowEqGEee6sqVtLQ1VnBUWO6nu4v4gwIjGtckQU6O2zrH3h6hKXpeuYefw29A2ecnyjV7DGcoa7/vZEF+eN+cr++Y6k4ejFqBfEHnK8gGu5dFyfvrZr9/K5vQI9smmVrmcjIX6zbLxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCh7aRUF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1660779f8f.0;
        Mon, 02 Dec 2024 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733163559; x=1733768359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9xI3zMiroK1TWhD5qFX+TQwJDBCg2p4NOnhJcoAr3E=;
        b=TCh7aRUFTiBNdWUwuwIY8oyII73JCvWrvP1+8vcUBzGCLVXPR7JK9s4N3Q6fY83n6q
         Iv/VgllM4o679iscpzbpjSCobdh8lDN1pgqC3z2W7RCCb/kL2KX4Xs7QAdDjv/zkq3hh
         7osSv8Ha2YcAITgrCfJwrGc5QXEM9N6QCQfRrYHVxKJENJgH7Lo92RgHZf5lBre6Q4c3
         jXAfTW7rZTUgbzHdbaEMxKEvNULgRB8oj2BbO91U0W+rdZZKr5T0CHCKWVUKDPQ1M+7v
         Ol1ZY3Ms1g5Xyli7t/sAZ7M3pIAALGEi1p/sHCSlAXdj++pSCdD//OU6akYC3wrcGzDy
         L6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163559; x=1733768359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9xI3zMiroK1TWhD5qFX+TQwJDBCg2p4NOnhJcoAr3E=;
        b=Oq3mfWTFs/ZKdaBiC6Bn2gDmVBIdfEqKW7irUoEJIVOrVXUg706qQGN3/djkl57gfA
         6mo94gDAhMfla9ishgXJQjx/5eMC8fsamXJT9qU/ndg7Hy7qH4i6JBnEKoqYBZRsyW6n
         sr4of2M/j/diuCBPbq+Getf/A463SIGXyKnc4BrejK62txamjRcvyZULDuB7kUZzveMT
         8mRT2G+pEPOYLTEtETmjqHKKTfrIW3BmsGvYOA94NChI7ZC1GD4uiHZQtIx7dI6n+EHO
         KuBHhut4X+oTiOvjaMKti26O1nvKYAMTPn5wdSLalWooQa/wne7cM+cht/KwOlL5IPwe
         GytQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Y9aJIWKlgd7NyEjqkTXRYfdJGzDmDDWvaGyQDjnTBEqytjGI1cvO7OLZ3y3+TWxNzso4DsD+fb8G5194@vger.kernel.org, AJvYcCWbmNUBX/SjDke4urXASqQXfpvP9RjDWj+bEOwyiTvQm1/TCITMGNZNZGt0V5omQ3nNXsqBswOOO9jx@vger.kernel.org, AJvYcCX9+WcO0nZIH4tncjV7Ii95lSIpxQNiccioiGvBsj3Nf5PvJ3Vkn+6FPH+bkIlTCIXx5vLkolqVwmWC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywth/18aunHasQoFuP5LZ9nbUSK4mzzJlXt3PGQw/qidHnyV50E
	H6m41EfoxKthiZ8LjE835Xl2KB82AcJUmqKrlu611gkwOTMzadU2
X-Gm-Gg: ASbGncv2KbHPQ2pArPVbYxIqEcfJSjzg7OfXuexEOrJbt00Y9Jju5tvhoEjCZ/haOGk
	lfz/yKkiqQ7iyeEuPKCG+GeMRTJHjtgP8F3WvmSRO93i6CPoovqIDLx4Eg/b0Iy/GhyksDRf8MH
	ipRos80uolEkYPVB5fkAGL4GIlLmzV2359E6yu6w2+D4Nq5v0Cr6YJXF/cXDgDN6h55KTczIHVP
	JxkTm3938eCvsjDQzyNUK9GJjWmeQzoMy7ODwlVfUcJc5ycWosYS9Z/namFCdM=
X-Google-Smtp-Source: AGHT+IG80za/uK72ISWgh9HZEe56T4mKDhe/iTDphKwBhssjmYdmU64UlUdSBfkV3GqToLqJEMz44A==
X-Received: by 2002:a5d:6d8e:0:b0:382:4f9e:711f with SMTP id ffacd0b85a97d-385c6eb8dd0mr21073908f8f.6.1733163559094;
        Mon, 02 Dec 2024 10:19:19 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385d7d4d9b0sm11659108f8f.65.2024.12.02.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:19:18 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI interface
Date: Mon,  2 Dec 2024 19:19:05 +0100
Message-ID: <20241202181907.21471-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202181907.21471-1-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
in the device-tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index cb201cecfa1a..43af400a9939 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -55,12 +55,16 @@ properties:
       If not set, defaults to push-pull configuration.
     type: boolean
 
+  spi-max-frequency:
+    maximum: 10000000
+
 required:
   - compatible
   - vddd-supply
   - vdda-supply
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -73,6 +77,16 @@ allOf:
     then:
       properties:
         interrupts: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - bosch,bmp085
+              - bosch,bmp180
+    then:
+      properties:
+        spi-max-frequency: false
 
 additionalProperties: false
 
@@ -93,3 +107,21 @@ examples:
             vdda-supply = <&bar>;
         };
     };
+  - |
+    # include <dt-bindings/gpio/gpio.h>
+    # include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@0 {
+            compatible = "bosch,bmp280";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+            vddd-supply = <&foo>;
+            vdda-supply = <&bar>;
+        };
+    };
+
-- 
2.43.0


