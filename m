Return-Path: <linux-iio+bounces-8548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F71955866
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71371C20E7D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C19B652;
	Sat, 17 Aug 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vz++LjCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462C9454
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905758; cv=none; b=R/+alu0Jm9jjXX5A+yl+3WgwTvZQRSB4BFgylNlHD0Zf2LuMFaJ9mq6t1fA0qV8vZ7QAy0OTW0oHxJJ79KnCLDRMJ2olxwSicpdCr1xhVVJAzEARj1oYbA1tm735d2xPkRBz6AF7q5cBOI+ehpma8KzrKeWHMJ8umueaiDMZMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905758; c=relaxed/simple;
	bh=UBkzE6+oCuIftGfpMq3065zC0QcdCWFK6oX1UTE8cBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUo+CztQsouzvtD+m+QV9anW56FiOOy3/limZLQajMCIUk22pRITrXlJERu1aVwP2OOJZWy3BNx2k6L1QjHHiq2wV/IwtAiEKzhJhFL3fDSmg5W3W9/D3qZ/kH1EKI+oOoIbFv5/JrPOjVn4V3wM+o0HHUjA5HrPl/CSn0oTzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vz++LjCI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bec4c3ace4so390245a12.3
        for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723905754; x=1724510554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHNgwMtUWTK7B3ia4ikN1/V7/xrza6Azw4TfJ/emNAY=;
        b=Vz++LjCIuX1S5gqL419Z79V/IOB5jKhdYW/zG7d7pLAZ5dxepFXYzsnHeFcG0zjFxM
         hPSaLIpdr7s5zdi2elB+moIDxACuYsy3JA8c7SC6NWFK4YbMNdqhEQkOWJvgqgNUaeM3
         ZbmpU5RXYPBaSWZCK4WIlrmGUzZySyJ1MyUceXkpCHm0F+u/IxJmeq6nq1cTz4DJPdPy
         wQZEho5kL77OAUxhod19joanWQbiMoHaSSPHH2FdbPtZCcicS2a0L4bARVp7D9JZceFs
         3ERufM4b95bWOBR9KD+lVrlKBZ3K35ZwtzVOzpHjH5mHvfB5/uN7zBstNyVb2h3AIrFL
         QHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723905754; x=1724510554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHNgwMtUWTK7B3ia4ikN1/V7/xrza6Azw4TfJ/emNAY=;
        b=T9+cdq9tIHAlvcz8w6dbaX72FqMMU3K/BPQpMH2Boyh1CZrBRHXPl/v2UpaRfyrvcu
         n1/u28vLVJkwVGBo4UxrrhGRE/tSI/RelMnfv2I0BuIZxhbHwjIsGlD6sTtPBdV445lW
         WVxndAJ9c+HWHpoE6ap9zNjg62zaaIP1yWFEufhvE3Gm8MT18Grm2COaBD9aCw8g60rF
         yLr+xSGooyg6nnClHdTbWAeYbe1VsdfYtoMT1kqdUx321/bo+Cl6EKRpKWXNZs8XH/SU
         XaL/34+8az6SqXlW/80Y87XUica5fNEZXQBSyo0tNPQwgCdJSmvv2MlNaz+bEslnl2F4
         fUag==
X-Gm-Message-State: AOJu0YwP6zOBBvpe6jD99X1CQtBZuWWb+Lltf7bF9/j0PFEjP0XHkOE4
	74VyMuyA3B1AtM9mj+lM6awiCW0ek05zTMIamEA25EKhogG4DKZ1mekRc6Mr4xOQOuUtlhL4u/6
	3Swk=
X-Google-Smtp-Source: AGHT+IE9RuYHDHrkqJsko1Tqy4QNxSpJva9+rcXcps9qVQ3GLPfBR9jtX56S0hFYxtbftprk2G/0xg==
X-Received: by 2002:a17:907:6d1f:b0:a80:b63b:eba0 with SMTP id a640c23a62f3a-a839291c501mr246376766b.4.1723905753890;
        Sat, 17 Aug 2024 07:42:33 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6c07sm409840666b.43.2024.08.17.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:42:33 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Sat, 17 Aug 2024 17:42:15 +0300
Message-ID: <20240817144216.16569-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change moves the logic for setting up SW mode (during probe) into it's
own function.

With the addition of some newer parts, the SW-mode part can get a little
more complicated.
So it's a bit better to have a separate function for this.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 68481e97e50a..192b9cd56b45 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -545,6 +545,29 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (!st->bops->sw_mode_config)
+		return 0;
+
+	st->sw_mode_en = device_property_present(st->dev, "adi,sw-mode");
+	if (!st->sw_mode_en)
+		return 0;
+
+	indio_dev->info = &ad7606_info_os_range_and_debug;
+
+	/* Scale of 0.076293 is only available in sw mode */
+	st->scale_avail = ad7616_sw_scale_avail;
+	st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+
+	/* After reset, in software mode, ±10 V is set by default */
+	memset32(st->range, 2, ARRAY_SIZE(st->range));
+
+	return st->bops->sw_mode_config(indio_dev);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -617,23 +640,9 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	if (st->bops->sw_mode_config)
-		st->sw_mode_en = device_property_present(st->dev,
-							 "adi,sw-mode");
-
-	if (st->sw_mode_en) {
-		/* Scale of 0.076293 is only available in sw mode */
-		st->scale_avail = ad7616_sw_scale_avail;
-		st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
-
-		/* After reset, in software mode, ±10 V is set by default */
-		memset32(st->range, 2, ARRAY_SIZE(st->range));
-		indio_dev->info = &ad7606_info_os_range_and_debug;
-
-		ret = st->bops->sw_mode_config(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = ad7606_sw_mode_setup(indio_dev);
+	if (ret)
+		return ret;
 
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name,
-- 
2.46.0


