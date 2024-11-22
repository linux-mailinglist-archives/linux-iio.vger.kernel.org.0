Return-Path: <linux-iio+bounces-12488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413039D5E34
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A594B251B9
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC091DE4E4;
	Fri, 22 Nov 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iTEyjaDa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1201D86E8
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275251; cv=none; b=plN7Adompm8uqSxve2xnAlSY3HBdyF+BlgaEzDDwgECnD4GDA9GKFqDBcWrXCcn0xF8r94gu+BpDgd14jF7Yt6G4jDzRLlQiPbwrw8ZnAKPKpadVcxfYImc2R77S7/1Z0/KX4VxtnKnknSaziWYuSB4Pt6cAZCeeAI4gs9zzoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275251; c=relaxed/simple;
	bh=3ouC6J8jpQ6T3v2X4y2oAYZtCrMvewc3DweIK6uwMcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOR1oq+h96f45d4WxW5w2Yo8gCAso8TdNikT2H4sSDvwPixw7clEBU6dqKteWA/jMzbSM+le2kXSQhStroRkjVwkVIahogQRzNDFetMs5+8D/MTG9WjQXcNfl0/bThpfkvucDvGT3MLwiyfwPje88JedzRpqfHoaBzRYfjXqJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iTEyjaDa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316cce103dso23079765e9.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275247; x=1732880047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5vsE+1SYYglxp/JuuZv6rA3jQIs0OvM8YprYi8ne74=;
        b=iTEyjaDaJprstv+0+hpLEW+avMHvcVyjMmTULZO0OtwPbCW5dRaAfGaGuZ99LNyzlg
         4WlQEtHmAdlG70Iyx+pyhyCykNcRoBFTNOX+p7XbFdCeftG+dAe4ATDr8LGmkZceV0Ng
         S8APRy0RnH73CR/ZcUoQ6VWR/OWgDeqjx/Zxh2B6EtKm7qqhwCDqTmEMiuSvYQXu839x
         1fZuUu2Hi0cnDiyRVNnla9koEjxdHifxS8SA7gKZJjWtdCkC1Bg7iZiolkMWTZUZUoo7
         R+5fTvttdx5+Eloq991LJisrRnmJCYXgjq8jpOQEqaoiLOh9g5hJ5Q1t1JwbBYM20tB2
         8klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275247; x=1732880047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5vsE+1SYYglxp/JuuZv6rA3jQIs0OvM8YprYi8ne74=;
        b=hmATxDxWVjmIIcr3NKjVgS9a8O1YRq+itBdhKFVbubzvCDsHwCrt5OOxVZmM2t5TMG
         FWNnqC4cJeGBpehLGOgcBUkwSNtmH/quknU0MzXdoKtwTdatKiqBi6m27TqxO2dr3XHN
         r0BD2YY1GE/1YHe51TpIHgr+lB1n5ApJB/3g7xfcuVEkSM8d3GVWd0A6/leL0oBFkum+
         tgFF0TVG8uTT6JgiyhvnOLL9qh+4eiSPAE8qewuEP4YDz1ekd5zeNWuXMGbpWxzT+wwg
         6V/XTLfjfobHVjrDEzQuFLnnX/R3qIzEJ4BJ9WvGKWRQgrG7g9YCiIhsEa6THy/fIV6U
         yHrw==
X-Forwarded-Encrypted: i=1; AJvYcCUlMiuNQ5Xe31TdyO9MQ6rmffxFe0PwsDd7Prh59El+x9vXwnnCUyltyKqzlNmNEY/ITzdhIDI4fd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjGieW2oWJQzjDOVEpLJEiFw6g/i8ylQVQaiR7Cl1zi6X1R1E
	BoU7tOaZTgkxTtUNpnn/ww2q3TLmdzLaaF/WVVacGjhcstJAI7lCd+mbCBme++0=
X-Gm-Gg: ASbGncufsA70r0pFs2gCkmr9+agYqY5I6cF9oKZVaJsR79AgKXC1RPoVpXeNdtbhQVa
	FQYbWvia2DX7/538/XCGuBhiamZVhISz8vOupRObeqEmT7df1oiLdO+85fAIm5aEukzJMGbNrwb
	ZuLaQUYXe8Gode1U9jWNYtWW7EXgf+7SYydhFzEu3DRBakcSe+2Od/7uohIofJzIwRJfUWgZpLu
	RjlmhLIEMBjbLFINzZ7UH1rj9hppe0A33QNzJFD0BbKN5SJTv5LgwJKg0kgd8sa27TkAVZcg0Cn
	uxk=
