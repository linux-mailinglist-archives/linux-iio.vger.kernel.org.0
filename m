Return-Path: <linux-iio+bounces-23121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ABCB30CED
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A258BB618EE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D41509AB;
	Fri, 22 Aug 2025 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Mf90Iq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CA2253FD;
	Fri, 22 Aug 2025 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834647; cv=none; b=aat7Kej/8+epH5G3oYaSqLNr48R66yXCsxSd9TVE3kuNlJYNC/eWtoD9Ulc2NMEnw77Kyf5ykkdLrRxKK3UgWl7riQ/rqs+SXTtytsVpVBBQOb8gfgp1688ktecvYcixR2dW0xRroTCtDcKGOllS5sDGLa2b8GITz9FE3wBjMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834647; c=relaxed/simple;
	bh=1K93tVeoPiLj/0fP86BU3YSmIy3OX+Xeg+DZkIsbkCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmzaotuATaKf9xKuues0oBtjOns1QU5a/A4h1Pb8HHsixHJfZJTK+WRpZnq7Kpf2SyPuCmcknh2j5F6hNWi4fVZbdF4gO6yLEenIJcJmNBXwdUFKVN4A7gG+J6V7V86zksMyx2j2+2q/Rh7IeNUG6HgPdC6xKyoURIcITva9cDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Mf90Iq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so1575784b3a.0;
        Thu, 21 Aug 2025 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834645; x=1756439445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWhZhPrOG/QAlgX04rUzc0hrbfIiVcVzkp3PRYw6Qbs=;
        b=h0Mf90IqDkOgjqhveknsVeGruZ6ZLe5YYmqFgCUHFaoGmavVfME8lpbRPYox5iFjdU
         1qFEqFWZUtnn13HpF+1P9Yc8//JdsiTd6lnL7N+Mxkf4GG8eYUctHAY/mTTW/Yxt/7DQ
         ovw2eCKLdt/WxW6lMiitYcnCYShBCNi/GAKMIadV1dAHy1nq/2aUxEgGH0KsKqD5162O
         W+FF4RNyFYidfpL1d88MZtaryUzmKBH07CnkJ9FVoZY5KZe7IslSy0B4X/zpd4gU+aA+
         840VMyIQlo/YHCYKLksSqR7r81P9CwKlxYe4n2+RwPkTaG3jyr8lfDtGenDBQJtItG/h
         SFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834645; x=1756439445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWhZhPrOG/QAlgX04rUzc0hrbfIiVcVzkp3PRYw6Qbs=;
        b=OZu3s1NZXghcnAmtrAMmidbXVQ7zXyiMwJmYa9CIfKqmAe68jgyjw2BarEp63SwmI8
         bhoyg0nDeJecMX35QZV+RMXoXnMP17XaRXZ3E4YTyj8hFCCawwBmWwxM5HyQufsRXCIa
         pwC+zrpa/1ekdnJMgXQL9GyLniWORf4eLgTQVR6uC5hbc7eTEUpAcfDPnjgWimVUDabJ
         /p6De1ER/wZq2Igp1t/XL4DMdLapJxILUO1ftTEqJtsJkQSti7wzjZqWdoouEN98fJtf
         qtUwbD10mWGkO9ZU1WwsiKGsdX32VzdzTgunSACqQwS2AcFhRO6AN35RW4GLdhnXyuIG
         kJNg==
X-Forwarded-Encrypted: i=1; AJvYcCUYBm3ZsX56gY6TbhKE/KS0t1aZuikvjAU2tBaRqF0fxqBIA7Y0ygY8wnPH+yCWabdh7YfCaCL+iLELAOP6lGAfo2I=@vger.kernel.org, AJvYcCX31lAbAMbcS73IR9nHB7tbn1tFQgoiirCPs09Gqe1Elfl0RcPuWN/irVln5JEjvwRfRs1ljkiwlPa6D6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/317xYP8ygpg8RPHlQzcZKIMIDUwtIuxfvt+ZvQaQ/VcJIsm
	gI4Z9Y3ZquAVZ4UXPWLDY9eWSozZzGPUmtC/dkEnmcqRgcdARpjEKQnD
X-Gm-Gg: ASbGnct69gbdFEZrxNS7e3XIZ1hUEBXOvnZbDiOgzFdA7PM4Xw8Xc2hKebR7b+KRw85
	o484gkQT259d7+u+46P73Cbg+JcIsZwXy+pXVlK8cvHe6A2F0nC1Sp4ewP5GdFgNUExEdGNwgYm
	YzCaaHbMkKzo9uFCcs3MuTHdg+jkIoy9l4IWVvTBY61vVjPVZVuj7Rk5qkUgp/T/IKJX+SqCjE/
	8toajMA591UPRvcSKN0umRybX81t6KxU7JfKFMSr8s/nkP5hnza1wNdbvWrv4XWoOLFLZUD9Drl
	NGdtJHQCQjAOA1wrzypozhrpy/QTJC41jAMEesdywjIr2pbpWmNEPPoZjzwT9arPSL7ScK0AYj8
	Pm76VGm54GmqwXZPIU1A0g9ZYwgzD
X-Google-Smtp-Source: AGHT+IHkP7IcI6b0w4x7HvhyRCGL8lDQ0eb2HC3aGo0CeMkwIFIX7qo+gbx+sa5/Xre12VY1dmNs5g==
X-Received: by 2002:a05:6a00:8ccb:b0:76f:73be:5c40 with SMTP id d2e1a72fcca58-76f73be5d38mr3282271b3a.0.1755834644500;
        Thu, 21 Aug 2025 20:50:44 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:50:44 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:51 +0530
Subject: [PATCH 03/10] iio: dac: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-3-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=3064;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=1K93tVeoPiLj/0fP86BU3YSmIy3OX+Xeg+DZkIsbkCY=;
 b=JROXYfDq1SqDL2ylheHeUCGY4etunQkZ/BgczFT/HiSsDjSgLfD+vVQv/PUGbpM0DntA8c+rO
 /vK5LfYFZBAAFXCYy4qQHdS9WRP7YF9lw/jPh6v3LyPjytsGbwnqVdv
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/dac/ad5380.c     | 4 +---
 drivers/iio/dac/ad5764.c     | 4 +---
 drivers/iio/dac/ds4424.c     | 4 +---
 drivers/iio/dac/ti-dac7311.c | 4 +---
 drivers/iio/dac/vf610_dac.c  | 4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index f63af704b77e..ffb8c676c7a8 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -371,10 +371,8 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (indio_dev == NULL) {
-		dev_err(dev, "Failed to allocate iio device\n");
+	if (indio_dev == NULL)
 		return -ENOMEM;
-	}
 
 	st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 26c049d5b73a..fbbd7105a80c 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -278,10 +278,8 @@ static int ad5764_probe(struct spi_device *spi)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL) {
-		dev_err(&spi->dev, "Failed to allocate iio device\n");
+	if (indio_dev == NULL)
 		return -ENOMEM;
-	}
 
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a26a99753418..a8198ba4f98a 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -221,10 +221,8 @@ static int ds4424_probe(struct i2c_client *client)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio dev alloc failed.\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 3d2ce61f0db6..5c1c5213962f 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -242,10 +242,8 @@ static int ti_dac_probe(struct spi_device *spi)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ti_dac));
-	if (!indio_dev) {
-		dev_err(dev, "can not allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	spi->mode = SPI_MODE_1;
 	spi->bits_per_word = 16;
diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index b30ff7bb4400..b7ee16ab4edd 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -178,10 +178,8 @@ static int vf610_dac_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					sizeof(struct vf610_dac));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;

-- 
2.43.0


