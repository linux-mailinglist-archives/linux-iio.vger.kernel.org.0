Return-Path: <linux-iio+bounces-8097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1B942EBA
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11471C21610
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF61B1436;
	Wed, 31 Jul 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN5QTO1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB1B0116;
	Wed, 31 Jul 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429453; cv=none; b=kxrthk+4qqQNfYeaMtongu2LeuxLAdq9UvAo79mcnAsgDsARJdJoq50KAz/dJDgyUal11qL9wrnwDWYoLyyTIM74PHyMhtGzfbVEG92PTfN4xWbTaJ4BQJhKIxeOuD88PNLoFRTcC2bZIKUAjEnJo9jcfux76go47oGeOpha2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429453; c=relaxed/simple;
	bh=dMyvbSpcAGD9BOQyyqG+nihowEhrRM9wLwe6KGiU3oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skk0H7z2binn2NEdVs4ELUAqBFhWCp3C/9yrOKFq8x79KEGVUflS+MZk1M/vt9v4B4JjbtjFGODJtWswOSl7pUsRBUWPYWi7TWNsG/AGk2LS7JMkS0QlE9eFCfikkFNaAXAopEJhDXp/dyuWheyVMExqhgZmuwM0SsLqNHKhwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN5QTO1r; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso78032211fa.2;
        Wed, 31 Jul 2024 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429450; x=1723034250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LS2KS4OhAjr943Ml9EsvwJpcwB4lNojCByA1HCauwsc=;
        b=TN5QTO1rDAVBQA5B7SSEWGfoMEvRSqYKkEeNiJbqnEQJBoiz8BGfrLincHD1CP/0br
         0mYepnUdB+LN0SqMB/JHZGV8BY/9iYBvOeig8Fn6QQ8saVjZi9IWNEEuDmd8YE7pMc8C
         GJ2SDW4h4QPd6XNdw3vqiEK/i9Cnm32RKpOlYaRj9SUNPjs6RqR7nrT03UaHLhzykOFi
         UexkxxZ57dzG/aCQLIdBvNvwIzxeARHrMZlHOgoTlkPjOo0DvPqqKR7MVzwWdQcFj/zv
         6r6TP/nko7oicnyWIL/0N4bbamzaZb7obVRJVmVDf4DszqRIjO56P3Vh8UCCpZQcYCOW
         q2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429450; x=1723034250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS2KS4OhAjr943Ml9EsvwJpcwB4lNojCByA1HCauwsc=;
        b=W77ETmXJlGIz9PJUtPFpzeM59iNhYJ5KasDhloAxp4/be7E2xMZyk3Ct93WFEllQhn
         v69wbvJRslgqGavCWitNXB/Nb/gHRyqj3AyCA4UiRZV3smbrL6k42I2PntbbRMtPkjWh
         zFAE3VXLTkFHcl7ThZcYWQNSvfIshE9NL6S26YPu7fuE2Iyr2wMkMCKAqU1k6wA2VLnk
         iPdee3xbiCN/f8zOcx6z7FqNCYCHV4KwvZfR6VGa710XN+Zi7NkYYf8+Km5a0YR77Rqm
         IPPIZjNTtP2Vtu3EBpqZ42ajVaNUtS49e98IyeektMBl2CUvyQrQ3WX23asUe3pQ/Rht
         8gpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ntzdro1R+uU7WZmEB4R65I6sfZ/RKeKCn7AsyFVpUnLLkNXUzMIhB0z0yH6hHHYrI2YMXAvgk4ZfOmT47Nh5s591s/cNC/Q4u+yZEeNbB/kqo87k+AUpRh6BN9SDZQXvNimuDm8Z
X-Gm-Message-State: AOJu0YwEfXtm58Rqrwpj3DzV7NrcIsZoOd1eI9Gm4ksoxJmH/SqqtDCV
	IwkAPZvVyb94TNB4MY2pcUK34GC6y5PbMWdA9Jj4sWjJZhTSdfUT
