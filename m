Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACDD78133A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbjHRTIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjHRTI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 15:08:27 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716DF359D;
        Fri, 18 Aug 2023 12:08:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="173297854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2023 04:08:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EB0FF4001DC4;
        Sat, 19 Aug 2023 04:08:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] iio: pressure: ms5637: Use i2c_get_match_data()
Date:   Fri, 18 Aug 2023 20:08:19 +0100
Message-Id: <20230818190819.339020-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace device_get_match_data() and id lookup for retrieving match data
by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1->v2:
 * Added Rb tag from Andy
 * Drooped id variable removal from commit description.
---
 drivers/iio/pressure/ms5637.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 9b3abffb724b..ac30d76285d1 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -144,7 +144,6 @@ static const struct iio_info ms5637_info = {
 
 static int ms5637_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct ms_tp_data *data;
 	struct ms_tp_dev *dev_data;
 	struct iio_dev *indio_dev;
@@ -159,10 +158,7 @@ static int ms5637_probe(struct i2c_client *client)
 		return -EOPNOTSUPP;
 	}
 
-	if (id)
-		data = (const struct ms_tp_data *)id->driver_data;
-	else
-		data = device_get_match_data(&client->dev);
+	data = i2c_get_match_data(client);
 	if (!data)
 		return -EINVAL;
 
-- 
2.25.1

