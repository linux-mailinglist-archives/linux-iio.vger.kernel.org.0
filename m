Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFE550C9C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiFSS73 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiFSS66 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:58:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEEBBC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 011C9B80D6F
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7735BC34114;
        Sun, 19 Jun 2022 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665133;
        bh=coVIwObqoJM535ijtWd5Wdhp4DRWv5CO0VupRVKbKW0=;
        h=From:To:Cc:Subject:Date:From;
        b=dCHx1xnA6D5tK6IBgyhVbZFWXu0J0YXmZ7NwHqYzMvfUOYESuKWT4NJ8+OFO5A81C
         xTUSwj2gpZwDA8Na8p9w78DTn+vgI2dHJhavI/08BBgdB8RQLhY+wXSPdfitzNVk/4
         o6FsQM1CyWu2VUl6iN4tzZK8UH2QIiVBM9Gn4ECcE2yiqCuXzZGmdyoF7bXMWJym3E
         /mirpBh/osueqkQxbDmW/94xx/vhwiotcUZGcaOGZoAiYdD/2KsTKmXm1K5y9KPFo9
         Zh8b8nYE04oCYIigfKq0t+JzOkFAeu3K9TVA1Kw0/Kc8QMZ30W0kQ08vCF4aAFcSkI
         ETKhkPPewa8Zg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/17] staging/iio: Clean up AD7746 CDC driver and move from staging.
Date:   Sun, 19 Jun 2022 19:58:22 +0100
Message-Id: <20220619185839.1363503-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Vincent: I'm getting some instability with roadtest after forwards porting to
current mainline. Tests run 'sometimes'.  Other times I get a crash
in um_set_signal.  Seems unrelated to the test this series adds.

Changes since v1: Thanks to Andy and Peter for reviews.
- Use sizeof(data) for be24 buffer data[3]
- Make the precision patch fall back to old maths if overflow would
  have occured.

This started out as an experiment with Vincent Whitchurch's roadtest
testing framework [1] and that worked well so I carried on cleaning up the
driver.

Mostly this is standard tidy up, move to new interfaces, then move the driver
out of staging, but there are a few other things in here.

1) Precision improvement for IIO_VAL_FRACTIONAL_LOG2.
   The ad7746 is a 24 bit sensor and this highlighted that 9 decimal
   places wasn't enough to keep the error introduced by
   _raw * _scale from growing too large over the whole range (I couldn't
   write a sensible test for it).  So I've proposed increasing the precision
   of the calculation used to provide the sysfs attributes with this value
   type and printing a few more decimal places (12), but only if overflow
   will not occur due to val[0] > ULLONG_MAX / PICO
2) _inputoffset ABI addition.  This driver had an odd use of _offset for
   the case of differential channels that applied the offset to both
   of the differential pair (hence usespace shouldn't not apply it when
   converting to the base units. That isn't inline with the existing
   documentation for _offset and it wasn't clear to me that it made sense
   at all.  To avoid confusion I've added this new ABI (_inputoffset) for t
3) roadtest file - note this is not a complete test set for the driver and
   mainly focused on the main channel reads and places I thought I might
   have broken things whilst working on the driver.

My conclusion on roadtest - Very useful indeed. I'd encourage others to
consider developing some basic sanity tests for drivers they are working on.
Hopefully my python code isn't too hideous to understand at least!
Vincent, it might be worth thinking about some generic code to handle the
'variants' on correct ABI like I introduce here because I switched from
a shared by type scale to an individual one per channel for the voltages.
Both were ABI compliant so that sort of change is fine most of the time
though we have to be careful with it.

All comments welcome.  Note there may be changes that make more sense
to do after moving this out of staging as long as there are no ABI changes involved
etc.  Feel free to highlight those sorts of changes as well as anything more
significant.

[1] https://lore.kernel.org/all/20220311162445.346685-9-vincent.whitchurch@axis.com/

Jonathan Cameron (17):
  iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2 when possible
  iio: ABI: Fix wrong format of differential capacitance channel ABI.
  staging: iio: cdc: ad7746: Use explicit be24 handling.
  staging: iio: cdc: ad7746: Push handling of supply voltage scale to
    userspace.
  staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
  staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
  staging: iio: cdc: ad7764: Push locking down into case statements in
    read/write_raw
  staging: iio: cdc: ad7746: Break up use of chan->address and use
    FIELD_PREP etc
  staging: iio: cdc: ad7746: Drop usused i2c_set_clientdata()
  staging: iio: cdc: ad7746: Use _raw and _scale for temperature
    channels.
  iio: core: Introduce _inputoffset for differential channels
  staging: iio: cdc: ad7746: Switch from _offset to _inputoffset for
    differential channels.
  staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
  staging: iio: ad7746: White space cleanup
  iio: cdc: ad7746: Add device specific ABI documentation.
  iio: cdc: ad7746: Move driver out of staging.
  RFC: iio: cdc: ad7746: Add roadtest

 Documentation/ABI/testing/sysfs-bus-iio       |  15 +-
 .../ABI/testing/sysfs-bus-iio-cdc-ad7746      |  11 +
 drivers/iio/cdc/Kconfig                       |  10 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/ad7746.c                      | 818 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  31 +-
 drivers/staging/iio/cdc/ad7746.c              | 767 ----------------
 include/linux/iio/types.h                     |   1 +
 .../roadtest/tests/iio/cdc/__init__.py        |   0
 .../roadtest/roadtest/tests/iio/cdc/config    |   1 +
 .../roadtest/tests/iio/cdc/test_ad7746.py     | 323 +++++++
 11 files changed, 1202 insertions(+), 776 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
 create mode 100644 drivers/iio/cdc/ad7746.c
 delete mode 100644 drivers/staging/iio/cdc/ad7746.c
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py

-- 
2.36.1

