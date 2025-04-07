Return-Path: <linux-iio+bounces-17738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A44A7D8A7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F6C3BCDDB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3122ACFB;
	Mon,  7 Apr 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t5dQ9luL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B522A7FA
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016015; cv=none; b=LZcbD3UVtP3CH4DfO01z1chFCJBrMro6Be/98AWJR5iNuBPJZ7yWBOQMl/LentBISVITQOKseH0wxei5SkIzJATVuuBeJ7I2XiR/kGyAyhr6Nlh9lezf/QNYGSpDNRrenPgeY8J1hDN3qdePIfOpJrOg2f61/zukxC5pkc+R63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016015; c=relaxed/simple;
	bh=OCoJU5I3KSv266Dud9GYmsHSuvkY/G/QdJ0ymA0kyLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGspOrmfDJyW18YByViytOOXCK/dE59ThZw7VIJ27cczWAP8Q2p/+S9+AUPLoOaW+a+SHLzUqBLGLQwNFbWeuJw+pjQqhAI31qwuG4hqiQ59mgtb8rmLHX/I+E78flRYWAgpeL8ZhQq4WLhcsdpJt2+Trti6cv3/kfZcZzsWVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t5dQ9luL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so35752915e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744016011; x=1744620811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHYg6gWg3qo6Q8O/SnNRE8XUeJskhJduG/oZ7vBh458=;
        b=t5dQ9luLTW3NiNFEajHqSP6F/uTWMdjppO953hKmrDzyfqQyV0R8jbZUON7RbNjhmP
         CQOnptnH4i994yFfHtp7tG7CrbyxvQM6jRP9fXUJaPfqrFqLoLfraNKrFXfnDJNBGqvG
         LnrU7SJba//rAmy33++2StIbPRX1vSmcUERrwbcm9YIbMsHOEtVI9MWTJJtTi3sLbor3
         LycKL42fdx5KQ6s5iZfAkYurqZK5MeUBFVqD1HiFv9pyyVPI+2fY8fbOIXu4sjIfEVc1
         Ug54yUG3uLAPQOoDeGIgHcxWsv6keNTEglecCizqXQRbSiL78EflpsHTFPp8t5w7HIZl
         7l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016011; x=1744620811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHYg6gWg3qo6Q8O/SnNRE8XUeJskhJduG/oZ7vBh458=;
        b=qysuweVktj+5+L+YIqu6oa0yp3pupsfM0eyiwY3fdUO8tZ5hZdlfaZI0Q8x4Jh+2fa
         bgxiypwlK2m3uGRD+Ius6+xzpnHSsKAyzlLbeQ1y9JTNMUelgywDRKfy9KIBGaH+gShw
         tppYmFtZwSxRzV2XWVQhnbDd67WWqdWeENUIwTk2b4ueCTp6yifJyj5SIO8EjdtuOsyR
         zzbLJ9pHTPk92PheNZVucVPrbqvWF0AHogeZftgvIZEd1B5a+y9WI4/2Yr1Q7gCxq+pO
         liB0VEK8gThD9n6mQmjp/pGVnlkBBtoD82oEMf+2Hliu0/Nekf2NJ1FWxQDAyVeIWuJC
         QNbA==
X-Gm-Message-State: AOJu0Yx1hHKhMt0EQZT7V3iatbn5Td/v7zd/+XPgo+sPpRZKf+BocO1t
	3HfoBCh/PDAZWUOyzuqvZ8LUuuUtSa+iZjZ7Z9bc/0j/dXhFL9Yue/fjNt+utKeC+ricwkpcj/s
	s
X-Gm-Gg: ASbGncufnBfcMd3oR0nPZZXTZ8H00Zz02ypxjusVZLtWSejY4j3wSP0clywgs9TmzIg
	wSHdSzo4SrLsX0LzxNTgdZpm0QKYoLs4UnjgGgJpbaAyqocSifn+HeySsgns8h0XJJlXq1nBxPR
	G9h/foFbmbEX+yT5Q4gTVTe4e8ku+DsbnPKHDqZmAD71TQhK7Ntfz98H1WZ+2uzjdRj05gHy9VC
	4KM1pwsM20btTKgwQEI3B4dBh0LdDwBRqIi6wEiyFlSIjMm1z13WVBhQCkgEx3+i2UFELP6O5EV
	jfmw6aTbkMUx/4GPgpvOfFnhSM3zEPygMaLAkt0MTYXfEKyYTIFCMCrcZ2WIOUW9f5Zcf4TkaFV
	u4Y1QNWV3jkz1ymkZwkDCow==
X-Google-Smtp-Source: AGHT+IG3UNqwKSmnEghN1Yf0vzRJslD7xevndIQG/1hxBxCx6zKFOX6soLxXbaPP6oJYqCIRrGEM3Q==
X-Received: by 2002:a05:600c:46d5:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43ee077feeamr71808175e9.30.1744016011319;
        Mon, 07 Apr 2025 01:53:31 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm126966995e9.0.2025.04.07.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:30 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 07 Apr 2025 10:52:06 +0200
Subject: [PATCH v3 4/5] iio: dac: adi-axi-dac: add data source get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-wip-bl-ad3552r-fixes-v3-4-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=DrKX9r5j3TjlenOHNRW1uPlJC2BhLVb8vPawrBK+mKo=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/PMnGKK638KhKL68Wi2vYhOdn96hf/lEkv9XvtNbUg
 GKxhdW7OkpZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExkLjfDP+0cvQ85O3L7A+d7
 nxKVPSDi+nt9CH+dUWmdwJrwVwE6FxkZZmz4um3a9phZBnpPjsjm22XXMi4OdJRfEta42ti/5GY
 NMwA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add data source getter.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index f86acb98b0cffb09bf4d4626f932bf1edc911e2b..8ed5ad1fa24cef649056bc5f4ca80abbf28b9323 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -536,6 +536,35 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	}
 }
 
+static int axi_dac_data_source_get(struct iio_backend *back, unsigned int chan,
+				   enum iio_backend_data_source *data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AXI_DAC_CHAN_CNTRL_7_REG(chan), &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case AXI_DAC_DATA_INTERNAL_TONE:
+		*data = IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE;
+		return 0;
+	case AXI_DAC_DATA_DMA:
+		*data = IIO_BACKEND_EXTERNAL;
+		return 0;
+	case AXI_DAC_DATA_INTERNAL_RAMP_16BIT:
+		*data = IIO_BACKEND_INTERNAL_RAMP_16BIT;
+		return 0;
+	default:
+		return -EIO;
+	}
+}
+
 static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 				   u64 sample_rate)
 {
@@ -818,6 +847,7 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.data_source_set = axi_dac_data_source_set,
+	.data_source_get = axi_dac_data_source_get,
 	.ddr_enable = axi_dac_ddr_enable,
 	.ddr_disable = axi_dac_ddr_disable,
 	.data_stream_enable = axi_dac_data_stream_enable,

-- 
2.49.0


