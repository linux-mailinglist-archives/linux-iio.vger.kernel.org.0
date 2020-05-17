Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69A51D6B75
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEQRcG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgEQRcG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F172067D;
        Sun, 17 May 2020 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736725;
        bh=h9NoHnxoLvYFpXG8oYcemWSw9mXjggeIuIsSQOnxUBk=;
        h=From:To:Cc:Subject:Date:From;
        b=wtHFeHCumXWNRVKiZkA48QCrvNP2Xm5/DKvjbf3KJGRDXnb1CPhvP1xChIQZ2EErL
         2ULgx0Xs47jldtsAGUI3mwqPr3tfevjFNnl5PORKgw6HYMSZhsgwRP5JqHJSLOwvJE
         r6qDushGZqciH4kmgA2FZX8pipd0bKuADPtOmT90=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/11] IIO: 1st set of timestamp alignment fixes.
Date:   Sun, 17 May 2020 18:29:49 +0100
Message-Id: <20200517173000.220819-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

Jonathan Cameron (11):
  iio: accel: kxsd9: Fix alignment of local buffer.
  iio:accel:mma8452: Fix timestamp alignment and prevent data leak.
  iio:accel:bmc150-accel: Fix timestamp alignment and prevent data leak.
  iio:accel:mma7455: Fix timestamp alignment and prevent data leak.
  iio:gyro:itg3200: Fix timestamp alignment and prevent data leak.
  iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
  iio:health:afe4403 Fix timestamp alignment and prevent data leak.
  iio:health:afe4404 Fix timestamp alignment and prevent data leak.
  iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
  iio:chemical:sps30: Fix timestamp alignment
  iio:chemical:pms7003: Fix timestamp alignment and prevent data leak.

 drivers/iio/accel/bmc150-accel-core.c | 15 ++++++++++++---
 drivers/iio/accel/kxsd9.c             | 16 +++++++++++-----
 drivers/iio/accel/mma7455_core.c      | 16 ++++++++++++----
 drivers/iio/accel/mma8452.c           | 11 ++++++++---
 drivers/iio/chemical/ccs811.c         | 13 +++++++++----
 drivers/iio/chemical/pms7003.c        | 17 ++++++++++++-----
 drivers/iio/chemical/sps30.c          |  9 ++++++---
 drivers/iio/gyro/itg3200_buffer.c     | 15 +++++++++++----
 drivers/iio/health/afe4403.c          |  9 ++++++---
 drivers/iio/health/afe4404.c          |  8 +++++---
 drivers/iio/proximity/mb1232.c        | 17 +++++++++--------
 11 files changed, 101 insertions(+), 45 deletions(-)

-- 
2.26.2

