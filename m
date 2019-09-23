Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABABB381
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfIWMRu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 08:17:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbfIWMRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 08:17:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so13734893wrx.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuV3QwoICkxsxXj6MRCa5YPaGE02cRujJRq5EjeTc48=;
        b=YlLIxetRqPNhHoOE5I9RCGCWOtjZ+cKWOL+PJWEQtF+eN+FadhWpBsZTIb6/lyvfSw
         f7jpawcytfDP+47riAdSKBpbqRysMlUvLdNAM8qHzWAtODdSw1LUepuk1ohQVthJQ9x0
         t6Ws6oRerRSjp+JhJWjgK8eGEo1FdouM3cZr2ynS4CJJ9NbDnwcsB2tEtoXeStPlypug
         2VIZ4dOo8g7t71Pm7TgUhygPVzRGH8rv0l1UNnU5M7gSjCnnLF9ALf4UGtJqRDrWz5vw
         t81PgE+GelISzO7se72YTwU4WmudItIY+Moib2FOjIH3wwwqe2eS7AMIOHcOt98DcrAQ
         U9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuV3QwoICkxsxXj6MRCa5YPaGE02cRujJRq5EjeTc48=;
        b=Q4wQgdcfwM73lpWTDsNdVknHCytKOeSwHkvQl6xelmy5gW8Bs5RKgr0NyxqhvjwOhq
         28eaO4z2hYg1Nkb2Zk6YTwqY80VjgdWWmGtBtf9RZ8opK55M2wtGPNcXaCAc111IsSnD
         SwS5GjJj82RMSYSeo+zaxHDeiTJ0nAiIBW2Qt1AJlMBHDiAPLPrOIxU9OGDCqqLunURo
         AkjNvs/vxDNs8dEssjyOeKm1L/G5nHBU/5mv2Cvq9+w34MGks11lCKb8f13BDauDeIR7
         ZGIcwR7yJQX1SthoZ8pGKJBxg3zPRm1qPftc8Tugtz1FDmASay/v5YZeD1aRlnE7uSbQ
         23wg==
X-Gm-Message-State: APjAAAUhXpWEFAvmJmvOfhLZ0JM+oga4XtS/ooMAtPo1ih3TWsRelIZe
        n4TYhAHsEylPfuq0xG9ao4M=
X-Google-Smtp-Source: APXvYqysgyKmGI6lMl+vW8RghRiq24OIIX5NDvdzEBFX1zBrsL5zbWEMPUV1VY/kQFevZJg9gZAsCw==
X-Received: by 2002:adf:e390:: with SMTP id e16mr21570355wrm.29.1569241067423;
        Mon, 23 Sep 2019 05:17:47 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id a7sm11342836wra.43.2019.09.23.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:17:46 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, matthew.weber@rockwellcollins.com
Cc:     colin.king@canonical.com, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 1/3] iio: max31856: add option for setting mains filter rejection frequency
Date:   Mon, 23 Sep 2019 14:17:12 +0200
Message-Id: <20190923121714.13672-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121714.13672-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
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

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 73ed550e3fc9..d12613f7ba3c 100644
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
 
@@ -249,12 +256,53 @@ static ssize_t show_fault_oc(struct device *dev,
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
+static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
 
 static struct attribute *max31856_attributes[] = {
 	&iio_dev_attr_fault_ovuv.dev_attr.attr,
 	&iio_dev_attr_fault_oc.dev_attr.attr,
+	&iio_dev_attr_filter.dev_attr.attr,
 	NULL,
 };
 
@@ -280,6 +328,7 @@ static int max31856_probe(struct spi_device *spi)
 
 	data = iio_priv(indio_dev);
 	data->spi = spi;
+	data->filter_50hz = false;
 
 	spi_set_drvdata(spi, indio_dev);
 
-- 
2.17.1

