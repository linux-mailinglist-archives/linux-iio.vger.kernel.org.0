Return-Path: <linux-iio+bounces-12988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666C9E1457
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 08:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B549281DD3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70933189F45;
	Tue,  3 Dec 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Hmcrf63s"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EB2500BD;
	Tue,  3 Dec 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211327; cv=none; b=gSa98diNYXBAEWNiTBLiot8khTk/rYtijK/CUjv6GLNskxZuMLJnsW9v53td0tWeKCnJJiHGxoMT0U71sfDtzTtN/yeo4coorCOTJZrkWhU5w3rb9j6YpNZ8qDrRuAtSy1y/mvLEcvwnqEm4yST8aCNLT6HpXQuQachfkRrqXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211327; c=relaxed/simple;
	bh=rVywOE0gRgGqCEDA/wgT1A60I07fUyj/DjFLWSig95E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X1j7rxxFra964YSK1o/fvM2kHfJgRecgITQ5T3bVGOG6sKxePabJhdrs3OlM2G/99ggMvUqwVq7SGRfg8A1h7YhoRCpS9/r3MjjesIWidWUl5nJuNwcZELqY371J8tE/exAHwF1ZMjGowNEPeu7pvvSHnHOlBYYCJIciF+VteHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Hmcrf63s; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=VBzRnmrC8jmWZvvyhpj/asxRV9aBhj2F5LFhdxtLcfU=; b=Hm
	crf63sNEleBGJxoSxu2E34jJ3jVc7qvsugD/cmHZW3mpa+e7TaS0WDUtEisEYaGEK+5uYJcPw/xfs
	J8qjO8PYBfBK28v3u0849Q8em9J/Iuc3J6iCm7i7HfeGGSftSHlReY36eiNH7J6wnxP78guPdRyAR
	ohQB1rdTP5nyLrUNJTR2/YxEnVTWvHyngnUrybzG4j420qTAvrWQvqyc0vZN4QvO9DgCzlKpBkUiX
	srhQVALwVIzw5y6IAYdGkD37COwwSm2GTeN5w8mDMzy9+yneyWUEtiAteLq0AVmeEmVGMsxEvK0o2
	ESXzp91MsBAMEeR/Kr+AyW5HozHCelmw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tINCu-000FNH-4C; Tue, 03 Dec 2024 08:20:28 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tINCt-000Bol-2Q;
	Tue, 03 Dec 2024 08:20:27 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 03 Dec 2024 08:20:17 +0100
Subject: [PATCH] iio: imu: st_lsm6dsx: don't always auto-enable I2C, I3C
 and SPI interface drivers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-lsm6dsx-v1-1-6d7893443bc8@geanix.com>
X-B4-Tracking: v=1; b=H4sIADGxTmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKGbU5xrllJcoWtqYWpoYWRgYQIUVAKqLihKTcusAJsUHVtbCwBFrqq
 4WQAAAA==
X-Change-ID: 20241202-lsm6dsx-585182084202
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27475/Mon Dec  2 10:41:11 2024)

This patch makes I2C, I3C and SPI interface drivers for ST lsm6dsx
individually selectable via Kconfig.

The default is kept unchanged - I2C, I3C and SPI interface drivers are
still selected by default if the corresponding bus support is available.

However, the patch makes it possible to explicitly disable drivers
that are not needed for a particular target.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 89d687ec3099cc3ecb848e44f610c5cd64c80ad1..3cabec3b152d21403b40668a20ca7d175109a79e 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -6,9 +6,6 @@ config IIO_ST_LSM6DSX
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
-	select IIO_ST_LSM6DSX_I2C if (I2C)
-	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
-	select IIO_ST_LSM6DSX_I3C if (I3C)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor.
@@ -42,16 +39,19 @@ config IIO_ST_LSM6DSX
 	  will be called st_lsm6dsx.
 
 config IIO_ST_LSM6DSX_I2C
-	tristate
-	depends on IIO_ST_LSM6DSX
+	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors I2C Interface"
+	depends on I2C && IIO_ST_LSM6DSX
+	default I2C && IIO_ST_LSM6DSX
 	select REGMAP_I2C
 
 config IIO_ST_LSM6DSX_SPI
-	tristate
-	depends on IIO_ST_LSM6DSX
+	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors SPI Interface"
+	depends on SPI_MASTER && IIO_ST_LSM6DSX
+	default SPI_MASTER && IIO_ST_LSM6DSX
 	select REGMAP_SPI
 
 config IIO_ST_LSM6DSX_I3C
-	tristate
-	depends on IIO_ST_LSM6DSX
+	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors I3C Interface"
+	depends on I3C && IIO_ST_LSM6DSX
+	default I3C && IIO_ST_LSM6DSX
 	select REGMAP_I3C

---
base-commit: 4ecd1edf4994bc5385609c6ea9e599b4ee958706
change-id: 20241202-lsm6dsx-585182084202

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


