Return-Path: <linux-iio+bounces-19289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA0AAF964
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5474C3820
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46382224AE9;
	Thu,  8 May 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq4STEiB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B95225414;
	Thu,  8 May 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706159; cv=none; b=CjZYpE07vTnjd2xGNdS4wLLg3i+q5/iCcMgSFvisevQ1jPZs8s16TaJQ2dNV2tIDHSLOuzrEqZhB3bbpeENwEIeTqt2iRiPG9hIa7iyg69lqjsCGS4uFEHWVUOMIO/GxDlexH8X36R4+MVJNRP8bGq3qgyofrFA1UoTp0W6pdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706159; c=relaxed/simple;
	bh=X26oclGIznR3qK1kdgpSD0REQDohkpF5ZOFUFdXzR44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yrkdq5MTnDhuU3jF0tF5H5dWG7Es+nnFwhKfIDsrrftJkc2CHHgF9PL9vEkvzkCxG74qSUNnsmc/3FyVsJJTOLU7VOd7Hv+YqDI67DMfVD2HQOS86IfQ+ag68syxs6U7lpPP+/3EobuNQURqKihR/jax0KiKse2ilrkK/ed/PGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq4STEiB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso175951b3a.1;
        Thu, 08 May 2025 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706155; x=1747310955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTF5WwZ755AtxMe017l6kAi7UdtOb3nONRyjvWK03SM=;
        b=fq4STEiBXD2JspgGGhQzicPFAKRtyX5TgU2NVvcDN9yB15J5HOwmH1ud3yiZ69oL55
         5JEjvxNOdVUDqvau3Dr6EiHV4PnqLydh/7G4BzHvVxEibqWDuty14AkdNW63lp/nMUdH
         zbyNrLzcShiBrxWJiaiis70UHDgoLW7+HZ2QfBGlYck7Yx7+EexX0NFCEfoZJiVzo4Hn
         hkogucjVSpFyRNLZLIMtMYfZxFVcsYstYr6W0TOI31txE4SI9Gzg/gB2bzTWLHQ6+sPG
         im2/toiNjlin565txzB0FT5lAO0KAXkVSikFu63oOhRZvfRJBzC6cclUATNnkLmf48Uc
         IzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706155; x=1747310955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTF5WwZ755AtxMe017l6kAi7UdtOb3nONRyjvWK03SM=;
        b=v2tvStCCH4aTVNdjYIJBXULzvW/Z1mLmf39H02nGtZanylLOJVg/TsuaGa9oWCu80L
         3nLfVIBDpNPZd2+87hXm6RA1E9R7LxMLFNBnGjafi2jkX37f2GAQgw6GZGJnK0H6QC+U
         fcSJiNfP+xRmqja0p52vpW4x6xUBzQbLpylmybSDvrDWudDuRcAjBCQXRevYj/3/sWwq
         XUQttAV0ScTi8nMS2LynacnfXDQELNe4F2GUgJiwOeqk9Ixa2hbur/5PFL3xDRe+AdmO
         qwZ5fZbEgBRzXts7Lli0Vk6WWt0iWMQ5EHkvM+0YPzjoOwZVbXszNy0QLM90jRmitgLJ
         y3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL2LUUtQvqWxHEm6S749bruJSrngKuWPvlha2hplWT4OJ5sc4VMgKeULf7qajKO1hkVVSGMMI6ijpxGWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwtEGVegpyJWFj8p9Xkpd15+9QhUB+mPxYk5M28SAfsXdsaH+
	sZQJRHYF6u7fAAjGZUByYZbMueEUNhmBNp+uncOcNlMWvP2zGt36
X-Gm-Gg: ASbGncuXYckZqq8bRQg3xmUN1oEfDAAqxi21vJUN3gCuHe/2q2UFhdlUKWxldVNJC0y
	0ZGQmUozJa8sj9aKmfrNM1N/6dgxsoiv8tM4Kqa8gKSxyyPeK55b2BT1pkLW61pjQlcRjkr5Tii
	XcEKzoL4wKNysVu7Vwx1xt2aTbgnLjooHk1rWuOaPpwghzIJnvpFNiln8BnVdZkpgbwD/l4W9MH
	VO4LD6baiaPYlDWOl+B8wMCmX8a+M/MSax2ycoGgkryW3iZzDOYQwe6Cw4bzHp+UdKD8S4SZ+WP
	SvHcfTupQ2dINMIJUHMBjvMo4k4JZSwUMWmoCtBSO4442VZ+qak0n52S4Wv9
