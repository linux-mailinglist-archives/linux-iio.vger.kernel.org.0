Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB65370803
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhEARDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARDl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 559F360FEB;
        Sat,  1 May 2021 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888570;
        bh=beQTznlIxYQXL5tbbc86wt2ien8TxzFNiS2KpYVC8w8=;
        h=From:To:Cc:Subject:Date:From;
        b=pl5KYUYA7Dl2QUAS8dCNqNbcKJdtpxKK3MFxwWxV4Ig09+IvK6/aCMWq/RKI9Ttt9
         V9pBmIaMuryG48zIzo3zvP61dz0/Nstzceg549vAL2hdK12LMX64YUCUDQQsiZj8gE
         NpS0Xs4Pwm4ed8TFraSK+einu6IEahJkX6Hwodw3T1fR/T3omLBCOzAnTugGmgiq2U
         OjVfRbSEzpeT3+5ytCZfJ3KFidYxH8ceZOh6hOD5e6RVanl8X2oLgn7UhMmo37ONDk
         egz78A+Kj98ACBOa+/c95YrD1RfoG2IIuX4cuYvelBA6Jxte4Wr1w/dhVlRHgdgY6M
         m7SgEjgUV91Lw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/19] IIO: Alignment fixes part 2 - struct used to ensure alignment
Date:   Sat,  1 May 2021 18:01:02 +0100
Message-Id: <20210501170121.512209-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I finally got around to do a manual audit of all the calls to
iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
of:
1. 8 byte alignment of the provided buffer.
2. space for an 8 byte naturally aligned timestamp to be inserted at the
   end.

Unfortuantely there were rather a lot of these left, but time to bite the bullet
and clean them up.

As discussed previous in
https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
it is not easy to fix the alignment issue without requiring a bounce buffer
(see part 4 of the alignment fixes for a proposal for that where it is
absolutely necessary).

Part 2 is the simple cases where the timestamp position is always the same
(as not more than 8 bytes of other scan elements) and where it is either
in a structure that is kzalloc'd or there was already an explicit memset
that would clear any holes in the structure (and hence avoid a potential
kernel data leak).

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Jonathan Cameron (19):
  iio: accel: bma180: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: accel: bma220: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: accel: hid: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: accel: kxcjk-1013: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: accel: mxc4005: Fix overread of data and alignment issue.
  iio: accel: stk8312: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: accel: stk8ba50: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: ti-ads1015: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: vf610: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: gyro: bmg160: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: humidity: am2315: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: prox: srf08: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: prox: pulsed-light: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: prox: as3935: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: magn: hmc5843: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: magn: bmc150: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: light: isl29125: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: light: tcs3414: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: light: tcs3472: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()

 drivers/iio/accel/bma180.c                    | 10 +++++---
 drivers/iio/accel/bma220_spi.c                | 10 +++++---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 13 ++++++----
 drivers/iio/accel/kxcjk-1013.c                | 24 +++++++++++--------
 drivers/iio/accel/mxc4005.c                   | 10 +++++---
 drivers/iio/accel/stk8312.c                   | 12 ++++++----
 drivers/iio/accel/stk8ba50.c                  | 17 +++++++------
 drivers/iio/adc/ti-ads1015.c                  | 12 ++++++----
 drivers/iio/adc/vf610_adc.c                   | 10 +++++---
 drivers/iio/gyro/bmg160_core.c                | 10 +++++---
 drivers/iio/humidity/am2315.c                 | 16 ++++++++-----
 drivers/iio/light/isl29125.c                  | 10 +++++---
 drivers/iio/light/tcs3414.c                   | 10 +++++---
 drivers/iio/light/tcs3472.c                   | 10 +++++---
 drivers/iio/magnetometer/bmc150_magn.c        | 11 +++++----
 drivers/iio/magnetometer/hmc5843.h            |  8 +++++--
 drivers/iio/magnetometer/hmc5843_core.c       |  4 ++--
 drivers/iio/proximity/as3935.c                | 10 +++++---
 .../iio/proximity/pulsedlight-lidar-lite-v2.c | 10 +++++---
 drivers/iio/proximity/srf08.c                 | 14 +++++------
 20 files changed, 148 insertions(+), 83 deletions(-)

-- 
2.31.1

