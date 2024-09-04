Return-Path: <linux-iio+bounces-9119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95C96B2D1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10F11C23630
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A5145A05;
	Wed,  4 Sep 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0eFx1Yrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4B147C9B
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434853; cv=none; b=nRNzgo2ROrgRHVweMSTz0iPKoOP4L4nzYHth4+XopThahWoSjwOgHEmSht2NK/hT4Wn92i8/Ed0ebw14sEOt7pw+xOGjLLmecoKxzcxTgB7Nc9Y8pKRQFkXR52Mn4TkBPRUZIKE/SqsfRdilBogIo1MN4BUAZ1C/kN3zzzpFQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434853; c=relaxed/simple;
	bh=9wWTe2RhHwvr6CPLWLyUmFQssffTJWZ48+UUgVNgMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbY6Ine83Hpte4aUo9tc1HSZCMJI3VxDGPI7rLAUEHksnP/VM7jTC4RZ7LvLiQnjB8s29rMUpRFzEQArMjS313J7CPvbFsowZ3HJgO8MZKZ+ZlN0XRXqbx+z/kyVdOjD9PcxOdwfvtZUXsBY8qwEee/7OEbdKoMAdH8+N9Qx3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0eFx1Yrf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so671054966b.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434849; x=1726039649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=0eFx1Yrfw7N7xYhkkA5vHA88olJeRRpREO5IVGFHeOeGKhlR+cDpL4CrdBCZSGP/Rq
         Q7mx4hNQDRSaOl0rWMk5xeamzq/UapJMRn9XQn97iXoI8lpZqfs3DgvIaSWBK8z+iuQ5
         hEoSm28blGaXPHA3vMhsnROScC25jRE08igNTXiahJtitAgT3YK/HQ4YBC5fcV1mDmhH
         QlSdAkRiraghgrhZKW0VvRGCLoOWINwtL5FoyWEbenkfniRi6tA/QWVEfA31E2OSPVLA
         f2B5NVsm4jCqbSHL554Drf8org3FZ6AydtRwyClRCBKaHQM351+c62ujTx8AESgftUlz
         inFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434849; x=1726039649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=qtRzYCKXq+QRO+TcjnfGA4kOs41UDcrQEZmHlE0LKMvTCGbCPu0bHStmeuR4+7FIqv
         rIOFK11tCCfWzYZsp8OfA7kiJYtDvkiEfPT1F4lrS3f1AetIX6KRmQbPeQfggxrwQW4O
         KmKr2uXTomHZBvlWmHm3m/FueDlBGgbN8u5ol623nQ5mdEK00ha+nD9+RtMC2Oz28FPP
         spqQ+4Uq0qnKDjCnCpvM5FLYrivEFFp0DPrTDiDLKva2+DDQiHNQZNVNposJsDDx8SH6
         MdKeJ9bkLchcpSFK9kP2gpeaKIzQgEiHBB9R2dZHylADayygugYEjZe/2yzLtoOj8VbV
         0dMQ==
X-Gm-Message-State: AOJu0Yxlp7aR8nYzzbEkONF9KE6OEl8Agg46TjR5QZdBzrkdXWWuNJ+E
	JBTO3ln+CAhJB37PNbGJNwf0MZhsRmorTfB0qH0wROMmxAM0ngjptzgzi8qsLmF6KZmw3az0CPm
	Aycs=
X-Google-Smtp-Source: AGHT+IFxShxDEqQPCTID74bNivAq6VaYj90mx3GbIAXzgKUqBSXXWdkkh79iRCw/9aQKfxR56BcRyQ==
X-Received: by 2002:a17:907:7e8b:b0:a86:6da9:72f4 with SMTP id a640c23a62f3a-a8a32e6dd5cmr265440566b.17.1725434848384;
        Wed, 04 Sep 2024 00:27:28 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:28 -0700 (PDT)
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
Subject: [PATCH v3 3/8] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Wed,  4 Sep 2024 10:27:11 +0300
Message-ID: <20240904072718.1143440-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904072718.1143440-1-aardelean@baylibre.com>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
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


