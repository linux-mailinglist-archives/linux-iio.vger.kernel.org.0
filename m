Return-Path: <linux-iio+bounces-9037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B43968F97
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EC528475E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7A188A1E;
	Mon,  2 Sep 2024 22:29:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E93188593
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316142; cv=none; b=NWo+tM3NgqLuao3C6MMtm4Tbc26lLzwuoxMDqhVb/3krx8Zep7TYf5KsxzuELjrme76Q5ddr3LShVriRToZXt1fU2+8/khFb20nw2OKZciclZDuOXlBaLoxNMLkLNir6YeS+WTxsWaiXey58dBkdylIYFDc8N3qh6Z/BT1X6GyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316142; c=relaxed/simple;
	bh=rz4cPLPk4U/N9gxi84pXdf1L9hx4wLHD3D5UxEPPbnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUMHvaAHXynng/sOFUtZzPeCgWCSkdtKrI1JDn2rUsZcXQIME4XmCnwfXyQLVQzvs96q39dZO2jZ99ZUDCVHuoxxVgL00QJGXfgYwjIYdWyn2FMKSKV6rJI9iIPTybyIVX3R2rAVEieeyfDrQS2UU7RGb2J27IR7GTMg70bR9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b3ad4428-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 14/22] iio: imu: st_lsm6dsx: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:59 +0300
Message-ID: <20240902222824.1145571-15-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ed0267929725..3958b5e1a3f6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2132,14 +2132,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 			const struct st_lsm6dsx_reg **drdy_reg)
 {
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	int err = 0, drdy_pin;
 
-	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0) {
-		struct st_sensors_platform_data *pdata;
-
-		pdata = (struct st_sensors_platform_data *)dev->platform_data;
+	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0)
 		drdy_pin = pdata ? pdata->drdy_int_pin : 1;
-	}
 
 	switch (drdy_pin) {
 	case 1:
@@ -2162,14 +2159,13 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
-	struct st_sensors_platform_data *pdata;
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	unsigned int data;
 	int err = 0;
 
 	hub_settings = &hw->settings->shub_settings;
 
-	pdata = (struct st_sensors_platform_data *)dev->platform_data;
 	if (device_property_read_bool(dev, "st,pullups") ||
 	    (pdata && pdata->pullups)) {
 		if (hub_settings->pullup_en.sec_page) {
@@ -2524,9 +2520,9 @@ static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 {
-	struct st_sensors_platform_data *pdata;
 	const struct st_lsm6dsx_reg *reg;
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	unsigned long irq_type;
 	bool irq_active_low;
 	int err;
@@ -2554,7 +2550,6 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
-	pdata = (struct st_sensors_platform_data *)dev->platform_data;
 	if (device_property_read_bool(dev, "drive-open-drain") ||
 	    (pdata && pdata->open_drain)) {
 		reg = &hw->settings->irq_config.od;
@@ -2639,7 +2634,7 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
-	struct st_sensors_platform_data *pdata = dev->platform_data;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	const struct st_lsm6dsx_shub_settings *hub_settings;
 	struct st_lsm6dsx_hw *hw;
 	const char *name = NULL;
-- 
2.46.0


