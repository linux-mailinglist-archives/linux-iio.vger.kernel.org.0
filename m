Return-Path: <linux-iio+bounces-6659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9EC911D0C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 09:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2097E282DAD
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647C16D318;
	Fri, 21 Jun 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXXE/FlI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D016D303;
	Fri, 21 Jun 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955781; cv=none; b=MLE21PDLmBEw0FAnFAwJo3acbExYCvhPHDWCJ/ZIVWwg6kqsAj8u7ijc93DsJ0QqRU/1bltRExvyy7T6/wIH84m8vQa/IyXbhGK5vdUfT/GHFJjTx23txSyRyxPwuUtM2tGeR+wKIybYiRv0VN14dxrmjtDfciSc30wIvQGEzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955781; c=relaxed/simple;
	bh=ZH1grv4GwIzZfZDYAFkKU2IKQo4u2YlYAcBUckzRIXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsfpEpaqYkzfdYYdqY4a6n71RiREMvRs9BgcCUtjod+rGjow05EVw9R0mx9Ho4ti5y4BUvWyQD2H4mqH4nFGUC4/IOuKSUxvBhSbanxWf/mNykO/bx2Fv/teZIUjmEG8Dg+a1oA6U7gu2wm3+vUrttF13fFK+NsiuyT+Mu79gRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXXE/FlI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7064afd7011so825107b3a.1;
        Fri, 21 Jun 2024 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718955779; x=1719560579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPB4NeIbno9a3Cbkfd8JR+eZ0Z1fUC8WhZO7rFwN2w0=;
        b=VXXE/FlIuHkIeCfugu9F16j4tm7DvDOlRA4OIyYyGh7ZNnXjsIA364SuSgPeodaVVV
         KYAvYFUVFhU6+986BLJTnWvYWkvUWryOc3JioYJUnSa446asPjSEzh3Vs1MlZKmx2Dg9
         /8JUfP8DQv0+ewOq6cPzaZzwF20552EDzFpFOEf7iaDlRwoP5aVx/k7ey8WNhV/70H90
         cXwCcaTx/KEzL1SAh+2L4wsxKJIQyUW5LNzCa3PdJURggwhiHi9QQi0UWNgAuSHM4XVW
         ie6ja66AFskc/3D9zF5zJcdn9UsZDEo/JpuMoB/u29C86YG0O4v75HbuJqBPXNHF3BhD
         9IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955779; x=1719560579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPB4NeIbno9a3Cbkfd8JR+eZ0Z1fUC8WhZO7rFwN2w0=;
        b=mGCNSN3UMed8eQYJAebLNO8HZKFPPUcmx1LPpzjhB6hzyKcDOyfuUu3lWY9+Heh7wn
         WzNKT7rY+r3VZYbIjjSVtNLV37/QBN3684qsVdeGbDTz+DijPL+8UdeWIRh5WDCLIJ78
         IKKIwN4Dp2pT9flCsGWBOdZ/mQV8FGfq3B0LcKeOBBibUnr1O98vaCR5n78ThKQT/Ks4
         vCx2RhAFC9nd++ojidDaCjYMM6Pf0OncR7K4hzEV2uw8qRyfsz+jNj6Xn0Qkk7/mwwTi
         lPUhMl0kiRpsIx+pYHvTDWHlncH62UbeRocftyjdnvMmtf4INY1tuQNWfvnQD+BZpsIi
         WGRA==
X-Forwarded-Encrypted: i=1; AJvYcCVt7NCi5+EFMn0Fa8iODM53Njxuwn/Hv5s3gDBOyW8CZyl/ic6+xhG2ZiFZ4Ucn/gDukE1mZlzGG3I9wg+Q0y3hu3n+2wUERQmfg38G3jbvZRt4sK4OsZyOnIqHGap8qM0gHL0lYqPp
X-Gm-Message-State: AOJu0YzH+i7eekEBnp74VQM9TYpyW5eQQmM2FEPkXu0HYpfg0LAmexFv
	9CCo35ixsenFXqQAhdPPaUwhK3LUSYH/170JMs+pwYSAwnlCgpGXJ05xxIPc8ij4ig==
X-Google-Smtp-Source: AGHT+IHYaEMTlnb2sBVKnqG3ncjfXInJR40Pj8bfzkYhBCkvtg2g7Sz3Ya7HJ2FmwdDZIiomFO8QjQ==
X-Received: by 2002:a05:6a20:8ca3:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1bcbb385dadmr8298000637.9.1718955779018;
        Fri, 21 Jun 2024 00:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5a87sm7893745ad.203.2024.06.21.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:42:58 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 21 Jun 2024 15:40:49 +0800
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: add tyhx
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-add-tyhx-hx9023s-sensor-driver-v6-1-65196a9020f1@gmail.com>
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
In-Reply-To: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718955766; l=827;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=ZH1grv4GwIzZfZDYAFkKU2IKQo4u2YlYAcBUckzRIXs=;
 b=kH3X/QfakY2cx8H/LnhZtnN9on64f2SdQQtroFE7/mLg75UlViU9s4mmKSLtUQdiAKxkt6FzQ
 NJ4b7kgfwaBDfoy70ClwHHVYOcU3TNQGngs020sOo51dirRwThSqI3P
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Add vendor prefix for NanjingTianyihexin Electronics Ltd.
http://www.tianyihexin.com

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..989242da4f44 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1515,6 +1515,8 @@ patternProperties:
     description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
+  "^tyhx,.*":
+    description: NanjingTianyihexin Electronics Ltd.
   "^u-blox,.*":
     description: u-blox
   "^u-boot,.*":

-- 
2.25.1


