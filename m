Return-Path: <linux-iio+bounces-13149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695D9E6D18
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C616929B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56D204095;
	Fri,  6 Dec 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RxSNxfTk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F84202F7A
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483659; cv=none; b=d/kpf9SjLai4SnNoeZCIO6UY0nHhLXGlysFhYRdibjOhdcKHoTjnEe8qN5ChMM90ucXQ9ygSrfUaV/zcfVn1huAm7UyWajx1rvJCjlHg+6vIRgbOAZajW2n0NZKlcOdt+M/qSO0rM0cocBcEp1heiOf9KxBlfMVCteZPTfexXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483659; c=relaxed/simple;
	bh=yHXEczmr3zgBN9Y5LQq53zyVDIkVuwqZazKuyqw+yEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ait6YAQpAnovi40iuQgU1mOUMrUD3WS0MM7D2f2v7v9Bvw1Z5+Jc6rR5qXLJwcwFhW+EbHAkVv1x+WrTx57WObS6XB41dYA4P7Zg9hSKXQf7YTxlZ7PeXJz7RB7PIhqh3+pxF0fPDfRqpKCVVCCuppEDpa25emHGDGPokwqBMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RxSNxfTk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso221722766b.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483655; x=1734088455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztquiO5zqo8/ypj6kpM7FV/n638PGdmNV83SwxwWZys=;
        b=RxSNxfTkdhKEMGKm1wiBlmyaeKNCwrVugZWsDZ8efNvBqvnpEiTOVOQY0zoKqVUspG
         pgEmNRfFfZQx20TO5Sk4w6ECbuKTUtLzWP+hwITACcHbvH8rPj6DpQ3UnYXdI+o5b7i3
         DHS5Ad/SxxExKECRJoq2hyGX+HOw3FXbJNiYGTSH+y/8Yua2nNcxVu0I/u4nVLkQiF2K
         y9pNfhZvB5avNXkVneN5RWM4ypD3aIRDIJm1nX2KHYal5GCjWTn5rCboa5HquZ3sZkRC
         ORekgKAQd6oSVSzarRQpCLs74579Pylv1tLDYrYG8aNbi9o4S2NIK4MKQnD2DN9GxYfv
         cS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483655; x=1734088455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztquiO5zqo8/ypj6kpM7FV/n638PGdmNV83SwxwWZys=;
        b=p4Uci8BRgwiYymDF/5BJPnu5LnxWIH3Ao3rkwodOs2/9yXZB9p69Dussw3BV4vuG+o
         PbAGEhtEqKThtN3vRILJ2eIexmsdzE3mv2YQv8EEJM7cd0lzEcr/6FcXDY3WjeoPbxUP
         Z+YM8WbIhMGSojwiNa4iJNf8Yxv0itlgwvKcilqE2Q7kfgSQ4fupsFiJHd0qn8wsbQ2K
         iSLJjdl7j48yiFfxk055w+T6/o4cWP1R9AFkkxHs/uT3OFT/gdib7uYQdyXB8Gl3SegP
         1nW6mqcjyzqhW8iZE2L6ZP2GppuiQ2D7Tl2g1p7jEnz9Dbfenj4f70mq8NC8X0+NkfOx
         piQA==
X-Forwarded-Encrypted: i=1; AJvYcCWm7X3Vit5AJxvIB7NqAMwV+8J0HL2+6dedEGAgqQMuAewHxdvotXEnXvBPgxP+9S4ttoIketwzJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdWyJpnpVUp80DjtDhxEuntSOSBisXIPsgO/rYLdWhg+8dY6w
	V6RHmYRGpqTPgjWG95oIWJV3OZlM4WtFRprrT0y10plNZ4PufwT30rFHfBav/pA=
X-Gm-Gg: ASbGncsy7GcILcDrTPAmbga8KPAp+NcSsmBQfxEF+chm6jDOGnMRdlOu9TXz9W1KtjH
	QXkd607W94z5S6aD9ki9dMJA70e6PIxF4UfPbfDrLSxPs/wet4DC/CDEPQhTc8zTowUQVc7fmax
	2pbqsdEDlr+D29kP4ZDkpwraznm4c7jqvxv381uxqbnD9d5zdMrA2YdDVjQn47ht3XivoPi2AwH
	q1rkgrD78bEH588XurETAq2oYw+6w1VBvOXMAd7/sPf/umexJfCu9SFyLn3edwJfi5exz9roHru
	KM1yDmAI
X-Google-Smtp-Source: AGHT+IEvXec05NePap0xg2+L8yTjn/PbPq51j1Lf2h7n3v46RbGZ/jBjPtqf7h5Sg7tKTHnIWh1xJA==
X-Received: by 2002:a17:906:30cc:b0:aa6:2018:8741 with SMTP id a640c23a62f3a-aa639fa2ce9mr196485666b.7.1733483655271;
        Fri, 06 Dec 2024 03:14:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 12/15] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
Date: Fri,  6 Dec 2024 13:13:34 +0200
Message-Id: <20241206111337.726244-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document the ADC IP available on the RZ/G3S SoC. The ADC IP on the RZ/G3S
differs slightly from the one found on the RZ/G2L. The identified
differences are as follows:
- different number of channels (one being used for temperature conversion);
  consequently, various registers differ; the temperature channel
  support was not available for the RZ/G2L variant; the #io-channel-cells
  property was added to be able to request the temperature channel from
  the thermal driver
- different default sampling periods
- the RZ/G3S variant lacks the ADVIC register.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 37 +++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index ba86c7b7d622..40341d541726 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -17,12 +17,15 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-adc   # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-adc   # RZ/G2L
-          - renesas,r9a07g054-adc   # RZ/V2L
-      - const: renesas,rzg2l-adc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-adc   # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-adc   # RZ/G2L
+              - renesas,r9a07g054-adc   # RZ/V2L
+          - const: renesas,rzg2l-adc
+      - items:
+          - const: renesas,r9a08g045-adc  # RZ/G3S
 
   reg:
     maxItems: 1
@@ -57,6 +60,9 @@ properties:
   '#size-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 1
+
 required:
   - compatible
   - reg
@@ -68,7 +74,7 @@ required:
   - reset-names
 
 patternProperties:
-  "^channel@[0-7]$":
+  "^channel@[0-8]$":
     $ref: adc.yaml
     type: object
     description: |
@@ -78,6 +84,8 @@ patternProperties:
       reg:
         description: |
           The channel number.
+        minimum: 0
+        maximum: 8
 
     required:
       - reg
@@ -92,18 +100,25 @@ allOf:
             const: renesas,r9a07g043-adc
     then:
       patternProperties:
-        "^channel@[2-7]$": false
+        "^channel@[2-8]$": false
         "^channel@[0-1]$":
           properties:
             reg:
-              minimum: 0
               maximum: 1
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g044-adc
+              - renesas,r9a07g054-adc
+    then:
       patternProperties:
+        "^channel@[8]$": false
         "^channel@[0-7]$":
           properties:
             reg:
-              minimum: 0
               maximum: 7
 
 additionalProperties: false
-- 
2.39.2


