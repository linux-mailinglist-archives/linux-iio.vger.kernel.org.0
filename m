Return-Path: <linux-iio+bounces-23119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF2B30CE8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF7B1CE413B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF47220F24;
	Fri, 22 Aug 2025 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuN2bQAB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954191509AB;
	Fri, 22 Aug 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834624; cv=none; b=I+WJg0jqG67t+naMnRVqbsT+WFSw3Q2AkngAsk5xx96XCN0p0Ppm36STgctbF4+mUEciakyy9LhNqdtDfEr/lvuyRpmPPI8WAfYx5tAbzcbJEokFXDPYjTyqBQg4rbtjBddAAn660XUEA+Yy0ZgMdAAnRy07GGYRav20eDeeCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834624; c=relaxed/simple;
	bh=AwWtPL38y1r0iJuhWRg453I1C8i8OfauDf6niMfJUko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZWrczlcyEmIgMsb7pz21V4O6Q/bwXKW0COjbszZXLGITfNmaQyhKnzqGq4q0dx1MpztDwpwIwsXMfvk/A96f0QjvJhA2UoM7DRRqqxnGZIvqb1v/MQBeKZ8Zsz409kQExjaslJhnPCfeC2nQgRTDy27UQMPK8A3liU2XpwDIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuN2bQAB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1557860b3a.2;
        Thu, 21 Aug 2025 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834622; x=1756439422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zktb9gNCV40fpMD00X6p5W7la95jm4sktu3txkhmc0k=;
        b=HuN2bQABx3WOnXOgwudsIoxrgVoLjqq2javyR/Q4l8FGRYZibfrrZECNRJJKCPbXrH
         o7AIq17Rh8/G3hLLmG+4aEKZvKxznyluuU4f5boiQuCBHMGV5m0a1yd9SfV311FEoPWQ
         /HJhJfgSPOGY7AuxQIxuRtlR5ZfU94V1dZyV7cjVeUQUWCVmycoYOihuB6d7ePCKSEQa
         6LqoSS7JOP+i3twocw2Ql7QjkMKLkRTLQEzSrUM0edGUBaTFX/5UniLlIN+ikdggaY51
         bamEGCk6TIJbYXzMjYJE6Prb3Ax0kkplARXmJOkDus5YYAOdd9YteOxZsBnMT1u6MX0o
         cj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834622; x=1756439422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zktb9gNCV40fpMD00X6p5W7la95jm4sktu3txkhmc0k=;
        b=Ns5kMro3SG6Tv/3Tza84NWo96AnpwpfhQP9fR9o8ZQI3LIvMmbXipTQt0AGFCqgRxC
         /goDTfJZ9SgfLiQe4P6+Ratv99Ld+T1pgggikkRSrQ3ueVgCMHByYx8+p+w+DxbgdQzc
         +BHkEhKTaxUX7vD36tnDqGGCrbqAZe2tXJVd0JbJJHNVChSTL+KJurtsr22g56uSrJpF
         jmKNpzcPyRPmJWbzlM31CdzcwpMcLGlEQdbsaxmB+08tVp7vhRblk5CFnTZ7nLNP0gWp
         RBMWz5foE38OXXEwUou5GNnlo2iWE9DCR4K5Cg5Awx+YaR57A+rmZ/UgE+XtHwEOtJ+Y
         llKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeXgkqyT46TmCLjiIYDpAxaeIPTs7q/UJCmA0NQTaGqTtsVowkCPwmm/v6olLAvi1RP6ZPouNsI0NKkEg=@vger.kernel.org, AJvYcCX8q4MvG2a10sy+UQSzxp2u5hgv3RYKNEEFo9q3wCwoXRaxXaNINmdPOWuNH1+1W8wmqce2E7zw2eiuwBDZA50ut84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPW/al9rauTaLxOgpDjsh4zG7BCbOskCyX8MZlYgacmLqeB0th
	i2fhJBzrqfPwMXakRXs+bc+czFn5bk940p6uW9cCBuq89mIh/i5+M724
