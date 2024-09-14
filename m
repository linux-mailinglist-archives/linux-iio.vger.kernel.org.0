Return-Path: <linux-iio+bounces-9530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBD978C24
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 02:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D788E1C2539D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4605C96;
	Sat, 14 Sep 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuYK9NCd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6D17D2;
	Sat, 14 Sep 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273750; cv=none; b=LJ5aGrmZRTaj1AlJ3QrkpZTqPF5RoR6Ys/+IOZTTYcQW0mEw/04HRpTYcdx2O6A7ej+KAqtkcrXzvkXBxgdC9g9yjNk+STHvLC02SV9o+vcdEg8b846Szvf+VuHCcdRrowKXTtqDWJ+m0YfxbgGoiNT4ZkG5Yeb2h/NrUBvbr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273750; c=relaxed/simple;
	bh=7uC/oD/EC1yLWS+RCZzt3d9PsCUcWXEwxeyQTHW1eqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/6XO3LE1hBvjVA6P6VIf9YKwezSN8IqAavszf6r8jUY8u7KjZBpWUY/lhtrzoV9B3FJ+8DNF9Dr6FHKK57EvG0S/IIQCx8rIvBK2Zk2hO3VuqEF+iTe0yUM1lvPrsv1/p11mCXCBf7LbFcDYfPrMojZ7kgGXLSfnCG2MbaeUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuYK9NCd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d4093722bso356795166b.0;
        Fri, 13 Sep 2024 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726273747; x=1726878547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uievK+pt+AYAjztyMLN5d3R8p/Zue4ihwk/QuKxSgQ8=;
        b=AuYK9NCdjOlSX4+eyux58zTNN1VHNb8swpd50lduUX6yoyZanILULVAN0eQL2jypHi
         WA9HEtxBjQOlCoEiWZS1Nwtvv5P6dRHgCNNOczmE4JvfCv0igI9dtsRJdhrza86eJl//
         0Le88V6OPQVlceaZ5ZG6TFyWfstmN/9l3A+HS7DSBj5VXIslvwl5QFgbTqt11JYLtLL4
         gCfRsjIhbrQxj8P0qR/uNXlsaM3wtBm4fO2wdZB1IgMqU4j92zj7btEKt5UNOHILiX6m
         600v47tl4qRwgf1pQX8DMEeCl9l4IKK1cITbPmRmxyGfb7MRogMZ6gPHYTaz1ohOyj/g
         f4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273747; x=1726878547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uievK+pt+AYAjztyMLN5d3R8p/Zue4ihwk/QuKxSgQ8=;
        b=lcQRVEyDHTmpaMMOIaVdSi2KcTtVKx0ilkjn2XHW+nMHNLvvOp070QoCwYR/To8NT3
         +m6/Dxm6/ZVMKnPKvE7A9jmNW1yV3hja8nWXDlgmOnrVdLbvnXgkaeI7abnWssoQxzBI
         j1vZYv2yhLRPtqspGck3buvlpXNCL1LBHtKUVqkGiVBQY6zSm+PWGX61Kg70yizpeY0f
         Km86akIW393gNW8x7Vhdcl6wF/1zkOTpX34xDC7dZnV4KlEGJvwV9d035SG5maJ2+k1X
         YJSlkiEdQYPUbJgLd7ABIuxIP7W57D2lpy2KmW3Eg0jUZw416DCSJjuDechPgkGdl2gd
         M/EA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQvxHqPk/OYpWSNF4VWCA1LJP4jw2lc+eo6tQAZnyFTIXiu9iJpUTv8g1ulynrSNqxDnUgxEsAbUe@vger.kernel.org, AJvYcCVdFJPCSAZqv1rf1+CCda39P3SLW4z97/NPBfR+zfQs9LY5CFJC9ImZ63xiYfYnM+miZx+Mzpq2XB5F@vger.kernel.org, AJvYcCXho22z+K1j53DCBiBhAKNFTkMz2Wwp2qSiaoBoW63UEX03UdIbNuANHHLm0I2B4e95JJyNQ1Q0mq74JCz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1E/1RFsR4Fx7YpYK1lWJfEqhq1m4CBVd75e8+fcHrE+nlVrMR
	9WEJcj4Y4hNQM2aWh/MsAXRs3jTQpFxAmRZZYnXS+aryvGY8Wk36
X-Google-Smtp-Source: AGHT+IG+VP6e83GOh67WL4tpJZYccwgpddn8rN8trSMGh4AEZueo7Bc20+r97ywFZiOxGclxy8WTPw==
X-Received: by 2002:a17:907:e9f:b0:a86:9e84:dddc with SMTP id a640c23a62f3a-a902969088amr816623666b.61.1726273746487;
        Fri, 13 Sep 2024 17:29:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43f4sm15157666b.80.2024.09.13.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:29:06 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/4] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Sat, 14 Sep 2024 02:28:58 +0200
Message-Id: <20240914002900.45158-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240914002900.45158-1-vassilisamir@gmail.com>
References: <20240914002900.45158-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..cb201cecfa1a 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -47,15 +47,33 @@ properties:
     maxItems: 1
 
   interrupts:
-    description:
-      interrupt mapping for IRQ (BMP085 only)
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+    type: boolean
+
 required:
   - compatible
   - vddd-supply
   - vdda-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - bosch,bmp085
+                - bosch,bmp380
+                - bosch,bmp580
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


