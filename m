Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD04BD0AB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbiBTSfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:35:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiBTSfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:35:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CA3121C
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51003B80DB7
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEB7C340E8;
        Sun, 20 Feb 2022 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645382112;
        bh=TTcNqcpFObjXqwmD+01ylvMEFUzHQFRTJvmEFdontTE=;
        h=Date:From:To:Subject:From;
        b=B1VVZREQvOj6wWpYjSfLuk8yKl5Dwz98tPsVSjxGnOIpmZ1gSJX8CmcRL6DVKHrG6
         /t7iME2Ae4q4h+yR3NlNTHu8NVgivde7Hi+asEc880JtxUnowBXmro6KCsR0tY717m
         jZRTBTGbu2/4X0y91hppH7+84+3PASVyag9Ra7nTYODoCvxcnDoIABjnU2PbSv8ZZR
         79M8K/H6kBZqWjnycPHV988AaliYMny2CzMhz52DtNDlvabuUfpzhUV3z4dJoA/iIZ
         /0tsjX0YkQNRZ1VhGPc41FxEwAXlzeqPADfM8yjPNQMZebIj0wTKMeZPBajJN1RlJv
         XAfHJUaH3IAaA==
Date:   Sun, 20 Feb 2022 18:42:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 5.17
Message-ID: <20220220184205.4eb4ef85@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-5.17a

for you to fetch changes up to ea85bf906466191b58532bb19f4fbb4591f0a77e:

  iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_oneshot (=
2022-02-07 20:45:49 +0000)

----------------------------------------------------------------
1st set of IIO fixes for the 5.17 cycle.

Several drivers:
 - Fix a failure to disable runtime in probe error paths. All cases
   were introduced in the same rework patch.

adi,ad7124
 - Fix incorrect register masking.
adi,ad74413r
 - Avoid referencing negative array offsets.
 - Use ngpio size when iterating over mask not numebr of channels.
 - Fix issue with wrong mask uage getting GPIOs.
adi,admv1014
 - Drop check on unsigned less than 0.
adi,ads16480
 - Correctly handle devices that don't have burst mode support.
fsl,fxls8962af
 - Add missing padding needed between address and data for SPI transfers.
men_z188
 - Fix iomap leak in error path.
st,lsm6dsx
 - Wait for setting time in oneshot reads to get a stable result.
ti,tsc2046
 - Prevent an array overflow.

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path

Cosmin Tanislav (3):
      iio: adc: ad7124: fix mask used for setting AIN_BUFP & AIN_BUFM bits
      iio: addac: ad74413r: use ngpio size when iterating over mask
      iio: addac: ad74413r: correct comparator gpio getters mask usage

Kees Cook (1):
      iio: addac: ad74413r: Do not reference negative array offsets

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_onesh=
ot

Miaoqian Lin (1):
      iio: Fix error handling for PM

Muhammad Usama Anjum (1):
      iio: frequency: admv1013: remove the always true condition

Nuno S=C3=A1 (1):
      iio:imu:adis16480: fix buffering for devices with no burst mode

Oleksij Rempel (1):
      iio: adc: tsc2046: fix memory corruption by preventing array overflow

Sean Nyekjaer (1):
      iio: accel: fxls8962af: add padding to regmap for SPI

 drivers/iio/accel/bmc150-accel-core.c        |  5 ++++-
 drivers/iio/accel/fxls8962af-core.c          | 12 ++++++++++--
 drivers/iio/accel/fxls8962af-i2c.c           |  2 +-
 drivers/iio/accel/fxls8962af-spi.c           |  2 +-
 drivers/iio/accel/fxls8962af.h               |  3 ++-
 drivers/iio/accel/kxcjk-1013.c               |  5 ++++-
 drivers/iio/accel/mma9551.c                  |  5 ++++-
 drivers/iio/accel/mma9553.c                  |  5 ++++-
 drivers/iio/adc/ad7124.c                     |  2 +-
 drivers/iio/adc/men_z188_adc.c               |  9 ++++++++-
 drivers/iio/adc/ti-tsc2046.c                 |  4 ++--
 drivers/iio/addac/ad74413r.c                 | 17 ++++++++---------
 drivers/iio/frequency/admv1013.c             |  2 +-
 drivers/iio/gyro/bmg160_core.c               |  5 ++++-
 drivers/iio/imu/adis16480.c                  |  7 ++++++-
 drivers/iio/imu/kmx61.c                      |  5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  6 +++++-
 drivers/iio/magnetometer/bmc150_magn.c       |  5 +++--
 18 files changed, 72 insertions(+), 29 deletions(-)
