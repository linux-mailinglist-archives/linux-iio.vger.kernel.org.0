Return-Path: <linux-iio+bounces-10421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D316499941E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7021C261DF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951571E9073;
	Thu, 10 Oct 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCTdCR7Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8591E7C1A;
	Thu, 10 Oct 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594049; cv=none; b=bBFw+MDtorXuZdpTA/Qt/CZtTnMpdKy+vBSWNRIKzoQSeP3yuPE3Wr8IxggeqrMKWlDZEWv098lAL2eYplKyZEPweEuIMtenBxF+Nk0RecBSBXiujK317KKFADr+aBh3WmkDUy+t8VfHfwwrY+FHJO9y8NYrI7Q3uM3N0C2iZ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594049; c=relaxed/simple;
	bh=Wa3EYI791Z6QvQ8LVPrmstMIWkKWiIKJHhi8ABqUJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC14ODC0fwi0Qn1OR9NQCsZeErMUqhfOwuLy4SdSwslruSquf9QDKBeiEoGNq7H7aiFZ+7c1p0h74viwkoNxD9Onjo8ZQoCEgvWpwuATehuKWN3x5pDxO11HOB2Nl49Wfiok7jA+psFQYKpEHkX8+EyfPI8m1ZvY2+XqCVzCCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCTdCR7Q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so191647066b.0;
        Thu, 10 Oct 2024 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594046; x=1729198846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+jQJSYyyk24bPlVarRgFu0Ib7+Yu24U/ZAJcxgJYmk=;
        b=mCTdCR7QV6XZUsTcGRuUb7yrN36wov/QJyk0O4lc3uo+/xR6vuNYhb0GhXowbxtSAp
         zJtQDSBRVBgSEcchcxzVtJ0IOfL7xDQLF73uy5s2vDkcAdBHNa5vVs5HqqftiZty3+0S
         MxQx8dZVAwCZZtJ8jtcA1Tqx9g085E3m9wg4HyZhrxZVxH1EsKKNjxdVSrtC2EhI8nX2
         afPbGkHl4a1BaOZ0jugSyxysAUn62yk6rtNdUNhsa4zTo4JFbMqNrYanWvcl4mZG5AL4
         i2CpfgNbZ8ujpSLGzqi69djZDRA9xnHRvBCLMSTyx6Epr+n9VbP1mv3YewBlMeb/Sq4m
         ExCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594046; x=1729198846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+jQJSYyyk24bPlVarRgFu0Ib7+Yu24U/ZAJcxgJYmk=;
        b=CjjLC8qtgvOADk8GomUwLytpFbG7XB7LTiaM1n3z19lCkEmx8mo8cqtYUKxghh4Kca
         Rr9vja0w5M+TnKoSkpJllYZUXLMfH1hnTqDeKT2t16dbw289ujEurDSU41+PyPC7wk3f
         dU1IJxg2gRmecdT5YpGEzYDHMlFFZIhMz1RuY709KTzUbD8DbKqHIUSQdVg4Ie+d2Pow
         7x/U3YEKXGu4EkWx8rGpPvJ6+GjdEkMHV68OKEO85oooalJi2F4E32TT5kiL9A1AcGfv
         uuZK82qmN8i8r5G61zRlcqc3gVaQrTOeOSEPl0ZM4WoJjoYgZF/VgHDChMqoz5PYHF+j
         vQNw==
X-Forwarded-Encrypted: i=1; AJvYcCXFzeyjmIVBztOCbiDGgCn78Vm9/kKpJ/Wm3L5rZDes5knakqpcJDruHDRJIOYzS3Y6Rxv/NDvRa6gh@vger.kernel.org, AJvYcCXMlI1nN1znnIX6ypNd0v/NGRX6qUxgeCk3MaIQGXi/PN/AkNSwoyLnXfXpfRThy7oRP6ovCrgZe5zBQ4w1@vger.kernel.org, AJvYcCXhguyt2Y2FrEu6jM9zfRsmqtDbdWWJemG+OP3Zn/Rp46i7YL0WHWnNpNjM8CQTWkw9W02hxOxFbWec@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x9LffuGURNx4xYYOCYgwAjFmcgtXDufQf3p8CXpOBP3nYmGG
	39/tnJuEkdkL/OyTaySf3D1HM09ideJXMKVDfpquyXDICLyFlJYAqSCacF73
X-Google-Smtp-Source: AGHT+IGvQ/rgjjoxIz3BxKyQtThZ405yt7y5MZUKMBCCdCpKeEwq4EJRK+REY2FLNqRk86IEBfWOoQ==
X-Received: by 2002:a17:907:3f28:b0:a99:3802:1c37 with SMTP id a640c23a62f3a-a99b937a670mr22344666b.20.1728594045848;
        Thu, 10 Oct 2024 14:00:45 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:44 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/13] iio: chemical: bme680: refactorize set_mode() mode
Date: Thu, 10 Oct 2024 23:00:22 +0200
Message-ID: <20241010210030.33309-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Refactorize the set_mode() function to use an external enum that
describes the possible modes of the BME680 device instead of using
true/false variables for selecting SLEEPING/FORCED mode.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 36 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9e843e463502..dedb7edaf43d 100644
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
@@ -501,25 +506,24 @@ static u8 bme680_calc_heater_dur(u16 dur)
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
+	switch (mode) {
+	case BME680_SLEEP:
+	case BME680_FORCED:
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
+				BME680_MODE_MASK, mode);
+	if (ret < 0)
+		dev_err(dev, "failed to set ctrl_meas register\n");
+
 	return ret;
 }
 
@@ -612,8 +616,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	int ret;
 	u8 heatr_res, heatr_dur;
 
-	/* Go to sleep */
-	ret = bme680_set_mode(data, false);
+	ret = bme680_set_mode(data, BME680_SLEEP);
 	if (ret < 0)
 		return ret;
 
@@ -750,8 +753,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 
 	guard(mutex)(&data->lock);
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
+	ret = bme680_set_mode(data, BME680_FORCED);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


