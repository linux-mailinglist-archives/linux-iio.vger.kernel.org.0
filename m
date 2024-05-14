Return-Path: <linux-iio+bounces-5041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9428C55B0
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4871F22D53
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85436BFAC;
	Tue, 14 May 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iICkAfPQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048D5FEE4;
	Tue, 14 May 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688196; cv=none; b=L3/mXybAMMO+BxFnNxyC1fATCZOuIcUgTfQHZzwPGSvVeaU6JZjjtgG27EmcTAYOvIMIsX+ZmYjSa9Ue4FGfKbJ+khaOAF3EDm8GTgItCOJRtexIVOvHiHK6Nbe5QFqE8irKv78qVKIiOQBdVux8FTDhn18phSsAfz+dB0iXUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688196; c=relaxed/simple;
	bh=EQWvzqoU04KDHd33CkauRp+nkwkc/ti3p0XhQIZRmF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWnZpFTFQ9/ynNADtR1VT7+CAIHwWmg8TE9Gj1o4mnKDG+cWaqC6CUJN8tGXmOdOUWB7y2Okk8lxftG0+qoazEoafKblKh/uGCei4OOO3AGMP34a57EWVOAyn1X6ZX9NXtS9cIDxDGBg3mb17l9vH2RCAhLiLd4hHFvkRBqTSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iICkAfPQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so22723525e9.1;
        Tue, 14 May 2024 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688193; x=1716292993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ClX4/6SPoY39TuEqmIN0lGGOvZxu0o0KST6aWhbYc=;
        b=iICkAfPQY6uxqQfWx5ydMROt6xlzY8iozChfKRq1Rc9g4phBkh7QhzujjwI8cUyy9v
         +lsHJk4CyK2x9nuKqc71lx1DWihE5ZONWGzcdI4jpCp4uXpXhE42fA36Y8xmpPNCfdfr
         QUwf8Wr2exAcgsR7q4CJxWj41ynPey/6QndZyztvzi3YcD50pt2NEB55gOa395Ho9Bbp
         py23KvaucfV+PoHRaYO0UC1nIvScDrRLZ7nEum8I/hpImq4qSlk69i24w0z6hDnRH5+L
         inNz01ze2s76HLc0H0Xm2YTW/f6k261ugMNiErmWWezjTKy/oWxG8k8jKjw1BdtYk1Gq
         O12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688193; x=1716292993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+ClX4/6SPoY39TuEqmIN0lGGOvZxu0o0KST6aWhbYc=;
        b=mzBuBSQ7DqCDu0ToAruf933jnyLGI/FpNU16X5QA9buoTDhJax20C7T0lhB7ZKcLSO
         vVTAxIkIgS39bWcN9huILWgTjM51BFjD8jtdBICYH/+LpXO3Xb4SoVpiXrOYHExNlj0q
         sMkwfNwD1cAzHUxEv2Rc9AmGBKb3sivMGvtopGAS1Xn1lUvFtm2Y2F8LDvjlaC12Cy9w
         1O6ydzOkZ9rwXjKOHnUP4gdxnLtrONzZTE8CP2TpStL6NCM8yiLS/eoSuqDEO8lUGLY5
         YFWDtiAIlhA38DhrxpwyibiLFemIZ4G7I+u/oaStEl9UKQ/uKxqXkWV3oEiXTptYIHQI
         hTEA==
X-Forwarded-Encrypted: i=1; AJvYcCV3nTQiPt8Oko9Tnc/Y8Gk31uXSs4XucQpl2tZJwVSC0r3RDtDX4dQjirFAndfIRxOddTWzj7odbsf8jUIOx4f+f7OXYATmx5G0jrDfV2gFo4eh2YSnpG2iOp2W2G6yQUdODGrqOD9/RKQ842uNm6xlEqJcyTuy1j4mkLylniA/E7Ra8Q==
X-Gm-Message-State: AOJu0Yxu1G1bM+m8DKDH8mvSNv6zFltonT9ec9hByPGawL9qIJjrGLT9
	VqALbOs7QkQF5tWgO0LHEG2EsAfRDjzudb3yewQvWVUxwJBWdYhq
X-Google-Smtp-Source: AGHT+IGwC791NsX0hJyiZ+f+Ii4Nij4DHtoJr93rsArexxpggsnaf8lP60pdL/XPpB7KmwinMiEU0A==
X-Received: by 2002:adf:e983:0:b0:34d:106a:1bd2 with SMTP id ffacd0b85a97d-3504a61c827mr11643599f8f.5.1715688193184;
        Tue, 14 May 2024 05:03:13 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:12 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 3/6] iio: adc: ad7192: Add aincom supply
Date: Tue, 14 May 2024 15:02:19 +0300
Message-Id: <20240514120222.56488-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseudo-differential operation mode. AINCOM voltage represents the
offset of corresponding channels.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index ace81e3817a1..7160929d32c9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -186,6 +187,7 @@ struct ad7192_state {
 	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
+	u32				aincom_mv;
 	u32				fclk;
 	u32				mode;
 	u32				conf;
@@ -742,10 +744,24 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
+
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			/*
+			 * Only applies to pseudo-differential inputs.
+			 * AINCOM voltage has to be converted to "raw" units.
+			 */
+			if (st->aincom_mv && !chan->differential)
+				*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * NANO,
+							      st->scale_avail[gain][1]);
+			return IIO_VAL_INT;
 		/* Kelvin to Celsius */
-		if (chan->type == IIO_TEMP)
+		case IIO_TEMP:
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
-		return IIO_VAL_INT;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
 		return IIO_VAL_INT;
@@ -1052,6 +1068,7 @@ static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
+	struct regulator *aincom;
 	int ret;
 
 	if (!spi->irq) {
@@ -1067,6 +1084,35 @@ static int ad7192_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	/*
+	 * Regulator aincom is optional to maintain compatibility with older DT.
+	 * Newer firmware should provide a zero volt fixed supply if wired to
+	 * ground.
+	 */
+	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
+	if (IS_ERR(aincom)) {
+		if (PTR_ERR(aincom) != -ENODEV)
+			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
+					     "Failed to get AINCOM supply\n");
+
+		st->aincom_mv = 0;
+	} else {
+		ret = regulator_enable(aincom);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable specified AINCOM supply\n");
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(aincom);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AINCOM voltage undefined\n");
+		st->aincom_mv = ret / MILLI;
+	}
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
-- 
2.34.1


