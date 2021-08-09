Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88E73E4CBD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhHITN7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 9 Aug 2021 15:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235487AbhHITN6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 15:13:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FC560E09;
        Mon,  9 Aug 2021 19:13:37 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:16:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 5.14
Message-ID: <20210809201626.36d04053@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.14a

for you to fetch changes up to 5afc1540f13804a31bb704b763308e17688369c5:

  iio: adc: Fix incorrect exit of for-loop (2021-07-31 14:46:05 +0100)

----------------------------------------------------------------
First set of fixes for IIO in the 5.14 cycle

adi,adis:
 - Ensure GPIO pin direction set explicitly in driver.
fxls8952af:
 - Fix use of ret when not initialized.
 - Fix issue with use of module symbol from built in.
hdc100x:
 - Add a margin to conversion time as some parts run to slowly.
palmas-adc:
 - Fix a wrong exit condition that leads to adc period always being set
   to maximum value.
st,sensors:
 - Drop a wrong restriction on number of interrupts in dt binding.
ti-ads7950:
 - Ensure CS deasserted after channel read.

----------------------------------------------------------------
Antti Keränen (1):
      iio: adis: set GPIO reset pin direction

Arnd Bergmann (1):
      iio: accel: fxls8962af: fix i2c dependency

Chris Lesiak (1):
      iio: humidity: hdc100x: Add margin to the conversion time

Colin Ian King (1):
      iio: adc: Fix incorrect exit of for-loop

Maxime Ripard (1):
      dt-bindings: iio: st: Remove wrong items length check

Sean Nyekjaer (1):
      iio: accel: fxls8962af: fix potential use of uninitialized symbol

Uwe Kleine-König (1):
      iio: adc: ti-ads7950: Ensure CS is deasserted after reading channels

 .../devicetree/bindings/iio/st,st-sensors.yaml     | 41 ----------------------
 drivers/iio/accel/Kconfig                          |  2 ++
 drivers/iio/accel/fxls8962af-core.c                |  2 +-
 drivers/iio/adc/palmas_gpadc.c                     |  4 +--
 drivers/iio/adc/ti-ads7950.c                       |  1 -
 drivers/iio/humidity/hdc100x.c                     |  6 ++--
 drivers/iio/imu/adis.c                             |  3 +-
 7 files changed, 10 insertions(+), 49 deletions(-)
