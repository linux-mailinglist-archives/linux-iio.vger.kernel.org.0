Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEF4379CB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJVP0G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 11:26:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4023 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhJVP0G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 11:26:06 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HbSh66Qbpz67wDW;
        Fri, 22 Oct 2021 23:19:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 17:23:46 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 16:23:46 +0100
Date:   Fri, 22 Oct 2021 16:23:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: [PULL] 1st set of IIO fixes for the 5.16 cycle (suggest queuing for
 merge window as nothing urgent)
Message-ID: <20211022162345.0000350c@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 37f12202c5d28291ba5f83ce229771447ce9148f:

  staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask() (2021-10-05 12:35:30 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.16a

for you to fetch changes up to 486a25084155bf633768c26f022201c051d6fd95:

  iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask() (2021-10-21 10:26:38 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.16 cycle

As these are very late in the 5.15 cycle and non are particularly urgent,
they can wait for the merge window.

Key element in this set is Yang Yingliang has identified a number of
issues in error paths introduced recently when we added multiple
buffer support.

Other fixes:
* adi,ad5662
  - Fix handling of i2c_master_send() return value.
* adi,ad5766
  - Fix a wrong dt-property name that indicated wrong units and
    did not mach the bindings.
  - Associated 'fix' of the bindings example to have a possible scale.
* st,pressure-spi
  - Add some missing entries to the spi_device_id table to ensure
    auto-loading works.
* ti,tsc2046
  - Fix a backwards comparison leading to a false dev_warn

----------------------------------------------------------------
Mark Brown (1):
      iio: st_pressure_spi: Add missing entries SPI to device ID table

Mihail Chindris (2):
      drivers: iio: dac: ad5766: Fix dt property name
      Documentation:devicetree:bindings:iio:dac: Fix val

Oleksij Rempel (1):
      iio: adc: tsc2046: fix scan interval warning

Pekka Korpinen (1):
      iio: dac: ad5446: Fix ad5622_write() return value

Yang Yingliang (7):
      iio: buffer: check return value of kstrdup_const()
      iio: buffer: Fix memory leak in __iio_buffer_alloc_sysfs_and_mask()
      iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
      iio: buffer: Fix memory leak in iio_buffer_register_legacy_sysfs_groups()
      iio: core: check return value when calling dev_set_name()
      iio: core: fix double free in iio_device_unregister_sysfs()
      iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask()

 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |  2 +-
 drivers/iio/adc/ti-tsc2046.c                       |  2 +-
 drivers/iio/dac/ad5446.c                           |  9 ++++++-
 drivers/iio/dac/ad5766.c                           |  6 ++---
 drivers/iio/industrialio-buffer.c                  | 28 +++++++++++++---------
 drivers/iio/industrialio-core.c                    |  9 ++++++-
 drivers/iio/pressure/st_pressure_spi.c             |  4 ++++
 7 files changed, 42 insertions(+), 18 deletions(-)
