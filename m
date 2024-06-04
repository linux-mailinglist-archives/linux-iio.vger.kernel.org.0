Return-Path: <linux-iio+bounces-5795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053238FBF61
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DC81C22762
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2214D446;
	Tue,  4 Jun 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRNYI2kM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FD14D428;
	Tue,  4 Jun 2024 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541883; cv=none; b=s+4jL4rXm2YLrx2vwti/EGCKO2FfbbRD6+/OOn2AqU8mWQqmZgmYdjLL0WQZU5Cfv0W9sldcEdV61TzdWVD9nn7iAlvqFwpKpvthvKz+vooQujNaU5612YpcGz7OTZo9tS2RrG20jPNX1+WFS9hBGw1JDJG3nzvjIaYZIHG2TZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541883; c=relaxed/simple;
	bh=4Upi/aO1n9wppPrsSNrwRbUEd5yfjpJhKlR5qtbnYoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGZaOudxlI4+OHMrcMmcXdl/HtTpzzmISis+YDB7j91WuT9IV6r16sf24xG4gD+QoKR3kGejV/7Qwc/3yvxfW3R7jd+fy2fmRL9HcFLO0SMviLwbu3aYM80Qq82mLbZOLsqclkmlX7G/3pUJqNy+Nr7yRSr3OsV1YAqL3VgqaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRNYI2kM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70244776719so1387357b3a.2;
        Tue, 04 Jun 2024 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541881; x=1718146681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIreKlpdqaedCwYC1fHyxchxscrvu2yAn0VXiUW6ZrY=;
        b=DRNYI2kMsnFw0KghYCX3IvBhKqYwXrF2a5zxrWc4RJ7FKFPU2AEHFkdZe9Gge3JHHw
         RYeHLO2FgX9hu0/cur3r+fyw7xPSXYIUYfLESueDL0rq9CWssiXbNxhJ1sdqf54HtUBD
         nY87UCcIp6YUOlADfBxerC13ifCFo135cc+RcmYhV5jqUYEXIVXCd3Lhi7YSiP0E+jay
         5z5FLYbWJPBSrMtoYCIgjIEboPIOXE2GmcKiJv0eUPbXie5RBaAq7roFjYFQP22KtXQ4
         r0iJfi+rq06FKa3JPTDWNCYMFZxTZi1eekaMMVT3ganZJ0xWPbKQ8LOErIBxvDKdbwRl
         anWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541881; x=1718146681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIreKlpdqaedCwYC1fHyxchxscrvu2yAn0VXiUW6ZrY=;
        b=NWrcb5AnVDzCuDtaRVQE3ZgQNYRVTq0H4ai6nf6BcVWqVIvAUPJTI0Sltru+NRfwRx
         EQT0K9DbRS1YPQKJa3HRMjLGskO2hGSHflsp2Dwyf+tiI8+1FcK14TlEfeMDVOvycw89
         U1ixPbo8XJLCO1awWABJKF51TnXWbtRv3lvHlj5oxQdoHtXBzC+mVwgFIRBjyuITjFTa
         Jxu9uZjbcAxBbg3W3SZ5/IKVtKV6t9DBY/p0YoNC0DhiOECm4E6S8V0BXIQTUBcDi95N
         BGW2bDAFYdjvvbjyy/fPNEmRaVwFRpTCUwUgfjTrRZdMgcRogdtqM3Hva1wV5zabBlSO
         ejtg==
X-Forwarded-Encrypted: i=1; AJvYcCWwddxm0Loz2IjEqsOhOnTCHQe1dmXrQ4f9D0Bkrcq5gibFWYKMy4gZKNOMChrjqi476FJ/jC7QiVmqcI+7qPy9Iy1TtUXDbmNLSHANfaLWUbAUnXgHpprHrF3TADVl/a+ZCZox4/QlcIPd+M4x3IhnbDInZlfLWurHJSUqam91ld2RfQ==
X-Gm-Message-State: AOJu0Yxx2hifkA89DVRZdLZ6BX8vp7vjYfmL0aFwYgXAFUbIpHngl7LA
	JrUlsTIOxNzqQ1WJtXvix3/VQF7lcL80FzWyqFb6c2UHCRZvKxRr
X-Google-Smtp-Source: AGHT+IHceD+KWLEKh9bzRbs6/sLhNMQ/mCZKeDL9jxUdK2SVW07CDG25eEfceLfeIrrnq7fxsmsm1Q==
X-Received: by 2002:a05:6a00:2387:b0:702:2749:6090 with SMTP id d2e1a72fcca58-703e5920c74mr1028549b3a.5.1717541881329;
        Tue, 04 Jun 2024 15:58:01 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:01 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/6] dt-bindings: vendor-prefixes: add ScioSense
Date: Tue,  4 Jun 2024 19:57:25 -0300
Message-ID: <20240604225747.7212-2-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ScioSense B.V.
https://www.sciosense.com/

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
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
-- 
2.45.1


