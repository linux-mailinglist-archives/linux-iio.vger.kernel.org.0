Return-Path: <linux-iio+bounces-11221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980C9AF25D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B1E289468
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AE21B45E;
	Thu, 24 Oct 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3w4qmfP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF7219C8D;
	Thu, 24 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797133; cv=none; b=NQM4miCPMAQrJKWv0wTt8zp3vhdlBKXiCqnhZEdQDWP73JC4/OyXW1ZjNrDTS23T7tnC9klXTchv6L2RkliC2HDiGH6CuXLFQhsJPtfw05vS1Len7NtM84kIZoHTsixee/NWI7EtftftdsYlRrC0mrjxPcWNNBEWrX8xrIo/SSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797133; c=relaxed/simple;
	bh=nnUYxTU6Qk+voFfM495gKZUOSvntg7CaVSFrf4/2QkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+DbWTswN+IdtaEvF/+HbDH14k8UMbVdBvQShOgKEqJH7IpIsCaOy0pyWTtpQPFlvibBC6IwuUF6KoP6VC0Y0l3H0n8RyrzwfsmGbYL88i3WU48d0nwVyEOUjmaPbb0ZYEi/1FAbRBlHa4IW3ZYDFRw9ZK/5kFmT76u/sy7RdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3w4qmfP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797131; x=1761333131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnUYxTU6Qk+voFfM495gKZUOSvntg7CaVSFrf4/2QkM=;
  b=K3w4qmfP1zfbFMm68o33Mf8H0ZT/Dq6g9TEg5FjSWPDT7xoBJ0vhQN3X
   kz4t2RVpsWoPxdosD5/Yo0Y6qd172kjZcVu3isCqFyTps+eT4wr4LcUiW
   a2rCTVNob7X4c/ZnjUHy6G7Yx8yRAPPtWTzo9RlKBTQ+97jFaGxfH54Ye
   132y8C7B/q0nOi4HOMmm0MR/UE7WPSRzTP+b6HOJE5tE2gFLug3FSgxCG
   2eKpx/2fkAO03HugRe+b/1UTh8VHou2Tak/NDxPopOtNarVidRQnzhN1u
   8gc6Rx2/Ha0sL6/mkX/PzbiBdk9je9wCkVY+eTEFKiYBSgsEnyrFeX8Y6
   g==;
X-CSE-ConnectionGUID: yeVKRQOBSXS6b/BJvVc9OQ==
X-CSE-MsgGUID: JeBr6j+zQjSmixOHYExayA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563185"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563185"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: H++YmrIrRrGSaL1UxHbZsQ==
X-CSE-MsgGUID: oYYXpd/RQuGMsOyWqcK6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 860F25B8; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 09/24] iio: accel: kxcjk-1013: Use local variable for regs
Date: Thu, 24 Oct 2024 22:04:58 +0300
Message-ID: <20241024191200.229894-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use local variable for regs in preparatory of further cleaning up changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 65 +++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 0cc34e17a23f..a5411d920025 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -445,9 +445,10 @@ MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -458,7 +459,7 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 	else
 		ret |= KXCJK1013_REG_CTRL1_BIT_PC1;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -470,9 +471,10 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode *mode)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -488,9 +490,10 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 
 static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -501,7 +504,7 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 	ret |= (KXCJK1013_scale_table[range_index].gsel_0 << 3);
 	ret |= (KXCJK1013_scale_table[range_index].gsel_1 << 4);
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -514,6 +517,7 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 
 static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
 #ifdef CONFIG_ACPI
@@ -535,7 +539,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -544,7 +548,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	/* Set 12 bit mode */
 	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
 		return ret;
@@ -555,7 +559,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->data_ctrl);
+	ret = i2c_smbus_read_byte_data(data->client, regs->data_ctrl);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
 		return ret;
@@ -564,7 +568,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	data->odr_bits = ret;
 
 	/* Set up INT polarity */
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -575,7 +579,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
@@ -637,18 +641,17 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->wake_timer,
-					data->wake_dur);
+	ret = i2c_smbus_write_byte_data(data->client, regs->wake_timer, data->wake_dur);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Error writing reg_wake_timer\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->wake_thres,
-					data->wake_thres);
+	ret = i2c_smbus_write_byte_data(data->client, regs->wake_thres, data->wake_thres);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_wake_thres\n");
 		return ret;
@@ -660,6 +663,7 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 						bool status)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 
@@ -676,7 +680,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -687,13 +691,13 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -704,7 +708,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -722,6 +726,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 					      bool status)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 
@@ -734,7 +739,7 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
@@ -745,13 +750,13 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->int_ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->int_ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->ctrl1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
@@ -762,7 +767,7 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	else
 		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->ctrl1, ret);
+	ret = i2c_smbus_write_byte_data(data->client, regs->ctrl1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -809,6 +814,7 @@ static int kxcjk1013_convert_odr_value(const struct kx_odr_map *map,
 
 static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 {
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 	const struct kx_odr_map *odr_setting;
@@ -834,7 +840,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->data_ctrl,
+	ret = i2c_smbus_write_byte_data(data->client, regs->data_ctrl,
 					odr_setting->odr_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing data_ctrl\n");
@@ -843,7 +849,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 	data->odr_bits = odr_setting->odr_bits;
 
-	ret = i2c_smbus_write_byte_data(data->client, data->regs->wuf_ctrl,
+	ret = i2c_smbus_write_byte_data(data->client, regs->wuf_ctrl,
 					odr_setting->wuf_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
@@ -1245,9 +1251,10 @@ static void kxcjk1013_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_rel);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_rel);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 }
@@ -1299,8 +1306,9 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
 static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	const struct kx_chipset_regs *regs = data->regs;
 
-	int ret = i2c_smbus_read_byte_data(data->client, data->regs->int_src2);
+	int ret = i2c_smbus_read_byte_data(data->client, regs->int_src2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src2\n");
 		return;
@@ -1365,9 +1373,10 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	const struct kx_chipset_regs *regs = data->regs;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_src1);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_src1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src1\n");
 		goto ack_intr;
@@ -1390,7 +1399,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	if (data->dready_trigger_on)
 		return IRQ_HANDLED;
 
-	ret = i2c_smbus_read_byte_data(data->client, data->regs->int_rel);
+	ret = i2c_smbus_read_byte_data(data->client, regs->int_rel);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


