Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F453F0249
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhHRLMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:17 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36347 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhHRLMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A23EF60002;
        Wed, 18 Aug 2021 11:11:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/16] Bring software triggers support to MAX1027-like ADCs
Date:   Wed, 18 Aug 2021 13:11:23 +0200
Message-Id: <20210818111139.330636-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Until now the max1027.c driver, which handles 10-bit devices (max10xx)
and 12-bit devices (max12xx), only supported hardware triggers. When a
hardware trigger is not wired it is very convenient to trigger periodic
conversions with timers or on userspace demand with a sysfs
trigger. Overall, when several values are needed at the same time using
triggers and buffers improves quite a lot the performances.

This series starts with two small fixes, then does a bit of
cleaning/code reorganization before actually adding support for software
triggers.

This series has been developed and tested on a custom board with a 4.14
kernel. I then rebased the series on top of a mainline kernel
(v5.14-rc1) but unfortunately after quite some time debugging it I was
unable to get all the necessary blocks running in order to properly test
it. Anyway, there was very little changes in that series when rebasing
it from v4.14 to v5.14-rc1 so I am pretty confident it will smoothly
work with a more recent kernel.

How to test sysfs triggers:
    echo 0 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
    cat /sys/bus/iio/devices/iio_sysfs_trigger/trigger0/name > \
        /sys/bus/iio/devices/iio:device0/trigger/current_trigger
    echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltageX_en
    echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltageY_en
    echo 1 > /sys/bus/iio/devices/iio:device0/buffer/enable
    cat /dev/iio\:device0 > /tmp/data &
    echo 1 > /sys/bus/iio/devices/trigger0/trigger_now
    od -t x1 /tmp/data

Cheers,
Miquèl

Miquel Raynal (16):
  iio: adc: max1027: Fix wrong shift with 12-bit devices
  iio: adc: max1027: Fix the number of max1X31 channels
  iio: adc: max1027: Push only the requested samples
  iio: adc: max1027: Lower conversion time
  iio: adc: max1027: Drop extra warning message
  iio: adc: max1027: Rename a helper
  iio: adc: max1027: Create a helper to configure the trigger
  iio: adc: max1027: Explain better how the trigger state gets changed
  iio: adc: max1027: Create a helper to configure the channels to scan
  iio: adc: max1027: Prevent single channel accesses during buffer reads
  iio: adc: max1027: Separate the IRQ handler from the read logic
  iio: adc: max1027: Introduce an end of conversion helper
  iio: adc: max1027: Prepare re-using the EOC interrupt
  iio: adc: max1027: Consolidate the end of conversion helper
  iio: adc: max1027: Support software triggers
  iio: adc: max1027: Enable software triggers to be used without IRQ

 drivers/iio/adc/max1027.c | 236 ++++++++++++++++++++++++++++----------
 1 file changed, 177 insertions(+), 59 deletions(-)

-- 
2.27.0

