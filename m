Return-Path: <linux-iio+bounces-20508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB974AD62DA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C8D7AA3C2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BB2627F5;
	Wed, 11 Jun 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sRM0AqK6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496526057A
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681773; cv=none; b=BYv4NolgphVlBRMR/aebpMrMSkwj8/0vklbk6/tlZCgXHS3ZMuLBM1R/sRrC+w5EfK/auj7cgdthwdjSlpdAzsSB4CvkIbDu//tyzpAvxPcyB4QaaVfcXwWOY1WKEbOU9yHexSq4nfkPvP3URfhAvC5ijIgU8TLqFBk8LFivniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681773; c=relaxed/simple;
	bh=NMgmVVL3w5aWTWvBC+xusdF+bAVkf9GZ8B3SAIKd/as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLSWlTZMBEBLxz7UGA0QbhCmZcXdaIu99JV8vs5SeBreCrIJFX7QEOUIi/nAF/OkGCZl5e2hu3/KfCO9KQUQ0pcaeSNMwNGzyY1MlX7+svwpDUv5vTsilONH4TRqdR16CP7FKYG3WY5jARZGmJCVoUlPWPxoKpMoZVLKTFQs7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sRM0AqK6; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-407aac76036so195598b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681771; x=1750286571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nl3LqMpYZe7rL10QvcxF4QXnsqo21gvi2tg2ycz1DlM=;
        b=sRM0AqK6no4PqlynMlWQJNfKXSRQjXFZdryPbT6BMz0/xAR7/QtM7UPQd+5KEL40FN
         iHshBrpyQ6ajm6B/XWUBcMVFRzxJSSeMmcQ0O5vu87He+1yKEidWfZiXuFAU7IHUMxE1
         4EppQdfn4BQ8dJumzQwCjn4xDzpob+zHhQQAowj7ITh3fcPdPSUmsiOo2dU2bB8iqNDH
         JXrCOZdVmz8MGuSQ7TUfHECtLr+MaAMPcQDLc5NLPiVMni043ozjb7Ucovblanw0gZ1l
         zUYGihzRI3yT9FAgHxq/kOsM8PcbwCt8+9hZwgZKdvf2AiiUjZlei8S0beM8fy3JWHlx
         jHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681771; x=1750286571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nl3LqMpYZe7rL10QvcxF4QXnsqo21gvi2tg2ycz1DlM=;
        b=n/RA7OVD2XoLyC2SSu91kMeqf9uuCFJ0ZF9NTz9YTkvywVAWW3QRFBeMddZzpLVs+5
         sJUD8MEAlzMgaC1Pxj5kuHaBAqSQ9+TwaNLMqMI5GaJHhBmqc2cWwQ72lZrTHRvmDY2L
         1Fs+3qaGNmRlewtU6p6RNrqSRnFFrMmiY6i+OqclDGtNUTCZLkMj6uo9ulsLX36kL09+
         OEnH/Xl86nOFrMdVbh/xIqUL/wSlT/rnJ332C93fRenN0enOXop7+O9SXiD7nWIQESA0
         yyQoKzPj8UotqKBAyu1KsGd9JHY3uHsOYUwO7AtJ7C8xnSOUvjwVo3R1OY7zYkzg6lO9
         Am0w==
X-Gm-Message-State: AOJu0Yy+CoryECCzla26zYKqFhan/XxFmpD8XEpjFzAbgMszdxwTd0i1
	P+FNi4KeMSAU65AWalehrLEAhFqYPuTQWXOYD1yZHwb72CmyKpITAElD7wsDlZAgnFw=
X-Gm-Gg: ASbGncuRFqf7Ch1LdLNZ3wjCfxMkLIdSkUJpGpvGRj8bfsc/SLt7ztJ8ZQgGkRZBbzT
	WuOxFHQWMEQFjcL19gwvQgktgjCf2p61Lw7fdUjgKL7qbXqIrMEe0+HLhMzBo0qMIYO/+fHObMw
	p/c7FPcl7dLe7/uLOUCgnUlRxyn8juCcAt3b3heJM5uuXWSixmX13wrJycApsRjP+JlkhRZHkUd
	NbLGPL9HZU4+xewkfmY0Yksa9CpnaWJKYOcSTXKoHqn9pACkMLb50sftYJyi3VlylxLuptaVJgy
	ZZ41bPjJLya8WlLQkyyrDY2yswSoqkd/mfoiC1zF7SbqDgdmUN9J/j+wLo694S7aoHo2
X-Google-Smtp-Source: AGHT+IEZSzWZ0MLiN0yyfGFrwS0RNkzhIod27nlhwUlhO/mElQY328781XuzrgNg/ZcIzQzVUMXtHA==
X-Received: by 2002:a05:6808:219a:b0:406:6fe7:37c1 with SMTP id 5614622812f47-40a66b32e32mr548422b6e.28.1749681770650;
        Wed, 11 Jun 2025 15:42:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:09 -0500
Subject: [PATCH 17/28] iio: imu: inv_mpu6050: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-17-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NMgmVVL3w5aWTWvBC+xusdF+bAVkf9GZ8B3SAIKd/as=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgX0U8uxbbKAo49fqrCappc+c/T/hCIP3Y0dC
 FOJqlflsliJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF9AAKCRDCzCAB/wGP
 wL4lB/9xRpYrOL5Dj/pVmFpiHVwrPZM5pGRIEo0tTLcH/Q5JOsLHQ5o/dbIirg/cJUikFfWLQ1G
 B7dqgu1hAl2Md4Pk6GklQzFpnaL0IqNcpDktycC3rp7CqezQvYDEGRcuC/yUKNmBLrL1HXOhMRu
 dFj7jXb/+0YU55sXaMa1UFfO2HiipdgqV0VoMprzCz8d6D6awosWDwQteOQXp56VLuseeqIvY5D
 bhcFYRq6FJO79v0KxUsdYYvTaGAhGGdrxJMabQ/o+fRiSHpy1dkzRXUnLMkM+Qf/Fgbfp1xFNWk
 WGqVvxJtN90stHJuDSbPGOqyJqWTW5GIY/9TYdSUXGc8gS0j
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 4 +---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index a9bcf02e5b43fac0e210c6f78816a3c042b52f3d..460792ed27e03192464066dfa088734f0b6b1cdf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -130,12 +130,10 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 
 	st->mux_client = NULL;
 	if (adev) {
-		struct i2c_board_info info;
+		struct i2c_board_info info = { };
 		struct i2c_client *mux_client;
 		int ret = -1;
 
-		memset(&info, 0, sizeof(info));
-
 		dmi_check_system(inv_mpu_dev_list);
 		switch (matched_product_name) {
 		case INV_MPU_ASUS_T100TA:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 273196e647a2b5a4860e18cfa34a088c773540e4..c4c11124f92f7fa6730e7443e3be67d920b8c115 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -50,7 +50,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
+	/* clear internal data buffer for avoiding kernel data leak */
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8) = { };
 	size_t i, nb;
 
 	mutex_lock(&st->lock);
@@ -103,9 +104,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);
 	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);
 
-	/* clear internal data buffer for avoiding kernel data leak */
-	memset(data, 0, sizeof(data));
-
 	/* read all data once and process every samples */
 	result = regmap_noinc_read(st->map, st->reg->fifo_r_w, st->data, fifo_count);
 	if (result)

-- 
2.43.0


