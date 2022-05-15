Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA65B5278AB
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiEOQAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiEOQAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5515FE3
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGez-0001DR-2v; Sun, 15 May 2022 17:59:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGey-002V37-Ng; Sun, 15 May 2022 17:59:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGew-009uG1-EG; Sun, 15 May 2022 17:59:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/8] iio:chemical:atlas: Improve error reporting for problems during .remove()
Date:   Sun, 15 May 2022 17:59:24 +0200
Message-Id: <20220515155929.338656-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; h=from:subject; bh=fA1+FAIBHgw7zXaewwD+Dy2jNBzBzvYKbbXo+d8uLJo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSMzvYAZvfuqKpnG5Xnn4a+b5jSqX5waN8ADthT1 NDjT0qiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjMwAKCRDB/BR4rcrsCWG0B/ sGUca3Ikt61nMb3y9jXqyJr3JIgDM3hL0GreNIGUMiWRzIwa4NL7IhDRp4ur2s7F/B7BQIndyQTj6u 2vYMQbKH9X7SWMYHHVf/0HACd4hXUckgFtpDzUOPsyXLXKAfzviu5JBjhHoRpmMKElloBgA514HhB5 /CHocGkWCDg1JraK06WkhSYDCwyRxnP8udbBT4HM/EoicUXPmRIevlBkJJsXDvdCi+n6SCXLfwv8+K 14DcGuLjUls25twpQPoI85omMlSp3rqxiAQO5vlaCwmQcOj+tmUJlWx0cixuOtEEofE0TcLtg/quFc RjitRst40pDnLyCWvUIdJirKo/iFYw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Returning an error value in an i2c remove callback results in a generic
error message being emitted by the i2c core, but otherwise it doesn't
make a difference. The device goes away anyhow and the devm cleanups are
called.

So instead of triggering the generic i2c error message, emit a more
helpful message if a problem occurs and return 0 to suppress the generic
message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/chemical/atlas-sensor.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 56dea9734c8d..8378c00fa2ff 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -726,6 +726,7 @@ static int atlas_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct atlas_data *data = iio_priv(indio_dev);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -734,7 +735,12 @@ static int atlas_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	return atlas_set_powermode(data, 0);
+	ret = atlas_set_powermode(data, 0);
+	if (ret)
+		dev_err(&client->dev, "Failed to power down device (%pe)\n",
+			ERR_PTR(ret));
+
+	return 0;
 }
 
 static int atlas_runtime_suspend(struct device *dev)
-- 
2.35.1

