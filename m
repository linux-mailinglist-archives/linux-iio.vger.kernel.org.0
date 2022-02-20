Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF98B4BD074
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiBTRpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:45:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBTRpY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:45:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3194C43C
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE88E60B87
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB38C340E8;
        Sun, 20 Feb 2022 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645379102;
        bh=KdlJLrSPcIJlVJ+GDjsNbmNbEtnrQEHIPpBeji0A6Qw=;
        h=From:To:Cc:Subject:Date:From;
        b=IEyrS49iDPNABwUTpClYY3sJ3NY1Mc1tY+VEvcNGMr0DRLozFJ0PXZ557V8Ci4Gqz
         +EU2jM5F7aQp6m0rFRMySTteZ2TcqC5+fDnMkqnd1yiksNrBIdh0XyQ1i1paSCSrpF
         hp4yFZ/Ytbmq53hQO9Zy5037IptygDS7J/FXg8Z9rXqMfjw5O4IVNuaP0hXwWt9yKF
         D6VQe+q2cgb7PrIkwPZWbjYUq971apm3ThrTAl5phd9OOiupL2UEUObBPb0Frvzbiw
         eWBNDCuNb/DwMFncXu0Zun0NgNxIuF6E8caYn2bW1Cl5/4O4xUPvcXIdoJUQ2mrCaB
         7V36Sx3O08pOg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio: gyro: mpu3050: Cleanup exports and PM
Date:   Sun, 20 Feb 2022 17:51:47 +0000
Message-Id: <20220220175149.503495-1-jic23@kernel.org>
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

Paul Cercueil happened to chose this driver as his example for
EXPORT_RUNTIME_DEV_PM_OPS() in his recent patch set to cleanup
how we handle dev_pm_ops.

https://lore.kernel.org/linux-pm/20220105101106.00005ae0@Huawei.com/

Whilst reviewing that I noticed that there were a bunch of exports
in this driver that are only used by other files compiled into the same
module.  Paul found another driver to demo his new infrastructure.

This series is cleaning up that oddity by first dropping the exports
and then using the new pm_ptr() and DEFINE_RUNTIME_PM_DEV_OPS() to allow
the compiler to be responsible for removing the unused code for us rather
than requiring manual CONFIG_PM guards.

Jonathan Cameron (2):
  iio: gyro: mpu3050: Drop unused symbol exports.
  iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()

 drivers/iio/gyro/mpu3050-core.c | 14 ++------------
 drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
 2 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.35.1

