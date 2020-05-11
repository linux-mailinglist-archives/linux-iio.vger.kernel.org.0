Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D41CE399
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgEKTL7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 15:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTL7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 15:11:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C467206E6;
        Mon, 11 May 2020 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589224318;
        bh=y6wmr4MoqUoWmVIt3d7OFxQPoqzir6uX21teSxuChqg=;
        h=Date:From:To:Subject:From;
        b=Ft4pYutGlsk0x6Kng2vmsWLxR3AYoysyzUXQFZ7koNRpfQX4hUzxswYSxrNag4PSQ
         ipBL+9LIvcwd3z/Q+Ti2Sohbt7ykHTVxMOv2/RyNTdUCZZ7AGrQ6Mvtnxop2TUVT/V
         QUTgglzy2QxUhEa3ft/nDFo1EzqIytjo5b84swg4=
Date:   Mon, 11 May 2020 20:11:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for the 5.7 cycle.
Message-ID: <20200511201150.13576144@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit c532cc617e6edc4398a9ec5c8f470833966f9f9f:

  Merge tag 'iio-fixes-for-5.7a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-04-20 14:07:00 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.7b

for you to fetch changes up to 928edefbc18cd8433f7df235c6e09a9306e7d580:

  iio: sca3000: Remove an erroneous 'get_device()' (2020-05-10 10:53:36 +0100)

----------------------------------------------------------------
iio-fixes-for-5.7b Second set of fixes for IIO in the 5.7 cycle.

Usual mixed bag of breakage in new code and ancient bugs.

ad2s1210
- Fix missing CS change needed to actually read anything.
atlas-sensor
- Avoid clashing scan index with the timestamp channel.
sca3000
- Fix a randomly placed get_device in an error message print.
st_lsm6dsx
- Fix missing unlock in error path.
stm32-adc
- Fix which device is used to request DMA to ensure it's one
  that has actually been registered at point of use.
stm32-dfsdm
- Fix which device is used to request DMA to ensure it's one
  that has actually been registered at poitn of use.
ti-ads8344
- Fix channel selection.
vf610 dac
- Fix some missing error handling code.

----------------------------------------------------------------
Christophe JAILLET (2):
      iio: dac: vf610: Fix an error handling path in 'vf610_dac_probe()'
      iio: sca3000: Remove an erroneous 'get_device()'

Dan Carpenter (1):
      iio: imu: st_lsm6dsx: unlock on error in st_lsm6dsx_shub_write_raw()

Dragos Bogdan (1):
      staging: iio: ad2s1210: Fix SPI reading

Fabrice Gasnier (2):
      iio: adc: stm32-adc: fix device used to request dma
      iio: adc: stm32-dfsdm: fix device used to request dma

Gregory CLEMENT (1):
      iio: adc: ti-ads8344: Fix channel selection

Matt Ranostay (1):
      iio: chemical: atlas-sensor: correct DO-SM channels

 drivers/iio/accel/sca3000.c                  |  2 +-
 drivers/iio/adc/stm32-adc.c                  |  8 ++++----
 drivers/iio/adc/stm32-dfsdm-adc.c            | 21 +++++++++++----------
 drivers/iio/adc/ti-ads8344.c                 |  8 +++++---
 drivers/iio/chemical/atlas-sensor.c          | 14 +++++++++++++-
 drivers/iio/dac/vf610_dac.c                  |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  7 +++++--
 drivers/staging/iio/resolver/ad2s1210.c      | 17 ++++++++++++-----
 8 files changed, 52 insertions(+), 26 deletions(-)
