Return-Path: <linux-iio+bounces-5995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223B90011A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57892B23D8A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065C15DBCA;
	Fri,  7 Jun 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsL13wL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5815D5C4;
	Fri,  7 Jun 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756853; cv=none; b=P/BfR6xs7dqxXAj/RnGmlFbnLv9LcgEzvrNDg0rdusyWkVcgnSSvNYLbr3835jE6f3mOb8Z9tF6XrFsRtBNtpgQ4MjaRUC06hNilo2qDoiib3NkxR5pZvU9/kkI4cFjF8NztEUfWHRHZNTLAyWnvxqT7JbohHNreBJL1EZcAsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756853; c=relaxed/simple;
	bh=UynYF8JW/N9DYyJC+f4j3JHrpHyBb40KUm2kws6VKh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddonD1kYKqRl5CjhNgcMRppIp3kW1MA4jVEkl0It9ZFpb2wX/kt5X4nTpjUGt41odnCGbObWi8/zij4Sc0oKaCIhVn3/DMCLZQH4LGFEi833Z+zzFeAAeMghKpbYUsF0Q9vdGsLOHlLv2fo15s790skwMIeUwfgpuK3TMGVBMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLsL13wL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so1986578f8f.0;
        Fri, 07 Jun 2024 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756850; x=1718361650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz+LCmEdD3MpY9rq5ZseyIHOMygig8X78a8YfUFrEaM=;
        b=YLsL13wLv5d31hrh3JkWo2MEqXaoGr8v4Z/OzgRACeGqkZwxR9wlv+rCoroFFJqt/K
         ipAR0zSm4K8BIe0ZsoCiydr+qn6wXqWXNiIbHhpLGfEPzx8EYKo57/2S/QkS8uJpZWza
         M9SFqsKaqEB5N8SrieRfc+tLa6YLzrXcdQWgu2kY1fWok22Hk38xDenlko9GadUAAwGq
         gHKmbzLDs+2rcAoqttTUyMzuBzxpaaxIc7bu9QHLOUZWdvLVXnjhCJQCGD8imogqozgD
         bUQ5s5i9U4dc8tI4Rb/1SbSZku+pHlWAVurONRnNUxkUQfUZDOLQEvaW4x7+WKhajKhR
         RyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756850; x=1718361650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz+LCmEdD3MpY9rq5ZseyIHOMygig8X78a8YfUFrEaM=;
        b=wq7FPbET/ImaidHclVbW9JIaJ308TbjZzPurmMv3z6RtlD2UKxtt05qgpKQHstThOw
         hr6QFIeT7KjWFlsoeT2Z48smdawhcHdTOJFhfkQI2DlvSZog1LeYtRxiLkqWEbRx0TnC
         wmavpb03BmDhlerbVHkh+VUES8WooU5uVcbrx8CJrG2wllT5X8WNuRy4QG+ENeLhemBn
         i3AVImhEEEnmBT+BGVWf3x+SVAj2b73n4PUqfG8vslY9pqC0Adorrgex48+9OKHHhEUZ
         aPGlzgYvFh7JyxdHlpGQYzwDznxTpVZF7+nUogSEToVOPQJp/V0LYuvI07Fd6y5r8+YT
         S6JA==
X-Forwarded-Encrypted: i=1; AJvYcCVrmh/ZgSSG7fwVhw6rlNBTvrnyowYVvEwa8bAvkVKMjSU1rke+dr2ODhyqgrAP5lQc07422uRpeF70oTeOTWSs7dLt7s54ZoQz
X-Gm-Message-State: AOJu0YzYrQbpeKceUf6Xiy827M+aJoQDtl22JxApusAIodsIVrIGdEG+
	Pek1FfALaZw06/yfANP6kxFAgGgwhcMIqBFFWd7z65zXERZzLQ/p
X-Google-Smtp-Source: AGHT+IFWrSsV98lABxtAWuYUuhaUhOEgnia9rghGWKGQ3beuppFQ0JQ+p1ULcJ5bOdLbp2II/lu7CQ==
X-Received: by 2002:a05:6000:45:b0:35e:7d21:cad2 with SMTP id ffacd0b85a97d-35efed5a649mr1974916f8f.30.1717756849835;
        Fri, 07 Jun 2024 03:40:49 -0700 (PDT)
Received: from localhost.localdomain ([78.210.52.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d297a4sm3731717f8f.9.2024.06.07.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:40:49 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
X-Google-Original-From: Antoni Pokusinski <apokusinski@o2.pl>
To: jic23@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	apokusinski@o2.pl
Subject: [PATCH v2] iio: humidity: si7020: add heater support
Date: Fri,  7 Jun 2024 12:39:45 +0200
Message-Id: <20240607103944.11730-1-apokusinski@o2.pl>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the integrated on-chip heater that is present
on all the devices supported by this driver (si7020, si7021, si7013, th6).
In order to configure the heater, the driver interacts with the following
device registers:
* User Register - the 2nd bit of this register is a "Heater Enable bit"
  (0 means that the heater is off, 1 means that it's on).
* Heater Register - this register is present only on the si70xx devices
  and controls the current flowing through the heater. The 4 lower bits
  of this register can be assigned values from 0x0 to 0xF.

Signed-off-by: Antoni Pokusinski <apokusinski@o2.pl>

--
Changes since v1:
* macros: remove unnecessary comments
* macros: add more meaningful names
* `struct si7020_data`: add comment explaining the mutex
* `si7020_update_reg()`: change the control flow to more standard
* use `scoped_guard()` instead of `mutex_lock() <...> mutex_unlock()`
* `si7020_probe()`: add comment for User Register default value
* minor format fixes

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


