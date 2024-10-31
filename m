Return-Path: <linux-iio+bounces-11674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD0E9B752B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E2B28654D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23414A619;
	Thu, 31 Oct 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SxSUVrM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C93148FF6
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359076; cv=none; b=iEYUUfZbrGkygG7jv+a/xYqtq4GEiLSmld7qIZEFbB3nt8twawYIBG1IbP36bo3wNQt1qLrcDw8iIxgYpE9fTtzR6xDWVCvrvTfR9GGL3hNN9w4ZJq+WHXYRTHAb8f6AM7bfk81Yyp2kn1mBaNJnv+R0uEAIUl+3JZsbj5bBkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359076; c=relaxed/simple;
	bh=np8Q2QVfQltUi41eXVufgARgz5a+zr3MKMZbbDyqKkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwUZ+8BFJ4c9Busa+yAqTxl6yPaLUcR2zXb+RRK5WAZJ+93U/MuiFMEGtcQ3FypgrKE8CEvUrbZwkMLr6KIk8ZWS+zWdM2pfiztoW39VEQqLK8X+2aOQyhtbyCz3L/RnHb6BZ/wOwDt+Ej38QQPkDBG/P3w5TNuWmZ/GtI06lHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SxSUVrM4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1072884f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359072; x=1730963872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XokXFUnFUJYwTRpNxF4QEO2NzHATnQ3nu28Wn+V/kw=;
        b=SxSUVrM4fAUILA9cth/SWarYnL4MtdrKyRVQa96SpQnIowveED4X91Mi7WflpU6XeX
         gW3vX0vuI/E6I8NpGouWb6BKtDfiU+Rg81aA00NzjSNvY/X7LBouUaKUFQyt9ndYKRpB
         QZzoNleGguRy3J3jEfNRZgmSb6KlQ19zbS2k3u2oJuDok6viEE3uzg94mmN8F/7WubbV
         /JNkXlIOyyhtbs0P6tk901dP/jGKTaBIaTAU2cNnGI0MCIIR7MvKAz9ZcHiGPu7AaYpQ
         BOUpQbQcyEkCUXswpWptL1AP9+V2giIPdBLHwTBj8RzjwiLty8uJF8EQ/FYcz5avDQiS
         Rszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359072; x=1730963872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XokXFUnFUJYwTRpNxF4QEO2NzHATnQ3nu28Wn+V/kw=;
        b=EF2/0Q7e0PNOzSV34TyVWKUMyne8DL2Fxf2Pl4HUui8wVR3KK2woFVU00DiFOjovWi
         7RzI46tw8qBrRtLdIdwDudlt38d4iel45/pnJCBeoUlx8tlay4giEy/ojvqYy60O9bBY
         xoAh+9LeuQkS/8xHE0dhDUYIt5nLGPu/9vEPpNHc0M4v0lAu9DwnUFkkOm6M+zZ5UoNZ
         sxTyn+tKXDnV4TiaaSYrLtKPhH6gwbJUECGikCZCrsYN9yOFuD/A93xjwV4QsNdQ7zaU
         nSOW8rhgUsMOu3Y2dhUqcTzMq31U2Oxior5hM9x4dMR4xhqgWkV9Cte0XL40L7SptCQ3
         8/jQ==
X-Gm-Message-State: AOJu0Yz3T1p+1Habr3XgfD025Faqd6RuicHOJjrwZL94fCGn+RN4ylXl
	NgwmIXHs6N5ZqYj2Oieq4dFHdZH0C3oTALBv+UlP6nG3mYr1oWNvqupuvtNDN5Q=
X-Google-Smtp-Source: AGHT+IHwQ7oBgfvFPEWdP5rY03R7404nWDkpFlRIwBt15xycWEIbwG4Y8/p8O6RKEwgky5rkwhtGjg==
X-Received: by 2002:a05:6000:1869:b0:374:c6b6:c656 with SMTP id ffacd0b85a97d-381c14c3469mr1015819f8f.21.1730359072176;
        Thu, 31 Oct 2024 00:17:52 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:51 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/6] dt-bindings: iio: dac: ad5791: Add required voltage supplies
Date: Thu, 31 Oct 2024 08:17:42 +0100
Message-Id: <20241031071746.848694-3-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Vcc, iovcc, vrefp, and vrefn are needed for the DAC to work.
Add them as required bindings for ad5791.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../bindings/iio/dac/adi,ad5791.yaml          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index fe664378c966..79cb4b78a88a 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -26,6 +26,22 @@ properties:
   vdd-supply: true
   vss-supply: true
 
+  vcc-supply:
+    description:
+      Supply that powers the chip.
+
+  iovcc-supply:
+    description:
+      Supply for the digital interface.
+
+  vrefp-supply:
+    description:
+      Positive referance input voltage range. From 5v to (vdd - 2.5)
+
+  vrefn-supply:
+    description:
+      Negative referance input voltage range. From (vss + 2.5) to 0.
+
   adi,rbuf-gain2-en:
     description: Specify to allow an external amplifier to be connected in a
       gain of two configuration.
@@ -47,6 +63,10 @@ required:
   - reg
   - vdd-supply
   - vss-supply
+  - vcc-supply
+  - iovcc-supply
+  - vrefp-supply
+  - vrefn-supply
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
@@ -65,6 +85,10 @@ examples:
             reg = <0>;
             vss-supply = <&dac_vss>;
             vdd-supply = <&dac_vdd>;
+            vcc-supply = <&dac_vcc>;
+            iovcc-supply = <&dac_iovcc>;
+            vrefp-supply = <&dac_vrefp>;
+            vrefn-supply = <&dac_vrefn>;
             reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
             clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
             ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


