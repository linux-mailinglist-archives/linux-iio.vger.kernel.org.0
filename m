Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A1341A96
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCSLBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSLBE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9FC06174A;
        Fri, 19 Mar 2021 04:01:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t20so2783125plr.13;
        Fri, 19 Mar 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gkq0h39ISzzco6BRVF3l2YW0jWOrafmPSnRJn1TiGBE=;
        b=uRP4e+9Kn4f59ka1kUSSwEb3q24z/MByYaK3NP0QTMIFIc4pNFOcb9vZkTeQHglH5t
         /p6oF/+lZrUCr43oTuYXu+2PuR6MzQU4tiKyOCyFTEZUsWKpBfuZw8I/8MFlhrjVw80D
         99pB1rJpCuGxARVxqe62Yw42ooQaBuZwvo2A3AV1BVbso6AJ5c6ayFpJaBZRcR4U+Nzl
         hoF6Pce7B2hcH/2BQodtukTt2emugBT7nyPwVxxWU4lSsujxPG/++Ax6aM/dYVs+MygO
         uozk+GKYq6biS2QzRs8kDdqsBsZC5niVgiqdxUmtqL0q+xIu35GNcuTTrGK69TOhp64G
         CxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gkq0h39ISzzco6BRVF3l2YW0jWOrafmPSnRJn1TiGBE=;
        b=NMqwP2fVxxnqkRluRcsrHesRStTyAMVy7T/0F6xPfdxRwWgG0Sxr1/ihKhseFDTl0i
         cg7onaHaxQzcPcXD0nxc1riBFE8kTO0gLsXlMpRjqTV947bJ7lvaul5xF4IDFf0VG116
         6CeHhHVngxWGB9hqhq7L7CcdG/9Dt5v6kute9Fjpq2R+YSvh4ogWKZWPeNderO8MXcDF
         T+tx8+GnaRbVXaTFIzQOCbY7DSpSvEWf96mGlUgF83JuXZYiX9SpL3ufes1lAlK2aslT
         xi4dBRD2dML+LdIWMnwsCyoa6zLqgqYssGS9P7QKrXhtkhmgzKhPATnA2GgNHiY/x4Su
         IRYg==
X-Gm-Message-State: AOAM5313UQmkIe4eVX6WieK3tJJerw26I6MsQYOQsnVu6AVd+oB0BP4p
        V3nqmGBf3LuYRskSl6RmQfE=
X-Google-Smtp-Source: ABdhPJxGTnmR2hTYczbszDLnOs1JGCJVlO6VRBFrakMfJEu2aNWDy/wUXdBOdAz+N66YrAmJ4PHVeA==
X-Received: by 2002:a17:902:b7c5:b029:e6:1a9f:5f55 with SMTP id v5-20020a170902b7c5b02900e61a9f5f55mr13717024plz.57.1616151664203;
        Fri, 19 Mar 2021 04:01:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:03 -0700 (PDT)
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
Subject: [PATCH v10 00/33] Introduce the Counter character device interface
Date:   Fri, 19 Mar 2021 20:00:19 +0900
Message-Id: <cover.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v10:
 - Use sysfs_emit_at() in enums_available_show() and
   strs_available_show() in order to concatenate list of strings
 - Use sprintf() in counter_comp_id_show(); only printing an size_t so
   there is no risk of exceeding PAGE_SIZE

Note that this revision is based on top of 3 prerequisite patches:
* counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register
* counter: stm32-timer-cnt: fix ceiling write max value
* counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED

I pulled out a lot of bits and pieces to their own patches; hopefully
that makes reviewing this patchset much simpler than before. This
patchset is also available on my personal public git repo for anyone who
wants a quick way to clone:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v10

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


base-commit: 69333b92c35cdd6cdfc90c4f5daa418cfeb40213
prerequisite-patch-id: 41fda3a386861edad110c644567fad373a5a175e
prerequisite-patch-id: c6c2ab3173f5a0136d1e9b7b96ccd115fa35d66e
prerequisite-patch-id: 7e3cd78924d79890b690f3029e0d4f5b3902a73c
-- 
2.30.2

