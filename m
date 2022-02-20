Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598384BD085
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiBTSJI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbiBTSJH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B6527E3
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:08:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35B2A60EAD
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41C0C340E8;
        Sun, 20 Feb 2022 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380525;
        bh=jpDa30iJgAwV/6xjby3g66jTxZMNAE1KRrB1ktOMP34=;
        h=From:To:Cc:Subject:Date:From;
        b=sc3v7vipbN1G8F+a+4UAwdl5QOg/p185WVguKazkkAez5yKoyy4EKkiXWMAPXAq3t
         XDbSV0/95dn3x3Ci43N6zQEN8021K5hy6KwszxEc4ZHFEznA3bPYlQgtR5/WDc+E8o
         OQNkPCGmE07P3xrnPyocKzxO5kgJKZ5lr4XFTh9Q6D4hDOZRP2VVFAP+4ZH4pLKb9J
         XUccyjxL47AXOw9XgS2PfUWTzU+UbrlClrvQ2QgAk6twzwH+AOWmDODm3QwdWKDYU9
         EuvjTSPX06jD6YH7ggsei8gNw7ESLRhikSaFSyaBU/7TS2FsP9SDvN94BMaZLf9N1Y
         YXrb8DLpg7n6Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] IIO: Where dev_pm_ops rework and namespaces meet.
Date:   Sun, 20 Feb 2022 18:15:14 +0000
Message-Id: <20220220181522.541718-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

As these two activities have been ongoing across IIO at the same time
it was inevitable that there would be drivers were they both interact.
In particularly when we have EXPORT* of struct dev_pm_ops.

This series covers those cases by introducing (in patch 2)
EXPORT_NS[_GPL]_SIMPLE_DEV_PM_OPS() and
EXPORT_NS[_GPL]_RUNTIME_DEV_PM_OPS()
that add a namespace as the final parameter.

In each driver (with the exception of the kxsd9 which was already
using a IIO_KXSD9 namespace) I first move to the new *_PM_OPS()
and pm_[sleep_]_ptr() then in a second patch move to the new
namespaces.  Initially I had these two steps done as one patch
per driver but that was harder to follow and broke the rule of
one thing per patch.

All comments welcome.

Thanks,

Jonathan

Jonathan Cameron (8):
  iio: chemical: scd30: Export dev_pm_ops instead of suspend() and
    resume()
  PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and
    runtime pm equiv
  iio: chemical: scd30: Move symbol exports into IIO_SCD30 namespace
  iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
  iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow
    compiler to remove dead code.
  iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
  iio: imu: lsm6dsx: Use new pm_sleep_ptr() and
    EXPORT_SIMPLE_DEV_PM_OPS()
  iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace

 drivers/iio/accel/kxsd9-i2c.c                |  2 +-
 drivers/iio/accel/kxsd9-spi.c                |  2 +-
 drivers/iio/accel/kxsd9.c                    | 11 ++---------
 drivers/iio/chemical/scd30.h                 |  5 +----
 drivers/iio/chemical/scd30_core.c            | 10 +++++-----
 drivers/iio/chemical/scd30_i2c.c             |  3 ++-
 drivers/iio/chemical/scd30_serial.c          |  3 ++-
 drivers/iio/humidity/hts221_core.c           | 12 +++++-------
 drivers/iio/humidity/hts221_i2c.c            |  3 ++-
 drivers/iio/humidity/hts221_spi.c            |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 ++-
 include/linux/pm.h                           | 14 +++++++++-----
 include/linux/pm_runtime.h                   | 10 ++++++++--
 16 files changed, 51 insertions(+), 48 deletions(-)

-- 
2.35.1

