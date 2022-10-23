Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13B609259
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJWK6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 06:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWK6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 06:58:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5FA5A8DB
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 03:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E32B80D19
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C6C433C1;
        Sun, 23 Oct 2022 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666522691;
        bh=Pgf7PLlTw7+Bed8Djq0whyhiXnc5TwX2n3uEskTYejU=;
        h=Date:From:To:Subject:From;
        b=UdeST0iH/ulFURpfIZ2CTDoe+00sOh8dboX+B1m7QLkXAy3XwWporFEP3LgWbudLh
         f1d2zZBhgBsW1yb1e48IN/XdjKiDUKZbi2k/eaHJiSQOIXaTYYN4iCVO9JEldX2QYf
         IGafbF7g9c6cgPURBtjO/11jh0rGAWNDpax4glfmGBmvvoS88ziGSfH4nruJ+M2rZc
         O6VT8kMEcQ33JsYpZIByuchmqO6Jt1PnsUu93uUBAAWR4bKI8B1QjHCmVaS+mobE83
         6fxfJA75ZOj1KNNQBYqzzo6XYbxGxKwd+xRJMSrjUjzgCBwo3nlZcspSuzZPwLqo0+
         U+2kkH6318HKw==
Date:   Sun, 23 Oct 2022 11:58:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 6.1
Message-ID: <20221023115848.148744b1@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1a

for you to fetch changes up to a10a0f385ab8af08ddb762ac3eca11e1b6d1fe69:

  iio: bmc150-accel-core: Fix unsafe buffer attributes (2022-10-17 08:51:26 +0100)

----------------------------------------------------------------
1st set of IIO fixes for the 6.1 cycle.

Usual bunch of driver fixes + one set of fixes for driver bugs
introduced by a core change to how buffer attributes are handled.

- buffer attributes
  * Remove usage of IIO_CONST_ATTR() for buffer attributes in all drivers
    where this occurred as that broke wrapping code need to duplicate these
    for multiple buffer support. The minimal fix is moving to
    IIO_DEVICE_ATTR_RO() with separate _show() routines.  A cleanup of
    this code, preventing similar issues in future will follow next merge
    window.
- tools/iio
  * Wrong handling of number of digits in the number 0.
- adi,ltc2983
  * Avoid reallocating channels on each wake up from sleep by moving
    that step out of the ltc2983_setup() function.
- microchip,mcp3911
  * Wrong ID bits + masking in debug prints.
  * Fix ARRAY_SIZE() vs sizeof() mix up.
  * Handle NULL return on trigger allocation failure correctly.
- st,stm32-adc:
  * Ensure we initialize sampling time even when optional property not
    provided in DT. Internal channels require a minimum value that will
    not otherwise be set.
- taos,tsl2583
  * Fix a double call of iio_device_unregister() via device managed and
    un-managed paths.

----------------------------------------------------------------
Cosmin Tanislav (1):
      iio: temperature: ltc2983: allocate iio channels once

Dan Carpenter (1):
      iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug

Marcus Folkesson (3):
      iio: adc: mcp3911: return proper error code on failure to allocate trigger
      iio: adc: mcp3911: use correct id bits
      iio: adc: mcp3911: mask out device ID in debug prints

Matti Vaittinen (5):
      tools: iio: iio_utils: fix digit calculation
      iio: at91-sama5d2_adc: Fix unsafe buffer attributes
      iio: adxl372: Fix unsafe buffer attributes
      iio: adxl367: Fix unsafe buffer attributes
      iio: bmc150-accel-core: Fix unsafe buffer attributes

Olivier Moysan (1):
      iio: adc: stm32-adc: fix channel sampling time init

Shreeya Patel (1):
      iio: light: tsl2583: Fix module unloading

 drivers/iio/accel/adxl367.c           | 23 ++++++++++++++++++-----
 drivers/iio/accel/adxl372.c           | 23 ++++++++++++++++++-----
 drivers/iio/accel/bmc150-accel-core.c | 23 ++++++++++++++++++-----
 drivers/iio/adc/at91-sama5d2_adc.c    | 23 ++++++++++++++++++-----
 drivers/iio/adc/mcp3911.c             | 13 +++++++------
 drivers/iio/adc/stm32-adc.c           | 11 ++++++-----
 drivers/iio/light/tsl2583.c           |  2 +-
 drivers/iio/temperature/ltc2983.c     | 13 ++++++-------
 tools/iio/iio_utils.c                 |  4 ++++
 9 files changed, 96 insertions(+), 39 deletions(-)
