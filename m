Return-Path: <linux-iio+bounces-8818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38195FB98
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 23:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209BC1F226E0
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76E19B3EE;
	Mon, 26 Aug 2024 21:23:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915271993BA
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707431; cv=none; b=u6JtUF/DH9oOffhG7kiOkyO214kuAoXFf1tgGX3H3WZPerKo7IF247EfjahPoHwr6RXiM4vX1kfAijOthxC/TwFUguk7PHqYvsENaZXAbS7NSsQzvcC4fJriw2d156DzPtpe4NyLIuf3NsDpKGcnbndeJ+IjxQkf4u4xle59VcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707431; c=relaxed/simple;
	bh=AJvpk1xtG+Ud7tuglDJ1RPHK7+JF6ECeU6+oT7zj7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkUFhEDkTahnjD+CjCe+8dl0JtyNj6h+mAHB8b468TJ/iuo4BX/wj08yLVqfPFx5yNkeGHZKimHUp+m5zFQWIuKmVP8sSf2wnuHmfSIao5Yq3b33/T4FPo4b+hPAv6WCXZHNARvHeyzHEMwmNqpKkDChC/RU1KTq6zjJcJ1Vr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 7af5e7e2-63f1-11ef-aba1-005056bdd08f;
	Tue, 27 Aug 2024 00:23:47 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls
Date: Tue, 27 Aug 2024 00:22:40 +0300
Message-ID: <20240826212344.866928-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826212344.866928-1-andy.shevchenko@gmail.com>
References: <20240826212344.866928-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device property APIs designed that way that they will return an error when
there is no valid fwnode provided. Moreover, the check for NULL of dev_fwnode()
is not fully correct as in some (currently rare) cases it may contain an error
pointer. This is not a problem anyway (see keyword 'valid' above) that's why
the code works properly even without this change.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 23 +++++---------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 722b43f9203b..a7760c000c8c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2127,25 +2127,15 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
 	.write_raw_get_fmt = st_lsm6dsx_write_raw_get_fmt,
 };
 
-static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
-{
-	struct device *dev = hw->dev;
-
-	if (!dev_fwnode(dev))
-		return -EINVAL;
-
-	return device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin);
-}
-
 static int
 st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 			const struct st_lsm6dsx_reg **drdy_reg)
 {
+	struct device *dev = hw->dev;
 	int err = 0, drdy_pin;
 
-	if (st_lsm6dsx_get_drdy_pin(hw, &drdy_pin) < 0) {
+	if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
 		struct st_sensors_platform_data *pdata;
-		struct device *dev = hw->dev;
 
 		pdata = (struct st_sensors_platform_data *)dev->platform_data;
 		drdy_pin = pdata ? pdata->drdy_int_pin : 1;
@@ -2180,7 +2170,7 @@ static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
 	hub_settings = &hw->settings->shub_settings;
 
 	pdata = (struct st_sensors_platform_data *)dev->platform_data;
-	if ((dev_fwnode(dev) && device_property_read_bool(dev, "st,pullups")) ||
+	if (device_property_read_bool(dev, "st,pullups") ||
 	    (pdata && pdata->pullups)) {
 		if (hub_settings->pullup_en.sec_page) {
 			err = st_lsm6dsx_set_page(hw, true);
@@ -2565,7 +2555,7 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 		return err;
 
 	pdata = (struct st_sensors_platform_data *)dev->platform_data;
-	if ((dev_fwnode(dev) && device_property_read_bool(dev, "drive-open-drain")) ||
+	if (device_property_read_bool(dev, "drive-open-drain") ||
 	    (pdata && pdata->open_drain)) {
 		reg = &hw->settings->irq_config.od;
 		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
@@ -2693,8 +2683,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 
 	hub_settings = &hw->settings->shub_settings;
 	if (hub_settings->master_en.addr &&
-	    (!dev_fwnode(dev) ||
-	     !device_property_read_bool(dev, "st,disable-sensor-hub"))) {
+	    !device_property_read_bool(dev, "st,disable-sensor-hub")) {
 		err = st_lsm6dsx_shub_probe(hw, name);
 		if (err < 0)
 			return err;
@@ -2735,7 +2724,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	if ((dev_fwnode(dev) && device_property_read_bool(dev, "wakeup-source")) ||
+	if (device_property_read_bool(dev, "wakeup-source") ||
 	    (pdata && pdata->wakeup_source))
 		device_init_wakeup(dev, true);
 
-- 
2.46.0


