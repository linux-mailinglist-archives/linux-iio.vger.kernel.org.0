Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28677103DAA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfKTOt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfKTOt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so7243884wme.1
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3e+Yxxp4U4zcH4iEUPGzxMAsFWhfr3JeTuPoN9dLqI=;
        b=bfRJs+XE6hYcmBKJnEBN3Nr+nvX372q7tJPoqC/Gh2zpuiXvtJscjbV58ejvbJ7AaM
         CLv2hug412ZhBDcN2DwB2PlCHpJ1pReYn0yvMEKoskjGYiKbRzUSs/1qhGgrJgiBPMOb
         ss0rP2hzA/5vgnV3+Vd0ufMPQnwzPLweWIrOyNNxzTvlSDWnU3Zv0uSNEbB7E9NDumxX
         3+qJpAXVXvcMzF8O8QXR+0nzqT2iawA8A4soSGEnoyHw2IKDmTiYfqvfVsadfxSdItsw
         smino/v0qrGA1A0GXIV1bsOLbkhCZttApHg/AiadVP3HmHVZbWy44UN6lmhnP21j7I3E
         jmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3e+Yxxp4U4zcH4iEUPGzxMAsFWhfr3JeTuPoN9dLqI=;
        b=N0dy/3DBu/snm9gMNfmVHGVAlHVcFvJlaNyBEi+Crp9d8zYC3f3v6xv0zTXDHbvtt4
         NsW9OvNIyM2r1n3POkPfT1TYTYBiGzPrxY6q32s6kAqjfssMsRya1eo4+nCpkpxdRSuA
         w9YCtjmhLBm4wpRh7XikbHS7FGqxwT41BPWkiaMcbz+/36YpWQSHi1rtllNTjPBOt50O
         oMRjsGtL0yXKZ9kMq48Kcxngedg/r6j/kAaPIpfxI0euZFZ4PKfifFbNb0yOgtbZhsZr
         on9/9UVLc4cse3UI/HBCSxaLGEsxXYcF04CAAt3gBnZZfMw3Rp19Bi+hWwujmurSDI31
         5mPA==
X-Gm-Message-State: APjAAAVPopEYqTBwygo3cdJAAqX4Wlu1Z3oncWUWK5LVMogecTqK/iYj
        /HdIEyv0EFrT8v6vmwU6vUk=
X-Google-Smtp-Source: APXvYqwEqK+UIWFBBjY1EhiiTonIsCtjTGcD/xSFEx4D5p5GBaJtYrmMp4rvFom25PJWyA+FSw0Kpw==
X-Received: by 2002:a05:600c:2919:: with SMTP id i25mr3588254wmd.158.1574261361934;
        Wed, 20 Nov 2019 06:49:21 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:21 -0800 (PST)
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
Subject: [v3 3/9] iio: max31856: add support for configuring the HW averaging
Date:   Wed, 20 Nov 2019 15:47:50 +0100
Message-Id: <20191120144756.28424-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
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
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index d97ba9ee1598..8457ca9ae326 100644
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
@@ -51,6 +54,8 @@ static const struct iio_chan_spec max31856_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 	},
 	{	/* Cold Junction Temperature */
 		.type = IIO_TEMP,
@@ -58,6 +63,8 @@ static const struct iio_chan_spec max31856_channels[] = {
 		.modified = 1,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 	},
 };
 
@@ -65,6 +72,7 @@ struct max31856_data {
 	struct spi_device *spi;
 	u32 thermocouple_type;
 	bool filter_50hz;
+	int averaging;
 };
 
 static int max31856_read(struct max31856_data *data, u8 reg,
@@ -109,6 +117,10 @@ static int max31856_init(struct max31856_data *data)
 
 	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
 	reg_cr1_val |= data->thermocouple_type;
+
+	reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
+	reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
+
 	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
 	if (ret)
 		return ret;
@@ -217,6 +229,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = 1 << data->averaging;
+		return IIO_VAL_INT;
 	default:
 		ret = -EINVAL;
 		break;
@@ -225,6 +240,33 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
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
@@ -313,6 +355,7 @@ static const struct attribute_group max31856_group = {
 
 static const struct iio_info max31856_info = {
 	.read_raw = max31856_read_raw,
+	.write_raw = max31856_write_raw,
 	.attrs = &max31856_group,
 };
 
-- 
2.17.1

