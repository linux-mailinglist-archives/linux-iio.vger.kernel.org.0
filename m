Return-Path: <linux-iio+bounces-12482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8C9D5E27
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8334C2810C2
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433091DE8B5;
	Fri, 22 Nov 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YGBMnUyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECC1DE2D2
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275243; cv=none; b=B2AQ8/i0jTJTmm5z8iKuf4KVzDBwZ0NGNSW3TJpjmcT+B48dSidoznIHNpi4ScE39EqexcNwDlqxkFzjc489/IEs2lvJzOXPTT/w/3DONq0X1Qf9oPnfSGLNTiXcs8nJxDoxD9dqkY6ykK1t4CxPtkWviEETHecAI0s3+dwGuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275243; c=relaxed/simple;
	bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/g18OSmvU0jfD7pie2gmLzfOLwgoFr631UTRO0qu/e/i2SEqKtY/Unq9SlJTLMgvCBh/+XM2IiBtZLnanErnGDXkKwdkihyPr8z6gIfaGGMWFy1RD5j3RDU9+xFMuBkUo5VLHYodTNVapG2Cyr+YYLxjwCKx8K6wyCtlhkqtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YGBMnUyr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so2246624e87.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275239; x=1732880039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=YGBMnUyrP+1gw90WRkl279Kwbo27y98bVjfyMD7kR9B73C+vbxlNEkQLdZCekFnfyr
         2JIzgdWik/38Elt168Sm19Cbd00ygu5Sgshsn6H6gip1Jxv+rus3yFIGPHqpbwB3a9cV
         ROORz2oDoAnPqSha3n58Fa9myno4Y6Y6bB7d2oCI0ZsKUQgxuo1gy5jel9jEqxp/x7kW
         oVVpPATVatuxxXMU8Y+1ZYs2LZTkfOkRU4n7tJM/EIx+YcHCDYbjGs+qen6chJc4dq4x
         gJxMEE4JYrG5DyPcvOUqbjIOb1o4iFNj8dx/XLgHW9mAABGYSn9lopxJs9fXXeHDGwRm
         4OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275239; x=1732880039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=YZM/TZhmuTmVrx15oGcUwXTTy9E6LPSVh/+nCkYgzMEmKU8/Zapyu3fg+hhCtYv959
         98Etl9MXetgbloK8KLetpGSzuRksLn/YRVAdBdrxT1ad3na5UTAqMbDdPxee0cfcIApY
         rcmxUfYXxlcT2dixDDUbao186jxLQrX6aMuc7NScU7GDHHI5S/IPtqPBU1fS/+dO2OBa
         d2QEymx3yNuzrnjPtx8f/eXLYKFIISutu3FoPECQMzck2nuG2WunNuKZhmfgUfMWpmKu
         jTkL79CRis7qAMW9g8BMvCpemlra4wADtUKekdSnD8dx7ZzymVHNZlmGnyugaZ/zvQ2D
         AbcA==
X-Forwarded-Encrypted: i=1; AJvYcCX1rmqF+OBu9UfTnH3boWZ7yUmuscvfhxhR7imvlyanJl0UM6kRuPgoRXVlMTO1xn8GpuefWxtC3xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6uIBcnYISmv/W37sO3zBiQTYaJ6dauZwWy9zmfEsKIyw4Hvm
	RiN7oc00tDjX6YZK1ODIqQ/ZHy/Y6q3i11mXAYGT5o/y84kPBc3Q1VBCAusb3JM=
X-Gm-Gg: ASbGnctGdfkxKBJ5wy+IHB5hgpfKFYvR5zxpvDol3hJfo/WelxRgse7I3y8iyoYgJ7L
	Ju7ur51JzQ2UR5Xfzc/e3sixwhneVE6O+pNmxj1GwVKnEVLjgt8GsQgHBWe3gLHq4OOpVLEcR6e
	Xr2A9eSksFBDwe04ux2GmQlrkQeqU0AwsWUiyfsFYbGp3GVhbUplxM2SnRxD0dgHnM/91D381kL
	PfBZExSM6M1o/ZZ5LP/WaigT28JZjNQ3F4620SkFPo9mUl+muV4kwtRNENJdf5dDJak0VlaqG1A
	x9k=
X-Google-Smtp-Source: AGHT+IFuJlxu5HJfwHL/G0HKYtzazTpe1NMfuln7ItQncr5JbRlzXCpYYyf6DYgRhYgcBMftOMdt0Q==
X-Received: by 2002:a05:6512:b81:b0:539:ddf1:ac6f with SMTP id 2adb3069b0e04-53dd39a4c7dmr1223377e87.46.1732275239075;
        Fri, 22 Nov 2024 03:33:59 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde9800fsm24416405e9.40.2024.11.22.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:33:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 02/10] iio: adc: ad7124: Refuse invalid input specifiers
Date: Fri, 22 Nov 2024 12:33:21 +0100
Message-ID: <20241122113322.242875-14-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwH+1KZ5UiwNQ58Q3K97bSFf9BrVCEAt6t2k PM5wp0FvtGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsBwAKCRCPgPtYfRL+ TiUaB/4gYCNz94dKkWDcW0KKqFeOXvfsVUzt5cxSiRjARESlRrGbLd/24tMnF2r/tweF8QefAyn Q8eL0bowPaRpgKTQiNizArUA2g2PYxidP8ECNMVLw3y+FDabYZ+3m4JyI/htn20q5T/v9e22Rs0 y5i6nhXoK4xyieeuZOeubKPKPrQKjhi/YHN3MXcQadAV9WSDdwfjDFLNkMJiy+e0YKM9GE+lLEC cmEtaczQc9lV8kc3xlrwf1TLVvWVCy8AwwfMv9HS8PAGDIcQiCKBava15JfC+Mx7CSXuOvBg64V HgYGh53ihBgzqjiEijuCD/hEQwGXCPYIIIpCqiDrs140+/oR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 has 8 analog inputs; the input select values 8 to 15 are
reserved and not to be used. These are fine for ad7124-8. For both
ad7124-4 and ad7124-8 values bigger than 15 are internal channels that
might appear as inputs in the channels specified in the device
description according to the description of commit f1794fd7bdf7 ("iio:
adc: ad7124: Remove input number limitation"), values bigger than 31
don't fit into the respective register bit field and the driver masked
them to smaller values.

Check for these invalid input specifiers and fail to probe if one is
found.

Fixes: f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5352b26bb391..1f3342373f1c 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -807,6 +807,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+/*
+ * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
+ * while they are fine for ad7124-8. Values above 31 don't fit
+ * into the register field and so are invalid for sure.
+ */
+static bool ad7124_valid_input_select(unsigned int ain, const struct ad7124_chip_info *info)
+{
+	if (ain >= info->num_inputs && ain < 16)
+		return false;
+
+	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM_MSK);
+}
+
 static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
@@ -859,6 +872,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
+		    !ad7124_valid_input_select(ain[1], st->chip_info))
+			return dev_err_probe(dev, -EINVAL,
+					     "diff-channels property of %pfwP contains invalid data\n", child);
+
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
-- 
2.45.2


