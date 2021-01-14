Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44D2F6DF8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jan 2021 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhANWPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jan 2021 17:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbhANWPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Jan 2021 17:15:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8371B21D42;
        Thu, 14 Jan 2021 22:14:27 +0000 (UTC)
Date:   Thu, 14 Jan 2021 22:14:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO and counter fixes for the 5.11 cycle.
Message-ID: <20210114221424.72c7e5f5@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.11a

for you to fetch changes up to b8653aff1c8876142f965fc69e12ba217da13182:

  iio: sx9310: Fix semtech,avg-pos-strength setting when > 16 (2021-01-14 21:01:22 +0000)

----------------------------------------------------------------
First set of IIO and counter fixes for the 5.11 cycle.

Counter fixes

ti,eqep
- Remove floor interface as the device always wraps to 0.

IIO

adi,ad5504
- Fix inverted power state control.
bosch,bma255
- Fix a difference in part naming between dt-binding doc and the driver.
melexis,mlx90632
- Add a delay after reset command.
semtech,sx9310
- Off by one error.
- Fix an issue due to need to skip a value in a power of 2 series.
st,st_sensors
- Fix a possible infinite loop if data read is not define or reading it fails.
ti,am335x
- Remove a left over iio_kfifo_free after managed allocation conversion.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()

Dan Carpenter (1):
      iio: sx9310: Off by one in sx9310_read_thresh()

David Lechner (1):
      counter:ti-eqep: remove floor

Lars-Peter Clausen (1):
      iio: ad5504: Fix setting power-down state

Lorenzo Bianconi (1):
      iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread

Slaveyko Slaveykov (1):
      drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c

Stephan Gerhold (1):
      dt-bindings: iio: accel: bma255: Fix bmc150/bmi055 compatible

Stephen Boyd (1):
      iio: sx9310: Fix semtech,avg-pos-strength setting when > 16

 .../bindings/iio/accel/bosch,bma255.yaml           |  4 +--
 drivers/counter/ti-eqep.c                          | 35 ----------------------
 drivers/iio/adc/ti_am335x_adc.c                    |  6 +---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 31 ++++++++++---------
 drivers/iio/dac/ad5504.c                           |  4 +--
 drivers/iio/proximity/sx9310.c                     |  5 ++--
 drivers/iio/temperature/mlx90632.c                 |  6 ++++
 7 files changed, 31 insertions(+), 60 deletions(-)
