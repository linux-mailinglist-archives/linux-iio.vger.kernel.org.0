Return-Path: <linux-iio+bounces-9169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B096D1FA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5531F28F2F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D5195B18;
	Thu,  5 Sep 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vR0KxDxd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04700194A65
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524658; cv=none; b=fsmhv/imohfLEOLZuJKWMXw/Ob5CfXcXs4U2+gkTvGf7sdGg41rjz2BKcTllDyU1KcorupyUQ/ig+hCv8WBtW7X22tdnzWPqA+ewP02FmVrP70FWVSNcfV6Xz4IRV3l0G6pITeuSokn6WuSqC9vMayadR4oAb4Wx5OIg4/UBk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524658; c=relaxed/simple;
	bh=9wWTe2RhHwvr6CPLWLyUmFQssffTJWZ48+UUgVNgMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7soazxpbyvVs4Zz077nBcKcVO1M8dULnI17cE+nupdPdGPz9xxD2ICk/2otTlgrZBkBzhOVi59AO47gfBvUM2hwFL4KXlM2M9Dd6wpzRZ/q/cPCqG8cD9TB0czISsK5K30wertk7gROHbbol7casMhm4w6FcHD/U0xF1wYwztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vR0KxDxd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a80eab3945eso60537766b.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524654; x=1726129454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=vR0KxDxdQ77x0HcgiwxAV6eJwsx97UxYlez2UKMSNBEIoQTZU6sq/t0u4cX/uVdr23
         Dz2pg2B5opjkyW5cvvv4SBuw3QtVo7eWu3v9npQN492SzUf/WkJudObmBxAc3oyPiOJ1
         /FNSZHr81CoTKsGIWRNzRTY7qxj35lNyZbKaLGejx/rx3k+Uko/zIxfRW/38RAImye/p
         MSbysA3Glsn47VUJ9tPvD9/y55X+r3IcsWow2YcNVZ828T/O/0+fENT4Ag4slh/KKMve
         evst4mE8EmsvVD+1Sj0ALwGPSht0iJdLNw0s763Aml4kEaTJd2lab//babVn5clbiCyl
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524654; x=1726129454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=Tcu4axgQ4Z6iS0qid6xM748kxaEV8/BVbZmNWVmNrTKwLaU3rfP3RDJ+vm3ZiquA9i
         UVesMX4xwv2UOAcGjYBGRrTiZAhdq2MA6L7pqIxPxLxWYHCnwrNuVlTldVS644ac7DOV
         hLHGZxDda9fky4Pri9T8QNLf3JLnD6ziyGqAR7HD6RlfTDU+9U+GwdN5yyxwBUlz0sOt
         8apDxjPRe6/N+m68ZF3sV7jdyNxttL9eeAtLA0NVVPjUWuZy6m01RLPsYDc7VNS9sgYR
         iyqMF/ECKsMa/LktanP+WiBrkC8vp8M6ye1REn9+ELF3GStjST/hsGyuNQHyJ3GxT1x+
         ez8Q==
X-Gm-Message-State: AOJu0YwOYuBHZdOqN0HtXN4flbJTL5AGEyVWhcOTinZZni8ZS1DcoF8b
	Y5Yul20LvTRBa9m7Co/oBiXQHGETOI8GwyHadg7nbhFlooIgeA80KYYibcQv0evwLeI2QvVNU7M
	4eLQ=
X-Google-Smtp-Source: AGHT+IGysHzpaI/D+IHLYDFtgbkl4iiw0+CnPgXwvIIR+LDXrAkqivGsmmQIUYkaxNsMKt0GYadSBA==
X-Received: by 2002:a17:907:72d6:b0:a80:788e:176c with SMTP id a640c23a62f3a-a89a35ceef6mr1707691766b.23.1725524653974;
        Thu, 05 Sep 2024 01:24:13 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c80sm102300366b.174.2024.09.05.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:24:13 -0700 (PDT)
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
Subject: [PATCH v4 3/8] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Thu,  5 Sep 2024 11:23:57 +0300
Message-ID: <20240905082404.119022-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905082404.119022-1-aardelean@baylibre.com>
References: <20240905082404.119022-1-aardelean@baylibre.com>
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


