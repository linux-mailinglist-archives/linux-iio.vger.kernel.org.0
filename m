Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BF3BB8B1
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhGEIWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:22:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC184C061574;
        Mon,  5 Jul 2021 01:19:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so8402643pjh.4;
        Mon, 05 Jul 2021 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1P0C+fJT3E1BmyLma3Hvt+LmdbtbvRdt4PGsDvZhDo=;
        b=hbAxn5PkjyDIa6lxUCJXoInHZZziGv78nTgayqagi4cPk6CZAHbU6uAkYcE9ckzcBL
         lXmrxyWAcdQUgSxTak7vyp6yD+8kwgGIzFpuk/4nHM6A7OvByeaF38nm4f2SQilizy1j
         dF8aiUS9VDps+5xuRFEpgXt9Wm23VPxUwbzjBCzdjpRdvJAMzH/XYEILlAuPYYxlgPR8
         YJO8cvgoyw6KtHDnICzUV+FmvSgJD/6vfyqfnGithRmnD5rH9XfcKUTIRdsdDoDzSIQq
         MUfKS1D/YjhygvLbXvy/YlfnX2hEy34tjVkj+eR+4vX8oEKOi4nvbeKDQsCk3PgMZVXt
         mP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1P0C+fJT3E1BmyLma3Hvt+LmdbtbvRdt4PGsDvZhDo=;
        b=iYQMHj7I99kY+rwDcxiH9epsF3mns5SURI5YPXtWWnnYjUfVUyYRx+EqhCWB+rX9fa
         T7I3rxPkZb8MKmZ4dlWi+oPKHGHX0lqyBa4BWX1WbeaSPJygYMzpZJxeOBkVL0BaxE/U
         GaS0yROFOHdaEiu/k6dRwkyox9CwIUdDiv78ZFoG4776eI+2XCt9GIZON+f1XlqpUnSz
         DVt7CmAJPkp6vGjz4XwAQvYaOUPnW9QVYooUbT2b6j7yo2xm9Zf0TNYpge+eFLpsck5G
         tw+2DUtNc3b2L96wjlGke+AE5BZx2q8RVEmB01oWpvFZmlgbR4W5SlI7NflM6jzp0Lav
         8w0Q==
X-Gm-Message-State: AOAM533s4e3lN4Xn9vu87ohCI8WBW6NB2UsIwUvm/dtBXVh3tt4EBRvQ
        htPgCxS/PuPpV9FmgcUE+zI=
X-Google-Smtp-Source: ABdhPJyW07EURk2obQnItNdqKcxAHzpBo8dwmgWrp9zIifIAudIWcCD5SxYkGAzC63Rwk+MqT8t6hA==
X-Received: by 2002:a17:90a:5401:: with SMTP id z1mr13788644pjh.7.1625473164317;
        Mon, 05 Jul 2021 01:19:24 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:19:23 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 00/17] Introduce the Counter character device interface
Date:   Mon,  5 Jul 2021 17:18:48 +0900
Message-Id: <cover.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v12:
 - Move unlock to after register set in quad8_count_ceiling_write()
 - Add locking protection to counter_set_event_node()
 - Fix sparse warning by using {} instead of {0}
 - Clean up and organize comments for clarity
 - Reduce boilerplate by utilizing devm_add_action_or_reset()
 - Use switch statements in ti_eqep_action_read() to make possible cases
   more obvious

I pulled out a lot of bits and pieces to their own patches; hopefully
that makes reviewing this patchset much simpler than before. This
patchset is also available on my personal git repo for convenience:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v12

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

William Breathitt Gray (17):
  counter: 104-quad-8: Return error when invalid mode during
    ceiling_write
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

 Documentation/ABI/testing/sysfs-bus-counter   |   38 +-
 Documentation/driver-api/generic-counter.rst  |  366 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +-
 drivers/counter/104-quad-8.c                  |  728 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  498 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  182 ++
 drivers/counter/counter-sysfs.c               |  953 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   59 +-
 drivers/counter/intel-qep.c                   |  150 +-
 drivers/counter/interrupt-cnt.c               |   73 +-
 drivers/counter/microchip-tcb-capture.c       |  103 +-
 drivers/counter/stm32-lptimer-cnt.c           |  176 +-
 drivers/counter/stm32-timer-cnt.c             |  147 +-
 drivers/counter/ti-eqep.c                     |  205 ++-
 include/linux/counter.h                       |  716 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  133 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   95 ++
 27 files changed, 3501 insertions(+), 2767 deletions(-)
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


base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.32.0

