Return-Path: <linux-iio+bounces-11229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A19AF26F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD161F263A6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E1224B58;
	Thu, 24 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZWfDlff"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240121C178;
	Thu, 24 Oct 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797138; cv=none; b=a4OFYGZd9H9vBfyz777vI67+2ibhOOCWNBpPwLhNLdSA8W8kugXCmIr9yxoCD5WqBzd65UJyE21bLvCAreB5UV5dBcF3vlyO5CWIAl7X4cL3R+FCTeizFzNM/knFG+XfdRoGwGtOysp6y9ptU3IXW2U0ALg+uFKlyHe/oOAx1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797138; c=relaxed/simple;
	bh=uT+ZwqlgTNNgVTqgPAMtmbOzjSABGu/ZcvrSOTZ429c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQmozEJ7CvmJ1au3oHeNp3QvWGar2guMWbHwk3FLcZZowg0Mo8f3eCkj0HfWiHunG0emg3gOcdamaY4GsmYPtdBrGxlPllxWdCoBVghQGm/wh8/eIfxs2SfINIPB3HvqkuVVuhID5l1fUCjfC3ttDMUmEG0kH1xbRG3zCjXJGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZWfDlff; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797135; x=1761333135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uT+ZwqlgTNNgVTqgPAMtmbOzjSABGu/ZcvrSOTZ429c=;
  b=DZWfDlffMpoFwpkbXngBd1wbR/CZwxiMtVgNCZk9tqcqdcmlnT9NG9E9
   mvnyYI2CTh8Jl+3WfijL5GTdSwyNg1WU80Wftw+4EebU8JKjeAZx9I9O6
   GmCXtE5E/nc2tHS4ENDJdqTBv9AA07STvSRDF/bnPV7VEZhjkr04XF9CK
   TJnVWHDCPIhFogDV7BXljmPseX4uX6zQKgzUxF9YgpD6NpMUZmbOxd2xI
   Zm8KISdC/vWZyISf6Asn+u1rtLVxmeCnTuFHUE6jiN2MrG8UBJ38bVuH7
   68uRxrR+LO0lR+cULrm90YTpe79ocpFW6H3ZklnEf3fSAsi8pu/YrpWrP
   A==;
X-CSE-ConnectionGUID: Wa+vcPmvSUG1SyV9pTra/A==
X-CSE-MsgGUID: mDKDWHq8T4CCeVZkFEOA4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934474"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934474"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: QsIQKEV2R7WqzuQSQRXJaw==
X-CSE-MsgGUID: R+zOKOmWT9WBWY8p5qpJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266685"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B01B6A7; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 11/24] iio: accel: kxcjk-1013: Start using chip_info variables instead of enum
Date: Thu, 24 Oct 2024 22:05:00 +0300
Message-ID: <20241024191200.229894-12-andriy.shevchenko@linux.intel.com>
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

Instead of having a enum and keeping IDs as driver data pointers,
just have a chip_info struct per supported device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 171 +++++++++++++++++++--------------
 1 file changed, 99 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index f97bdbbe71ed..37c82fdf7c43 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -234,6 +234,55 @@ static const struct kx_chipset_regs kx0231025_regs = {
 	.wake_thres	= KX023_REG_ATH,
 };
 
