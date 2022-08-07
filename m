Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61058BC75
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiHGSfT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiHGSfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:35:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DBF7D
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB561B80B45
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DF9C433C1;
        Sun,  7 Aug 2022 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897314;
        bh=kghi7HdVrxuc8xt9f1uC9DKKC3KsyLYoezM4OUkoGXU=;
        h=From:To:Cc:Subject:Date:From;
        b=I/GheyHkb0h07osrCdx3SVVLuMHkxZfexnOq7ZkSsisKJmVCgn0fWoavU/WFVP5g2
         5+W67A8o/JiLu+KyGoyX/1lZcLvBx/yKwynh/KQthkVLseiaX//OaLR3wzgbTX45yv
         nHZhp3n7VrnDsPfWPaEaFmbuY30DeN+B6U6wKJP8J2WIcuS/W31M+6O8/wWFJG1f6c
         AEuRGbjn+ChBGtZa1bY4mlp8MYIKRREd5GwUmCxoS4OAINKisWtUvLnKD7odsOyns1
         g0Arai12Pek6vA5ggea/7XcYICsMiwNjXJgpUUMPTIXQZa26FqHdQGmKGPMDpEkBkw
         huF1wEo1MtIfQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] Trivial cleanup and refactor dev_pm_ops handling.
Date:   Sun,  7 Aug 2022 19:45:32 +0100
Message-Id: <20220807184534.1037363-1-jic23@kernel.org>
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

This driver was taking an unusual approach to handling the optionality of
structures / callbacks depending on CONFIG_PM.  Bring it inline with
other similar drivers.

Part of continuing to move IIO over to the new PM macros that don't require
such complex handling.

Jonathan Cameron (2):
  iio: magn: hmc5843: Drop excessive indentation of assignments of
    hmc5843_driver
  iio: magn: hmc5843: Move struct dev_pm_ops out of header

 drivers/iio/magnetometer/hmc5843.h      | 13 +------------
 drivers/iio/magnetometer/hmc5843_core.c |  8 ++++----
 drivers/iio/magnetometer/hmc5843_i2c.c  |  2 +-
 drivers/iio/magnetometer/hmc5843_spi.c  | 14 +++++++-------
 4 files changed, 13 insertions(+), 24 deletions(-)

-- 
2.37.1

