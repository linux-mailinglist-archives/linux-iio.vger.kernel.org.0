Return-Path: <linux-iio+bounces-19258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10685AAEC36
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1675B188FC8E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5EE28C027;
	Wed,  7 May 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXl7aXHO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A428983F
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646363; cv=none; b=kc/kjMq2tN67HpNg37WkMTXp5Fle6l6ipdmv83ATkQ1GUabi7t6QvdKHOMHIdu/QfHBWwKtBEILrF3vJwMWfzeaPdaW9r6Xsp/4BxzoGbI6Utvdmyo71xltETWPYzCSr7eET6zuicfwSMaGnF4/zQfZ3VL0n85b473V6zooO2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646363; c=relaxed/simple;
	bh=WvRi7N/dcZ4WJj35ckwKWfH+srtOPc/rVSVp8fm9vOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3k7DoNK3ZebQ08ieWy2T89HIbJkcxIPa3635NCm/XqpcVrPVwaoFRIwLlag9LqDg81rV4yjKXrrY0yucgjaOQmKBS+Egs3wnR8f7tAY7q646pvvqIAUqrgusNadXjW4MFL0oNCiokvhFIbG1tgzkNqf9Nc991RGLIngibVFfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXl7aXHO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e661313a3so3238735ad.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646360; x=1747251160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJsH2XpfVp/Jybsufp6LwsEWmXWem9bMfVLaG4iJFZ8=;
        b=GXl7aXHOUnX+HCsyheoePNTlCDl6pwZaKV3NEYPOtJQcWLzFI3Emsn17mxMs6Xje2o
         62fzOZZYnGiRWfsKq5YlVVWamGMDkVqJgUIZFV7YtgxJQ0qEX5A/arj7MUwywD3l+s4V
         Jdnyo0iU9lGDWVK+k99XrY+wH+4jCwKmTuupW2q2LZG3g49gF3SbcSkmODDiT82/Sgza
         guQotV89QfKeqRat8X3BDQMoJcqPkSJMa8kqsVRlltI84PyIlETVqqlpwXWeaIG4XxRw
         dhWKI3rBPanE6BeUxmdxQD68kC708RusWUSwYg9s2r8iBzi0iT3d5mDoUhuZibYJJ3u0
         JL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646360; x=1747251160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJsH2XpfVp/Jybsufp6LwsEWmXWem9bMfVLaG4iJFZ8=;
        b=dFVl5XKjtM552uyXauxkGRQZtZHUfdJaR/unkhaC98WufB/OU1JZZ6A4GP2s9PQAWJ
         rXQNYjQNWWCkS9AQNzJ4aXr51oclYLWVHr+f8f/wJlvwsxSpzGDl7bkKx3Q5hPm0mtwH
         Uk68XkXnMuAKFm7tt4JHXGYzAlR1RyaF8b69uYT9JuyJHaJQlur0yyxG7WhtD/hvZbUf
         mt2m2p0UYlm5oue8YG8TNRIuxapf0V5hcHGuQGSEIHhyI5h9Z5K2JmINwnM7EYS9UVHN
         F6uNOz3NIvi2Rutwv0kedFMEFAuQTlfapZkzF56ZakE+mkuy0szGfQNQyx6iB8HaGfif
         c35w==
X-Gm-Message-State: AOJu0YyzTXM9jERXdbYhhaz+ETHQ/k5PBNRxPFhZClhDAHollPaub4Ew
	sRzI6jNnDrZhUUyX05y5c5dZkVEvvqQl/QBpKBOC5cVbn9scqtgf+vrL+fGmi8c=
X-Gm-Gg: ASbGncublWJ6sdJTOMYLlKAU6tCSLxDymUAkugUzX9hGbvQZnWxq4rvWwiDgwv9YB/5
	X69coChCZT6oRr9GCzT1jZ0lN8wklpQy3eP78B83BWICY8V10qIed61v1L/25hsf7gtGAU4prh/
	WQpa8yHGHYtWu7Bkvt0TbZBcy3GHbVVBD87ccK3XnFTNNq+4JaGK5sXh5Yj8Nl3o8DvQ+rPL5xl
	nrcxouGE0YnxZhalhWhKoG60im5mH/h6Z3y/a3xLXhtKcRk1vjwyHzSwMRlbYcadl5m7tR3qnLo
	UIOAscfSqeMN1JDWX6fUtz8SSBr58cPoTVvG8j62Qfwvh8Bu33Uhr/2U9cwn
X-Google-Smtp-Source: AGHT+IGVSDDxeomcRpGZH7bdvUjc3c8e0TVUjuKBc9GKt2aPX3pVKxnx/AA6Xl5hB6ruOM4FtLbFiA==
X-Received: by 2002:a17:902:e748:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22e5ea7d822mr60107585ad.26.1746646360230;
        Wed, 07 May 2025 12:32:40 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f62sm97769815ad.168.2025.05.07.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:32:39 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v1 3/3] iio: magnetometer: qmc5883l: add mount matrix, control features and power management