X-Google-Smtp-Source: AGHT+IHdJrpGFH+gGF2qBS38dFzz8yaqpoa0wV1UGm5qxuW2Vnd7GSahUaeXQVae6Vetv8sEmdsCxw==
X-Received: by 2002:a05:600c:5122:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-433ce41ffc9mr23368535e9.12.1732275247117;
        Fri, 22 Nov 2024 03:34:07 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde0db3csm24366755e9.10.2024.11.22.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:06 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 07/10] iio: adc: ad_sigma_delta: Store information about reset sequence length
Date: Fri, 22 Nov 2024 12:33:26 +0100
Message-ID: <20241122113322.242875-19-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6454; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=3ouC6J8jpQ6T3v2X4y2oAYZtCrMvewc3DweIK6uwMcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwUT0QNl9RCzqLhsvPaC1sJMvPjbfgJBMENb gVwGgwTFjiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsFAAKCRCPgPtYfRL+ TpqPB/0dx9cIU3Dd3gLnlRnE0IGx7IdbKgBO7WN1iFtCJQsTMaSVGneTEZZDx2jtDfTBKrcTA51 nf64S3u7ukJGfRhXE7z81abDotwYEKey0sbK/9yW9AefhOnRyThx4nhB/6CWyr+EMhGRJ6xPMzC xDI6vuTKg6zXHbfvexVFpIxImcCD06/xIU1+4bB2ZH7yQ2v3DSCuvF7R3RrkRUByluAYOBSI1jT xQcB8VDhSCyQ0ma9MIR2+JjbPEDZm+cX7q4oByxIE3igwrFZHTlthaA86rNgPbmZoq7g6D2+NxO iyie+ao+0/jjKHVtnDd2fHZ31nn2+8TUPp4URpixTw8+EFBI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The various chips can be reset using a sequence of SPI transfers with
MOSI = 1. The length of such a sequence varies from chip to chip. Store
that length in struct ad_sigma_delta_info and replace the respective
parameter to ad_sd_reset() with it.

Note the ad7192 used to pass 48 as length but the documentation
specifies 40 as the required length. Assuming the latter is right.
(Using a too long sequence doesn't hurt apart from using a longer spi
transfer than necessary, so this is no relevant fix.)

The motivation for storing this information is that this is useful to
clear a pending RDY signal in the next change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c               | 3 ++-
 drivers/iio/adc/ad7173.c               | 1 +
 drivers/iio/adc/ad7192.c               | 4 +++-
 drivers/iio/adc/ad7791.c               | 1 +
 drivers/iio/adc/ad7793.c               | 3 ++-
 drivers/iio/adc/ad_sigma_delta.c       | 7 +++----
 include/linux/iio/adc/ad_sigma_delta.h | 5 +++--
 7 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 1f3342373f1c..b17c3dbeaeba 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -571,6 +571,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.data_reg = AD7124_DATA,
 	.num_slots = 8,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 64,
 };
 
 static int ad7124_read_raw(struct iio_dev *indio_dev,
@@ -756,7 +757,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	unsigned int readval, timeout;
 	int ret;
 
-	ret = ad_sd_reset(&st->sd, 64);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 0702ec71aa29..2550194efee8 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -744,6 +744,7 @@ static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
 };
 
 static int ad7173_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03..c4dd48edd8d9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -361,6 +361,7 @@ static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.status_ch_mask = GENMASK(3, 0),
 	.num_slots = 4,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
@@ -373,6 +374,7 @@ static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
@@ -565,7 +567,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	int i, ret, id;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 48);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 	usleep_range(500, 1000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 86effe8501b4..c7509b911835 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -254,6 +254,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.addr_shift = 4,
 	.read_mask = BIT(3),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static int ad7791_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index abebd519cafa..0767c56bb442 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -206,6 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
 	.addr_shift = 3,
 	.read_mask = BIT(6),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static const struct ad_sd_calib_data ad7793_calib_arr[6] = {
@@ -265,7 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 32);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		goto out;
 	usleep_range(500, 2000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fd3560beb56b..19cb9b7b62c6 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -182,14 +182,13 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, IIO_AD_SIGMA_DELTA);
  *
  * Returns 0 on success, an error code otherwise.
  **/
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length)
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
+	unsigned int reset_length = sigma_delta->info->num_resetclks;
+	unsigned int size = DIV_ROUND_UP(reset_length, 8);
 	uint8_t *buf;
-	unsigned int size;
 	int ret;
 
-	size = DIV_ROUND_UP(reset_length, 8);
 	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index b3e4d89f2d06..39bb3a6dd9cd 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -53,6 +53,7 @@ struct iio_dev;
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
  * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
+ * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -69,6 +70,7 @@ struct ad_sigma_delta_info {
 	unsigned long irq_flags;
 	unsigned int num_slots;
 	int irq_line;
+	unsigned int num_resetclks;
 };
 
 /**
@@ -180,8 +182,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int *val);
 
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length);
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta);
 
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
-- 
2.45.2


