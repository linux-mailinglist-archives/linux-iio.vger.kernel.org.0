Return-Path: <linux-iio+bounces-6225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D937905D67
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F678B22871
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA012D776;
	Wed, 12 Jun 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YRsdl3nn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B754F87
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226204; cv=none; b=IMpCnS3KaYGuyuN+MhiRqDdt//BdHKhYgTGq+8lKZA5yTSbegaN3ug5hgvj/SLTlBcd2MboXZKGNqpHJ+blqaCvBZQIQxSNpjpUdUV9RMMbjXdq6+H469GIqzOGQFE2WCoMq21go/GGhFGtiLjq7mUzJk7wY6rVEpOf/f7ktDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226204; c=relaxed/simple;
	bh=sezQ4w6PZZve8U3ILWq1Xq5i5J6FPy2Gc64TgHqk4/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO6tlpJh4HGoMIE0HgbCzHtJzVlxP05Y4vAkGda8Zb/vyPwTqqyKFN7OyeNYmVG90ti1VA1eiWzq61ak+B3eNerwf2oIQlqeqenEf6mAH7G0h0CdJBoraryMspJtP5PsWVIuAkNpZFtKdm0k3Rz5tZxYQRD+FzRRuraXc8+e5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YRsdl3nn; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681e4fso108377b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226202; x=1718831002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2EhrQZ4+BmCMfRs36lFVBfa5pXsiS+VLdsM94tNmk=;
        b=YRsdl3nncMccG/IArtSdxOuiHewELH9I3v7S2k8Up3fEH+vc2rsZ6uxFu/biQi9zxd
         //JQioJIOhBrs66ud2SwArFWtR9pWGyuRUk8KS4ZIRQZhZdqKwv6rRQNMeHieowSnVIc
         KqcDBfZ9hY0U6vRNHphZBXIj1rywQgQ0yxIZIXUr9Kufv1lTGPmGLoc39rZ8QVevIBIY
         p3t8DZW/TgASb5xBWcc/9xwqvHgw1ftw1AfxJ5y9B4zpPkImL8j9SV80TOMH+gTW0xSy
         vJ/Vo68iW96AlJUV7xH9VW/FqXuGctlaEb+yezYqvd9TkOByl+eM8lvilX84VvALUrJl
         7R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226202; x=1718831002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w2EhrQZ4+BmCMfRs36lFVBfa5pXsiS+VLdsM94tNmk=;
        b=bvOTHVc5XIFzTN24doPxCiZJITJxUhpm+QLrGoQrOFDdvUZC8FQh35Y1xkrtK0LPoa
         OCTY4kuXRBaA98WM06dPi8MnrosgaEkwFJsqoIguTpInncXcfO97JkrSoK4ZbADnetXZ
         ByjwT01tM0+cO4MTlKd7EVjvWZCWQG+EFUykfckB8jFkILRBQxpCaLOHw09E26COHUI8
         eDR/Bgqkp1SaxkGJNY4PU1wbgQbN9+LzoywNSvrt4fLWmW0P0+kTDpsi5X708kP8RRW9
         t89hdkyp7FYn9fcdHoVFX0Sg/E1iOXcWxQmtYZ+oV0Ngk9cZrBLkNfu1z4P+RH7VIaqN
         dfJw==
X-Forwarded-Encrypted: i=1; AJvYcCVwEG5sGQNXdVHRZYNryFh+3pv+jm7kMrTnBVELb8IrBhIZ1URAseNRm4Wb9Ju6gw8O9QRc5vSri3ENtAJs7Fq/EjadEwh/op4Q
X-Gm-Message-State: AOJu0Yyy7NhE8oWCb/zedaKYfvbbu2iCaVwn/w+P/04UrVGjl4VSqoIM
	WT+2WRKBx38BRIrInxW6cz07OpK8ePY26CyAF1hRPRN6M7dtqrAxWicQqgXOTvo=
X-Google-Smtp-Source: AGHT+IH+n9V+MzaCy4aZHHNtHPMSXI+bS8hlK5eCVyi4DOF1NPWgoBSrSmEm04QGkU67m4l1Ly1jZw==
X-Received: by 2002:a05:6808:1282:b0:3d2:304c:982e with SMTP id 5614622812f47-3d23e0800a9mr4381718b6e.42.1718226202413;
        Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:08 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-4-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: none
---
 drivers/iio/adc/ad7793.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5f8cb9aaac70..d4ad7e0b515a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -152,7 +152,6 @@ struct ad7793_chip_info {
 
 struct ad7793_state {
 	const struct ad7793_chip_info	*chip_info;
-	struct regulator		*reg;
 	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
@@ -769,11 +768,6 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
-static void ad7793_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -800,23 +794,11 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		st->reg = devm_regulator_get(&spi->dev, "refin");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
-		if (ret)
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refin");
+		if (ret < 0)
 			return ret;
 
-		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0)
-			return vref_mv;
-
-		vref_mv /= 1000;
+		vref_mv = ret / 1000;
 	} else {
 		vref_mv = 1170; /* Build-in ref */
 	}

-- 
2.45.2


