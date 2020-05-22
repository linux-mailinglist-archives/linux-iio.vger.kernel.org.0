Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8471DEDC7
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgEVQ7g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 12:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbgEVQ7g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 May 2020 12:59:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2030E20738;
        Fri, 22 May 2020 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590166775;
        bh=pHZ/qjX4HavbblvMvja4IPTwn3VR55v5A1uOWXOmLsc=;
        h=Date:From:To:Subject:From;
        b=GdrlhA/aJCaDPzLH8i5MiTVD5vmnmzu+1kSwsHfjme/phIiFrGJTWIYjsKmDaMddo
         n1h6U/lemkeBR5qaxrgPoHQWDA6ZmuUeNRIh00EWXRjc+fWpD8L0TJgS2fXLtKchO0
         zkgJ4iuV5glfq1IRZYaOMeBGp2v78wDe2J2ZC0kM=
Date:   Fri, 22 May 2020 17:59:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 3rd set of new devices, cleanups and late breaking minor
 fixes for IIO in the 5.8 cycle.
Message-ID: <20200522175931.1d91d3e4@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


he following changes since commit cef077e6aa4c7dbe2f23e1201cf705f9540ec467:

  Merge tag 'iio-for-5.8b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-05-15 16:03:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.8c

for you to fetch changes up to 13e945631c2ffb946c0af342812a3cd39227de6e:

  iio:chemical:pms7003: Fix timestamp alignment and prevent data leak. (2020-05-22 17:31:05 +0100)

----------------------------------------------------------------
Third set of IIO new device support, cleanups etc for the 5.8 cycle.

A rather late final set to pick up a couple of new drivers, a bunch
of cleanup and some fixes that can wait for the merge window.

In particularly I'd like to highlight the great core and driver
cleanup work that the Alex and the team at Analog devices are currently
doing.  Should see lots more of that in the next cycle give what is
currently under review.

This pull also has the first few fixes squashing a class of alignment
and small kernel data leak bugs that Lars-Peter Clausen picked up
on in a review.  Quite a few more of those to come.  They've been
there a long time so we aren't rushing the reviews.

New device support
* atlas ezo
  - new driver supporting this range of chemical and similar sensors
    with the odd interface of ascii strings over i2c.
* bma180
  - bma023, bma150 and smb380 support.  Note these are currently also
    supported by a driver in input which we will hopefully remove
    (eventually). There are Kconfig protections to avoid a clash
    in the meantime.
* vcnl3020
  - new driver for this proximity sensor.

Core change
* during buffer updates, change the current state variable before
  we actually call pre and post enable callbacks so drivers can know
  where we are going.  Note this is a precursor to only exposing
  one enable callback to drivers.  The (false) logic behind having two
  such callbacks has long been fixed, but only now is the mess getting
  cleaned up.

Features
* exynos adc.
  - add reporting of channels scale values.

Cleanups and minor fixes.
* core
  - drop now unused attrcount_orig variable.
* ad5360, ad5446, ad5449, ad5755, ad5761, ad5764, ad5380, ad5421,
  ad5592, ad5686 and vf610_dac
  - remove direct use of iio_dev->mlock from all these drivers.
    Its semantics used to be poorly defined, but now it is for core
    use only.  Removing it's use in drivers has been a long process
    of which this is the latest step!
* exynos_adc
  - drop a pointless check on the phy as the driver doesn't access it.
* ping
  - avoid a dance from iio_priv and iio_priv_to_dev back again by
    just passing the iio_dev into the functions.
* pms7003
  - alignment and potential data leak fix.
* sps30
  - alignment bug fix.

----------------------------------------------------------------
Alexandru Ardelean (2):
      iio: buffer: remove attrcount_orig var from sysfs creation
      iio: proximity: ping: pass reference to IIO device as param to ping_read()

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix a wrong error message when probing interrupts

Ivan Mikhaylov (2):
      dt-bindings: proximity: provide vcnl3020 device tree binding document
      iio: proximity: Add driver support for vcnl3020 proximity sensor

