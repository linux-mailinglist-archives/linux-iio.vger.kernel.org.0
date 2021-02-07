Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833331257F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGPt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhBGPtY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:49:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 371C664E3E;
        Sun,  7 Feb 2021 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712922;
        bh=K7HuLpN83szPzAYEW+nANRWQey/sXv3jPb7/kdp2w+o=;
        h=From:To:Cc:Subject:Date:From;
        b=GkYm13jVW8uAcpmtSo7xLbxCGDCouohia4KFLCbv4ErkmN+cvBOxw7vjNSF7AeBaH
         A+T8v3g0uHR4ZA/DGjkv1rLkDcRDwEVp5wNVwGjirVPTGAXCFsF3xh4Yw7Qo8r78+7
         61Cww1GiMojZjp79k/aPnAvrSoAgwmy2sss7DGeIt2oIH99xAp5CGkdxoT7voftPq2
         SvG28mi9o1GMUWny33/DpIf7vM/+aehF9zYyIvka4nSFIGkrLj6BzmiMxneCaXbVUs
         udNTNrvItxMXovet4Pwoj4iK9Vmx8OUczOQY/ej3Jv8b+K5t+tfpwV2Rg9bqWBIbJ3
         +VmH7aGhe8IqA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/24] staging:iio:cdc:ad7150: cleanup / fixup / graduate
Date:   Sun,  7 Feb 2021 15:45:59 +0000
Message-Id: <20210207154623.433442-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

Jonathan


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
  dt-bindings:iio:cdc:adi,ad7150 binding doc
  iio:Documentation:ABI Add missing elements as used by the adi,ad7150
  staging:iio:cdc:ad7150: Add copyright notice given substantial
    changes.
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
2.30.0

