Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BB58BC88
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiHGSqI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiHGSqI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6D95A7
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C11DEB80D80
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F95DC433C1;
        Sun,  7 Aug 2022 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897962;
        bh=DEwlYjov5Pop1XXGP4M96Nf2J5xzWqQPIE7jH+bydhg=;
        h=From:To:Cc:Subject:Date:From;
        b=dfpHQn6HOyQI8UNPCeVnQl/OOzXzCI6pR67zhF+M9YNKGVsedHiFSWbU+Zcn4aHtJ
         hyoDs9Psj2SZo7+lEeptpFJu4Tk3azs8DmnmiTcD9brYIHpgt+/YDv5gy0xu82/zL+
         5IN7E16rFhsHvyGV/BvG1vx1cGp8nD6h/xFfcb911waHcefNrA6vaxemLX7kWrY8B8
         4u5KPmAh+8vwwAGpoVic7RhS6HxQO+IZoUvvWX1dLwLMfiDnEzRCZM4hp7WK86lU7G
         J7k5ywoh7sBVe1l6qbcVDTSSBeP0UOkBeg8F8fF3MkZbtrG3lISQpKAo8VWqSswlPo
         jBoUU8wLHHHPQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/6] iio: PM macro rework continued.
Date:   Sun,  7 Aug 2022 19:56:12 +0100
Message-Id: <20220807185618.1038812-1-jic23@kernel.org>
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

These are straight forward cases so I've grouped them together.
Aim here is to move to the macros that don't need __maybe_unused markings
and generally simplify the handling of different CONFIG_PM* options.

Jonathan Cameron (6):
  iio: proximity: sx9310: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: proximity: sx9324: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: proximity: sx9360: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: proximity: srf04: Use pm_ptr() to remove unused struct dev_pm_ops
  iio: accel: bmi088: Use EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and
    pm_ptr()
  iio: light: st_uvis25: Use EXPORT_NS_SIMPLE_DEV_PM_OPS()

 drivers/iio/accel/bmi088-accel-core.c | 15 ++++++---------
 drivers/iio/accel/bmi088-accel-spi.c  |  2 +-
 drivers/iio/light/st_uvis25_core.c    |  9 +++------
 drivers/iio/light/st_uvis25_i2c.c     |  2 +-
 drivers/iio/light/st_uvis25_spi.c     |  2 +-
 drivers/iio/proximity/srf04.c         | 10 +++++-----
 drivers/iio/proximity/sx9310.c        |  8 ++++----
 drivers/iio/proximity/sx9324.c        |  8 ++++----
 drivers/iio/proximity/sx9360.c        |  8 ++++----
 9 files changed, 29 insertions(+), 35 deletions(-)

-- 
2.37.1

