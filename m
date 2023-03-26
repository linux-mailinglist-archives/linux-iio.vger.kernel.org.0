Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D046C9705
	for <lists+linux-iio@lfdr.de>; Sun, 26 Mar 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCZQ7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Mar 2023 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjCZQ7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2023 12:59:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25DC5FE1
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2023 09:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B78B5B8070D
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2023 16:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9C0C4339B;
        Sun, 26 Mar 2023 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679849979;
        bh=VTcMIlx6ZZI+HaFtCIO2QEbdEQCArgBjiebh0U/JRTE=;
        h=Date:From:To:Subject:From;
        b=p0iUlkA1Ko0k3NBKAaOjZ5UItml2P03ZKHllCHxYgfnKJSI8p+YIMtGDOoQL/gXAj
         P3FofsRdrReD2aDrwv9WzUbcCCTNlKP3mfweJyemktEpGqZK9CNn9KAkovRUL4g80f
         ORhN8dcaL5rRQ+Z9b89gSXc+JIM8onhxRld8EJ3TlDiDMqt3W+oSgPo+pofZmAN8oT
         ZgW1rQ0QWqB0JGv42kT/wHZxJrFOe6ntcK8uAxkOahUX48IY7fyrG1x4wXMA8r8Vxm
         eZzONMY6z0JdI6MqFP69d8r7f1Kw773e4SDjUYsf/N7KnURj3+yNNAxyJE0Qc/3TSV
         HCKb1lAsH5NSA==
Date:   Sun, 26 Mar 2023 18:14:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes for 6.3 - set 1
Message-ID: <20230326181442.3475d522@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 2acd031347f645871959a799238a7caf6803aa18:

  iio: imu: fxos8700: fix MAGN sensor scale and unit (2023-01-21 18:15:19 +=
0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.3a

for you to fetch changes up to 363c7dc72f79edd55bf1c4380e0fbf7f1bbc2c86:

  iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip (2023-03-18 16:3=
9:35 +0000)

----------------------------------------------------------------
1st set of IIO fixes for 6.3

Usual mixed bag:

- core - output buffers
  Fix return of bytes written when only some succeed.
  Fix O_NONBLOCK handling to not block.

- adi,ad7791
  Fix IRQ type.  Not confirmed to have any impact but good to correct it an=
yway

- adi,adis16400
  Missing CONFIG_CRC32

- capella,cm32181
  Unregister 2nd I2C client if one is used.

- cio-dac
  Fix bitdepth for range check on write.

- linear,ltc2497
  Fix a wrong shift of the LSB introduced when switching to be24 handling.

- maxim,max11410
  Fix handling of return code in read_poll_timeout()

- qcom,spmi-adc
  Fix an accidental change of channel name to include the reg value from OF.

- ti,palmas
  Fix a null dereference on remove due to wrong function used to get the
  drvdata.

- ti,ads7950
  Mark GPIO as can sleep.

----------------------------------------------------------------
Andy Shevchenko (1):
      iio: adc: qcom-spmi-adc5: Fix the channel name

Arnd Bergmann (1):
      iio: adis16480: select CONFIG_CRC32

Ian Ray (1):
      drivers: iio: adc: ltc2497: fix LSB shift

Kai-Heng Feng (1):
      iio: light: cm32181: Unregister second I2C client if present

Lars-Peter Clausen (1):
      iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip

Mehdi Djait (1):
      iio: accel: kionix-kx022a: Get the timestamp from the driver's privat=
e data in the trigger_handler

M=C3=A5rten Lindahl (1):
      iio: light: vcnl4000: Fix WARN_ON on uninitialized lock

Nuno S=C3=A1 (4):
      iio: buffer: correctly return bytes written in output buffers
      iio: buffer: make sure O_NONBLOCK is respected
      iio: adc: ad7791: fix IRQ flags
      iio: adc: max11410: fix read_poll_timeout() usage

Patrik Dahlstr=C3=B6m (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

William Breathitt Gray (1):
      iio: dac: cio-dac: Fix max DAC write value check for 12-bit

 drivers/iio/accel/kionix-kx022a.c |  2 +-
 drivers/iio/adc/ad7791.c          |  2 +-
 drivers/iio/adc/ltc2497.c         |  6 ++----
 drivers/iio/adc/max11410.c        | 22 +++++++++++++++-------
 drivers/iio/adc/palmas_gpadc.c    |  2 +-
 drivers/iio/adc/qcom-spmi-adc5.c  | 10 +++++++++-
 drivers/iio/adc/ti-ads7950.c      |  1 +
 drivers/iio/dac/cio-dac.c         |  4 ++--
 drivers/iio/imu/Kconfig           |  1 +
 drivers/iio/industrialio-buffer.c | 21 ++++++++++++---------
 drivers/iio/light/cm32181.c       | 12 ++++++++++++
 drivers/iio/light/vcnl4000.c      |  3 ++-
 12 files changed, 59 insertions(+), 27 deletions(-)
