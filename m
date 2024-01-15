Return-Path: <linux-iio+bounces-1681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33DD82DA18
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932C3280F77
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228E17551;
	Mon, 15 Jan 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJXBERWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F8171A2;
	Mon, 15 Jan 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3376d424a79so6747268f8f.1;
        Mon, 15 Jan 2024 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705325428; x=1705930228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eupg5ox+rYZJyukr/GeAxFlDga4wcn8HAieRx2GbhsQ=;
        b=ZJXBERWnQm/s2VJRCh0PDVlEEkiQ7msPJhnrYUzfC4RlLr79nR0zWJldQhyljIEEwO
         PPWDLBwdN5uQnZ9D1f8tgFSN//F5uVFczmLSUzA9bb2XOSxAMi7qcy+jEK+//bZOi8Pl
         UuY74quWuSp1yDGH0lxMU60vUGGsYmQ5zts2ZZoTbRFG/lFm3DHlQo6lLpV2lowSjpXi
         11ilR3PGKpCmCA6C2iAJfGaz6KX3S4qtwomSDU9tK82SXGZAkP5Gv8hjxYfcYOTk1KBf
         2TKUzYvLIhu1Ym1vvtcPl1QhUVzMSEHwRmnLNy+u/TSoalArdef2zXvNN9o0zQkDmCmr
         qWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325428; x=1705930228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eupg5ox+rYZJyukr/GeAxFlDga4wcn8HAieRx2GbhsQ=;
        b=kmTRmL0eSXk2YmIix2GuHPzvoE8SkGZ/7dUI/VN0uZ7QnLitVySsvk+PIwHWFk4gZa
         VN0xBLG0HSpWWHr77An4dYL26vCvLXT/8aJeryY8NjOE+6nYGGMcJebDJJEw3qXbAVvg
         ID189si0CdD3Q7h0BjFl3p57w4Wd13G+43CbbcBN9kuYuWc3FZvHSGhf08YPUI7TYZ8f
         +Nb1XgSoFplu00CvJl7NdiwGExrX1x3RqdQkbTFzYyijC/6SsakFm/l/nle5oyopcXTQ
         1CsOdbBtmZtVI++osKJ61RXz0S1df1DNgS4QhTOpGoHXZ6yGA5O0tEcUaEzRzP3FhcQ/
         Fa7Q==
X-Gm-Message-State: AOJu0YwjHIzOCy67/EUbev3k6QOWzNLwksCCOqY5gVD162QvT91cx4vf
	3ofh+33mp8evQs9FbVTC3oQ=
X-Google-Smtp-Source: AGHT+IG1CZy93+shcO6ywzZ841ZwjggUltnDwmHvUMtbSfFmqYLRLdazEM8RtByIuPaq1HLlPHzG5g==
X-Received: by 2002:adf:fa0e:0:b0:336:7794:4b9a with SMTP id m14-20020adffa0e000000b0033677944b9amr2991392wrr.33.1705325428223;
        Mon, 15 Jan 2024 05:30:28 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b003378d89737fsm11566669wre.46.2024.01.15.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:30:27 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/5] dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
Date: Mon, 15 Jan 2024 15:30:14 +0200
Message-ID: <20240115133023.3465-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115133023.3465-1-mitrutzceclan@gmail.com>
References: <20240115133023.3465-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADRF5740 and HMC540S have a 4 bit parallel interface.
Update ctr-gpios description and min/maxItems values depending on the
matched compatible to correctly reflect the hardware properties.

Fixes: 79f2ff6461e7 ("dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator")
Fixes: 20f87a9a26be ("dt-bindings: iio: hmc425a: add entry for HMC540S")

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 67de9d4e3a1d..a434cb8ddcc9 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -33,11 +33,38 @@ properties:
 
   ctrl-gpios:
     description:
-      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
-      connected to the control pins V1-V6.
-    minItems: 6
+      Must contain an array of GPIO specifiers, referring to the GPIO pins
+      connected to the control pins.
+        ADRF5740  - 4 GPIO connected to D2-D5
+        HMC540S   - 4 GPIO connected to V1-V4
+        HMC425A   - 6 GPIO connected to V1-V6
+    minItems: 1
     maxItems: 6
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,hmc425a
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 6
+          maxItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,adrf5740
+              - const: adi,hmc540s
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 4
+          maxItems: 4
+
 required:
   - compatible
   - ctrl-gpios
-- 
2.42.0


