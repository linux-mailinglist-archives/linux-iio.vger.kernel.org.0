Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7ED319E10
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBLMOn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhBLMOl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:14:41 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CEC061574;
        Fri, 12 Feb 2021 04:14:00 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x14so8432363qkm.2;
        Fri, 12 Feb 2021 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4yEGF4AjXqnem5hKAuSPNf/U7YlqelstXtmTJWlhNI=;
        b=qeeJfbvFVl0h81JpFKFxtmMRQ10eHisgwd45W2GG7TM5yHTLOyZPV9gOdv7Mv2l2yg
         pnERECp342fv8J1aHQyL4PhoC9KoGNxukiqQR0YhWdjel+xmI8dPmMKImwLQywj1XEkv
         vW6lPFhEJl9q2mrvbwdJEiEajB1D6Tj47Jz2BMeEeJtpvK/y8fSYGYBuXBd6GlaN2mWa
         2FMS2PQ+RSVavlXbBe+3QoPnzo7LGbyUGlf+u/9CSg/hY+ahHf2K5dD7q/+UBCDu/0kY
         N28fGB8xikKFjZWZfLxL7UnZKHDQ8X0ms9BM1JByMIxCgFIbDSvxhX3osq70Y/+XRhg4
         7IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4yEGF4AjXqnem5hKAuSPNf/U7YlqelstXtmTJWlhNI=;
        b=KoDj9Sl5x/NrZzAFWzwVvuJPxOGYWSTBtMdLuHDfUjfr7eTask7D09XWK7tMqqqhUz
         d+4v/9X8WAbrHVHVayeR5YufF3Z/gV9AE0wTtm5X4f7ysHQnBv7xyR5OeLUMFfdthO4j
         fLzS24z4Xp+7kylAGfwqppuUT0CnCYzq8hpmm8dPdVWd3H7eqYCmX2erIwNO6pBKDBkY
         opKKLHissbDMzjNYe4IcSfZqvHFUWHFtoLVS6nIm6v5UZwCQB1TmqM6alqphRRNyBQpJ
         wz1xSygm01k3RRqD301vsMo2ltFAae1Yg+PY2V7pkNgSDSa17Fq+6BZ9jcoDPJIv1bP5
         qByw==
X-Gm-Message-State: AOAM530xoRC5MJUxhWlRJamv59n+bjrgSOdKk/x3heBpggJBxNxhnr2t
        Uc0w8A6AzgwVIh8QF34DLLU=
X-Google-Smtp-Source: ABdhPJxFsiQwibCIY/jzrkMEOjGRvL/Umh2DVWmeMRwmBlG0UpNjfOXTGn7C2OIHJu2eh2qGMrCXXA==
X-Received: by 2002:a37:992:: with SMTP id 140mr2317435qkj.349.1613132039638;
        Fri, 12 Feb 2021 04:13:59 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:13:59 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 00/22] Introduce the Counter character device interface
Date:   Fri, 12 Feb 2021 21:13:24 +0900
Message-Id: <cover.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v8:
 - Consolidated Counter sysfs ABI documentation to single file
 - Added events_queue_size sysfs attribute to allow users to dynamically
   resize the events queue
 - Fixed markup syntax and typos in generic-counter.rst
 - Improved documentation in include/uapi/linux/counter.h and friends
 - Renamed COUNTER_LOAD_WATCHES_IOCTL to COUNTER_ENABLE_EVENTS_IOCTL;
   Renamed COUNTER_CLEAR_WATCHES_IOCTL to COUNTER_DISABLE_EVENTS_IOCTL
 - Renamed the struct counter_event "errno" member to "status"
 - Dropped the "irq_trigger" 104-QUAD-8 sysfs attribute; this
   functionality now occurs implicitly via the Counter chrdev interface
 - Return -ERANGE where appropriate instead of -EINVAL
 - Simplified switch exit paths; return early when possible
 - Call devm_request_irq() before devm_counter_register() for 104-quad-8
 - Renamed devm_counter_unregister() to more apt devm_counter_release()
 - Use enum counter_scope for scope values in counter-sysfs.c
 - Use sysfs_emit() instead of sprintf() where appropriate
 - Renamed find_in_string_array() to more apt counter_find_enum()
 - Renamed *_action_get() and *_action_write() to *_action_read() and
   *_action_write() to match new naming convention of Counter callbacks
 - Use "Counter function" naming convention instead of "Counter count
   function" to avoid confusion about scope

I pulled out a lot of bits and pieces to their own patches; hopefully
that makes reviewing this patchset much simpler than before. This
patchset is also available on my personal public git repo for anyone who
wants a quick way to clone:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v8

The patches preceding "counter: Internalize sysfs interface code" are
primarily cleanup and fixes that can be picked up and applied now to the
IIO tree if so desired. The "counter: Internalize sysfs interface code"
patch as well may be considered for pickup because it is relatively safe
and makes no changes to the userspace interface.

To summarize the main points of this patchset: there are no changes to
the existing Counter sysfs userspace interface; a Counter character
device interface is introduced that allows Counter events and associated
data to be read() by userspace; the events_configure() and
watch_validate() driver callbacks are introduced to support Counter
events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
example of how to support the new Counter events functionality.

Something that should still be discussed: should the struct
counter_event "status" member be 8 bits or 32 bits wide? This member
will provide the return status (system error number) of an event
operation.

William Breathitt Gray (22):
  docs: counter: Consolidate Counter sysfs attributes documentation
  docs: counter: Fix spelling
  counter: 104-quad-8: Return error when invalid mode during
    ceiling_write
  counter: 104-quad-8: Annotate hardware config module parameter
  counter: 104-quad-8: Add const qualifiers for
    quad8_preset_register_set
  counter: 104-quad-8: Add const qualifier for functions_list array
  counter: 104-quad-8: Add const qualifier for actions_list array
  counter: ftm-quaddec: Add const qualifier for actions_list array
  counter: Return error code on invalid modes
  counter: Standardize to ERANGE for limit exceeded errors
  counter: Rename counter_signal_value to counter_signal_level
  counter: Rename counter_count_function to counter_function
  counter: Internalize sysfs interface code
  counter: Update counter.h comments to reflect sysfs internalization
  docs: counter: Update to reflect sysfs internalization
  counter: Move counter enums to uapi header
  counter: Add character device interface
  docs: counter: Document character device interface
  counter: Implement extension*_name sysfs attributes
  counter: Implement events_queue_size sysfs attribute
  counter: 104-quad-8: Replace mutex with spinlock
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |  100 +-
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   61 -
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec |   16 -
 Documentation/driver-api/generic-counter.rst  |  426 ++++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    6 +-
 drivers/counter/104-quad-8.c                  |  751 +++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  519 ++++++
 drivers/counter/counter-chrdev.h              |   18 +
 drivers/counter/counter-core.c                |  185 ++
 drivers/counter/counter-sysfs.c               |  889 ++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   69 +-
 drivers/counter/microchip-tcb-capture.c       |  105 +-
 drivers/counter/stm32-lptimer-cnt.c           |  186 +-
 drivers/counter/stm32-timer-cnt.c             |  187 +--
 drivers/counter/ti-eqep.c                     |  226 ++-
 include/linux/counter.h                       |  716 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  126 ++
 23 files changed, 3363 insertions(+), 2785 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h


base-commit: b72d4f6a5122a78941ce5a3147685d6a44939a75
-- 
2.30.0

