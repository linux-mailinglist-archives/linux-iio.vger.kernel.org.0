Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9CEA4A3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfJ3UQz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 16:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3UQz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Oct 2019 16:16:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BDA2083E;
        Wed, 30 Oct 2019 20:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572466614;
        bh=h08FDjrUws98ud7q3JrCPndvrtAkjCTeznWjw2wPvxc=;
        h=Date:From:To:Subject:From;
        b=t4yam5dsUESpfZtt2nPWrblWVDxKXel9i79R/jGKCYYPCaGZ0c3i3gtQct4aMF9se
         s7DB8Cgak6VsPRuoVLIIa6L+y/EoE5bSsK+c9M75q8SMR9ah20NY7zlFKoPiLBLntc
         npiJ/O+9po/eM2FOn2Q0b7NwYFDuNYo5kAgzujTc=
Date:   Wed, 30 Oct 2019 20:16:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PULL] 2nd set of IIO fixes for the 5.4 cycle.
Message-ID: <20191030201651.0f9b5237@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 3f3d31622a2c18b644328965925110dd7638b376:

  Merge tag 'iio-fixes-for-5.4a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-10-10 11:18:37 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.4b

for you to fetch changes up to e6afcf6c598d6f3a0c9c408bfeddb3f5730608b0:

  iio: adc: stm32-adc: fix stopping dma (2019-10-27 15:57:19 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 5.4 cycle.

* adis16480
  - Prevent negative numbers being accepted for sampling frequency.
* inv_mpu6050
  - Fix an issue where fifo overflow bits don't actually work as expected,
    by checking the fifo count instead.
* srf04
  - Allow more time for echo to signal as some sensors supported have
    a higher range.
* stm32-adc
  - Fix a potential race in dma disable by ensuring all transfers are done.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: imu: adis16480: make sure provided frequency is positive

Andreas Klinger (1):
      iio: srf04: fix wrong limitation in distance measuring

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix stopping dma

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix no data on MPU6050

 drivers/iio/adc/stm32-adc.c                |  4 ++--
 drivers/iio/imu/adis16480.c                |  5 ++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 15 ++++++++++++---
 drivers/iio/proximity/srf04.c              | 29 +++++++++++++++--------------
 6 files changed, 44 insertions(+), 20 deletions(-)
