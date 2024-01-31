Return-Path: <linux-iio+bounces-2065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34D843A88
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 10:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CB81F2C07A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11980633E9;
	Wed, 31 Jan 2024 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/pYVnkF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B6612CA;
	Wed, 31 Jan 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692324; cv=none; b=JotQXEduuuxga7BAFU4PXkRMJg9TAlA52yPmBH4K59pazT6Y50PsEAGZAsj/XIrFk6qjJbnFuWTvkAcbYAJ7w+h1vMowpZK1MBzi7hSQ+Dsw9m3Wr57QuVrIi1JBwszwrMZFChnr0Wn4483lENraLxHgGkfDftnmpwW3MmI8Bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692324; c=relaxed/simple;
	bh=ZSzxh1mwBJ8gwbcJrJRw1eyrmNdReZB2azT2AOBDd9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azjkFAbhPNXJNf1wdUIeNBctEuIUje4eCORm8eHtLUhAje/W46AZdAnOgne1KkklizSgb6pxYEeGeL9++y2qb4KexohCLftPxrrxt3bu0VyDqgpZZ82pOTQSJA2xRkyxUGMBrbNbUWh586U9LaAt7Wx2nvaPWXOulVAPzP58bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/pYVnkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06EDC433C7;
	Wed, 31 Jan 2024 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692324;
	bh=ZSzxh1mwBJ8gwbcJrJRw1eyrmNdReZB2azT2AOBDd9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/pYVnkF0Z2Jw7dslj+O5wnEfn9r9+mbY8SnH4blZ2Gb0To71L5jQt1coSG0YtyhF
	 dOUb2wIEwOFmglAEePM2haCqS18kyoxvTGpoNnQkrEYpU7VZjpCUAqH2XJVagnJv7Q
	 2xaGhcSQDVnadxUGcN9Aq2irYSU87rShMAFoYH1yL3MstFYh4vm8qy76yDHgvGWOSo
	 A5txKlxyqnhNCSD5CFlIldRBDRmI9gT3ffVegjZHCnh1+c4f82Uxs/Kxh+3sa5lLhb
	 LLnduRLOhpj1/dvqUKEV5eQlVy/eicmdE0qdVOsypjGcEF9lKCJHv/rnnkjSESplw0
	 tGVYXs3HqtdyA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 2/3] iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
Date: Wed, 31 Jan 2024 10:11:30 +0100
Message-ID: <26538457e42ec85bd7c705ee7d7cb2e93c17cc25.1706692153.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706692153.git.lorenzo@kernel.org>
References: <cover.1706692153.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to STM ASM330LHHXG1 (accelerometer and gyroscope) Mems
sensor.
The ASM330LHHXG1 sensor can use LSM6DSR as fallback device since it
implements all the ASM330LHHXG1 features currently implemented in
st_lsm6dsx.

Link: https://www.st.com/resource/en/datasheet/asm330lhhxg1.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
 6 files changed, 19 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 24914946f914..89d687ec3099 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -16,6 +16,7 @@ config IIO_ST_LSM6DSX
 	  - asm330lhb
 	  - asm330lhh
 	  - asm330lhhx
+	  - asm330lhhxg1
 	  - ism330dhcx
 	  - ism330dlc
 	  - ism330is
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c19237717e81..a3b93566533b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -38,6 +38,7 @@
 #define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
 #define ST_ISM330IS_DEV_NAME	"ism330is"
 #define ST_ASM330LHB_DEV_NAME	"asm330lhb"
+#define ST_ASM330LHHXG1_DEV_NAME	"asm330lhhxg1"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID = 1,
@@ -63,6 +64,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSO16IS_ID,
 	ST_ISM330IS_ID,
 	ST_ASM330LHB_ID,
+	ST_ASM330LHHXG1_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 154f92fa9a87..0a7cd8c1aa33 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -31,6 +31,7 @@
  * - ASM330LHB
  * - ASM330LHH
  * - ASM330LHHX
+ * - ASM330LHHXG1
  * - ISM330DHCX
  * - LSM6DSO
  * - LSM6DSOP
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 01ef9d38aadd..0716986f9812 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -33,6 +33,7 @@
  *
  * - ASM330LHH
  * - ASM330LHHX
+ * - ASM330LHHXG1
  * - ISM330DHCX
  * - ISM330IS
  * - LSM6DSO
@@ -836,6 +837,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_ASM330LHHX_ID,
 				.name = ST_ASM330LHHX_DEV_NAME,
 				.wai = 0x6b,
+			}, {
+				.hw_id = ST_ASM330LHHXG1_ID,
+				.name = ST_ASM330LHHXG1_DEV_NAME,
+				.wai = 0x6b,
 			}, {
 				.hw_id = ST_LSM6DSTX_ID,
 				.name = ST_LSM6DSTX_DEV_NAME,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 911444ec57c0..cddf41cc0ca9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -134,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,asm330lhb",
 		.data = (void *)ST_ASM330LHB_ID,
 	},
+	{
+		.compatible = "st,asm330lhhxg1",
+		.data = (void *)ST_ASM330LHHXG1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -168,6 +172,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
+	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index f56c170c41a9..c122c8831365 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -129,6 +129,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,asm330lhb",
 		.data = (void *)ST_ASM330LHB_ID,
 	},
+	{
+		.compatible = "st,asm330lhhxg1",
+		.data = (void *)ST_ASM330LHHXG1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -157,6 +161,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
+	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.43.0


