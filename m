Return-Path: <linux-iio+bounces-11546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C09B4343
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913DB1F2334F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355682036F3;
	Tue, 29 Oct 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KOAITw3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CB201111
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187546; cv=none; b=dhFxan+4Y8l1haHASSAIKBOmZ2s9JC26J8Kr+gb3JkZ9E5pE3Rr/kvOfmmQr1o6Z9SxfOALRuv7xi/FOWKFgQARKkSQGFSJkordeYiQmM3eguqC+jBT9xyk4rty8ZH25IFJaJ1cKqVVYyZuUKXoL9X9YAew2lAQKoCQ7/FtDIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187546; c=relaxed/simple;
	bh=jafJk2l8LB6j7r+ISNKS+BYGrzbzmOwpI3CE3mDkURs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgARvSCZzIWYIbOPSHn6OxpJo5ON5AYX7AhcSlUzmzS8iqhOHQYdhV3Pyy2uahH8O1myyHOx2tLLbuSyyPH4vlf0uqfwiDqqakMt9MQNe6l9a6oiv2oDgLBjzFK0gwGG7lWleINgUID+JWUTyYoe3c3FycQnxW7NbW/LaJc2n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KOAITw3B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d8901cb98so4165103f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730187542; x=1730792342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByBkxKFO1zAiwfUD51XRICDpnS7esWzb+iP98wAku88=;
        b=KOAITw3BtyqCiVBp2psb89nhskAlcs6IzCOKLx7SWFHZDhslzkuHGPoZkyBtiME2kU
         8vUxZ8Is1iaZL5PQuhNJK0s0m9TlPhggCfXnxxFPQlUGqkytAfCXCzNg/fRgFTROqu4w
         fFv12YgAWroaPRflE5iJrOnZiBpZhVlLQQM8uNEC1j3W7FBvnLY4slE+dRzDBRvUsQVS
         ZH1BpoBPbvvbLoi+79R9HuN5tf7cDNnFCGuQQR7ltby/BqZcYiZ27JWKmtJwoSBtubyb
         rvj4mF4BSQhNZeLTKl5rPiHKFUGugf00/4kNgWFl3DGEblMdFTyQxwjSGWAo5dU7AEp8
         TXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187542; x=1730792342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByBkxKFO1zAiwfUD51XRICDpnS7esWzb+iP98wAku88=;
        b=WzmT4sSp+leGdQIfHvoTS/Z/3wzVEHKa8llAO1wLZhCVVxGh2vrxhC7P1csC+4l/o8
         shBs+vv6yHBjPX7nupOwA+JzVQHwum0okSk9Nh4kjI3j5MRRKBaRuCP62eq4NRff3+vY
         hnOhr1ifPTcXf9F4abMjZgbS5XwXMLJ09ZtyXKlh9idaQSdOGf1mJLmgBmNaKVlQDG2t
         hkU4t+O2zvGqW+G+/ayjDfE4cSs2kKr6MkgC70i1HbUmZuW/49MWHsJvROl8oGq1xICL
         lZAoKFB5viqqfJHm6wfDDEPTYN2Dm8XHQdVt3oXdhW3SinJ/gKBsnhQob8DzzuFmbIR4
         4AFw==
X-Gm-Message-State: AOJu0YzDSxbGzLolnegxx/2CRxreQQW43IXFLYoYbSx5cFrrvkXoS1zK
	EIO+ZidHw75C6AOGyhHSGZMAGA2BruKQDrFC4sIU7QtpTLeqOm/P6RCidftCgbQ=
X-Google-Smtp-Source: AGHT+IGsOTbqoT0AU7JxWkeKxYQBH4Tl4G3UGLLILEaIH0T/p3AFPiOJZfClYLH6CLSMd920jcG8Eg==
X-Received: by 2002:adf:e742:0:b0:37d:4610:dca with SMTP id ffacd0b85a97d-38186a22c7dmr734577f8f.31.1730187542265;
        Tue, 29 Oct 2024 00:39:02 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm11692939f8f.71.2024.10.29.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:39:01 -0700 (PDT)
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
Subject: [PATCH 2/6] dt-bindings: iio: dac: ad5791: Add required voltage supplies
Date: Tue, 29 Oct 2024 08:38:53 +0100
Message-Id: <20241029073857.753782-3-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029073857.753782-1-ahaslam@baylibre.com>
References: <20241029073857.753782-1-ahaslam@baylibre.com>
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


