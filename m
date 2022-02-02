Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299104A7297
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiBBOC1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34607 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbiBBOCY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:24 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 301D2200008;
        Wed,  2 Feb 2022 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXn4IESIoPIAR0ctW8abTbeyhSdVMTKrdrsZbBfaEXQ=;
        b=P8RM9jMwsdZ/0hSsVX2ei2oc8UzWjZvUQeFrc9rBid9M9qCu+Ji1nZxRYTqDraYk27G0jT
        JjO+yjLPlkAruL6FB+Srn6hFYf0rHIJ+/A7LacJD6qt0pQqtx8aNBbroqO94+LVo3QfbVA
        DBxUJz/9QO39DRH3iIO2bgIsUKFfmqYSkVaII+7m+VWSIYybGj3FnXA3l6Y7dT3FjDO0w7
        25/8GWfAw8GVurk3D388gaJ8ZwUsCeEhcYCJ9yMuNQD7vCCMSfTytsqOj63bZ9P7Lzyt/2
        wpKKtDZEJUhG1UaXrLLJ50XKuslkCvjyudq+Tlf3kbEZI/PoBWltfjNBcLW7Fw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 12/12] iio: core: Clarify the modes
Date:   Wed,  2 Feb 2022 15:02:08 +0100
Message-Id: <20220202140208.391394-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
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
 include/linux/iio/iio.h | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 85cb924debd9..66eccae2b9d1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -315,7 +315,51 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
 
-/* Device operating modes */
+/**
+ * Device operating modes
+ * @INDIO_DIRECT_MODE: There is an access to the timely single value available.
+ * On most devices, this is a single-shot read. On some devices with data
+ * streams without an 'on-demand' function, this might also be the 'last value'
+ * feature. Above all, this mode internally means that we are not in any of the
+ * other modes, and sysfs reads should work.
+ * Device drivers should inform the core if they support this mode.
+ * @INDIO_BUFFER_TRIGGERED: Common mode when dealing with kfifo buffers.
+ * It indicates that an explicit trigger is required. This requests the core to
+ * attach a poll function when enabling the buffer, which is indicated by the
+ * _TRIGGERED suffix.
+ * The core will ensure this mode is set when registering a triggered buffer
+ * with iio_triggered_buffer_setup().
+ * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
+ * No poll function can be attached because there is no triggered infrastructure
+ * we can use to cause capture. There is a kfifo that the hardware will fill,
+ * but not "only one scan at a time". Typically, hardware will have a buffer
+ * that can hold multiple scans. Software may read one or more scans at a single
+ * time and push the available data to a Kfifo. This means the core will not
+ * attach any poll function when enabling the buffer.
+ * The core will ensure this mode is set when registering a simple kfifo buffer
+ * with devm_iio_kfifo_buffer_setup().
+ * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use this mode.
+ * Same as above but this time the buffer is not a kfifo where we have direct
+ * access to the data. Instead, the consumer driver must access the data through
+ * non software visible channels (or DMA when there is no demux possible in
+ * software)
+ * The core will ensure this mode is set when registering a dmaengine buffer
+ * with devm_iio_dmaengine_buffer_setup().
+ * @INDIO_EVENT_TRIGGERED: Very unusual mode.
+ * Triggers usually refer to an external event which will start data capture.
+ * Here it is kind of the opposite as, a particular state of the data might
+ * produce an event which can be considered as an event. We don't necessarily
+ * have access to the data itself, but to the event produced. For example, this
+ * can be a threshold detector. The internal path of this mode is very close to
+ * the INDIO_BUFFER_TRIGGERED mode.
+ * The core will ensure this mode is set when registering a triggered event.
+ * @INDIO_HARDWARE_TRIGGERED: Very unusual mode.
+ * Here, triggers can result in data capture and can be routed to multiple
+ * hardware components, which make them close to regular triggers in the way
+ * they must be managed by the core, but without the entire interrupts/poll
+ * functions burden. Interrupts are irrelevant as the data flow is hardware
+ * mediated and distributed.
+ */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
 #define INDIO_BUFFER_SOFTWARE		0x04
-- 
2.27.0

