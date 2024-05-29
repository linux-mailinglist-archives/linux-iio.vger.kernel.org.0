Return-Path: <linux-iio+bounces-5413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C98D2950
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F98281530
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022601FA4;
	Wed, 29 May 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHYIK/nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46D819;
	Wed, 29 May 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941712; cv=none; b=Tnyi56FhNTGhLgDa8p70q3Vm8V/p+06m45X7qtUemfEyIAE7o34VJI4Butx1wtQQwJeMgSi6EP0JyDO00vnOVL7hOe4wIQwOwhRM+znQ/dnvdYxgyvWYwmAWPONSg45j0FKc8NLPmotyUl9CkbcU8OwDZfgKksigGJqP/Ge+XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941712; c=relaxed/simple;
	bh=nWS79Xdi9Z1eTNqxIh6QMb/lMAP5MFLOTH72fyKQ4Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UatExrVzi/JnY2RUYZ8M++i8n+WRBWjRxiukbPK3DoGyF1JMhJEgcPAAn8icsTxNjoDFsvdAz7nq7m1PCD919HyT0T5aCTFUOcKNq5EmZyzQ9oBwxvoOO1xw08hdaRHbF6LprBboeye9lA7hDzDksf5qPcIByro7gswcgjdc0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHYIK/nu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso1128248b3a.3;
        Tue, 28 May 2024 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941711; x=1717546511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvqQ51v9IugDWKdPnnnfXWHKI+dXs1qLkkNZeI+c6Xc=;
        b=ZHYIK/nuVfILf6u9s3DxRI7eHx/Jv1uiy6icF35mGJhjOgrlgygv+Hi/+5+XaTMZV1
         W+/8VPmNSUQepClfP4SBlPk6P2c5P46OVossEMtlF2Kf5K3v4MKhM4NDBB/DSFIQkKCg
         V/InzQEc9wMSV3h1KpdbH349LQbqZWIvwOZtgIXAZXhnzQkiu1Psxeh9S9/r0rU0e+Ot
         m7lUNvbwDYV277hqsJGFOPuS5Z6QTw2UhRbx3c9oqiBi6YAIoNbic9KIV26t3yN1IxCB
         hlEnMVppJ5dE2C6onVzljrlMQaN+gb6RvLmz7Yk/KsBtTq3RrmMIB16pk9sD2pZbb9nG
         i5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941711; x=1717546511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvqQ51v9IugDWKdPnnnfXWHKI+dXs1qLkkNZeI+c6Xc=;
        b=tsLNDNiDlPy8LeiP8sVywhokiWb8Xo5seAIblFjux6U9IBDu6BVokW9q08osUDaJJh
         iVIoCkZLaSmmxlnnD9ijgwuZX4gHDh5aNa/bH9SOu/xpAtDLyWgq/YHHAA5qm9ZOj/PQ
         E0BSooXcAv+s6DhudV3XxTIKqg3PDpbTO+h80QdQ4m3oqaasrL+RsG+0JLl8Lwl/a9ts
         lkPUrUj/RQsK/htLG/XwHueKxa5ADaTORMxzAyXBvMYVFS7x4wnEZO0hbCHJddGmPPSN
         y9FzFSXszfqfy51ZjJRM6HBlHbI0KnLjRY6pcT8obvy0byytOKKTn9mKv38vvkvBmzzg
         gN5w==
X-Forwarded-Encrypted: i=1; AJvYcCWfbe2hG4kWDvCwnGeTXR6Gs2dY/WMzKL3ru/d40NI7kWQBofRIVPiwwVZ2WldgTF+kJVYqQFE3pzuWXD0kOVH2k8GwXCTKaOetiIMk6C2dGLeA0I4iiLnsaDEh8B2gv1RHSRu/fRlHOW5f8K3nQdLKrHb2nRp1+sfhTOghCRhk8p38Dg==
X-Gm-Message-State: AOJu0YwCT7ooErYtst5cde7GmS7O4OUrcuooV+2v9AxLtEDfS0xw3Auu
	PRQPcV5hpunAT33sQU2Lh/tpJoaZBcR1zkdm5HM8Djc2xOAVWg1YHBln8jHc++0=
X-Google-Smtp-Source: AGHT+IFgjgDEue0qXVYGTI+3vE+43mbKQc5n7UgW/exEodSgv/tn4i+QHgus3C66Y+22YfyjnE0ODg==
X-Received: by 2002:aa7:9302:0:b0:6f3:edac:d9e4 with SMTP id d2e1a72fcca58-6f8f3700476mr13476014b3a.20.1716941710695;
        Tue, 28 May 2024 17:15:10 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:10 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: vendor-prefixes: add ScioSense
Date: Tue, 28 May 2024 21:14:18 -0300
Message-ID: <20240529001504.33648-1-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ScioSense B.V.
https://www.sciosense.com/

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
no changes in v2
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3..298f13a0d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1246,6 +1246,8 @@ patternProperties:
     description: Smart Battery System
   "^schindler,.*":
     description: Schindler
+  "^sciosense,.*":
+    description: ScioSense B.V.
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":

base-commit: 084eeee1d8da6b4712719264b01cb27b41307f54
-- 
2.45.1


