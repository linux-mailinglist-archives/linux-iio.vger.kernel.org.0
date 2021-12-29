Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B94815AF
	for <lists+linux-iio@lfdr.de>; Wed, 29 Dec 2021 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhL2RSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 12:18:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53316 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhL2RSK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 12:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27186153D
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 17:18:09 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2A4C9C36AE9;
        Wed, 29 Dec 2021 17:18:07 +0000 (UTC)
Date:   Wed, 29 Dec 2021 17:23:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO new device support and cleanups for 5.17
Message-ID: <20211229172354.605d75c9@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 1bb866dcb8cf5054de88f592fc0ec1f275ad9d63:

  Merge tag 'iio-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2021-12-22 12:33:01 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.17b

for you to fetch changes up to 38ac2f038666521f94d4fa37b5a9441cef832ccf:

  iio: chemical: sunrise_co2: set val parameter only on success (2021-12-28 18:37:41 +0000)

----------------------------------------------------------------
2nd set of new device support etc for IIO in the 5.17 cycle.

A small additional set of things that just missed the previous
pull request and have mostly been through plenty of review before the
holiday period began (or are trivial).  I've not taken some other series
on the list to allow for more eyes after the holiday period.

New device support
* adi,admv1013
  - New driver for this wideband microwave upconverter including dt-bindings
    and some device specific ABI due to the need to describe phase calibrations
    of a differential channel on both i and q phases. Previously we could
    do differential or i/q but not both on the same channel. The driver
    ABI uses a workaround for core support which will do until we know if
    this is a common requirement for which a more generic solution is
    needed.

MAINTAINERS:
* Add Haibo Chen as a maintainer for various NXP SoC ADCs.

Minor cleanup:
* sunrise_co2
  - Make sure an uninitialized value isn't used to set *val in read_raw().
    Not a real bug, but a compiler or reviewer can't tell that based
    on what they can see locally.

----------------------------------------------------------------
Antoniu Miclaus (3):
      iio: frequency: admv1013: add support for ADMV1013
      dt-bindings: iio: frequency: add admv1013 doc
      Documentation:ABI:testing:admv1013: add ABI docs

Haibo Chen (2):
      MAINTAINERS: add imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer
      dt-bindings:iio:adc: update the maintainer of vf610-adc

Tom Rix (1):
      iio: chemical: sunrise_co2: set val parameter only on success

 .../ABI/testing/sysfs-bus-iio-frequency-admv1013   |  38 ++
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml |   2 +-
 .../bindings/iio/frequency/adi,admv1013.yaml       |  91 +++
 MAINTAINERS                                        |  12 +
 drivers/iio/chemical/sunrise_co2.c                 |   4 +-
 drivers/iio/frequency/Kconfig                      |  10 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/admv1013.c                   | 656 +++++++++++++++++++++
 8 files changed, 811 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
 create mode 100644 drivers/iio/frequency/admv1013.c
