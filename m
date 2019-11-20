Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6E103DA6
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfKTOtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46713 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfKTOtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so48201wrs.13
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JjokDUYttILXu1Ard3/OhbVu0xrFQleV/PAtkmHmq8o=;
        b=qN8TZxtqMHnM8MJqi/wvebI4aZLmggzgMIyQ5Q2SanFmH3Vfd11b2QHFBhLmXjnIvj
         WjixZqcgZRUyRYxq6n6f9PAUUjMudKYPKIO8On4RtFszrcJNUIORNCocfVsBdpz7mnYh
         j4X6eRvVQCkLHG3iCkQSGT0UjcheEdUcC7ekLwWLt1OqUcPLxWIqnuxH8P9ESfXeO8dC
         2pYDUVr3kL2QWSWektkLZDfAllex4Y+RAddnHvnfGDyD+GZA9PxTow7cWy01eUd+08wl
         GMGtEtWK4EyU1KLGxG3XT6Ly8Hp+1zchzd4UizEJ/RB0apPs+azq8JMkOKJchTMLVCcE
         qdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JjokDUYttILXu1Ard3/OhbVu0xrFQleV/PAtkmHmq8o=;
        b=lRvZ4FlFKAutGdgocWxybE4IpA+z4tifhBs+4zhwfUKaPma2tWu+kJFAJ4ycvcjyhU
         elnwAmDj+/uy/FDA4TnM6gugkDMNjUNWEEo3zGtky1IEnZqBV7GD/sLJSxsc/xyHD/5O
         +bTaL4Rcc6qVxUcB5Ik+m1vfIy8qo2mepvfex3pq79rKlcitQTMW+mdDslSkrG7lUwnW
         D73AJJy43qQjAZ1iGB4l7dDfyHdCHTb6dq9ziCkM5JeA/SAM90WIiVf+rT9f1eL+aFfE
         ZcjKkM+mjjyadOrvtpjQyTZXPdSq7659ZcdH32hWn3vAsa7jWUiDJALUymfDdqdJPINf
         MSDQ==
X-Gm-Message-State: APjAAAU6BsMUBm/wafhrsPXetQHf0w/OLXovRTGnsDH0EhXQctaePI1R
        WN3yyuC2m8fC4ofVwkX3RsE=
X-Google-Smtp-Source: APXvYqwTKmyAbq1FpZgjLAzL6oW8ZJf5QafyChrwfYm/hlKODKaDCbkVfdbVHXhzzEWspYPzH28S0w==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr3739211wrx.110.1574261359636;
        Wed, 20 Nov 2019 06:49:19 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:18 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 1/9] iio: max31856: add option for setting mains filter rejection frequency
Date:   Wed, 20 Nov 2019 15:47:48 +0100
Message-Id: <20191120144756.28424-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This sensor has an embedded notch filter for reducing interferences caused
by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
(and harmonics).

Currently the said setting is left alone (the sensor defaults to 60Hz).
This patch introduces a IIO attribute that allows the user to set the said
filter to the desired frequency.

NOTE: this has been intentionally not tied to any DT property to allow
the configuration of this setting from userspace, e.g. with a GUI or by
reading a configuration file, or maybe reading a GPIO tied to a physical
switch or accessing some device that can autodetect the line frequency.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/temperature/max31856.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 73ed550e3fc9..d97ba9ee1598 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -23,6 +23,7 @@
 #define MAX31856_CR0_1SHOT         BIT(6)
 #define MAX31856_CR0_OCFAULT       BIT(4)
 #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
+#define MAX31856_CR0_FILTER_50HZ   BIT(0)
 #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
 #define MAX31856_FAULT_OVUV        BIT(1)
 #define MAX31856_FAULT_OPEN        BIT(0)
@@ -63,6 +64,7 @@ static const struct iio_chan_spec max31856_channels[] = {
 struct max31856_data {
 	struct spi_device *spi;
 	u32 thermocouple_type;
+	bool filter_50hz;
 };
 
 static int max31856_read(struct max31856_data *data, u8 reg,
@@ -123,6 +125,11 @@ static int max31856_init(struct max31856_data *data)
 	reg_cr0_val &= ~MAX31856_CR0_1SHOT;
 	reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
 
+	if (data->filter_50hz)
+		reg_cr0_val |= MAX31856_CR0_FILTER_50HZ;
+	else
+		reg_cr0_val &= ~MAX31856_CR0_FILTER_50HZ;
+
 	return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
 }
 
@@ -249,12 +256,54 @@ static ssize_t show_fault_oc(struct device *dev,
 	return show_fault(dev, MAX31856_FAULT_OPEN, buf);
 }
 
+static ssize_t show_filter(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
+}
+
+static ssize_t set_filter(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf,
+			  size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	switch (freq) {
+	case 50:
+		data->filter_50hz = true;
+		break;
+	case 60:
+		data->filter_50hz = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	max31856_init(data);
+	return len;
+}
+
 static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
 static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
+static IIO_DEVICE_ATTR(in_temp_filter_notch_center_frequency, 0644,
+		       show_filter, set_filter, 0);
 
 static struct attribute *max31856_attributes[] = {
 	&iio_dev_attr_fault_ovuv.dev_attr.attr,
 	&iio_dev_attr_fault_oc.dev_attr.attr,
+	&iio_dev_attr_in_temp_filter_notch_center_frequency.dev_attr.attr,
 	NULL,
 };
 
@@ -280,6 +329,7 @@ static int max31856_probe(struct spi_device *spi)
 
 	data = iio_priv(indio_dev);
 	data->spi = spi;
+	data->filter_50hz = false;
 
 	spi_set_drvdata(spi, indio_dev);
 
-- 
2.17.1

