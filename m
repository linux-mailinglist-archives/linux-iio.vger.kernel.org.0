Return-Path: <linux-iio+bounces-6504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034890D581
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08934282930
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8EA15FCF1;
	Tue, 18 Jun 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN6RUvMy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF715EFBB;
	Tue, 18 Jun 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720534; cv=none; b=MN1zHSvJNhG3/rm7tF4uxuZwiQnogA7Do3h0XH86c39tzBs0EhDAI6KZ/tAHQyqwsVt1kNnGIQ61xLpEjekJd8S3B9NKEfVbIOebS5iWzTzv0L97h/pxfGFfkkMKHmPSd+hxR6/uLmCqPN7gmKqiuUQvSmPs+Iuf6w9v9y4lTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720534; c=relaxed/simple;
	bh=1RfKCKRM/QHk1sWWcHeNZ9DVL0BehZVSe3/VONNmJOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpMYMpT58+wOQkmYpG+KOyJmReHOgw2gthu213DvSZrCaBHg36JtjidK7S8wrrcGOwyvp1QhFx+3/YMxd70XI+n0/QpwqQ6CyEkPKoazwpjIJTrS4XRHVP1XefgKVBDUGrmBYIzVw+BwjBzYNI76dVJoloAsxfs7eolcmO6/k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN6RUvMy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef64b092cso685350366b.1;
        Tue, 18 Jun 2024 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720531; x=1719325331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgBScQw99cAyuq+khOD513QlHP8xLsoTlTlZ97Pvf2M=;
        b=aN6RUvMyWklurCKhVAVwuq2+ooc84NAkYglqMZa00MyMLIKP7v5bcZMpAjaGUToSeU
         tM7vmUvPvDMzpZ9lul88j5gBLiCiZUdcUV4BmnXmLhZxROXXivigFILv/igVS3NB8TNn
         n+IwVjJIuqp9TrhqDSMoMn+saAr8M/2CkIe6sSvhyiqJWGgsf025rIcVitdUrJ1VD9zj
         93b2d0TgXMwUmiel21/GiobNwruuSblpBNeivzn/BlDk81oecvworG6/zs8IKECI3/JN
         UDWEsXL7XA1peMFBMryA+G4TSaI1hzJuSJsLdNjc8EXhNLz6MyFMDxN6ZKivIMysK3sN
         u86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720531; x=1719325331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgBScQw99cAyuq+khOD513QlHP8xLsoTlTlZ97Pvf2M=;
        b=L0RuNx2JxYQBPQmLB4ThTW8oq2w5SXGyFvCUKGIlo9Bx3cVCNrGgIoxxT43mT2YeUW
         bz2NhQ0IKwsOsC4zdRTypbGhB3otHI+6fSqpwv/mOV6hvzpY4mBo6GkDKANFarzqj/z/
         mbU17uytvCF7s90wif7MFGSTcFUqKn6BF2L/bU1u0D+q7w0ITgI9bYiKyF2i+1V9AzHK
         GQ3QXhWJ9JfXT/C/2NuCv92pV6xJpqIjbtFiQ0p0VRoX1bD8YkC3oTbKTubSlgLjbP+v
         tEk/93AvO64g3V49jh1MtVvF3CjwL14rSXRyNKxBZH0hDt1zf7wyUX/+c+GL1bKyBcbR
         /DkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7MOstn0f5lkM0j/8PIQvGnzkkOEBf4EAEW1S0/rhG3ARPmO6YypJDod6MzgQ4bRZgV/sHoyljovRM52NI35i1fNy6WSFSVUG3x1hLY8CjMuxAzwfIJyAoXU174gueK+x71feOe4N/RQowm4aySURmeHqspQRX5Q9LuoorwqOlmjJ9w==
X-Gm-Message-State: AOJu0Yz1+bh+N995GS1ElJqpG7CE4pRnfJXVbL+wH3Pu7FahIpiAfOZJ
	hzY8Al7IBR6nj6hL3pN0fGdbLgRxB06VcBap7P8CmynR8IuBgywf
X-Google-Smtp-Source: AGHT+IFzsl/INZiexPN6RwG5b3xBE2cKSebqZVnKxdW9dhSsBM7HcLIszJpEKpOi4NCAIqw0CC91WA==
X-Received: by 2002:a17:907:970b:b0:a59:b590:5d71 with SMTP id a640c23a62f3a-a6f60bc9ac8mr1068279266b.0.1718720531274;
        Tue, 18 Jun 2024 07:22:11 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:22:10 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 3/6] iio: adc: ad7192: Update clock config
Date: Tue, 18 Jun 2024 17:21:35 +0300
Message-Id: <20240618142138.520192-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock.

Removed properties adi,int-clock-output-enable and adi,clock-xtal were
undocumented. Use cleaner alternative of configuring external clock by
using clock names mclk and xtal.

Removed functionality of AD7192_CLK_INT_CO restored in complementary
patch.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 334ab90991d4..940517df5429 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -396,25 +396,37 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_clock_select(struct ad7192_state *st)
+static const char *const ad7192_clock_names[] = {
+	"xtal",
+	"mclk"
+};
+
+static int ad7192_clock_setup(struct ad7192_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int clock_sel;
-
-	clock_sel = AD7192_CLK_INT;
+	int ret;
 
-	/* use internal clock */
-	if (!st->mclk) {
-		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
-			clock_sel = AD7192_CLK_INT_CO;
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad7192_clock_names,
+						    ARRAY_SIZE(ad7192_clock_names));
+	if (ret < 0) {
+		st->clock_sel = AD7192_CLK_INT;
+		st->fclk = AD7192_INT_FREQ_MHZ;
 	} else {
-		if (device_property_read_bool(dev, "adi,clock-xtal"))
-			clock_sel = AD7192_CLK_EXT_MCLK1_2;
-		else
-			clock_sel = AD7192_CLK_EXT_MCLK2;
+		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
+
+		st->mclk = devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
+		if (IS_ERR(st->mclk))
+			return dev_err_probe(dev, PTR_ERR(st->mclk),
+					     "Failed to get mclk\n");
+
+		st->fclk = clk_get_rate(st->mclk);
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return dev_err_probe(dev, -EINVAL,
+					     "External clock frequency out of bounds\n");
 	}
 
-	return clock_sel;
+	return 0;
 }
 
 static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
@@ -1275,21 +1287,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->fclk = AD7192_INT_FREQ_MHZ;
-
-	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
-	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
-
-	st->clock_sel = ad7192_clock_select(st);
-
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
-		st->fclk = clk_get_rate(st->mclk);
-		if (!ad7192_valid_external_frequency(st->fclk))
-			return dev_err_probe(dev, -EINVAL,
-					     "External clock frequency out of bounds\n");
-	}
+	ret = ad7192_clock_setup(st);
+	if (ret)
+		return ret;
 
 	ret = ad7192_setup(indio_dev, dev);
 	if (ret)
-- 
2.34.1


