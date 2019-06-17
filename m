Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003E848D9F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFQTKy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 15:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfFQTKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jun 2019 15:10:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FD120863;
        Mon, 17 Jun 2019 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560798653;
        bh=fvMKl9QM70tfD0LeebcXub5YauhZRB5PidbKCjU4uVM=;
        h=Date:From:To:Subject:From;
        b=oJjOfkZZdorHwpWjWOOrsNJQ+ij4ePv/6dc3f9r70JUNuF0OLi7Aq//DNz3MuqwQ6
         A5SPc64BEyQOz92BMWJDeDdsiJpgdpm5bPwrM5CJpOuvmBOwGRrV7SfcIB+Bst1BqV
         vWdqAKVhHWkWb3b7xgOfsAi8x4ceHWP6JWWuvx7s=
Date:   Mon, 17 Jun 2019 20:10:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 5.2 cycle.
Message-ID: <20190617201049.6a914ae0@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e61ff0fba72d981449c90b5299cebb74534b6f7c:

  staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC2000' (2019-05-24 09:41:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.2b

for you to fetch changes up to 0c75376fa3950b9875559dd79f73c36a5498a969:

  counter/ftm-quaddec: Add missing dependencies in Kconfig (2019-06-08 13:07:41 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 5.2 cycle.

* ad7150
  - sense of bit for controlling adaptive vs fixed threshold was flipped.
* adt7316
  - Fix a build issue due to wrong headers for gpio usage.
* lsm6dsx
  - correctly suspend / resume i2c slaves when the host goes to sleep.
* mlx90632
  - relax a compatability check to allow for newer devices.

Also one counters fix

* counter/ftm-quaddec
  - missing dependencies in Kconfig.

----------------------------------------------------------------
Crt Mori (1):
      iio: temperature: mlx90632 Relax the compatibility check

Fabio Estevam (1):
      staging: iio: adt7316: Fix build errors when GPIOLIB is not set

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller

Melissa Wen (1):
      staging:iio:ad7150: fix threshold mode config bit

Patrick Havelange (1):
      counter/ftm-quaddec: Add missing dependencies in Kconfig

 drivers/counter/Kconfig                      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++++++--------
 drivers/iio/temperature/mlx90632.c           |  9 +++++++--
 drivers/staging/iio/addac/adt7316.c          |  3 ++-
 drivers/staging/iio/cdc/ad7150.c             | 19 +++++++++++--------
 6 files changed, 40 insertions(+), 19 deletions(-)
