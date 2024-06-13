Return-Path: <linux-iio+bounces-6235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D8906B76
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14CC1F20F51
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539301448E9;
	Thu, 13 Jun 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdN4FX8x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772ED1448C4;
	Thu, 13 Jun 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278835; cv=none; b=mFJp0gyQK9b9pGsYoR04r9exlLI9Ty9teoxt2tGS+xBT9+G0goHge5vR3rtk3JSc4oSy2OaKs9d1yO3w7qCeXY2LhR2ciESQBvsR1A29dJTLAZlin1J+6Mxg4C+oLc4Cfhl0mMi4En1qxjETPlY980FGo9UOpt4XBw5uiivjbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278835; c=relaxed/simple;
	bh=cBl6lm+uYbXycFH/fNn9g1k1ZCbHQsZa5Ds/HHzsWHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mX1HVH331qrqtqC8aS0Xy364XsTEO7rjfWouve4ZrTO0ItfXxp7BuvlHJUMR/rZ0aLhVur7E6qj4op0e6V0D9Au/LNTZ2qBMCHYFsWP2M9YpNf+ca3/EIfLP/zW5Fj+n9khvx98km3FwLjC+KB7QEfXBMl9uQwGT219Zm+Zdk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdN4FX8x; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so979217a12.0;
        Thu, 13 Jun 2024 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278831; x=1718883631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBYQeN03yapNF7PDiSvVH0IbdjyeSyAKmDjAtrb1ifA=;
        b=VdN4FX8xx0IXyyV38guVJ9T07FloRDofwK4mshPTWNEyGP0eVDLg4w8/ATHWqaGJdH
         rBY0med6UUXJwGRhc+5zdAO3ZY5yIyuzSYk+4qtJynTSTRCkGUSyPxAk7uFIsbfq1QdU
         d7G2lM2V6R7xesNfO3Ss3uSD+sG4uVh754G89KDuOFSPxeibliy23NNyjQQgMLO1BtgI
         VKlFxW66HG9mwFzJDtxaD1eTXqdwagzLNCzAdOcQHrRM+sz0pmDpQOTYmHi00b2L62qe
         QDEwkR3P6R27zKoilS0wAElSwWAClx1t6z3JIBXy2/m1Inxaq9Vu7xTX+1euVuynIWoZ
         dKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278831; x=1718883631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBYQeN03yapNF7PDiSvVH0IbdjyeSyAKmDjAtrb1ifA=;
        b=tVQapYz7otsLJOQx6RElhppUy4Fbzm8H3gE6aBAf0SugxfYYhvApE1s+/SX84Hmoei
         wB4207y1HTjfWo/vK/EC+b8B06NelQeibRS9FIkmsWknpJucJi3OkQfYTq9UKPfaRQtP
         cHL0ZuDGHJdnqWmkaDW68WlNF/p4wd7uo/ZWLmnTSwH7AJfdhFGVyhnx6BuxABmX1zNh
         GbFmgk1XBwI/ozwcF1XFAmRgSXeFSlj0uZjEC6uUVo48/sNYWxZ5WqEoNbo8II0np0Ef
         RbrjtpSdUN6+XuLqr0SWz1p891gvWXdBmU7wVr+GzDwgjUR/FjfrQ7n7Hi5gJswm8Rrz
         l5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvkylFUx6QD5M0wq4mAiL+/yu1qOdRooIWK6DVsMDX5doC27rsI+8l/Qi9dYy+OlvhBexF2gAY5fmRRe3aubs75/TzD9K1zyBmKnll/DizNeCl3Exd4rMafWn+RDsKQxpRIOryx2JSPeuNKdi2VIjTY2z5Hnl1fLr4CTXYXxfFq7xdUA==
X-Gm-Message-State: AOJu0Yyquim/eGYMIdoZgMGS0i3V4iRfoALZNxr2k0Cw3yGltz85TPcS
	AcaswuOHk1uK/ZkfbEmLofRx+ELrnzS/3vRfT0n9nJJqA5WNa5NA
X-Google-Smtp-Source: AGHT+IE2HoHXEo7lO6gI7UF31Rr+8LP/l529r/bkkfSxGQb7y2Z1JHqjA006Y2tBAHIBmW6TyHgI/g==
X-Received: by 2002:a50:d654:0:b0:57c:6bd6:d8e5 with SMTP id 4fb4d7f45d1cf-57ca9756c4dmr2950959a12.8.1718278830658;
        Thu, 13 Jun 2024 04:40:30 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:30 -0700 (PDT)
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
Subject: [PATCH v4 4/5] dt-bindings: iio: adc: ad7192: Add clock provider
Date: Thu, 13 Jun 2024 14:40:00 +0300
Message-Id: <20240613114001.270233-5-alisa.roman@analog.com>
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

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 3ae2f860d24c..1434d89c2880 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -42,13 +42,20 @@ properties:
     description: |
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
+  clock-output-names:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
@@ -204,6 +211,8 @@ examples:
             spi-max-frequency = <1000000>;
             spi-cpol;
             spi-cpha;
+            #clock-cells = <0>;
+            clock-output-names = "ad7194_mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             aincom-supply = <&aincom>;
-- 
2.34.1