+struct kx_chipset_info {
+	const struct kx_chipset_regs *regs;
+	enum kx_chipset chipset;
+	enum kx_acpi_type acpi_type;
+};
+
+static const struct kx_chipset_info kxcjk1013_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXCJK1013,
+};
+
+static const struct kx_chipset_info kxcj91008_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXCJ91008,
+};
+
+static const struct kx_chipset_info kxcj91008_kiox010a_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXCJ91008,
+	.acpi_type = ACPI_KIOX010A,
+};
+
+static const struct kx_chipset_info kxcj91008_kiox020a_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXCJ91008,
+	.acpi_type = ACPI_GENERIC,
+};
+
+static const struct kx_chipset_info kxcj91008_smo8500_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXCJ91008,
+	.acpi_type = ACPI_SMO8500,
+};
+
+static const struct kx_chipset_info kxtj21009_info = {
+	.regs = &kxcjk1013_regs,
+	.chipset = KXTJ21009,
+};
+
+static const struct kx_chipset_info kxtf9_info = {
+	.regs = &kxtf9_regs,
+	.chipset = KXTF9,
+};
+
+static const struct kx_chipset_info kx0231025_info = {
+	.regs = &kx0231025_regs,
+	.chipset = KX0231025,
+};
+
 enum kxcjk1013_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -261,9 +310,7 @@ struct kxcjk1013_data {
 	int ev_enable_state;
 	bool motion_trigger_on;
 	int64_t timestamp;
-	enum kx_chipset chipset;
-	enum kx_acpi_type acpi_type;
-	const struct kx_chipset_regs *regs;
+	const struct kx_chipset_info *info;
 };
 
 enum kxcjk1013_mode {
@@ -425,27 +472,28 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
 }
 
 static const struct acpi_device_id kx_acpi_match[] = {
-	{"KXCJ1013", KXCJK1013},
-	{"KXCJ1008", KXCJ91008},
-	{"KXCJ9000", KXCJ91008},
-	{"KIOX0008", KXCJ91008},
-	{"KIOX0009", KXTJ21009},
-	{"KIOX000A", KXCJ91008},
-	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
-	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
-	{"KXTJ1009", KXTJ21009},
-	{"KXJ2109",  KXTJ21009},
-	{"SMO8500",  KXCJ91008},
+	{"KIOX0008", (kernel_ulong_t)&kxcj91008_info },
+	{"KIOX0009", (kernel_ulong_t)&kxtj21009_info },
+	{"KIOX000A", (kernel_ulong_t)&kxcj91008_info },
+	/* KXCJ91008 in the display of a yoga 2-in-1 */
+	{"KIOX010A", (kernel_ulong_t)&kxcj91008_kiox010a_info },
+	/* KXCJ91008 in the base of a yoga 2-in-1 */
+	{"KIOX020A", (kernel_ulong_t)&kxcj91008_kiox020a_info },
+	{"KXCJ1008", (kernel_ulong_t)&kxcj91008_info },
+	{"KXCJ1013", (kernel_ulong_t)&kxcjk1013_info },
+	{"KXCJ9000", (kernel_ulong_t)&kxcj91008_info },
+	{"KXJ2109",  (kernel_ulong_t)&kxtj21009_info },
+	{"KXTJ1009", (kernel_ulong_t)&kxtj21009_info },
+	{"SMO8500",  (kernel_ulong_t)&kxcj91008_smo8500_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
-
 #endif
 
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
@@ -471,7 +519,7 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode *mode)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
@@ -490,7 +538,7 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 
 static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, regs->ctrl1);
@@ -517,11 +565,11 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 
 static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 #ifdef CONFIG_ACPI
-	if (data->acpi_type == ACPI_KIOX010A) {
+	if (data->info->acpi_type == ACPI_KIOX010A) {
 		/* Make sure the kbd and touchpad on 2-in-1s using 2 KXCJ91008-s work */
 		kiox010a_dsm(&data->client->dev, KIOX010A_SET_LAPTOP_MODE);
 	}
@@ -586,7 +634,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	}
 
 	/* On KX023, route all used interrupts to INT1 for now */
