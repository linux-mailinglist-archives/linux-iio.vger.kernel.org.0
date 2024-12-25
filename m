Return-Path: <linux-iio+bounces-13799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F839FC641
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DF1162BA7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159C1C54B0;
	Wed, 25 Dec 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyqG/I0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2D1C460B;
	Wed, 25 Dec 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150435; cv=none; b=bgkHmabptVg9MUFz5Fge+KojXIeeujYE1Pgk6/yp8RNuIq292wZlLi8VDHHgWogqslyuZcHg+/z7fQ/3geUzX/XGaQKy6/92tDMj8psTtlBj8ZGTdIkZ0YspvIhUCRdPrp3zrUxGHZz/NEQYVgdgPmjcD3o+alBiqiks6POp8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150435; c=relaxed/simple;
	bh=ggdrW/BTcLogCPS2mh2i3gna8+7b4XdfkZbjCw7lz6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGMk4NDxPGO6xVe4PveQzerg6+dsqk6R78JxjW31y+j7IBFIEe6aMiDn4USjVXOi+833BiHCnBM/vfqx47+bYbre/MPWyV96dUVBi3tRDpKj6j2FWvKvVn7XVKaKwUaQpFuUKPOc1dxtiO8L20a188BP4YBUaOZMC+aZTvQwxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyqG/I0Q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6a47a3da3so118299966b.1;
        Wed, 25 Dec 2024 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150432; x=1735755232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYDrZiVle4k+26gWV15uDrwllCdtK3uFZaGukHuklik=;
        b=PyqG/I0Qr+TZGA05pQOIEiaTroX8mLLegcenfeCfrqO7exQEbSwnAt9k0+UfZ1R2CH
         RWO+oR2X6UeBRMJEckO+8y6Z48KVbilcER2goFb/VUQ2Qh9a1xXaBonocrtb5foVGUuy
         12agkrDuAqTyqMx9L+60WH0YW7sMxgSOy/IGKjRTVjRwq6tc8/o867MkeZ6/ch40lJAs
         SV8u7CSBLFv2FZpUC4Wv19vdh1qWWeyAKofDr+bJOMFOqGP4zkfky7lIcuVmTWjB1U48
         4FxjUSpSae4u4k58yFlbjiyev70WK6nRPdYDVITItniBFChF0R/F4P12qid80qQxQGQN
         osqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150432; x=1735755232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYDrZiVle4k+26gWV15uDrwllCdtK3uFZaGukHuklik=;
        b=CLgn9rfZn+/KWLTbkpTXN48MXweUkLJZj/SpFUpInElv9ZI97dForbA51mfBUQ3pj5
         3GC/kp1UCq/4SZqD148mVVG1jPwkeZHk+TDbpT+8+G00t2jTp5LXUQ4UiE81GbDmlAxO
         sssCBlDcA0XS5iV5yxF5cuwVxns3wH6uREnPiisFi9XnPgDzNYarnmfl0mvVwFf281JU
         p7bKjGoGHFkrmpUcL6KJJtrioLmo3BWBBeEIJVlrcCP3ec+yqYNYc/442vcMVck2obVF
         dYLVJW2X6TX7HfOc6btFQ7fRzBIrGKdlv3jR9hHjCaPMCUKKpUxGLDKPJFiUMUb0FX/C
         wFAA==
X-Forwarded-Encrypted: i=1; AJvYcCWj5HX03QQq1oHKH5rmdyHb2Z2ZuOvv/mdRBWwioYjAmzvI6exj+cL/8RX6xHlH8b7E80PnIZJb8XwP+DiF@vger.kernel.org, AJvYcCWvnt9PNCWBxJeEON/5qQfdWGnlZ+gzIEc+gkEPQhy280SpmLvSsPH7iyG7O/99LBXjkk9i1wMabSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVduwNhGmU4OIKSEqgb76ecGG0P+43Q1yxBEgmPQNsDFc13KUx
	Ib/jjDcdXWcBHHWBYB1YlRFCVtp4NtGPey7LPfSPUk7fGTH0iwkI
X-Gm-Gg: ASbGncthJZTWTlT6c5ozbUkFdYzy460xqzHdX9XFbb8/WN+ZPKpGC5mxKUkfwu4AZYE
	2h1IP5fnBLpc+/2NPWyDN4sZyU+bDHGvghGzracZW4SFyCqNwJlAdp0Yow0h+crgdiprPT6g8Fy
	homUDjVw69dtwUWokdqr94HWdOOJDYvS+6qBtWocULGf0XH6Y8fGOC+BoDrDpY2NgOyYRhcMoMQ
	vmx4HjF6tfKmt9b5cPlYk/4gn0/fQlDJf2A81IABQ6lAKH9Rvu4BuOIYLpNdR/aNVdDisG8NwwS
	UP7cRWYJwwy3NM4B9TtOgpFSOCo2tCZO6xc=
X-Google-Smtp-Source: AGHT+IHRyY6uaLLGd97ERIYdcLr+jR5gBisEWLT7NW4xPVidPjix8m9NnTlWJib8hWgSUBpzMDy5ug==
X-Received: by 2002:a05:6402:13c7:b0:5d3:ba42:e9f8 with SMTP id 4fb4d7f45d1cf-5d81ddf80bcmr5435836a12.7.1735150431509;
        Wed, 25 Dec 2024 10:13:51 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:50 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 3/7] dt-bindings: iio: accel: adxl345: add interrupt-names
Date: Wed, 25 Dec 2024 18:13:34 +0000
Message-Id: <20241225181338.69672-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241225181338.69672-1-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt-names INT1 and INT2 for the two interrupt lines of the
sensor.

When one of the two interrupt lines is connected, the interrupt as its
interrupt-name, need to be declared in the devicetree. The driver then
configures the sensor to indicate its events on either INT1 or INT2.

If no interrupt is configured, then no interrupt-name should be
configured, and vice versa. In this case the sensor runs in FIFO BYPASS
mode. This allows sensor measurements, but none of the sensor events.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index bc46ed00f..84d949392 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    items:
+      - enum: [INT1, INT2]
+
+dependencies:
+  interrupts: [ interrupt-names ]
+  interrupt-names: [ interrupts ]
+
 required:
   - compatible
   - reg
@@ -60,6 +68,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -78,5 +87,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.5


