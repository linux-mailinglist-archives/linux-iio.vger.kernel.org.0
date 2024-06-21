Return-Path: <linux-iio+bounces-6703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 126F891303A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2FB20F60
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054A168C17;
	Fri, 21 Jun 2024 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lStu89Kg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65636127
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008567; cv=none; b=DXZFb9eiZxbXwFfG/FojyAh4QgqdCyzDXLs0r9tAAP81QfHUGO/5455TsOlPn/W7PdGIb9GO/xbAPZuXxcMiLZ8zOtxDzbPehCgalytFZqtY7ymJZw3svfuJ/NgE7tuxAnBMSPqovjZ4n8dDwf4PhKqfCV7vh33HfUgDxMH7G2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008567; c=relaxed/simple;
	bh=8PoHB1+iNVVWg8t/RPg2r9VCF8spozdok5YxPwDRVdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwQkPcZ4Ez+GiI1FDj8sF88UP9gQzZSOL7ctvx27phifATG1T9wCzREBZNfvIWLay0R4I+AessT2Yp3++gD08zK3tXBV3ULYfmbrY1B6jlclRi2eGT6DGBurPfFmo4AcmoUrTjZc/yJT8vZBWgzLr7L2fXlDYF3kyjcxSeE90+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lStu89Kg; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso1211003eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719008564; x=1719613364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlIty+WgdwDoohW5XXFoR1hOthwU+4uED/1nhbuq/KU=;
        b=lStu89KgLrVrp2G5NTYGp2uyfg5nVhlDQ8z/9xppOQYd3irrSloHJQUhpK7SRXn2+A
         tAEBOB+xkLWvV0mcrCt3YeLBQbW3hWKmqTbRIimJLdOeQ9M4wQqQaoSzWv/JhQfy5sr+
         7aDfty1Hcg2NwUtgAS8MCBPM2RavI26jgqg5vwwjvRQB3/VwU4W9NeEj9OudFBe00kJJ
         i6Dq1HxMKRT0d8TamsAA3RliE20S9jANfhPbvALudiSmq2a9g3y/RbTYrqN+ND3N9CTe
         Y08WZj3Y7rfIRZe9I/wiDqGPCGjrDG3QTAWNu1UTOBnUW5A6ykowi1UYgGWA9BCiPiOD
         D89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719008564; x=1719613364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlIty+WgdwDoohW5XXFoR1hOthwU+4uED/1nhbuq/KU=;
        b=DTCVYMTYUogbkY3JaUHH2B7VTIkRgXlZ/k+Ka0Q0s1sji8e5abEJzGLLJl9qgPSQJN
         Act4BMdyNu+g1HvNTnhcFhS2qZYMRQGLBlW5b7dbTw1w++9kUJPUy5E3ZndUF9n3kfvm
         rWXQQgDz1kYWh66qYpg7NcoCAzGIwr9mIWdfpily+uNzRncu7eu1gmmR0alNlAD4GeRT
         /S6sNwVS6tEtDtPj4ceqGf8dIsXBXF3Lg6KNWcJSlKF3HNRiDVPR48+9d/vG+H0gxEdD
         ThOt8lvQCOIaxgsfpjbZ+5wz1H9meAeKfBPlcXuwsXXem1ex6QbFIZSt9kBH+SugQWPq
         kWpw==
X-Forwarded-Encrypted: i=1; AJvYcCXcO0fOik0UpZ6EOOOoYgzBO8He+hyeKh71/UNpXKolsfhetDcErlQ4zXXg/v3cwoxwBmHeUUa52UP0SI7AbcdvdRD8+KHW7Gsz
X-Gm-Message-State: AOJu0Yz2H44H+Gb4QbUdMH/6Q/ixoOjAjKUyDPghTEA1jVLI+ks0uSnI
	XAQL1l5jgdMttbiBptBqVyvJKrAZtKGBO4Ar9kJx9PHL1gOXmRdyQAJTV0WQ0y/1BRd8kyDEsh7
	1
X-Google-Smtp-Source: AGHT+IG+p63Zxmf2rAXWjvPijY7SoPMWPclMbCezJsVfap4w6qjRMVX7Qof09UrimH4j8vFNbWCoxA==
X-Received: by 2002:a4a:2407:0:b0:5bb:2d23:8aeb with SMTP id 006d021491bc7-5c1adb3b4f8mr10056699eaf.2.1719008564634;
        Fri, 21 Jun 2024 15:22:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d5901473sm414841eaf.43.2024.06.21.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:22:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] counter: ti-eqep: enable clock at probe
Date: Fri, 21 Jun 2024 17:22:40 -0500
Message-ID: <20240621-ti-eqep-enable-clock-v2-1-edd3421b54d4@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The TI eQEP clock is both a functional and interface clock. Since it is
required for the device to function, we should be enabling it at probe.

Up to now, we've just been lucky that the clock was enabled by something
else on the system already.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Reviewed-by: Judith Mendez <jm@ti.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Added Fixes: tag to commit message
- Picked up Judith's Reviewed-by tag
- Link to v1: https://lore.kernel.org/r/20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com
---
 drivers/counter/ti-eqep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..825ae22c3ebc 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
+	struct clk *clk;
 	int err;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+
 	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);

---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-ti-eqep-enable-clock-91697095ca81

