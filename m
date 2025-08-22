Return-Path: <linux-iio+bounces-23120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B044B30CEA
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A2B6168C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2C22F74E;
	Fri, 22 Aug 2025 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKqytArJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913121D3F5;
	Fri, 22 Aug 2025 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834635; cv=none; b=lyRSto79mhiDEkAacjmm9JonWkAWkPxMhJkNe9ASJVYoBi9rSA9Vv2F7cMd1y3a21yV2pTsRp+/kuJUc27IIizTQLi8PW0fXnUMw1RIEi8KF/S/aZDEKsyPdU5O++5TKPee7sBGREytPa6kEJFZj+EH7P++mCVFtWeC6VDiJmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834635; c=relaxed/simple;
	bh=AGu9ZkRHfhF6t137X8zXcHpvsGhVHMDMV1L9x/K150I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDe1XKURdGeZSWPOWpIieBxaZsaSgC27oPj3R+O39fipkVPsJ4GXomJLTWaJdYiEwwbK643SBBIKH7LeBVoxnRqvReNQuLX2r/Ldyj+adTDI6h1erPw6NhaJGSOddMsuNaP6Ruds/K1MuvNrSqhotc9WjhcUP8N6AMvINuPu6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKqytArJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so1933746b3a.3;
        Thu, 21 Aug 2025 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834633; x=1756439433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqTeTmuPyRyJ3pkNoYGDtSBuc00zqnBTdwwG/CzasEM=;
        b=VKqytArJSlxH9wUaL/Pe6KNdItGAhm5cO8NO4JArsmSXAZdW3efhdSW1b2cJQapE8r
         EB1S3Y2mbjiKsk/tYTwaZzio25ZMZmY9/LAK2MWZCWLp0JRl8izwRkBjXcdo3oPyOETc
         tvdQbBuphL8C+zLWA8BVIeU85rqJI5NZDPvfGdM4TN6wnKuEngIRfcZjxUrQRj8nm7Aw
         nRraszIbSq5YP9yhkMKIZP6aPXzJX03WDtRNLlnWVsCOcHUW3TyiVCSpDrWzDKLI6YyX
         B8G527q1hhpamsPRhABOZBrt15xiksb+/nOPTCbJpMt+ObwJIWQ8A/PssDErEwsH6cYr
         ehUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834633; x=1756439433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqTeTmuPyRyJ3pkNoYGDtSBuc00zqnBTdwwG/CzasEM=;
        b=dn8fnsAaxF/9/TcvbAtq+ezYKgBLBLiGB9knLsgPwbn19u/+mj/3+NbOiuUgBDn//6
         0JM8OZavXdpCdLf/7ZqWL++ZSHYjKpyoI0ASVCwzmlqYtqpiwal+ry+7AesTq5UBrPsP
         LbjEZFjGEFh9sAXdmRsXBK6w6CC1nQ2U62jpD7XfNb0Yb7fMWwAqOaKCSYV5H7g0mDAp
         AJOuH7go2HSCf+zU1YJML0w7r1e2feEOjj1OR6lyvOR0jwwHd8gVsUh5i1DDlo3Da3ES
         DOljDA2VU+KikhChohtT06Q4A/KZwYRFnrIt1KqH+nB7hUllgQh3TL7y95/YtpoYgkPh
         RwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAyQMOXur3eoyZTN67gHKOLkoYBIjWXOsr8TENXV+XqtfB7lhkxJqxyDCcbCsEOBqMcUpUSbs1OiVh8aUEXIsJQkA=@vger.kernel.org, AJvYcCW9FPSxG627lLr83Zq+TzQpZB7SOTtxEbRsAzFoWAXm2NWrAP/jv1CSqe53qp2KTk45MVC3SPqtG4+hZqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynA/T41Z5tkXkR0X1I2DFuPXNntis5ViikDZXGHpzQfB7d3+Pg
	l4io/JWRtalBKn7wXs2Xz0/en3H67lVKv8KXthfB3kHUDwpG98Gk/Lrh