X-Google-Smtp-Source: AGHT+IFaSbDoJIt1Z+vCsWx5cgKWLIKUsqBA0JIq9bUhUC4ptl0RkIID7s2994GEbOjsiFW+cFCzgA==
X-Received: by 2002:a2e:7307:0:b0:2ef:26f2:d3e6 with SMTP id 38308e7fff4ca-2f12ee5bd37mr92441121fa.34.1722429449656;
        Wed, 31 Jul 2024 05:37:29 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64755sm20600465e9.36.2024.07.31.05.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:37:29 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 31 Jul 2024 15:37:24 +0300
Subject: [PATCH 3/4] iio: adc: ad7124: reduce the number of SPI transfers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7124-fix-v1-3-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
In-Reply-To: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722429445; l=3323;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=dMyvbSpcAGD9BOQyyqG+nihowEhrRM9wLwe6KGiU3oM=;
 b=g4bNkivIFh8UTEABqE3XBiMneAMWGvetwyulS9dMpTy4/h1BpYsOJFEA+4ExAxIsLRhTBUgW9
 l8gbzrHE+jNBGDopDFtaqN753FoLV2soQYN+cpyCHK05PhiJLqyjH7H
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

The ad7124_init_config_vref() function writes the AD7124_ADC_CONTROL
register for each channel that is configured to use the internal
reference.

The ad7124_write_config()function performs 7 SPI transfers for
configuring 2 registers: config_x and filter_x.

Reduce the number of SPI transfers:
-during the probe by only setting the st->adc_control value in
 ad7124_init_config_vref() and writing to the device only at the end of
 ad7124_setup().
-in ad7124_write_config() by grouping writes to the same register.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index bd323c6bd756..4d63cd5c9d04 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -382,8 +382,7 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
 		cfg->vref_mv = 2500;
 		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
 		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
-		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
-				      2, st->adc_control);
+		return 0;
 	default:
 		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
 		return -EINVAL;
@@ -401,24 +400,17 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 
 	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
 	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
-	      AD7124_CONFIG_IN_BUFF(tmp);
-	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
-	if (ret < 0)
-		return ret;
+	      AD7124_CONFIG_IN_BUFF(tmp) | AD7124_CONFIG_PGA(cfg->pga_bits);
 
-	tmp = AD7124_FILTER_TYPE_SEL(cfg->filter_type);
-	ret = ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot), AD7124_FILTER_TYPE_MSK,
-				    tmp, 3);
-	if (ret < 0)
-		return ret;
-
-	ret = ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot), AD7124_FILTER_FS_MSK,
-				    AD7124_FILTER_FS(cfg->odr_sel_bits), 3);
+	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
 	if (ret < 0)
 		return ret;
 
-	return ad7124_spi_write_mask(st, AD7124_CONFIG(cfg->cfg_slot), AD7124_CONFIG_PGA_MSK,
-				     AD7124_CONFIG_PGA(cfg->pga_bits), 2);
+	tmp = AD7124_FILTER_TYPE_SEL(cfg->filter_type) |
+	      AD7124_FILTER_FS(cfg->odr_sel_bits);
+	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
+				     AD7124_FILTER_TYPE_MSK | AD7124_FILTER_FS_MSK,
+				     tmp, 3);
 }
 
 static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_state *st)
@@ -906,9 +898,6 @@ static int ad7124_setup(struct ad7124_state *st)
 	/* Set the power mode */
 	st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
 	st->adc_control |= AD7124_ADC_CTRL_PWR(power_mode);
-	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
-	if (ret < 0)
-		return ret;
 
 	mutex_init(&st->cfgs_lock);
 	INIT_KFIFO(st->live_cfgs_fifo);
@@ -926,6 +915,10 @@ static int ad7124_setup(struct ad7124_state *st)
 		ad7124_set_channel_odr(st, i, 10);
 	}
 
+	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+	if (ret < 0)
+		return ret;
+
 	return ret;
 }
 

-- 
2.43.0


