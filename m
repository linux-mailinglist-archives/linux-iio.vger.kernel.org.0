Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F658BCA9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHGTK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHGTKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 15:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E84E9;
        Sun,  7 Aug 2022 12:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B601B80DC1;
        Sun,  7 Aug 2022 19:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6568C433C1;
        Sun,  7 Aug 2022 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659899422;
        bh=Db1xu/H84odySSOPk3NgnvFGWEVIZg/EcipSlPUsG1w=;
        h=From:To:Cc:Subject:Date:From;
        b=qNaBWs0cdH3GL3JD8kGGkAQ9+nM+5F4EgWjJ+ll/+ps4w21vXby3UbBuT3XbG9Ea1
         AAJmpjiJp13C1DFLR36F7E2EWJ3eyEVPXoIRRnMqdPKDoqipXsZHAnpt53P4BqP/JZ
         iDz/vgTpk4KJVsLFnQXFUf0GHh+4uOTuWU+kj5UqihbmTdb1QbjfyS+qoBvxRCTtQ+
         JmbvO2doe03NWtghMcEbL9i7y1in6ywOgyT2akUvhBJv7Bg2sMgoV6wfKkNxAKqLz0
         YuGkEExiZNGhpcYDms/HrmaeGvD8TK5vTDGfVYspy+Low4EsQ3Hfbzxe0/h/mfGWiW
         jba/UWdznOueA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/5] PM: Introduce EXPORT_NS_GPL_DEV_PM_OPS() and use cases in IIO.
Date:   Sun,  7 Aug 2022 20:20:33 +0100
Message-Id: <20220807192038.1039771-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Perhaps the most complex case we can have is a core driver module (usually
with accompanying per bus modules) that exports, in a namespace,
a struct dev_pm_ops. The driver has different handling for runtime and
sleep suspend / resume so (almost) all callbacks are provided.
The pm.h helper macro _EXPORT_DEV_PM_OPS() could be used here but the
handling of the last two parameters is unusual and very different from
the macros intended for driver usage. First parameter needs to be "_gpl"
and second needs to be the namespace specified as a string.  Other NS
macros take it without quotes.

As such, this series proposes introducing a suitable macro and then provides
a number of IIO driver conversions. Where relevant the exports from the
driver are moved into the new namespace.

If accepted we can either take the whole lot through the PM tree and hope
there is nothing much else overlapping with this driver code in this cycle,
or ideally we could use an immutable branch and pull this into both the
IIO and PM trees.

Jonathan Cameron (5):
  PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid drivers rolling own.
  iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
  iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
  iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
  iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace

 drivers/iio/accel/fxls8962af-core.c           | 17 +++++++--------
 drivers/iio/accel/fxls8962af-i2c.c            |  2 +-
 drivers/iio/accel/fxls8962af-spi.c            |  2 +-
 drivers/iio/gyro/fxas21002c_core.c            | 21 ++++++++-----------
 drivers/iio/gyro/fxas21002c_i2c.c             |  3 ++-
 drivers/iio/gyro/fxas21002c_spi.c             |  3 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 21 ++++++++-----------
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 18 +++++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  3 ++-
 include/linux/pm.h                            |  5 +++++
 13 files changed, 52 insertions(+), 52 deletions(-)

-- 
2.37.1

