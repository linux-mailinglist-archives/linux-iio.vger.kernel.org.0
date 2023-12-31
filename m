Return-Path: <linux-iio+bounces-1358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D6820C96
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96211B20CE1
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307CAD32;
	Sun, 31 Dec 2023 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqPE7SFP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB019449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F102C433C7;
	Sun, 31 Dec 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047759;
	bh=gtohdYKYVmvIZMgiZK1b3gRkd22ji9IpmJvxnSfQ2kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqPE7SFPqhWardG9bbyFgKqZ9+VkkMprpPqQjIPtTe6cXGZSntCGYynTQ9KKtxjaR
	 K2YQ9G10x1iU+gLEfddyLPm6Ftk/A7zoj4pRoo0aU0IQH7omvlcBaO26d5qwNl3Qtd
	 fnz40spiDPD9Ki/qMu3RllKAY8GN5a1VR/YKJMe1ORg58frY2WEx7PLhHGGhDY4T0y
	 CCT2oLEIrJu6vp2ZG527Qnbw6NuYZAp71S7jwUPFFbBobgAu/5jaTf2Rxtz++0fgph
	 HBVWPuSWyqYIVWj09rM4qaQlvlnSTFLKtkncS2T9LhFo8Tgw7OJ/tZm21MZMMSahj9
	 fCn6rfnDv7V8Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH 21/24] iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Sun, 31 Dec 2023 18:35:11 +0000
Message-ID: <20231231183514.566609-22-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. This example was doing it correctly
but I am proposing dropping this so as to reduce chance of cut and paste
where it is done wrong.  Also drop now unneeded linux/acpi.h include.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_i2c.c       | 5 +----
 drivers/iio/pressure/st_pressure_i2c.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 71ee861b2980..fd3749871121 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -127,14 +126,12 @@ static const struct of_device_id st_accel_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
 	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
 	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
-#endif
 
 static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM303DLH_ACCEL_DEV_NAME },
@@ -204,7 +201,7 @@ static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-i2c",
 		.of_match_table = st_accel_of_match,
-		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
+		.acpi_match_table = st_accel_acpi_match,
 	},
 	.probe = st_accel_i2c_probe,
 	.id_table = st_accel_id_table,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 5101552e3f38..389523d6ae32 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -55,13 +54,11 @@ static const struct of_device_id st_press_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id st_press_acpi_match[] = {
 	{"SNO9210", LPS22HB},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
-#endif
 
 static const struct i2c_device_id st_press_id_table[] = {
 	{ LPS001WP_PRESS_DEV_NAME, LPS001WP },
@@ -114,7 +111,7 @@ static struct i2c_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-i2c",
 		.of_match_table = st_press_of_match,
-		.acpi_match_table = ACPI_PTR(st_press_acpi_match),
+		.acpi_match_table = st_press_acpi_match,
 	},
 	.probe = st_press_i2c_probe,
 	.id_table = st_press_id_table,
-- 
2.43.0


