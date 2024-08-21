Return-Path: <linux-iio+bounces-8669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F266195A749
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F331B21585
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE317BB24;
	Wed, 21 Aug 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8kyQcwc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74A17BB3A;
	Wed, 21 Aug 2024 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277455; cv=none; b=KnhmKjcRpSTAd75XqGZfuPjBfkOCtmiAKQP/JfdiyIpzrTukPO+x4pvjb0lhwjvtfBHu6vg3IRwCQVytFjyyA8SFNZW+yLix34kRIzgiKPAEk73xhCsvrEYGguQIQA1JQsc5wV0VOwEx61/bHnTD7s+S/Xx172b15GePOSfRYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277455; c=relaxed/simple;
	bh=xtbe2GE0kxv3PLdvqMIaX8WjPceiFQkO5WY5kWSV1ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8bCf0ymK5aCuaDCV0U2btjR8CHzsFjWGwlWVCgS67nLy5syxkMoa1d5xHSIkEs0sX3OZlcpfEqO7EaywP+8OsHx+P9FEYdqFpKAyntV2yCJ83/T3rx6kLKINTCn0AMGJVR/KQiGmX25LEjyf3ubyj0gwCpe/zzx8XSUzRyOsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8kyQcwc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db1956643bso83009b6e.3;
        Wed, 21 Aug 2024 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277453; x=1724882253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGxHVYptl/mfZ5O11htImf9Dey/T9TeFYQkFJXrtkIg=;
        b=M8kyQcwcCCZ2+KIqRh/50s+2t/56i/G8MqBmaP1UCqfYm+61LevSObK9Nf15Wuk1bR
         VtT6r329mAdjpJoRN486a1MDllRKxpic+cgX2DDPV/5O1nHVgX38OgfS0G523j9cgJ0f
         y48crEsMff5MidCN8v7OEWOVmXZcmxk/g/vCyyqXubrODNsquSFa3pHavVan8h9aZqIO
         gPKkHt/KNOM/oGYqQnyy4Q62GCDVxUvJ50yiFzTZHXg7uY3Z0Xg07YyJ8WtcHOCkeRyB
         ahezgWxeI8Q1wgxYlRzNLib09qIfoNV3XbF8dIpeXPYE1LhBi0FLR5Uyzug8s30ZH3Dz
         D2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277453; x=1724882253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGxHVYptl/mfZ5O11htImf9Dey/T9TeFYQkFJXrtkIg=;
        b=VETOuRzp+aYGQfquLeEOzI6PSgOn8t6HXXA/qsHtdikTEo6P2M3lrIXP74rJr/uf8C
         iFdVzOTYWS1I+lzfhAY1vdjyehAYoTmRhuEGiWxIHK49a6m8sr4ENIlxMWam5LdxLLNM
         PYPbBxDdqn+3RSZZiaUoGRFe8D3o3jb+OPiGBTtoa69KtH4c0I9aPMoi5NkCVbGMuDhk
         EyDn4pp3wwklhactvtcWo/6TkXIzWHVOtzwkFK/gCWcwyAgOqIn3yQt4izC9ksZ6Z9YT
         EcoBwuErPEDLgRW2g/Hv9lmjNrh/Iiec0yjdMSl9e2tId0X54YALQ6NVqfqtipj7y7sH
         Yg7g==
X-Forwarded-Encrypted: i=1; AJvYcCUoLJvce/OZjZyKcOIzJ6ESm8+DI3TykZdzfVvPcy4RyxTr4SoqINvevMEqO8uD2PbnCuWsL+sn+XKH@vger.kernel.org, AJvYcCWP181fx20AHjv/Id/aAlsRS93wxCZf+9qxtDE2JJ4K1c+kW1SVct8nLK2homTze6Vjob1R9R0kMpYd@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCfbAz5TJEIHO1dQZr1v+O8kheBIwZSK6nqOy5K9iEe4F2UWd
	jKHsP80YsOz1d8IQEdPD+vAq95jOIGvqBwjkrk0SG5y1+t2G6eiS
X-Google-Smtp-Source: AGHT+IEEVh05GQZqcfbn4IDKx4nQgV7t9q/7T+7lh7gib4DsRCbvqlfs8kaWytyaNhMT/Lx2z5jZKg==
X-Received: by 2002:a05:6808:2f08:b0:3de:220c:ace2 with SMTP id 5614622812f47-3de220cae0amr601913b6e.14.1724277452915;
        Wed, 21 Aug 2024 14:57:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:32 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 05/15] dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
Date: Wed, 21 Aug 2024 16:54:46 -0500
Message-Id: <20240821215456.962564-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Allow specifying a hard limit of the maximum input current. Some PMICs
such as the AXP717 can pull up to 3.25A, so allow a value to be
specified that clamps this in the event the hardware is not designed
for it.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../x-powers,axp20x-usb-power-supply.yaml     | 58 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 34b7959d6772..ab24ebf2852f 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -15,9 +15,6 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Sebastian Reichel <sre@kernel.org>
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -31,8 +28,63 @@ properties:
           - const: x-powers,axp803-usb-power-supply
           - const: x-powers,axp813-usb-power-supply
 
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. If omitted, the programmed value from the EFUSE will
+      be used.
+    minimum: 100000
+    maximum: 4000000
 
 required:
   - compatible
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp192-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          enum: [100000, 500000]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp202-usb-power-supply
+              - x-powers,axp223-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          enum: [100000, 500000, 900000]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp221-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          enum: [500000, 900000]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp813-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          enum: [100000, 500000, 900000, 1500000, 2000000, 2500000,
+                 3000000, 3500000, 4000000]
+
 additionalProperties: false
-- 
2.34.1


