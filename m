Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F85120FF
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiD0Sly (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiD0SlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 14:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B2DD447C
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 11:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8074161EE1
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 18:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD8CC385A9;
        Wed, 27 Apr 2022 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083821;
        bh=DDD8fNEIkc3RFhAQYhhN7xQeA5RwKwzV2ZiHP3D5J7c=;
        h=Date:From:To:Subject:From;
        b=OxkQjhQaEhicmGyMDnbT14xRV0e3w5gXbAiKRsWMSNFTiAceKl0RPFIpjjghBrMg5
         MKWDDLF84sxyq8ehppsRbqQwojI9StC0VUwMlskAPnLEkQ5aGfATAQo4CuTwzUKiY3
         rg+1wTwc3hQVza+b16imQXE2VMpH7vZONUMBCuqSrC+gdXjiZHIkVZDUUmarg8uSbM
         /xfkGtz39CzjReUHVn0LZf2FJuh3On6FJx2FpDVDMgw+Em1RhpvahSdeST5qCx/U0p
         qO6yeApy5peJe5+e8i5e4fwTD2Bx295bV6GKFFMbFD0KhLmhlrSrW9jLEtkZ+zkysG
         JkCJ+PmXc/cQg==
Date:   Wed, 27 Apr 2022 19:31:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 5.18
Message-ID: <20220427193153.69d3237b@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-5.18a

for you to fetch changes up to b5d6ba09b10d2ccb865ed9bc45941db0a41c6756:

  iio: imu: inv_icm42600: Fix I2C init possible nack (2022-04-16 15:03:58 +=
0100)

----------------------------------------------------------------
1st set of IIO fixes for the 5.18 cycle

ad3552r:
 - Fix a bug with error codes being stored in unsigned local variable.
 - Fix IS_ERR when value is either NULL or not rather than ERR_PTR
ad5446
 - Fix shifting of read_raw value.
ad5592r
 - Fix missing return value being set for a fwnode property read.
ad7280a
 - Wrong variable being used to set thresholds.
admv8818
 - Kconfig dependency fix.
ak8975
 - Missing regulator disable in error path.
bmi160
 - Disable regulators in an error path.
dac5571
 - Fix chip id detection for devices with OF bindings.
inv_icm42600
 - Handle a case of a missing I2C NACK during initially configuration.
ltc2688
 - Fix voltage scaling where integer part was written twice and
   decimal part not at all.
scd4x
 - Handle error before using value.
sx9310
 - Device property parsing against indio_dev->dev.of_node which
   hasn't been set yet.
sx9324
 - Fix hardware gain related maths.
 - Wrong defaults for precharge internal resistance register.

----------------------------------------------------------------
Dan Carpenter (2):
      iio: dac: ad3552r: fix signedness bug in ad3552r_reset()
      iio:dac:ad3552r: Fix an IS_ERR() vs NULL check

Fawzi Khaber (1):
      iio: imu: inv_icm42600: Fix I2C init possible nack

Gwendal Grignou (1):
      iio: sx9324: Fix default precharge internal resistance register

Jonathan Cameron (1):
      iio: adc: ad7280a: Fix wrong variable used when setting thresholds.

Jose Cazarin (1):
      iio: dac: dac5571: Fix chip id detection for OF devices

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Nuno S=C3=A1 (1):
      iio: dac: ltc2688: fix voltage scale read

Stephen Boyd (2):
      iio:proximity:sx_common: Fix device property parsing on DT systems
      iio:proximity:sx9324: Fix hardware gain read/write

Tom Rix (1):
      iio: scd4x: check return of scd4x_write_and_fetch

Tong Zhang (1):
      iio:imu:bmi160: disable regulator in error path

Wang ShaoBo (1):
      iio:filter:admv8818: select REGMAP_SPI for ADMV8818

Zheyu Ma (1):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

 drivers/iio/adc/ad7280a.c                       | 12 +++++-----
 drivers/iio/chemical/scd4x.c                    |  5 +++-
 drivers/iio/dac/ad3552r.c                       |  6 ++---
 drivers/iio/dac/ad5446.c                        |  2 +-
 drivers/iio/dac/ad5592r-base.c                  |  2 +-
 drivers/iio/dac/ltc2688.c                       |  2 +-
 drivers/iio/dac/ti-dac5571.c                    | 28 ++++++++++++++--------
 drivers/iio/filter/Kconfig                      |  1 +
 drivers/iio/imu/bmi160/bmi160_core.c            | 20 +++++++++++-----
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++-----
 drivers/iio/magnetometer/ak8975.c               |  1 +
 drivers/iio/proximity/sx9324.c                  | 32 +++++++++++++++++++--=
----
 drivers/iio/proximity/sx_common.c               |  1 +
 13 files changed, 85 insertions(+), 42 deletions(-)
