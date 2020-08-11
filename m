Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5D24156E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 05:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHKDsR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 23:48:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41374 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgHKDsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 23:48:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 10EE820072D;
        Tue, 11 Aug 2020 05:48:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5219E200729;
        Tue, 11 Aug 2020 05:48:10 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D4F8402EB;
        Tue, 11 Aug 2020 05:48:05 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        hslester96@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] iio: magnetometer: mag3110: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 11:43:16 +0800
Message-Id: <1597117396-2894-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
References: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/iio/magnetometer/mag3110.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 4d305a2..838b13c 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -476,22 +476,14 @@ static int mag3110_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 
 	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd_reg)) {
-		if (PTR_ERR(data->vdd_reg) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(&client->dev, "failed to get VDD regulator!\n");
-		return PTR_ERR(data->vdd_reg);
-	}
+	if (IS_ERR(data->vdd_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
+				     "failed to get VDD regulator!\n");
 
 	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
-	if (IS_ERR(data->vddio_reg)) {
-		if (PTR_ERR(data->vddio_reg) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(&client->dev, "failed to get VDDIO regulator!\n");
-		return PTR_ERR(data->vddio_reg);
-	}
+	if (IS_ERR(data->vddio_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
+				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
 	if (ret) {
-- 
2.7.4

