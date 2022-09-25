Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED09A5E941D
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIYP5V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYP5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 11:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E312715A
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 08:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEC960BA6
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 15:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB60C433D6;
        Sun, 25 Sep 2022 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664121439;
        bh=wUZ10wceTm9+eKSXehQLIECdr+VRkwB5GYXmCtkMv14=;
        h=From:To:Cc:Subject:Date:From;
        b=APEAnZoDkZkSMI+myIjvOWY+I0HwwibYX+1vrH+sqEF26Ldtd3z01kbWZqr4RvaML
         hbwHMN6CMlvO1AtKPmfg6h+Bsb5+9eVPGd7ML89KygzrLNz9LW5zy3RaM9CeRUYHqG
         WIpibn3NkIauOEfVv4pu7E8AGP/2Lc+uXM05ZBb0U4UX07gIq05Q4zDwvAP+LscuHz
         lEklWKlb44ZDYcpxJQgBGR6y5VBsTbL79Qf4G3D2CmR9wQ1jWVpCmhzqu0xbYm09JB
         FCOO9sN/U24HmVdL5hRKU1+xoDYOmGMgFasfAzC9DKVRPX59GwqD0s5eovqUncUV9w
         v6dapbqByRNNw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/5] IIO: Use EXPORT_NS_GPL_DEV_PM_OPS()
Date:   Sun, 25 Sep 2022 16:57:14 +0100
Message-Id: <20220925155719.3316280-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I've included Paul Cercueil's patch from
https://lore.kernel.org/all/20220813154902.32f86ee2@jic23-huawei/
but my assumption is that will go via a different tree.
It's just included here to provide everything needed to build these
against current IIO tree / linux-next

V2: Switch to Paul's more flexible implementation.
I've dropped all tags given as the form of the patches is somewhat different
from in v1.

The aim is the same as v1 - moving the remaining IIO drivers over
to the new PM macros that remove the need to mess around with
__maybe_unused or ifdef magic.  They do this by ensuring the compiler can
see all the code, and then drop it as unused if that is relevant.

Jonathan Cameron (4):
  iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
  iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
  iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
  iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace

Paul Cercueil (1):
  pm: Improve EXPORT_*_DEV_PM_OPS macros

 drivers/iio/accel/fxls8962af-core.c           | 16 ++++----
 drivers/iio/accel/fxls8962af-i2c.c            |  2 +-
 drivers/iio/accel/fxls8962af-spi.c            |  2 +-
 drivers/iio/gyro/fxas21002c_core.c            | 21 +++++------
 drivers/iio/gyro/fxas21002c_i2c.c             |  3 +-
 drivers/iio/gyro/fxas21002c_spi.c             |  3 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 21 +++++------
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 17 ++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  3 +-
 include/linux/pm.h                            | 37 ++++++++++++-------
 include/linux/pm_runtime.h                    | 20 ++++++----
 14 files changed, 84 insertions(+), 70 deletions(-)

-- 
2.37.2

