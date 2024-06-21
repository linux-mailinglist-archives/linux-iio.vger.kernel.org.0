Return-Path: <linux-iio+bounces-6700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7391302C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EF41C234A0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66E17D8B4;
	Fri, 21 Jun 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C4AeYUSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70A17D379
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007932; cv=none; b=EzEORdoWUtsyW3PcLgcFA/5v0kIbZa0nvQgTh1OrrJS7iJNFNDWqcr3s0TGERBs0k4D2xjdjUC7Df0pAhFXvUbn0AkJNViO+L8MXMPloiLeVVtyXPeAiI3DET6Px4EesqVWXHrKbYv9qi3IpjNZpLV6qzO8KmYo26FY4a302fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007932; c=relaxed/simple;
	bh=7AO4VzufO37nMfxwedeUorkeLS2PzJWzCHqvllFysIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/R4aNnhodu7tmHvkwPnqWCOAFasqdxWTFc3v+1+ybum6Z2jpbGMYQ0mGe05/2lSA7l9ylxNRW1GPvai4toHEdFg2qWbcs9JARTOG1x5L2KFBn8c3QFS4tV4A/Oai5CatWoMU7o5cOV6IRRY9biZLKTzUfXSmtThYdBzyhE3kRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C4AeYUSZ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1cabcb0c1so1133518eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007929; x=1719612729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU5eFUTN0Hk2LWl03tYr+7EwkXmonIPdLeN7oZJP5hY=;
        b=C4AeYUSZD/Jjpnq8vzxYiOPhdME59n5hyrdTvs8SlWMZwdrFMReQvPXAGP1mbKC2wS
         ue3uKIAoV8vt9Q19+vJq+iPoTHXioxp+WQ/rL5w9e5Bb2MO1gY1+MJBifJmq4zN83Egl
         1Tg8ATqlXk2MAcj5r/uPoxhOHxS+XpvnCJnLHk5+K77jQh/fgQ3vaVkHMiRl7DJHgxc7
         phL3vmoaQFsRc3K85PUmSHKNatrVoPyM//LKd/XJWIMtPARBiRZLCBcTJKIAKsdYh+Hv
         AvImjIzeLrPWP/g2tkVzn+fJRAtVFO1YJYgOMsVrmngsf+GRv21udMA3SKRebRQEiq/0
         SQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007929; x=1719612729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU5eFUTN0Hk2LWl03tYr+7EwkXmonIPdLeN7oZJP5hY=;
        b=eIGp9vpUJOQ5PYQYiVcx9Vpomx/5YMTHLmhwcd7NsajsvXwjt5YvRTgxwIJD6WYVUy
         2wXHthD/Z4+mMRVwNGW8ylmb9s3tunoA7UZbfL9JcN8cOWHp6EVgCObKRJpMRCy8KEtO
         t/r8TrlfGRU45DQN3rNT4cg3ltY2WailVXga+7S39CUCr/SzvUgTS4T+WX6eIYYMTdNe
         rYSxkIiEX0Bivr80z5HtwNDrsJptV6Dec1wB/4ICxwe7HbFh7Gx+lXNUFRbooE5IHtkO
         YrzoHMi9H2zvhyL2+BOlmIUNF6vinXkdGFbf+/dL2IumdipSKVxGUNj9AqGg7pr6KLVZ
         ZSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTkP4RTmiG88rXoiHBMa34iv+V3i0mT4x71PEIg4juhgAgAsg75UVRJkIcD8Qf5HRzQ8ClaVzGTG1YYabHy2ADb/b3lNRhCBCQ
X-Gm-Message-State: AOJu0YwlxOD7ncsNnV1SXP5jEBCS86K4Jqn/L6Zd3A+zlL1TjHBSBgwr
	45aUsp5beEOqFwidfkg8v8I8vAc2JeT/x8ksqd4FEZUf3X/Rhw2CgEZJLjN9BqB7i5HEA/E1XpS
	Q
X-Google-Smtp-Source: AGHT+IEKaEnaN52GJyDtdHtvEb/BI9UwWkmlr8jo82XfbDm4o52uxvo39sqUISJ/G4+mET8wMIvNRQ==
X-Received: by 2002:a4a:240f:0:b0:5bb:79d:1c6e with SMTP id 006d021491bc7-5c1adc06d8bmr10632688eaf.8.1719007929621;
        Fri, 21 Jun 2024 15:12:09 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:55 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-8-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads8688.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 9440a268a78c..fca3032c59d9 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -65,7 +65,6 @@ struct ads8688_state {
 	struct mutex			lock;
 	const struct ads8688_chip_info	*chip_info;
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	unsigned int			vref_mv;
 	enum ads8688_range		range[8];
 	union {
@@ -423,21 +422,11 @@ static int ads8688_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			goto err_regulator_disable;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
 
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Use internal reference */
-		st->vref_mv = ADS8688_VREF_MV;
-	}
+	st->vref_mv = ret == -ENODEV ? ADS8688_VREF_MV : ret / 1000;
 
 	st->chip_info =	&ads8688_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -460,7 +449,7 @@ static int ads8688_probe(struct spi_device *spi)
 	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		goto err_regulator_disable;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -472,23 +461,15 @@ static int ads8688_probe(struct spi_device *spi)
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-err_regulator_disable:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
 	return ret;
 }
 
 static void ads8688_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ads8688_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 static const struct spi_device_id ads8688_id[] = {

-- 
2.45.2


