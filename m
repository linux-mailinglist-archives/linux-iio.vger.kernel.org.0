Return-Path: <linux-iio+bounces-3844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7488F2E9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 00:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715E429CE6F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292815666F;
	Wed, 27 Mar 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmmK8IK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7871553A6
	for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581552; cv=none; b=Y3z2hS2AqBm4zV/r6/NoiRcPg12brCLwpwT8wMrgCkYCkGhYzFneEuiCxgJFqgysjM6D7ok/g3fJeZWG9p7Kx9z350IsuAhdTK2ha8mhBgDgslu+tCubnJGcXbNwaUiSTGG3m1pypUKtmwtd860d2tRaT+fv33F22BRiLX7E31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581552; c=relaxed/simple;
	bh=sBLswoaOXaPOvtO52rKuqYQNWurR1XJ6O1U4h0zvPkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1TIw5PXi4WszMd95WA//qISRZ1bK7PJudQBmBu56QnZQfut3C53jN9UwMWkNGWGbhSWyuo6VW1x/K+2fSFeRMdW2+Iko0UkIA/3SDPsO8qYQIrptR+/HcsSfafqjyGj1GZ0dU2/NqXRR08psSF1OW4iytKRD1zhQkmcGOi+8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmmK8IK0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22a1e72f683so272673fac.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581548; x=1712186348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaNlrVh6YX+OdjnoPnmjQwMmZEJRJLFsRjLteQznSUU=;
        b=GmmK8IK0iivL2FmUdS13hA2ENWWXIW/hTaQCILNCGBPXTotcgGrCDpOC97OcLwlTx7
         RjCYu7tM39lZj8lveTnDWDIq7Dutz2w1TLDeBW+DbwB9uhUvdRfXEWWvPfzug7y1Ytzu
         PTnQ2sml8lwNfbC1P17OM9gmRYaiVBtzqUdLpw+Zvt3muIbaAXtj2wGtov1D7EK3W9za
         Yg7HqRkYl69oLtY5zMGyXTZtOMXlMCu0abdCIy9IT1SMIzgvLEHbW2tO/ynV8sYIYp5Q
         BL6lUb3wH99jD/7VsdFRpXvkLefTGV/D29VUY0ZI6vt2PJwoAqd+n7cyJooGmG88yqXt
         vI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581548; x=1712186348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaNlrVh6YX+OdjnoPnmjQwMmZEJRJLFsRjLteQznSUU=;
        b=WgO8oOTydhSYwBfZ2/GIq43vxWOc7tORIDiSsoKPeplHViBRq6husAOOYolvIidWym
         Tphrp0e8wfaps53F/zcpYsM1vzLKl/NaqmLeyKNOfdovIxFCpbetQLw9hA+yfqYA9cz1
         XAS9KXOzMYZBxeor4zXydPWyNgtzmpQaPqWkEzDWPavXvV6bjbibyFrkmPASF2MZzXAd
         y8UeZ+KVE5nsVnYhULtg4EcZvzpFzrdYLTdTJdpNP40GlxpxqPCf4F5Hepx9yrzXtwK2
         wScx8koNnxFPFmIMv/9AFX2uIodw5pavRkC9+XW7RKHa4B1X07un5se55pTfzt0kOaDI
         hseA==
X-Forwarded-Encrypted: i=1; AJvYcCU5IZZUfi4Tj5bxfDjMYcUVd0vqFdc+mbFsQmdRdTuWNaDeTBvsLYldCom6BW+jLSrUIN2B1wMN3a1DCy8704Ea4oU2NqedmhWN
X-Gm-Message-State: AOJu0Yx2yFPmje1NKCVIee53sqLkUo2Yf87j3aarK3/+StdwVc9mnZcj
	FUBjOWRzQFOs3y9JDhr1fNP1StznSOLYJ5zwv5yoAdLVnFeRBBg9lu/Q5rsCWY4=
X-Google-Smtp-Source: AGHT+IFWJbt2/BUKuKdpJqTrO3Ps0Zm4Bbiulso5ad2yHWD7/eCmYh93EbMlYQB/kOSN+Tatt1jIOQ==
X-Received: by 2002:a05:6871:a913:b0:22a:1399:a781 with SMTP id wn19-20020a056871a91300b0022a1399a781mr1281622oab.23.1711581548121;
        Wed, 27 Mar 2024 16:19:08 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH RFC 5/7] iio: frequency: admv1013: Use devm_regulator_get_enable_get_voltage()
Date: Wed, 27 Mar 2024 18:18:54 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-5-5f4517faa059@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

We can reduce boilerplate code by using
devm_regulator_get_enable_get_voltage().

The common mode voltage is now passed as a parameter in the init
functions so we can avoid adding a state member that is only used
during init.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/frequency/admv1013.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 92923074f930..b0aa3cc27ea9 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -95,7 +95,6 @@ struct admv1013_state {
 	struct clk		*clkin;
 	/* Protect against concurrent accesses to the device and to data */
 	struct mutex		lock;
-	struct regulator	*reg;
 	struct notifier_block	nb;
 	unsigned int		input_mode;
 	unsigned int		quad_se_mode;
@@ -342,14 +341,9 @@ static int admv1013_update_quad_filters(struct admv1013_state *st)
 					FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
 }
 
-static int admv1013_update_mixer_vgate(struct admv1013_state *st)
+static int admv1013_update_mixer_vgate(struct admv1013_state *st, int vcm)
 {
 	unsigned int mixer_vgate;
-	int vcm;
-
-	vcm = regulator_get_voltage(st->reg);
-	if (vcm < 0)
-		return vcm;
 
 	if (vcm <= 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
@@ -443,7 +437,7 @@ static const struct iio_chan_spec admv1013_channels[] = {
 	ADMV1013_CHAN_CALIB(1, Q),
 };
 
-static int admv1013_init(struct admv1013_state *st)
+static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 {
 	int ret;
 	unsigned int data;
@@ -483,7 +477,7 @@ static int admv1013_init(struct admv1013_state *st)
 	if (ret)
 		return ret;
 
-	ret = admv1013_update_mixer_vgate(st);
+	ret = admv1013_update_mixer_vgate(st, vcm_uv);
 	if (ret)
 		return ret;
 
@@ -498,11 +492,6 @@ static int admv1013_init(struct admv1013_state *st)
 					  st->input_mode);
 }
 
-static void admv1013_reg_disable(void *data)
-{
-	regulator_disable(data);
-}
-
 static void admv1013_powerdown(void *data)
 {
 	unsigned int enable_reg, enable_reg_msk;
@@ -557,11 +546,6 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	st->reg = devm_regulator_get(&spi->dev, "vcm");
-	if (IS_ERR(st->reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
-				     "failed to get the common-mode voltage\n");
-
 	ret = devm_regulator_bulk_get_enable(&st->spi->dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
 					     admv1013_vcc_regs);
@@ -578,7 +562,7 @@ static int admv1013_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1013_state *st;
-	int ret;
+	int ret, vcm_uv;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -597,16 +581,11 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified Common-Mode Voltage!\n");
+	ret = devm_regulator_get_enable_get_voltage(&spi->dev, "vcm");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_reg_disable,
-				       st->reg);
-	if (ret)
-		return ret;
+	vcm_uv = ret;
 
 	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
@@ -620,7 +599,7 @@ static int admv1013_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = admv1013_init(st);
+	ret = admv1013_init(st, vcm_uv);
 	if (ret) {
 		dev_err(&spi->dev, "admv1013 init failed\n");
 		return ret;

-- 
2.43.2