Date: Wed,  7 May 2025 20:32:19 +0100
Message-Id: <20250507193219.52965-4-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507193219.52965-1-brajeshpatil11@gmail.com>
References: <20250507193219.52965-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 drivers/iio/magnetometer/qmc5883l.c | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
index 53a225fab798..66a2300e7add 100644
--- a/drivers/iio/magnetometer/qmc5883l.c
+++ b/drivers/iio/magnetometer/qmc5883l.c
@@ -7,6 +7,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
@@ -53,6 +54,12 @@
 #define QMC5883L_OSR_64             0x03
 #define QMC5883L_OSR_MASK           0xC0
 #define QMC5883L_OSR_SHIFT          6
+
+/* Control Register 2 Configuration Bits */
+#define QMC5883L_SOFT_RST           0x80
+#define QMC5883L_ROL_PNT            0x40
+#define QMC5883L_INT_ENB            0x01
+
 static const char *const qmc5883l_modes[] = {
 	"standby", "continuous"
 };
@@ -85,6 +92,7 @@ struct qmc5883l_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct regmap *regmap;
+	struct iio_mount_matrix orientation;
 
 	struct {
 		__le16 chans[3];
@@ -101,6 +109,9 @@ static ssize_t qmc5883l_show_scale_avail(struct device *dev,
 					 struct device_attribute *attr, char *buf);
 static ssize_t qmc5883l_show_status(struct device *dev,
 				    struct device_attribute *attr, char *buf);
+static ssize_t qmc5883l_store_control(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count);
 
 static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
 {
@@ -356,6 +367,15 @@ static int qmc5883l_read_measurement(struct qmc5883l_data *data,
 	return IIO_VAL_INT;
 }
 
+static const struct iio_mount_matrix *
+qmc5883l_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static const struct iio_enum qmc5883l_mode_enum = {
 	.items = qmc5883l_modes,
 	.num_items = ARRAY_SIZE(qmc5883l_modes),
@@ -375,6 +395,7 @@ static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
 	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
 	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
 	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qmc5883l_get_mount_matrix),
 	{ }
 };
 
@@ -382,6 +403,8 @@ static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
 static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
 static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
 static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);
+static IIO_DEVICE_ATTR(soft_reset, 0200, NULL, qmc5883l_store_control, 0);
+static IIO_DEVICE_ATTR(pointer_rollover, 0200, NULL, qmc5883l_store_control, 0);
 
 static ssize_t qmc5883l_show_odr_avail(struct device *dev,
 				       struct device_attribute *attr, char *buf)
@@ -415,6 +438,44 @@ static ssize_t qmc5883l_show_status(struct device *dev,
 	return -EINVAL;
 }
 
+/* Control attribute writes:
+ * - soft_reset: performs device reset and re-init
+ * - pointer_rollover: enables/disables rollover pointer
+ */
+static ssize_t qmc5883l_store_control(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+	bool val;
+	int ret = 0;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (attr == &iio_dev_attr_soft_reset.dev_attr && val) {
+		mutex_lock(&data->lock);
+		ret = regmap_write(data->regmap, QMC5883L_CONTROL_REG_2,
+				   QMC5883L_SOFT_RST);
+		mutex_unlock(&data->lock);
+		msleep(50);
+
+		ret = qmc5883l_init(data);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Sensor Reinitialization Failed\n");
+			return ret;
+		}
+		dev_info(&data->client->dev, "Sensor successfully reinitialized\n");
+	} else if (attr == &iio_dev_attr_pointer_rollover.dev_attr) {
+		mutex_lock(&data->lock);
+		ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_2,
+					 QMC5883L_ROL_PNT, val ? QMC5883L_ROL_PNT : 0);
+		mutex_unlock(&data->lock);
+	}
+	return ret ? ret : count;
+}
+
 static int qmc5883l_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -598,6 +659,8 @@ static struct attribute *qmc5883l_attributes[] = {
 	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_data_ready.dev_attr.attr,
 	&iio_dev_attr_overflow.dev_attr.attr,
+	&iio_dev_attr_soft_reset.dev_attr.attr,
+	&iio_dev_attr_pointer_rollover.dev_attr.attr,
 	NULL
 };
 
@@ -658,6 +721,27 @@ static const struct iio_info qmc5883l_info = {
 
 static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
 
+static int qmc5883l_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
+}
+
+static int qmc5883l_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
+}
+
+static const struct dev_pm_ops qmc5883l_pm_ops = {
+	.suspend = qmc5883l_suspend,
+	.resume = qmc5883l_resume,
+};
+
 static int qmc5883l_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
@@ -682,6 +766,10 @@ static int qmc5883l_probe(struct i2c_client *client)
 	data->regmap = regmap;
 	mutex_init(&data->lock);
 
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		dev_warn(&client->dev, "Failed to read mount matrix: %d\n", ret);
+
 	indio_dev->name = "qmc5883l";
 	indio_dev->info = &qmc5883l_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -729,6 +817,7 @@ static struct i2c_driver qmc5883l_driver = {
 	.driver = {
 		.name = "qmc5883l",
 		.of_match_table = qmc5883l_of_match,
+		.pm = pm_sleep_ptr(&qmc5883l_pm_ops),
 	},
 	.id_table = qmc5883l_id,
 	.probe = qmc5883l_probe,
@@ -739,3 +828,4 @@ module_i2c_driver(qmc5883l_driver);
 MODULE_AUTHOR("Brajesh Patil <brajeshpatil11@gmail.com>");
 MODULE_DESCRIPTION("QMC5883L Driver");
 MODULE_LICENSE("GPL");
+
-- 
2.39.5


