Return-Path: <linux-iio+bounces-5379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9858D0A0B
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515A42828A0
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86715FA86;
	Mon, 27 May 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+AqzGBx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3B168C02;
	Mon, 27 May 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835111; cv=none; b=FcQ2BZ5l3w6Fb2+6iuWoAsxQgqju6rMWbF6g8Ask24cb6GpNH93SZFbbiAVigxT5HdtEu48KXVkieYFm0VfLv6oVX1YljfgDIoGsgQSxvLfHehdgWKKw5XGrmy2xtUvl3N27leQ2xaGuK098hnME+IIGNwnEwp9gshPh/ft2cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835111; c=relaxed/simple;
	bh=rzpH65TI21U5m7K2/XlUoxBtkbSqlLsZqVOhx4LGgm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwYjBpOcuJiVsEipt/WOTrrFR53GvjnrMGrlOoqTpFYFA/PQ56sMMLLDnxNHdTciadXQB4Wff2rBv5nIrhIJXaISfzWekWRBu9aq9b11wnukx25EHrp1kmvW2L4oxjeoi7QoGRuHZm8sRkzlJWcNyh22K76bWUxaV7rSPRlNB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+AqzGBx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ccbdso8883866b.0;
        Mon, 27 May 2024 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835108; x=1717439908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1d9d0lvub004aDn/nseYuqjTWsfZ06sG/wRTeZByZ0=;
        b=c+AqzGBxHHZKMbTgbM1mpVxKRibVdGvUNx1uswdewwsgWlFPCXuSnnTsrZRyqSPWZf
         jdOkUpEJ95af6163yYqDuDIRLCAzQmIMiQRpgx0EIuPSx3AmP1Wd044IOUtvMbCyvhbv
         7ErFo0YFnxnuVJZmskVZoOvNG0DTKE7mYrOVtBTEB5+7pf7ZWCFn2ns3ZGJnT8ZEon1K
         V1AlwUij7Xa9/ENxLOAi5VMlToC8Lw35CL7W2uo0x4JoiZRlORXSUUNPGytO5/YOQMHs
         R1SCAW0dvNwMiYNAI4mR2dofyL352MP+ZqRrQWxxflLIjPwm2Z8LiAobQ7EArQDh31ox
         uGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835108; x=1717439908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1d9d0lvub004aDn/nseYuqjTWsfZ06sG/wRTeZByZ0=;
        b=wax8t17MzpcEbW3fdji2mLL0sl/HAVzBh6ahdlCRbQkP1CW+IoVXa3Ltq47gNCPxNC
         8CWdY2o8O89FECkFS9qLnzwwzaBjD4n/iLyj4rTItwhREOn/KvL03oyRXQW07jc7IaMo
         rIcpRHSa8nSWvn1j7dQOJDbmitEIaltI/Ih27UX/OGURics8ywBUlTJ5ERBXTS5PUBF/
         Atk0caILwkrJ39Tdkr9QRnukzfHZaseuNPOwB1VtM7UiyEVyLWBoMus+SkPLf9AdcVzp
         Z5zLvwNtF6MJ/p7jgS0PgrFvite5NFZ0glrwvOLvW8F0l8JpTfbOjEpLNYE542JzR6iT
         m5qg==
X-Forwarded-Encrypted: i=1; AJvYcCVi9tUd+CK9nvCzGpIb5nihMbiAmmh/tqXqXFKQJeo+1Z3blGR89GCaWWu+WBXe0SnysCr8KBsALKf8WZ1fz5dq8F9RSkoihsv2FeQtt2MShXo9LwzaBOCmIkNVnNLH4ejvPfy4a7dk
X-Gm-Message-State: AOJu0YzrdoDo/crk4DEqwVfOI69RzUcCYJkxKzYb7g12m206AULWDYs0
	83TdpKHB6gYiDX0bW8l2+FvO7aLhAeraHMme8klo+uEdXOvQciHB
X-Google-Smtp-Source: AGHT+IFdpdfIrm/Ss6ITkoo/AI/NE/vDUJhSCtwQ5mjzNPn3DJ4Kkj3Cy/HQVY1DiB2ruqUg3FM4kA==
X-Received: by 2002:a17:906:c0d3:b0:a59:c2c3:bb45 with SMTP id a640c23a62f3a-a6265112b00mr714904366b.56.1716835107827;
        Mon, 27 May 2024 11:38:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 16/17] iio: chemical: bme680: Move forced mode setup in ->read_raw()
Date: Mon, 27 May 2024 20:38:04 +0200
Message-Id: <20240527183805.311501-17-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever the sensor is set to forced mode, a TPHG cycle is
triggered and the values of temperature, pressure, humidity
and gas become ready to be read.

The setup of the forced mode to trigger measurements was located
inside the read_{temp/gas}() functions. This was not posing a
functional problem since read_{humid/press}() are internally
calling read_temp() so the forced mode is set through this call.

This is not very clear and it is kind of hidden that regardless
of the measurement, the setup of the forced mode needs to happen
before any measurement.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index a91b15626ec8..8f977667249b 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -560,13 +560,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	u32 adc_temp;
 	s16 comp_temp;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	bme680_wait_for_eoc(data);
-
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       data->buf, BME680_TEMP_NUM_BYTES);
 	if (ret < 0) {
@@ -669,13 +662,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	bme680_wait_for_eoc(data);
-
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (data->check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
@@ -713,9 +699,17 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
 
 	guard(mutex)(&data->lock);
 
+	/* set forced mode to trigger measurement */
+	ret = bme680_set_mode(data, true);
+	if (ret < 0)
+		return ret;
+
+	bme680_wait_for_eoc(data);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
-- 
2.25.1


