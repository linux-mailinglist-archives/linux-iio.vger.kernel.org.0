Return-Path: <linux-iio+bounces-322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB557F89D3
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693382814A8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCACA43;
	Sat, 25 Nov 2023 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D68RzQg/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1AD127;
	Sat, 25 Nov 2023 02:03:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2859bde1d62so656301a91.2;
        Sat, 25 Nov 2023 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700906614; x=1701511414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSDxTyLFtsnYDHG0zEBI3s1d8zvOlEcq91cg6PyUPyY=;
        b=D68RzQg/iFVLxDVsxBjZ2WUEVkwyDseRsR0wQElOMZrxXDfa6pYb5sVVHb025rEcY6
         cI+ZqrmE0oUu0IOpDsR1ma+X70Jic08SWEtdaC6/ducCH4BOSljkTys7qZsJIrGx3tpk
         s/I4b8Exj91sVEObaEwbYVAgTSr5AE7sV8BPU33JQyo/XCdCWLqXtiKzU+bgiJVCg5nl
         047gEuhssS0eoh3w0E+gY7+JXRft+GoFhx4rKAQkacfcOHh3ZtVMOA+QkSFC8SAy/aKW
         3A9D8+usjgOKZC1/X/fVHmReKEoMXe+plwf1Kd/tQou41WZBAc8NWobb02YKBtNkQNI+
         RhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700906614; x=1701511414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSDxTyLFtsnYDHG0zEBI3s1d8zvOlEcq91cg6PyUPyY=;
        b=l1pPRpG+qsuPanvcUewHH58BOfgFSOVbBdeEyFr4/5BlCP9F+VYnROg9E+p0OT7VpC
         YOzTEJhcmTMQz6QEpVivmJjY8vl9Mp5IjxPIHqC8RJUO4mgFygMk8BSSXlHLLTEf2Q0o
         ZZaJKLcqm9Pn0PVNiDC9gxFR2MWUSErxYfYBqF2yzGwYmotH5/01oCebR8SNMvKNomU/
         eipC8VD9QHRYl1+7S11t1gcbnFXueHUXhW/HZ3O2Hkk+LpRiH9/mQXy0WMsBt+DkLAha
         LUbjaxzCCpoMQkZmlGDb3AtWVWI25kWY/R7eiETAlrafTc6pFl595bZn4uxV9irszHdQ
         /IYw==
X-Gm-Message-State: AOJu0YxDV1d1TBef3QWGfF7c1x95KeESfutFvlC7NvYEvZKOMSFRq/Dq
	UE99UkJeKq0udH8jyNOv+JK6GXUHx5f2tDoQ
X-Google-Smtp-Source: AGHT+IE8P/9A9uFEhLK2eEUUCihHCn1yCc5ffgail4ByFUf22HfJlKgVqAX//mogYWt7YzUIR8PdxA==
X-Received: by 2002:a17:90b:3ec8:b0:285:936a:86b5 with SMTP id rm8-20020a17090b3ec800b00285936a86b5mr3655332pjb.20.1700906614498;
        Sat, 25 Nov 2023 02:03:34 -0800 (PST)
Received: from archlinux.srmist.edu.in ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090adb9800b0028593e9eaadsm2049035pjv.31.2023.11.25.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 02:03:34 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add aosong
Date: Sat, 25 Nov 2023 15:31:36 +0530
Message-ID: <20231125100139.193584-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
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

Changes for v4:
- no updates

v3: https://lore.kernel.org/lkml/20231121095800.2180870-1-anshulusr@gmail.com/

Changes for v3:
- no updates

v2: https://lore.kernel.org/lkml/20231115125810.1394854-1-anshulusr@gmail.com/

Changes for v2:
- Changed vendor prefix from asair to aosong

v1: https://lore.kernel.org/lkml/20231107173100.62715-1-anshulusr@gmail.com/
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
2.42.1


