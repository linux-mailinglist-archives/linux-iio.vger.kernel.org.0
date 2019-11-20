Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0F103DAC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfKTOt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731257AbfKTOt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so82708wrf.9
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kvZ1Nd4oryJTOXaM5v9Kg50ST7ylgE1lXo/BkAjpRdg=;
        b=Ip0YhmoNmAlsXVCBQKZGvfF6ZbxnrTQlj5+05zWdyZB6segJPJGkjVk14RHCD0dE8u
         Rds0ubueK9iw9Ve72IyHkuSDoMuOxJqPnSAVSsFROCLUJABvCcehYb1FS4Gy8vGCj1aq
         HgFOFU8BzrAsPxYAJ/fVGxor4FPPmNS/Lh9qbxVJByZnpd6wnvdCAPdaxXb91CHr2pZu
         eby+N1hhDYseRbA8X1uyVTuaXWbtnVjU5jUt9RFPDjhle/iONCPI28Tm37DeBtBitB4M
         mWtOKmBM8AyrgckGaWluHspkqa3pDv21Kx1tlMvnoxXOAKEI9uWt4sAeXOKdnYgGFtBW
         Z+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kvZ1Nd4oryJTOXaM5v9Kg50ST7ylgE1lXo/BkAjpRdg=;
        b=I/lu3JdTpOppNl7yJmYv4eWxBVOSBYmXnVm+tjdmymMVV4RjOjRuZWAobvNUi0SKbt
         Nd3Qotz23u5rSyRf4owbPwHEpnd3PdMonMVd7nqxyp2igjgaS2QzL4v7kxdVDeMWIs6j
         0ie4R36CH3AefaLtEYRrUkGPT5ieBGjh42pm29tyfG3KykFIM1bwM516ZNS4wpZwJLx7
         uDZTYvUj884bxk4xUthNMtI7jvwim1uCy0wKCfAsT607sTRL//hLnVtJX5rlZQlHQcAs
         2xSEqlpO2JONLIdcZC4s/BmP67V4I9JxqXFmvvq3CfPXp3UL8rMIpIZa9/aXNAb7g051
         8nkg==
X-Gm-Message-State: APjAAAW7TfBHTgjzVltg8aq8sAVXZPi+5CKNVgWwcg9vSrsQQbhtK79a
        3VudVj/1bmD5IFSH9LjJPg4=
X-Google-Smtp-Source: APXvYqxrEvRKEWZMfF2QD7KGAx/Glti6fpO4xt6g+a3df1guuRzX8NKLV7jdhXqU8O0dvgExXjUUag==
X-Received: by 2002:a5d:6b51:: with SMTP id x17mr4031036wrw.148.1574261366434;
        Wed, 20 Nov 2019 06:49:26 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:25 -0800 (PST)
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
Subject: [v3 7/9] iio: max31856: add support for runtime-configuring the thermocouple type
Date:   Wed, 20 Nov 2019 15:47:54 +0100
Message-Id: <20191120144756.28424-8-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The sensor support various thermocouple types (e.g. J, K, N, ...). The
driver allows to configure this parameter using a DT property.

This is useful when i.e. the thermocouple is physically tied to the sensor
and it is usually not removed, or when it is at least known in advance
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
---
 drivers/iio/temperature/max31856.c | 41 +++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 8457ca9ae326..4952e89c00bb 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2018-2019 Rockwell Collins
  */
 
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -53,7 +54,8 @@ static const struct iio_chan_spec max31856_channels[] = {
 	{	/* Thermocouple Temperature */
 		.type = IIO_TEMP,
 		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),
 		.info_mask_shared_by_type =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 	},
@@ -75,6 +77,10 @@ struct max31856_data {
 	int averaging;
 };
 
+const char max31856_tc_types[] = {
+	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
+};
+
 static int max31856_read(struct max31856_data *data, u8 reg,
 			 u8 val[], unsigned int read_size)
 {
@@ -232,6 +238,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = 1 << data->averaging;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*val = max31856_tc_types[data->thermocouple_type];
+		return IIO_VAL_CHAR;
 	default:
 		ret = -EINVAL;
 		break;
@@ -240,6 +249,18 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int max31856_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		return IIO_VAL_CHAR;
+	default:
+		return IIO_VAL_INT;
+	}
+}
+
 static int max31856_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
@@ -259,7 +280,24 @@ static int max31856_write_raw(struct iio_dev *indio_dev,
 		data->averaging = msb;
 		max31856_init(data);
 		break;
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+	{
+		int tc_type = -1;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
+			if (max31856_tc_types[i] == toupper(val)) {
+				tc_type = i;
+				break;
+			}
+		}
+		if (tc_type < 0)
+			return -EINVAL;
 
+		data->thermocouple_type = tc_type;
+		max31856_init(data);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -356,6 +394,7 @@ static const struct attribute_group max31856_group = {
 static const struct iio_info max31856_info = {
 	.read_raw = max31856_read_raw,
 	.write_raw = max31856_write_raw,
+	.write_raw_get_fmt = max31856_write_raw_get_fmt,
 	.attrs = &max31856_group,
 };
 
-- 
2.17.1

