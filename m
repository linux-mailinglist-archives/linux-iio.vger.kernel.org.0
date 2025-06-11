Return-Path: <linux-iio+bounces-20507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76755AD62D9
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5FB7A8DC7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27338252906;
	Wed, 11 Jun 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RdLgWZa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419825FA00
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681771; cv=none; b=ad/XPFhAoJ0MAR/VOwyCvXF3ZxN/6BaEYvM47hQGt2WSscnjre6yM23Of0ZGJ68TF6QiYq2ciXHdkkwMgdVqtM6e6PLxf37zR/RQIf7q6I8yXKaCBzwko3KjDLbZ4prkhfNUxOGKqE0Hsws0t+fwWjHDVF+dHAx8PT+0zNR3xhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681771; c=relaxed/simple;
	bh=fAkKApzgvKKCY+4XB2hNM39jEFCTxF0PElDrgzvAlfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp0CQQeTauVhWW66pf+VZduTAkkLkrAo4IFQjLGztMox8ru6IDrFOAkyTN7F/Ep0DNgS/3yZ1fe9xPtraPUGIZs0TVAtur7AHYS8PO4d5ZFFfrzBIu1EUUuAt8n3Sx24kEs1xFVc239tBSSAHwqwiPNt93iMxp/WOQlwRN0BUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RdLgWZa2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4079f80ff0fso864804b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681768; x=1750286568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaCqKPIs2f0ylRS6bTSnQ5BqgfESWCqO1Av05E42Aq8=;
        b=RdLgWZa2Vc34/qYNPisBXxqg82arRz0uBD/VFP1QmO+NXHVaz94nXOh2psViGhE+o1
         +c3qQckjo0DPu2t2NngarfEfOPPNeIyZzFNx9EAevQfSh+Li3CFEf4LVWvsGr4X8oEy7
         BZ5XvRgG6WnW1P3j2XFWve3uBlxeWkgIaheoEXfV9INODBaOXKFASYu2FP6ITeX0+2Bf
         80EH93QiznRW90QCUgweceEwPf+1KklNX4IsrLa0SKuDMyO9+iDN8w3pE4wnOT/EqnCL
         0Rlp6fCI5Dxd4h2m1mT/ogG2z1GqTWYnmJkj+RcqbXeuz41aeIMqMEaoIPXS5klNBdr9
         TDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681768; x=1750286568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaCqKPIs2f0ylRS6bTSnQ5BqgfESWCqO1Av05E42Aq8=;
        b=BejFU6+lvfTNJ7Xe+rm90ZzvL1YjHekv56KtipmWemBkeXdn5FJNGfPDSr3PnQukB5
         9UZgxUfUYYbrjmjjHFXL65AMuEwinUPz+KOKbsz4o/4hOnuK3ZATCrd9udTzsVyoQz2G
         I6hUn34bjOmf65+8EiPaVxWzJ2yqXKZac4P/yunNakHfCvI38/lhPlWkOm9os8tDJwW1
         jAC7+4BqZyMlnFYKyEeM4fdpHRJJgQm857Yw/wEAXABM2yPFKtmBOln1mC0mhOX5ykc2
         FLrxerSwxZ7uluy9AYhcuP4D1pTbQNNqet8Ae2TjP+Q/Jiax0yK8fvwS7RycJnEbRIQw
         QZFg==
X-Gm-Message-State: AOJu0Ywc4bYnOp+rS80WXbwZqALs+tTPKummNMKlV8A5WLi0MvESM8zg
	Agc/ohBthqER+qq0m2KMSznPdW8ypHRueaISIYCKnWH6S6C5azTvr9S+tbpGRV7WqP8=
X-Gm-Gg: ASbGnctoWGjKIpwVp7Z9iRLDVEypONwCIfRz6NVQXwS8+mcnCNkJNO5vEBWKfsVjJl9
	avjep7cpWth1XoHEH6vt8Kb4YVsmJCGJFs5S4CTQMY71QUxfJH6Q7Ir6b05Wl7ZaLjVNreu51CP
	kvZ9gBy419jU4u0pyeSBExYNEWtUuG1qz897BWUng9DJOOuyJZWFVNeKQBA0tqdsmwyeYC3AVYz
	kQ5aXJjd6zJtMWE0hvS5xxUym9MQ0xxjcD/6ZTu6KuxXHJdzMMwOkKhpzi+DdtesraCzo5Jkob/
	0DLpDFXpaKyaRGtXR07D7LCLcnI0WJxTTgQE+Wq1ZrFt0V5WisFTclv4zlSX1T4jLaFS
X-Google-Smtp-Source: AGHT+IEqBdswhJxFab3cfPWoCt/XhvSdy8p4DMoA4oBrcj8i32O67dKlBd9w/Xt2c78Lmmmu54g1yQ==
X-Received: by 2002:a05:6808:3403:b0:407:a0ea:a233 with SMTP id 5614622812f47-40a66081d10mr892925b6e.10.1749681768360;
        Wed, 11 Jun 2025 15:42:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:08 -0500
Subject: [PATCH 16/28] iio: imu: inv_icm42600: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-16-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fAkKApzgvKKCY+4XB2hNM39jEFCTxF0PElDrgzvAlfA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXt+4nZ+zbyhmjJNdPfIxZOtXs2Bk8+N21Ob
 xic8BlFYmWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF7QAKCRDCzCAB/wGP
 wIUNB/48BoC8ymocKlLoNu3v5QYdcqupR0Gl4uhHgWI4Jt4Brgahbb5SfPq/3olqkbiy+T1Ookv
 DWyixFwL+PnlcdEYgsS3FtkBM77VlMTSo6KPDdiudRl4FOE1D8dxwHWMFTSURf17zsYwE+dDLHp
 YZRLNMo9fWgXqlnqEsBGDUgu2l57aaQxB6TaIlukki2lYZmsUTkPQsTN9JnX1WWTeNubNgf9d9W
 0ZUaDpZW1pcDF8oQsk1+HVaB1pWPs5UwKNoW9xGgFt43NyStIN8Eb/T84MFJaOOu+ikBdQENY1a
 Diwzxh8L7c4dTlMajUB9DvjbZGuzAcjh6/xW+3qRtK6/KKlM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 ++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index e6cd9dcb0687d19554e63a69dc60f065c58d70ee..dbd315ad3c4d2bd5085f7cd3cdc6de4391b1c896 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -902,7 +902,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -921,8 +922,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index b4d7ce1432a4f4d096599877040a89ede0625e0b..4058eca076d8b03a2290535eedffa0a74098d739 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -806,7 +806,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -825,8 +826,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;

-- 
2.43.0


