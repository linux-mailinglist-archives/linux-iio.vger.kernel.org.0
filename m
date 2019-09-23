Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA9BB383
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfIWMRw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 08:17:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbfIWMRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 08:17:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so9052767wml.4
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QSsgq7cJwjjmwGU+j1IcvwyHO3CVCMDJ3zX6AShKDGM=;
        b=tzaJLYjxxVdzYPDA8luK/gxQV0sW6xM6NjJzrJeo99SOPNTQu3G8xhqnoM8PmzqzbM
         6YAKmjQXgJX3JRPKQfJTv6KmbwQDk3uke76gjoc86n39VZ6CjPHqlyAo95zVM33WluVK
         J3i/4G/M09eB6ulj7Yh9Fv3CmCIDUdxIj6JMWrteLgEnZdf0DXDCawQBEyDQ+xrIL7xB
         URRD+Qio9gSe+nQ42tOLU6Nfl7JUwH+ruqJlYvTJWlclN87gAnCGWsnCEsijBFk/1aRh
         jldrbHLQwRFpVzrrteLMujhPWDKd3NUjHoDVtZesAqV+erPvAn8F56al98Ft7Bbj3jJs
         rUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QSsgq7cJwjjmwGU+j1IcvwyHO3CVCMDJ3zX6AShKDGM=;
        b=WTczO3ODsH18dqL9AMiEZ/IPM5RzdrqOYaNfLkM10bsBl38ieyrR1R/zIdJTmxXk3N
         UcjncG8H0hFm9vDgZxU8Us2Wvh6AsROc6GFy7gPyM67Ns7iwjMcZlDQRi47GcGdLcIek
         Jzx1nHsPLZmlHGuoRrobq/cIM6w2Y5l6gYV0TcNadDaVo84TnnC0+af3kNU+XwoN1UYB
         DAF45zig2yxQfLb0FScZ3AhgWbqIjqW+5u+tctf1ScX8NWQsM+9K8R5CJfY9MF5aI8GD
         iQEMouoGHBY3OZDuJHl4Q4bb8zjt7T7f8wXYnDacWc+cDXhiKm3HVZLS7q4vFoBCBuXL
         /pPw==
X-Gm-Message-State: APjAAAUq/XMCPm+7y64NyOwIjqxQEHF7tcFZ7Cr/XrFNfgunNxVs5OI8
        1jUr0CFnsxGMoVY8Hh7OVls=
X-Google-Smtp-Source: APXvYqzOgKAsem8Fp43vjeDlxDg/z7AJhaIwYROlIMId9UWN1Tl6eBibEOrwyJRNWcoVm1X7wTZuDw==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr12770650wmc.23.1569241069456;
        Mon, 23 Sep 2019 05:17:49 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id a7sm11342836wra.43.2019.09.23.05.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:17:48 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, matthew.weber@rockwellcollins.com
Cc:     colin.king@canonical.com, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 3/3] iio: max31856: add support for runtime-configuring the thermocouple type
Date:   Mon, 23 Sep 2019 14:17:14 +0200
Message-Id: <20190923121714.13672-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121714.13672-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The sensor support various thermocouple types (e.g. J, K, N, ...). The
driver allows to configure this parameter using a DT property.

This is useful when i.e. the thermocouple is physically tied to the sensor
and it is usually not removed, or when it is at least known in advace
which sensor will be connected to the circuit.

However, if the user can randomly connect any kind of thermocouples (i.e.
the device exposes a connector, and the user is free to connect its own
sensors), it would be more appropriate to provide a mechanism to
dynamically switch from one thermocouple type to another. This can be i.e.
handled in userspace by a GUI, a configuration file or a program that
detects the thermocouple type by reading a GPIO, or a eeprom on the probe,
or whatever.

This patch adds a IIO attribute that can be used to override, at run-time,
the DT-provided setting (which serves as default).

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 8b2e0102fa5c..588e791c79a3 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2018-2019 Rockwell Collins
  */
 
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -70,6 +71,10 @@ struct max31856_data {
 	int averaging;
 };
 
+const char max31856_tc_types[] = {
+	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
+};
+
 static int max31856_read(struct max31856_data *data, u8 reg,
 			 u8 val[], unsigned int read_size)
 {
@@ -336,16 +341,55 @@ static ssize_t set_averaging(struct device *dev,
 	return len;
 }
 
+static ssize_t show_tc_type(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%c\n", max31856_tc_types[data->thermocouple_type]);
+}
+
+static ssize_t set_tc_type(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf,
+			   size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+	char tmp;
+	int tc_type = -1;
+	int i;
+
+	if (sscanf(buf, "%c\n", &tmp) != 1)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
+		if (max31856_tc_types[i] == toupper(tmp)) {
+			tc_type = i;
+			break;
+		}
+	}
+	if (tc_type < 0)
+		return -EINVAL;
+	data->thermocouple_type = tc_type;
+	max31856_init(data);
+	return len;
+}
+
 static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
 static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
 static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
 static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
+static IIO_DEVICE_ATTR(thermocouple_type, 0644, show_tc_type, set_tc_type, 0);
 
 static struct attribute *max31856_attributes[] = {
 	&iio_dev_attr_fault_ovuv.dev_attr.attr,
 	&iio_dev_attr_fault_oc.dev_attr.attr,
 	&iio_dev_attr_filter.dev_attr.attr,
 	&iio_dev_attr_averaging.dev_attr.attr,
+	&iio_dev_attr_thermocouple_type.dev_attr.attr,
 	NULL,
 };
 
-- 
2.17.1

