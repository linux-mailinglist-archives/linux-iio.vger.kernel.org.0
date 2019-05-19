Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3D22830
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfESSCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 14:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbfESSCV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 14:02:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E822082C;
        Sun, 19 May 2019 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558254841;
        bh=MH6yaW8P3uZYXI5QMYnL36st/AUkI/5A5wwVU55Yp/M=;
        h=Date:From:To:Subject:From;
        b=Nojc7xRZ9uvV1CYQena1zCOHSw93jLKPGPZnE1ke418X6XxWj2m5U9Klayt/YNMhZ
         zFhtBCRvYGLxTXaT1cSEMGqvsQZ4OgOxNmECJtGqKpse6AkahspVJnwMVkKxcCCC5w
         vaTUF0dGBikfTuxceJLK2SiGdu9kATawCzOiPx2s=
Date:   Sun, 19 May 2019 09:33:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.2 cycle.
Message-ID: <20190519093356.4703119a@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 131ac62253dba79daf4a6d83ab12293d2b9863d3:

  staging: most: core: use device description as name (2019-04-02 20:23:07 =
+0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixe=
s-for-5.2a

for you to fetch changes up to e6d12298310fa1dc11f1d747e05b168016057fdd:

  iio: adc: ti-ads8688: fix timestamp is not updated in buffer (2019-05-11 =
12:50:18 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.2 cycle.

* ads124
  - Avoid a buffer overrun when setting an array to 0.
* ads8688
  - Don't use the pollfunc timestamp as it isn't set and would be wrong
    anyway for a device that does sampling on demand.
* ds4422
  - Fix masking on register used for chip verification. Wrong address
    was being read.
* mpu6050
  - Fix the fifo layout for ICM20602 to avoid underreading and hence failure
    to move on to the next record in the fifo.
* NPCM ADC
  - Make sure there is actually a valid regulator before reading its voltag=
e.

----------------------------------------------------------------
Ruslan Babayev (1):
      iio: dac: ds4422/ds4424 fix chip verification

Sean Nyekjaer (1):
      iio: adc: ti-ads8688: fix timestamp is not updated in buffer

Steve Moskovchenko (1):
      iio: imu: mpu6050: Fix FIFO layout for ICM20602

Tomer Maimon (1):
      iio: adc: modify NPCM ADC read reference voltage

Vincent Stehl=C3=A9 (1):
      iio: adc: ads124: avoid buffer overflow

 drivers/iio/adc/npcm_adc.c                 |  2 +-
 drivers/iio/adc/ti-ads124s08.c             |  2 +-
 drivers/iio/adc/ti-ads8688.c               |  2 +-
 drivers/iio/dac/ds4424.c                   |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++++++++++++++++=
+---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 ++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |  3 ++
 7 files changed, 68 insertions(+), 9 deletions(-)
