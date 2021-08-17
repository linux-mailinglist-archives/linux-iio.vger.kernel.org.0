Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEC3EEEF3
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhHQPKb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 17 Aug 2021 11:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237052AbhHQPKa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 11:10:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F127A61073;
        Tue, 17 Aug 2021 15:09:56 +0000 (UTC)
Date:   Tue, 17 Aug 2021 16:12:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of new IIO device support, cleanups and fixes for
 the 5.15 cycle.
Message-ID: <20210817161258.2e015e20@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit f805ef1ce5d695c260986fdf2e28f5d6c98cf3a8:

  Merge tag 'iio-for-5.15a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-08-15 08:32:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.15b

for you to fetch changes up to d484c21bacfa8bd2fa9fc26393ec59108f508c4c:

  iio: adc: Add driver for Renesas RZ/G2L A/D converter (2021-08-15 17:03:13 +0100)

----------------------------------------------------------------
2nd set of new IIO device support and cleanups for the 5.15 cycle.

A small pull request to pick up a few new drivers and some cleanup
and fix patches.

New device support
* ad5110 non-volatile digital potentiometer
  - New driver
* renesas rzl/gl2 12-bit / 8 channel ADC block
  - New driver and bindings

Minor or late breaking fixes and cleanups
* ltc2983
  - Fix a false assumption of initial interrupt during probe().
* hp03
  - Use devm_* to simplify probe and allow the remove function to be dropped.
* rockchip_saradc
  - Use a regulator notifier to reduce overheads of querying the scale.

----------------------------------------------------------------
David Wu (1):
      iio: adc: rockchip_saradc: add voltage notifier so get referenced voltage once at probe

Lad Prabhakar (2):
      dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
      iio: adc: Add driver for Renesas RZ/G2L A/D converter

Mugilraj Dhavachelvan (2):
      dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
      iio: potentiometer: Add driver support for AD5110

Nuno Sá (1):
      iio: ltc2983: fix device probe

Théo Borém Fabris (1):
      iio: pressure: hp03: update device probe to register with devm functions

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        | 134 +++++
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |  14 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rockchip_saradc.c                  |  47 +-
 drivers/iio/adc/rzg2l_adc.c                        | 600 +++++++++++++++++++++
 drivers/iio/potentiometer/Kconfig                  |  10 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ad5110.c                 | 344 ++++++++++++
 drivers/iio/pressure/hp03.c                        |  36 +-
 drivers/iio/temperature/ltc2983.c                  |  30 +-
 12 files changed, 1177 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 drivers/iio/adc/rzg2l_adc.c
 create mode 100644 drivers/iio/potentiometer/ad5110.c
