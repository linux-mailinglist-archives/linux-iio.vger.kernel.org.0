Return-Path: <linux-iio+bounces-23265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D5B34DF2
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D463189064F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF528DF2B;
	Mon, 25 Aug 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbD24hzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196628C039;
	Mon, 25 Aug 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157143; cv=none; b=Yd9GnOZMPTJR2O4LE52xIdnbAfy7SHhSKHFCpJcnOj1XNjbUomcEiJv82GwoOJQNOGe3KNj57fBKICA1Zi0oLHEMrZJ7KIm2duC9PLgNNKn2EVoyRHHPxwr2j9lk0TviO6HCCHl+6SrBubfoXswfzzsHV26sQaJGRxB6LaoJGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157143; c=relaxed/simple;
	bh=Jl/ncDvqUh192GvaR34ov3dmZVRGD2P8BbYjxlKL2DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFY+I5JLOUmk2d5a1zMVJDs2DmPufZBfeivq1B8G61EB12Y7DnKmWRQ9xIY9kMlOkyrL6R/y0c0duYqB/FpY4+znm4qhiax3fUeSb9tlLMWaCEtQh7DP3jpuU0WRl1ZnHPdguJhXpefymipdZJx+vLlZ62nrgce0ASIqarVFPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbD24hzl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7704799d798so1579544b3a.3;
        Mon, 25 Aug 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756157138; x=1756761938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHyfvSM9kRi2ZG7wLj8FVPiyYX+kkXwgRk2he9dJF50=;
        b=SbD24hzlvYK7FcDpxVO/A55NV1M6HDkgQ8bWu8boUX1iNpEs/IoSHVTFwzVirA2SJn
         31ghNsmbCrfcVzMVPCRWBa+TTAeU4jxQv1cSlc553to0iEpgCww2i9Cn/WOT4ghif7LN
         +cHVUHEmvK8lp6TnKlVM/1zyuOLavl0XwzwD4pVyDYlKxWnJGmr6mgvNDlV9iAeVZIsU
         M3N1xV5/pYhhHNQSLCGJQJ4C8rbyXHmiGCqULKCYdtkSQR6eGMcOvkPvqUrrq0ndWQ0y
         75qN3mEfDySl6CDzQ9JlJl9hKlQ9FnxGOKJX3xk4ArG9Q7QW6IFX+A58QX/23DrymKId
         DhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157138; x=1756761938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHyfvSM9kRi2ZG7wLj8FVPiyYX+kkXwgRk2he9dJF50=;
        b=IgVulAkIK41iI/WjTV3xAXP7XCnwiRGwtOQOynewkZcGkXcFz7g4Y0InemTumfdD6o
         uqeqttnMwulWXqOzTnJ0II+Hohv3qwLG7xo7pyhGMWPWAEUfzc2Tba+9QR0mgn/9GB2w
         zZWCfNm3n+voR5nIWlvnY6jJ+BuQ3s5417sYnw/isXFnEyGIjbvdI1JsQDgG+HDAdO15
         14J+nsoPTO0LulpnsZzyGzAF+74dTWdXs7lT9QtSg5CPnvsu3XuwkobdFpMAUcnPpL5d
         vP1PjxbuhylVyQt9j5iHuI/ybnXXswy6ukzRyZuLYPe42DcufSKi+QzIUjIVWDxMRL4R
         +aRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh+NOCWU8fTxQ1CaamvEkcn8GKzns3kbdkfTpNJpzny1N0MbRPmJP68TRZ9tVAg0DO3RpfcdjJKWxYIOkz@vger.kernel.org, AJvYcCWDumLTswaqKY9epNXXOdQRmc0DMI8jnbR6MBeLTQSZQbkevXEaN9vSmvfa+/ZYJrnqb09JXJ2cAi7J@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDhceRfaS5OyEJLFhoJzVAj5aPlGUrHQZ285Jxwoc4PiKNlYe
	f6ol0XvaIeC86SZO+C/JpljyjF796HGWaIEkerPTr2Q910iV1sFtNee/hqIWc+nT78A=
