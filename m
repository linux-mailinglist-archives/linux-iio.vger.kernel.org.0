Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E252733DB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUUtq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 16:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIUUtq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 16:49:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25892216C4;
        Mon, 21 Sep 2020 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721385;
        bh=A0nup3Z1bLwO1gwJ+cXZYwovnnrdgdFmS3icDXQ1bU0=;
        h=From:To:Cc:Subject:Date:From;
        b=0NX1aegjeIrleMvg63bVG4U3kIpITJ21qXGxQIUIFW6vlD8ojXxgESO5j0E8XNCom
         cVeSDnPMfCHmpNW3iWiLQxztlXN2uthL6ABW7EOxYbOf66S+EW0nr//aFkcVmvWlws
         cyHTgS+8q81kizLTlwTY2XGQxs4PhrCn3DqCBqP4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] iio: ssp: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:39 +0200
Message-Id: <20200921204939.20341-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use PLATFORM_DEVID_NONE define instead of "-1" value because:
 - it brings some meaning,
 - it might point attention why auto device ID was not used.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index a94dbcf491ce..1aee87100038 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -503,7 +503,8 @@ static int ssp_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(&spi->dev, -1, sensorhub_sensor_devs,
+	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
+			      sensorhub_sensor_devs,
 			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "mfd add devices fail\n");
-- 
2.17.1

