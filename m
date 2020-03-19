Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AD18ACA0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 07:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCSGHr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 02:07:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40199 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSGHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 02:07:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so594914plk.7;
        Wed, 18 Mar 2020 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=+2KAuRbCHFjdVsAIugVgzHXogj+I1RX4aDDbYGi4B8g=;
        b=WseahAeA87QIienqpmBo30l6efUR+0R6dpvRzdrVSewkXLfooA25wLzMsilWQcETjm
         6PLQro56I34pZJlxK/RMf7i9TJD8ylVOXqA/SvMWR4Inwv5V55FlLH+SiuZ2B8bE58p7
         OXloOqQxBKWH3y4UqU4QHkql88qSfk4XUVPX+wfygLKZobpLvHg+Fmw6sGwuPr1q0xhL
         CmkGWork/JR9usXA3MfAOk1T0nMDCoiHBqJUhQrBvd0vID0Xie2cfOJc5OnK3dlmHc7T
         /zCBjNMqwFiZCLP/JO3XAzkTPBtWdg8uV1SH+e7MiC6vEoC+YpLAh3h21qgxHxdJYhk9
         mp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=+2KAuRbCHFjdVsAIugVgzHXogj+I1RX4aDDbYGi4B8g=;
        b=SdPMRUWiTnECbZqJHttt0DR8jY4lEAjP8gZb2ukPKRKL1IRm8gGSB72kz35v7Sp5bA
         Vs3RwSrLAd/6O3h6cz9dVMHMELb2VBIAQDMqe4fsB2YIw9jRtVz6zUff1nogMCd2kYON
         sY1TxZHio7oKgT4QZbBUSOlCEWhNNWgVXyAdFplYr4y8ptIFkA9UNGNRHFbE0NPirji3
         dyUY+vjhgA9usaff6jWw+ZnsWewwLaA7ZsGkryIzuoNZC+xkXC1qhU/scBIMM0mQb9L8
         1MAITCI6B8W6rrk6eW4DOi040FTbEFXLFJ9D6lIzDrPls248RLuoYy6nd6q67xdzu1N7
         jc7Q==
X-Gm-Message-State: ANhLgQ3osSgvLY+WRqkXVK9kPHAYGVytlEkIGvSwB7fofM4QosXh4/yC
        I2GM9vcGp6c2nbT/n0xPpS7bSLWt5SU=
X-Google-Smtp-Source: ADFU+vtWp7i934vx1L84aHVsVMikSBxRJwdHutRfb316sKwixUiTwRNWBCSHz5z+LnPi2TgldTynHg==
X-Received: by 2002:a17:90a:2601:: with SMTP id l1mr2169816pje.74.1584598064293;
        Wed, 18 Mar 2020 23:07:44 -0700 (PDT)
Received: from SARKAR ([43.224.157.34])
        by smtp.gmail.com with ESMTPSA id r186sm936300pfc.181.2020.03.18.23.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 23:07:43 -0700 (PDT)
Message-ID: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
X-Google-Original-Message-ID: <20200319060739.GA22714@rohitsarkar5398@gmail.com>
Date:   Thu, 19 Mar 2020 11:37:39 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio debugfs interface provides direct access to read and write device
registers if debugfs is enabled.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 7cb9ff3d3e94..3f40db8ea9e2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1248,12 +1248,26 @@ static const struct attribute_group inv_attribute_group = {
 	.attrs = inv_attributes
 };
 
+static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
+				  unsigned int reg,
+				  unsigned int writeval,
+				  unsigned int *readval)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->map, reg, readval);
+	else
+		return regmap_write(st->map, reg, writeval);
+}
+
 static const struct iio_info mpu_info = {
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,
+	.debugfs_reg_access = &inv_mpu6050_reg_access
 };
 
 /**
-- 
2.23.0.385.gbc12974a89

