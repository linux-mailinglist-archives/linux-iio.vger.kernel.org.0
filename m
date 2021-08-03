Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE93DED5D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhHCMGv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhHCMGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:06:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282FC061757;
        Tue,  3 Aug 2021 05:06:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so4415984pjd.0;
        Tue, 03 Aug 2021 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxfbPiz+OAcunKQUJDKkMXC8YuoZmJfrrdd8jRqpaxk=;
        b=UXy+yxDdKtiLc0N9wSz60KM58J9GQ7PHrrI15wKth4LRDoXDgYpyEDkLNScoXfNX4J
         OZTipAKwywS7CODr+fO2UgPsfsgo/+OVcCm43B3n4Ofgu507IMWkiNr6l+DZW+17kBTT
         BdN3M2+dCB9qgs4rD+7Kbveu1I2RATNjv8Nq6GGJhSvE3npG2+s1UmlVnoeCa+4zlicj
         YSpIJ04y3+Z9R+1W488qhrlP9r8QLtNo5+MJXam0LHYcz3hQTknZnieZF7wKGnMSfyDU
         49mzH/Wd+60E718va1p7+JfXZYIeEr7zrJPC1eMUmfb23OEodgIrltg9xTTTL5T+SGzr
         QXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxfbPiz+OAcunKQUJDKkMXC8YuoZmJfrrdd8jRqpaxk=;
        b=ae6PTJZtLJoVff5Wf+pma3d3wnQliQ5cn879l3BRQdoqQxpC9tuRLaEUv8qTQdKfsT
         vljEMIC1rfJ06aTEXx2PirG/L2wpV12dObQKqMa6FFDM8ZGf725LCwf5ly2b2Jm7R1ah
         qVx1amMKGLskSjZoDUvAg2YHlnKDkWiCGkFIe5ATFMlFUxMBeBM9/DGBCPrjLXRzxTE1
         MPoTBK36OqbLCUUW6Jt6ljc0YUjj5d9TcpvaURMSgT1MyXYKlwSr0NPeBzCxq6pnkgwz
         bm/xxk4fDGylqIswbD3qJUDGasSQysYN5mbclSyu5s8YjcCW8Q6oEpYwuTTAbt1yKfYa
         +u8w==
X-Gm-Message-State: AOAM533yS7JTOV5caTk4qpDmhZzA8ni2xPYo3QbJY1T7+k3tOLuc1Vd8
        7/lL+Vz48YVUTMIzUNJbundeh58nMzYkTg==
X-Google-Smtp-Source: ABdhPJzM9f53hVzeiMglAza3PHeo7CQhGnWlK0216I+XYmn8dFkYsjjkmHml4H7YMnzUHlBpMZg5eQ==
X-Received: by 2002:a63:556:: with SMTP id 83mr221918pgf.1.1627992399142;
        Tue, 03 Aug 2021 05:06:39 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:06:38 -0700 (PDT)
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
Subject: [PATCH v14 00/17] Introduce the Counter character device interface
Date:   Tue,  3 Aug 2021 21:06:10 +0900
Message-Id: <cover.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v14:
 - Initialize counter_fops owner to THIS_MODULE
 - Implement ops_exist_lock to prevent counter->ops use during removal
 - Set counter->ops to NULL on counter_unregister to indicate removal;
   chrdev callbacks return -ENODEV if driver is removed
 - Refactor counter_fops read, poll, ioctl, and release callbacks to
   utilize ops_exist_lock where needed and to check counter->ops
 - Wake up sleeping chrdev read() on counter_unregister
 - Move chrdev_lock introduce to the "counter: Add character device
   interface" patch; this is a more appropriate place to introduce this
   lock because the chrdev code is intended from the get-go to only
   allow for a single open() at a time

For convenience, this patchset is also available on my personal git
repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v14

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
 Documentation/driver-api/generic-counter.rst  |  358 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +-
 drivers/counter/104-quad-8.c                  |  728 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  553 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  192 +++
 drivers/counter/counter-sysfs.c               |  962 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   59 +-
 drivers/counter/intel-qep.c                   |  150 +-
 drivers/counter/interrupt-cnt.c               |   73 +-
 drivers/counter/microchip-tcb-capture.c       |  103 +-
 drivers/counter/stm32-lptimer-cnt.c           |  211 ++-
 drivers/counter/stm32-timer-cnt.c             |  147 +-
 drivers/counter/ti-eqep.c                     |  205 ++-
 include/linux/counter.h                       |  719 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  154 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   93 +
 27 files changed, 3623 insertions(+), 2768 deletions(-)
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

