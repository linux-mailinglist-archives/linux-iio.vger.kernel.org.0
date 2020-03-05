Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BA417A731
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 15:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCEOQn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 09:16:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44818 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEOQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 09:16:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so7193089wrt.11
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2020 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eifDdvFkvCJs5UXxx8ZCjJXpTsKOp6h7bU7XtW1Ku+k=;
        b=Qi5HjooMjLAF8D1dcMtBZx1Tw0wAMhgmwWTgVeCv8nZ9fiCAjjKZ6OjQ6I3Ma6gAmU
         bl3Azo+UAiyXlxJROE+uDobDest79yHGJ09HG2t92Oo5Q92IswDq5rzsku1DWdTGR4Dk
         nuDpokHvnM9ccryFVQedzMzGCh7/asKJvzpRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eifDdvFkvCJs5UXxx8ZCjJXpTsKOp6h7bU7XtW1Ku+k=;
        b=myyUh4H68cTPt7TNHXoTk1dwKwBxRfP2lh3NWK1LSei84dNrgZvVPOUZnr7oblIoDu
         2V0kKhUmOC0fOgJnLQc3oQMaZYvfuk9pIk28NIoJ7G7N1pILvK9AiNI4+1j+KFENuMsP
         ObLLNy6iNrN3ghymEM0XYAIOldgA1xE8uXZHM9doXcME1pB6ORPR8FDgDWsGjfusfr94
         xU3009wxSlcfSj33rTNYcVbSlTurn2YlDwSU18sBgD6S1ujmoSRWfBlKAZHyAhDBX4dO
         GlgVK+nBveVDNr+F+9++PhlBFv9NCsuZ7+p04/XE6BmXsP9zfro8x+mKqsRobZZEkbKK
         +7hQ==
X-Gm-Message-State: ANhLgQ1btni+qhvoPTs7omI0g0uduHnHJAjm+QCl3stUiNXMu5UCjrCE
        9yjBhiXy34gcthKIilOY0HethqvBznN+
X-Google-Smtp-Source: ADFU+vt2DChTL7nLy7lqGDi9NS6ohSXzxxFK99gYgXXmtDNJZZwNJEU+Eum5YBXdC7o0BP0lffcfXA==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr10148680wrq.119.1583417799360;
        Thu, 05 Mar 2020 06:16:39 -0800 (PST)
Received: from odin.spotify.net ([2001:2030:49:0:b4e8:ff8f:e413:2a12])
        by smtp.gmail.com with ESMTPSA id a5sm9686927wmb.37.2020.03.05.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:16:38 -0800 (PST)
From:   Mike Goeppner <mikegoeppner@spotify.com>
To:     linux-iio@vger.kernel.org
Cc:     pmeerw@pmeerw.net, manivannanece23@gmail.com,
        Mike Goeppner <mikegoeppner@spotify.com>
Subject: [PATCH 1/1] iio: light: vl6180: Add support for range ignore
Date:   Thu,  5 Mar 2020 15:16:15 +0100
Message-Id: <20200305141615.110423-2-mikegoeppner@spotify.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305141615.110423-1-mikegoeppner@spotify.com>
References: <20200305141615.110423-1-mikegoeppner@spotify.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This now makes it possible to configure and use the range ignore setting
on the vl6180 sensor via sysfs. In order to do this, three new device files
have been added, range_ignore_enable, range_ignore_threshold, and
range_ignore_valid_height.

range_ignore_threshold and range_ignore_valid_height write to the
corresponding registers on the sensor. range_ignore_enable sets the
sysrange__range_ignore_enable bit in the SYSRANGE__RANGE_CHECK_ENABLES
register.

Signed-off-by: Mike Goeppner <mikegoeppner@spotify.com>
---
 drivers/iio/light/vl6180.c | 180 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 192c77ef3608..4cc308de97f2 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -41,10 +41,18 @@
 #define VL6180_OUT_OF_RESET 0x016
 #define VL6180_HOLD 0x017
 #define VL6180_RANGE_START 0x018
+#define VL6180_RANGE_CHECK_ENABLES 0x02d
+#define VL6180_RANGE_IGNORE_VALID_HEIGHT 0x025
+#define VL6180_RANGE_IGNORE_THRESHOLD 0x026
 #define VL6180_ALS_START 0x038
 #define VL6180_ALS_GAIN 0x03f
 #define VL6180_ALS_IT 0x040
 
+/* Range check enable configuration */
+#define VL6180_ALS_EARLY_CONVERGENCE_ENABLE (1 << 0)
+#define VL6180_RANGE_IGNORE_ENABLE (1 << 1)
+#define VL6180_SIGNAL_TO_NOISE_ENABLE (1 << 4)
+
 /* Status registers */
 #define VL6180_RANGE_STATUS 0x04d
 #define VL6180_ALS_STATUS 0x04e
