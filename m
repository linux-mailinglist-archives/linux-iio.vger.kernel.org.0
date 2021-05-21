Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F538CBA7
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEURPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 13:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhEURPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 May 2021 13:15:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9220B613E1;
        Fri, 21 May 2021 17:13:48 +0000 (UTC)
Date:   Fri, 21 May 2021 18:15:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for the 5.13 cycle.
Message-ID: <20210521181509.419b9db0@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit ba9c25d94dea1a57492a606a1f5dde70d2432583:

  Merge tag 'iio-fixes-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-11 15:17:55 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13b

for you to fetch changes up to 923b374318f8aa0b241731e83e7abfb9e5300f29:

  iio: adc: ad7793: Add missing error code in ad7793_setup() (2021-05-16 10:15:47 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 5.13 cycle

A mixed bag of fixes for various drivers.

adi,ad7124
 - Fix miss balanced regulator enable / disable in error path
 - Fix potential overflow with non sequential channel numbers from dt.
adi,ad7192
 - Avoid disabling clock that was never enabled in error path + remove
 - Avoid nasty corner case if regulator voltage is 0 that would result
   in a good return half way through probe.
adi,ad7746
 - Avoid overwriting num_channels just after setting it correctly.
adi,ad7768
 - Buffer passed to iio_push_to_buffers_with_timestamp() too small and
   not aligned appropriately.
adi,ad7793
 - Missing return code setting in an error path.
adi,ad7923
 - Buffer too small after support for more channels added.
adi,ad5770r
 - Missing fwnode_handle_put in error paths.
fsl,fxa21002c
 - Missing runtime pm put in error path.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: ad7192: handle regulator voltage error first

Andy Shevchenko (1):
      iio: dac: ad5770r: Put fwnode in error case during ->probe()

Jonathan Cameron (5):
      iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
      iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
      iio: adc: ad7192: Avoid disabling a clock that was never enabled.
      iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()
      iio: adc: ad7923: Fix undersized rx buffer.

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Rui Miguel Silva (1):
      iio: gyro: fxas21002c: balance runtime power in error path

YueHaibing (1):
      iio: adc: ad7793: Add missing error code in ad7793_setup()

 drivers/iio/adc/ad7124.c           | 36 ++++++++++++++++++++----------------
 drivers/iio/adc/ad7192.c           | 19 ++++++++++---------
 drivers/iio/adc/ad7768-1.c         |  8 ++++++--
 drivers/iio/adc/ad7793.c           |  1 +
 drivers/iio/adc/ad7923.c           |  4 +++-
 drivers/iio/dac/ad5770r.c          | 16 +++++++++++-----
 drivers/iio/gyro/fxas21002c_core.c |  2 ++
 drivers/staging/iio/cdc/ad7746.c   |  1 -
 8 files changed, 53 insertions(+), 34 deletions(-)