X-Gm-Gg: ASbGncvlFMVv1Wvkird6v/g8NPvrxInWc8APXX76Kc2yfj9gq+4Ox1knVfzL7mpNzB/
	OK8/zi6y0Th/FOsLcqdbVeAgWdwtIotxu5A8YtsEwZlGQs3+B0xEq8VF+s9Mj5hkNKC4YfEjlJ0
	WN+RC931IVkXReDzf3lOjsXs/CchztoHNWhUJ8V/aGjoDX8OF0US26CW4noQhvrL4zM3jT+FgLM
	ZDXLSmqL49y/MUHdooSJJbIfwanYUATbpKw8xzKuLqu72uY/nKjH6lJKcnTVjg3mbn6iiF/qXFx
	W+3Ooh1Xuq9BNQW3eSnvWr13nfu25ixx4O8zhvxXCOOQyeEmMgCMu3DLrzZVTdihorqL1vZyr6W
	+bTbX5qlRqTqyWR7oZgdyWR5Sky2C
X-Google-Smtp-Source: AGHT+IFDoZyIz0WRIUaxN7FXYxLo2r7HqUuxevy2n8ltiyBxZUhzirU0KHdL7UEIoextymafrEyd3g==
X-Received: by 2002:a05:6a00:858e:b0:770:3663:d7ed with SMTP id d2e1a72fcca58-7703663e373mr162150b3a.8.1755834621826;
        Thu, 21 Aug 2025 20:50:21 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:50:21 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:49 +0530
Subject: [PATCH 01/10] iio: accel: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-1-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=4894;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=AwWtPL38y1r0iJuhWRg453I1C8i8OfauDf6niMfJUko=;
 b=HyArtRPdcLffakDtLhClwxTdP+mH4OjolmAEC2kl0Ef9kkGBHqmafuOPvQlafSR3649vcC4lc
 /gRsKN/en8vAYGKTMMFbugkLJ14LDuKTxUNJK79Mcbj67+WHGSq6Qtv
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/accel/bma220_spi.c | 4 +---
 drivers/iio/accel/dmard06.c    | 4 +---
 drivers/iio/accel/dmard09.c    | 4 +---
 drivers/iio/accel/dmard10.c    | 4 +---
 drivers/iio/accel/mc3230.c     | 4 +---
 drivers/iio/accel/mma7660.c    | 4 +---
 drivers/iio/accel/stk8312.c    | 4 +---
 drivers/iio/accel/stk8ba50.c   | 4 +---
 8 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 38f7498431ee..01592eebf05b 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -255,10 +255,8 @@ static int bma220_probe(struct spi_device *spi)
 	struct bma220_data *data;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&spi->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->spi_device = spi;
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index fb14894c66f9..33f225d73e7b 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -137,10 +137,8 @@ static int dmard06_probe(struct i2c_client *client)
 	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dmard06));
-	if (!indio_dev) {
-		dev_err(&client->dev, "Failed to allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	dmard06 = iio_priv(indio_dev);
 	dmard06->client = client;
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index 4ec70ca6910d..d9290e3b9c46 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -95,10 +95,8 @@ static int dmard09_probe(struct i2c_client *client)
 	struct dmard09_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 71cd1928baa6..575e8510e1bd 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -191,10 +191,8 @@ static int dmard10_probe(struct i2c_client *client)
 		return (ret < 0) ? ret : -ENODEV;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index e2853090fa6e..3e494f9ddc56 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -169,10 +169,8 @@ static int mc3230_probe(struct i2c_client *client)
 	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->chip_info = chip_info;
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index d0a16f227903..be3213600cf4 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -192,10 +192,8 @@ static int mma7660_probe(struct i2c_client *client)
 	struct mma7660_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index dfac2e44191f..305d88b1ae0b 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -505,10 +505,8 @@ static int stk8312_probe(struct i2c_client *client)
 	struct stk8312_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 05d4fd540eb2..0f984b72a35b 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -386,10 +386,8 @@ static int stk8ba50_probe(struct i2c_client *client)
 	struct stk8ba50_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;

-- 
2.43.0


