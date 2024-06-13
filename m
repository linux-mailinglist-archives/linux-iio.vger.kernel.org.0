Return-Path: <linux-iio+bounces-6234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E282B906B71
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6518B1F21DF0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2DF1442EA;
	Thu, 13 Jun 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKpuVYd8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A521442EF;
	Thu, 13 Jun 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278832; cv=none; b=L7KIi5HyDHC8GZ+n7OKKDEevS2Jnz5TqeVWT0dugrxRalj28RD1Utdal8ZvDA8i4c+giFcA+6I5SlJiANbGmchoNwwN7A+VC7BQ38bkGtDNQkIf0MikPgWmjkaxHjPVmqcgqJgLH39QautDGc5xrdc0ZOhOBFlip0g4KEQZMx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278832; c=relaxed/simple;
	bh=UNJKY1APu8hC8tnXQbVXTO0anEd3Q+DEYeYTK/oq3lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/eToNVbcnnKiINolEQQw+6nSo7QvsBCyFU8rXZ31Bl4o4+q8IIcBU7fne1VdDYbICzLwNgkePSTEVDYBhYtp35w1Z7/ALcDKRvgn+Ef8wY3TAT0VQszS7dlQvkvVillLyYT4JzOIw2w8+Lu7i77CIWhDAb1QnQ1kcLSAg1Oieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKpuVYd8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so963479a12.1;
        Thu, 13 Jun 2024 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278829; x=1718883629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHdK21MQAj7eMH+wey85S101XtvAaeCIG2tAjvFarww=;
        b=NKpuVYd84SQSwTjbxS4x2IT6gbxgPxE4UEisBOvQcEHJzQUghuhlM/xakUBEqekvyi
         iWslaYX1/rfZ89kDlAEskaq/qMkbRbA2lFkVfj5ILOXVjaKmklwanbpGhXCAgIIImTyA
         c3pLeFSCyVt45J8yCUk2MNzCRjzA7BTDNR1xS1bNEO44RYS7/h+R9UcfkXI0PPxBhUOb
         ksAip2JCduSvDccekv8OskjZG8tr684VcKI9fSMAxjWvrsyeklmETQPh97yslJv/llWN
         hbv5JvngjMVc2q6tfM2LXV02FcDWSVoyuoroNzKo1+RrzXWSbzIm7f/KLcgx/mu3Tu5+
         m6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278829; x=1718883629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHdK21MQAj7eMH+wey85S101XtvAaeCIG2tAjvFarww=;
        b=jBnchF5nqKkYetvZqxsECFqLylkUtWazIn0mMLVM1RvWo46GZIeXkI1K7GXnBO632f
         O5sHps9j4LoollfoCg8a2nUfMmCmZcVXQNGS1qVLmi/fCgKj9D5onAYjSQDUwpO8q3Tr
         GcBMPIFe/D7ygXpaUrvsWxI4KJAOaH8eHu3VhFHz0wXO2lndvlIiU33GcYkFcT+d0n+g
         S2sB2ulYxQzG2r7XyMFIMZG3I/3L49CgnQTdkAdppjRDc+IOypM1Tt2IZdbeaXAh8NPg
         x/tPNuPTvfTjf7JUz3fzY1xRa5+wGs18SVUcsshwSj2gQeqytpqsajkv9AMK8Iw0sfCS
         i1PA==
X-Forwarded-Encrypted: i=1; AJvYcCUNO5JnLQH9a7BY/Cfe+iLW3IEcNqlJ2mszaQNvyTtkqPSdCLCgzovpM5qKfhMDVFHusBEKlhSQW6Nu5gxDITBl5R51y7DDEeBJ+o5uJoBAjnQvnToEyFd1oPB+72Lg93re1vjgRaWcTEqZKNfmJKAtZXuaajaZBEAs5gs8yGtXqvBROg==
X-Gm-Message-State: AOJu0Ywdxpns4ynSLYIw3ve4d1C+6pMqJuU0W7xNx5KmGg7vzGop4EIT
	i0i44+sf3ackRUhYAY3D6C92o4oyTXVbtE0BtdlzzbdeAB5WOc2a
X-Google-Smtp-Source: AGHT+IG/+WcR4oE/o6/dLioL19QyAaoUKov0Fp6szt5bO/Klws3koFzKmvlCQ+7RQXVNH4zlOqvkzw==
X-Received: by 2002:a50:9f6a:0:b0:57a:2327:d2d2 with SMTP id 4fb4d7f45d1cf-57caaacbb4emr3120531a12.29.1718278828531;
        Thu, 13 Jun 2024 04:40:28 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:28 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 3/5] iio: adc: ad7192: Update clock config
Date: Thu, 13 Jun 2024 14:39:59 +0300
Message-Id: <20240613114001.270233-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613114001.270233-1-alisa.roman@analog.com>
References: <20240613114001.270233-1-alisa.roman@analog.com>
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
index c7fb51a90e87..c30ffe47cd70 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -398,25 +398,37 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
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
@@ -1306,21 +1318,9 @@ static int ad7192_probe(struct spi_device *spi)
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


