Return-Path: <linux-iio+bounces-6805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E21914B09
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71891C22C74
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66BD13C9D5;
	Mon, 24 Jun 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9lK34yC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178BD13CFB6;
	Mon, 24 Jun 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233417; cv=none; b=QDdM553EaqNDavmV/9pUeBFGJWGz7LXSNwjK1hZieMStfodL4nbMymENUveDoVIDWUCyrSXsoPZU18ALXJUc8RFBsMTKzj2jwYAPm3tjRgcxvn3Kkhijt09cijzxyJbz1vsTEEyohqKMX1ZIkUJompy8u1FYqXSUO8dRseK13Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233417; c=relaxed/simple;
	bh=Bu8F+l13HHuz2d/P/HSpMq3O34R6YheN5LcYoDmAWDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7JEn2ZfUStAUFkNd7j2EUvj7bBysUdEJf0Vrw9Ww4/iRtHMnSp8poxp+pt+nhgNilOUSUKATgXQTKvvJHKMCaI9bfsXx6GW7zLz1F92BWZqrelxesq/1tmfxJqZ6ysIalMVWLh16x/4caukALKxXCHUQ4KDXGA44Xs2ZfagGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9lK34yC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so3283328f8f.0;
        Mon, 24 Jun 2024 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233414; x=1719838214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOfPkYxWy6ZUkypcBlYLtOXF3/JTIBRyQPldNQhVo1E=;
        b=T9lK34yC0l0GIYxSHmIyH9J9UY1MfVD7GDwa664rK1iKiEYYPSmlDu5PYI2jatQX+F
         2Tm0HfcZeyPjC05w2dEVUMWemETZvxIVCDPTI6l/neAHKSkTglfrrtluiVsJAMO6H375
         svKZ+1kiwYLwJHobHLG3MXCf/UQSbvCLv3WIXxqOhdXMGd9aXW3FugtAAsGN4d4IVBCg
         3VuDXT0PTxowaRVeoEUUnSpWIDY8PuSvcrwxEdXxJZLHMG0as0CB2E/J5PZHdbaqGQUx
         oGBU7poJ7hqO3+JGrNjMAy5XnSPTgFMTL9o7aHLRCo+SucsAvRaXFq8SFC17yYK1vqYt
         TS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233414; x=1719838214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOfPkYxWy6ZUkypcBlYLtOXF3/JTIBRyQPldNQhVo1E=;
        b=l2QlDWe22o9eCDw1jq3DSXT2r0YKuw0V1Oh2l/gLME75sKTA6LLbvWNYh3Wh548H7c
         BltSbp2EcQm9SpMpFZcJv9pIO4wb4hgno1OinGnsI7UFbwvcUPhW4VlhHhCUeHFCcrFi
         nT7+TrgB2Hs9QQ7RW11+Dj9ifxVAYqE1g+uU6o5psvDf4dAsCXw+QwV8LO+hRwk5pGzy
         xbR6UIGrfbFwZIio6ZRc0uGGgg0ztEcXXEygfE20LqfzRGkqD3Pr2fUbX1PXUpeeyMHK
         /h07u6OmdrzBUR8/5+JqpEFl0HqdwSJIQjIehOY4qu3nK2SG4iWVnRlRO94bDxnrYPA6
         /DYg==
X-Forwarded-Encrypted: i=1; AJvYcCXMimQIsdsVnXzQC/Ll0wMTubJswBmynWFE02ixSsPBNpCjZCaUWdP0vx0FNlknyUZw+wokPvjEFKNF3yssfWPxV+socIL2d2RghKg62pIou4Im900c8uR67XGfbZuy6Fpw+YdHO4QU7z9FdvUcpipLZqipf7vcm3pk8A0fosKQCL4uOA==
X-Gm-Message-State: AOJu0YwiD0NmFUqBRL8ZoN350Jof0MUiJWOsKQHJSzVjjipkeWVxzk4P
	Im/RHNb2XyahjFrihLYL4bd64miZtUptMvRD80t73vULrt7KTJ9jpJ8zew==
X-Google-Smtp-Source: AGHT+IHvUlvMMpqCEaRYN3JwnyLslaAEjgabuVMm5es0bzJddB74tXWAgN4rN/dnc8cC0vnt6mNN+Q==
X-Received: by 2002:adf:f68c:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-366e3293282mr4456753f8f.17.1719233414097;
        Mon, 24 Jun 2024 05:50:14 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:13 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 2/6] dt-bindings: iio: adc: ad7192: Update clock config
Date: Mon, 24 Jun 2024 15:49:37 +0300
Message-Id: <20240624124941.113010-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624124941.113010-1-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock.

To configure external clock as either a crystal or a CMOS-compatible
clock, changing the register settings is necessary. Therefore, add clock
name xtal alongside mclk. By selecting one or the other, the register is
configured.

The presence of an external clock source is optional, not required. When
both clocks and clock-names properties are present, an external clock
source is used. If the intention is to use the internal clock, both
properties should be absent. Modify required properties accordingly.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..c3adc32684cf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,15 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description:
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
 
   clock-names:
-    items:
-      - const: mclk
+    enum:
+      - xtal
+      - mclk
 
   interrupts:
     maxItems: 1
@@ -135,8 +139,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
@@ -157,6 +159,16 @@ allOf:
     then:
       patternProperties:
         "^channel@[0-9a-f]+$": false
+  - if:
+      anyOf:
+        - required:
+            - clocks
+        - required:
+            - clock-names
+    then:
+      required:
+        - clocks
+        - clock-names
 
 unevaluatedProperties: false
 
-- 
2.34.1


