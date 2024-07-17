Return-Path: <linux-iio+bounces-7662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EA99343D4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF53B214A3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED318E74A;
	Wed, 17 Jul 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdi/cAPk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6A187327;
	Wed, 17 Jul 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251565; cv=none; b=jPAd55oXgEUOxCEgGsmGb4wgAsJeMi7QKvyoflK6AQaEm17uy3nswus0gas7YrUG+zPonM5s0gY+zStLKV7wfeLnAlYJyMMIgfKUZR7IyfcFI2rgzzd4Yz11VdY7qMai46mr2Um6HieST6e9woURHIyM5zt/ri2XwJ+JTSMF4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251565; c=relaxed/simple;
	bh=q0QXKPOoj/Khd748ndxVYRbG9o7mTel+H5n9hSzkqUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmjMMxezocFR98UYwES6pqrkBZX6zGO8EXwZAtRO1wfS8GIBL3PtLeeo01vxFvLxvTsrcU8H3zq1Mg+pGgWLZNz8aE1rPa6S+SpjklYBQDtdZRIaCETJGa9vVoonXWf3ymuB9MDhL/u0nlug1b+mxtCHCMex8P7PID/OJBxw6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdi/cAPk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso953065e9.0;
        Wed, 17 Jul 2024 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251561; x=1721856361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sg8LKJx++D3XfRHX+4zY2+YNwXjqTcalUFZETrZ3jQ=;
        b=Gdi/cAPkixlLPlXvIPZKFxjS46lJUQmz7mjh7sXBQLZiSXr/ilWHU5h8NwDj6Q/mNq
         F2zSbiwT1QEJH+OIXHfoBYtfkG6IdDFERlvqnvQaTGW9cK++tunDnohmST/hgu07y8Ly
         E/Hf9q1O2CVHbELRLvFkvCwQhyaHZzVjce9npBFNZrEU4vU4NIDvulUYzFMcDdAGjE1R
         aS9mJ9Gq7vTpx/8TNIO9WEIR/WpamFRQ1y9Vcm91KV0otMTyq8XFkciI8u3bWudCdlaU
         yNfYKM6RMtuWWv5ZYGr/Kme50/953kX2yU5bsJNuDRCbTQFXJVEDu1hKP0Wt2JDl3NI7
         +1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251561; x=1721856361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sg8LKJx++D3XfRHX+4zY2+YNwXjqTcalUFZETrZ3jQ=;
        b=NFyM0hVze/lXik/gfdkTtuUOH8OQJz/UtQBMq8rStmuCgTIxfqIcBgscY9XaAunLa9
         cDmVrjA5+y2ufXlhUsrvOm6kQALVeFQc+svsZ68TLrQPutooNyF5U7DKs+mMV57prW4R
         tteocpfelHIRrBdJM4ZAqcveXUHSKMutbCf0Bd5TtT1WaoTjIHpJHNhDMSkpO6azLhIT
         IXSEOKkFoTtYeik70hMo90Yt3m6A640maQh3e/HfzLGj7Z1E1ib4KoA70nf6C+F2mXYl
         aAfvqBjjcZ6m4gr30z47GoA87hjRujJTOh6/oKamVuJSpWRfD+VtckgCp2lp72AFNR5n
         WLow==
X-Forwarded-Encrypted: i=1; AJvYcCXBck/8Y87I3+OIOoyzt2i987VwPn5rHuQr4Upy1VBnLsxXv/1FQPuY3RHi4iA6+jdfLBE6mIM0eMfuwI+XqT6Qjvbl3tT9KyblIB50oBHD/72iKLguNvDmt7YD/tnFrxkHkiGl8UVdK2xrxu6Rz+YAcb9b3rGghLZUN3IQ4l6MFLoB6w==
X-Gm-Message-State: AOJu0Yy39ZYrfv1foTdfNnBKRgr82wvdA6DPfEPIK0rT7oENLxCZnjVz
	/xEUyvq9HN8bU3jFpN1aE1yZcAOcYvHTTQl9x2fWK6Fi3HuBPjdV8v3548zE
X-Google-Smtp-Source: AGHT+IH3UgY6jeuxXwJsetVvU8SPN5MVMd+5wsN5vchiFc+o68wYOtFPgyDuRbpyOlYtVUw+z5Wraw==
X-Received: by 2002:a05:600c:1551:b0:426:6960:34b2 with SMTP id 5b1f17b1804b1-427c2d0d613mr17359325e9.33.1721251561244;
        Wed, 17 Jul 2024 14:26:01 -0700 (PDT)
Received: from spiri.. ([86.124.123.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10532735e9.17.2024.07.17.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:26:00 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v7 3/4] dt-bindings: iio: adc: ad7192: Add clock provider
Date: Thu, 18 Jul 2024 00:25:34 +0300
Message-Id: <20240717212535.8348-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717212535.8348-1-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality when clock cells property
is present.

The clock source can be either provided externally or the internal clock
is used. Pair of clocks and clock-names property is mutally exclusive
with #clock-cells property.

Modify second example to showcase the mode where internal clock is used.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index c3adc32684cf..edfa4378e838 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -42,13 +42,19 @@ properties:
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
+    description:
+      If present when internal clock is used, configured as clock provider.
+
   interrupts:
     maxItems: 1
 
@@ -169,6 +175,8 @@ allOf:
       required:
         - clocks
         - clock-names
+      properties:
+        "#clock-cells": false
 
 unevaluatedProperties: false
 
@@ -214,8 +222,7 @@ examples:
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


