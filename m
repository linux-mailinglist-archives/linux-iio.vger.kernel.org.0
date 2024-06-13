Return-Path: <linux-iio+bounces-6233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CD906B70
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E92BB227BF
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075391442E3;
	Thu, 13 Jun 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK05C206"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF0143C5D;
	Thu, 13 Jun 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278829; cv=none; b=lqTIs8+VczNFJY2tvwNiU3XEM7+V/zba1SE15EpSd5+wCJlJ71wSUsK68amLCiWFtQ9mPx0Cli0saqC+MO8i9TvzMW3Nb3JrlGMXtOZSnRZhHHRLG8LKk+VPraVVFGRDC3livxCFv9mxoHSeIDBZtQ+cZt6woIT9BdVpkg9AB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278829; c=relaxed/simple;
	bh=uVWFVTd5GlpLryYDcJNqq8foua/zB1C1n4jPiPq28Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0xVFPhBsBhCPH/NPDmDqZjOBrDxNBUH4B6z45sr8Au/JkBwEM8fg2hWY6F7eIyds51kvzIiIHqvlu6CNwgDBauNtU0X2ITZIBBaaXSyw/qs/bcgeUdKJZwQS7YwhKTZ6TMD+CtxGwYyvvBYZywUwpldibZpY5lrchGX87Y8V54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK05C206; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6cb130027aso58603166b.2;
        Thu, 13 Jun 2024 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278826; x=1718883626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kywt79nD6WZgV4GUu5mJiQNJMwCwDGOVKWmG5+d2Cp0=;
        b=mK05C206+6h13sZggHZBA323S2jdiEFzy/9P69pzi+iOKNqL/pzICwtGDo2dsJ/yK1
         RzPBBYCKrkMhv1jPMnXAVY6vxbfCAdvxArC9cfueo3qX0ePQxLrZvhdaloxqkDK4Vmqx
         gp8nHmvO4zfdaPVSGbQjdzQL/dlNT3lqve8yFigNt/B2bQG+7MDIQiozaoxDkjbaUoXY
         TBun2VffDshNV0D+xQoDHb4XG989AuZRVqX2pINf49e1/EWoz64vRn6V7JUlJWww20CR
         Hma8J/wm1/M6AA/HTeXt0Rg65rgtixjsiIeMBF99wcuiSly98gnILjzdL4l/gqTwJwPV
         FkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278826; x=1718883626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kywt79nD6WZgV4GUu5mJiQNJMwCwDGOVKWmG5+d2Cp0=;
        b=hwRvWQeqtPHV0XPIpq2K7tR6EYiEDwyy3p24le2a+U1/yZAKbYhy7/X98VBKweDM4R
         HcjNI0OvTUXYXHUIAK7mtyYfWADkezDFiJtU52cZ9AtUl9nGzmKGFk1JcsRzxq7qu85Z
         xmps3fhl9cadNVmoci6zp62lfEHSMrsLG5aglcZK5sSiS67XDKCCJ3VoWiSl7znwKkPl
         NpOLSbdsfI5nmEpAGBeDT103Ou95RK/ai2lwu4os1AE2Hvag0YJeBjiq4xwZCR6A0Ihz
         cGBdm/o2BRdYIE8+cXQ6osOOvQJP3C72qHK5GVNcmwTAo1XVxygPGVzmq3g1cfu0deJH
         P23A==
X-Forwarded-Encrypted: i=1; AJvYcCW/IZCY8teD/zakZyZE6KqC5co8hmS0W65NMHHfvcMgdlLztQRzsUxgn0PlC6C+5u+uZvsI2zIUxrIIWmNFdSwAj/CrzfGD9kY7feLDXLO/eg+CAeBq5U0TdkWvcb2Yog3GfQTGelr4EXFc18hE4C9P2M8hVme7Xv0qe9p/0d4Ql2YidQ==
X-Gm-Message-State: AOJu0Yw0hwT0K4xugzaMSNbUKMEeUyRWt/Yya29e0oNWc9EXo8JIDj/H
	kkTmQk0wRVFYJWsli/b1u3Ol2mGGsIq2iBOvKKc4HLfdIllpE6ElG7Bjbg==
X-Google-Smtp-Source: AGHT+IGYZbqcqg80Z2AmwxGvIFn+fx0fBQmTpuuD9tHuXJ6h/s7KFgIlPuWjrLRs/mJDWQKaHbRKXg==
X-Received: by 2002:aa7:c0d0:0:b0:57c:b810:1062 with SMTP id 4fb4d7f45d1cf-57cb8101283mr1398556a12.13.1718278826363;
        Thu, 13 Jun 2024 04:40:26 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:26 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: iio: adc: ad7192: Update clock config
Date: Thu, 13 Jun 2024 14:39:58 +0300
Message-Id: <20240613114001.270233-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613114001.270233-1-alisa.roman@analog.com>
References: <20240613114001.270233-1-alisa.roman@analog.com>
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

Add clock name xtal alongside mclk. When an external crystal is
attached, xtal should be chosen. When an external clock is used, mclk
should be chosen.

The presence of an external clock source is optional, not required. When
absent, internal clock is used. Modify required property accordingly and
modify second example to showcase this.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..3ae2f860d24c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,15 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: |
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
@@ -202,8 +204,6 @@ examples:
             spi-max-frequency = <1000000>;
             spi-cpol;
             spi-cpha;
-            clocks = <&ad7192_mclk>;
-            clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
-- 
2.34.1


