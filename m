Return-Path: <linux-iio+bounces-6209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E599054E8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713B41F2212A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A617E450;
	Wed, 12 Jun 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP5tmI2Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2D537F8;
	Wed, 12 Jun 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201848; cv=none; b=cy0MSUx595pIoLt1WFLjR48EL27Y5F0R/mwCLoatN6uGZJxp0i4jnm3jVaCG6uoyzBxD/G8GHkJjaKwP0U+m3Gj3TwhaZGfsSHHx4k/JSYm60kivZlkWrWtDV9ZbzOQTV2b+aD9kFyIAp9w0tvHiYx8PbQwuQxhTQCa7F6bZH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201848; c=relaxed/simple;
	bh=Cka+oLL1qhMjYwntvJYzxyxhdG6S7GtJtZp7v19EnZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VM8ZNjil6fUtyvN7ep0sfVPyxSqkr/82jBo1OCPnKp/HWMnWbmW7wU7ujWfRTrleLTr0zuKSxQj93+oKtVELKsUgGq5r/r1ScHwyw1XIucsa69l6sZzsTPp1YRk7Qbn74mIbsc8oilptqADjWNtTn50mi4wn3g17UxAAIzArbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP5tmI2Y; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebed33cb67so25600301fa.0;
        Wed, 12 Jun 2024 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201845; x=1718806645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hftruIW0KQj7Pfx4TS18oMb+ZkfBePj5jiEFqzrWZWg=;
        b=BP5tmI2YYguGAXXM9PwriQ+/T1PXlXoIkZWyjgNIAZ/J4n9T2r4W4bY6jijT5sPvx4
         UQHPHPpQewDppVi0Klv6a3teHvgn0f33HWT6hVbOACjsV5Mpim8oNbUSnppRt1MElfH3
         Xct6BtyT56NOmAOTtPw79L/iiXuvWcRGuI3JCaPxIO+0xYMpDJtfPorb7wvmxDtvDRJc
         2s2d+ntjWQn0HSoh/+lBj9hRh9pAyGEETeLbYyBuxz0BoEippOrtBYJfV9mjV8+/C5Q0
         vZVUNNTSxlKA+oWdXxtDEpKvTHnuKqsiAaTgTM/ooa7SVkj8JErhUl+6B7nUiO88/LAt
         lbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201845; x=1718806645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hftruIW0KQj7Pfx4TS18oMb+ZkfBePj5jiEFqzrWZWg=;
        b=Rf9atYgn/Kew602VRBwAYMSRDD/tXqWSRmiU7Gdku3DkDangITxV0MbcucF8kDH1nX
         WZZ+p+GpxB/5e/yhgSDjxe+M5/PrgOjukhYsUPDPn0pxjwZGCVzcFPd9H4ywz4mEynmY
         2ecUy5crtN4EARun75upqcviWLva6nSm08l2Qq4LruicRSTpAsTbOvrUix9ZG4qVONr3
         vv4JbMqj9NL33KZGwQbvPXR3ABkIZUhWSAh7cF0gPaE2BeYfQNA2zkBQewalHZUwb2dH
         2L3gjbPYJqRwfvVS7ezHm+2WlWZky62mmvnw7vUZ+xabOdKLfAObU5F4mXOLlU8sQFn7
         97+w==
X-Forwarded-Encrypted: i=1; AJvYcCVYLf5At+9J3NxJ+jk7/vzJFnxTND9vW61CyVLLOwEEpcsEeBuYRIxVMSbviSQIfdA2fXCd49kZwi8YKcudtEUf4UV3f3gO2V69akrZ8EdLjKMBEWJHc+w+uw0DhzIKoJdDOEaHBa0oMpqHQjwYoLh4qZ9EtAbDPmBnFc4HpPDnnM0WbQ==
X-Gm-Message-State: AOJu0YzzNCXYcEqssjTMSgQYQkU5TOiEwJ+DapTekPOGOYd7h+oTxaWN
	9wuc4qjzM7zbqpD8eXiPKzltAwNiRToXKizXVN9BY1wJvKI1MWEYclW8fg==
X-Google-Smtp-Source: AGHT+IEyojmlqRV1j5JToSMRqGnGC7P7tl0M87Hr7bR15LwdmLXzWPjaQbZtXzYOKxKnqTrKVyaJwQ==
X-Received: by 2002:a2e:8508:0:b0:2eb:242b:652a with SMTP id 38308e7fff4ca-2ebfc8bbde0mr13764651fa.15.1718201844912;
        Wed, 12 Jun 2024 07:17:24 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm27876655e9.9.2024.06.12.07.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:17:24 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 2/2] iio: adc: ad7192: Fix clock config
Date: Wed, 12 Jun 2024 17:16:37 +0300
Message-Id: <20240612141637.175709-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612141637.175709-1-alisa.roman@analog.com>
References: <20240612141637.175709-1-alisa.roman@analog.com>
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

Note that the fix tag is for the commit that moved the driver out of
staging.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 58 +++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 0789121236d6..2301fee9ccd0 100644
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
@@ -1309,23 +1321,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->fclk = AD7192_INT_FREQ_MHZ;
-
-	st->mclk = devm_clk_get_optional_enabled(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
-
-	st->clock_sel = ad7192_clock_select(st);
-
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
-		st->fclk = clk_get_rate(st->mclk);
-		if (!ad7192_valid_external_frequency(st->fclk)) {
-			dev_err(&spi->dev,
-				"External clock frequency out of bounds\n");
-			return -EINVAL;
-		}
-	}
+	ret = ad7192_clock_setup(st);
+	if (ret)
+		return ret;
 
 	ret = ad7192_setup(indio_dev, &spi->dev);
 	if (ret)
-- 
2.34.1


