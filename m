Return-Path: <linux-iio+bounces-5965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD68FF6D4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C3A1C256D4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887EA19DF7C;
	Thu,  6 Jun 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdClElQq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939819EEC4;
	Thu,  6 Jun 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709057; cv=none; b=iddf1SFkc+DlXsZkBq+h4fFcis3CANn7drKP4usmMIlIjpf0hi/stANPdjYDv6QovtyD199QvAPAkqAZTgQBt80w6Lp1uR3u41Uzza8Xeh3v4DSEKwxqIeZ1/G32Pi0m3t7gxDkVPw3vGDtNY5N4BSeCzWlrr5tIhMvMCbKiZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709057; c=relaxed/simple;
	bh=XMl3CW3SWJdU+9IxGlTqy5iqqJbwXQZEMbI0sxxKmCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Myz1ouYOeOLbdel3GBJprBunOhNk8zW81D28OnzEoNJVYzs6+t2p4E3NJYWcxO1L/idfATXBdJZjqInrpX4maI3qLCr1CxWJrwNjDLS0Vs1NdA/LIvNWJLRSmBn9tX4rin1tzC9P3otG4GwZLexgJ/Aev2SZjSWUzDz4QyTMHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdClElQq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68bf84d747so139063966b.3;
        Thu, 06 Jun 2024 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709054; x=1718313854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rktH83Z8JxFjHKNqGOfzwitSgp1NA5g1Za3nobwcCto=;
        b=hdClElQqreDKleYOkBjIv+2zcUpcfVbME7ymxAxKRki70wf9KTisRD7jws5uyxmRRQ
         DfoYoR4gKyv9itBSZsomqeS3MVHF7DSe0i5jKtOe06+rbAwAK0yYYXjj/F8y77FkQAeA
         RvbN0ed+PYjw4tGnroG9tY6xW821k+/uBvvA7FhY8FO/zuD/NtUG6O8auq/sGL3K6nyF
         piG5AAvCvgOPBlANaOhUV6j1gPYJRE0DXrRtgovayD/+xWDWIhujTuvNJxg2BNCAuP+g
         yu6RfvzsgSWDSr6logHPK76X8I64RFoG4I03mItWh+1UF9TL06GF6ELxsgEh40CJTD5k
         IMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709054; x=1718313854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rktH83Z8JxFjHKNqGOfzwitSgp1NA5g1Za3nobwcCto=;
        b=v5D/CodtRYneMujOuWbRjznxugZPi2ExqJkFVOMeBABsO+TPY4PZkwUIXlTLMXRpXP
         ZRzL/igGbO8xae39ULGHV2UDXNoS7ESbuEplUWTGHhS/h7TUCn5SDy7lrWwDUzH8QuwC
         BgBChrEnxY+E0YGC2TcLirAeWgXnOpBLbFZRpXQcVyLYzgvQVSE9BmOxyacDxTmoC224
         dbbXANwDLIPTWWF6kuoRbUV/o+LQzXzHXDBJU0J8qRA7WCQFyS2zzMR3yxj2Pp7K7Uej
         l6BKj4V/AGcuXoQ4T6OUwKyer3SnyzKfJlDkmyOBQSUKXNxniAioMcsD6FSVYbDCLDFS
         1WaA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJQy5wXqvO4yv/2Yfjftsc0kOqlxlRLgXD5dOgwrd6OberzV5yN0M8fgeNvRqdRjz7TonXSjLsDxhfX3WWUjlcPdNmpv6RUCEYbQQSHKkx+UvKYF+Weh5J09/JN5F4Ubw+6m1tjCL
X-Gm-Message-State: AOJu0YyMNjJcnh21VdSrSWXCdhU38nsvrCvjScEzEtHM2jjXZYyJMPWn
	Mh+q2hhlAC266deeM1HcYkJlu9mKruVvmWNH2F6cEAos9zhjPq5A
X-Google-Smtp-Source: AGHT+IGWw4zSoOf3kLvew5vKceUopVFNZZZFv2dtC0WLRGpO7/4dB55S8cf28QGEi3FkOAh2j2wrSg==
X-Received: by 2002:a17:906:bcd4:b0:a68:7b9b:5176 with SMTP id a640c23a62f3a-a6cd7d68aedmr48777766b.44.1717709053877;
        Thu, 06 Jun 2024 14:24:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 18/19] iio: chemical: bme680: Move forced mode setup in ->read_raw()
Date: Thu,  6 Jun 2024 23:23:12 +0200
Message-Id: <20240606212313.207550-21-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 76b96993120f..b654a8cd31aa 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -572,15 +572,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	u32 adc_temp;
 	s16 comp_temp;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	ret = bme680_wait_for_eoc(data);
-	if (ret)
-		return ret;
-
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       data->buf, BME680_TEMP_NUM_BYTES);
 	if (ret < 0) {
@@ -683,15 +674,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	ret = bme680_wait_for_eoc(data);
-	if (ret)
-		return ret;
-
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (data->check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
@@ -730,9 +712,19 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
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
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
-- 
2.25.1


