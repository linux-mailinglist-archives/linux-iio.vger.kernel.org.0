Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4259462BFB1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiKPNk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 08:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiKPNkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 08:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185220F73;
        Wed, 16 Nov 2022 05:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56D2DB81D81;
        Wed, 16 Nov 2022 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECAFC433D7;
        Wed, 16 Nov 2022 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606017;
        bh=FG/GRNUxoxtkmudxbJdf26wfrIlhUElAnfeP09gC33Q=;
        h=From:To:Cc:Subject:Date:From;
        b=OiIS7YvhPoxrkPa6DUgoYNqGZ70MKxYHM0T7DT08ALHYLnJsw4GFJqd8pkItGnkdR
         QYboFivnakTRmi+qOOT3S7ljWwn7IUKeNQaj1DxBwIew8ypkjggewidq1Ws+QOnX/2
         8v29GeUcXLsp0xHd35x/SA985FVkOh0LJHX2jvRM2+2xm8R7TVOHBx6SYXNtpbss4p
         KSf8dhgyZhtFMrGdzXQy43tVzrj2ju0hl/ggtMVso9Vdss71ANVS1RK0tyEkGzFmz3
         gDm1Ipzi2tazrWz3Hc8BUT2kD09v8mHYGEgvd01gPlkh2YTZpsoV0BedJdv7g/eeYO
         JjZlzlCXhHnug==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for LSM6DSO16IS
Date:   Wed, 16 Nov 2022 14:40:02 +0100
Message-Id: <cover.1668605631.git.lorenzo@kernel.org>
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

Add support for LSM6DSO16IS IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dso16is.pdf

This series is based on the commit below:

commit 1adcc208048826635bcdabb03d0f40744fea512e
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon Nov 14 10:25:34 2022 +0100

    iio: imu: st_lsm6dsx: fix LSM6DSV sensor description

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSO16IS
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is

 .../bindings/iio/imu/st,lsm6dsx.yaml          |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 128 +++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.38.1

