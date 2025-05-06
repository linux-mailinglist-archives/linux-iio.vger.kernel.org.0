Return-Path: <linux-iio+bounces-19216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B97AACF3A
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 23:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52387B9108
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2721A427;
	Tue,  6 May 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sRKk7VCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658E218AD2
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565530; cv=none; b=tOjyi/rT5eLOXMXrjbFBS+n4qmAir+9JY44ndauK3Ep6TX3P6lUHDftqqL0xeSkgLgUsaoM/W4GOmaPpypRKbmAmSHNgsFSsICa/smbMMzpu7PPI2poCW09kSrVz/Q+gK+6fW921EU2q/vyhKS/kOB6vvKLPPpQNtgxanxN353o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565530; c=relaxed/simple;
	bh=NtotUFQE861trIH/6KVUMJlh1RHFkSekY2PpGsDNTzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mETBki7l4g5Ymq+PJgMzR4jpHUQ15HfT6FofvWIjycFABrIazgKzh22FDja7LyoFszcLQJpjjqsU+eVvmjpGD134/dTXd+cw/miyqm1NlarwncrGKz3Mci369eOlzOpTT1HBuXFlAk9Bu+Y05XGd64mbqI6evBPt/BbcnmvP7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sRKk7VCp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so40271155e9.2
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746565526; x=1747170326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=sRKk7VCpsIgpDd3l3QlrSy3OBEsV+LNqy3lT+FbM18j77putich8W7nEhP1gCgHOe1
         K8rDU14miiRYTvDf41Ogw+rjXfkh2XZEl46uyjA+e9oxD7vmM8k7y2Yz+AfnucORyk2s
         tE9TSoYe7fN6YWZ0LNu3IVIQ7RxqovT6RIZKkuDbxnGivUKYKPGLpPEPjaEooSG0DQc0
         gx2fZwBiKniM6ZEXHyUYZZ+Rn6+mOXJvU9J6xq+D5wyQAU4U6mXGxLM883sha3STkL00
         fU/R1Kl9+dFL2BaghDLoZDtM2pqUPtU608LXnz0zT6ca7Gb+SBQ4idzd1GvC54xiUAYr
         NAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565526; x=1747170326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=ppv4p6KJyEfivX+AI9miG3H4rZMHw9LA/G43AowwtONZXF1LMlMgv2gK2JLMfunUiu
         eQ4j4uloNgq/+g/QmThIoadIZR3WKt+WJMPJ4sBtyCcHrTu3cQ1w4g52d27qlAs8grTU
         p8YenDb324lPkmnUTT93gRNPyvHj0GyiUvTCQL1QKRLxgnWk8SJYpFk747RpmAhR6q66
         n10xhz9UFb25tnKLxke12IcUTUV+TFtkUYVIoyqfCC8vwnA400QnDfQryr4TFDQvMCiN
         lx66h0hXjvHk4UZHJZ/u9OL5pf7e0AdjHxP/Hjn1UiOXLCliW74CHZcmak5MJYzBIRzd
         VHiQ==
X-Gm-Message-State: AOJu0YxNECjXu04FFP8RQLmaCnHOAOHxK/prcDvjNoA3jA57mYGjxJ6A
	T0uimwdmRVKGlirw048tVfaxJVHLO3X/3G64ca4pHMbSd0LWbvB9xuIYvUx0Lpk=
X-Gm-Gg: ASbGnctYGnz9rMqrxx8UIovrTR5hr5m6vYYP1/JiW1R+XCdGJ7gQm2RL4va5PU9OXY3
	tig7bQ2Cq0M22BlXRHP5BkhCkg4yk6mPXEd8tHGo2Gmri6JhsPiJTwsLTJU9lPwV3KHUnvxySOR
	EMD3XxGnljLXWJN851bo7vg8ZeJQwP+z0C43tV4HmsmVLh69f03FgaV/JJN/ELGS2aDByMsYfNp
	OpG8GIcujNHBjv3UHTYDcBRYQDmsFtGXm1zG57qMBbNpxllhhVZoNQoxYLjd0CTFp7XIvdFXWqt
	2DtdFLi3/yXSL3+kYrmUetmutjTcFPxZJW0HBiOj//qThfabTc0QkEI8R9Qn5ZJtzqkHxVw44/X
	QEuXFAoghn5W5hvhUwYZ43r4=
X-Google-Smtp-Source: AGHT+IEGADKws5OxM0lefeqBlHEbBvNpOXvuGA3FZ2E05BjR5O71/V9irAMdAGrDlFjmTztGEFNgKA==
X-Received: by 2002:a05:600c:8217:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-441d44c174amr3058605e9.19.1746565526295;
        Tue, 06 May 2025 14:05:26 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4351abdsm6794475e9.23.2025.05.06.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:05:25 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 06 May 2025 23:03:50 +0200
Subject: [PATCH v3 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-wip-bl-ad7606-calibration-v3-4-6eb7b6e72307@baylibre.com>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=mK1GoQiX2hS20/yC/1czrPjfc5t1uAwSltJDkMx72Mc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQqvR4o7TAXEehyJWnqy/bu73gB/+SjYkHbt4VeXWo5
 NWX3d38HaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACbSys/wV/ztIrf1U7ZaCpR+
 mr+poNwt9WX8KplXL309zaMkl4RkWzIybCyIXpOtlGreZpl/NSPFQu25vf7q52/3WMys2Xb44Ht
 PDgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support by a per-channel resistor value.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 29f12d650442b8ff2eb455306ce59a0e87867ddd..6926f5f090ad6bbbe7bfd9327dc5ae17dafcd1fd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -204,6 +204,15 @@ patternProperties:
           considered a bipolar differential channel. Otherwise it is bipolar
           single-ended.
 
+      adi,rfilter-ohms:
+        description:
+          For ADCs that supports gain calibration, this property must be set to
+          the value of the external RFilter resistor. Proper gain error
+          correction is applied based on this value.
+        default: 0
+        minimum: 0
+        maximum: 64512
+
     required:
       - reg
       - bipolar
@@ -256,6 +265,25 @@ allOf:
       properties:
         adi,oversampling-ratio-gpios: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
+              - adi,ad7616
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            adi,rfilter-ohms: false
+
   - if:
       properties:
         compatible:
@@ -398,6 +426,7 @@ examples:
                 reg = <8>;
                 diff-channels = <8 8>;
                 bipolar;
+                adi,rfilter-ohms = <2048>;
             };
 
         };

-- 
2.49.0


