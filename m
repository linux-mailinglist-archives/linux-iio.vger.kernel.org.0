Return-Path: <linux-iio+bounces-9025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613E968DC0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A82283BCC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E552139D4;
	Mon,  2 Sep 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apuVUKnQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714E3B1AC;
	Mon,  2 Sep 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302555; cv=none; b=sOzWWySyUsgrNPWEJi4IzS370i0Zsl9gQsEhPyuuBcUdu+QIDR7+qq9V1LLrgblXn6L/K1cwBEscbRrNThkejRcmwfHaa5MplAI2RRh3y1sv7NHqaHn7yFdxXtWcHY97rTHgd0w7gQvoGLnwmMhWy5Qq8UV0vPu3Zys5oR23f7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302555; c=relaxed/simple;
	bh=GkiarHMmH9pJs7XDXCDb+vBjRm3RV657WRgvnnni5MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckWayYsXhZy512JgkTLK9SWbExinW95N+r80Am/xxlopsKEInnrtlXgk6I27HfL7IUXRS+yXXGyPGkwe/P34tEaqeIb4zXL/s+eis7teoY52ipob+opah8jF6okLyHy6zxORv3rIfQ6WnAuDhiyK/tiBcKx4El1laY02FCLchRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apuVUKnQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-534366c1aa2so4662839e87.1;
        Mon, 02 Sep 2024 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302552; x=1725907352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G8g0J/q8QWuHVcxWZKshG+cNgLOqquv02fgoHW0NJ8=;
        b=apuVUKnQmTDrcchMyRQGdHlRFpA+MTwJ5qYHF6hbHNswscatGjk80dx6PB+LYQ3B3A
         XI9bCRVXxwuC797a3pRMv/SJCY8vV8vLa8ZB9d5+u156x2I0/hCIxAOj+36S05GJ+yAA
         2g+Osfd7rrKIceMBTfTKDRVLgWo0g+VGU5kATmchlBWqeMju2ldfNeYECyqelnw1EA8l
         hD+Eg14a7aLrS+z8sYxzJOMgZarzzfiRhXE3MBq44JWmO0iPEl3f/3WNgieywbltqJSW
         dx+VBQADf6a30fTyyQysgXCmll7O3/TNYcq5TwC3LwxKlXQdRLEBSb4b2eLA69hYkMNx
         +7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302552; x=1725907352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G8g0J/q8QWuHVcxWZKshG+cNgLOqquv02fgoHW0NJ8=;
        b=P86353If1TG0mYp1dDKBvpYw7Bt+ov/zn9bNakSv5dxOR3Dncv48smKJLQtB3A6T3u
         iRY3uu2pitNVQOdARioJbKRD9E6kcKbAymg4kZC/i7m7fwzuyRtQuZV7iPFHAweHe8tP
         7gPB8oN1XTPuVA8+2lvn0qgUlRuBw3cr4fPEPMthzG40I1sBTInHE6xuLyoLI/VSPNtL
         v1Z2lqplzANA+UYvJ+1Vl07eq6R3A6QmlQe1uChKAi76rnSORbB8Q5kyJ1nWbYbhtbxI
         XQR+zwlhwp7RScyWSkDJH0BxWm9cwBe2GhjD9wrQOSgN9D/FuRZIMafRh6deZeIEtRhb
         JvRA==
X-Forwarded-Encrypted: i=1; AJvYcCUFSilZW/plnRqxXjStpcU3dMA3gwkOBzxR8MEDHuWnQp+o/UGR7yHzy+CdwG5mozYGytdigF7nVBqlCLv7@vger.kernel.org, AJvYcCVH94Z8fyR5iM8lhxFIkh/l84RKjS5miJJ8AglYQGc1us1sKCcOQwe1+fSBdZ72Ta70EpE37kzngzRe@vger.kernel.org, AJvYcCVySR6N7KpO2xLCe4GQWXLMCCtIq4RLDN1Z4MQHpDagumU+bMAchStmPJ9FJ4IclPtaSnIAUA7j6doU@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzRTu9MOjVc/o5DgmRb9nAnsTGbc7aH+26gkCjiO1ZuWGhUvw
	stH/hDYdHQ3P8EPYq+ojY7mi81Be4iCag1wFOjEc35aMBEv1qcD+vC/pEn/PuMk=
X-Google-Smtp-Source: AGHT+IGKd75Yg3LvTV2Nt6i0JlpMKC9tZKvwNxsQyYGudmeUw2Qosgc5/N1tCSSunmUmVQ+iaY4ZJw==
X-Received: by 2002:a05:6512:3187:b0:52e:be50:9c66 with SMTP id 2adb3069b0e04-53546b9b710mr5663789e87.53.1725302551122;
        Mon, 02 Sep 2024 11:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:30 -0700 (PDT)
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
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Mon,  2 Sep 2024 20:42:20 +0200
Message-Id: <20240902184222.24874-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..20b75865e02f 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,14 +48,34 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+    type: boolean
+
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
+            enum:
+              - bosch,bmp085
+              - bosch,bmp380
+              - bosch,bmp580
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


