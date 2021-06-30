Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352093B8195
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jun 2021 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhF3MG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3MGZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 08:06:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230DC061766
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 05:03:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so2908847eds.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGqfMLR1AMj29tMPKqbUUGw05oAykXOuNpPiQvs4AjI=;
        b=ny8ehxZdNZHCiNeSJf5TyJF2HdPeKNTIXbzHv6efvOvHjarKyeUrf41Pk+WqskwiQH
         VROciDUxRz6J8RNuboRe0XfBjl0JwzWoEFOOM2nQeaxJ/Aj5+J0DXZcUdD1NaLcKixwE
         InFwKmZnQI/PbG5x709d8XKhxSxkE9VZkb4TTNhvrGiKtywwyVIodcCuSfi0b38CbJQq
         0l48i4A7I/JmGPqKT1NWQovrMj4KRVVHVaEuexJ0cxjdcXChn0yI3PCGAQFacf3CCfeB
         1TWGrAu75OqfAOPMpHWwmFlGS0PmbLN3kCZYPyEsGQclNzYLX0jpMDbhp73IDqanw92B
         lJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGqfMLR1AMj29tMPKqbUUGw05oAykXOuNpPiQvs4AjI=;
        b=Lz8AtT7m+JWzPRxVLIlkiUOEuSuXa55WIL5NM2OstMtMcRY+cqLbFeBEpBSBXUIdhl
         YwweFPvQuVuL4lIxDC/JpYluws1I+NChrEJWh2Zrd5W8cm03dDT1fbmxe8Qvopyf/H3J
         Mn5H/+wqERJCeQTBov3S/8qJe4IiZf2OKmpDAyUb1FVsCeLeay2AZz4gU0eOO7Yf6MO9
         0hhcYj2jakzhMAmXF8vrvYd56f6aXC5a0sYQCrYfJR0cgPjem0BqASUgeLECzmk8feWA
         xeZvWvPLtfCogzpQMEd44V0INRU+33s/73KEnG/dZ86irEOZF20NPXN2wsPm8O204a+p
         eu2w==
X-Gm-Message-State: AOAM530vJqfb0WlsHK4sOa0ggY2VXhuyXRt5SGhXgM/R5uPM9vBihnxl
        gzQ9MY2+nditjAtR5SWx2h2NtHn+P22xXrbJ
X-Google-Smtp-Source: ABdhPJwRIbC5S4CIcN4ylAyrM7dbLOgsKBD7iZ7VpQ7wlD3Gm14TjOuP8G18kUI3YnNGz5PsE+2/Mg==
X-Received: by 2002:a50:ef09:: with SMTP id m9mr3392887eds.130.1625054635250;
        Wed, 30 Jun 2021 05:03:55 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id u21sm9405610eja.59.2021.06.30.05.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:03:54 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: accel: da311: convert probe to device-managed functions
Date:   Wed, 30 Jun 2021 15:03:38 +0300
Message-Id: <20210630120338.482426-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is another simple conversion to device-managed functions, requiring
the use of devm_iio_device_register() and moving the disabling of the
device on a devm_add_action_or_reset() hook.

The i2c_set_clientdata() can be removed, as the PM functions can work with
just the device object, to obtain the i2c_client object.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/da311.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 92593a1cd1aa..04e13487e706 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -212,6 +212,11 @@ static const struct iio_info da311_info = {
 	.read_raw	= da311_read_raw,
 };
 
+static void da311_disable(void *client)
+{
+	da311_enable(client, false);
+}
+
 static int da311_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -229,7 +234,6 @@ static int da311_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &da311_info;
 	indio_dev->name = "da311";
@@ -245,22 +249,11 @@ static int da311_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		da311_enable(client, false);
-	}
-
-	return ret;
-}
-
-static int da311_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, da311_disable, client);
+	if (ret)
+		return ret;
 
-	return da311_enable(client, false);
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -289,7 +282,6 @@ static struct i2c_driver da311_driver = {
 		.pm = &da311_pm_ops,
 	},
 	.probe		= da311_probe,
-	.remove		= da311_remove,
 	.id_table	= da311_i2c_id,
 };
 
-- 
2.31.1

