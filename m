Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02925230D62
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgG1POL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgG1PNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300ACC0619D9
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:18 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so16459792ilk.5
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8BLZMzA+ROESYBLDJPQNqdkwcaC9Aplp9oQfc1AvvU=;
        b=kNwnsSnjzw3GS/T34EFdhzO/5dv9m35wRnd4ukW+2NNL2zPTwIs+axO3N7H9ePHoc4
         xR/QkOG5nIsWmTlfnCmKRwE266q7wtJsvZyXOPX5W4jgL8qAJM7/Te6Cr0SJfR+KRtX5
         40M6FL0kNyriRzsn0IMGNC2zQbl8PbnAk+mOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8BLZMzA+ROESYBLDJPQNqdkwcaC9Aplp9oQfc1AvvU=;
        b=oRIJ+1hsitljeYottjDbkm8EFytAcTv7GsYDfcnBW7LXYtrnWBihnxAvB4HQ02WnXk
         2+744zb/DHpkuq3OOR7fdGfcbFSfPSekjDD6EkNci5XN5JBWmHNVt6wEc25m88ovduLM
         Rkrn/DLcYSSTbk3aIJbhJPAQHybbhvPDtmRPWfSDdkVDDPOERYuGe9GHdwCKtD6GkmLG
         LtHr67wxlqgpgv6hhGSb25+GVgzAKiPSVSD9ZWekCg5oCBvQakv+yFY1sZ4uTvHkaOoJ
         Fe6r89S69WXki+R11FGMZZfKwG2grqfNi4KDS5CPXMCRVBKrdIjRyIMwvwRh/olcjhAo
         Metw==
X-Gm-Message-State: AOAM530nANADC7OT9Vay2hmwjnuEMv9RSUzMIcGBS27ElT7lohs5vPBg
        V2BAF3DHpTHp1x0TlNqvyvHgRA==
X-Google-Smtp-Source: ABdhPJwCeImWtRTvcIL1MrXSvzfCaWV+TydneoD9Ux6DY8eVfPmskXiyrnxLJPbrlik2TpFYrQhBgA==
X-Received: by 2002:a92:d444:: with SMTP id r4mr7018829ilm.63.1595949197603;
        Tue, 28 Jul 2020 08:13:17 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:17 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 05/15] iio: sx9310: Change from .probe to .probe_new
Date:   Tue, 28 Jul 2020 09:12:48 -0600
Message-Id: <20200728091057.5.I0ea31fe183b99838b28213df05b0e7912db3ba29@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Uses .probe_new in place of .probe. Also uses device_get_match_data()
for whoami matching.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 37 ++++++++++++----------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0fb88ad66f7342..de52afd7c13333 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -138,7 +138,7 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned int chan_read, chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
-	int whoami;
+	unsigned int whoami;
 };
 
 static const struct iio_event_spec sx9310_events[] = {
@@ -859,24 +859,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
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
+		dev_err(dev, "WHOAMI does not match device data: %u", whoami);
 		return -ENODEV;
+	}
 
 	switch (whoami) {
 	case SX9310_WHOAMI_VALUE:
@@ -893,8 +884,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
-static int sx9310_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -920,8 +910,7 @@ static int sx9310_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
-					data->whoami);
+	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
 	if (ret < 0)
 		return ret;
 
@@ -1034,8 +1023,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
-	{ .compatible = "semtech,sx9310" },
-	{ .compatible = "semtech,sx9311" },
+	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
@@ -1054,7 +1043,7 @@ static struct i2c_driver sx9310_driver = {
 		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
-	.probe		= sx9310_probe,
+	.probe_new	= sx9310_probe,
 	.id_table	= sx9310_id,
 };
 module_i2c_driver(sx9310_driver);
-- 
2.28.0.rc0.142.g3c755180ce-goog

