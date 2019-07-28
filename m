Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED7077EB3
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfG1I6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 04:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1I6i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 04:58:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FB72085A;
        Sun, 28 Jul 2019 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564304317;
        bh=HpJyrdAEgaLUXNfCZ8pVjwQoqG51nSXC0WuP3nAwKxY=;
        h=Date:From:To:Cc:Subject:From;
        b=tfB+USMox9nLNm97fs5wr28MemKFhW6n+frZ4YCYHgpUrl9Pvx3Lz2tYLHHeT+Sgi
         oav88jY5llgeS+2Ucgmc1WKwf6A45HG5SEwj9kQcWH4WG+SnKZUOMBkOwb6X0QTXY/
         4sVqVaEzGxUGPYdZjKFnW4a2UT7rhNeBKmn94xHw=
Date:   Sun, 28 Jul 2019 09:58:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for 5.3
Message-ID: <20190728095828.01c5cbe2@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit d7d170a8e357bd9926cc6bfea5c2385c2eac65b2:

  Merge tag 'tag-chrome-platform-for-v5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux (2019-07-11 18:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.3a

for you to fetch changes up to 90c6260c1905a68fb596844087f2223bd4657fee:

  iio: adc: gyroadc: fix uninitialized return code (2019-07-27 21:56:59 +0100)

----------------------------------------------------------------
First set of IIO fixes in the 5.3 cycle.

* cros_ec_accel_legacy
  - Fix a false double entry for channel scale as both per channel
    and shared.
* gyro_adc
  - Fix uninitialized return code that got detected by GCC 9.0 having
    be previously missed.
* ingenic_adc
  - Set the clock divider on probe to avoid an issue seen with false
    button press detections on JZ4725B SoCs.
* max9611
  - Backwards parameters in GENMASK.
* mpu6050
  - Enforce the fact only certain scan modes are actually possible.

One counter fix also picked up for William,

* generic-counter.rst
  - Fix some references.

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: adc: gyroadc: fix uninitialized return code

Gwendal Grignou (1):
      iio: cros_ec_accel_legacy: Fix incorrect channel setting

Jean-Baptiste Maneyrol (1):
      iio: imu: mpu6050: add missing available scan masks

Joe Perches (1):
      iio: adc: max9611: Fix misuse of GENMASK macro

Maarten ter Huurne (1):
      IIO: Ingenic JZ47xx: Set clock divider on probe

Mauro Carvalho Chehab (1):
      docs: generic-counter.rst: fix broken references for ABI file

 Documentation/driver-api/generic-counter.rst |  4 +--
 drivers/iio/accel/cros_ec_accel_legacy.c     |  1 -
 drivers/iio/adc/ingenic-adc.c                | 54 ++++++++++++++++++++++++++++
 drivers/iio/adc/max9611.c                    |  2 +-
 drivers/iio/adc/rcar-gyroadc.c               |  4 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c   | 43 ++++++++++++++++++++++
 6 files changed, 102 insertions(+), 6 deletions(-)
