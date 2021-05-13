Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD87A37F7E2
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhEMM0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhEMM0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:26:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4321C0613ED
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:25:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id df21so3522533edb.3
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpZpdAO1/PMI+7gumAxN/U6hYQSLUF5PVsfG5cbqn/k=;
        b=V4WRwq8AczyqxazVuYZ5e4aAr/xAe1sdntbER5nBnMoPBY9hKDzzdcqJh4LejggFaX
         00SjUtRlLaAPZLqOwwVokb3fj2ML/OGxrUKAIVOZjaiLRCQI1wjrim4woUZ8tjyiDrR0
         rRqfw1CNtBQGx5/0qtmz19UdAbTlAknZ3syssxfaKSJcd0S2ytLgQBCBgbgqztCaYNOv
         A4nIhSdcW+5LdnTsXzVUivwYWnVDdWCQoQcn2fifQ0vAS6xSXs5luop9blwrnBdULgwy
         5wD4vc3S+qjtuDVlTt1SnkZbJheizyiVfoFNMv05wlBMTaxXurT1v1n2lYmKJljSq3z7
         3V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpZpdAO1/PMI+7gumAxN/U6hYQSLUF5PVsfG5cbqn/k=;
        b=MA6wSx36e2WM2AFmyinNLJOcpGFsqJAHgiI665vqn5AITMSX6fIUnbQ/m/QY/kgnIw
         qbRDyFJV+kw3A9wK3HJ+zAUVB5ettxdvg1L3EuamBZBxmiKFMn2AK6CJp4XpRdeFhW38
         az8aHR2/iibWJqcTAOMkDTHSGNsTDEtsWzmqaGKnFjB84Ew5YUN4HSxq04lKz1H2rYpk
         1XaJkSo8e0k0fozGZ52hG3QnOH4uGeIqR+vMsSdkWCSfxfl//ttW2jJFeuPucGTsHOUh
         TV8M/UlIPiJLMq5aeXiuv7RBVGqbAYfuAoKG18q5CG+fioZBy0DG7zJ9olGILX7bww/K
         aKbQ==
X-Gm-Message-State: AOAM533SkagIpJgkmx8w5rH1xSrnveRSLjvWL4svJMHqfYwvYZe1i8Qg
        9bFd4JlEApg/O3IKpnPQ5fKqvrYM+O6Zw2+TwhM=
X-Google-Smtp-Source: ABdhPJzKJg6HadllfR6s9RpfDpBd8peDnG8G7vova3n0iOMy1YUzfrWf35J1H6+0oDFNEZ5wu0AeyQ==
X-Received: by 2002:a50:fd14:: with SMTP id i20mr5444456eds.60.1620908716168;
        Thu, 13 May 2021 05:25:16 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id e23sm964211edr.80.2021.05.13.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:25:15 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, nuno.sa@analog.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: imu: remove unused private data assigned with spi_set_drvdata()
Date:   Thu, 13 May 2021 15:25:12 +0300
Message-Id: <20210513122512.93187-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These were usually used before the conversion to devm_ functions, so that
the remove hook would be able to retrieve the pointer and do cleanups on
remove.
When the conversion happened, they should have been removed, but were
omitted.

Some drivers were copied from drivers that fit the criteria described
above. In any case, in order to prevent more drivers from being used as
example (and have spi_set_drvdata() needlessly set), this change removes it
from the IIO IMU group.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/imu/adis16400.c | 2 --
 drivers/iio/imu/adis16460.c | 2 --
 drivers/iio/imu/adis16475.c | 1 -
 drivers/iio/imu/adis16480.c | 2 --
 4 files changed, 7 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cb8d3ffab6fc..109b2360a54e 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1164,8 +1164,6 @@ static int adis16400_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	/* setup the industrialio driver allocated elements */
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 73bf45e859b8..068d98780383 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -388,8 +388,6 @@ static int adis16460_probe(struct spi_device *spi)
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st = iio_priv(indio_dev);
 
 	st->chip_info = &adis16460_chip_info;
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 5654c0c15426..90aec3c9dbcb 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1329,7 +1329,6 @@ static int adis16475_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
 
 	st->info = device_get_match_data(&spi->dev);
 	if (!st->info)
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index f81b86690b76..c7dd1150780d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1279,8 +1279,6 @@ static int adis16480_probe(struct spi_device *spi)
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st = iio_priv(indio_dev);
 
 	st->chip_info = &adis16480_chip_info[id->driver_data];
-- 
2.31.1