Jonathan Bakker (9):
      iio: accel: bma180: Prepare for different reset values
      iio: accel: Make bma180 conflict with input's bma150
      dt-bindings: iio: accel: Add bma150 family compatibles to bma180
      dt-bindings: iio: accel: Add required regulators to bma180
      iio: accel: bma180: Add support for bma023
      iio: accel: bma180: Rename center_temp to temp_offset
      iio: accel: Add bma150/smb380 support to bma180
      iio: adc: Add scaling support to exynos adc driver
      iio: light: gp2ap002: Take runtime PM reference on light read

Jonathan Cameron (2):
      iio:chemical:sps30: Fix timestamp alignment
      iio:chemical:pms7003: Fix timestamp alignment and prevent data leak.

Krzysztof Kozlowski (1):
      iio: adc: exynos: Simplify Exynos7-specific init

Lars-Peter Clausen (1):
      iio: __iio_update_buffers: Update mode before preenable/after postdisable

Matt Ranostay (2):
      dt-bindings: iio: chemical: add CO2 EZO module documentation
      iio: chemical: add atlas-ezo-sensor initial support

Sergiu Cuciurean (11):
      iio: dac: ad5360: Replace indio_dev->mlock with own device lock
      iio: dac: ad5446: Replace indio_dev->mlock with own device lock
      iio: dac: ad5449: Replace indio_dev->mlock with own device lock
      iio: dac: ad5755: Replace indio_dev->mlock with own device lock
      iio: dac: ad5761: Replace indio_dev->mlock with own device lock
      iio: dac: ad5764: Replace indio_dev->mlock with own device lock
      iio: dac: ad5380: Replace indio_dev->mlock with own device lock
      iio: dac: ad5421: Replace indio_dev->mlock with own device lock
      iio: dac: ad5686: Replace indio_dev->mlock with own device lock
      iio: dac: vf610_dac: Replace indio_dev->mlock with own device lock
      iio: dac: ad5592r-base: Replace indio_dev->mlock with own device lock

 .../devicetree/bindings/iio/accel/bma180.txt       |   8 +-
 .../bindings/iio/chemical/atlas,sensor.yaml        |   6 +-
 .../bindings/iio/proximity/vishay,vcnl3020.yaml    |  62 +++++
 drivers/iio/accel/Kconfig                          |   8 +-
 drivers/iio/accel/bma180.c                         | 208 +++++++++++++++--
 drivers/iio/adc/exynos_adc.c                       |  17 +-
 drivers/iio/adc/stm32-adc-core.c                   |  34 ++-
 drivers/iio/chemical/Kconfig                       |  11 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ezo-sensor.c            | 177 ++++++++++++++
 drivers/iio/chemical/pms7003.c                     |  17 +-
 drivers/iio/chemical/sps30.c                       |   9 +-
 drivers/iio/dac/ad5360.c                           |  17 +-
 drivers/iio/dac/ad5380.c                           |   8 +-
 drivers/iio/dac/ad5421.c                           |  21 +-
 drivers/iio/dac/ad5446.c                           |  12 +-
 drivers/iio/dac/ad5449.c                           |  12 +-
 drivers/iio/dac/ad5592r-base.c                     |  30 +--
 drivers/iio/dac/ad5592r-base.h                     |   1 +
 drivers/iio/dac/ad5686.c                           |  10 +-
 drivers/iio/dac/ad5686.h                           |   2 +
 drivers/iio/dac/ad5755.c                           |  22 +-
 drivers/iio/dac/ad5761.c                           |  12 +-
 drivers/iio/dac/ad5764.c                           |  12 +-
 drivers/iio/dac/vf610_dac.c                        |  11 +-
 drivers/iio/industrialio-buffer.c                  |  14 +-
 drivers/iio/light/gp2ap002.c                       |  19 +-
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/ping.c                       |   7 +-
 drivers/iio/proximity/vcnl3020.c                   | 258 +++++++++++++++++++++
 31 files changed, 908 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
 create mode 100644 drivers/iio/chemical/atlas-ezo-sensor.c
 create mode 100644 drivers/iio/proximity/vcnl3020.c
