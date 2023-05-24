Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595370F9E9
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjEXPRZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjEXPRZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 11:17:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8235A9
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2023 08:17:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEU-0005aq-Mn; Wed, 24 May 2023 17:16:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEO-002W9M-1G; Wed, 24 May 2023 17:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1qEN-007b3X-3a; Wed, 24 May 2023 17:16:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>, Steven@pengutronix.de,
        Corey Minyard <cminyard@mvista.com>,
        Haowen Bai <baihaowen@meizu.com>, Tom Rix <trix@redhat.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        linux-media@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Subject: [PATCH v2 0/5] staging: Switch i2c drivers back to use .probe()
Date:   Wed, 24 May 2023 17:16:41 +0200
Message-Id: <20230524151646.486847-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oZTirYzLLLjAbQ0R9E7WUt1ieii/eqYC2yfE783S0uI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbipV7ckWVv8+r3k+4CFvcNoma8ar3IPgApcSh D/+jwT9RIqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4qVQAKCRCPgPtYfRL+ TmtEB/wOhQ6/QboZ072fYqMkRQJsatwYd0Kr6OGDfUftT67XbG/TazkPpqUuGy1xTLX8pddwU6N GVqlCSLZKS2T3eRY/bliNCqLttuhukihWANAUZMPsRQ1LxOx5pHyMvWTd6L8PJFShumXIlzVarx oJ18yk7RpdRikDUhvmCYWrcYlGeDxThenfWHmpQmzkT2Wgx9EqCOgI1HOex42bGejhNaIhw3LGg sjmkivoJxogJ5KXAZi8wSL7w4ItXBVtQHT8xqbgpHP3DyVba0NriGeS0UONavzeyekfhOpTS3BK G6iRdQ6nuwohHn2vtnHI/HUs+F6nmG1AmEbuSU9OpDNIL3u+
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

changes since (implicit) v1, sent with Message-Id:
<20230523200036.465180-1-u.kleine-koenig@pengutronix.de>:

 - Split by driver/driver area
 - Rebase to next/master in the hope this makes it easier (or at least
   not harder) to apply this series. Applying on v6.4-rc1 should also
   work just fine.

The individual patches are all pairwise independent of each other, so
everyone can pick up the subset that suites them.

Best regards
UWe

Uwe Kleine-König (5):
  staging: iio: Switch i2c drivers back to use .probe()
  media: atomisp: Switch i2c drivers back to use .probe()
  media: staging: max96712: Switch i2c driver back to use .probe()
  staging: olpc_dcon: Switch i2c driver back to use .probe()
  staging: most: Switch i2c driver back to use .probe()

 drivers/staging/iio/addac/adt7316-i2c.c                   | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c           | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 +-
 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 +-
 drivers/staging/media/max96712/max96712.c                 | 2 +-
 drivers/staging/most/i2c/i2c.c                            | 2 +-
 drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

base-commit: cf09e328589a2ed7f6c8d90f2edb697fb4f8a96b
-- 
2.39.2

