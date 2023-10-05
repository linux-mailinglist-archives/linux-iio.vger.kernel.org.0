Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEEC7BA7EB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Oct 2023 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJERZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Oct 2023 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjJERYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2023 13:24:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B0D66
        for <linux-iio@vger.kernel.org>; Thu,  5 Oct 2023 10:20:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8DAC433C8;
        Thu,  5 Oct 2023 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526415;
        bh=3Z3rM7mMTHYOLVAPZXnUQg8llp/QeBgpl27WRedShHc=;
        h=Date:From:To:Subject:From;
        b=ZscivNuEyhB5i51z02At0rzvrlXGk0yv82AKDQh2UJ5VkdD9e1aqCwi8DwQ1tHrN1
         ua8Hnl1L3+58x96fO+Au28JLdh8Jmw6MhnHEx5izO69itEQN6q49yXqaUlCbwy3kQE
         ijYJ/xoLOE4vM7QXAZROOC2sMquBAV5Air91AtF4sKny/KReFY7ojyh55NgmU1e0aQ
         bg+mfuvpqw+CqJg60Bv1AyBVxnFYIdlv5FzOGhUu5/mtoQdd5v+e2zkcT2y/MBw5Z/
         wwjssHTkPC43EjnGXIxMiO7J4FQmS1lhyB26VVuHLpZ8UDoXAQiKvSjKkpJTFkjwzj
         lttFHFnEoaEBQ==
Date:   Thu, 5 Oct 2023 18:20:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 6.6
Message-ID: <20231005182024.66b68b41@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.6a

for you to fetch changes up to fd39d9668f2ce9f4b05ad55e8c8d80c098073e0b:

  iio: pressure: ms5611: ms5611_prom_is_valid false negative bug (2023-10-0=
5 18:06:46 +0100)

----------------------------------------------------------------
1st set of IIO fixes for 6.6

Note last minute rebase to fix up a stale Fixes tag. All patches have been
in Linux-next for some time.

adi,ad3552r
 - Fix swapped device IDs for the two parts that are supported.
adi,ad7192
 - Use the right reference voltage source.
adi,ad7292
 - Fix additionalProperties to be false, not true.
adi,ad74413
 - Add missing Kconfig depends on IIO_BUFFER and IIO_TRIGGERED_BUFFER
adi,admv1013
 - Fix up some corner cases for the mixer vgate register value.
bosch,bmp280
 - Fix a null pointer dereference caused by a wrong boolean operator.
bosch,bno055
 - Add missing Kconfig depends on IIO_BUFFER and IIO_TRIGGERED_BUFFER
freescale,imx8eqxp
 - Fix some wrong register addresses.
google,cros_ec
 - Fix a use after free if very badly timed buffer disable occurs by
   holding the device in buffered mode.
infineon,dps310
 - Expand a timeout so we don't hit it on working parts.
meas,m5611
 - Allow for a ROM CRC of 0 as it is a valid value and there are devices
   out there where it happens.
murata,irsd200
 - Make sure the buffer used to build up the scan is large enough to take
   the timestamp.
rohm,bu27010 binding
 - Add a missing required vdd-supply
vishay,vcnl4000
 - Don't power down chip in wrong place.

----------------------------------------------------------------
Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Alisa-Dariana Roman (1):
      iio: adc: ad7192: Correct reference voltage

Antoniu Miclaus (2):
      iio: admv1013: add mixer_vgate corner cases
      iio: addac: Kconfig: update ad74413r selections

GONG, Ruiqi (1):
      iio: irsd200: fix -Warray-bounds bug in irsd200_trigger_handler

Jonathan Cameron (1):
      iio: imu: bno055: Fix missing Kconfig dependencies

Krzysztof Kozlowski (1):
      dt-bindings: iio: rohm,bu27010: add missing vdd-supply to example

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Marcelo Schmitt (1):
      iio: dac: ad3552r: Correct device IDs

M=C3=A5rten Lindahl (1):
      iio: light: vcnl4000: Don't power on/off chip in config

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Philipp Rossak (1):
      iio: adc: imx8qxp: Fix address for command buffer registers

Rob Herring (1):
      dt-bindings: iio: adc: adi,ad7292: Fix additionalProperties on channe=
l nodes

Tzung-Bi Shih (1):
      iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |  2 +-
 .../bindings/iio/light/rohm,bu27010.yaml           |  1 +
 drivers/iio/adc/ad7192.c                           | 29 ++++++++++++++++++=
+---
 drivers/iio/adc/imx8qxp-adc.c                      |  4 +--
 drivers/iio/addac/Kconfig                          |  2 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  6 ++++-
 drivers/iio/dac/ad3552r.c                          |  4 +--
 drivers/iio/frequency/admv1013.c                   |  4 +--
 drivers/iio/imu/bno055/Kconfig                     |  2 ++
 drivers/iio/light/vcnl4000.c                       |  1 -
 drivers/iio/pressure/bmp280-core.c                 |  2 +-
 drivers/iio/pressure/dps310.c                      |  8 +++---
 drivers/iio/pressure/ms5611_core.c                 |  2 +-
 drivers/iio/proximity/irsd200.c                    |  6 ++---
 14 files changed, 51 insertions(+), 22 deletions(-)
