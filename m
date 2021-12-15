Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FCE475B9D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbhLOPN4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:56 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54155 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243843AbhLOPNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 37057200016;
        Wed, 15 Dec 2021 15:13:54 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 10/10] iio: core: Clarify the modes
Date:   Wed, 15 Dec 2021 16:13:44 +0100
Message-Id: <20211215151344.163036-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of a previous discussion with Jonathan Cameron [1], it appeared
necessary to clarify the meaning of each mode so that new developers
could understand better what they should use or not use and when.

The idea of renaming these modes as been let aside because naming is a
big deal and requires a lot of thinking. So for now let's focus on
correctly explaining what each mode implies.

[1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-huawei/

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/iio/iio.h | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d04ab89fa0c2..75b561fd63d0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -314,7 +314,45 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
 
-/* Device operating modes */
+/**
+ * Device operating modes
+ * @INDIO_DIRECT_MODE: There is an access to the last single value available.
+ * On most devices, this is a single-shot read. On some devices with data
+ * streams without an 'on-demand' function, this might also be the 'last value'
+ * feature. Above all, this mode internally means that we are not in any of the
+ * other modes, and sysfs reads will definitely work.
+ * Device drivers are pleased to inquire the core about this mode.
+ * @INDIO_BUFFER_TRIGGERED: Most common mode when dealing with kfifo buffers.
+ * It indicates that there is an explicit trigger that must be used. This
+ * requests the core to attach a poll function when enabling the buffer, which
+ * is indicated by the _TRIGGERED suffix.
+ * The core will ensure this mode is set when registering a triggered buffer.
+ * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
+ * No poll function can be attached because there is no triggered infrastructure
+ * we can use to cause capture. There is a kfifo that the hardware will fill,
+ * but not "one scan at a time", just like in a continuous stream. This means
+ * the core will not attach any poll function when enabling the buffer.
+ * The core will ensure this mode is set when registering a simple kfifo buffer.
+ * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use this mode.
+ * Same as above but this time the buffer is not a kfifo where we have direct
+ * access to the data. Instead, the consumer driver must access the data through
+ * side-channels (or DMA when there is no demux possible in software).
+ * The core will ensure this mode is set when registering a dmaengine buffer.
+ * @INDIO_EVENT_TRIGGERED: Very specific, do not use this mode.
+ * Triggers usually refer to an external event which will start data capture.
+ * Here it is kind of the opposite as, a particular state of the data might
+ * produce an event which can be considered as an event. We don't necessarily
+ * have access to the data itself, but to the event produced. For example, this
+ * can be a threshold detector. The internal path of this mode is very close to
+ * the INDIO_BUFFER_TRIGGERED mode.
+ * The core will ensure this mode is set when registering a triggered event.
+ * @INDIO_HARDWARE_TRIGGERED: STM32 specific mode, do not use it.
+ * Here, triggers can result in data capture and can be routed to multiple
+ * hardware components, which make them close to regular triggers in the way
+ * they must be managed by the core, but without the entire interrupts/poll
+ * functions burden. All of this is irrelevant as it is all hardware mediated
+ * and distributed.
+ */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
 #define INDIO_BUFFER_SOFTWARE		0x04
-- 
2.27.0

