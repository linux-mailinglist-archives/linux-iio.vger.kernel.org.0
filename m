Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298D660938D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJWNXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4976F240
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawf-0006qF-CB; Sun, 23 Oct 2022 15:23:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-000yg9-Pa; Sun, 23 Oct 2022 15:23:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawU-00A3Qb-Qj; Sun, 23 Oct 2022 15:23:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dan Robertson <dan@dlrobertson.com>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Vladimir Oltean <olteanv@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>, Ajay Gupta <ajayg@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Haibo Chen <haibo.chen@nxp.com>, Peter Rosin <peda@axentia.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 00/23] iio: accel: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:39 +0200
Message-Id: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=uwe@kleine-koenig.org; h=from:subject; bh=vtBh38mDHSt70+h0Nd41/Bgb2a0DOA9dpKmAioQ2rvc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVUAdOy5FiIAVwkGVZ3oKXKp02eFCiZesqwtItYAS I4hBukyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1VAHQAKCRDB/BR4rcrsCTZ+B/ 4iruosL8SrqxY8poWIhuT6QV6U+ftqvDLdBt9TkyF10NkMPWsonSyo26k/09IYSNzHCXIn6efoZJaT gib8DU7dg2grHpfbk0FoEBXuo2WH0eH9nzH1jCbNwOBpB344cdLSD+QnJOEr+oF5Cjpzd3dTEBUUyK 2gPrlJGr/2ghdlZku2YigaK+vY5R1n8p2s/yyaVJUIP2x4rY21dHsQJOXqkLJNIYCJXabXtjhV7kJ4 LcY8fBmwlasA4JxRbCV3KtLRc3Go2LKZTCq5YChksoQGiolgVb9zpHdoX7opET7yCZ8h5I5JnTrwsY meeg1ZCCaP47ZDFQBFyG1LRfEU/x6B
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

this series converts all drivers below iio/accel to use the (not very new)
.probe_new() probe routine. The motivation is to get rid of the implicit
i2c_match_id call for each .probe invokation that isn't used by a big part of
the drivers anyhow.

Best regards
Uwe

Uwe Kleine-König (23):
  iio: accel: adxl367: Convert to i2c's .probe_new()
  iio: accel: adxl372: Convert to i2c's .probe_new
  iio: accel: bma400: Convert to i2c's .probe_new
  iio: accel: bmc150: Convert to i2c's .probe_new
  iio: accel: da280: Convert to i2c's .probe_new
  iio: accel: da311: Convert to i2c's .probe_new()
  iio: accel: dmard06: Convert to i2c's .probe_new()
  iio: accel: dmard09: Convert to i2c's .probe_new()
  iio: accel: dmard10: Convert to i2c's .probe_new()
  iio: accel: kxcjk-1013: Convert to i2c's .probe_new
  iio: accel: kxsd9: Convert to i2c's .probe_new()
  iio: accel: mc3230: Convert to i2c's .probe_new()
  iio: accel: mma7455: Convert to i2c's .probe_new
  iio: accel: mma7660: Convert to i2c's .probe_new()
  iio: accel: mma8452: Convert to i2c's .probe_new
  iio: accel: mma9551: Convert to i2c's .probe_new
  iio: accel: mma9553: Convert to i2c's .probe_new
  iio: accel: mxc4005: Convert to i2c's .probe_new()
  iio: accel: mxc6255: Convert to i2c's .probe_new()
  iio: accel: stk8312: Convert to i2c's .probe_new()
  iio: accel: stk8ba50: Convert to i2c's .probe_new()
  iio: accel: st_magn: Convert to i2c's .probe_new()
  iio: accel: vl6180: Convert to i2c's .probe_new()

 drivers/iio/accel/adxl367_i2c.c        |  5 ++--
 drivers/iio/accel/adxl372_i2c.c        | 18 ++++++-------
 drivers/iio/accel/bma400_i2c.c         | 18 ++++++-------
 drivers/iio/accel/bmc150-accel-i2c.c   | 37 +++++++++++++-------------
 drivers/iio/accel/da280.c              | 22 ++++++++-------
 drivers/iio/accel/da311.c              |  5 ++--
 drivers/iio/accel/dmard06.c            |  5 ++--
 drivers/iio/accel/dmard09.c            |  5 ++--
 drivers/iio/accel/dmard10.c            |  5 ++--
 drivers/iio/accel/kxcjk-1013.c         | 29 ++++++++++----------
 drivers/iio/accel/kxsd9-i2c.c          |  5 ++--
 drivers/iio/accel/mc3230.c             |  5 ++--
 drivers/iio/accel/mma7455_i2c.c        | 20 +++++++-------
 drivers/iio/accel/mma7660.c            |  5 ++--
 drivers/iio/accel/mma8452.c            | 28 +++++++++----------
 drivers/iio/accel/mma9551.c            | 19 +++++++------
 drivers/iio/accel/mma9553.c            | 21 +++++++--------
 drivers/iio/accel/mxc4005.c            |  5 ++--
 drivers/iio/accel/mxc6255.c            |  5 ++--
 drivers/iio/accel/stk8312.c            |  5 ++--
 drivers/iio/accel/stk8ba50.c           |  5 ++--
 drivers/iio/light/vl6180.c             |  5 ++--
 drivers/iio/magnetometer/st_magn_i2c.c |  5 ++--
 23 files changed, 133 insertions(+), 149 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.37.2

