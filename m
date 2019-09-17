Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC5B50CE
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfIQO4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 10:56:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfIQO4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 10:56:47 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEuG-0007Oq-Gf; Tue, 17 Sep 2019 16:56:40 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEuE-0007Jt-Jv; Tue, 17 Sep 2019 16:56:38 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, angus@akkea.ca,
        tomas@novotny.cz
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] iio: light: fix vcnl4000 devicetree hooks
Date:   Tue, 17 Sep 2019 16:56:36 +0200
Message-Id: <20190917145637.22605-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since commit ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
the of_match_table is supported but the data shouldn't be a string.
Instead it shall be one of 'enum vcnl4000_device_ids'. Also the matching
logic for the vcnl4020 was wrong. Since the data retrieve mechanism is
still based on the i2c_device_id no failures did appeared till now.

Fixes: ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/iio/light/vcnl4000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 51421ac32517..f522cb863e8c 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -398,19 +398,19 @@ static int vcnl4000_probe(struct i2c_client *client,
 static const struct of_device_id vcnl_4000_of_match[] = {
 	{
 		.compatible = "vishay,vcnl4000",
-		.data = "VCNL4000",
+		.data = (void *)VCNL4000,
 	},
 	{
 		.compatible = "vishay,vcnl4010",
-		.data = "VCNL4010",
+		.data = (void *)VCNL4010,
 	},
 	{
-		.compatible = "vishay,vcnl4010",
-		.data = "VCNL4020",
+		.compatible = "vishay,vcnl4020",
+		.data = (void *)VCNL4010,
 	},
 	{
 		.compatible = "vishay,vcnl4200",
-		.data = "VCNL4200",
+		.data = (void *)VCNL4200,
 	},
 	{},
 };
-- 
2.20.1

