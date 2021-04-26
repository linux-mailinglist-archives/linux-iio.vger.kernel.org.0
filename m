Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D036236B84D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhDZRvO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235532AbhDZRvN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9564261007;
        Mon, 26 Apr 2021 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459431;
        bh=CwVPNLdWbGWu2staKX35GSUcbgBMt1A2iSoGIpuhCWI=;
        h=From:To:Cc:Subject:Date:From;
        b=jfpDIxLKhEtHBofM5F8SaCr7WE3HedOzUDtSfEnagG8tVVS2iIYRkH+oyFpjGufRk
         YudIVKQbDuhnNqNzWId3G3FpdwknpgcFdHvHWyc/MmHIFipMEtwobqQsk9jht3508k
         auz4VFVzTRc8qka1RVU3nKBFbqBTio+YgwelxxiazBjNOBBmwxe7xC5/YyafAX8MGL
         nyAyoOQn2NXLdw13jcQSjuXOf1NLSCu8V/LW9oKj0q5RsmdS91PYjwT3YpM6S3d187
         1Y1UQof3XoCLq6kwL9SsKboFpOI879AZamXnVYGq5imWlmgdw6ucrhBsoYPcgIoKEP
         S66HBkjSo2GBQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/9] iio: Move more things from iio_dev to iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:02 +0100
Message-Id: <20210426174911.397061-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Intent here is to clear out the low hanging fruit so we can focus on the
more interesting elements.

Hopefully this set are all uncontroversial. Lightly tested only but
all fairly mechanical so hopefully I didn't mess up.

As for the others my current thinking is as follows

mlock: Still some instances to clear out of this being used to protect things
it should not be used for. Long run we definitely want to move this one.

scan_timestamp: Can easily use a look up function in drivers that access this
directly, but that feels like an unwanted level of indirection in
iio_push_to_buffers_with_timestamp().  Perhaps worth doing anyway.
scan_bytes is also used in this function.

active_scan_mask and masklength: Both used in valid ways inside drivers.
Could be wrapped up in access functions, but it does seem a little
convoluted.

trig: This is used correctly in lots of drivers, so should stay in
struct iio_dev.

Jonathan Cameron (9):
  iio: core: move @id from struct iio_dev to struct iio_dev_opaque
  iio: avoid shadowing of variable name in to_iio_dev_opaque()
  iio: core: move @driver_module from struct iio_dev to struct
    iio_dev_opaque
  iio: core: move @trig_readonly from struct iio_dev to struct
    iio_dev_opaque
  iio: core: move @scan_index_timestamp to struct iio_dev_opaque
  iio: core: move @info_exist_lock to struct iio_dev_opaque
  iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
  iio: core: move @flags from struct iio_dev to struct iio_dev_opaque
  iio: core: move @clock_id from struct iio_dev to struct iio_dev_opaque

 drivers/iio/accel/adxl372.c                   |  4 +-
 drivers/iio/accel/bma180.c                    |  2 +-
 drivers/iio/accel/bmc150-accel-core.c         |  4 +-
 drivers/iio/accel/kxcjk-1013.c                |  4 +-
 drivers/iio/accel/mma8452.c                   |  2 +-
 drivers/iio/accel/mxc4005.c                   |  2 +-
 drivers/iio/accel/stk8312.c                   |  2 +-
 drivers/iio/accel/stk8ba50.c                  |  2 +-
 drivers/iio/adc/ad7606.c                      |  3 +-
 drivers/iio/adc/ad7766.c                      |  3 +-
 drivers/iio/adc/ad7768-1.c                    |  3 +-
 drivers/iio/adc/ad_sigma_delta.c              |  2 +-
 drivers/iio/adc/at91_adc.c                    |  4 +-
 drivers/iio/adc/dln2-adc.c                    |  3 +-
 drivers/iio/adc/ina2xx-adc.c                  |  3 +-
 drivers/iio/adc/ti-ads131e08.c                |  2 +-
 drivers/iio/adc/xilinx-xadc-core.c            |  2 +-
 .../buffer/industrialio-triggered-buffer.c    |  2 +-
 drivers/iio/chemical/atlas-sensor.c           |  2 +-
 drivers/iio/chemical/ccs811.c                 |  2 +-
 drivers/iio/chemical/scd30_core.c             |  3 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |  2 +-
 drivers/iio/gyro/adxrs290.c                   |  2 +-
 drivers/iio/gyro/bmg160_core.c                |  4 +-
 drivers/iio/gyro/fxas21002c_core.c            |  2 +-
 drivers/iio/gyro/itg3200_buffer.c             |  2 +-
 drivers/iio/gyro/mpu3050-core.c               |  2 +-
 drivers/iio/health/afe4403.c                  |  2 +-
 drivers/iio/health/afe4404.c                  |  2 +-
 drivers/iio/imu/adis_trigger.c                |  3 +-
 drivers/iio/imu/bmi160/bmi160_core.c          |  3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  2 +-
 drivers/iio/imu/kmx61.c                       |  2 +-
 drivers/iio/industrialio-buffer.c             | 12 ++-
 drivers/iio/industrialio-core.c               | 76 +++++++++++++------
 drivers/iio/industrialio-trigger.c            | 19 +++--
 drivers/iio/industrialio-triggered-event.c    |  2 +-
 drivers/iio/inkern.c                          | 46 ++++++-----
 drivers/iio/light/acpi-als.c                  |  3 +-
 drivers/iio/light/rpr0521.c                   |  2 +-
 drivers/iio/light/si1145.c                    |  2 +-
 drivers/iio/light/vcnl4000.c                  |  3 +-
 drivers/iio/light/vcnl4035.c                  |  2 +-
 drivers/iio/magnetometer/bmc150_magn.c        |  2 +-
 drivers/iio/magnetometer/rm3100-core.c        |  2 +-
 drivers/iio/potentiostat/lmp91000.c           |  3 +-
 drivers/iio/pressure/zpa2326.c                |  3 +-
 drivers/iio/proximity/as3935.c                |  3 +-
 drivers/iio/proximity/sx9310.c                |  2 +-
 drivers/iio/proximity/sx9500.c                |  2 +-
 include/linux/iio/iio-opaque.h                | 22 +++++-
 include/linux/iio/iio.h                       | 29 +------
 52 files changed, 188 insertions(+), 131 deletions(-)

-- 
2.31.1

