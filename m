Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACD2B505E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKPS5Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 13:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgKPS5Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Nov 2020 13:57:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0FF2224B;
        Mon, 16 Nov 2020 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605553044;
        bh=5KBtgxhFWa5VWBosOKqRJB478FKqnFETrHTCu/4KitA=;
        h=Date:From:To:Subject:From;
        b=Q+K5sCBW7K9dJD1VK5uE0WQvtkMZVcnjAIwin2cm08nLjxGNglmyafBAyFtyB6c7r
         9sqv2ROwF3uubMq3VPZzYcFnsK8/mACI1qrPIm1vcicI0aCLxwELkmhZ9PTKNFhqxT
         h5EUWyxiSRyPQsqI8JXUqUlZk8DU4s9WUuUwtpnw=
Date:   Mon, 16 Nov 2020 18:57:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO and counter fixes for the 5.10 cycle.
Message-ID: <20201116185719.17696afa@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 7e97e4cbf30026b49b0145c3bfe06087958382c5:

  staging: fieldbus: anybuss: jump to correct label in an error path (2020-10-27 13:24:51 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.10a

for you to fetch changes up to e5b1032a656e9aa4c7a4df77cb9156a2a651a5f9:

  iio: accel: kxcjk1013: Add support for KIOX010A ACPI DSM for setting tablet-mode (2020-11-14 17:33:47 +0000)

----------------------------------------------------------------
First set of IIO and counter fixes for the 5.10 cycle.

IIO

cros_ec
 - Provide defauts for max and min frequency when older machines fail
   to return them correctly.
ingenic-adc
 - Fix wrong vref value for JZ4770 SoC
 - Fix AUX / VBAT readings when touchscreen in use by pausing touchscreen
   readings during a read of these channels.
kxcjk1013
 - Fix an issue with KIOX010A ACPI id using devices which need to run
   a ACPI device specific method to avoid leaving the keyboard disabled.
   Includes a minor precursor patch to make this fix easier to do.
mt6577-auxadc
 - Fix an issue with dev_comp not being set resulting in a null ptr deref.
st_lsm6dsx
 - Set a 10ms min shub slave timeout to handle fast snesors where more time
   is needed to set up the config than the cycles allowed.
stm32-adc
 - Fix an issue due to a clash between an ADC configured to use IRQs and
   a second configured to use DMA cause by some incorrect register masking.
vcnl4035
 - Kconfig missing dependency

Counter

ti-eqep
 - wrong value for max_register as one beyond the end instead of the end.

----------------------------------------------------------------
David Lechner (1):
      counter/ti-eqep: Fix regmap max_register

Fabien Parent (1):
      iio: adc: mediatek: fix unset field

Gwendal Grignou (1):
      iio: cros_ec: Use default frequencies when EC returns invalid information

Hans de Goede (2):
      iio: accel: kxcjk1013: Replace is_smo8500_device with an acpi_type enum
      iio: accel: kxcjk1013: Add support for KIOX010A ACPI DSM for setting tablet-mode

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: set 10ms as min shub slave timeout

Necip Fazil Yildiran (1):
      iio: light: fix kconfig dependency bug for VCNL4035

Olivier Moysan (1):
      iio: adc: stm32-adc: fix a regression when using dma and irq

Paul Cercueil (2):
      iio/adc: ingenic: Fix battery VREF for JZ4770 SoC
      iio/adc: ingenic: Fix AUX/VBAT readings when touchscreen is used

 drivers/counter/ti-eqep.c                          |  4 +-
 drivers/iio/accel/kxcjk-1013.c                     | 51 +++++++++++++++++++---
 drivers/iio/adc/ingenic-adc.c                      | 34 ++++++++++++---
 drivers/iio/adc/mt6577_auxadc.c                    |  6 ++-
 drivers/iio/adc/stm32-adc-core.c                   | 41 ++++++++---------
 drivers/iio/adc/stm32-adc.c                        | 50 ++++++++++++++++++++-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 16 ++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  6 ++-
 drivers/iio/light/Kconfig                          |  1 +
 9 files changed, 160 insertions(+), 49 deletions(-)
