Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26582BC924
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 21:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKVUaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 15:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVUaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 15:30:11 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97DC0613CF;
        Sun, 22 Nov 2020 12:30:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id u4so14725523qkk.10;
        Sun, 22 Nov 2020 12:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFhanjy6cq9u6pCyJCDCCRZRA7jLll7R0Ehj4TdK5o0=;
        b=N4ywAcKD2IvWeShu0qjc9ql+G8i0AyKLEQGeqLAX04FUo8WFkupSvGjf6I5PinnkpY
         6KF9/k1gOcY832IArpj9f/54rNcebtRsmh9n08YwLmQ7IBG/CP7foNwWTRLJgxlX6mzr
         Pku/98VSxlAXi9yWYKctM+f3tJkZw4PD7GZ9LPC2p6ZoxxE7QH8/5zgABnVb5DbzG9pi
         u/y3d9WNjqhT+gldyR6dsHZyXEXAyQnISKn1cTo5MWlG8VkhpDFzuLKAExbe0VOhP61b
         5PzZKvHVYWp9bojqZYUSAL0c1x9B1eGZZ8h+vXtfzHv/aeSconyzYn5a2mgkD7hIOFrW
         vvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFhanjy6cq9u6pCyJCDCCRZRA7jLll7R0Ehj4TdK5o0=;
        b=JkoNsjfpOBcdq1S+iZkbE8O2casdx+WQ0B2zwmqSRzUyyzueR7BxgMlN9ad/9HbvIG
         z5P1t5LE7woK6nqgMilIIq11EtH3Lb/xG5HqG+nJcJnacOuOuo3ZGWj3m7Q43dRHJNpL
         O8V4YkjzyPhSQzLXWMynRaHVVMECqfoOSZMDcFgnYwlCAnZoA18Q21xQbhbOsrf/GiL7
         PW9P/ohqpRiFvjSMRwc28y85SY1SVyvoQuuN+ISLhF5nu048K/2hGg2wtuPZAMidbEle
         hd8vrsvhUzoOAAZU4aZzFjPFJFPedEKMJ4FoejOiJ6O7QoYA52zu3Duv9mVJi2a3+Ibq
         ACug==
X-Gm-Message-State: AOAM530HdmE6IDz3mDRoK7/fKgb4gpStTpgMO3iu9sdhlNeTpk+c1kRq
        ekR+q0hc3/I5AkXYZtDkWoU=
X-Google-Smtp-Source: ABdhPJzq54eLjNm5Ffz3tvoJrUF/q/GsxjpylgX1f2FqFwqX4injx0UeWHvV3YrXi1CDe/3CrnEYaQ==
X-Received: by 2002:a37:5103:: with SMTP id f3mr6622004qkb.460.1606077010337;
        Sun, 22 Nov 2020 12:30:10 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p73sm7446522qka.79.2020.11.22.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 12:30:09 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 0/5] Introduce the Counter character device interface
