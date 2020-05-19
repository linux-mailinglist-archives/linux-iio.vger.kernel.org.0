Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637951D907A
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgESG6m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESG6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 02:58:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF962C061A0C;
        Mon, 18 May 2020 23:58:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so14534134wra.7;
        Mon, 18 May 2020 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VDmyzrySD4Ps31eGi/jgnHCXsN6EThrf0g6khOYg/JA=;
        b=O59a8tWIvaWSO7HtdqtunTf7+/K5LaFq+VdCrxMS6b53oKh0BLDN5J59TBRs/d8Kdf
         JCLzm73uJz38sMPsWJP7eZSlaGPV9b7Q0OvjdUloCD/y0Ezt3lAhMJADf3jYvoea2ENx
         ctzn791eqzvOIXTuPVy1JSRsj25fuoJK9DMms6zJ9cwC2J2U+HLlCrntW66DvOB5HJfv
         fEwZSQcRskrh0AD1TAk1H3bcP5vwKyySbD5zromoFzBHKj/ZUosrvpZnDDTHujWi+OQR
         2ag6R4CAWOMNM93cUOx+zyRS5JdMDrFrhf0liWG0uJOpoWvKXGS3Ml7VjBARRqaTlvvg
         GIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VDmyzrySD4Ps31eGi/jgnHCXsN6EThrf0g6khOYg/JA=;
        b=aWvVTj5vxXfW9EKigobvzOehmJUfhB1o+B/mTaRtemcFu3v1QXdI1xCiLsZtP/K1Ny
         OmLrCpg/czj+vO1V3los4W9QtCzutJ97HpEWcYQ3Bx3lqT5BdD0f92jkuDNYvfrRG1rZ
         zNptYypWkSfsUnBUgkpihARG88eAlxPQfpuY+WU5Ie+EMOuhYs9nlo7HdR0hx3Q9QkS8
         aLDxGs/SWzwdOlZaocQp5bFL16X2cuhMQZyx4vvBu8F2mPs9kLUs6hDBlyUVIMr3SZV9
         LFf+Z9Vr4w9ml3i/IhS1CxFMptWwlV9hoaPIWAEOfEof8xxg1dG1Bz/X7lubL1QMlKUf
         Tu6w==
X-Gm-Message-State: AOAM532GCR4xuWGzxGsYW2SCRmj3HIXcZaL4DDIunM52QQTe2AVIG4Tr
        SyZdTh25yhl6RuYJ1xqafLAnY6TayvsGGg==
X-Google-Smtp-Source: ABdhPJwwRa+ZKzjAn8nODGSc7yyEzdFyLKC/+Nuye0maZqgeufwZYQnzOfJck2YEm1F2QAz/G5bdDQ==
X-Received: by 2002:adf:f783:: with SMTP id q3mr23694885wrp.348.1589871519170;
        Mon, 18 May 2020 23:58:39 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id p7sm2597550wmc.24.2020.05.18.23.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:58:38 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: [PATCH v2 3/3] iio: magnetometer: ak8975: Add gpio reset support
Date:   Tue, 19 May 2020 08:57:43 +0200
Message-Id: <20200519065749.4624-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to AK09911 datasheet, if reset gpio is provided then 
deassert reset on ak8975_power_on and assert reset on ak8975_power_off.

Without reset's deassertion during ak8975_power_on, driver's probe fails on
ak8975_who_i_am while checking for device identity for AK09911 chip

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..84dea520db02 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -358,6 +358,7 @@ struct ak8975_data {
 	u8			asa[3];
 	long			raw_to_gauss[3];
 	struct gpio_desc	*eoc_gpiod;
+	struct gpio_desc	*reset_gpiod;
 	int			eoc_irq;
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
@@ -384,10 +385,13 @@ static int ak8975_power_on(const struct ak8975_data *data)
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
+
+	gpiod_set_value_cansleep(data->reset_gpiod, 0);
+
 	/*
-	 * According to the datasheet the power supply rise time i 200us
+	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
-	 * total 300 us. Add some margin and say minimum 500us here.
+	 * total 300us. Add some margin and say minimum 500us here.
 	 */
 	usleep_range(500, 1000);
 	return 0;
@@ -396,6 +400,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 /* Disable attached power regulator if any. */
 static void ak8975_power_off(const struct ak8975_data *data)
 {
+	gpiod_set_value_cansleep(data->reset_gpiod, 1);
+
 	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
 }
@@ -839,6 +845,7 @@ static int ak8975_probe(struct i2c_client *client,
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
+	struct gpio_desc *reset_gpiod;
 	const void *match;
 	unsigned int i;
 	int err;
@@ -856,6 +863,16 @@ static int ak8975_probe(struct i2c_client *client,
 	if (eoc_gpiod)
 		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
+	/*
+	 * According to AK09911 datasheet, if reset gpio is provided then
+	 * deassert reset on ak8975_power_on and assert reset on
+	 * ak8975_power_off.
+	 */
+	reset_gpiod = devm_gpiod_get_optional(&client->dev,
+					      "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod))
+		return PTR_ERR(reset_gpiod);
+
 	/* Register with IIO */
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->eoc_gpiod = eoc_gpiod;
+	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
 	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
-- 
2.17.1

