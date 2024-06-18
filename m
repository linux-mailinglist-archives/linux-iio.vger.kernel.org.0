Return-Path: <linux-iio+bounces-6505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC290D584
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AC41C2531E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48257160792;
	Tue, 18 Jun 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBmWFQhf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F315ECD3;
	Tue, 18 Jun 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720537; cv=none; b=XgtC9m4VlpttIRnotB9yn/9Diw5RnvwEoUQgLbjmKHgGSwQVbhUuWS3Rb4o6RIB0AxGT27fphiatc2TH7pXFpBGUalF/iQzdMe7DUehDirss0rcRXWiBtUMBx0j5Swgy54L6C+5oUmCJESf9XApjyOW+VoQ1jRbK49sRmlBzbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720537; c=relaxed/simple;
	bh=cILECnWkmUvZQ7aIlxgrr2AKE9gRmIy6LhC1B0JjF2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaXc2bM2h9I4ALy81YcTTHzXOrvF0qVVXwr/Lv5PkF8on8LcFM+kr3eZHF1cdmBQvVUTii+U8s6XPDfAwym5ovKAixRvLfiKivtOPYL4uQnXcR85C4lTTvEwHGfNHjmVLfD6jMcyQBzR/FpDeRboo8b5LGdb1p9vZQ12FE+ZRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBmWFQhf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6ef46d25efso679615066b.0;
        Tue, 18 Jun 2024 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720534; x=1719325334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fLaikDiWkU5fRRAnenW6x2jVX2BzyMP33lNNvt71c4=;
        b=fBmWFQhfJwzLxTCDzwN3GkCu+CSEY3+Gy+MGELbxqKFymtp8UnFQkmfTaAxavGAycl
         30cwcLXpC9fNjwjFBg3SH+bFfq9GyM1cSnqa2rscZeeC62wCid8zotdg5gODMTTEq0na
         WD8+rboNerVn3ZgXkYzZrssHKNUD7PJKxNSC7FD0QHOcBxu0UfrMSI31QCl8A8sKGOA+
         ub8Dpc10FV0WfHGgQbGZetk6hBjQZCv4W3Hlb3lr7mbgwgDrHkCzTrvr9X8I8AWAFyJX
         +3tGKRae3/yjE8Mxs6Jfd4nLUvZpozKGpbygC0ylRzWCRkzjPQZyZIbAoWNrGq1/Nz7V
         FJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720534; x=1719325334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fLaikDiWkU5fRRAnenW6x2jVX2BzyMP33lNNvt71c4=;
        b=nUAFlDo+GI7yNmLL7ZwK+lYWugYRpSQoRl1yeOuJ0I8MmYCL4sP2P7PsjGeetfUWZE
         iVUz2XKmGcNcpqsN6aSHSI08+1wfVmzTua6gW5ym8qDg7vQLqz6YYp9YepC3mUS0CtMC
         bFZgYGsQyHUSckqdLhRYkMO/57j8LIBvRxwNKATm9mbPMAx8q3o+4i0+MY6opx+LvPrs
         xB7TLr1OEEBB8HMI9mk6Hd5AOkPB032EZHwmL4gs4iNSnTcbuIu1nzzGJ6XQY3sEbgZ0
         6k5Suoh8XWQVh+ieW7Rgpc3u8Zzhv2jXY6Rflb0fH6VJL/paVR608qRHDOovwppP+5KI
         UGkA==
X-Forwarded-Encrypted: i=1; AJvYcCXtB4m1BSjs0BDrE9dBNc8whZO38UgaMckM0JqqIyx5b7Qw6Srak3rZFGaAHjPCbPPMN+LeKqahLD/a6x+wC6l291t1KP96VP9+wR5PH/g8Ng9LHdQREPPGKhAz/NsExPBdbv/m7ng+HNadFqLbk+feDSg/PrH9sXwMmIC0zVsKC+dxLg==
X-Gm-Message-State: AOJu0YykFlSOI56uhjXh9ODZG9GGPiIdt6zW+4zgKEV5Kx7tQ4CXbZ2Z
	0HltYSLcJhMuTP3aWEo0en8XHYhd0rFzu63r8dZU0xkNvAryTVIr
X-Google-Smtp-Source: AGHT+IEqwhh3beEvRSnCVxq3eUU3DBGuf0MZxckbbY5FILxAGEYpZUjNYLceJP2m6yV3z89DL2W+lA==
X-Received: by 2002:a17:906:6a02:b0:a6f:1893:f549 with SMTP id a640c23a62f3a-a6f60d1ce82mr949424466b.28.1718720533414;
        Tue, 18 Jun 2024 07:22:13 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:22:13 -0700 (PDT)
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
Subject: [PATCH v5 4/6] dt-bindings: iio: adc: ad7192: Add clock provider
Date: Tue, 18 Jun 2024 17:21:36 +0300
Message-Id: <20240618142138.520192-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality.

Modify second example to showcase this mode.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml          | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 67384bed4cd3..e31436484372 100644
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
 
@@ -204,8 +208,7 @@ examples:
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