X-Gm-Gg: ASbGnctZNXbKnmAqEPPPKCE/zBpQ0IRjpzj+4hw53WaWVofU1KRgU5k9utvV46BciEM
	Ae6Ie09aGC+rObIfO4NODXMJqOKOXY/L5t4n3/QNsS/QOVTNWxz+m2FNum7ygjY09EFO4F4nHNb
	CvjgS7dvi3ytRijNazvYyJqUvrGChRG4Rh6BXlJnvr+Sqj2YDcyyYp9QIZ2BgNbxY0jVHTQBsq0
	eYzMDmHsMLJA6VmEHJnAFNbRAdAzi0DSyVdfNQetg9T3Tsu/RylCtpflhL9fYB6tQknpZOjJ/Ch
	dMWt0gHPBQG00YFF6o7GgMO3+TDGWlwnAhhCliPA97QngpEgLI3mzTPj5skBDed5j/rx/uTE/SH
	f9oAQBQqo9zEqea8SMIUSUkf4F8b+
X-Google-Smtp-Source: AGHT+IERxoDtaVf+dbrrvbv5pjZ4KSfLrglqW2Pvw+HdC3IHQrRaPUrXlowMN+IZs1D9wMCBHplfUg==
X-Received: by 2002:a05:6a00:bd12:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-7702fa057b7mr1767050b3a.10.1755834633167;
        Thu, 21 Aug 2025 20:50:33 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:50:32 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:50 +0530
Subject: [PATCH 02/10] iio: adc: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-2-db87f2974552@gmail.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
In-Reply-To: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=11663;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=AGu9ZkRHfhF6t137X8zXcHpvsGhVHMDMV1L9x/K150I=;
 b=hqMnjGHFYKykrgn5xbxcJprX4HQtBsNcj5+80fgC7kDWczGc3DTikdedYtP4NDO6fK1WjM8Zu
 VyzP4w7grMLBiK5eg6NuTBqN9ITKDUplHn5PYIrJsgtmxIdUR2wy7HO
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/adc/ad7949.c          | 4 +---
 drivers/iio/adc/bcm_iproc_adc.c   | 4 +---
 drivers/iio/adc/cpcap-adc.c       | 6 ++----
 drivers/iio/adc/da9150-gpadc.c    | 5 ++---
 drivers/iio/adc/dln2-adc.c        | 9 +++------
 drivers/iio/adc/exynos_adc.c      | 4 +---
 drivers/iio/adc/imx7d_adc.c       | 4 +---
 drivers/iio/adc/imx8qxp-adc.c     | 4 +---
 drivers/iio/adc/mxs-lradc-adc.c   | 4 +---
 drivers/iio/adc/palmas_gpadc.c    | 4 +---
 drivers/iio/adc/rn5t618-adc.c     | 4 +---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 +---
 drivers/iio/adc/stmpe-adc.c       | 4 +---
 drivers/iio/adc/ti-adc084s021.c   | 4 +---
 drivers/iio/adc/ti-ads131e08.c    | 8 ++------
 drivers/iio/adc/ti_am335x_adc.c   | 5 ++---
 drivers/iio/adc/twl4030-madc.c    | 4 +---
 drivers/iio/adc/viperboard_adc.c  | 4 +---
 18 files changed, 24 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index edd0c3a35ab7..4407828b4fc5 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -317,10 +317,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
-	if (!indio_dev) {
-		dev_err(dev, "can not allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	indio_dev->info = &ad7949_spi_info;
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index f258668b0dc7..6426c9e6ccc9 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -511,10 +511,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					sizeof(*adc_priv));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed to allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	adc_priv = iio_priv(indio_dev);
 	platform_set_drvdata(pdev, indio_dev);
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index ba7cbd3b4822..d9ee2ea116a7 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -953,11 +953,9 @@ static int cpcap_adc_probe(struct platform_device *pdev)
 	int error;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ddata));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed to allocate iio device\n");
-
+	if (!indio_dev)
 		return -ENOMEM;
-	}
+
 	ddata = iio_priv(indio_dev);
 	ddata->ato = device_get_match_data(&pdev->dev);
 	if (!ddata->ato)
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index b99291ce2a45..625e3a8e4d03 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -308,10 +308,9 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed to allocate IIO device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
+
 	gpadc = iio_priv(indio_dev);
 
 	gpadc->da9150 = da9150;
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 9dbd2c87938c..a6f3746b6f13 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -586,10 +586,8 @@ static int dln2_adc_probe(struct platform_device *pdev)
 	int i, ret, chans;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*dln2));