@@ -128,7 +136,7 @@ static const struct vl6180_chan_regs vl6180_chan_regs_table[] = {
 };
 
 static int vl6180_read(struct i2c_client *client, u16 cmd, void *databuf,
-		       u8 len)
+			   u8 len)
 {
 	__be16 cmdbuf = cpu_to_be16(cmd);
 	struct i2c_msg msgs[2] = {
@@ -207,6 +215,76 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
 	return 0;
 }
 
+static ssize_t vl6180_show_register_byte(struct device *dev, u16 cmd,
+		char *buff)
+{
+	int ret;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = vl6180_read_byte(client, cmd);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buff, "%d\n", ret);
+}
+
+static ssize_t vl6180_store_register_byte(struct device *dev, u16 cmd,
+		const char *buff, size_t len)
+{
+	int ret;
+	u8 val;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = kstrtou8(buff, 0, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = vl6180_write_byte(client, cmd, val);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static ssize_t vl6180_show_register_word(struct device *dev, u16 cmd,
+		char *buff)
+{
+	int ret;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = vl6180_read_word(client, cmd);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buff, "%d\n", ret);
+}
+
+static ssize_t vl6180_store_register_word(struct device *dev, u16 cmd,
+		const char *buff, size_t len)
+{
+	int ret;
+	u16 val;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = kstrtou16(buff, 0, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = vl6180_write_word(client, cmd, val);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
 static int vl6180_measure(struct vl6180_data *data, int addr)
 {
 	struct i2c_client *client = data->client;
@@ -343,8 +421,104 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 
 static IIO_CONST_ATTR(als_gain_available, "1 1.25 1.67 2.5 5 10 20 40");
 
+static ssize_t vl6180_show_range_ignore_threshold(struct device *dev,
+		struct device_attribute *attr, char *buff)
+{
+	return vl6180_show_register_word(dev, VL6180_RANGE_IGNORE_THRESHOLD,
+			buff);
+}
+
+static ssize_t vl6180_store_range_ignore_threshold(struct device *dev,
+		struct device_attribute *attr, const char *buff, size_t len)
+{
+	return vl6180_store_register_word(dev, VL6180_RANGE_IGNORE_THRESHOLD,
+			buff, len);
+}
+
+static IIO_DEVICE_ATTR(range_ignore_threshold,
+		0644,
+		vl6180_show_range_ignore_threshold,
+		vl6180_store_range_ignore_threshold,
+		0);
+
+static ssize_t vl6180_show_range_ignore_valid_height(struct device *dev,
+		struct device_attribute *attr, char *buff)
+{
+	return vl6180_show_register_byte(dev, VL6180_RANGE_IGNORE_VALID_HEIGHT,
+			buff);
+}
+
+static ssize_t vl6180_store_range_ignore_valid_height(struct device *dev,
+		struct device_attribute *attr, const char *buff, size_t len)
+{
+	return vl6180_store_register_byte(dev, VL6180_RANGE_IGNORE_VALID_HEIGHT,
+			buff, len);
+}
+
+static IIO_DEVICE_ATTR(range_ignore_valid_height,
+		0644,
+		vl6180_show_range_ignore_valid_height,
+		vl6180_store_range_ignore_valid_height,
+		0);
+
+static ssize_t vl6180_show_range_ignore_enable(struct device *dev,
+		struct device_attribute *attr, char *buff)
+{
+	int ret;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = vl6180_read_byte(client, VL6180_RANGE_CHECK_ENABLES);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buff, "%d\n", !!(ret & VL6180_RANGE_IGNORE_ENABLE));
+}
+
+static ssize_t vl6180_store_range_ignore_enable(struct device *dev,
+		struct device_attribute *attr, const char *buff, size_t len)
+{
+	int ret;
+	bool val;
+
+	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct i2c_client *client = data->client;
+
+	ret = kstrtobool(buff, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = vl6180_read_byte(client, VL6180_RANGE_CHECK_ENABLES);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		ret = vl6180_write_byte(client,
+				VL6180_RANGE_CHECK_ENABLES,
+				ret | VL6180_RANGE_IGNORE_ENABLE);
+	else
+		ret = vl6180_write_byte(client,
+				VL6180_RANGE_CHECK_ENABLES,
+				ret & ~VL6180_RANGE_IGNORE_ENABLE);
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(range_ignore_enable,
+		0644,
+		vl6180_show_range_ignore_enable,
+		vl6180_store_range_ignore_enable,
+		0);
+
 static struct attribute *vl6180_attributes[] = {
 	&iio_const_attr_als_gain_available.dev_attr.attr,
+	&iio_dev_attr_range_ignore_enable.dev_attr.attr,
+	&iio_dev_attr_range_ignore_threshold.dev_attr.attr,
+	&iio_dev_attr_range_ignore_valid_height.dev_attr.attr,
 	NULL
 };
 
@@ -416,8 +590,8 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 }
 
 static int vl6180_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
 {
 	struct vl6180_data *data = iio_priv(indio_dev);
 
-- 
2.20.1

