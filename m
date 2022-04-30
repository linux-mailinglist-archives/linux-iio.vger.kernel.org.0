Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE7515B65
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiD3ITp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiD3ITo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 04:19:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D369CC4
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 01:16:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH3-0001IL-1j; Sat, 30 Apr 2022 10:16:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiH0-0066Y3-JU; Sat, 30 Apr 2022 10:16:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nkiGy-006ayb-6T; Sat, 30 Apr 2022 10:16:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jiri Valek - 2N <valek@2n.cz>,
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH 0/9] iio: Remove duplicated error reporting in .remove()
Date:   Sat, 30 Apr 2022 10:15:58 +0200
Message-Id: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; h=from:subject; bh=udNsicR8X7Sq9yO6AIy+zCoB3QapyM2GDUPSBP30HBc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBibPAgQlrvcqGv7mwfO8VLPNApITWNlgronwz6umGE 2E4l9bqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmzwIAAKCRDB/BR4rcrsCTqXB/ 993YxXzzyK41/M7p5ZQnr96MdQO55iDZjkZd7Ejlp1MabTZ3RRRiVhYH6o53SgeZfxfVE10R36S+eh A18f9wO+JyMckzPEsZidc96F8HY5rFT/Y4CdxaGUdXUGuOUpHI8k7PVVoYvUnSH7ItcFscTmNkDMxW 7+nN36FApPwonpmX3vHNvLXyv+eMpEbtzUuWUsJYBdFTOV5AzlcuOv2ZuBwtvircCTWS1ipaK6O3dw AZoRE58WgKX73T7ZWk3jINk3ZBBBTWaps636pfw/uHnmwfjbwIWzz3/LVv6dENAAVju/2cgjNySehr daRqkxmZBMRlK1AhrlnE+DgvGjp1nH
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

Hello,

this series adapts several i2c drivers that emit two error messages if
something in their remove function fails. The relevant issue is that the
i2c core emits an error message if the remove callback returns a
non-zero value but the drivers already emit a (better) message. So
these patches change the drivers to return 0 even after an error. Note
there is no further error handling in the i2c core, if a remove callback
returns an error code, the device is removed anyhow, so the only effect
of making the return value zero is that the error message is suppressed.

The motivation for this series is to eventually change the prototype of
the i2c remove callback to return void. As a preparation all remove
functions should return 0 such that changing the prototype doesn't
change behaviour of individual drivers.

Best regards
Uwe

Uwe Kleine-König (9):
  iio:accel:mc3230: Remove duplicated error reporting in .remove()
  iio:accel:stk8312: Remove duplicated error reporting in .remove()
  iio:accel:stk8ba50: Remove duplicated error reporting in .remove()
  iio:light:bh1780: Remove duplicated error reporting in .remove()
  iio:light:isl29028: Remove duplicated error reporting in .remove()
  iio:light:jsa1212: Remove duplicated error reporting in .remove()
  iio:light:opt3001: Remove duplicated error reporting in .remove()
  iio:light:stk3310: Remove duplicated error reporting in .remove()
  iio:light:tsl2583: Remove duplicated error reporting in .remove()

 drivers/iio/accel/mc3230.c   | 4 +++-
 drivers/iio/accel/stk8312.c  | 4 +++-
 drivers/iio/accel/stk8ba50.c | 4 +++-
 drivers/iio/light/bh1780.c   | 7 +++----
 drivers/iio/light/isl29028.c | 4 +++-
 drivers/iio/light/jsa1212.c  | 4 +++-
 drivers/iio/light/opt3001.c  | 3 +--
 drivers/iio/light/stk3310.c  | 5 ++++-
 drivers/iio/light/tsl2583.c  | 4 +++-
 9 files changed, 26 insertions(+), 13 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

