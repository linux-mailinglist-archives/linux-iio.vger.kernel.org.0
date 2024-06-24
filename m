Return-Path: <linux-iio+bounces-6807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E1F914B0E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545A71F23D79
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274A13D8A4;
	Mon, 24 Jun 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1jlUWsn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49713D88C;
	Mon, 24 Jun 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233425; cv=none; b=kZwkTvhJTKEx4S18slvCcNfGu3MFE8rdCZg0nWsUXotlquygzVeh5UITYWOlbGujK8n7UPbrrbbXAr4Cl6VIZxxaS17i6fD1mv9zNeV84C/DTrV+mNzCOcVLzz63xBs6VfWuplaQd2tft2ws1XHoTwHM/rbpKniUwa5OcFgbWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233425; c=relaxed/simple;
	bh=0H9fyfW9NOCYnrL8QSS2BFAftR0fN7bCqcOnQZZ2AXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZ3/cp0TMRIVzC/AMfB5M6RENs4/Aoppu9U14wU8apj9Ypz1nz8MliPlLYCfchDruE3ToM7UD5KUz1jMLtUloU8l57VnEuTwBwvNuPnoL0wOT2o/j6bUBZZsPaiqEkEXWarZ9FXt+QWltxYeYvBepYP0VTevkwfgjWcuKVlYk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1jlUWsn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso35694675e9.3;
        Mon, 24 Jun 2024 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233422; x=1719838222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIiqlAHnqSz+73tZxmSi5Ak+gujcl19c0xQyAh4BQmQ=;
        b=M1jlUWsnVV9qQhEOlpz7+2yzw9ZwD/YVGVh1iXjSCeiWe4rUovHy+lxE+8RLw18E1i
         3IUTn2w9q3XyWNBOQbfoZZaFXC3PmJf7FAc9lg8nxN4ISOaUSs5Ob6i/66eM3i6M42Do
         CQXIOJ2i7l08SGhS3pS+k56vQcrnNz8kNqAR4XZG0hP6y/lXXeyGSXzh7LKmEQtjadbh
         aCpJkGb9loL8MBVQ+fBvoDvbuyn+Iazk5/MWRvG6903jpCbxrgvfaOcnwwwL469G3Lhw
         gmhC4SEzwoMnyfw8rr8w+6rfOCezujwu4USyuSEFdFy7QL65x7Co8AF10/9S5OI5LEaE
         vBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233422; x=1719838222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIiqlAHnqSz+73tZxmSi5Ak+gujcl19c0xQyAh4BQmQ=;
        b=IUY4X/Tq01kFDgcaJ8uV/LwqsdzP72xrBoLErdWYjieet2UHwsZQTM7B3FIjVmYvKm
         D3EnwDJfv3Q4SMTueA4NtKncaZ4ie6ucev2ATYJ1pNY82Nm1D+5jyOTK5gbP5YmBJVwX
         oTblb1bicvnI5juo2uNqZ4fJdiSf5oIXFwTWha+2/I8pnoSCE2ptZAlXQ8Ie+AorPdmt
         drdEhibyv2lEuyRH57gG45Pvx2h2SQLuAHUtMEVX3anPpBMbG5v8gnSwQ8m6n7rVisLP
         w00bYnknzhpDGtmPH216mK7Az2qjs8yzYrKycMcBAgd82C75ota5eQhO8iJi9HAK172M
         AAfw==
X-Forwarded-Encrypted: i=1; AJvYcCWQzkcjqD9k2IFNW5YLz0wG+pTOg1zFxic5eP01ym4poESUAvZt728RkTN6gbseuotX2DLry8iURn8AQlKNGUoJwsDvpYpgRfrclPyRaQeAel+Q4l1WFO/EhZbAtem61SDoGP8lK6Qg6qBdH97gbQXbWRBusohpD6KR+prIlRpaKA2lfg==
X-Gm-Message-State: AOJu0Yz6mmEq5+uoybckMD/QuqhXVHX80yxYRlxfavBBCmFXKNK3ZpCB
	0ab8B5soCEXUyBheRfSVqK2yueLMYnbkP+YTAazCJJPiRKSIzwXp
X-Google-Smtp-Source: AGHT+IESqI+fn/Rq+2bR38zM2M2Bc+q1onyg0hmJVt2lop2cE279Qzj3WDUnjIfoZqqJIRqxL2nQPA==
X-Received: by 2002:a05:600c:4656:b0:422:4c42:f804 with SMTP id 5b1f17b1804b1-4248cc2b6c1mr32636015e9.10.1719233422115;
        Mon, 24 Jun 2024 05:50:22 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:21 -0700 (PDT)
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
Subject: [PATCH v6 4/6] dt-bindings: iio: adc: ad7192: Add clock provider
Date: Mon, 24 Jun 2024 15:49:39 +0300
Message-Id: <20240624124941.113010-5-alisa.roman@analog.com>
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

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality.

The clock source can be either provided externally or the internal clock
is used. Pair of clocks and clock-names property is mutally exclusive
with #clock-cells property.

Modify second example to showcase the mode where internal clock is used.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index c3adc32684cf..384bff7e9bb7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -42,13 +42,17 @@ properties:
     description:
       Optionally, either a crystal can be attached externally between MCLK1 and
       MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
-      pin. If absent, internal 4.92MHz clock is used.
+      pin. If absent, internal 4.92MHz clock is used, which can be made
+      available on MCLK2 pin.
 
   clock-names:
     enum:
       - xtal
       - mclk
 
+  "#clock-cells":
+    const: 0
+
   interrupts:
     maxItems: 1
 
@@ -169,6 +173,12 @@ allOf:
       required:
         - clocks
         - clock-names
+  - oneOf:
+      - required:
+          - clocks
+          - clock-names
+      - required:
+          - "#clock-cells"
 
 unevaluatedProperties: false
 
@@ -214,8 +224,7 @@ examples:
             spi-max-frequency = <1000000>;
             spi-cpol;
             spi-cpha;
-            clocks = <&ad7192_mclk>;
-            clock-names = "mclk";
+            #clock-cells = <0>;
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
-- 
2.34.1


