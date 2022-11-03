Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCD618A09
	for <lists+linux-iio@lfdr.de>; Thu,  3 Nov 2022 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKCU6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Nov 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKCU6R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2022 16:58:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F01A05B
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 13:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6905FB829FD
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 20:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63866C433D6;
        Thu,  3 Nov 2022 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667509093;
        bh=+vynZu7mMO1qRFdS5r1K9X6+cqCbOQfLbPfU3GIQQZc=;
        h=Date:From:To:Subject:From;
        b=Swdqz1Zp8pActOOPBmbrDVk10Mq5bUqPjGzSO8IvJEd6rfd3h3/8TMPkPV0fAhLmD
         uaZ3cajSHT3a7VbCbpRRUp1b415g7lT52s6ziUwVj2fFxFhCZKrLMcVPOj4k+nZiQJ
         N6vOP9nwSh0/l8+67y5d97cRYnk2u5c5thf7YMYaskzmrxUGc4QfUPc8hT37XNbl0g
         VI92VOzWz/PMJDukgNSxm+sKQazYWttkO2CnApGqUMTbMmAu+YmQAO0/PnHPijYy4D
         zfubJrr8beXVkMhfE2NeLAmz0ZMY73nRn48eeQqpNx845AKhApJE7uOJh099Vt2HRt
         59J5D49rnk6zg==
Date:   Thu, 3 Nov 2022 21:10:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for 6.1
Message-ID: <20221103211016.1ddd0e9b@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit d76308f03ee1574b0deffde45604252a51c77f6d:

  Revert "coresight: cti: Fix hang in cti_disable_hw()" (2022-10-24 08:33:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1b

for you to fetch changes up to 7c919b619bcc68158921b1bd968f0e704549bbb6:

  tools: iio: iio_generic_buffer: Fix read size (2022-11-01 08:48:13 +0000)

----------------------------------------------------------------
2nd set of IIO fixes for 6.1

Another mixed bag of driver fixes.

* atmel,at91-sama5d2
  - Drop a 5 degree offset as not needed for production devices.
  - Missing iio_trigger_free() in error path.
* bosch,bma400
  - Turn power on before trying to read chip ID.
* bosch,bno055
  - Avoid uninitialized variable warning (no actual impact)
* meas,ms5611
  - Fix multiple instances of driver sharing single prom array.
  - Stop forcing SPI speed to max devices supports
* mps,mp2629
  - Wrong structure field used to match channel.
  - Missing NULL terminator.
* sysfs-trigger
  - Fix memory leak in error path.
* tools
  - Fix wrong read size when calling with noevents.

----------------------------------------------------------------
Claudiu Beznea (1):
      iio: adc: at91-sama5d2_adc: get rid of 5 degrees Celsius adjustment

Dan Carpenter (1):
      iio: imu: bno055: uninitialized variable bug in bno055_trigger_handler()

Jonathan Cameron (1):
      iio: accel: bma400: Ensure VDDIO is enable defore reading the chip ID.

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer: Fix read size

Mitja Spes (2):
      iio: pressure: ms5611: fixed value compensation bug
      iio: pressure: ms5611: changed hardcoded SPI speed to value limited

Saravanan Sekar (2):
      iio: adc: mp2629: fix wrong comparison of channel
      iio: adc: mp2629: fix potential array out of bound access

Yang Yingliang (2):
      iio: trigger: sysfs: fix possible memory leak in iio_sysfs_trig_init()
      iio: adc: at91_adc: fix possible memory leak in at91_adc_allocate_trigger()

 drivers/iio/accel/bma400_core.c      | 24 ++++++++---------
 drivers/iio/adc/at91-sama5d2_adc.c   |  6 ++---
 drivers/iio/adc/at91_adc.c           |  4 ++-
 drivers/iio/adc/mp2629_adc.c         |  5 ++--
 drivers/iio/imu/bno055/bno055.c      |  2 +-
 drivers/iio/pressure/ms5611.h        | 12 +++------
 drivers/iio/pressure/ms5611_core.c   | 51 +++++++++++++++++++-----------------
 drivers/iio/pressure/ms5611_spi.c    |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c |  6 ++++-
 tools/iio/iio_generic_buffer.c       |  4 +--
 10 files changed, 60 insertions(+), 56 deletions(-)
