Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE77515B61
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiD3ITn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiD3ITn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854F69CD1
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0001IK-45; Sat, 30 Apr 2022 10:16:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0066Xz-Gc; Sat, 30 Apr 2022 10:16:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGy-006aye-Bu; Sat, 30 Apr 2022 10:16:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/9] iio:accel:mc3230: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:15:59 +0200
Message-Id: <20220430081607.15078-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; h=from:subject; bh=LJoCLmxjL4bK/cGKmO7RRF+EN+0cBPKoNge1ip1xHJc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPAkxD5Hi/0nuR6hBZwLN48uys859V7M4EXKOi3h DK2YXZ6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwJAAKCRDB/BR4rcrsCQ5NB/ 93n9cy6Gb5pq69L70Yr2esmU8m336amr3Qw69TLEdUJg+xeod4KRe52PXaOb8k4uNsN59MP7DQEbmI jgGVH2S+bEqcU1wiJ01L7aLPLgUug+6fKtbQl1KMbtlCYSVUIMtS2WvhE82/Zp4PViWzxAMb2Ko9O1 67t0EHIzGvzVquFD8jDB5Ni2r+/zFdanGB1NpO/3vBsCMXYUXaqL9g1RDKjw1mPhcHTIQmQXhRRWRR uYPoTwKuHItGrbsx5YIkHpjAlilcXD8bkpDvaZlcK9aUdcwiUPNdGNXFyRlPxuVDQLjx85P05FmdTY cPCPLDT88kYooUy/Qml1azGqEUvBTY
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

Returning an error value in an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference. The device goes away anyhow and the devm cleanups are
called.

As mc3230_set_opcon() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/mc3230.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 679e69cd7657..c15d16e7f1da 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -157,7 +157,9 @@ static int mc3230_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
+	mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
+
+	return 0;
 }
 
 static int mc3230_suspend(struct device *dev)
-- 
2.35.1

