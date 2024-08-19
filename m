Return-Path: <linux-iio+bounces-8607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F79570C8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F5728193D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DBB186289;
	Mon, 19 Aug 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuWQr1Fx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98B17C223;
	Mon, 19 Aug 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086129; cv=none; b=gzZpvvfXxwy/6VoR7aFAE0NCf/ND+T75hJrErLRzU+FOEBEImX/8lJLGS695BK6Nf1ZB7HKHlBZDbuTZa6IpCrUvvpceHIGxnMSNPyggQhKCYt4sBuAxmcL7+UyQQg446P49pqnl6pGscIY0GKjr585eOvsplEgRm6j43cLs0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086129; c=relaxed/simple;
	bh=V/didJfH9Mli5oAKhwkzsu03vK9Kmk0ArxEypPCD82w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqQhBOQwYCdqbX64ttk5yP0FDx75PWCjul2hUvsSGCmrpaT0lkwSkEMM+KH/4XYtoQ8AdMk/g92lfVwlx6pEZneGXOYbvwVEOsdT3RIzbmLY1EyoNx9yF1FK6aDtMVnVijEwqHMsMrBTw523AcRQy3evH6b+BxqzO6G134Q19sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuWQr1Fx; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093f3a1af9so2786471a34.1;
        Mon, 19 Aug 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086126; x=1724690926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDis15Hzp2Vx+5TQlBnC0YVroTqVlccFthHOCI8Z73Q=;
        b=XuWQr1FxhFRsOjOwjFtl7ahm3YTVAHOYQkVi77ZzFKrXQl1MpOcOn7lrQExZDUFulR
         yPJO/ceBdcGMDqkoR/R//y2iRsp7jE+dfXnRkhaGfSUJOLDTTDe01D5vZgMvhtauYVW6
         q7R9ojkxEwb3tsVpvXlT3lXJS5dkoSO+cBLOLQddTgcLUqApVjod3Kga8VfYi0uSYwNL
         lTk7j7yaFWdG0s+n4B4RIsyUT+3tzjX/KIGlnNW6dy1ZOWKWHbq5TRJR4KIm8vCJvccd
         AA1dzsYAdIfZqNRMQm1nynuS5TeQRM45q+6l7fCm6HpxlkfqnrD0RjjTApvw5ytSNnRv
         +uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086126; x=1724690926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDis15Hzp2Vx+5TQlBnC0YVroTqVlccFthHOCI8Z73Q=;
        b=svTRgQiYGvaubmUI2YPP2JVbzAf9+F76MjLsLLR2ARRWlxi9zgre9LtvwWBiCyBCRP
         Re8e9wfBxQmuuxw9SjyNYFdO0WK2KVjFZYPm1nSNsjGKoyheTbqNUvYOlEOHpY/YSWvL
         eMlizJoqOZYzKdAsouW47RZLcMwa+wHwhd8LRL88sOxP/33WvAf5w3XVFBdMJFO+D0Rm
         kHe0pe1puU+NChbazUyS+ViPLEHjjJdk4RPW9stN9qhtHFOXmSTOtKQRU3Vx78T4Hmab
         RG3+yPSnYSc+a8spl+fWrUQh6cQEmlLHiWDX2LSvvntCv3gL29x1yxzH4RZhlSJNasOW
         MFuA==
X-Forwarded-Encrypted: i=1; AJvYcCUNgZ03aghCRGMgLJ2LddR9mzzaNOLFqBM9sQp0cqMcv5fRsYIkWHDrZ+HxVWs960fw9vQL0Ss9dShS@vger.kernel.org, AJvYcCV2PAq5UaMoNjRIPL+1W6DSVvVcV+B55Ep2bo9try99XagXU/TB/3771iO5F2MPIV5egyncm7AcUobn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6/e6GB7U7MQwz+fEX/taOmAQy4NcAJid/Enkzcs/TlUibqwJ
	0o+IrnjLZtPs6yyd9e34UAlrGsU3RnLKXSAT/JQLfBcqf6svXwim
X-Google-Smtp-Source: AGHT+IHJmQOitznYw7nxXig16L2gz0qkKmEqys1jVwJ8LH/stIDVmGhzuz59B5CSI59rRM0lCJakKQ==
X-Received: by 2002:a05:6830:448a:b0:70c:a547:1c3c with SMTP id 46e09a7af769-70cac83c080mr14115806a34.5.1724086126620;
        Mon, 19 Aug 2024 09:48:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:46 -0700 (PDT)
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
Subject: [PATCH V3 05/15] dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
Date: Mon, 19 Aug 2024 11:46:09 -0500
Message-Id: <20240819164619.556309-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
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
 .../x-powers,axp20x-usb-power-supply.yaml     | 69 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 34b7959d6772..9cc300e78f60 100644
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
@@ -31,8 +28,74 @@ properties:
           - const: x-powers,axp803-usb-power-supply
           - const: x-powers,axp813-usb-power-supply
 
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. If omitted, the programmed value from the EFUSE will
+      be used.
 
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
+              - x-powers,axp717-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          description: Maximum input current in increments of 50000 uA.
+          minimum: 100000
+          maximum: 3250000
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


