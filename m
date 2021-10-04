Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA47421762
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 21:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhJDTZU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Oct 2021 15:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238303AbhJDTZQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Oct 2021 15:25:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A8561269;
        Mon,  4 Oct 2021 19:23:26 +0000 (UTC)
Date:   Mon, 4 Oct 2021 20:27:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for the 5.15 cycles
Message-ID: <20211004202726.6dfbad58@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.15a

for you to fetch changes up to 26d90b5590579def54382a2fc34cfbe8518a9851:

  iio: light: opt3001: Fixed timeout error when 0 lux (2021-10-03 16:43:25 +0100)

----------------------------------------------------------------
1st set of IIO fixes for the 5.15 cycle

Usual mixed back of minor bug fixes.

adi,ad7192, ad7780, ad7793
* Fix incorrect IRQ_FLAG types.  As the IRQ line is shared with the data
  line we can be sure of the polarity and edge like nature. They were
  previously either left unspecified or as level interrupts which may
  cause problems on power up.
adi,adis16475
* Fix a deadlock by calling unlocked function when lock already held. Also
  deal with making sure lock is released correctly.
adi,adis16480
* Fix assumption that all devices support sleep mode.
aspeed,adc
* Add missing platform_set_drvdata() so we can get the indio_dev in remove
  as was being assumed.
fsl,fxls8962af
* Return IRQ_HANDLED on flush rather than a positive 'error' code.
maxim,max1207
* Fix a wrong shift on 12-bit devices that will lead to incorrect scale.
* Fix wrong number of channels on max1X31 devices due to allocating them twice.
mediatek,mt6577
* Fix a failure to apply scaling to IIO_CHAN_INFO_PROCESSED
renesas,rzg2l
* Fix failure to return -EBUSY on timeout due to ignored error code.
* Add a missing clk_disable_unprepare() on error in runtime_resume.
samsung,ssp_spi
* Fix an error code to always be returned on invalid length.
* Add some range checking to ensure resilience against bad data leading
  to potential overflow.
ti,adc128s052
* Fix an error handling path that leaves regulator on if probe fails.
ti,dac5571
* Add missing return value in a switch default.
ti,opt3001
* Fix case where sensor returns 0 lux and we were previously accidentally
  returning that this was a timeout.

----------------------------------------------------------------
Alexandru Tachici (3):
      iio: adc: ad7192: Add IRQ flag
      iio: adc: ad7780: Fix IRQ flag
      iio: adc: ad7793: Fix IRQ flag

Billy Tsai (1):
      iio: adc: aspeed: set driver data when adc probe.

Christophe JAILLET (1):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'

Colin Ian King (1):
      iio: adc: rzg2l_adc: Fix -EBUSY timeout error return

Dan Carpenter (3):
      iio: dac: ti-dac5571: fix an error code in probe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()

Hui Liu (1):
      iio: mtk-auxadc: fix case IIO_CHAN_INFO_PROCESSED

Jiri Valek - 2N (1):
      iio: light: opt3001: Fixed timeout error when 0 lux

Miquel Raynal (2):
      iio: adc: max1027: Fix wrong shift with 12-bit devices
      iio: adc: max1027: Fix the number of max1X31 channels

Nuno Sá (2):
      iio: adis16475: fix deadlock on frequency set
      iio: adis16480: fix devices that do not support sleep mode

Sean Nyekjaer (1):
      iio: accel: fxls8962af: return IRQ_HANDLED when fifo is flushed

Yang Yingliang (1):
      iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()

 drivers/iio/accel/fxls8962af-core.c      |  2 +-
 drivers/iio/adc/ad7192.c                 |  1 +
 drivers/iio/adc/ad7780.c                 |  2 +-
 drivers/iio/adc/ad7793.c                 |  2 +-
 drivers/iio/adc/aspeed_adc.c             |  1 +
 drivers/iio/adc/max1027.c                |  3 +--
 drivers/iio/adc/mt6577_auxadc.c          |  8 ++++++++
 drivers/iio/adc/rzg2l_adc.c              |  6 ++++--
 drivers/iio/adc/ti-adc128s052.c          |  6 ++++++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 11 +++++++++--
 drivers/iio/dac/ti-dac5571.c             |  1 +
 drivers/iio/imu/adis16475.c              |  3 ++-
 drivers/iio/imu/adis16480.c              | 14 +++++++++++---
 drivers/iio/light/opt3001.c              |  6 +++---
 14 files changed, 50 insertions(+), 16 deletions(-)
