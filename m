Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F20BB382
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfIWMRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 08:17:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54851 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfIWMRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 08:17:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so9689924wmp.4
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkw+yBgCh3Duibf7O+61ekGUivzVg0RWWljsVrDdd80=;
        b=G/8H5BBk0dWbBcjVRH3ufQGX+az+p5UDGYiLQ51AF5vQIEytxjQ/LGksSmMkg7b+KM
         KxoaCyO/XnLWlPns7IzKv0Uon8lfIOs2g87eKc+l89k0mqTiMDB2fFJpExnW9uW31xoN
         B6ev4g5FB09PwjDmxsdT25EArE4uoc3QiV+aacmqX/YHm15Bx9ADdKzKGpg52Sp3XEqi
         OIOnZqV3MOzsxViSGExt8aMj6GG13W9u1jzrvURzF+RSE97M1KV6nN+2IQQ8v/jj/p1+
         aJfMm2YsGnzrcXKOBR+Xf3/f4046J0pEbnbj/CPCP9rXDk73AWvCuVHlvjKE+aeKN5Xc
         Vy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkw+yBgCh3Duibf7O+61ekGUivzVg0RWWljsVrDdd80=;
        b=cQjl2fk2DcYbFAwzPupzDt9QPAyo7TQEkNSQb2vGiWaNh8KfdJSoRInHJxZk9eAY4a
         GC3P/Q2HjlFUrNCeox4cVfe0biMqZCXRumaJO8xQrpSdeGkaKMM3J6DU6qtlouTXc8oF
         gtp1mFVD0Q8YgeJ+tQiArZCeK+2vEZkoGRPL/FQ8FsQ7cyYiqsZJksu8FyaCDttR8xD0
         7mW7149xetJQ36xSH8bGyp3U2eiNJiI32HAhksIZi/WVMSPCHqBpIsx7vVuzJMurVbh9
         u2Q4eYnzf4MEnPo0mCDKq5fEn5nfZFH+1985WHRSFPx+61XtxBhhMJGUWA8Mle/QgQ61
         gIUA==
X-Gm-Message-State: APjAAAXIyfQg7voMaX9LCrjYqWFHfFnpVNySC+W8vPt+gbZyWM7dd1uc
        P+y+yJzVsKbj9tHCcJmmzcNhYN0R18s=
X-Google-Smtp-Source: APXvYqwow9KEvVfcEZ4XYDBzvdS3E2/MtCCJDPRVJDLgYeef1J3jG0jLmZmC5UY0buWAPMYPvbolMg==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr12452827wmh.134.1569241068492;
        Mon, 23 Sep 2019 05:17:48 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id a7sm11342836wra.43.2019.09.23.05.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:17:47 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, matthew.weber@rockwellcollins.com
Cc:     colin.king@canonical.com, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 2/3] iio: max31856: add support for configuring the HW averaging
Date:   Mon, 23 Sep 2019 14:17:13 +0200
Message-Id: <20190923121714.13672-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121714.13672-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This sensor can perform samples averaging in hardware, but currently the
driver leaves this setting alone (default is no averaging).

This patch introduces a new IIO attribute that allows the user to set the
averaging as desired (the HW supports averaging of 2, 5, 8 or 16 samples)

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index d12613f7ba3c..8b2e0102fa5c 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -24,6 +24,8 @@
 #define MAX31856_CR0_OCFAULT       BIT(4)
 #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
 #define MAX31856_CR0_FILTER_50HZ   BIT(0)
+#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
+#define MAX31856_AVERAGING_SHIFT   4
 #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
 #define MAX31856_FAULT_OVUV        BIT(1)
 #define MAX31856_FAULT_OPEN        BIT(0)
@@ -65,6 +67,7 @@ struct max31856_data {
 	struct spi_device *spi;
 	u32 thermocouple_type;
 	bool filter_50hz;
+	int averaging;
 };
 
 static int max31856_read(struct max31856_data *data, u8 reg,
@@ -109,6 +112,10 @@ static int max31856_init(struct max31856_data *data)
 
 	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
 	reg_cr1_val |= data->thermocouple_type;
+
+	reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
+	reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
+
 	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
 	if (ret)
 		return ret;
@@ -295,14 +302,50 @@ static ssize_t set_filter(struct device *dev,
 	return len;
 }
 
+static ssize_t show_averaging(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", 1 << data->averaging);
+}
+
+static ssize_t set_averaging(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf,
+			     size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+	unsigned int nsamples;
+	int shift;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &nsamples);
+	if (ret)
+		return ret;
+
+	shift = fls(nsamples) - 1;
+	if (nsamples > 16 || BIT(shift) != nsamples)
+		return -EINVAL;
+
+	data->averaging = shift;
+	max31856_init(data);
+	return len;
+}
+
 static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
 static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
 static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
+static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
 
 static struct attribute *max31856_attributes[] = {
 	&iio_dev_attr_fault_ovuv.dev_attr.attr,
 	&iio_dev_attr_fault_oc.dev_attr.attr,
 	&iio_dev_attr_filter.dev_attr.attr,
+	&iio_dev_attr_averaging.dev_attr.attr,
 	NULL,
 };
 
-- 
2.17.1

