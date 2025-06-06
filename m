Return-Path: <linux-iio+bounces-20268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EEFAD03E1
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780C13B155F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21B42A9E;
	Fri,  6 Jun 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lLtuejX3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AB152E02
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219645; cv=none; b=OagKWSaSAWhyXCFp0qpkP8AVb5kNkcOZMVXz/jdPkuV0E1TX7DUzZU8jmHvow/QXF+lELrysA29XEqJFlfZ/3I9fS/uIam/ZlMuV07Zn6gwKxtVqG03QZ2tuWpVoT5ck/2hTVgr8Xyq1iG/c+JOZF++PVCz0RaPEPmHe2k1sxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219645; c=relaxed/simple;
	bh=NtotUFQE861trIH/6KVUMJlh1RHFkSekY2PpGsDNTzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAK1edw4Pgtahw27Pjar+YTBDOwxLAfuZ9k46N3IjJa3KR7VS78hgzJzb9vd96AV0DlopDDqQtpFIA1dTcogrwT3VxGqW0RC1AbhMBoftM67hPPhKmJWfo54huplAEUS3N2WvxgWzUVvE/iQvEci56gxvr1XP961mkiY71LzUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lLtuejX3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a52874d593so1959569f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749219642; x=1749824442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=lLtuejX3slvpCHU5i4svKXMgnvnLvKMSNrDwTfrfZr4seE5NN7DXsUvdXy8mAhg8zc
         vLxQ5Z+RK7lcPCEH84kmRBoq1WU9PJHqXpVZVTqAAnGeb+Obw5hmv22WqkFDvfA3UtNh
         +0xUY1Lxb1DWn4INjEkWAWYmkh5LF5BqaeUMGrH2tgaLfnEA1qoMIv6jszDUagmREmWp
         BZ9ypARgXCHZ/5U2CMMJqRg8fXliJaMI+vMnAjwa1oo3r2ra7x+q5AlsCrVYF0venqFi
         jW5Plgraw/5hXShlLZ0Zhjm4kBFG6psp6PxVhpn7RrfTcJcgDwfamj+FMtI+viXtjwsA
         llmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219642; x=1749824442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=Z0qFrhNwxDyqDHmci1Hbc0RB8iAP48YpiCqQ5lXR2m/AndYKwGM83xRdboVzReguJ+
         2wmBnAadDQcGsVSvT0wE73pQ8E4cV1Lp4/6AaoY4QCQ+iNesDqedvWk4fd9mATK0GEtj
         gz2Kw1KSQyw+oRHhBQts1siKD/DPcP3TnhwbikaWNbwWAQ/JKYF6XVUJ+QzFx4/kV/JQ
         rGIsHJBKYOCVLY8lG68ahwTl3t8M/gAwW1fJa/RD7Ru9HcutwWPkGkA9NOjDDwcWYNMW
         Sz0dMR5D2kgqhiqbNf3LJsyAUR9q/xwWuBfzIDXLYHgm/pByaPCWqGBsuvAWmAAhmHVl
         kxvQ==
X-Gm-Message-State: AOJu0YwoRivIjHd2aHA3XYqw5Zsp7t+kB8JGOPNSTwexmKasrBkncI4g
	F/q39WK/YxUXrXM2WwqiBLoPGMWalN6g0zEcDPDIyLw6rPx8kEQrz35Ohz0tZG1lRDw=
X-Gm-Gg: ASbGncubQ4QorYHFgh4UAP5mnmqYtgt4lyyMhle6a01VzQ512Vgy5tIbgZsU7hIgDo/
	au63fKU7lKeIB6H9dbKGIcYZsNVrhAbo8i1jynQB7koGupFhlQV30HLNcFi27oLORXs/otgKV7A
	kBOG62suK04zePFWIvHN2j72f97SNrPFym3auTMnlPkzTEop047TtQQSBz+/JlcN1EoYBMDfI7h
	NC0wnOoDY16FpUfxgmWGUUBWFMLRlSlO4UD2gMbHrgcjm9P/SROzb4S05GY3qKLjnQR6cXNuAlN
	52FMMYqyYcUwgcS/DztiE62xMofRggzmI1ufcruCYsxQ397gtrXzrEjC5CvKzLrY6sVjGeM9RSD
	94FkQiuGGA5xu7WQ18hLF4jr33ANCVOlNahf6WIeAsg==
X-Google-Smtp-Source: AGHT+IEPSADRuivjsBAwnxDwELX3J0cYKMrPAlNjoba2OLvJNlyJgJfrVNB7PQfFuEos6eyJm7zU2g==
X-Received: by 2002:a05:6000:22c4:b0:3a5:2f23:3789 with SMTP id ffacd0b85a97d-3a53188d5cfmr2988081f8f.15.1749219641589;
        Fri, 06 Jun 2025 07:20:41 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm25686345e9.35.2025.06.06.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:41 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 06 Jun 2025 16:19:19 +0200
Subject: [PATCH v9 4/7] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-wip-bl-ad7606-calibration-v9-4-6e014a1f92a2@baylibre.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
In-Reply-To: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=mK1GoQiX2hS20/yC/1czrPjfc5t1uAwSltJDkMx72Mc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshw+vGszPKRm63gXMlsYU25p/+9pCYJzNvw3ZXJrWmy5
 gVJ5oV7O0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAEzE6jbDf8cJPqdERXo7/dob
 1gZM6W+U/um4QMru1QcHV5v1Fr//xwJVuF/PW/jn7zF1he36bNKT+jU05/3ebmv1ZN1pB4UAVQ4
 eAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support by a per-channel resistor value.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 29f12d650442b8ff2eb455306ce59a0e87867ddd..6926f5f090ad6bbbe7bfd9327dc5ae17dafcd1fd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -204,6 +204,15 @@ patternProperties:
           considered a bipolar differential channel. Otherwise it is bipolar
           single-ended.
 
+      adi,rfilter-ohms:
+        description:
+          For ADCs that supports gain calibration, this property must be set to
+          the value of the external RFilter resistor. Proper gain error
+          correction is applied based on this value.
+        default: 0
+        minimum: 0
+        maximum: 64512
+
     required:
       - reg
       - bipolar
@@ -256,6 +265,25 @@ allOf:
       properties:
         adi,oversampling-ratio-gpios: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
+              - adi,ad7616
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            adi,rfilter-ohms: false
+
   - if:
       properties:
         compatible:
@@ -398,6 +426,7 @@ examples:
                 reg = <8>;
                 diff-channels = <8 8>;
                 bipolar;
+                adi,rfilter-ohms = <2048>;
             };
 
         };

-- 
2.49.0


