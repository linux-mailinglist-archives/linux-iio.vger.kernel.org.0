Return-Path: <linux-iio+bounces-21787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23321B0B7A2
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 20:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696157A833B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0788222585;
	Sun, 20 Jul 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsRIpAty"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B739382;
	Sun, 20 Jul 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036003; cv=none; b=d0xUuWYU2z2hp6SGzl9N5MqKbiue3C5c4yEebgr4LnOgIdCUWNdgxPTGUZBW5soI76IV3oN9JiVcdKMRRC/HrF1BPSGWRpkF92IUyM1htswKbjU7NTEcrIW27dVLojBTBK9tJzCezfb18G903Cx51pRwk8G41X/fPQnO0vPmVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036003; c=relaxed/simple;
	bh=CO3t+aMRXC7TDnBUj622dh5JiJ7sh0cr37a/whpbhqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7DB1Nvz/gxi5p8TgCy87YO+het2Clue+Tlb/B5pxvTRdod0Ub8+Cs2nASu271vepbbLZZR4UyclmsB9H/bShkLAutVaLGLQwit9UQBZa9ahE0LSZqj/LUXhZUay3hVHdiwgLORk/RZvH+AyxIwUhyXNi04N3GIZhRUmloxNqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsRIpAty; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so2687703a12.3;
        Sun, 20 Jul 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753036001; x=1753640801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHZe9EgIX5bHoOn1lRHIIocbOcsSd7x7FE0vB7xjsvo=;
        b=NsRIpAtysxZ+CnQmXAUmRUq0cjOQ4FHpgiqasbnD6bBzw0ppXcJGIgD8oK6BCya6ml
         ye2+G4/YI/8w1GxAL6cnyS3+RIN8+bFA5ZkLIDDmdJPSb4euXe93AW5vE6ocaqDHX/1c
         1CK8Y+aqdq/wGAYUBblM2mg/3Csowff7j9GowMqoelaKpyNFb8Bbybi3TjS09mqAEepI
         qPSjhzzzR5B7OvbJEGXsUgUlV7bgSYAiLFeVv7RoCJhZDfkD3sFMp6pL9/YGAC6r8O2o
         o7Jtrm3BZPdeVTH/RPkQXXxSuqV9ps8E8gVge6z+eDYUpzY3jpWHEcZYsFPC/MUk/SxQ
         yNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753036001; x=1753640801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHZe9EgIX5bHoOn1lRHIIocbOcsSd7x7FE0vB7xjsvo=;
        b=ZJpadqZSXPPEtvfhjkQGmrfku5KD5+pWUVRNsl1j5THzZA3xu//upvZGs3txI+TSVq
         f2j1qc4BrGesy8RfU7iec5baySVgJnrUpqvpvBU046skWAf4PLE3GiL4tC9jBrY3kHZa
         pVAAmDZL1HV96uA3NcdvRkmc6gIK+JVXJzhpA1l7oSSdCV58/RaTnhPZB4jmqtbRZd+e
         bsyxZMJbo32ZXmhZeDAXDObQN8LwKeWdAtHq55haTYXJw/u6UbdFPaxWv8Q5X+q2yvid
         ctsAK2Dc/qd9Biqks7nTcz6c+MFP5+gnqg6AzIyH1xCGJZ3R2hq9m8CAExZtIPKKo6i5
         3qtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzUUMtVJbGVTfmnHnQWRttWQOqEUQFfqr6Z1DoGGIsoUmSmLnAmf5r4HWRIm3jOfL5403mS+DpSZLo@vger.kernel.org, AJvYcCVqVGnYCR5B0f8ZAuhw5KLEWU7WOBGsKDgrdS/kAakAkLisT8ky606Q/+IS5KbRKuJ/nL5FNEgA@vger.kernel.org, AJvYcCWe56ew7cJ6GsMfPehI1TP6XdpLUi5rhWeHY26tS45JF2RH+x7GZDcG3X7bTr0IbV9ZtMhKqIUhhNuC@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAmiHKit08htGSSAWG7XbTCOVAE+NVqrDtaIHEdSesY90fD7J
	ApWBSxqKn61MlpiCuvxbpzxuqds6MB/K14CLcEpY9L2H62bXbxrqEzvFe90G+9xxH9U=
X-Gm-Gg: ASbGncvq1LJvaKKWIF0QseBFV2nMgKEA6NWK7fYxYeBAQpT956aZUxa7DhpDNVG4urI
	ywrI2iG6UKIy7Zm5x3TmqXuPkbSjWCVVMvWyaH03EJ7SFO08WwA6tznAFRoGKGiB2vw3hbEmUvb
	L2iUDGr4rrBetzIUnoavPjNSukI/JDAlv20NE4SiyugFGViSmzKwLPzR/QqedSUKfaJqki0G8gi
	D/mNzbUZsYeAcogizgS86ERd/AEoc7yblkVKlH9fnHGpEua3o0krmjrM7fVUyabc81VPIClCZgR
	aAbzT/fVdXRHkOZRdue16mLF0by4pDB6BJKWkeczaVjGWmK2uzvGdlFDFdPD+CvlpVHytg==
X-Google-Smtp-Source: AGHT+IGoGfPH4SczPPgpunZElQl0pQIPgpNF56UBU7IRRaCJpTzKmfW9fc9yllKz3BFHUR8wc4vQBw==
X-Received: by 2002:a17:90b:4b4d:b0:312:e445:fdd9 with SMTP id 98e67ed59e1d1-31c9f3df4d6mr27338628a91.10.1753036001293;
        Sun, 20 Jul 2025 11:26:41 -0700 (PDT)
Received: from km-host.. ([49.207.192.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a82sm44634475ad.156.2025.07.20.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:26:41 -0700 (PDT)
From: ">" <sanjaysuthar661996@gmail.com>
X-Google-Original-From: Sanjay Suthar sanjaysuthar661996@gmail.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: ribalda@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	sanjay suthar <sanjaysuthar661996@gmail.com>
Subject: 
Date: Sun, 20 Jul 2025 23:56:27 +0530
Message-Id: <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
References: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Fixed commit message grammar
- Fixed subject line style as per DT convention
- Added missing reviewers/maintainers in CC

From 5c00524cbb47e30ee04223fe9502af2eb003ddf1 Mon Sep 17 00:00:00 2001
From: sanjay suthar <sanjaysuthar661996@gmail.com>
Date: Sun, 20 Jul 2025 01:11:00 +0530
Subject: [PATCH v2] dt-bindings: cleanup: fix duplicated 'is is' in YAML docs

Fix minor grammatical issues by removing duplicated "is" in two devicetree
binding documents:

- net/amlogic,meson-dwmac.yaml
- iio/dac/ti,dac7612.yaml

Signed-off-by: sanjay suthar <sanjaysuthar661996@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml      | 2 +-
 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index 20dd1370660d..624c640be4c8 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
 description:
   The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
   guaranteed 12-bit monotonicity performance over the industrial temperature
-  range. Is is programmable through an SPI interface.
+  range. It is programmable through an SPI interface.
 
 maintainers:
   - Ricardo Ribalda Delgado <ricardo@ribalda.com>
diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 0cd78d71768c..5c91716d1f21 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -149,7 +149,7 @@ properties:
       - description:
           The first register range should be the one of the DWMAC controller
       - description:
-          The second range is is for the Amlogic specific configuration
+          The second range is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)
 
   interrupts:
-- 
2.34.1


