Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE363A0920
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhFIBev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:34:51 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:34354 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhFIBeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:34:50 -0400
Received: by mail-pj1-f47.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2722460pjx.1;
        Tue, 08 Jun 2021 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyDjY2O85FyQCTp9dYnoY5JdVe8zkT4Tb27VuFry0ys=;
        b=RrC/XuH3+XUHNmodeDqXQsKB3H56048bxwyZ2TqiGbybmvVrbMYLO8YNCzKCSNwTMq
         DzPBl/wmGWmolkzqfpQcgkItrLTZNEG82+eTtHmNj2TTW0KTm0kEBi76ZpiujVivdeuG
         gpUDSKjtrulJJMeAEjkFj/8KzyeCO0vTXhM4IxQ70n4Vo+2j03njgkcFbRHdAqWayG0P
         z9J1M3w1DhDcs9KtfJ660NMSJPRMi3JdQNXwLqngumK7YckvEWrkb/DXc7jRxH4Iq2Xp
         Q5EeCg20/6zdbrcHDjYNyOLnt6lW5ZnCJ0j0ElmhqLKL301UfSsurEu/GvV4gpkKbykV
         J5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyDjY2O85FyQCTp9dYnoY5JdVe8zkT4Tb27VuFry0ys=;
        b=rwOWMQptzm1pPNg8wG37QurmYbqYdVzuPMUPWa8JTSkV4ZjCcTHXydXyY4Hs8x+C0y
         2DRQivxDwqxnz4y0IhwoCh56hxettJABz5/o1ZrnnYwoIT7F3m1jn/Hur4oJQmceHzRu
         koNXnnHeMUwLDn82kX7TlyNzl+WYyMwxASIeJ0FG04QJTvfL1RsCCmnlCSfu0XUMTFDW
         udEISoMcsxwGpCN2+h/nQKefFELFf9i3gi/r2orSJhDczpaX0IW04Y18LP1zHHfj4pdE
         4orXI2pqyDxHi5mbX+8Ogx686/BfV2pcXHGFzFEykkMY2wdlUBiWTBYk7HH/VoF8bcXL
         Sw3Q==
X-Gm-Message-State: AOAM530wTnFN61jFwPNUBFrNpbp7Xn4O9vwWNh9AuqfQdB1il12dS8DL
        cnQD2CN4nkwwX2P/2yIlByc=
X-Google-Smtp-Source: ABdhPJyOd/UaMC79oy956Vrpo6w/NopzxFLJZ+5FGzHhb9a3Vj9fMMEIOT4e0hRFH09va6me3QpFGg==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr29791746pjb.102.1623202308523;
        Tue, 08 Jun 2021 18:31:48 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:31:47 -0700 (PDT)
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
Subject: [PATCH v11 00/33] Introduce the Counter character device interface
Date:   Wed,  9 Jun 2021 10:31:03 +0900
Message-Id: <cover.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v11:
 - Migrated Intel QEP to new interface
 - Context adjustments made for documentation

I pulled out a lot of bits and pieces to their own patches; hopefully
that makes reviewing this patchset much simpler than before. This
patchset is also available on my personal public git repo for anyone who
wants a quick way to clone:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v11

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
 drivers/counter/intel-qep.c                   |  150 +-
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
 29 files changed, 3586 insertions(+), 2872 deletions(-)
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

-- 
2.32.0