-	if (!indio_dev) {
-		dev_err(dev, "failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	dln2 = iio_priv(indio_dev);
 	dln2->pdev = pdev;
@@ -630,10 +628,9 @@ static int dln2_adc_probe(struct platform_device *pdev)
 	dln2->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					    indio_dev->name,
 					    iio_device_id(indio_dev));
-	if (!dln2->trig) {
-		dev_err(dev, "failed to allocate trigger\n");
+	if (!dln2->trig)
 		return -ENOMEM;
-	}
+
 	iio_trigger_set_drvdata(dln2->trig, dln2);
 	ret = devm_iio_trigger_register(dev, dln2->trig);
 	if (ret) {
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 4614cf848535..32cfc4002b1b 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -798,10 +798,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	int irq;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	info = iio_priv(indio_dev);
 
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 09ce71f6e941..039c0387da23 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -482,10 +482,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	info = iio_priv(indio_dev);
 	info->dev = dev;
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index be13a6ed7e00..427ee9f24408 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -315,10 +315,8 @@ static int imx8qxp_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
-	if (!indio_dev) {
-		dev_err(dev, "Failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(indio_dev);
 	adc->dev = dev;
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 92baf3f5f560..dda5182a5076 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -697,10 +697,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	/* Allocate the IIO device. */
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
-	if (!iio) {
-		dev_err(dev, "Failed to allocate IIO device\n");
+	if (!iio)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(iio);
 	adc->lradc = lradc;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 7c01e33be04c..3f433064618e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -885,10 +885,8 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "iio_device_alloc failed\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(indio_dev);
 	adc->dev = &pdev->dev;
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index d6f6b351f2af..f78fc795b69a 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -199,10 +199,8 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
 
 	iio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
-	if (!iio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
+	if (!iio_dev)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(iio_dev);
 	adc->dev = &pdev->dev;
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index f583924eb16b..92e5159793eb 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1763,10 +1763,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 
 	dev_data = of_device_get_match_data(dev);
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
-	if (!iio) {
-		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
+	if (!iio)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(iio);
 	adc->dfsdm = dev_get_drvdata(dev->parent);
diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index b0add5a2eab5..8e26c47edc08 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -267,10 +267,8 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 		return irq_adc;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct stmpe_adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	info = iio_priv(indio_dev);
 	mutex_init(&info->lock);
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 50a474f4d9f5..a100f770fa1c 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -200,10 +200,8 @@ static int adc084s021_probe(struct spi_device *spi)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
-	if (!indio_dev) {
-		dev_err(&spi->dev, "Failed to allocate IIO device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 085f0d6fb39e..c3bf0ed46690 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -807,10 +807,8 @@ static int ads131e08_probe(struct spi_device *spi)
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev) {
-		dev_err(&spi->dev, "failed to allocate IIO device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	st = iio_priv(indio_dev);
 	st->info = info;
@@ -841,10 +839,8 @@ static int ads131e08_probe(struct spi_device *spi)
 
 	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
 		indio_dev->name, iio_device_id(indio_dev));
-	if (!st->trig) {
-		dev_err(&spi->dev, "failed to allocate IIO trigger\n");
+	if (!st->trig)
 		return -ENOMEM;
-	}
 
 	st->trig->ops = &ads131e08_trigger_ops;
 	st->trig->dev.parent = &spi->dev;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index fe1509d3b1e7..99f274adc870 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -631,10 +631,9 @@ static int tiadc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed to allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
+
 	adc_dev = iio_priv(indio_dev);
 
 	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0ea51ddeaa0a..fe3b31ec976e 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -758,10 +758,8 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	}
 
 	iio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*madc));
-	if (!iio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
+	if (!iio_dev)
 		return -ENOMEM;
-	}
 
 	madc = iio_priv(iio_dev);
 	madc->dev = &pdev->dev;
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 1028b101cf56..9bb0b83c8f67 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -113,10 +113,8 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 
 	/* registering iio */
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	adc = iio_priv(indio_dev);
 	adc->vb = vb;

-- 
2.43.0


