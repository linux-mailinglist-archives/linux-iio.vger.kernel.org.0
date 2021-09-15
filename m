Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076640C8E8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhIOPxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:06 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47405 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbhIOPwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:52:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0797F20000D;
        Wed, 15 Sep 2021 15:51:17 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 00/14] Bring external triggers support to MAX1027-like ADCs
Date:   Wed, 15 Sep 2021 17:51:03 +0200
Message-Id: <20210915155117.475962-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Until now the max1027.c driver, which handles 10-bit devices (max10xx)
and 12-bit devices (max12xx), only supported hardware triggers. When a
hardware trigger is not wired it is very convenient to trigger periodic
conversions with timers or on userspace demand with a sysfs
trigger. Overall, when several values are needed at the same time, using
triggers and buffers improves quite a lot the performances.

This series does a bit of cleaning/code reorganization before actually
bringing more flexibility to the driver, up to the point where it is
possible to use an external trigger even without the IRQ line wired.

This series is currently based on a v5.15-rc1 kernel and the external
triggering mechanism has been tested on a custom board where the IRQ and
the EOC lines have not been populated.

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

Changes in v3:
* Rebased on top of v5.15-rc1.
* Dropped the useless change from devm_kmalloc to kmalloc because I
  thought devm_kmalloc allocations were still not suitable for DMA
  purposes.
* Added a comment explaining the use of the available and active masks
  in the code as suggested by Jonathan.
* Released the lock used in iio_device_claim_direct_mode() in the two
  error paths.
* Did not move the call to reinit_completion before
  wait_for_completion_timeout() as advised by Nuno because the
  triggering is done before entering the waiting thread, so there is a
  world were we reinit a completion object right before waiting for it
  (which would lead to a timeout).
* Deeply rewored the various handlers (see my answer to
  "[PATCH v2 15/16] iio: adc: max1027: Add support for external  triggers"

Changes in v2:
[All]
* Overall quite a few changes, I'll try to list them here but I made
  significant changes on the last few commits so it's hard to have an
  exhaustive and detailed list.
* Simplified the return statements as advised by Nuno.
* Dropped useless debug messages.
* Used iio_trigger_validate_own_device() instead of an internal
  variable when possible.
* Added Nuno's Reviewed-by's when relevant.
[Created a new patch to fix the style]
[Created a new patch to ensure st->buffer is DMA-safe]
[Push only the requested samples]
* Dropped a useless check over active_scan_mask mask in
  ->set_trigger_state().
* Dropped the st->buffer indirection with a missing __be16 type.
* Do not push only the requested samples in the IIO buffers, rely on the
  core to handle this by providing additional 'available_scan_masks'
  instead of dropping this entry from the initial setup.
[Create a helper to configure the trigger]
* Avoided messing with new lines.
* Dropped cnvst_trigger, used a function parameter instead.
[Prevent single channel accesses during buffer reads]
* Used iio_device_claim_direct_mode() when relevant.
* Dropped the extra iio_buffer_enabled() call.
* Prevented returning with a mutex held.
[Introduce an end of conversion helper]
* Moved the check against active scan mask to the very end of the series
  where we actually make use of it.
* Moved the Queue declaration to another patch.
[Dropped the patch: Prepare re-using the EOC interrupt]
[Consolidate the end of conversion helper]
* Used a dynamic completion object instead of a static queue.
* Reworded the commit message to actually describe what this commit
  does.
[Support software triggers]
* Dropped the patch and replaced it with something hopefully close to
  what Jonathan and Nuno described in their reviews.
[Enable software triggers to be  used without IRQ]
* Wrote a more generic commit message, not focusing on software
  triggers.


Miquel Raynal (14):
  iio: adc: max1027: Fix style
  iio: adc: max1027: Drop extra warning message
  iio: adc: max1027: Drop useless debug messages
  iio: adc: max1027: Minimize the number of converted channels
  iio: adc: max1027: Rename a helper
  iio: adc: max1027: Create a helper to enable/disable the cnvst trigger
  iio: adc: max1027: Simplify the _set_trigger_state() helper
  iio: adc: max1027: Ensure a default cnvst trigger configuration
  iio: adc: max1027: Create a helper to configure the channels to scan
  iio: adc: max1027: Prevent single channel accesses during buffer reads
  iio: adc: max1027: Separate the IRQ handler from the read logic
  iio: adc: max1027: Introduce an end of conversion helper
  iio: adc: max1027: Deeply rework interrupt handling
  iio: adc: max1027: Don't reject external triggers when there is no IRQ

 drivers/iio/adc/max1027.c | 301 ++++++++++++++++++++++++++++----------
 1 file changed, 223 insertions(+), 78 deletions(-)

-- 
2.27.0

