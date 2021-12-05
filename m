Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC07468D2A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbhLEUZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38490 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUZf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BAC46114C
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B1EC00446;
        Sun,  5 Dec 2021 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735727;
        bh=BbBhZkSJZgCWsAZhkJ/nHnwGylHGrKFDZcYjguFrw9k=;
        h=From:To:Cc:Subject:Date:From;
        b=IGLQtzcnFcWEKkhtUrNYKQsyAw0zyEUiUYP+f0L3RnzuDE7jWa4U3SEy3smSneXy1
         Cx4BXjQG8qdHWECb1eJf8FljDq/Fa8ytb0gzsiZ9LsZchF3Es/wb3KX6biuXcYKw5L
         wKyGS+sqLbNVWN6+Y4kcLNbmgZBPeKQkkb0eUEO2y1pjTJtEDxYEWdcuOSRc89gJ3m
         WvcvAhSyO4U/EObpPkz4YnHID83+wEovqF/PI1XBO9MtBMxjqAdHykBrc+4LHZ8wpT
         kOmBF5rc2acjYNJB63foOoVaHoPjaIpPniw1t3GXq/xFTdiiYIHoczKaqDPTBtKz8j
         ZAgNFWrJoSXOw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/17] iio:adc:ad7280a Cleanup and proposed staging graduation.
Date:   Sun,  5 Dec 2021 20:26:53 +0000
Message-Id: <20211205202710.2847005-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v2: Picked up Rob's tag for the binding
    Rebase and a trivial white space tidy up.

Marcelo expressed interest in reviewing this one, but given it's
been a while I'm resending in the hope that someone else will have
time to take a look. Obviously if anyone wants to try the emulation
that's great but fundamental thing I'm looking for here is review of
the final patch as that has the whole driver in it.

Note we don't require perfection for staging graduations, so futher
cleanup can be delayed until it's out of staging.
The interesting stuff here is anything related to the ABI as that
is pretty much fixed once it's out of staging.  Obviously any
feedback welcome.

v1 cover letter.

Hi All,

This one proved an interesting diversion.

Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
ad7280a devices (18 channels).  Note that the emulation isn't complete
but does do chaining, CRC, and readout of channels etc in a fashion that
worked with the original driver (up to the bug in patch 1) and continues
to work with the updated version. I've not intention to upstream the
emulation (as would need to make it more completed and flexible), but
happy to share it with anyone who is interested.

I briefly flirted with posting a patch to just drop the driver entirely,
but the part is still available and it looked like fun + isn't going
to greatly impact maintainability of the subsystem long term so is low
cost even if it goes obsolete sometime soonish.

There are lots of things we could do after this set to improved the driver
and make things more flexible, but it should basically 'just work'

Anyhow, as normal for staging graduations, last patch has rename detection
turned off so that people can easily see what I am proposing we move
out of staging.

Jonathan Cameron (17):
  staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
  staging:iio:adc:ad7280a: Register define cleanup.
  staging:iio:adc:ad7280a: rename _read() to _read_reg()
  staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
  staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
    transfers.
  staging:iio:adc:ad7280a: Switch to standard event control
  staging:iio:adc:ad7280a: Standardize extended ABI naming
  staging:iio:adc:ad7280a: Drop unused timestamp channel.
  staging:iio:adc:ad7280a: Trivial comment formatting cleanup
  staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
  staging:iio:adc:ad7280a: Cleanup includes
  staging:iio:ad7280a: Reflect optionality of irq in ABI
  staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
  staging:iio:adc:ad7280a: Use device properties to replace platform
    data.
  dt-bindings:iio:adc:ad7280a: Add binding
  iio:adc:ad7280a: Document ABI for cell balance switches
  iio:adc:ad7280a: Move out of staging

 .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
 .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
 drivers/iio/adc/Kconfig                       |   11 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
 drivers/staging/iio/adc/Kconfig               |   11 -
 drivers/staging/iio/adc/Makefile              |    1 -
 drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
 drivers/staging/iio/adc/ad7280a.h             |   37 -
 9 files changed, 1228 insertions(+), 1093 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
 create mode 100644 drivers/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.h

-- 
2.34.1

