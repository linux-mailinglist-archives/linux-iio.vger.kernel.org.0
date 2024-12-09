Return-Path: <linux-iio+bounces-13294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473E9EA2F0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 00:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854E91666C8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1D226160;
	Mon,  9 Dec 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URojwwLr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F212224899;
	Mon,  9 Dec 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787547; cv=none; b=aqCiolcbz60J14CfiQpbB1x9O53VijkmP2kplRbPQ9xzhPLbOBj6Dfwecyf5b1bajtodwS0n8Fe9c96sUx4KZFqhZSw7m+OAJj+AQCGq4mR+HX5EEZ6JyOwTqSj3aWJ1p52K7mJzdPDjclxwp1iQ5y2jEuXp4CFGCKujx7HxTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787547; c=relaxed/simple;
	bh=qcuOdx8hZivNp+/lIGlZem/7uPAPAG1pRU4ZVS3dgl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnI24TRJY2H5qtr8Xur4NGzpqAAfy7LOCezQbRJmQtCwyiuH3fiVg+OFKdEWm2mN1FlYAhbr30AdK3JKUjgRpwtTAL0uMiOEKOGRi7TpBdFzarrO4kbMKzJC7cxLKIZAFSIKrABFNu8prwBELgjLhEPIY9hSn7KpNG+J4IUxJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URojwwLr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1920261f8f.3;
        Mon, 09 Dec 2024 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787544; x=1734392344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQC+/hcHw3+9i2y7f4ODYtBOZ4vTIJRxDA4KogHU0vU=;
        b=URojwwLrIsSjIqvZ3B3aTW7oKyKshemXPqKZdcYwDSGRKKHkrEHpE61ro9MHDBbAj+
         unVo+p6lhg3gIJci4m6m32BxVFMbUeySSDudBBvoM47qmSy2Tg+jC4Y2E631cl1oL3lK
         bentU+jp+7+eVpSFStkr7fJX9koQIGhQr+8H2KqBWlJTtS4wOYGrWKkZXBVFA5VLZRSP
         z9jf7YqMiFaG2H0UfdZ9g/GZ5737jWcJROM9XGEkqmENQ7GIu+ApvWgGpCYxTMtLs5td
         3mU0SatTa3Wt/ysw7YMs8WXyvhwbbkNMKvyrGX6QqcKwAvWUJ5FOdsw7yrJqhcJs78EJ
         zfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787544; x=1734392344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQC+/hcHw3+9i2y7f4ODYtBOZ4vTIJRxDA4KogHU0vU=;
        b=C2DbmXx/LoWtBq9JOlDOVuLKXpyyDAO/K3V4htRn9AJsU4bN7dSOJfRW7Qlh17WPii
         jYUe8S/RdvCLRBYJDvfnw6EB097aNNytsMqPlaZVt208bXNiVMBCFzwoCiJu5NzFN/iw
         xHDKYUGZrmMZTJfvKrWWin/D/Mpg5G4E8Q3qo4L7RSWEBkXRZyNhqC7R9AzxkPgSsavL
         lsQ9tZvph2IrUgqKlUFp8EaX9ey3Bj+czcd0W9K01xtD2yBgDclr7jdoQVhxa+ZkybjC
         DYVt9bSH8SXZi+yhrazrLEuz1GRvZM2PZ/fl8mXjVwxzQYkfzaiYYRl7EH883TOVkC68
         LWtw==
X-Forwarded-Encrypted: i=1; AJvYcCVMbq+VMcvkZPa1l7m7a5rAQxb4TljqN2XzE/m5tD4s9ErbUZxTY9xLvnJRVZAW306qeaj3w3dl0JYY@vger.kernel.org, AJvYcCVk0IqDFwt2s7Ljppo87SNTAhvq8ZRGnNEESqcjqfWai6VfPxQyGIRzEIOMZWNQ/Le8guicHxDWSfQk5xkG@vger.kernel.org, AJvYcCXy8tnLESYWM9OxjMb+HUtqnT3rh6EMmCUQ3WBKxl8KmbQBzIHz+AEGOe680Yqk7Q89DqNVGTrI8iE7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2+bbpOcmuuDkYtbpAqSGdTzbzVMQEbj2/pzR5ECX/WmURDFy
	zlxYjrxDdm6n7P6x4Z9mkJUS/JeRrTLEQBsPDWrTdnNepuJpxNcn
X-Gm-Gg: ASbGncuVWLH4ackjsKD5v8A75hSXcdmBaLOLCMgMMIexM8imN0rf9o04QZxnhu9gpAJ
	GG7T3YI6POAsWbaoHgzTgrDj0KotS7oRcwrzwnxHtGDb9ZWdiQRQzkdMM/ujSvQnoRlIUDNZvTK
	23MgaIZEpqPOF84OFzNumxxNowtX6Kb9OsIt+h61SzNpXkCQd+mjeBEvpgwIo8uYic3AEio56hr
	b9tcg6QkDoinBix/6EY52gLUZQNHpjTmr9TtF8rWVYyNQMIP50AqZbDunMbbKpUZQ==
X-Google-Smtp-Source: AGHT+IFywjbHHP9mdCram3lT2R/hW4Cqjc6NKIFgjA2mJlCelgFtVOVWnaNpXLjocVnzYU1T0G94Nw==
X-Received: by 2002:a5d:6da4:0:b0:382:5088:9372 with SMTP id ffacd0b85a97d-386453f67f1mr1578143f8f.43.1733787543514;
        Mon, 09 Dec 2024 15:39:03 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:1688:29d6:6b3:2e70])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-386220b01c5sm14298564f8f.94.2024.12.09.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:39:03 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/1] dt-bindings: iio: pressure: bmp085: Add SPI interface
Date: Tue, 10 Dec 2024 00:38:45 +0100
Message-ID: <20241209233845.29539-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209233845.29539-1-vassilisamir@gmail.com>
References: <20241209233845.29539-1-vassilisamir@gmail.com>
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
 .../bindings/iio/pressure/bmp085.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index cb201cecfa1a..017abe8eb9c5 100644
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
 
@@ -93,3 +107,19 @@ examples:
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
+            reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+            vddd-supply = <&foo>;
+            vdda-supply = <&bar>;
+        };
+    };
+
-- 
2.43.0


