Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C932176A4
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jul 2020 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGGS0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jul 2020 14:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGGS0P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Jul 2020 14:26:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E035E206F6;
        Tue,  7 Jul 2020 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594146374;
        bh=CjZcAC4AUGqH+HjIN682gSE2dmjGOamtHOQZoOLuriE=;
        h=Date:From:To:Cc:Subject:From;
        b=kY9v4EqS68GpM9N3PThNk89xKNdj8BsUe4yYTDrsYSl/C9Hdylu88teRYZoATHBHs
         T0qjcLzUf3YsCizNw48V71OC3z4qwd2hH15VmXesaYlw7lhU2Ovq670vfm4NEEqn9f
         q99wszw+dhZX8RitBPoZVT0X4IjpoGCV4TQCECHM=
Date:   Tue, 7 Jul 2020 19:26:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.8 cycle.
Message-ID: <20200707192611.6a5d3e99@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit b791d1bdf9212d944d749a5c7ff6febdba241771:

  Merge tag 'locking-kcsan-2020-06-11' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tip/tip (2020-06-11 18:55:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixe=
s-for-5.8a

for you to fetch changes up to b0536f9826a5ed3328d527b4fc1686867a9f3041:

  iio: adc: ad7780: Fix a resource handling path in 'ad7780_probe()' (2020-=
07-05 14:22:48 +0100)

----------------------------------------------------------------
First set of IIO and counter fixes in the 5.8 cycle.

The buffer alignment fixes continue to trickle through as we get
reviews in.  The rest are the standard mixed bag of long term issues
just discovered an things we missed in this cycle.

IIO fixes

* core
  - Add missing IIO_MOD_H2 and ETHANOL strings. Somehow got missed
    when drivers were added using these in attribute names.
* afe4403, afe4404, ak8974, hdc100x, hts221, ms5611
  - Fix a recently identified issue with alignment when using
    iio_push_to_buffers_with_timestamp which assumes the timestamp
    is 8 byte aligned.
* ad7780
  - Fix a some premature / excess cleanup in an error path.
* adi-axi-adc
  - Fix reference counting on the wrong object.
* ak8974
  - Fix unbalance runtime pm.
* mma8452
  - Fix missing iio_device_unregister in error path.
* zp2326
  - Error handling for pm_runtime_get_sync failing.

counter fixes
* Add lock guards in 104-quad-8 to protect against races - done
  in 2 patches to allow easy back porting.

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: adc: ad7780: Fix a resource handling path in 'ad7780_probe()'

Chuhong Yuan (1):
      iio: mma8452: Add missed iio_device_unregister() call in mma8452_prob=
e()

Dinghao Liu (1):
      iio: magnetometer: ak8974: Fix runtime PM imbalance on error

Jonathan Cameron (6):
      iio:health:afe4403 Fix timestamp alignment and prevent data leak.
      iio:health:afe4404 Fix timestamp alignment and prevent data leak.
      iio:magnetometer:ak8974: Fix alignment and data leak issues
      iio:humidity:hdc100x Fix alignment and data leak issues
      iio:humidity:hts221 Fix alignment and data leak issues
      iio:pressure:ms5611 Fix buffer element alignment

Matt Ranostay (1):
      iio: core: add missing IIO_MOD_H2/ETHANOL string identifiers

Navid Emamdoost (1):
      iio: pressure: zpa2326: handle pm_runtime_get_sync failure

Nuno S=C3=A1 (1):
      iio: adc: adi-axi-adc: Fix object reference counting

Syed Nayyar Waris (2):
      counter: 104-quad-8: Add lock guards - differential encoder
      counter: 104-quad-8: Add lock guards - filter clock prescaler

 drivers/counter/104-quad-8.c         | 22 +++++++++++++++++++---
 drivers/iio/accel/mma8452.c          |  5 ++++-
 drivers/iio/adc/ad7780.c             |  2 +-
 drivers/iio/adc/adi-axi-adc.c        |  4 ++--
 drivers/iio/health/afe4403.c         |  9 ++++++---
 drivers/iio/health/afe4404.c         |  8 +++++---
 drivers/iio/humidity/hdc100x.c       | 10 +++++++---
 drivers/iio/humidity/hts221.h        |  7 +++++--
 drivers/iio/humidity/hts221_buffer.c |  9 +++++----
 drivers/iio/industrialio-core.c      |  2 ++
 drivers/iio/magnetometer/ak8974.c    | 29 +++++++++++++++++------------
 drivers/iio/pressure/ms5611_core.c   | 11 ++++++++---
 drivers/iio/pressure/zpa2326.c       |  4 +++-
 13 files changed, 84 insertions(+), 38 deletions(-)
