Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA471505E64
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiDRTXv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347651AbiDRTXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:23:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30120F41
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A12BEB8106E
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC61FC385B7;
        Mon, 18 Apr 2022 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309667;
        bh=lKmaMswO8kBp1L/bCer+0koT/eIroE08TT9QoHreBGM=;
        h=From:To:Cc:Subject:Date:From;
        b=hk1uvqmdVSCUP7KnzstYsHsfnlt+H58JWU2BzK/CWgjWrAUWCyxIK+FGuxvbZ0+I6
         dhqnl5LjRaJvsIAt9+knnS22R07uFvJQDjxwHLP2VyPBZgiMK6m8QCjH5r/Bx07Z4c
         lXQMfUFJtm2YwRu7fR7ihrTlRN5fJI/TkkNLqdKhw1vNdeuu7vU35htgk1I+Y+yeRe
         o2jmdd3Mg4lZiTxIsYO+OOrZ01OTpY6N7skscjyu4iJwG8hS4Ax4fnsSt1GIAOz8++
         ZTVE2TCBJAdNAoSvDdGenMLX9gMuqycefQR/40y5aRsHkUHgAYXE95oJvRoikr/5ai
         mkA5CVDjC2SxA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/17] staging/iio: Clean up AD7746 CDC driver and move from staging.
Date:   Mon, 18 Apr 2022 20:28:50 +0100
Message-Id: <20220418192907.763933-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
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
   type and printing a few more decimal places (12).
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
  iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2
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
 drivers/iio/industrialio-core.c               |  24 +-
 drivers/staging/iio/cdc/ad7746.c              | 767 ----------------
 include/linux/iio/types.h                     |   1 +
 .../roadtest/tests/iio/cdc/__init__.py        |   0
 .../roadtest/roadtest/tests/iio/cdc/config    |   1 +
 .../roadtest/tests/iio/cdc/test_ad7746.py     | 323 +++++++
 11 files changed, 1195 insertions(+), 776 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
 create mode 100644 drivers/iio/cdc/ad7746.c
 delete mode 100644 drivers/staging/iio/cdc/ad7746.c
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py

-- 
2.35.3

