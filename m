Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8253D798
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiFDQDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiFDQDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC94286DA
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 418B360E9E
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443FFC385B8;
        Sat,  4 Jun 2022 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358611;
        bh=+OYOATh5pUbNPVdb7Wkf009TGoZ2rWcRHVppolwz6SQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YkDHHfS+wV9l7ao+utJyi0ZjR7bjCyUFWl9ORzDeJVlIA+BMclyszoKOC4qXKUSCw
         IUkuAdmMpO253Cz/7HU63AVDv6QJI3RB9CEN6ZVPClzqdfV8vVTkMPgxAA2yc/a4D9
         avLZ9L9FUoOD3GaXhFIUKB1QLrygzA6XbrssfsB/SwCyEEzTqeyd+GLtdhas3SDIa1
         8DBJfZj6BwBhL4fgN1j68IbTozSfl9kY0fFmRBWDg/HkPgXba3ZT/jIgRHPMXiK2zh
         UtdqtIagiwKmuOL4YRZbaVi1rjRHdQANB7izffU7DJi2huOtroWkkjNkGVc5FrAHIm
         Yk+734//+vNkA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 0/5] IIO: Where dev_pm_ops rework and namespaces meet (4-8)
Date:   Sat,  4 Jun 2022 17:12:18 +0100
Message-Id: <20220604161223.461847-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
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

Resend as the first part of this series went via Rafael's tree and is
now available in mainline.

Hence time to return to the remainder which didn't really get much review
the first time around as focus was on the more interesting new macros
in the first few patches.

Now we have NS specific EXPORT_NS[_GPL]_SIMPLE_DEV_PM_OPS() etc
we can move these drivers over to their own namespaces reducing polution
of the global namespace with exports that are only of interest
within multi module drivers.

All comments welcome,

Thanks,

Jonathan


Jonathan Cameron (5):
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
 drivers/iio/humidity/hts221_core.c           | 12 +++++-------
 drivers/iio/humidity/hts221_i2c.c            |  3 ++-
 drivers/iio/humidity/hts221_spi.c            |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 ++-
 10 files changed, 24 insertions(+), 30 deletions(-)

-- 
2.36.1