-	if (data->chipset == KX0231025 && data->client->irq > 0) {
+	if (data->info->chipset == KX0231025 && data->client->irq > 0) {
 		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
 						KX023_REG_INC4_DRDY1 |
 						KX023_REG_INC4_WUFI1);
@@ -607,8 +655,8 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 
 static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 {
+	int idx = data->info->chipset;
 	int i;
-	int idx = data->chipset;
 
 	for (i = 0; i < ARRAY_SIZE(odr_start_up_times[idx]); ++i) {
 		if (odr_start_up_times[idx][i].odr_bits == data->odr_bits)
@@ -641,7 +689,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, regs->wake_timer, data->wake_dur);
@@ -663,7 +711,7 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 						bool status)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 
@@ -726,7 +774,7 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 					      bool status)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 
@@ -814,7 +862,7 @@ static int kxcjk1013_convert_odr_value(const struct kx_odr_map *map,
 
 static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 {
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 	enum kxcjk1013_mode store_mode;
 	const struct kx_odr_map *odr_setting;
@@ -823,7 +871,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	if (ret < 0)
 		return ret;
 
-	if (data->chipset == KXTF9)
+	if (data->info->chipset == KXTF9)
 		odr_setting = kxcjk1013_find_odr_value(kxtf9_samp_freq_table,
 						       ARRAY_SIZE(kxtf9_samp_freq_table),
 						       val, val2);
@@ -867,7 +915,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
 {
-	if (data->chipset == KXTF9)
+	if (data->info->chipset == KXTF9)
 		return kxcjk1013_convert_odr_value(kxtf9_samp_freq_table,
 						   ARRAY_SIZE(kxtf9_samp_freq_table),
 						   data->odr_bits, val, val2);
@@ -1134,7 +1182,7 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	const char *str;
 
-	if (data->chipset == KXTF9)
+	if (data->info->chipset == KXTF9)
 		str = kxtf9_samp_freq_avail;
 	else
 		str = kxcjk1013_samp_freq_avail;
@@ -1251,7 +1299,7 @@ static void kxcjk1013_trig_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, regs->int_rel);
@@ -1306,7 +1354,7 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
 static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 
 	int ret = i2c_smbus_read_byte_data(data->client, regs->int_src2);
 	if (ret < 0) {
@@ -1373,7 +1421,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
-	const struct kx_chipset_regs *regs = data->regs;
+	const struct kx_chipset_regs *regs = data->info->regs;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, regs->int_src1);
@@ -1383,7 +1431,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	}
 
 	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
-		if (data->chipset == KXTF9)
+		if (data->info->chipset == KXTF9)
 			iio_push_event(indio_dev,
 				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 				       0,
@@ -1425,8 +1473,7 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 }
 
 static const char *kxcjk1013_match_acpi_device(struct device *dev,
-					       enum kx_chipset *chipset,
-					       enum kx_acpi_type *acpi_type,
+					       const struct kx_chipset_info **info,
 					       const char **label)
 {
 	const struct acpi_device_id *id;
@@ -1435,16 +1482,12 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	if (!id)
 		return NULL;
 
-	if (strcmp(id->id, "SMO8500") == 0) {
-		*acpi_type = ACPI_SMO8500;
-	} else if (strcmp(id->id, "KIOX010A") == 0) {
-		*acpi_type = ACPI_KIOX010A;
+	if (strcmp(id->id, "KIOX010A") == 0)
 		*label = "accel-display";
-	} else if (strcmp(id->id, "KIOX020A") == 0) {
+	else if (strcmp(id->id, "KIOX020A") == 0)
 		*label = "accel-base";
-	}
 
-	*chipset = (enum kx_chipset)id->driver_data;
+	*info = (const struct kx_chipset_info *)id->driver_data;
 
 	return dev_name(dev);
 }
@@ -1496,31 +1539,16 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	msleep(20);
 
 	if (id) {
-		data->chipset = (enum kx_chipset)(id->driver_data);
 		name = id->name;
+		data->info = (const struct kx_chipset_info *)(id->driver_data);
 	} else if (ACPI_HANDLE(&client->dev)) {
-		name = kxcjk1013_match_acpi_device(&client->dev,
-						   &data->chipset,
-						   &data->acpi_type,
+		name = kxcjk1013_match_acpi_device(&client->dev, &data->info,
 						   &indio_dev->label);
 	} else
 		return -ENODEV;
 
-	switch (data->chipset) {
-	case KXCJK1013:
-	case KXCJ91008:
-	case KXTJ21009:
-		data->regs = &kxcjk1013_regs;
-		break;
-	case KXTF9:
-		data->regs = &kxtf9_regs;
-		break;
-	case KX0231025:
-		data->regs = &kx0231025_regs;
-		break;
-	default:
+	if (!data->info)
 		return -EINVAL;
-	}
 
 	ret = kxcjk1013_chip_init(data);
 	if (ret < 0)
@@ -1535,7 +1563,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_iio_info;
 
-	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
+	if (client->irq > 0 && data->info->acpi_type != ACPI_SMO8500) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
@@ -1711,22 +1739,21 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
 };
 
 static const struct i2c_device_id kxcjk1013_id[] = {
-	{"kxcjk1013", KXCJK1013},
-	{"kxcj91008", KXCJ91008},
-	{"kxtj21009", KXTJ21009},
-	{"kxtf9",     KXTF9},
-	{"kx023-1025", KX0231025},
+	{"kxcjk1013",  (kernel_ulong_t)&kxcjk1013_info },
+	{"kxcj91008",  (kernel_ulong_t)&kxcj91008_info },
+	{"kxtj21009",  (kernel_ulong_t)&kxtj21009_info },
+	{"kxtf9", (kernel_ulong_t)&kxtf9_info },
+	{"kx023-1025", (kernel_ulong_t)&kx0231025_info },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
 
 static const struct of_device_id kxcjk1013_of_match[] = {
-	{ .compatible = "kionix,kxcjk1013", },
-	{ .compatible = "kionix,kxcj91008", },
-	{ .compatible = "kionix,kxtj21009", },
-	{ .compatible = "kionix,kxtf9", },
-	{ .compatible = "kionix,kx023-1025", },
+	{ .compatible = "kionix,kxcjk1013", &kxcjk1013_info },
+	{ .compatible = "kionix,kxcj91008", &kxcj91008_info },
+	{ .compatible = "kionix,kxtj21009", &kxtj21009_info },
+	{ .compatible = "kionix,kxtf9", &kxtf9_info },
+	{ .compatible = "kionix,kx023-1025", &kx0231025_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


