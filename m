Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8C3E45AF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhHIMiO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhHIMiO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:38:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A9C0613D3;
        Mon,  9 Aug 2021 05:37:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l11so4540193plk.6;
        Mon, 09 Aug 2021 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRRfOMGRdWmSmqR/jCwDTPGfm5oA2KrQYIknx7HPYGM=;
        b=I02Ftysn1jyRMA2SJeLr+43VRYWurwqgoEHDJmLgc1b1Bd0xeN53XOIO9KbKJr9Yfi
         Dk7wx7icdBf8R9qnHBk3xNey7IMzRYLbggFRZNTbiL8HhqPNw6KT789G43ca4XxfaKxT
         KEMQHvo8riJOkZAwS+gskQLWsGhlCjCWTJKw8ix3nn8YR6mUd80sm/Jc6Kx2rCWXAoHt
         +nhO5BJabIqH9RS952X36lHKN6WISl/Wire8zRq8iy/Iud9RX+V3IiTHdBDFlrg+Gfa8
         dOLTjfR79K5QngmF9PGd3kVrgV993G4v+kH65wrzKdivXYj8rHZaWYZ0oq336p/AyUIm
         joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRRfOMGRdWmSmqR/jCwDTPGfm5oA2KrQYIknx7HPYGM=;
        b=o+XJP8KtK2uq/x1eIEKPSIEO5zZ97DFHfQYoHOd3jvrMfXhnTe8v6vsQYxBjdgBX3V
         8H6KAsSOyNxKvk1ZQtwmnatliCZTWeFpFZnB8kl85eotefajeY3OAp3sJlaq0p2cXUct
         JHsMkN+7bouIu7gi1Ruuvl3QCBOPvqmk9XsDYzn0bAN3m/E/gJUXrTTCSYz/3aAu9kRk
         +yUJYq122Re7D/GUmYt0Uieqr3C3QEMGN6BaJ2rXcHUZtpSzrpZjLhCf/NNtXYnKDWhe
         XQzFYg1kY8eYNWjmjDqlyUtqY0vsZzP4K2fhvKUrte5mxmXNdhSt3BBk4C43P3gk+h1T
         eqTw==
X-Gm-Message-State: AOAM532JaPzF+QFKYVgmrCLeV7D93LQHrEBreHm5cxUJcf7EWRDVLIv5
        bpA7zryGIZtaZnG2M/kMjjk=
X-Google-Smtp-Source: ABdhPJzZQp34WPlUWoCcv5TWsKqOi0aBXJs0mxrtXU6YexojYGaftCiT8EJK3MwGkNBMYo1lUU97Rg==
X-Received: by 2002:a05:6a00:bd3:b029:3c6:9c64:9771 with SMTP id x19-20020a056a000bd3b02903c69c649771mr23237597pfu.78.1628512673418;
        Mon, 09 Aug 2021 05:37:53 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:37:52 -0700 (PDT)
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
Subject: [PATCH v15 00/13] Introduce the Counter character device interface
Date:   Mon,  9 Aug 2021 21:37:25 +0900
Message-Id: <cover.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v15:
 - Move the description for the member 'lock' in the 'quad8' structure
   as a separate patch
 - Reorganize the "counter: Internalize sysfs interface code" patch to
   not call chrdev code; respective code moved to the "counter: Add
   character device interface" patch with the other chrdev code
 - Custom enums removed from the ftm-quaddec.c, stm32-lptimer-cnt.c, and
   stm32-timer-cnt.c files; respective drivers refactored to use the
   COUNTER_FUNCTION_* and COUNTER_SYNAPSE_* enum constants instead

For convenience, this patchset is also available on my personal git
repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v15

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

William Breathitt Gray (13):
  counter: 104-quad-8: Describe member 'lock' in 'quad8'
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
 Documentation/driver-api/generic-counter.rst  |  358 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +-
 drivers/counter/104-quad-8.c                  |  700 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  553 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  191 +++
 drivers/counter/counter-sysfs.c               |  962 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   60 +-
 drivers/counter/intel-qep.c                   |  144 +-
 drivers/counter/interrupt-cnt.c               |   62 +-
 drivers/counter/microchip-tcb-capture.c       |   91 +-
 drivers/counter/stm32-lptimer-cnt.c           |  226 +--
 drivers/counter/stm32-timer-cnt.c             |  179 +-
 drivers/counter/ti-eqep.c                     |  180 +-
 include/linux/counter.h                       |  715 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  154 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   93 +
 27 files changed, 3568 insertions(+), 2784 deletions(-)
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


base-commit: c886885336b0b5f1a08ce580f7201a2ca30ab041
prerequisite-patch-id: 8ca55ffcdd5d060dd5fa2b4dd50bf01dc1026da6
prerequisite-patch-id: 46ef2668ca6bdc0d08dd488fe1d2b886189a5652
prerequisite-patch-id: 2df1946c917d6408148306db30a071e67b00ad73
prerequisite-patch-id: f81579f50552e6041a95403cc743c5f36962b111
prerequisite-patch-id: 8a6860e75cdec162812c56dc39c5d7fc6fc5154e
-- 
2.32.0

