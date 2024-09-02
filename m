Return-Path: <linux-iio+bounces-8969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30339684D7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D1288B38
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5718455B;
	Mon,  2 Sep 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RXaXJMyX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6F183CA6
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273421; cv=none; b=CyeMrTUGg7I5ooRiQ9cMmSJ178ARhXWy1IM9SVeihsFYh8gCP2/fs3wbKsqrH3ejHWXH5qOtgTfp76jsmrYpFGofDK5B76P+XNW5DtssZ6H2jG83qrdr3P/Hr7g1t0tpkWok/m2rjGtWDbJD8ieubXsrshzjEw50tY4XEDsgn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273421; c=relaxed/simple;
	bh=9wWTe2RhHwvr6CPLWLyUmFQssffTJWZ48+UUgVNgMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i11mxGMtaVm8lHVppIroWTA75Uo91WW2KRqtUZx+uDwufXaOuQ2SjXgAR4R27xVfqfg1GLQyOl6/GCqm/C6OxtpF7KGwKbrsCR2tYT7yJWuLvB/7AJkInAHDP3h0EA2iBSBXEm6OxLtoyrE1Qk7uIBiuDethTm/PepAXXrt1Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RXaXJMyX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a866cea40c4so465407966b.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725273418; x=1725878218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=RXaXJMyXe7Iw3yp8BTlLK1dooJ4J55xsYrQjwaMHWGOUPJkXx8qsFxa3WiqAyUCCad
         KvUav1LSTP6gRMjoTvS/wRcuNgNe+YSPyamBY3+ODTfDIhIoHpeuquJOWsoQgyqAtkY6
         66NsKEPK2638hMBwvOYvsYQwHxSq44TQ5ty7x0m2RbmUs9ujAQgGSosyVq9l81Mrb6Tu
         h3jajWJMWx+13rCHrPUTSx1Hr+TlV2aTWv6UteAguTOL73H5bfC1joIdw77PvW9+K5vL
         8b5tVkIQJTTlM7uLEfEqp54uj3nzDLwrstNGiHSqzxqCMfvpsN8vuRhYoVZBRaeytNlH
         b6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273418; x=1725878218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=As5hx6Zk3ig1whS/XEMbqEmHAqSzVKUHk8GgslMZpVhxub/nLCe0cuckUk+TfzMJyB
         L1gjssHE+bt5Y/OtBV1/d36aqet9VUDuPuObVUfwYsipIsuQtAud27K0Q3NewXKJd3c9
         6rXJ3A2McuVFaTgsbsY4dVBmceTpD+D4+xEoSctabcuhN0PHlhqUKx/WxupzAi+74zE8
         UjWsAT1+Sh44QbaIgTTjnPrXoDfeezVllN7cNkXN3NMJptRLqvVDw0BbbmZEkJXagFxl
         //lQkwqJ1ylva109pEzIhw9uagxLSCsSW1LNBwHF77diy8xpraTVzphqtzcvCAlYe/ur
         I/yA==
X-Gm-Message-State: AOJu0YyRvZjKAdUjDzxn7ccgYwe7Sq5HYzulHl5PA07XWfUt6ul+v9CN
	g+Xy5Cxj2nauFFBoHPMQMSbnr7RGSEaVmHfbt5hC/WfqXEcOY6DFK+VyxfB1MwTpSmHZF7duZrM
	Hcjg=
X-Google-Smtp-Source: AGHT+IGs3wVJTHJ7qyp2vbEm9Wg5aV71A/IVWW27uPpd7RSejJp8JXTar1dmQObOgDz9YV8h50xsmg==
X-Received: by 2002:a17:907:3fa7:b0:a86:b00a:7a27 with SMTP id a640c23a62f3a-a897fad07f9mr1015773966b.60.1725273417491;
        Mon, 02 Sep 2024 03:36:57 -0700 (PDT)
Received: from neptune.local ([2a02:2f0e:3004:6100:e124:ce40:67a4:fcf0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm540876766b.182.2024.09.02.03.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:36:57 -0700 (PDT)
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
Subject: [PATCH v2 3/8] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Mon,  2 Sep 2024 13:36:26 +0300
Message-ID: <20240902103638.686039-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902103638.686039-1-aardelean@baylibre.com>
References: <20240902103638.686039-1-aardelean@baylibre.com>
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


