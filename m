Return-Path: <linux-iio+bounces-10701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3D9A3164
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 01:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24141F21823
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B043DAC0D;
	Thu, 17 Oct 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGmnk25X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03E1DA116;
	Thu, 17 Oct 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207837; cv=none; b=cZvWhMgVFTDQT8UZtZ0/uGnUkh1dXKPJ8/BZu7cVGr7dU0RKPge6EkvBqwNJeh8fkLi7Eenvu2zviwleZaLUvaPw29ExIwnhO/5hhFzQDReLSFD54v3M/V0/lD5HUXIKNkKPqwN4JEQ0q866jmX9TH73jeOKHC6HYUsLG+w7IrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207837; c=relaxed/simple;
	bh=eAY1hTTkc6zB17ODGLsyqWAOg13GMRMk/2LkjykgxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUYmdOuYYjissIYByZ9f9STElhGwu7BlH/F9ILD/FJgHukr68zR6yUGuWSfdcs1n3DUYsF37pPGHj4Btd+pUYyrtCwk14ANy/QPf0cGr+K5aNAa9CzOWUtnJzpzo/YNikH7uGeZwIon+zv0BtYdwzB3AgoMt8GTrTvADy4cO02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGmnk25X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43158625112so13994135e9.3;
        Thu, 17 Oct 2024 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729207834; x=1729812634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIbli1M7hW/BVRSXeIjtcKMrgS5TeW2fN11YEFKx9CU=;
        b=DGmnk25XPYi7xANxyP2DCL5WpNKFg5+UQGuHL48BFDrcGcmZN635Hzo2OFKsAeZ5VM
         3mIDfuy79zEqGwGKjG9bzHb+XQaKuHvaMo39lah5PSnjJyuBoA9YiSWBdd4vvsN9Tzdm
         r9jwPn4xGWg0AWzgS98EzrVkyhpRoJJfZAFrxeVQ5m+a8hVHLqIoERX3W1/obT1EnUEO
         Wi87G/OlizS/9XoZfQlrpS579R42Ci37RzkBs3X+ScUUzWoRtWcFFHkFu/R1/z690yQL
         7PsNOH4uP2YDUNRTdef7iaopllRTvZHylpnwvU72mQ98WQFKRP9smDt0MTye9gt3ocw/
         GV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207834; x=1729812634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIbli1M7hW/BVRSXeIjtcKMrgS5TeW2fN11YEFKx9CU=;
        b=iT4HjQDuIfqoL9YzYV1J1QKLOHYeiWhjILFOZtD6jlJhyH35eP5Mdmkt04XDOD/acW
         H68sN0bbqYD/R51piwu3O8DCvfuZ/XRNUaGztYRmXK2d15UqNY7fJBjoC4+OVE2u+3+3
         1ynwSb9h/EK2waXYa4SgEjSfP7Pz2Jvo21P90ZNYI4SlQraljQOroBPgGEhYwabrSk0m
         3DvFzN+TK6Whvl0EQvzdn0ObTnQwpTTJ53p6osbaxEsZwIAIczUyaByp1VZec4/FiAQk
         56/6+oxLeYoreT+S71g78ZHoADJ4ErEDvVQXCtIZtt426ROBpCHl95fbatEvsU/PVomn
         uITA==
X-Forwarded-Encrypted: i=1; AJvYcCV2+PzJD9pbeCtExs0R3SOduH2PbrTudpp2UmD/JbzkSDrp0d7wwXYWlZbfXLNwzIR1FAhnlvbUUW8f@vger.kernel.org, AJvYcCVV0fg/Cqlxvmu09eKpLnVdmoWs9MPhrbDpvfLECQbJaffGv3k6KanKmzNbhyG9eKvIsbfmTu53iTXrLiUn@vger.kernel.org, AJvYcCWMNmDfPlqlwIq8IAZJUbvZpyA6lDV+Jh2HdJmjW+YBUKChn/RbEbSQOezqU0rDvzrfIN05pumZk6Vo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4C7VDYwjnbxlZvchsi8sd+w2Ul8uVYWS8wcK/DgMXfkwqBQ6
	pl223iX3pkdbls+INYaJoJOmrvzpkRqOw0A8rheq6TEvNvw/pGOR
X-Google-Smtp-Source: AGHT+IGJkALxfsFig24l+iTuar/zke82mzQ6JfVgSsJpPuYgS9NtE77hsCnrs0Q4qc2bqH8io58t8w==
X-Received: by 2002:adf:f988:0:b0:37d:940c:7394 with SMTP id ffacd0b85a97d-37ea2192b67mr268486f8f.32.1729207833545;
        Thu, 17 Oct 2024 16:30:33 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:8661:df0e:b445:43ef])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf06d3casm306939f8f.48.2024.10.17.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 16:30:32 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	ajarizzo@gmail.com,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 2/4] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Fri, 18 Oct 2024 01:30:20 +0200
Message-ID: <20241017233022.238250-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017233022.238250-1-vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
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
2.43.0


