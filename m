Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA6234977
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgGaQtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbgGaQtD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373ACC0617A1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q75so24133540iod.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3XXXr/NVFbGCC1s552cmz/bn1PN5K8vbmeSX/RmmQA=;
        b=jYHgiVLGCivn2lpFjTjutITT5r7/YUbo907n+JTdEXyCb1Oi7qDGABbh+LqutCFSbe
         5fxC//D/hHepp1hReEI1Nf89X0dMpGjgTSevMXhE+iChXZubvfni9nOCfIOOVfMQd27T
         6h0FxaFlLhUyZDs/P0eAX0WuCl4P5sTHz5EqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3XXXr/NVFbGCC1s552cmz/bn1PN5K8vbmeSX/RmmQA=;
        b=nyq1D3Bj4G2vNoAh2NOdgy4uZE/hGW2BHSzG5f1WKovhX253j8Wbcl9VEO63WpBTXL
         SA1fNBhB/2qHV2XTmbouBmMffgAE9Ta7g1ThjRqSVruHi9k+0/hDZ8AOyciqOXrFyYuJ
         gG4/yv8tUEfmr9sTgYhwu3J2gMAhEkjXZQdikHRNxf9bhUco4Sv/aBNrIwyx91VxdI1U
         B8DF8y+DpvuZQ8rK2FQRNiG04Tgtu/Q6n7rMBW3u8yRqeZAFAzxfoMp+8LJFW24JY4rd
         1fuEbOv8P7CMvuYOHZi+uCtdEOP9WIbBB9Kdu0mAJ2IGRTwNip8DG3gC3tOdqxI4VkZw
         /AKQ==
X-Gm-Message-State: AOAM530GKrpDNLibx4heewEKRdVrq39Rm/V5ytyQuYabZcYvTXqx5hqw
        OFDei5JJgq3YYQ6FF39bw9apNA==
X-Google-Smtp-Source: ABdhPJwMh/TdbR8qXBpIumlJzrxe6FttNGIgLCMSpknQ3wVnexGeXAtyJY4eUK8Q3sCnzSttkAEDww==
X-Received: by 2002:a02:2445:: with SMTP id q5mr6101205jae.104.1596214142669;
        Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:02 -0700 (PDT)
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
Subject: [PATCH v3 05/15] iio: sx9310: Change from .probe to .probe_new
Date:   Fri, 31 Jul 2020 10:48:42 -0600
Message-Id: <20200731104555.v3.5.Ieb5fdf7381764835dad0b3099c7b19ba754e4c47@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
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

Changes in v3: None
Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 66f7050d63ae97..2ed062d01634bc 100644
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
@@ -861,24 +861,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
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
@@ -888,15 +879,14 @@ static int sx9310_set_indio_dev_name(struct device *dev,
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
@@ -922,8 +912,7 @@ static int sx9310_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
-					data->whoami);
+	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
 	if (ret < 0)
 		return ret;
 
@@ -1036,8 +1025,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
-	{ .compatible = "semtech,sx9310" },
-	{ .compatible = "semtech,sx9311" },
+	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
@@ -1056,7 +1045,7 @@ static struct i2c_driver sx9310_driver = {
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