X-Google-Smtp-Source: AGHT+IHPHJCZloVxA72cbL5PeRUKZnwp77UfWDWmXTuaXazKEUqSXUxw0FeueFpCTavjO8GD3RgL/A==
X-Received: by 2002:a05:6a00:228f:b0:740:a85b:7554 with SMTP id d2e1a72fcca58-740a85b7598mr5071141b3a.2.1746706155353;
        Thu, 08 May 2025 05:09:15 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a20bsm13503134b3a.10.2025.05.08.05.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:09:14 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v2 5/5] iio: magnetometer: qmc5883l: add mount matrix, control features and power management
Date: Thu,  8 May 2025 13:09:00 +0100
Message-Id: <20250508120900.114348-3-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508120900.114348-1-brajeshpatil11@gmail.com>
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 drivers/iio/magnetometer/qmc5883l.c | 89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
index 07c65f193def..d26f959ab8c5 100644
--- a/drivers/iio/magnetometer/qmc5883l.c
+++ b/drivers/iio/magnetometer/qmc5883l.c
@@ -7,6 +7,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/types.h>

@@ -54,6 +55,10 @@
 #define QMC5883L_OSR_MASK           0xC0
 #define QMC5883L_OSR_SHIFT          6

+#define QMC5883L_SOFT_RST           0x80
+#define QMC5883L_ROL_PNT            0x40
+#define QMC5883L_INT_ENB            0x01
+
 static const char *const qmc5883l_modes[] = {
 	"standby", "continuous"
 };
@@ -80,12 +85,14 @@ static const int qmc5883l_odr_map[] = {
  * @client: I2C client structure
  * @lock: mutex to protect register access
  * @regmap: register map of the device
+ * @orientation: Sensor mounting orientation matrix
  * @scan: buffer for triggered data reading
  */
 struct qmc5883l_data {
 	struct i2c_client *client;
 	struct mutex lock; /* Protects sensor read/write operations */
 	struct regmap *regmap;
+	struct iio_mount_matrix orientation;

 	struct {
 		__le16 chans[3];
@@ -102,6 +109,9 @@ static ssize_t qmc5883l_show_scale_avail(struct device *dev,
 					 struct device_attribute *attr, char *buf);
 static ssize_t qmc5883l_show_status(struct device *dev,
 				    struct device_attribute *attr, char *buf);
+static ssize_t qmc5883l_store_control(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count);

 static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
 {
@@ -357,6 +367,15 @@ static int qmc5883l_read_measurement(struct qmc5883l_data *data,
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
@@ -376,6 +395,7 @@ static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
 	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
 	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
 	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qmc5883l_get_mount_matrix),
 	{ }
 };

@@ -383,6 +403,8 @@ static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
 static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
 static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
 static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);
+static IIO_DEVICE_ATTR(soft_reset, 0200, NULL, qmc5883l_store_control, 0);
+static IIO_DEVICE_ATTR(pointer_rollover, 0200, NULL, qmc5883l_store_control, 0);

 static ssize_t qmc5883l_show_odr_avail(struct device *dev,
 				       struct device_attribute *attr, char *buf)
@@ -416,6 +438,44 @@ static ssize_t qmc5883l_show_status(struct device *dev,
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
@@ -599,6 +659,8 @@ static struct attribute *qmc5883l_attributes[] = {
 	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_data_ready.dev_attr.attr,
 	&iio_dev_attr_overflow.dev_attr.attr,
+	&iio_dev_attr_soft_reset.dev_attr.attr,
+	&iio_dev_attr_pointer_rollover.dev_attr.attr,
 	NULL
 };

@@ -659,6 +721,27 @@ static const struct iio_info qmc5883l_info = {

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
@@ -683,6 +766,10 @@ static int qmc5883l_probe(struct i2c_client *client)
 	data->regmap = regmap;
 	mutex_init(&data->lock);

+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		dev_warn(&client->dev, "Failed to read mount matrix: %d\n", ret);
+
 	indio_dev->name = "qmc5883l";
 	indio_dev->info = &qmc5883l_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -693,6 +780,7 @@ static int qmc5883l_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
 					      NULL, &qmc5883l_trigger_handler,
 					      &qmc5883l_buffer_setup_ops);
+
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to setup triggered buffer: %d\n", ret);
 		return ret;
@@ -730,6 +818,7 @@ static struct i2c_driver qmc5883l_driver = {
 	.driver = {
 		.name = "qmc5883l",
 		.of_match_table = qmc5883l_of_match,
+		.pm = pm_sleep_ptr(&qmc5883l_pm_ops),
 	},
 	.id_table = qmc5883l_id,
 	.probe = qmc5883l_probe,
--
2.39.5


