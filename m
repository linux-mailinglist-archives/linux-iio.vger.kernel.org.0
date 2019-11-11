Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD631F77C9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKPfh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51812 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKKPfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so13815132wme.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PVezXAejdva/nQbIcOFCt57jKE7cejAQgFATjaQOuZw=;
        b=aORACKzikbOHDtI+Tbc0XoVy/5/LxPmadClYCIevhPI7Ixb/cpgBP9D/guAnmiW+l5
         Cus8qNvlUy+4BvRCqKFt5RbFnYTX+cR5op6/M0nqQrpRvcgCnj/ThQMRzSLAkmKDCnb7
         nboBZ2DHU3DVsRDWUnJurY/h15MGwJsqCjg0v69klK/eTm+ZTx8EDTgm38qZkJtSbEGK
         4RQ0eCiOnA7jXbPHm4z9fUFplH1rvEmt4xJO+nxx6LrWWiEDZodMWyzuD7LYQIfwxi9k
         YXHpLolL9kpIcakqgdQxGbZHAevML4jieDIIljsktCa72RtbbFE+DN6P2KrqhaYQleml
         FywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PVezXAejdva/nQbIcOFCt57jKE7cejAQgFATjaQOuZw=;
        b=SSeNzIee71HauNItADa12hAJ/4c9IPvENAB2c4uJE2fgOrUS87XfQ7tABtNdDAbXrF
         wKhIFMsgJC30fQNHBEwNbsOMV7qAPOlsy5Mm8f5f1jjTUhDG+2ovFFkzNy0f3X7krAEz
         Mg8FB/ADiVYQYORinqqzc+MBhQG4kF4wn5pEPUd6YexXoS5meJgzWhunBSsElOsQ7Gn2
         u6hGE7jj9sA5PeAOqPt1DxTxXoJPWHjdsmAfF0z7sURky7qLdDqzk7CkkOIiYZ9sSJ0C
         xe+93Lv6RI1aBcSXUo29do7NrFalhn4LvjNW4U+UHIn6C5k5/MEJPAZj5HoTqVZ+gBqI
         lh1Q==
X-Gm-Message-State: APjAAAXQpTi9Gw7V7BI1RTU0iarQ+2jPu+DvtQQqR+LeDwBtucbX2eop
        LMSJ31OBJvYojKrtWDC+UWA=
X-Google-Smtp-Source: APXvYqxQ6qaY2vJ+3xwqdc7lfAOAeCrHrFVlHbTI+L0Mzaua/BTHD2n4wIAzhPjMOeRnN1dMWXwFXA==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr21379125wmg.166.1573486534788;
        Mon, 11 Nov 2019 07:35:34 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:34 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 3/9] iio: max31856: add support for configuring the HW averaging
Date:   Mon, 11 Nov 2019 16:35:11 +0100
Message-Id: <20191111153517.13862-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This sensor can perform samples averaging in hardware, but currently the
driver leaves this setting alone (default is no averaging).

This patch binds this HW setting to the "oversampling_ratio" IIO attribute
and allows the user to set the averaging as desired (the HW supports
averaging of 2, 5, 8 or 16 samples; in-between values are rounded up).

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 46 +++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index d97ba9ee1598..9f0f4f65dccd 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -12,6 +12,7 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/util_macros.h>
 #include <dt-bindings/iio/temperature/thermocouple.h>
 /*
  * The MSB of the register value determines whether the following byte will
@@ -24,6 +25,8 @@
 #define MAX31856_CR0_OCFAULT       BIT(4)
 #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
 #define MAX31856_CR0_FILTER_50HZ   BIT(0)
+#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
+#define MAX31856_AVERAGING_SHIFT   4
 #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
 #define MAX31856_FAULT_OVUV        BIT(1)
 #define MAX31856_FAULT_OPEN        BIT(0)
@@ -50,7 +53,10 @@ static const struct iio_chan_spec max31856_channels[] = {
 	{	/* Thermocouple Temperature */
 		.type = IIO_TEMP,
 		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 	},
 	{	/* Cold Junction Temperature */
 		.type = IIO_TEMP,
@@ -58,6 +64,8 @@ static const struct iio_chan_spec max31856_channels[] = {
 		.modified = 1,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 	},
 };
 
@@ -65,6 +73,7 @@ struct max31856_data {
 	struct spi_device *spi;
 	u32 thermocouple_type;
 	bool filter_50hz;
+	int averaging;
 };
 
 static int max31856_read(struct max31856_data *data, u8 reg,
@@ -109,6 +118,10 @@ static int max31856_init(struct max31856_data *data)
 
 	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
 	reg_cr1_val |= data->thermocouple_type;
+
+	reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
+	reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
+
 	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
 	if (ret)
 		return ret;
@@ -217,6 +230,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = 1 << data->averaging;
+		return IIO_VAL_INT;
 	default:
 		ret = -EINVAL;
 		break;
@@ -225,6 +241,33 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int max31856_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct max31856_data *data = iio_priv(indio_dev);
+	int msb;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val > 16 || val < 1)
+			return -EINVAL;
+		msb = fls(val) - 1;
+		/* Round up to next 2pow if needed */
+		if (BIT(msb) < val)
+			msb++;
+
+		data->averaging = msb;
+		max31856_init(data);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -313,6 +356,7 @@ static const struct attribute_group max31856_group = {
 
 static const struct iio_info max31856_info = {
 	.read_raw = max31856_read_raw,
+	.write_raw = max31856_write_raw,
 	.attrs = &max31856_group,
 };
 
-- 
2.17.1

