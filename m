Return-Path: <linux-iio+bounces-208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA87F298D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C289F28297C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7A3C686;
	Tue, 21 Nov 2023 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvGbAoPh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD0114;
	Tue, 21 Nov 2023 01:59:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809414efa9so4172783a91.1;
        Tue, 21 Nov 2023 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700560787; x=1701165587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5d4Ds0rhXmcTPF46DSZlqdSRg4RbFJSILxJbeSUaSV4=;
        b=ZvGbAoPhSw4H47ZywzL7UFbrbBOnbi6IzJuyRIjNkB65UfeRUSwR2mq9XX9z+eV5C3
         F7HB2/3EhFuF2+xpAkFYc0fm6sTr3BKDQ3dDUN4iHTlZyCNbvNDxWFF54vDwQoLJPwIO
         i9HBciGXZgRDdd9wkS3A2XjEtKOPMotQZBNqtQN4mWwjx/5+rJS58GA5samMSKBgV7e7
         AamygaZdaslKmHWTrQpKb6+L47Co+AAxD2bu9vMujETjFYwfpsCbwMndWf5uYyra8h35
         73Iir08E0yQ4NRR+eDMk1KuOVyycHmqLqjooye24/4aoH8bQm1wKpxr5dytER0pO9lyw
         9aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560787; x=1701165587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5d4Ds0rhXmcTPF46DSZlqdSRg4RbFJSILxJbeSUaSV4=;
        b=HQF5wBbPOGJVAvMGNtNWcS9+RmDcL8ckqJLX03436hm7A6N7izNEFwzvm5pxX2QbR2
         wvn1yIvYLMYeNbM4z7udPeQ3YqtDJEmzT3z0HQ/0j3hWREIxq7LoDwYMCnYN4QBvEChW
         cOm+0i+kXqupwvm//A0xKKVV9eb45J4e5tfRgcdHOMbetRieiOwptjf6qBYrt3ERhqV/
         OYV2N6f/6kPNgha8JtN9zHzbiW6GRv6Ct27tdIytU1VH4q0iyfZb4ZwLzc89LJ29bVB3
         e7wjrBxrMtUBLUEsA+zGRxYH5vmQT9WTgK9jIGNetq11DOEn00vDsUEKCFu+7gsT1GiR
         ZwPw==
X-Gm-Message-State: AOJu0Ywylbfk5W9MERocWt6YpPzXnNnWv7lLRcGYmnrhUXb30Y+XWrRv
	uTq6kPBMlILXRNv2nQH+Wm5i853d69mjyg==
X-Google-Smtp-Source: AGHT+IHHtZmZtyzuep8YXNg8hIFWSpcLETd1D1fo9yHbLdwHxHjfhMaLnlNufFjT6FRT1en/zL49/w==
X-Received: by 2002:a17:90b:3144:b0:27d:3439:c141 with SMTP id ip4-20020a17090b314400b0027d3439c141mr7544085pjb.39.1700560786964;
        Tue, 21 Nov 2023 01:59:46 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001cf68e1c5a1sm2047415plh.4.2023.11.21.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:59:46 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add aosong
Date: Tue, 21 Nov 2023 15:27:57 +0530
Message-ID: <20231121095800.2180870-1-anshulusr@gmail.com>
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


