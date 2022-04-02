Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202FD4F0053
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiDBKLt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiDBKLs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 06:11:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16038527D3;
        Sat,  2 Apr 2022 03:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0C77B80689;
        Sat,  2 Apr 2022 10:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E929C340EC;
        Sat,  2 Apr 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648894194;
        bh=CXMartoYjubWeMV3E1H9s8ARDUAdYfTP7uWl0ij+SGg=;
        h=From:To:Cc:Subject:Date:From;
        b=kipW2BQRZ41shGiNObLooDWizusP+q192QYflwQiKGgepT+y66dJq2r/cvV5Fm+MY
         mIO4zSduiXSIWDiKpZCVGRZUOojJuIjdsQEeoTuy4AtG1EGfm5vb7HUyQgyoaCubJc
         6pjoZBDeDA9jbnHjtAgh1/GCbv3JHc4Pqd3HZXJcmNcjO9mBFyHZ28PCLmejzKvQUH
         wGmNshvSNYysY7LVTSg/LzOYY4e6AsmOF1kxJEsBdbtvnD/qwfudxVoxk0TgWg3uCU
         QIkGdm1mMnLiONN3zjYYssPBj2S6vsgTlo92+tkf4WIwubzV0LctaeK8HU6GxeuHxU
         zJkWQU8lovR7Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH 0/2] add support for ASM330LHHX
Date:   Sat,  2 Apr 2022 12:09:28 +0200
Message-Id: <cover.1648893892.git.lorenzo@kernel.org>
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

Add support for ASM330LHHX IMU mems sensor
https://www.st.com/resource/en/datasheet/asm330lhhx.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ASM330LHHX
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 6 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 7 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.35.1

