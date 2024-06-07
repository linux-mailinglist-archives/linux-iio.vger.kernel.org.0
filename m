Return-Path: <linux-iio+bounces-6003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9929005F0
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7091F28527
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0234219750B;
	Fri,  7 Jun 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJzt233D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FC196DA2;
	Fri,  7 Jun 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769481; cv=none; b=TtV+xELJ2aZmR/bGzubzkz6XBePKoylqXDTxeSnJKvaIUut8KxQ9kVFB9AWgDTN1Fnwxk3DjHCd9/EWZc5a+MGTEX553d27Lh+qE9LgeLkaMeeFdmbajDna08hZUzw4aONC1FW66T8K326BQ/rdN9t0MU1WQA1Q/jsYQtED8OEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769481; c=relaxed/simple;
	bh=szdgMiMulz0n7NhHc4otBa6OaNYZ7UkfqeGqWUn4MR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpRNrrpbXE8Rne9pyriQ0sr15ZvBwzRIqHEn07AKQ6G/Wbidm/4cbALKMsLn0cxMXExFtJ5qzp792qIjXNZsOXaFPw3cig3LAK75shdwcqvLCb7ERUcnlnpgC6U621eziHigepBpfuYcFkqn33dwiqGtXQpPfp6u/qxnzGcRLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJzt233D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso220497866b.0;
        Fri, 07 Jun 2024 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769478; x=1718374278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4qPAE/NAva4MlMgTADVa4TN/vwiz57HEIx2SnwISIM=;
        b=aJzt233DYeUpww+qDNEIp8aDGqI5/Xy0+gJBq6vhkmcDIsR3bRpGCK1ZqWVRS9QYvq
         cZiL61N4ZnDD3ZyEPoe+YplK+luL+Xp/Hm9m18+Y9Vfw/YkD41kzdsEmq2WBfwUm//5x
         EtzjM4six2tGmfIkTBBSlRTW0oSII3j1j+eIsLMBxS7Ig9v6KF+v0oHMDZL0nCjwNb/L
         uK4rnurmaxfyl52z+Z3a1VmU21Bsr8ZKklltNKGBPriKGK9cZH0fcC4sn5asC3ZDSwjg
         xtKUOzGTP5ZEbN2FtpBDpITzh/rJxi9Su5ZayKQrMfLhwteMXDmw4CM8sEBwYPT/i0e3
         RZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769478; x=1718374278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4qPAE/NAva4MlMgTADVa4TN/vwiz57HEIx2SnwISIM=;
        b=ZxRo0/HdFlmxS6bB5c+xks322WhtOKah3O+AJel6TW3QXNJjiJC7ZHZjnW4bhBJL6q
         Qk24B8GBkX+JBoHLv27kPldZ7wu+dHIUD3rg5890+/Q6L4NYGZz7fdaJkX4k6Hw3ZdID
         9X9BH30pOXy1uCGBao3S3uUW+h/R9djOpyHnBdAio3hH2jX51tEfVnS+UNqOCx0EoQ8T
         pn37hl/FPUaZEiadyrmaXy1gfVO9xHZgvyEdTPpwti00fDIRQHJ6WXKyYBqR/D9rIIvo
         zyx0yuvNhF15pOnJTnoTq0BsZ1yO2eLD17nFWPlFhN8svi0E9sHAzcj2l56fb1GQ56dz
         GKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66Jfkt/TN/LMSm6VTa23/+GapGZTyCBHyLHbjFbSTrxwr3PqIN+9CUnT0AcTS1xCB1eByISsAyvnCcAVvTHJ2KnWV6BsvVtp0
X-Gm-Message-State: AOJu0YwkLAXFf8B0FxaJnegwY9T5beBZzEDIgbC80keXEYiB/7NLZQiR
	HwpzulQny5OZ3Uf70e3C8YM4753iwTJoKbiNrToJLGvXeSRgEKG6Mw6jIRDPQRj6Xg==
X-Google-Smtp-Source: AGHT+IFFCZO7+lQ7DdYbkfKAPFKXuF4xdeOIZCzRa6UAYIpw5Q8I+YgxXCtcNCY9Hh1WIocxR6foMw==
X-Received: by 2002:a17:906:bc86:b0:a63:7e9e:6271 with SMTP id a640c23a62f3a-a6cd6289e91mr168516466b.22.1717769478105;
        Fri, 07 Jun 2024 07:11:18 -0700 (PDT)
