Return-Path: <linux-iio+bounces-12798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471D9DBE17
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 00:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC5163435
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9721C9EBD;
	Thu, 28 Nov 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SViYUbqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB701C7B85;
	Thu, 28 Nov 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836308; cv=none; b=JkvZ5kNTv11PASnfNrI/E/PpCO/v9oqtDpYl32LCrelV4hmAPbmzqBX1XH+AHGjOrKLi5vKx5Zd/LQRAamehwGAHvNsfuAtV67IRdWOOYPP3p0wAgb+oOHqTAauQN7Hl+vINQq2izmjz2l8yfDgBr8bmDTvolt23HIyc1wayctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836308; c=relaxed/simple;
	bh=I5vv2fWuCCm+0kMBnAa/cHM5vA7PqH5H1QTs6M7O+zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GayGiLLTBFgoMp50yKmDb5aZrN6zQQbqZkcCRKHD/gHJXh5Gv+sp8YT1iuQ0OQNkfOWd++zru+8cjs9GzIXVV3ZIWXGXWXhkldW0ZSfMHrTvv2IshlhEu4hu8GfojS2dZtTExDcM2nQkICm1X/tGtA1kYQuJjmOihbbIKXIVXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SViYUbqf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385deda28b3so8140f8f.0;
        Thu, 28 Nov 2024 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732836305; x=1733441105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYXADLk7e56HOtJ9NIfhy4w3YpkQF11ICyrRorAihY8=;
        b=SViYUbqfa7HyAGl09DRVrSxso8Ealk6EAGiTcse1KgOmYCDmCwuMsW0X4p2mDqeHyq
         kdM69jM2+lDQ0HMqJyodFijhnY4Em+ZDmAyvwTAEtVJ70zHQJjwo/V9jFXi/g+OkYhmj
         gLLnuq8shYxE33m8LKfFf8RjzICvpJfEr/Pbd3PBiXwhb8JpK7F0VjqpXDTldR0vPVzM
         XKi8sckUSVE8l2Vcm3A/Kpt1wP1eCYiWKDafe74IbrTgoLD7nyoDq7NWmiFyG8M/khzl
         6KIn2lus/YgmPeOqWpOaYm207Gq1g5MJPeVC4tAytXsejcWTcFDuurELjdjgw7Scs+EY
         IvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836305; x=1733441105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYXADLk7e56HOtJ9NIfhy4w3YpkQF11ICyrRorAihY8=;
        b=RjtjHl6dGkQ9q9gvM4pi48zOl74yjXUP0+reBYYgaFAlS+JPKY8MyxeeYvHzwF9MfS
         yLTADShQtWWTgc27aHrRkyZ4l+KOJbIoQOl/xdReZQxfWHawsvUU5TYtsIO/nJm3ryF7
         Z5zVIl2JvqL48HMe+ENetc1CUvfsP835a3CSLbnWEpxAstHD6+S7IHLb1p3B7mZLp08q
         Jv1Uruq0H+vZtz993BtQbWAntdOC/g3ckdwC1SSfx3hPGBmbiR5gP29lDjomBIH1Oanj
         RmzriZ0VHXZRyJAz99V6SiZ3wXA+r/qbLyHE3KlCsol+jggNc16MILMoJZsySaQFrjfM
         hmPw==
X-Forwarded-Encrypted: i=1; AJvYcCWcxLYBdp/UgUayd2h365PagC+fl++jn6qZhiNRgfDu906oDaFwfSHQuXATRkokr8QGYTmh2OHChLa6BQbD@vger.kernel.org, AJvYcCWxeDzBH1YF3xxZWP9TSfi8jXwje2K6HOyzEkWch7PMkuRImvJOWwUQ/T+XzAjZEyhHIfEGlxk3U6cw@vger.kernel.org, AJvYcCXNnXtKpOiRzjy9iblGfZiRDjcsgOK0zKtfCz3oRQF6CEnuiULW81kQQC/zh+surA9wd5VbmK5qqczv@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDCR3NAkYCStm/8BFMls7nxKdDA5lvi/eELXfcIxXuTwDyrJ5
	8huUPdzneFv2h30yHXAKqfPtVlPjsr5aaSV9yr/K5yO+JrWsupE1
X-Gm-Gg: ASbGncuNw1Yz0wqpfxKxH7itWW6kLxlTJXV3WZaMDxldsBNzGdkgp41HSJ3JLwWvx0i
	zz0vCnH2ivfe5bO0ynHYG2xvuu/bVoEw37elheczM1NkdSiDGsJxTS96+MHj9R4TZy2IrDvD3Gy
	MALsZQF1L48uN5TCDma+JiRoLXOCnbBWSmFb1jXezFYhGxyljmh7v8bUwf8erlPfN8BiEGSzJEh
	2vdebR00maAYfM6dxEpQojCrLuq+Ku8QbicNR2nDWkMwAjUbP/yu9EYP+nWbwg=
X-Google-Smtp-Source: AGHT+IE67yzwQn+Gsp3D0lStWLhO3MHN+OUySiwVy8B6BoCexP/iHdjj1N6VZ+ot33T4CXCUMCbvNQ==
X-Received: by 2002:a05:6000:1865:b0:382:4a3b:5139 with SMTP id ffacd0b85a97d-385c6ef598emr7320578f8f.59.1732836305006;
        Thu, 28 Nov 2024 15:25:05 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd3690dsm2765594f8f.35.2024.11.28.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:25:03 -0800 (PST)
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
	vassilisamir@gmail.com
Subject: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI interface
Date: Fri, 29 Nov 2024 00:24:48 +0100
Message-ID: <20241128232450.313862-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128232450.313862-1-vassilisamir@gmail.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
in the device-tree.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index cb201cecfa1a..cbddc7bb26a6 100644
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
@@ -73,6 +77,19 @@ allOf:
     then:
       properties:
         interrupts: false
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - bosch,bmp280
+                - bosch,bme280
+                - bosch,bmp380
+                - bosch,bmp580
+    then:
+      properties:
+        spi-max-frequency: false
 
 additionalProperties: false
 
@@ -93,3 +110,21 @@ examples:
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


