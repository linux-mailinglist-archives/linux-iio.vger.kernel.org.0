Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CC27138E
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITL2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 07:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgITL2Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:24 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AADF20EDD;
        Sun, 20 Sep 2020 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601303;
        bh=CdFtarjNMI/QtZYfu+X5iRCropuzV9a20Lp9eaIofog=;
        h=From:To:Cc:Subject:Date:From;
        b=dBGZygd5MguX4N9Puz5CKQsVqtXoajPL++noDlPCh8tUo/DHQzrBEBb0wPmr4EFrY
         fYlXUYJ4cIyOeydID+NVOmMoL1+tKpOLbOzWUuln9UdXEWlA5YddX3dMxJ7cwY5bIq
         jfwyPRbb96RXdNnunv4R0F2FkdwCpYm5pfy98Vog=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 0/8] IIO: Fused set 1 and 2 of timestamp alignment fixes
Date:   Sun, 20 Sep 2020 12:27:34 +0100
Message-Id: <20200920112742.170751-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Took me a while to get back to these.  We have 2 new patches in here to
fix issues unrelated to the main topic, but which effect the buffer lengths.
I've done those as precursors so it is clear what is going on.

Note there are still a few outstanding drivers to be fixed before we can
think about adding a warning if unaligned buffers are provided. Naturally
they are the hardest ones, or the ones where I couldn't work out how
the code is working today, so may take a little while.

Changes since v3:
* Applied all the ones where only minor comment changes were needed.
* rpr0521: Fixed typo. Also added to patch description Mikko's information
  on why it would be costly to split off the interrupt read.
* st_uvis: Drop the pointless masking.
* mag3110: Rename element to temperature
* bmi160: Add fix to length of buffer.
* bmi160: Improve comments and carry forwards shorter length.
* mpl3115: Sufficiently unusual to need a 'special' comment and another review.
* ti-ads124s08: Add fix to length of buffer.
* ti-ads124s08: Expand comment to express the buffer length not all needed if
  not all channels are enabled.

Changes since v2:
* bmc150-accel: Use sizeof() for channel size (Andy Shevchenko)
* st_uvis25: Use local variable for regmap call (Andy Shevchenko)
* st_lsm6dsx: Use array of scan[] rather than 3 structures (Lorenzo Bianconi)
* inv_mpu6050: Add patch switching to a regmap_noinc_read (Jean-Baptiste Maneyrol)
* ina2xx: Use a structure (previously failed to notice that works here)
* I've added clarifying notes to patch descriptions based on questions asked.
  These were mainly about why we didn't use the structure approach everywhere
  and why I've forced alignment in places it wasn't strictly needed.

Previous cover letter:
A few notes based on questions on v1.

1. Why not use put_unaligned to avoid the whole thing?
   This interface can pass directly to a variety of in kernel users
   who would reasonably assume that we have true natural alignment.
   When it gets passed directly is subtle as it depends on whether
   the demux has to realign the data or not.  So enabling an extra
   channel could result in a previously working alignment no longer
   being true.
   
   Even if this is fine for existing usecases we are likely to
   store up subtle long term issues if we don't fix it explicitly.
   It's also worth noting that the data channel sometimes suffered
   the same problem as the timestamp.

2. Why not specify explicit padding?
   In my view this is error prone in comparisom with relying on
   c to do the hard work for us.

3. Why not move the timestamp to the start?
   ABI breakage and as timestamp is optional (no obvious from the
   iio_push_to_buffers_with_timestamp call) we can end up having
   to shift the rest of the data within that call.
   
Changes since v1.

Andy Schevchenko pointed out that on x86_32 s64 elements are only
aligned to 4 bytes.  Where I had tried to use a structure to avoid
explicit need to list the padding, there were some cases where
this results in insufficient padding being inserted.

This doesn't affect the few patches that had already been applied and
sent upstream. (which was lucky ;)

The fix was to take advantage of __aligned(8) which (according to
my reading of the c spec and the gcc docs) enforces the alignment of
both the element within a structure and the structure itself.
The kernel now requires a recent enough version of GCC to ensure this
works both on the stack and heap.  This is done in lots of other
userspace interfaces. In some cases iio_push_to_buffers_with_ts
is aligning data for passing to userspace, be it via a kfifo
so it is sensible we should use the same solution.

Note that we could have used u64_aligned but there is no equivalent
for s64 and explicit use of __aligned(8) is common in
the kernel so we adopt this here.

Note that there were about 8 drivers that would have been broken with
v1 of the patch.  I have also forced alignment of timestamps in cases
where (mostly by coincidence) we would have been fine (padding was
less than 4 bytes anyway.  I did this partly to reduce fragility if
other elements are added in future and also to avoid cut and paste
errors in new drivers.

There were a few other minor tidying up changes inline with reviews
of v1.

I've kept tags given for v1 on basis the changes are minor. Shout if
you disagree.

Version 1 part 1 cover letter.

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

Jonathan Cameron (8):
  iio:light:rpr0521: Fix timestamp alignment and prevent data leak.
  iio:light:st_uvis25: Fix timestamp alignment and prevent data leak.
  iio:magnetometer:mag3110: Fix alignment and data leak issues.
  iio:imu:bmi160: Fix too large a buffer.
  iio:imu:bmi160: Fix alignment and data leak issues
  iio:pressure:mpl3115: Force alignment of buffer
  iio:adc:ti-ads124s08: Fix buffer being too long.
  iio:adc:ti-ads124s08: Fix alignment and data leak issues.

 drivers/iio/adc/ti-ads124s08.c       | 13 ++++++++++---
 drivers/iio/imu/bmi160/bmi160.h      |  7 +++++++
 drivers/iio/imu/bmi160/bmi160_core.c |  6 ++----
 drivers/iio/light/rpr0521.c          | 17 +++++++++++++----
 drivers/iio/light/st_uvis25.h        |  5 +++++
 drivers/iio/light/st_uvis25_core.c   |  8 +++++---
 drivers/iio/magnetometer/mag3110.c   | 13 +++++++++----
 drivers/iio/pressure/mpl3115.c       |  9 ++++++++-
 8 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.28.0

