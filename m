Return-Path: <linux-iio+bounces-7661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F09343D1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1274DB237E6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8418C353;
	Wed, 17 Jul 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzVhWP2Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F718C32F;
	Wed, 17 Jul 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251561; cv=none; b=i8iykbuwb7pkWGtLbuwv1XGltOfdTKfQaVqP7MwtD2STEJFNDtsmTHYifZmX9BkncERhKvc4BiDkeMEwY7tbav8UtcylPyyhpE8OjuTqdzdjnclsYiYnj/QHJPE4A96eCwUIfbeG/9EN2TKFGnTuAwO3d3YuCpgLhFTEdEQCfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251561; c=relaxed/simple;
	bh=EPnqK00Zbzb3HGOrZO6C1bpI7XsCkYhT1PpT9l8PLfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfspdmJccy5xe2YAJDnVKwo6MkIGhHLrQU7z0fDjXASBrQ108NK6IdSLQRGpwEhLLjOb7389j2UKlJrZwVWpLyzbHtjNleMbwyp+wnmYH2FCKiI7YPDRR4rr+pQmeFrmkJWDEdj2jPnasJykO3eilYb3SdaMu3y2tWnICyvojjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzVhWP2Z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so825155e9.2;
        Wed, 17 Jul 2024 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251558; x=1721856358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nMwL8aJUa7GifJHTRApBtb5HON4txSFXIHmf17V1nM=;
        b=KzVhWP2Zqc/mkmwU9/DrumDUByF0Gjj/V4MpfqkOAH7G5AcMKMDBqLj3wbaz/qWps6
         DfKKaEx/tmFgavrHvHqn3cHH2HV260TZB7ABzT1fUDKwhtOFYbtnH9o5dXSRN36lkWX2
         W9ozxSRDOZThJoKH8ZXokmoRQHmD4fPwZdas3WCivMZ2qiw6rCof109FKkBycbM1mWO7
         4+AY/dKKHN3kRTQFj2ADTjJ8/AY2T/pK82oiaa+r3V8LDQqEMHLDflDKwKBb8RKRZuzA
         gvn94fmZy2wMGuRjzVBpR5sifZkWMuqaJDfnPqTmAzdWwEl6tiORUltTebT1WDUvA+mW
         3k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251558; x=1721856358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nMwL8aJUa7GifJHTRApBtb5HON4txSFXIHmf17V1nM=;
        b=X11z+xM+stLE1pD73GNxQEL4Kz84U8O91P/Wn5dVcTmxrnIi4jaYJ47dg9zn/3HvC8
         iv6uku6LlYmZMtqCNaMYv0FwnOExjlYSPrIxxAQu7nMj1Jxbmop6zoqva+FM7V7H+jPe
         4pQtqKTJm9DhG2f/7WJ9RKKtU0tXI8baRi76UnIXJ9dvlO2UhmGakKoXPOyQSySPWJ7g
         g1/fqogUHBUZgCN18yZqYNwAj5hcL/5H5Vh4qJx2eGXRDaqlaol6Qx9x5oLx1ud19ne4
         BjEqffVa3f0857mzulP0/x2a3EOD5sqp4eNXgKpI5d4L77uivkU8skAxE9TToO1bQNMM
         FHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVozqjRXR+KtVLa9jRGaoyIO/XhzW6hq/lV6lA9SS5EiJzQ/eLR69l1iXSMBGym5aOV3voCN1X/BIDnzJUZIbHyHITHI81zVhEqfG5pEWAR2mfmis12/TcAKkq7iUdwkuKkseasCVXBL+8ZPN6gHSgiSCRTHxA2AfvmPpUT/Ex9XH+r1g==
X-Gm-Message-State: AOJu0YzqrIcW3nYUDU1gXa3F3irJ5glGsr7/cJSQhcd3vpcx3wzxfW0M
	7IM6YAqaQilWOdC0IrhLweIUkHlmwIoVshyOz3TUDdATWi6IBE0UrDgE6HsB
