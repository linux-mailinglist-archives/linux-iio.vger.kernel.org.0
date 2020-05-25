Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2691E132C
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbgEYRIq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRIq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:08:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD7320723;
        Mon, 25 May 2020 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426525;
        bh=fFpAz3pzK/r5tUpwmu0umxR+0t7J55XLVgfkk39bmfg=;
        h=From:To:Cc:Subject:Date:From;
        b=jr+3EruIDhA9l8Rybzk2+icNxNiM1TG4x6OOkYEspKanrM+oBcPSCouWZxjzWMJfF
         5Edvp7NiL1b0Q0MLJy1LWQBUnK7hnpG7XLda0rmhZXIg6Yq/ThbygSEfADS0ayUUzM
         xbj4Kmhd4RcLAokbw+gtLL/NWoVcNpU3JQm2hUuA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/25] IIO: 2nd set of timestamp alignment fixes.
Date:   Mon, 25 May 2020 18:06:03 +0100
Message-Id: <20200525170628.503283-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note there are still quite a few in the first set [2] that I have not
picked up yet due to lack of review.   Any help with sanity checking
those (and these) would be much appreciated.  These are not quite
mechanical enough for me to be sure I haven't done anything silly
so the more eyes the better.  Also see that discussion for extra
details on why I went in various directions to fix this in the
different drivers.

I've mostly avoided simply using __aligned(8) on the stack because
it is only relatively recently that that has been guaranteed to work.
Gcc 4.6 and kernel 4.19.  I'd like it to be sensible to backport
most of these without significant rework. The mpl3115 is I think the
only exception.

I also snuck in a warning fix for endian casting as it was in the code
that I was touching to do the main fix.

So what's left from Lars list? 5 harder cases where I'm either fairly
sure there are other bugs in the code, or I simply couldn't face
figuring them out today.

Anyhow, to recap - round 1 cover letter.

Lars noted in a recent review [1] of the adis16475 that we had an issue around
the alignment requirements of iio_push_to_buffers_with_timestamp.
Whilst it's not documented, that function assumes that the overall buffer
is 8 byte aligned, to ensure the timestamp is itself naturally aligned.
We have drivers that use arrays (typically on the stack) that do
not guarantee this alignment.

We could have fixed this by using a put_unaligned to write the timestamp
but I think that just pushes the problem down the line.  If we were to
have a consumer buffer wanting all the channels in the current
active_scanmask then it will get the raw buffer from the driver passed
straight through.  It seems odd to me if we allow passing a buffer
that is not naturally aligned through to a consumer.
Hence I'm proposing to fix up all existing drivers that might pass
a buffer with insufficient alignment guarantees.
Sometimes the timestamp is guaranteed to be in a particular location,
in which case we can use C structure alignment guarantees to fix this
in a nice readable fashion.  In other cases, the timestamp location
depends on which channels are enabled, and in those case we can
use explicit alignment __aligned(8) to ensure the whole array is
appropriately aligned.

Lars-Peter also noted that, in many of these cases, there are holes
in the stack array that we never write.  Those provide a potential
leak of kernel data to userspace.  For drivers where this applies
we either need to zero those holes each time, or allocate the buffer
on the heap (only once), ensuring it is zeroed at that time.
We may leak previous values from the sensor but currently that seems
unlikely to present any form of security risk.

As such, this first set contains a mixture of fixes.  Where there
are no possible holes, the buffer is kept on the stack but a
c structure is used to guarantee appropriate alignment.  Where
there are holes, the buffer is moved into the iio_priv() accessed
data private structure. A c structure or __aligned(8) is used
as appropriate.

I've stopped at this point rather than doing all the drivers Lars
found in order to both throttle the review burden and also to
see find any general problems with the fixes before doign futher
similar series.  A few of the remaining ones will be rather more
complex to deal with.

These have been there a long time, so whilst they are fixes we
will want in stable I'm not that bothered if it takes us a little
while to get them there!

