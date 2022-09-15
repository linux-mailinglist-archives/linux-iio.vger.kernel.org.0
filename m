Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9525C5BA06B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIORfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIORfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 13:35:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B094ED9;
        Thu, 15 Sep 2022 10:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D2C0B821A6;
        Thu, 15 Sep 2022 17:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8BEC433D7;
        Thu, 15 Sep 2022 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663263306;
        bh=CAMApLxsFRyjlyr+zQja25pEOP5xoAT8KHk+CoyIDFc=;
        h=From:To:Cc:Subject:Date:From;
        b=dU1SpkiyesP1hIUQ3RbcudqirXdwXcV3euWJIx/UEq+ycww2iblUo7QV5sbbST7ai
         ihHMISisL6gJ98h7IHBXmonTsEI+qowFl1pF0Y+Kl+q5vL6xs+efwkuQqH5942OVZD
         GBXPXizjD/fnXENYVRW+KSTPGQ9+DVCBXAZBcvLBG5T6yPLO3S8EiFYWDzUTIRWx0j
         CAEYo/72vsaE91o/S/36exZnm5xvPDadg1yTxJKxz7yaTFY2cmtC3lXwUnjTd/59Zr
         dT3T8/691ahFQAkle4HDo5KiKODQjjuN5Pv/aVC4UySM4cuz//dcOsJgmmzGtaC42w
         AW0VvnbS6xylQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH 0/2] add support for LSM6DSTX
Date:   Thu, 15 Sep 2022 19:34:58 +0200
Message-Id: <cover.1663262890.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for LSM6DSTX IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dstx.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSTX
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dstx device bindings

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 7 ++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 7 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.37.3

