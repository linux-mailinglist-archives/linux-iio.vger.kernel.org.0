Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD19533A760
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhCNSRk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCNSRY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF7FA64E31;
        Sun, 14 Mar 2021 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745844;
        bh=1k8BmwjS5bLalom1GwknKuJ1chfmR4ru7i656P4dFEM=;
        h=From:To:Cc:Subject:Date:From;
        b=Bv5VLCY8Viq+r9Ky2djkPvd0nE6ppTtDI6KZJpeMxc2XD9iE5OB2vzAMoGsn/m9Jz
         Kr0XA0JqFJ09QCADCWRqe+T88FJGujyehM5jCiDTBJzbXKwyC8xG/9XPVWj0h2PX5p
         j1xNUpbRgQ7MR4GwuQl2n1nlflJqMjHo2G+NYSmRKlL5H2VTRCCDeoAFFGdvelWt3f
         I7eTcpc0GnIPHYHqRYX/LPcn2ZMsjlbsK/KDifJEGDm+79KVyCX1rwzIkDAoBhrnvh
         MZVhgqXxB4EImjLoCyl/j06U/naiFP3bIU0WgNvgNjP7v8vsS46pGVKYPKzvKi09fY
         Qpmdxh4bREnlQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup / graduate
Date:   Sun, 14 Mar 2021 18:14:47 +0000
Message-Id: <20210314181511.531414-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

There is just enough in here to need a full posting as v2.
Note modifications are really small from v1. This v2 is more about seeking
reviews of a few patches that still need some eyes on them.

Thanks to Alex and Barry for reviews on v1.  There are a few patches
that still need someone to take a look though.

23 - DT bindings (I moved these later in the series to help them stand out)
     No changes in here beyond adding a clarification on the regulator to
     the patch description. @Rob, if you could sanity check this that would
     be great.

12 - The big irq rework patch. Alex wasn't quite happy to give a tag
     on that last time, but didn't mention anything specific. It's a bit
     fiddly so fair enough!

20 - of_match_table patch.  Simple patch, and I believe I addressed all
     questions in v1, but no tags given yet.

21 - ABI patch.  I don't think there is anything controversial in here
     but it's not gained any tags yet.
     
13 - Really minor tweak to avoid a build warning.  I've kept Alex's
     tag on that one.

v1 description:

This is an 'old' driver in IIO that has been in staging a while.
First submitted in October 2010.

I wanted to try and experiment and picked this driver to try it with.

The cleanup etc here was all tested against some basic emulation
added to QEMU rather than real hardware.  Once I've cleaned that up
a tiny bit I'll push it up to https://github.com/jic23/qemu
Note that for now I'm not proposing to upstream this to QEMU but
would be interested in hearing if people thing it is a good idea to
do so.

Whilst it's obviously hard to be absolutely sure that the emulation is
correct, the fact that the original driver worked as expected and the
cleaned up version still does is certainly encouraging.

Note however, that there were a few more significant changes in here than
basic cleanup.
1. Interrupts / events were handled in a rather esoteric fashion.
   (Always on, window modes represented as magnitudes).
   Note that for two channel devices there are separate lines. The original
   driver was not supporting this at all.
   They now look more like a standard IIO driver and reflect experience
   that we've gained over the years in dealing with devices where these
   aren't interrupt lines as such, but rather reporters of current status.
2. Timeouts were handled in a fashion that clearly wouldn't work.

Note that this moving out of staging makes a few bits of ABI 'official'
and so those are added to the main IIO ABI Docs.

Thanks in advance to anyone who has time to take a look.

Jonathan Cameron (24):
  staging:iio:cdc:ad7150: use swapped reads for i2c rather than open
    coding.
  staging:iio:cdc:ad7150: Remove magnitude adaptive events
  staging:iio:cdc:ad7150: Refactor event parameter update
  staging:iio:cdc:ad7150: Timeout register covers both directions so
    both need updating
  staging:iio:cdc:ad7150: Drop platform data support
  staging:iio:cdc:ad7150: Handle variation in chan_spec across device
    and irq present or not
  staging:iio:cdc:ad7150: Simplify event handling by only using rising
    direction.
  staging:iio:cdc:ad7150: Drop noisy print in probe
  staging:iio:cdc:ad7150: Add sampling_frequency support
  iio:event: Add timeout event info type
  staging:iio:cdc:ad7150: Change timeout units to seconds and use core
    support
  staging:iio:cdc:ad7150: Rework interrupt handling.
  staging:iio:cdc:ad7150: More consistent register and field naming
  staging:iio:cdc:ad7150: Reorganize headers.
  staging:iio:cdc:ad7150: Tidy up local variable positioning.
  staging:iio:cdc:ad7150: Drop unnecessary block comments.
  staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
  staging:iio:cdc:ad7150: Add scale and offset to
    info_mask_shared_by_type
  staging:iio:cdc:ad7150: Really basic regulator support.
  staging:iio:cdc:ad7150: Add of_match_table
  iio:Documentation:ABI Add missing elements as used by the adi,ad7150
  staging:iio:cdc:ad7150: Add copyright notice given substantial
    changes.
  dt-bindings:iio:cdc:adi,ad7150 binding doc
  iio:cdc:ad7150: Move driver out of staging.

 Documentation/ABI/testing/sysfs-bus-iio       |  33 +
 .../bindings/iio/cdc/adi,ad7150.yaml          |  69 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/cdc/Kconfig                       |  17 +
 drivers/iio/cdc/Makefile                      |   6 +
 drivers/iio/cdc/ad7150.c                      | 678 ++++++++++++++++++
 drivers/iio/industrialio-event.c              |   1 +
 drivers/staging/iio/cdc/Kconfig               |  10 -
 drivers/staging/iio/cdc/Makefile              |   3 +-
 drivers/staging/iio/cdc/ad7150.c              | 655 -----------------
 include/linux/iio/types.h                     |   1 +
 12 files changed, 808 insertions(+), 667 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
 create mode 100644 drivers/iio/cdc/Kconfig
 create mode 100644 drivers/iio/cdc/Makefile
 create mode 100644 drivers/iio/cdc/ad7150.c
 delete mode 100644 drivers/staging/iio/cdc/ad7150.c

-- 
2.30.2