X-Gm-Gg: ASbGnctSSDeuVwzENNncy+BvvVQPJVchPGTS1hxrol+ufNuAyJlDByyd3s10lziTm/J
	PaLlVtYHGdsom/DaUMq2zgx1GFVHEDTae6jgwx4tzrj+feh7NK5H7Qwg2fsBHXkobSwjN1VHyeb
	gzpnjdMqZ+b8KG8HFveYxvfmI2HmBC5b/+eAdv7sUjMStXwSAbsdQYsYi5o1tvJdgeJqQcPoFfC
	Z5MwiR/qIFlsd2foxLh8Wtv89o833NF9ayPq/HFnMcW9rgCJRiTmygwfjMJkdzuDRG03RhgP03i
	9mRS4X707dPA94YohaBJgJj/E+8242JDVH4yEO30u7+98MK/IgZ0SRj1VVCTb1X69CBSWLQqrz7
	BSH+2JpsIfcvbniUdHZa1CwxozQ==
X-Google-Smtp-Source: AGHT+IEENsXfTmbxZjxtve9uLQGo3s7d52MKn7WT5ZD3JkuoYC9tHP3L4CGQ0HTxEiVuoqJKP3ETrw==
X-Received: by 2002:a05:6a21:6da2:b0:23e:19fd:e182 with SMTP id adf61e73a8af0-24340b18985mr20069739637.13.1756157137644;
        Mon, 25 Aug 2025 14:25:37 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:38cc:eb35:b786:98be:f27d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c2fc5f9ccsm134253a12.45.2025.08.25.14.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:25:37 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alexandru.ardelean@analog.com,
	jlc23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Marcelo.Schmitt@analog.com,
	dumitru.ceclan@analog.com,
	Jonathan.Santos@analog.com,
	dragos.bogdan@analog.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add device tree binding for MAX22531 ADC
Date: Tue, 26 Aug 2025 02:55:24 +0530
Message-Id: <ba7c09277c71cd8bc84736429a7fdc66914fd322.1756115378.git.jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756115378.git.jain.abhinav177@gmail.com>
References: <cover.1756115378.git.jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add device tree documentation for MAX22530-MAX22532 family of ADCs.
The MAX22530–MAX22532 are galvanically isolated, 4-channel, multiplexed,
12-bit, analog-to-digital converters (ADC) in the MAXSafe™ family product
line. An integrated, isolated, DC-DC converter powers all fieldside
circuitry, and this allows field-side diagnostics even when no input
signal is present.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 .../bindings/iio/adc/adi,max22531.yaml        | 75 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
new file mode 100644
index 000000000000..16bf4a1d0926
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Abhinav Jain
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max22531.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX22530-MAX22532 12-bit Field Isolated ADCs
+
+maintainers:
+  - Abhinav Jain <jain.abhinav177@gmail.com>
+
+description:
+  Bindings for the Analog Devices Max22530-MAX22532 Field-Side Self-Powered,
+  4-Channel, 12-bit, Isolated ADCs.
+
+  Datasheet can be found here
+    https://www.analog.com/media/en/technical-documentation/data-sheets/max22530-max22532.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,max22530
+      - adi,max22531
+      - adi,max22532
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+    description: Maximum SPI frequency (Hz)
+
+  vddl-supply:
+    description:
+      Logic power supply.
+
+  vddpl-supply:
+    description:
+      Isolated DC-DC converter power supply.
+
+  interrupts:
+    items:
+      - description: |
+          Interrupt for signaling when conversion results exceed the upper
+          threshold for ADC readings or fall below the lower threshold. The
+          interrupt source must be attached to one of COUT1 to COUT4 pins.
+      - description: |
+          Alert output that asserts low during a number of different error
+          conditions. The interrupt source must be attached to INT pin.
+
+required:
+  - compatible
+  - reg
+  - vddl-supply
+  - vddpl-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max22531: adc@0 {
+        compatible = "adi,max22531";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        vddl-supply = <&vddl>;
+        vddpl-supply = <&vddpl>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..6f26db9cf742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14702,6 +14702,13 @@ F:	Documentation/userspace-api/media/drivers/max2175.rst
 F:	drivers/media/i2c/max2175*
 F:	include/uapi/linux/max2175.h
 
+MAX22531 ADC DRIVER
+M:	Abhinav Jain <jain.abhinav177@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
+
 MAX31335 RTC DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.34.1


