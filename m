Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018355B1D5
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiFZMUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiFZMUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386FDFE6
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 188A1B80D64
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45444C341CA;
        Sun, 26 Jun 2022 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246018;
        bh=lbkdIQ4F2g1HfpXVmTb5J6jc18F8n+Vt78g3iGeDsnc=;
        h=From:To:Cc:Subject:Date:From;
        b=f742L0hYY04KyjZ2zWcVN3JTsm12yWyP2UeCtkawgFDbjT9Xp7EQO9KFhFuH6WBG/
         FM45j/Xgh6EugJVULH1cob2AEmjdX+b1gxwU/GPVZw88BU2Wj8cZejSuiIvrWsvuqe
         XNptpsMkJ3ExKyHsShAatIwEjfr9yOqCJgg7gZcv+k8gGNpjh5G0PsXdIttVhxLMob
         eD0cZWNWzxVMFoQTGqAgebD2SYJXbEJruMcLNpaOaGo43FQOlWoSouB1aSm+3HXez3
         VHZHs6KO1+JA8+Hp0nHOgpNoo0L5tWc/cK1GdjmktZ8dQeijbjEIk/tTMvrFCSEkoS
         vsBqTwtdlzKfQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 00/17] staging/iio: Clean up AD7746 CDC driver and move from staging.
Date:   Sun, 26 Jun 2022 13:29:21 +0100
Message-Id: <20220626122938.582107-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v2:  Thanks to Andy Shevchenko for review
- Fix the horrible mess I made of a rebase that meant v2 didn't build
  mid patch set.
- Fix various build issues I'd missed due to wrong make file (fails to
  update variables after moving them, missing unaligned include,
  failure to cleanup staging driver Kconfig / Makefile)
- Change new ABI to _zeropoint and add more the description to hopefully
  add clarify to what this is. I don't think it's going to be a particularly
  common bit of ABI, but still good to get it right.

Note that the --no-renames was used to preserve full code listing
for the actual move out of staging to aid review. The ad7746 file is
moved with no changes.

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
similarity index 100%
rename from drivers/staging/iio/cdc/ad7746.c
rename to drivers/iio/cdc/ad7746.c

This started out as an experiment with Vincent Whitchurch's roadtest
testing framework [1] and that worked well so I carried on cleaning up the
driver.  Note that if you are using roadtest rebased to current
kernel, add CONFIG_UML_RANDOM as suggested by Vincent in reply
to v2 of this series.  I still saw one freeze but with that config
element added roadtest runs the tests successfully the vast majority
of the time.

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
2) _zeropoint ABI addition.  This driver had an odd use of _offset for
   the case of differential channels that applied the offset to both
   of the differential pair (hence userspace shouldn't not apply it when
   converting to the base units. That isn't inline with the existing
   documentation for _offset and it wasn't clear to me that it made sense
   at all.  To avoid confusion I've added this new ABI (_zeropoint) for this.
3) roadtest file - note this is not a complete test set for the driver and
   mainly focused on the main channel reads and places I thought I might
   have broken things whilst working on the driver.  Given roadtest isn't
   upstream yet this test will have to wait. That doesn't block merging
   the rest of the series.

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
  staging: iio: cdc: ad7746: Drop unused i2c_set_clientdata()
  staging: iio: cdc: ad7746: Use _raw and _scale for temperature
    channels.
  iio: core: Introduce _zeropoint for differential channels
  staging: iio: cdc: ad7746: Switch from _offset to _zeropoint for
    differential channels.
  staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
  staging: iio: ad7746: White space cleanup
  iio: cdc: ad7746: Add device specific ABI documentation.
  iio: cdc: ad7746: Move driver out of staging.
  RFC: iio: cdc: ad7746: Add roadtest

 Documentation/ABI/testing/sysfs-bus-iio       |  21 +-
 .../ABI/testing/sysfs-bus-iio-cdc-ad7746      |  11 +
 drivers/iio/cdc/Kconfig                       |  10 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/ad7746.c                      | 820 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  32 +-
 drivers/staging/iio/Kconfig                   |   1 -
 drivers/staging/iio/Makefile                  |   1 -
 drivers/staging/iio/cdc/Kconfig               |  17 -
 drivers/staging/iio/cdc/Makefile              |   6 -
 drivers/staging/iio/cdc/ad7746.c              | 767 ----------------
 include/linux/iio/types.h                     |   1 +
 .../roadtest/tests/iio/cdc/__init__.py        |   0
 .../roadtest/roadtest/tests/iio/cdc/config    |   1 +
 .../roadtest/tests/iio/cdc/test_ad7746.py     | 323 +++++++
 15 files changed, 1211 insertions(+), 801 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
 create mode 100644 drivers/iio/cdc/ad7746.c
 delete mode 100644 drivers/staging/iio/cdc/Kconfig
 delete mode 100644 drivers/staging/iio/cdc/Makefile
 delete mode 100644 drivers/staging/iio/cdc/ad7746.c
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py

-- 
2.36.1

