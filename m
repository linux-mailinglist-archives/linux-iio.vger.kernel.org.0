Return-Path: <linux-iio+bounces-10896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E799A9046
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B8328607E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983B1FBC9E;
	Mon, 21 Oct 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuDC/YZd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFF1C9B82;
	Mon, 21 Oct 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540411; cv=none; b=TfTIx7A6wnG0xiTuCKmW48mJX/OJND1ipoBzdK0qRSXN2vmGfNXoexqXBtuWsstjyBufr3vKDhl2+fJfJVu0lwPBJoj9ilU9ehvybs7FbGJsTMA3oAbKrENOz0Vlf5XbhU+3PT9Lr0ZNmLAQIw8V2mEMyo4EM/ak47NiNOZKLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540411; c=relaxed/simple;
	bh=ezXl4v8W4J6XN8omxgx9NgXx60OPexUxZJG+saDHlTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN7NMe0JUuHPM1ELwt7uQ9x/sw/03M7B0kz1qIKRneT7iqhAJQq7Dlma1/HHSxmdXBlZ5LZ+Lm6ELn90rf8sfLz/T3+WtZEVDcWxwi9QPCdBV0xY8uKHNOLQDJn8RudZ7j24EnBubt7RKDIwadSTdsnwbkbca2i5oWi40S2e5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuDC/YZd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431695fa98bso23944075e9.3;
        Mon, 21 Oct 2024 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540408; x=1730145208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAEuSCx9ubPqQdyLtNi7rXlFj0w0O+VCxcD2ZmvWOgw=;
        b=DuDC/YZdrbDI5m+bDrHJWbphCPtYHhBqdI30Il+4E1Ws4+Om5mSyAzRxQXy0gdm41S
         RURfPrWK1cdWMO5sNGYPFR1Ub/htNu1LlsveuyrbRIEGjguWdLbEyYViFO5usFVkjdZz
         eSJ7KFqb4q6ecf6NXvSJm+3Uqsp08RYTEsT3D12mm7KaTwxwgCi3ODszqBa66mfahC6E
         Kr0mm91lXstac4eM5oBme+rvh8rvBW0aCDQYmTPfocC5SvAhhxNvyjLBlDD7Ub/4Gvuk
         5U21rbkdvmRnZHtQGRnyWo5FrbZHu34Kb6hP2XnZE5UIPe4/Wi1nxNhEb/xGYEyXN1Ct
         05DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540408; x=1730145208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAEuSCx9ubPqQdyLtNi7rXlFj0w0O+VCxcD2ZmvWOgw=;
        b=uDijx6p42lVC74E9aU5x8DPcsspMtfLK0JsJO6XmNDACw0bqDtW1EGzfWZSvkn1yne
         JAtzIbXVqUCsYtz15Tw/sMSmtJ3DtaLS0Q2M8go5VkiY9K1L0I8IOUUiunPTLiry9NyP
         fLT7Her6v5B0w+WbOK1b7J3VF0XsEipRjtz5pvfYkpIb2NnVvP4VXHHxW759ISBP7hYm
         xVd1gUH86ioRw4nAjgQcSgkg9dNl5KZKO/P6YjF3Co4SwhSd6qx5t5+fno+Z7Fc8B4js
         BYP0UoO9GkPJJ5A0eQoGUXvHzISLuSIG9fkDd9JEVBEV+GEeCNigB6QXn9hWvbEKUMSI
         Vm8w==
X-Forwarded-Encrypted: i=1; AJvYcCWaXC5xL6vVyeIIimwUbQphpdl8tJanImNeskg0weKaXu53bh+GCbsOnp9TU26GD3D6jeLCYZzd7uovpORv@vger.kernel.org, AJvYcCWj044Sl2w6w6SKDWJ0rv012UlYJnlCuHZF2VIwSr+XCaJmHrPPfN2o0qFsltf8YkIIE/0KfB5vLhfo@vger.kernel.org, AJvYcCXS017IIbnkjLMBd1HTQYBC/obee64d3bCtgqXesXk2naK2BrDvJb4Hp5Jp54/KB7PigvSNjRss0aHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxrotR42TZJWgL3VpriuuOATe1/RGg5IBXEG1Evgaa06SQgPdKI
	Sd127ftMd+xxqPYrLzMYZsCsEyk+L1pztf7DYt10pKv/FqVBduQF
X-Google-Smtp-Source: AGHT+IHXBDjbuKYFxxBE3m07eIDPFlVH8nP6fc0n2zHCbM5higff1cgAAA+po3MrrJzUzIJ6raaoFA==
X-Received: by 2002:a5d:54c3:0:b0:37d:3f42:9b59 with SMTP id ffacd0b85a97d-37eab4d13c2mr8153964f8f.11.1729540407758;
        Mon, 21 Oct 2024 12:53:27 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] iio: chemical: bme680: refactorize set_mode() mode
Date: Mon, 21 Oct 2024 21:53:07 +0200
Message-ID: <20241021195316.58911-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactorize the set_mode() function to use an external enum that
describes the possible modes of the BME680 device instead of using
true/false variables for selecting SLEEPING/FORCED mode.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index d228f90b4dc6..9002519d2c33 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -95,6 +95,11 @@ struct bme680_calib {
 	s8  range_sw_err;
 };
 
+enum bme680_op_mode {
+	BME680_SLEEP,
+	BME680_FORCED,
+};
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -502,23 +507,16 @@ static u8 bme680_calc_heater_dur(u16 dur)
 	return durval;
 }
 
-static int bme680_set_mode(struct bme680_data *data, bool mode)
+static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (mode) {
-		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
-					BME680_MODE_MASK, BME680_MODE_FORCED);
-		if (ret < 0)
-			dev_err(dev, "failed to set forced mode\n");
-
-	} else {
-		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
-					BME680_MODE_MASK, BME680_MODE_SLEEP);
-		if (ret < 0)
-			dev_err(dev, "failed to set sleep mode\n");
-
+	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
+				BME680_MODE_MASK, mode);
+	if (ret < 0) {
+		dev_err(dev, "failed to set ctrl_meas register\n");
+		return ret;
 	}
 
 	return ret;
@@ -615,8 +613,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	int ret;
 	u8 heatr_res, heatr_dur;
 
-	/* Go to sleep */
-	ret = bme680_set_mode(data, false);
+	ret = bme680_set_mode(data, BME680_SLEEP);
 	if (ret < 0)
 		return ret;
 
@@ -756,8 +753,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 
 	guard(mutex)(&data->lock);
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
+	ret = bme680_set_mode(data, BME680_FORCED);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


