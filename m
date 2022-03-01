Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A924C9890
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiCAW4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 17:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiCAW4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 17:56:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2D79397;
        Tue,  1 Mar 2022 14:56:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p9so22854518wra.12;
        Tue, 01 Mar 2022 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3h0PpRGN1b9QtsJKwBnOzDweyLrjwadXEhG6ra676Q=;
        b=C56u2O0lqISECCr7dkelTEKdbtkZITES8pq8U2F2sP17bZKgjpd2jfZvwQZXnuD90t
         5I+IsGADkau80MuwA90njKYdOFGetr5O8mRO/iEFDRXVQdBF/Y5O6foqDq0YhsfEaDdT
         8uEs3Uc8ta792Nd7mG0feloLeWqQOWbRrfv9UY85U7ykb+Gl0oCxtwFRPDW/PQjpwctU
         CT6SRKg7fDQX0a30qHHNZDnaVP89eEQsmuVkIaB9O80qI99HxKQRluJF0v0+Ib9AnS3e
         fSWoil55qp86DWfn5Qn8gryPqmyGMd5HyKjRExQ86CA+vhMSQClUEH9pL+63/1GmGPNz
         4aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3h0PpRGN1b9QtsJKwBnOzDweyLrjwadXEhG6ra676Q=;
        b=fFUPtgjizUYB8/BaHmg/lnxP4xnol++l0CRujZPkc7y9Cqrpm8wgyUoZ5PGIM2tRxa
         NaTeyRtudC1irNGQZ/1jbgejwGabTiFl5JAH0akasInxD1Ql6uDH6oe3ijbvogwgzDwm
         9Y6F6sWl/Jh/VcZNthfb4A8ORq2bYgdZDLxcdF3LKGZH+7RcHGY5H6yZoQVD8MCSzUF3
         UQfZjEBf/I11Jp40/hlrxJ0yhNeNgIGnqL2GsFSXkTxCnYemp9o8EA+PQdBsAc0RRjJe
         Ko33+92Z0zhJqb1/FsXWX9mbti47Zu25RZitLgLzWoHsJRLKdaeI1Woir8hrPD7au3pU
         /6FQ==
X-Gm-Message-State: AOAM532M7fLGR0ON7/AuIB5yaVHR+9Lq6qKf1mu4uX9dzWg9lgtZQea6
        luNC/0kFEeRzhf0jlH4vPZfzQZWm3qM0apmK
X-Google-Smtp-Source: ABdhPJxEeEjQ3rLS9vFIha4EPgtwRtPHrbOTHsj9wYF+3n7Aw2fsG3SN6DvG/2ifC+UgxStMaP6FDw==
X-Received: by 2002:adf:ea44:0:b0:1ef:6f00:cf47 with SMTP id j4-20020adfea44000000b001ef6f00cf47mr17372976wrn.460.1646175363437;
        Tue, 01 Mar 2022 14:56:03 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm5314832wms.7.2022.03.01.14.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:56:03 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 3/3] iio: accel: add support for LIS302DL variant
Date:   Wed,  2 Mar 2022 00:54:32 +0200
Message-Id: <20220301225432.60844-4-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301225432.60844-1-absicsz@gmail.com>
References: <20220301225432.60844-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for STMicroelectronics LIS302DL accelerometer to the st_accel
framework.

https://www.st.com/resource/en/datasheet/lis302dl.pdf

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/iio/accel/st_accel.h      | 1 +
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 969cc7faca07..0e79dc100ce5 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -36,6 +36,7 @@
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
+#define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
 
 #ifdef CONFIG_IIO_BUFFER
 int st_accel_allocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..2a353c51c84a 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -444,6 +444,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS331DL_ACCEL_DEV_NAME,
+			[1] = LIS302DL_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0ce78eebad9..086e8af89e18 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -107,6 +107,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2hh12",
 		.data = LIS2HH12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis302dl",
+		.data = LIS302DL_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -142,6 +146,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
+	{ LIS302DL_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-- 
2.35.1

