Return-Path: <linux-iio+bounces-72-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68F7EC322
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E57B20AA6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB0182BF;
	Wed, 15 Nov 2023 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibN7e/0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF08179AC;
	Wed, 15 Nov 2023 13:00:16 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F0F109;
	Wed, 15 Nov 2023 05:00:15 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso4176835fac.3;
        Wed, 15 Nov 2023 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053214; x=1700658014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDT3a72/4EK2RXUg+bwJp3dxgNq1+ZbWNBolGSQCq8U=;
        b=ibN7e/0CnUF46/PfOZy6paIxeUlRCoWjZy9wlCAzkiWJDrWEl5VV87vMjXEDwdHPV/
         WxRyTBoIRuhyBbg58gGx5BObPvCo/w1Ey/jdolGlTjhcrLrqMDQab+N9Wgt/rJbbIcYW
         jhRg7k78zvNBCC7TMmAd8pKfXD3xZYIT4iDBK/LeBTWkfTlnTJC3biId/NBztVIWQRuE
         UClg2IXW2piS6KEtdf8Kta1lWZaOR8ILYbiBdwf4qUq9/tu3uKS6ywg0rvmRdrYCKK5l
         YsZZR45PCKKoOBoxfbAPr6wM1a78c+1xfEuS91jkwBg/vUcuV2M2CVjwDANRdPNJauYt
         JqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053214; x=1700658014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDT3a72/4EK2RXUg+bwJp3dxgNq1+ZbWNBolGSQCq8U=;
        b=ESbXCbdhXFj+67y5o440jwxlv18NPnG6W1qUiwpE3LnmuCUM5NDHquLHfT0viyM+WI
         7EtcQdT30e3lbnFNbfNXtSqPWQedIG5xWNeOqVlf7rlSYcw73HIctQfAT/bnQGc25gpV
         d9yaO2qylz3yUUgzIdQBSNM6tPxkeZr2k3YgAU9GC+4uLPXpZFGcIgWzLgukrPuY6FKw
         zs5UMoGAMt33y7Y8qCcCDy4JkefiU6MNJGZpS4S5+SnVER/kJDGuCCHmbNvuWNEUKTCi
         LLNwUeGX+AvTBN/W7gmWCw9xMLcfyE0piTXEi1atOttVWdCui0IoB6o6pKu7FGrEJMlw
         ZtoQ==
X-Gm-Message-State: AOJu0YxVB9riD1SBlrfY3xC2lBFcLE0ss7ROBxqpwN36U4tZVohKmuSy
	2td2kMSrFCKIQzFvSlofHJpeq5xQBl1x2w==
X-Google-Smtp-Source: AGHT+IEPrIUX6ZzViiJXg+HhiZ1aUAYZpbVsJ3LLGoCj+Ba6zvmxvqFqsdgCHXtK315N6GkzpKzK2Q==
X-Received: by 2002:a05:6870:f14d:b0:1d5:b2ba:bc93 with SMTP id l13-20020a056870f14d00b001d5b2babc93mr15039104oac.13.1700053203762;
        Wed, 15 Nov 2023 05:00:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id fh42-20020a056a00392a00b006c4d128b71esm2812867pfb.98.2023.11.15.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:00:03 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add aosong
Date: Wed, 15 Nov 2023 18:28:06 +0530
Message-ID: <20231115125810.1394854-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aosong Electronic Co., LTD. is a supplier for MEMS sensors such as AHT20
temperature and humidity sensor under the brand name Asair

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v2:
- Changed vendor prefix from asair to aosong
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..48d4ff635562 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -117,6 +117,8 @@ patternProperties:
     description: Andes Technology Corporation
   "^anvo,.*":
     description: Anvo-Systems Dresden GmbH
+  "^aosong,.*":
+    description: Guangzhou Aosong Electronic Co., Ltd.
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
   "^apple,.*":
-- 
2.42.0


