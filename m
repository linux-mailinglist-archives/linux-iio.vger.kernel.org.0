Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18A85278A5
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiEOQAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiEOQAH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:00:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D315FCF
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:00:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGf2-0001DP-Ql; Sun, 15 May 2022 18:00:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGey-002V30-6S; Sun, 15 May 2022 17:59:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqGev-009uFs-RA; Sun, 15 May 2022 17:59:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        kernel@pengutronix.de
Subject: [PATCH 0/8] iio: Improve error reporting for problems during .remove for various i2c drivers
Date:   Sun, 15 May 2022 17:59:21 +0200
Message-Id: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; h=from:subject; bh=O5cAG3agHOq2S3wgG5/5v/EhPFYXfY/H4Kz7PzUfjNk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBigSMedULAKf71g97p6WED9LEysWNb/XvF9LI6HKXj REl74KSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoEjHgAKCRDB/BR4rcrsCcTtCA CDYenSpSrha80XL2hSxrYE29ldrVwOLNys3l8CIb4ZGUyjRxngMAnNy1ur3QiVNKFcLF2TDduvtlX0 3qXmWJeKNvOr9ajYjetO4VP3GwQaDD1DKEkEmeVRsIBKs8TDZalwmS8EbBeHz96DYrC5NcpzPu6tct zvcmzl96HT5rPV7quOgjn8RxjknXIyAflyJ1jFCI7eFDOxeWzI8QKpKbTGhD/2r6fAz8HfIf4f3Ra9 TgdJK9bDL3rtNNX8/TUL12noQlpDH1dFOSsJfSIH6hw2Mgu49hsfdfZU4fWI9JmYIGe7prqnprM7pz MvDpesagkmOHWM58F+xYDpoSc/OAFA
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

Hello,

the goal of this series is to improve the error messages emitted by
remove callbacks by several i2c drivers. The status quo is that these
might return an error code silently to the i2c core on remove. The
effect is a very unhelpful message:

	$bus $device: remove failed (EIO), will be ignored

. Note there is no further error handling and the device will be
removed, all devm cleanups are called.

With the patches from this series applied the emitted message better
tells what actually failed and the remove callback returns zero
unconditionally.

The motivation for this change is to make i2c remove callbacks return
void. The ability to return a value is misleading as driver authors
might expect some kind of error handling from the i2c core.

Best regards
Uwe

Uwe Kleine-König (8):
  iio:adc:ina2xx: Improve error reporting for problems during .remove()
  iio:adc:ti-ads1015: Improve error reporting for problems during
    .remove()
  iio:chemical:atlas: Improve error reporting for problems during
    .remove()
  iio:chemical:ccs811: Improve error reporting for problems during
    .remove()
  iio:light:pa12203001: Improve error reporting for problems during
    .remove()
  iio:light:us5182d: Improve error reporting for problems during
    .remove()
  iio:light:vcnl4000: Improve error reporting for problems during
    .remove()
  iio:light:vcnl4035: Improve error reporting for problems during
    .remove()

 drivers/iio/adc/ina2xx-adc.c        | 10 ++++++++--
 drivers/iio/adc/ti-ads1015.c        |  8 +++++++-
 drivers/iio/chemical/atlas-sensor.c |  8 +++++++-
 drivers/iio/chemical/ccs811.c       | 10 ++++++++--
 drivers/iio/light/pa12203001.c      |  8 +++++++-
 drivers/iio/light/us5182d.c         |  8 +++++++-
 drivers/iio/light/vcnl4000.c        |  8 +++++++-
 drivers/iio/light/vcnl4035.c        | 10 ++++++++--
 8 files changed, 59 insertions(+), 11 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

