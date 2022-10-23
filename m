Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79741609391
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJWNXf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222F6FA04
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawb-00070f-DX; Sun, 23 Oct 2022 15:23:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawa-000yhg-6w; Sun, 23 Oct 2022 15:23:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawZ-00A3S0-CG; Sun, 23 Oct 2022 15:23:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 23/23] iio: accel: vl6180: Convert to i2c's .probe_new()
Date:   Sun, 23 Oct 2022 15:23:02 +0200
Message-Id: <20221023132302.911644-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Pyu9GPUX2p9YWM1nkSwKN+ShPzYSjJx9ergRFEi7B7A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT+dqWlN2K2zsUAeYOAo3+VSnx7CKBDCQ2g93GI1 ihfy4bWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/nQAKCRDB/BR4rcrsCbhqB/ sHNs3S7+u3SEc50404NJKULsWhqCsaBSXf8mA1rIUoNCgTH5W1i50jol9VXyT+ZFZOdMnCNKh0wLC2 HkasqI/Nvwu3WlIro4rP5BefvX0dP01fMu9DY7p9eOobT7bvZPwA5VfXx4XavukiRP56BpBCXAC6YT dOYp3uH1TBsuIfzZhcmpbVLnbVJSbJQy7pVoJ+VnsJfMAMJ72KVJI7SvQoq9/apUoNE1fENwR9p7kL R08K+z3iWXfOldm+UNlvC2hffO8dQoRqvUsjlsoUq18r0Mt3r12D3/KO/U8X7ST16BjWS3Bq4NtFQb Xusxz/D8ohRjuchK9K1/M6oIhuo/tt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/vl6180.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index d47a4f6f4e87..8b56df26c59e 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -493,8 +493,7 @@ static int vl6180_init(struct vl6180_data *data)
 	return vl6180_hold(data, false);
 }
 
-static int vl6180_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int vl6180_probe(struct i2c_client *client)
 {
 	struct vl6180_data *data;
 	struct iio_dev *indio_dev;
@@ -539,7 +538,7 @@ static struct i2c_driver vl6180_driver = {
 		.name   = VL6180_DRV_NAME,
 		.of_match_table = vl6180_of_match,
 	},
-	.probe  = vl6180_probe,
+	.probe_new = vl6180_probe,
 	.id_table = vl6180_id,
 };
 
-- 
2.37.2

