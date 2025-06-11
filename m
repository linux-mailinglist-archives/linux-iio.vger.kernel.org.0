Return-Path: <linux-iio+bounces-20505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C7AD62D3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CA01755E1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7425E80A;
	Wed, 11 Jun 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0v0cNQtC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617125DB15
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681767; cv=none; b=SkJhqyacCzRE99/Kn+LO15cf1d/V1/60NJM+dHN3CtBYG07M0cW9H0rCSI+MaPWvla07SAHWmGL6+8pwFLQOW02jRWP9LPDMXVmPhUczhq61WSDzoX868C3xlDbPlsYd3RNbn3zi2aEHfpKiJAgHxQQLNm9OXNEayWbxDYlkMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681767; c=relaxed/simple;
	bh=/BUF3sI3UgUZuWXo/TdJaTMxjYqN2OTvccYkHdo0CWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBz9nNvXojjTCWcqf1sl7EM1z7oH/pAB1Nr4VbVAOFCa0cT6cmJzDmj7j448oaFd6nfghSIl8UkLaZ9rG3TytlGr/VP2RV5pP3Pju0g72U07QqAd+6/RxCPDl0vIF7Plq+9E39ky6y6kDTfo6eH9cLEWNJLPwfJFL5v/z7wOQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0v0cNQtC; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4067b7d7e52so92946b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681765; x=1750286565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2UNg6SvTUsLvS4xPi0bVdlEHCiUbwbx1DnGSz9PULU=;
        b=0v0cNQtCh+80+vcD05qyU5VktOD1MENR/RmLK2oiAkVykf5VcvPt7kuiwv5obHwETM
         CArZdQ2BTvsh3/Iy8s3slHLlZhHQefd9HbfAk2IDsfYyYvdadX4lUFDne8vq4kYQSw4b
         ua8hnG85ydV5RYDBcBVjrfybJACZEAlHH4DDdKmKl9M7SBycsJrqVu+Cz9xEFgzr7j34
         3y3qBpFbnRJxH0hwAyB+B8aqfaSvYHIXIKcSUuFRdKhhCAPyfxC5UbO9iQxKNweNunbm
         6T+DyJzM0ESI0QNYrMgZwndn76i/idnRWMDeOsA9aWzik+P08C6QDkaJ9IryqYfL6iKl
         pGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681765; x=1750286565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2UNg6SvTUsLvS4xPi0bVdlEHCiUbwbx1DnGSz9PULU=;
        b=jlbH3K97CSbd+Q0mUVRxW6U643ID9i+MJCGHTCR83m5wpefXDhSsrLDudbRARauA8k
         ClAkt2P/klHNQao1POzWTEvbBTzqJh/PQsJyuV10JKrTJMUtUmDPm0PBguWfEvmJvlVD
         N89xV755+wGouk/fOhkXDZCO/SQmCVyKc9wS+3z8o4wJLSWIQURYAK7c5fZ2Ja+Uxwx1
         fR3pMFP2Q9rzQv2zpVMdh3AMzdJDIW7g8aeJJaSob/TsURHzpacqW3c0mZgaljG3ms1n
         kWRd7yBqEVzpmW0NNJP+9XPsHNE1gGO0m+X5EVznE7VIcKOuGwZfShCN7QIQb/mdbKG1
         mmuQ==
X-Gm-Message-State: AOJu0YxUbG3SqXueZVHvfsD+GoJ0eZuiheHrxffUUiuFxmkOPthF6oJU
	At7Ansxw5h9jbl8QC1YcDxE2RLj2nEW19Ce00dHPAWLxc9XyfHR4AtHTvYl/WtzlJCk=
X-Gm-Gg: ASbGncuCEZytH+U3tQVyU4E80oMo4Qokfy4lmPxLHjeeNdKpnIGu7vumGA5smL8TTI5
	lbtGHt5suFFOW3pKSsgrJf80ljCLPCC4AA/a+U4wzZfRSJ+JqVsrfjdtDQ3FqtjEL+E12p+gnWJ
	9YPAVI64QvUkQCED7jWjQ0BoKyLUF1RwgxKx47PopGxVb+rT7hYMIycipxfDrZv3aCNcvoqv4TZ
	+zw1PT3lezKc1uFQiVAPokT2OSj1FUFaR4bvu9/fY0Kylnq+3BVNagRo/gvCIiWdmPsDJPARdIW
	EjQpIx4qtUOBnrEjyRdc58aWy8sMlQfIrw3u/ymqG1pwDSiDtbnmg2ejw1HMF7jSsriL
X-Google-Smtp-Source: AGHT+IFtdjG7FJlzUxyoQdzNSopQXJAu7gY8CXP2Gzp1csbup6tf9jsf+umiF0SzQmKRhZKr02rKRw==
X-Received: by 2002:a05:6808:23c2:b0:407:a47e:6e43 with SMTP id 5614622812f47-40a65f9214fmr957924b6e.1.1749681765005;
        Wed, 11 Jun 2025 15:42:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:06 -0500
Subject: [PATCH 14/28] iio: chemical: sunrise_co2: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-14-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=/BUF3sI3UgUZuWXo/TdJaTMxjYqN2OTvccYkHdo0CWU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXgx0zbHn3Oo3OHG9JE4qdzOSIeNJ0xKf9sX
 wnfAW8aNIqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF4AAKCRDCzCAB/wGP
 wKEOB/4rZj/0DQjmcBcARn4a2juCsZtjNAGxZS6Gnnpvb9lBcZ/M7WLd2TJ1FU4tng8kNtGsdpl
 xxpYcw9zUa03RA+T15dk478hNrBOrf2769q/x+Z1ASRK6yXK3oE8+pjK5cy1Um2YQXRWQEm59/3
 /79KeHDmQDe11sPIhDQI+6E6v3n71Dc3Iy4yldkp7noMM0+e6hb79BqwrA5FGzOlOZWqtZlPc2T
 +cXsU8GS8cJdJPtJ2N+qcs/bXCjapsQgI4a2JVuet7WD3ZhgXF0vk5hcotnb2Rx0o1conJ7TdH3
 UiMPLiwJFamoQtn4+HaIKDh9EXnxtMphf1igA9vqBfUQt1tI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/sunrise_co2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
index af79efde37e89170128ef9351bf1ad8b993d4a2d..158be9d798d26199cfb40ef0d294f967ba8a737f 100644
--- a/drivers/iio/chemical/sunrise_co2.c
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -51,13 +51,12 @@ static int sunrise_regmap_read(void *context, const void *reg_buf,
 {
 	struct i2c_client *client = context;
 	struct sunrise_dev *sunrise = i2c_get_clientdata(client);
-	union i2c_smbus_data data;
+	union i2c_smbus_data data = { };
 	int ret;
 
 	if (reg_size != 1 || !val_size)
 		return -EINVAL;
 
-	memset(&data, 0, sizeof(data));
 	data.block[0] = val_size;
 
 	/*
@@ -88,14 +87,13 @@ static int sunrise_regmap_write(void *context, const void *val_buf, size_t count
 {
 	struct i2c_client *client = context;
 	struct sunrise_dev *sunrise = i2c_get_clientdata(client);
-	union i2c_smbus_data data;
+	union i2c_smbus_data data = { };
 
 	/* Discard reg address from values count. */
 	if (!count)
 		return -EINVAL;
 	count--;
 
-	memset(&data, 0, sizeof(data));
 	data.block[0] = count;
 	memcpy(&data.block[1], (u8 *)val_buf + 1, count);
 

-- 
2.43.0


