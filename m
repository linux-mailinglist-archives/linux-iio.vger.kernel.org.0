Return-Path: <linux-iio+bounces-8584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B439563E4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9E282EA6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6541586C9;
	Mon, 19 Aug 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c04hrCL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D9157E82
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050062; cv=none; b=H3f6k63hGPaxzOJZCLbTBE1T0cIQ8yDLnU+dtBlvcxnM6woyCMzSDrncO6PiK94ptszivWBT4xbY2Irmt4JfbaE+3mwMyZ5vcKm+q5XJImIOiShE/0biBcbr0YQoGaE+Xdyoa259AB/fR3IAcGsLiCnqxYOfcxkWHTqwsRWMD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050062; c=relaxed/simple;
	bh=9wWTe2RhHwvr6CPLWLyUmFQssffTJWZ48+UUgVNgMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp3YwAJlNdpQ6K08O2FTtgdSZMZLdynXGY0zeH/JYvTQPvRJYUg59r8DxPUYFf/XoEBXtyz2WBHATxgchwsZ6/JTTteFfYSJAtGJgpv/IJ2FZ0BwAFxE/+F0zY86HIk1ZUKnnFa8ce3JeEmkAih/jzXpg9P7PseHwSkNK+UGOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c04hrCL8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2c0f35f2so3349321fa.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724050058; x=1724654858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=c04hrCL8DS/AGHsbzeX6exIwZiBs3fyXre/EH724jOqgWdQrbsHJ41WLRMRWzfW0+9
         v5n5TsCHUcsfarp5nX+O7dBaiG7owuXCDdXBGbqqRte7mGVVMK1KQzhPaUNLmTSubYUz
         I6+iNUO0VzRn+Rpa5XwRIo4WrPcCyI0QxREoT57WO/CCMu8UqdzXyL6MgJFNS0SiLxVg
         IOuH9RFaNSnEXm0JUxcZtaiRoUENbwcdbvnE929mexz0cI6CL12k5UfmAr/noXgLj3o4
         pKd/zdo+hoXCYFrkShwi+aNFDqx75zn0cOrboTzTTJgnPj2cxDEp/FLJIHPm5N5DTH7/
         OYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050058; x=1724654858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=tyL19akXViPdHvnKWGtdTD27o00FTdLT5se6y4W8D2vNTx5ZrXoilXcMwuBVnQNI/p
         FfYPz+ePzMMRU9ocJsO09kyu7GMpm5Mz0HZR63sNUTydOH5FdhAiz5vNVQT9/IRaC2CX
         JE3DoxmJbcNMGw6hPcM+p2yMyRWxEL9JyqSkQ/6QpuURoiXEH91c2PmgSlK1i1t0zF3p
         dd1r2MY+MPcRyEwKezt/utqRWZcLzvo+ulG+GUN5mtFJwYKK4QvwNFHzIeNzpRmqbBb3
         ToqJyfE25kSCiY3Qp5pbyfQdFWQ6CT801YLcROAD+drjq7RCa6EE/Mnkr+bDQkB4E4gt
         RhCg==
X-Gm-Message-State: AOJu0YzbbF/IXPpoRu4ST0IOb49xRSmTvXzRmT41+a2mPffOVXVvpQEe
	8s/FF7fT2NqSlzfaNYYjiD8fjpGtwvXGsAxjuyFDgw+AXneGcKaqGAa1tUlXZdN18keYl7SSFNB
	0SIM=
X-Google-Smtp-Source: AGHT+IF+DEbik1uOC4GS0ALFsCh+5Y7rbXbhvxj5lhq3956byF8gYPkdxyO6ujzsaXjae8xATGu/eQ==
X-Received: by 2002:a05:651c:19a9:b0:2ef:23af:f1f2 with SMTP id 38308e7fff4ca-2f3be78709cmr38344991fa.9.1724050058380;
        Sun, 18 Aug 2024 23:47:38 -0700 (PDT)
Received: from neptune.lan ([188.27.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm599069966b.28.2024.08.18.23.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:47:38 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 3/7] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Mon, 19 Aug 2024 09:47:13 +0300
Message-ID: <20240819064721.91494-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819064721.91494-1-aardelean@baylibre.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
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
index 5049e37f8393..b400c9b2519d 100644
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