Date:   Sun, 22 Nov 2020 15:29:51 -0500
Message-Id: <cover.1606075915.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v6:
 - Consolidated the value member of struct counter_event down to a
   single u64; u64 should be capable of representing all component
   values
 - Removed extension width sysfs attributes; no longer needed when value
   is always u64
 - Implemented COUNTER_COMPONENT_DUMMY to allow timestamp grabs without
   component data reads
 - Implemented events_config() callback; called during
   COUNTER_CLEAR_WATCHES_IOCTL and COUNTER_LOAD_WATCHES_IOCTL in order
   to allow devices a chance to adjust (enable/disable IRQ, etc.) for
   the new events configuration requested by the user
 - Simplified example code in Documentation by removing confusing use of
   poll() call
 - Removed redundant ida_simple_remove() from counter_register()
 - Renamed devm_counter_unreg() to devm_counter_unregister()
 - Renamed functions in counter-sysfs.c to be clearer
 - Fixed miscellaneous typos throughout files
 - Added more kernel doc comments; I've left some defines without
   comments if they seemed obvious -- but please let me know if further
   documentation is needed
 - Refactored quad8_irq_handler() to use WARN_ONCE() instead of
   returning on error; this should prevent interrupts from entering an
   endless loop
 - General refactoring and additional comments for clarity
 - Returns EOPNOTSUPP instead of EFAULT now if a Counter watch is added
   for unsupported component
 - Renamed COUNTER_SET_WATCH_IOCTL TO COUNTER_ADD_WATCH_IOCTL to make
   the use clear
 - Reimplemented the parent and id members of struct counter_component
   as __u8 instead of __u64; it's unlikely we'll ever have a device that
   supports more than 255 components
 - Reimplement __u64 variables in include/uapi/linux/counter.h as
   __aligned_u64 to prevent 32-bit vs 64-bit alignment issues
 - Fixed return value bug in counter_comp_u8_store(); enums set to a
   value with index > 0 should now work correctly
 - Fixed spectre issues in counter-chrdev.c
 - Removed redundant get_device() call from counter_register()
 - Moved put_device() to after the events_list is freed lest we leak
   memory

I'm skipping the introduction blurb because it was just a rehashing of
information included in the documentation patches within this patchset.
Instead I will focus this cover letter on discussions about this
patchset and the userspace interface implications.

1. Should standard Counter component data types be defined as u8 or u32?

   Many standard Counter component types such COUNTER_COMP_SIGNAL_LEVEL
   have standard values defined (e.g. COUNTER_SIGNAL_LEVEL_LOW and
   COUNTER_SIGNAL_LEVEL_HIGH). These values are currently handled by the
   Counter subsystem code as u8 data types.

   If u32 is used for these values instead, C enum structures could be
   used by driver authors to implicitly cast these values via the driver
   callback parameters.

   This question is primarily addressed to David Lechner. I'm somewhat
   confused about how this setup would look in device drivers. I've gone
   ahead and refactored the code to support u32 enums, and pushed it to
   a separate branch on my repository called counter_chrdev_v6_u32_enum:
   https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v6_u32_enum

   Please check it out and let me know what you think. Is this the
   support you had in mind? I'm curious to see an example of how would
   your driver callback functions would look in this case. Is everything
   works out fine, then I'll submit this branch as v7 of this patchset.

2. How should we handle "raw" timestamps?

   Ahmad Fatoum brought up the possibility of returning "raw" timestamps
   similar to what the network stack offers (see the network stack
   SOF_TIMESTAMPING_{RAW,SYS}_HARDWARE support).

   I'm not very familiar with the networking stack code, but if I
   understand correctly the SOF_TIMESTAMPING_RAW_HARDWARE timestamps are
   values returned from the device. If so, I suspect we would be able to
   support these "raw" timestamps by defining them as Counter Extensions
   and returning them in struct counter_event elements similar to the
   other Extension values.

William Breathitt Gray (5):
  counter: Internalize sysfs interface code
  docs: counter: Update to reflect sysfs internalization
  counter: Add character device interface
  docs: counter: Document character device interface
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |   18 +-
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   32 +
 Documentation/driver-api/generic-counter.rst  |  411 ++++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    2 +-
 drivers/counter/104-quad-8.c                  |  778 +++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  476 ++++++
 drivers/counter/counter-chrdev.h              |   16 +
 drivers/counter/counter-core.c                |  183 ++
 drivers/counter/counter-sysfs.c               |  806 +++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   60 +-
 drivers/counter/microchip-tcb-capture.c       |  114 +-
 drivers/counter/stm32-lptimer-cnt.c           |  175 +-
 drivers/counter/stm32-timer-cnt.c             |  145 +-
 drivers/counter/ti-eqep.c                     |  224 +--
 include/linux/counter.h                       |  676 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  105 ++
 22 files changed, 3094 insertions(+), 2689 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h

-- 
2.29.2