X-Google-Smtp-Source: AGHT+IE8186YpyhsC3RlwZDCa3EJDjw5UlTZGJXIBrBMFVmM7AEbS5mdadmVyfiiqEpDIZsQdfOWOA==
X-Received: by 2002:a05:600c:1d1e:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-427c2cc97efmr21803495e9.8.1721251558588;
        Wed, 17 Jul 2024 14:25:58 -0700 (PDT)
Received: from spiri.. ([86.124.123.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10532735e9.17.2024.07.17.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:25:58 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v7 2/4] iio: adc: ad7192: Update clock config
Date: Thu, 18 Jul 2024 00:25:33 +0300
Message-Id: <20240717212535.8348-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717212535.8348-1-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
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

Undocumented properties adi,int-clock-output-enable and adi,clock-xtal
still supported for backward compatibility, but their use is highly
discouraged. Use cleaner alternative of configuring external clock by
using clock names mclk and xtal.

Functionality of AD7192_CLK_INT_CO will be implemented in complementary
patch by adding clock provider.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 91 +++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 334ab90991d4..042319f0c641 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -396,25 +396,72 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_clock_select(struct ad7192_state *st)
+/*
+ * Position 0 of ad7192_clock_names, xtal, corresponds to clock source
+ * configuration AD7192_CLK_EXT_MCLK1_2 and position 1, mclk, corresponds to
+ * AD7192_CLK_EXT_MCLK2
+ */
+static const char *const ad7192_clock_names[] = {
+	"xtal",
+	"mclk"
+};
+
+static int ad7192_clock_setup(struct ad7192_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int clock_sel;
+	int ret;
 
-	clock_sel = AD7192_CLK_INT;
+	/*
+	 * The following two if branches are kept for backward compatibility but
+	 * the use of the two devicetree properties is highly discouraged. Clock
+	 * configuration should be done according to the bindings.
+	 */
 
-	/* use internal clock */
-	if (!st->mclk) {
-		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
-			clock_sel = AD7192_CLK_INT_CO;
-	} else {
-		if (device_property_read_bool(dev, "adi,clock-xtal"))
-			clock_sel = AD7192_CLK_EXT_MCLK1_2;
-		else
-			clock_sel = AD7192_CLK_EXT_MCLK2;
+	if (device_property_read_bool(dev, "adi,int-clock-output-enable")) {
+		st->clock_sel = AD7192_CLK_INT_CO;
+		st->fclk = AD7192_INT_FREQ_MHZ;
+		dev_warn(dev, "Property adi,int-clock-output-enable is deprecated! Check bindings!\n");
+		return 0;
 	}
 
-	return clock_sel;
+	if (device_property_read_bool(dev, "adi,clock-xtal")) {
+		st->clock_sel = AD7192_CLK_EXT_MCLK1_2;
+		st->mclk = devm_clk_get_enabled(dev, "mclk");
+		if (IS_ERR(st->mclk))
+			return dev_err_probe(dev, PTR_ERR(st->mclk),
+					     "Failed to get mclk\n");
+
+		st->fclk = clk_get_rate(st->mclk);
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return dev_err_probe(dev, -EINVAL,
+					     "External clock frequency out of bounds\n");
+
+		dev_warn(dev, "Property adi,clock-xtal is deprecated! Check bindings!\n");
+		return 0;
+	}
+
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad7192_clock_names,
+						    ARRAY_SIZE(ad7192_clock_names));
+	if (ret < 0) {
+		st->clock_sel = AD7192_CLK_INT;
+		st->fclk = AD7192_INT_FREQ_MHZ;
+		return 0;
+	}
+
+	st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
+
+	st->mclk = devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get clock source\n");
+
+	st->fclk = clk_get_rate(st->mclk);
+	if (!ad7192_valid_external_frequency(st->fclk))
+		return dev_err_probe(dev, -EINVAL,
+				     "External clock frequency out of bounds\n");
+
+	return 0;
 }
 
 static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
@@ -1275,21 +1322,9 @@ static int ad7192_probe(struct spi_device *spi)
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