Received: from localhost.localdomain ([78.210.52.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80729747sm250769066b.205.2024.06.07.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:11:17 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
X-Google-Original-From: Antoni Pokusinski <apokusinski@o2.pl>
To: jic23@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	apokusinski@o2.pl,
	apokusinski01@gmail.com
Subject: Re: [PATCH v2] iio: humidity: si7020: add heater support
Date: Fri,  7 Jun 2024 16:10:30 +0200
Message-Id: <20240607141029.51744-1-apokusinski@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607103944.11730-1-apokusinski@o2.pl>
References: <20240607103944.11730-1-apokusinski@o2.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antoni Pokusinski <apokusinski01@gmail.com>

This patch adds support for the integrated on-chip heater that is present
on all the devices supported by this driver (si7020, si7021, si7013, th6).
In order to configure the heater, the driver interacts with the following
device registers:
* User Register - the 2nd bit of this register is a "Heater Enable bit"
  (0 means that the heater is off, 1 means that it's on).
* Heater Register - this register is present only on the si70xx devices
  and controls the current flowing through the heater. The 4 lower bits
  of this register can be assigned values from 0x0 to 0xF.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

--
Changes since v1:
* macros: remove unnecessary comments
* macros: add more meaningful names
* `struct si7020_data`: add comment explaining the mutex
* `si7020_update_reg()`: change the control flow to more standard
* use `scoped_guard()` instead of `mutex_lock() <...> mutex_unlock()`
* `si7020_probe()`: add comment for User Register default value
* minor format fixes
--
Hello, after sending this email I noticed an accidental email mismatch
between "From:" and the "Signed-off-by:" therefore I send this email
once again with a corrected signature. Sorry for the confusion.
---
 drivers/iio/humidity/si7020.c | 137 +++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fb1006649328..1215fab7b1a5 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -23,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/stat.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -33,17 +34,38 @@
 #define SI7020CMD_TEMP_HOLD	0xE3
 /* Software Reset */
 #define SI7020CMD_RESET		0xFE
+#define SI7020CMD_USR_WRITE	0xE6
+/* "Heater Enabled" bit in the User Register */
+#define SI7020_USR_HEATER_EN	BIT(2)
+#define SI7020CMD_HEATER_WRITE	0x51
+/* Heater current configuration bits */
+#define SI7020_HEATER_VAL	GENMASK(3, 0)
+
+struct si7020_data {
+	struct i2c_client *client;
+	/* Lock for cached register values */
+	struct mutex lock;
+	u8 user_reg;
+	u8 heater_reg;
+};
+
+static const int si7020_heater_vals[] = { 0, 1, 0xF };
 
 static int si7020_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	struct i2c_client **client = iio_priv(indio_dev);
+	struct si7020_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_smbus_read_word_swapped(*client,
+		if (chan->type == IIO_CURRENT) {
+			*val = data->heater_reg;
+			return IIO_VAL_INT;
+		}
+
+		ret = i2c_smbus_read_word_swapped(data->client,
 						  chan->type == IIO_TEMP ?
 						  SI7020CMD_TEMP_HOLD :
 						  SI7020CMD_RH_HOLD);
@@ -96,17 +118,118 @@ static const struct iio_chan_spec si7020_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "heater",
+	}
+};
+
+static int si7020_update_reg(struct si7020_data *data,
+				u8 *reg, u8 cmd, u8 mask, u8 val)
+{
+	u8 new = (*reg & ~mask) | val;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, cmd, new);
+	if (ret)
+		return ret;
+
+	*reg = new;
+
+	return 0;
+}
+
+static int si7020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct si7020_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0 ||
+			val < si7020_heater_vals[0] || val > si7020_heater_vals[2])
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->lock)
+			ret = si7020_update_reg(data, &data->heater_reg,
+					SI7020CMD_HEATER_WRITE, SI7020_HEATER_VAL, val);
+		return ret;
+	default:
+		return -EINVAL;
 	}
+}
+
+static int si7020_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals,
+				  int *type, int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
+		return -EINVAL;
+
+	*vals = si7020_heater_vals;
+	*type = IIO_VAL_INT;
+
+	return IIO_AVAIL_RANGE;
+}
+
+static ssize_t si7020_show_heater_en(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si7020_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", !!(data->user_reg & SI7020_USR_HEATER_EN));
+}
+
+static ssize_t si7020_store_heater_en(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si7020_data *data = iio_priv(indio_dev);
+	int ret;
+	bool val;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &data->lock)
+		ret = si7020_update_reg(data, &data->user_reg, SI7020CMD_USR_WRITE,
+				SI7020_USR_HEATER_EN, val ? SI7020_USR_HEATER_EN : 0);
+
+	return ret < 0 ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(heater_enable, 0644,
+		       si7020_show_heater_en, si7020_store_heater_en, 0);
+
+static struct attribute *si7020_attributes[] = {
+	&iio_dev_attr_heater_enable.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group si7020_attribute_group = {
+	.attrs = si7020_attributes,
 };
 
 static const struct iio_info si7020_info = {
 	.read_raw = si7020_read_raw,
+	.write_raw = si7020_write_raw,
+	.read_avail = si7020_read_available,
+	.attrs = &si7020_attribute_group,
 };
 
 static int si7020_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
-	struct i2c_client **data;
+	struct si7020_data *data;
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -126,7 +249,9 @@ static int si7020_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	*data = client;
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -134,6 +259,10 @@ static int si7020_probe(struct i2c_client *client)
 	indio_dev->channels = si7020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
 
+	/* All the "reserved" bits in the User Register are 1s by default */
+	data->user_reg = 0x3A;
+	data->heater_reg = 0x0;
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.25.1