[1] https://www.spinics.net/lists/devicetree/msg350590.html
[2] https://patchwork.kernel.org/cover/11554215/

Jonathan Cameron (25):
  iio:light:si1145: Fix timestamp alignment and prevent data leak.
  iio:light:max44000 Fix timestamp alignment and prevent data leak.
  iio:light:rpr0521 Fix timestamp alignment and prevent data leak.
  iio:light:st_uvis25 Fix timestamp alignment and prevent data leak.
  iio:light:ltr501 Fix timestamp alignment issue.
  iio:magnetometer:ak8974: Fix alignment and data leak issues
  iio:magnetometer:ak8975 Fix alignment and data leak issues.
  iio:magnetometer:mag3110 Fix alignment and data leak issues.
  iio:humidity:hdc100x Fix alignment and data leak issues
  iio:humidity:hts221 Fix alignment and data leak issues
  iio:imu:bmi160 Fix alignment and data leak issues
  iio:imu:st_lsm6dsx Fix alignment and data leak issues
  iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues.
  iio:pressure:ms5611 Fix buffer element alignment
  iio:pressure:mpl3115 Force alignment of buffer
  iio:adc:ti-adc081c Fix alignment and data leak issues
  iio:adc:ti-adc084s021 Fix alignment and data leak issues.
  iio:adc:ti-adc084s021 Tidy up endian types
  iio:adc:ti-ads1015 Fix buffer element alignment
  iio:adc:ti-ads124s08 Fix alignment and data leak issues.
  iio:adc:ti-ads8688 Fix alignment and potential data leak issue
  iio:adc:ti-adc0832 Fix alignment issue with timestamp
  iio:adc:ti-adc12138 Fix alignment issue with timestamp
  iio:adc:ina2xx Fix timestamp alignment issue.
  iio:adc:max1118 Fix alignment of timestamp and data leak issues

 drivers/iio/adc/ina2xx-adc.c                  |  8 +++---
 drivers/iio/adc/max1118.c                     | 10 ++++---
 drivers/iio/adc/ti-adc081c.c                  | 11 +++++---
 drivers/iio/adc/ti-adc0832.c                  |  7 ++---
 drivers/iio/adc/ti-adc084s021.c               | 20 ++++++++------
 drivers/iio/adc/ti-adc12138.c                 |  9 ++++---
 drivers/iio/adc/ti-ads1015.c                  | 12 ++++++---
 drivers/iio/adc/ti-ads124s08.c                | 10 ++++---
 drivers/iio/adc/ti-ads8688.c                  | 12 ++++++---
 drivers/iio/humidity/hdc100x.c                | 10 ++++---
 drivers/iio/humidity/hts221.h                 |  5 ++++
 drivers/iio/humidity/hts221_buffer.c          |  9 ++++---
 drivers/iio/imu/bmi160/bmi160.h               |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c          |  5 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  8 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 12 ++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 ++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 ++++++++++---------
 drivers/iio/light/ltr501.c                    | 15 ++++++-----
 drivers/iio/light/max44000.c                  | 12 ++++++---
 drivers/iio/light/rpr0521.c                   | 17 +++++++++---
 drivers/iio/light/si1145.c                    |  7 ++---
 drivers/iio/light/st_uvis25.h                 |  5 ++++
 drivers/iio/light/st_uvis25_core.c            |  6 ++---
 drivers/iio/magnetometer/ak8974.c             | 10 ++++---
 drivers/iio/magnetometer/ak8975.c             | 20 +++++++++-----
 drivers/iio/magnetometer/mag3110.c            | 13 ++++++---
 drivers/iio/pressure/mpl3115.c                |  3 ++-
 drivers/iio/pressure/ms5611_core.c            | 11 +++++---
 29 files changed, 198 insertions(+), 103 deletions(-)

-- 
2.26.2

