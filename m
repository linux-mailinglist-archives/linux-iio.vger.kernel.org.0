Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12E2E2CA5
	for <lists+linux-iio@lfdr.de>; Sat, 26 Dec 2020 01:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLZAQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Dec 2020 19:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLZAQ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Dec 2020 19:16:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9CC061757;
        Fri, 25 Dec 2020 16:15:45 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h19so3606982qtq.13;
        Fri, 25 Dec 2020 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVdvTATmDwmYxloj8TKrwN2TG5yZBfCLk/8JXYC6itA=;
        b=kvXDNmNW7SUXGtbW7J5cQlCOUNP/LGcd5R13he3ecyHyWNrJ+1R2licXt5Jt1G+hJU
         zaQ+/rf4B+6HbtIIN5GfWs3+UVO1mNXX0fAusIx0FhkPcZUkzM4Y3BhIZ0Yxh0CCQru0
         SpI3EYt3Tfni/gFhAu5TnBrwAdtG22+8BNLfjNAMnwQYviOTR47OgeBBJ8sWNmVMt6mb
         MUB5zz2owDp7Uo8h45+Co6aTFlQF/DTuv5hkt1Vh2QGcPz6JrD7IXMpS+4XK9vBTk5YW
         AYKClxJNimyLmqsovzMDDLu73zYQ7H18cyCN60NmqK1oiMa7JPbZytwBWXxMVkceQsPm
         tQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVdvTATmDwmYxloj8TKrwN2TG5yZBfCLk/8JXYC6itA=;
        b=qnxb2KCbR+rftuEFf9861HXpdgZZjyaF8X6KNkbAQ9iOPn4ErqCibLnXlSqmUbbgKV
         FG2NH7u0YftfAh3NN98cQi/Dder+FTOS7egEkgEj6mE5/bYJrqpYB8QWCLpklF1qintO
         Y1iJhI+BFzQW1gXrqw5seGjFOFqtllKR3fV9v4p/8aw/HlfbZDVbyc230fT+uT+NTPCK
         meyKG03NAzes/cQ9eWbklxvZwi/d4od0FDK3URscdRhzaMWoEKNh4+45pe2SbbYl4uDG
         GkMKMnHJThNH0dOmX4ELPiQlF0CO4aFdgv18SuKFt4N9h3eD3CQES65htccYWZcyx5+s
         TbUQ==
X-Gm-Message-State: AOAM531F9aSqcTLKT7RmSJRUk0mWB6Wq38ryLhE/DONC2R/lkXfHRRZ6
        hwdrw0+UFJRsR/5O8EhK6xA=
X-Google-Smtp-Source: ABdhPJw1rPdFlbbhKKxus59aWuh+wxbn5TechZTGZasdUXRn6/Z7LRnigRTWJTtoxjwQ/trTlAq2rg==
X-Received: by 2002:a05:622a:a:: with SMTP id x10mr35164641qtw.29.1608941742965;
        Fri, 25 Dec 2020 16:15:42 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id b14sm18349966qtx.36.2020.12.25.16.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 16:15:42 -0800 (PST)
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
Subject: [PATCH v7 0/5] Introduce the Counter character device interface
Date:   Fri, 25 Dec 2020 19:15:33 -0500
Message-Id: <cover.1608935587.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v7:
 - Implemented u32 enums; enum types can now be used directly for
   callbacks and values
 - Fixed refcount underflow bug
 - Refactored all err check to check for err < 0; this should help
   prevent future oversights on valid positive return valids
 - Use mutex instead of raw_spin_lock in counter_chrdev_read();
   kifo_to_user() can now safely sleep
 - Renamed COUNTER_COMPONENT_DUMMY to COUNTER_COMPONENT_NONE to make
   purpose more obvious
 - Introduced a watch_validate() callback
 - Consolidated the functionality to clear the watches to the
   counter_clear_watches() function
 - Reimplemented counter_push_event() as a void function; on error,
   errno is returned via struct counter_event so that it can be handled
   by userspace (because interrupt handlers can't do much for this)
 - Renamed the events_config() callback to events_configure();
   "events_config" could be confused as a read callback when this is
   actually intended to configure the device for the requested events
 - Reimplemented 104-QUAD-8 driver to use events_configure() and
   watch_validate() callbacks; irq_trigger_enable sysfs attribute
   removed because events_configure() now serves this purpose

The changes for this revision were much simpler compared to the previous
revisions. I don't have any further questions for this patchset, so it's
really just a search for possible bugs or regressions now. Please test
and verify this patchset on your systems, and ACK appropriately.

To summarize the main points: there are no changes to the existing
Counter sysfs userspace interface; a Counter character device interface
is introduced that allows Counter events and associated data to be
read() by userspace; the events_configure() and watch_validate() driver
callbacks are introduced to support Counter events; and IRQ support is
added to the 104-QUAD-8 driver, serving as an example of how to support
the new Counter events functionality.

William Breathitt Gray (5):
  counter: Internalize sysfs interface code
  docs: counter: Update to reflect sysfs internalization
  counter: Add character device interface
  docs: counter: Document character device interface
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |   18 +-
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   25 +
 Documentation/driver-api/generic-counter.rst  |  416 ++++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    2 +-
 drivers/counter/104-quad-8.c                  |  799 +++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  490 ++++++
 drivers/counter/counter-chrdev.h              |   16 +
 drivers/counter/counter-core.c                |  182 ++
 drivers/counter/counter-sysfs.c               |  868 ++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   61 +-
 drivers/counter/microchip-tcb-capture.c       |  103 +-
 drivers/counter/stm32-lptimer-cnt.c           |  181 +-
 drivers/counter/stm32-timer-cnt.c             |  149 +-
 drivers/counter/ti-eqep.c                     |  224 +--
 include/linux/counter.h                       |  716 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  123 ++
 22 files changed, 3259 insertions(+), 2676 deletions(-)
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

