Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02A223161A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 01:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgG1XGd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgG1XFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB275C0619DD
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q75so14421360iod.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFwKpOolil2cigK/Fi3S/MPo2NhowXWtQj+GOyuNS/c=;
        b=TKT5aUTJuFr6UoNYj4eTsHJGVckWaAjBanjyOyARCuOJnTfFVXPP4wufGorg5KdMu3
         xGt6iqRvYVZAu/0e9aXOA0caHT8zPr4guxMP9L0qULqwu8I9qgmnTXMhvVE0h3jAC74K
         FJUvG+4VEXa3IR2FXFifykWWs28pVkTdavucw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFwKpOolil2cigK/Fi3S/MPo2NhowXWtQj+GOyuNS/c=;
        b=CYsxUJljB4C7Nh6wKvM4mF748rq1Arv8/8S4b87JU3IcuqAr4qaY8vRO/ffxL5zeKH
         K8OGW2BJz/ohB6rlE2Sw1dVkhcxu+tMG5adlFVySVlsr0g+jWEwQsJjLdPOh5TWUJshW
         1w7qJe1A8ADWDY0hm+cl8C9umzPh+0QJ59icQ7hmKeuVlN5CvHWtYm/+KXfERjec95hH
         JyS5eTKeTQZ6CnnRoOS3orXiDUg6QHjBC9vBdWRUy8jwV1WhVcZk3FIY2eZP+7+ThU9d
         MFPcJlFjSQ22jx7cWHN6raOeAnQSEpeZ1JvWWKqriEfu8YkxJVUZKlrehKbjF7QISvLU
         pnYQ==
X-Gm-Message-State: AOAM530VRBhXYW6iUFadSW8mmK0rRzg+xUo+hZV9H3/tzANwH8tARb4z
        q1q6PyOw7a1ofNIFdrUz9NPpeQ==
X-Google-Smtp-Source: ABdhPJw3oJB71OoukounwSSpOZX9IysvOrjvnrfFdWaactsDXxmWmMqPd90CoQ6uWvd+N+teRdhMPw==
X-Received: by 2002:a5d:9b86:: with SMTP id r6mr11454618iom.44.1595977539055;
        Tue, 28 Jul 2020 16:05:39 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:38 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 05/14] iio: sx9310: Change from .probe to .probe_new
Date:   Tue, 28 Jul 2020 17:05:11 -0600
Message-Id: <20200728170317.v2.5.Ieb5fdf7381764835dad0b3099c7b19ba754e4c47@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Uses .probe_new in place of .probe. Also uses device_get_match_data()
for whoami matching.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 04b646ae8a1009..bb007673f758d5 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -139,7 +139,7 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned int chan_read, chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
-	int whoami;
+	unsigned int whoami;
 };
 
 static const struct iio_event_spec sx9310_events[] = {
@@ -860,24 +860,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 static int sx9310_set_indio_dev_name(struct device *dev,
 				     struct iio_dev *indio_dev,
-				     const struct i2c_device_id *id, int whoami)
+				     unsigned int whoami)
 {
-	const struct acpi_device_id *acpi_id;
-
-	/* id will be NULL when enumerated via ACPI */
-	if (id) {
-		if (id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
-				id->name);
-	} else if (ACPI_HANDLE(dev)) {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id)
-			return -ENODEV;
-		if (acpi_id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
-				acpi_id->id);
-	} else
+	unsigned int long ddata;
+
+	ddata = (uintptr_t)device_get_match_data(dev);
+	if (ddata != whoami) {
+		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
 		return -ENODEV;
+	}
 
 	switch (whoami) {
 	case SX9310_WHOAMI_VALUE:
@@ -887,15 +878,14 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 		indio_dev->name = "sx9311";
 		break;
 	default:
-		dev_err(dev, "unexpected WHOAMI response: %u", whoami);
+		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
 		return -ENODEV;
 	}
 
 	return 0;
 }
 
-static int sx9310_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -921,8 +911,7 @@ static int sx9310_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
-					data->whoami);
+	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
 	if (ret < 0)
 		return ret;
 
@@ -1035,8 +1024,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
-	{ .compatible = "semtech,sx9310" },
-	{ .compatible = "semtech,sx9311" },
+	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
@@ -1055,7 +1044,7 @@ static struct i2c_driver sx9310_driver = {
 		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
-	.probe		= sx9310_probe,
+	.probe_new	= sx9310_probe,
 	.id_table	= sx9310_id,
 };
 module_i2c_driver(sx9310_driver);
-- 
2.28.0.163.g6104cc2f0b6-goog

