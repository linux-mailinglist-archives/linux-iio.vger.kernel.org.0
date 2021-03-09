Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B6D33267D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCINUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCINUM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:12 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C7C06174A;
        Tue,  9 Mar 2021 05:20:12 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o10so8754773pgg.4;
        Tue, 09 Mar 2021 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UQXlkoZL9oIV4Vm/y3H2dkMxHwkxK4VsNYeOuqh9c0=;
        b=nZnVTGDqVOA4wPPRl/vxLH1zpDwIVKmhxegagbYco/EsThrlk3Npxs2ax9l80v9SZR
         eh4cODZzz7wtWcxfM9hn9d/S1TLT0Q0ChkQsGT7Q1p33e6p+b8siIF1XyXaL59XMZV0I
         zWrT6K2nVkesRY1+lzmYTRI26kicxcvBVr4sBr3VjMWZX1fxDAPsHC95UrE7sXYBQ6G0
         k2JvmPiTlIREN8r7fcBsyXb2N0LEJy1AtU4colTytxWyt/H5IDS8OkfXzwE5O/gKhoxL
         3Ab/9iu7DQIU9qRIYPuHmBKAJTZEgLRxIivVDziEUxJphgGo9k+v5a/ZRCcplClA3UAF
         ZvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UQXlkoZL9oIV4Vm/y3H2dkMxHwkxK4VsNYeOuqh9c0=;
        b=OcpIqV7ZU/VuYits6a+oJ2b3DLzq+XXYpAMc/q/ONHWoAmc2ubsIHyb+8M8c1VEAbJ
         hcH3CvfzGMGfeOa5ruuEib9M5w8ruf+3xo7zoZtkavEJ052ENegAqWkqoGAvaixxstH6
         LoahM+nVJFGm6ctP9gp7MWaYub97tg9TKUOUhMQEJE8Pr9gVmCzt36PEodk2ZuUkWo+M
         3Ks2O/vmedKdtoUvCchr7Jz2lSQVoInreAO7bUUGeSVCbN4WxUdRP0gUboneHUv8s0n2
         lmphwuzWse1eayZah7JtIj0TkYfqIVkJ0RagrvlUznxMYrAngtxj6jBpxPgKONLin976
         1XBA==
X-Gm-Message-State: AOAM531VBiv0lsOaqOEdZrZQz9w5kd7de8aBYU80pXpDxb6ddi50Myvh
        z4gBkvvBvHCOtZRmf7vIqmQ=
X-Google-Smtp-Source: ABdhPJxITphI+0Q1/mUBxAdrWpnlO5YBUHufs2D1Mk5a7ka6o7dmWAEbqklf8Zm62u5NOVP0XmW32A==
X-Received: by 2002:a63:df10:: with SMTP id u16mr7437528pgg.308.1615296011574;
        Tue, 09 Mar 2021 05:20:11 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:10 -0800 (PST)
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
Subject: [PATCH v9 00/33] Introduce the Counter character device interface
Date:   Tue,  9 Mar 2021 22:19:13 +0900
Message-Id: <cover.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v9:
 - Implemented example userspace counter application under tools/counter
 - Replaced extension*_name attributes with *_component_id attributes;
   this should hopefully be a more intuitive way to find the desired IDs
 - Changed to use regular spinlock because raw_spinlock is not needed
 - Implemented chrdev_lock mutex to limit chrdev to a single open() at a
   time
 - Improved struct counter_component documentation with examples
 - Reverted "counter_count_function" to "counter_function" naming change
   for drivers; individual maintainers can change this if they so desire
 - Utilized "return 0" in switch blocks to return early where possible
 - Utilized default cases in switch blocks to improve clarity and intent
 - Refactored counter_register to make use of cdev_add_device();
   counter_chrdev_add() has been simplified as a result
 - Inlined counter_chrdev_realloc_queue() because it is only used by the
   events_queue_size sysfs attribute
 - Replaced deprecated ida_simple_* calls with ida_alloc()/ida_free()
 - Made use of struct device "id" member to construct the cdev node name
 - Made use of kfifo_size() instead of rolling my own
 - Implemented changes necessary to migrate interrupt-cnt driver

Note that this revision is based on top of 5 prerequisite patches:
* counter: add IRQ or GPIO based counter
* dt-bindings: counter: add interrupt-counter binding
* counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register
* counter: stm32-timer-cnt: fix ceiling write max value
* counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED

I pulled out a lot of bits and pieces to their own patches; hopefully
that makes reviewing this patchset much simpler than before. This
patchset is also available on my personal public git repo for anyone who
wants a quick way to clone:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v9

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

William Breathitt Gray (33):
  docs: counter: Consolidate Counter sysfs attributes documentation
  docs: counter: Fix spelling
  counter: 104-quad-8: Remove pointless comment
  counter: 104-quad-8: Return error when invalid mode during
    ceiling_write
  counter: 104-quad-8: Annotate hardware config module parameter
  counter: 104-quad-8: Add const qualifiers for
    quad8_preset_register_set
  counter: 104-quad-8: Add const qualifier for functions_list array
  counter: interrupt-cnt: Add const qualifier for functions_list array
  counter: microchip-tcb-capture: Add const qualifier for functions_list
    array
  counter: stm32-lptimer-cnt: Add const qualifier for functions_list
    array
  counter: stm32-timer-cnt: Add const qualifier for functions_list array
  counter: 104-quad-8: Add const qualifier for actions_list array
  counter: ftm-quaddec: Add const qualifier for actions_list array
  counter: interrupt-cnt: Add const qualifier for actions_list array
  counter: microchip-tcb-capture: Add const qualifier for actions_list
    array
  counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
  counter: stm32-timer-cnt: Add const qualifier for actions_list array
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
  tools/counter: Create Counter tools
  counter: Implement signalZ_action_component_id sysfs attribute
  counter: Implement *_component_id sysfs attributes
  counter: Implement events_queue_size sysfs attribute
  counter: 104-quad-8: Replace mutex with spinlock
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |  112 +-
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   61 -
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec |   16 -
 Documentation/driver-api/generic-counter.rst  |  368 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    7 +-
 drivers/counter/104-quad-8.c                  |  739 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  486 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  192 +++
 drivers/counter/counter-sysfs.c               |  953 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   61 +-
 drivers/counter/interrupt-cnt.c               |   75 +-
 drivers/counter/microchip-tcb-capture.c       |  105 +-
 drivers/counter/stm32-lptimer-cnt.c           |  176 +-
 drivers/counter/stm32-timer-cnt.c             |  149 +-
 drivers/counter/ti-eqep.c                     |  221 +--
 include/linux/counter.h                       |  716 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  133 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   95 ++
 28 files changed, 3522 insertions(+), 2786 deletions(-)
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
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c


base-commit: 4ef57c4862e38e6034978d8b247a511292d7055a
prerequisite-patch-id: 41fda3a386861edad110c644567fad373a5a175e
prerequisite-patch-id: c6c2ab3173f5a0136d1e9b7b96ccd115fa35d66e
prerequisite-patch-id: 7e3cd78924d79890b690f3029e0d4f5b3902a73c
prerequisite-patch-id: 98f0a6c1d188a7dec01a5587fb7566ac637385a1
prerequisite-patch-id: 884299e23b6426ea43282e9701996e794cb6aa34
-- 
2.30.1

