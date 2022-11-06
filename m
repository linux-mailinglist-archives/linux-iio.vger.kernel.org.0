Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8C61E297
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 15:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKFOhR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFOhR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 09:37:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730CDEA8;
        Sun,  6 Nov 2022 06:37:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AA0BB80BFE;
        Sun,  6 Nov 2022 14:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE99C433C1;
        Sun,  6 Nov 2022 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667745433;
        bh=1DZTsOuzJDxPuK9zMI+XaGIwYmOZ8cmytqAO1cZy0Sc=;
        h=From:To:Cc:Subject:Date:From;
        b=QkQ/Fzj55ciEjIvIDTv1XMOl1RjpZjaAKYzZ2sBTXczLDofSN7mmI3CKK0JjYkSY6
         hSDaiR9oSxVcyATDRfOX5V7Tda91pcFdHYiCOaBdwuyZ+cTSmGv6uNaz4swgOs2EbD
         V4mFSXwr78DIUVHfXaGIFbE03yk3v74zMhfaDQWufOL9NQ+gsikyxNJZTgnVcI5jwv
         NAuDXWJ+3FdeBiN1RxKOhbstG9IdjIKK6TclWotttTfqoRKsufoEycXgIqL8F8We3w
         X/pyXzT3mFn+DCLYyUMjLsdII988X81ob+dXo+xwc+rrzRYDK0VaNgGjjrkCnY+W8X
         nxj0zTwijVfuQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for LSM6DSV16X
Date:   Sun,  6 Nov 2022 15:36:52 +0100
Message-Id: <cover.1667745215.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Add support for LSM6DSV16X IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dsv16x.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSV16X
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x device bindings

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 6 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.38.1

