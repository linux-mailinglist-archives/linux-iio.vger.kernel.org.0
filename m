Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03E1A5FE6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgDLShh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLShh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 14:37:37 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5FC0A3BF0;
        Sun, 12 Apr 2020 11:37:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE19206E9;
        Sun, 12 Apr 2020 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586716657;
        bh=+4nGmS/2SoiWlHxBXiY+53betQazRPy4c45SXrQ0PSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWnDmj8xgsdmMQ+UlQdI90U5cWeh7IcuORT6yyISAA1PTR0tEpBpy86CyokkRi8cI
         GSPx2daG3B6Wx+hHhL4Lc5notaPTxcccQ2Lxp+pzCjWHu45GG2x3/HjJmubhh8DHiY
         tjO9YDa/BBJLlSR9bFMRTgUElxBpPdwPVZqPGoL0=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC sensor
Date:   Mon, 13 Apr 2020 00:06:58 +0530
Message-Id: <20200412183658.6755-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412183658.6755-1-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree OF match table support for CCS811 VOC sensor.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/chemical/ccs811.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 6cd92c49c348..313931208f61 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -24,6 +24,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #define CCS811_STATUS		0x00
 #define CCS811_MEAS_MODE	0x01
@@ -538,9 +539,16 @@ static const struct i2c_device_id ccs811_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ccs811_id);
 
+static const struct of_device_id ccs811_dt_ids[] = {
+	{ .compatible = "ams,ccs811" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
+
 static struct i2c_driver ccs811_driver = {
 	.driver = {
 		.name = "ccs811",
+		.of_match_table = of_match_ptr(ccs811_dt_ids),
 	},
 	.probe = ccs811_probe,
 	.remove = ccs811_remove,
-- 
2.17.1

