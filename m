Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EA3F9327
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbhH0DtB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbhH0DtA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8453C0613C1;
        Thu, 26 Aug 2021 20:48:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so3109479plx.4;
        Thu, 26 Aug 2021 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqqSaS+xFujsg063LbIZ6FBQCRzCA3jZ3HiQj8yEsME=;
        b=AgugwqMn5os6t3tUSyTcSvTf2l8zIzffj+S3/N8V1kjd2adSs0Coe2rmeeEB+NUGq5
         +Nax/9LNA/4+rDZHly/8IJWb+lqcC4MLTTZMFL2DugCmdfuaQKd2nYrbJjAZL4cAEJH4
         xxYDS5c3VFVWpFnxtm+vZl+rIvYg4GIT3vWRZDTHtnaDkVnjs2W16k9kRChz2woZoM7C
         lDJxq2/YqCjBbjaC8nE8FFHAZ1Loy38POo1E1I6O1w7I67Ogoa++sqcNhXhU9sEX7D/P
         lHJYzNwZBmA/1ouche3oqhgEnOlUW9cgStv9qXgDCdfCQy18tgGdsiSLn3xXMtjsUJrz
         kmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqqSaS+xFujsg063LbIZ6FBQCRzCA3jZ3HiQj8yEsME=;
        b=KIC40b3qsFFNtyixa1KOQCrgYi/PMPbjjCYE122FR/zQuCvzuYo/M3OnrNar8w9IFj
         g0xbXGsnMtO7ozM1oGHZH2aC9e24/d38ud8wCr3Pnuhdxa59LUL9ooI5Do7czqHVmzo2
         jLhGp6tBPZcbtzUTCaJaY2LG5rYq2oQSBraoZkTIQawQTlykwTRYMG/ByaxapvsdGzki
         AKRHl1jckVR4BFWZCW94v3HMr4p4tclEtey983k88IkUXwaAzKh8+eD4b8eoHxnDE8yL
         n/TCq6F1Pzf+AhPiDUfieCMs+IGW88JJWpLxOjqdYVChuXCAV2f0slygjupRVz3bgKE9
         f7GQ==
X-Gm-Message-State: AOAM5321RgDfL+6OtH4KeVEWvf50gMNxgbSdFVUWS2IThqQiYaT66TGo
        rPT3umV3oQC3j6UwBNB9DWs=
X-Google-Smtp-Source: ABdhPJxNo38rlYLjA8U+ThfxFyw8VE6JDAO6SORGaGgH34iHp7uxCutHV+aYWuq2bXb6OENxHHVuVA==
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr8246555pjb.99.1630036092191;
        Thu, 26 Aug 2021 20:48:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:11 -0700 (PDT)
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
Subject: [PATCH v16 00/14] Introduce the Counter character device interface
Date:   Fri, 27 Aug 2021 12:47:44 +0900
Message-Id: <cover.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v16:
 - Define magic numbers for stm32-lptimer-cnt clock polarities
 - Define magic numbers for stm32-timer-cnt encoder modes
 - Bump KernelVersion to 5.16 in sysfs-bus-counter ABI documentation
 - Fix typos in driver API generic-counter.rst documentation file

For convenience, this patchset is also available on my personal git
repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v16

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

William Breathitt Gray (14):
  counter: stm32-lptimer-cnt: Provide defines for clock polarities
  counter: stm32-timer-cnt: Provide defines for slave mode selection
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
 drivers/counter/104-quad-8.c                  |  699 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  553 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  191 +++
 drivers/counter/counter-sysfs.c               |  960 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   60 +-
 drivers/counter/intel-qep.c                   |  144 +-
 drivers/counter/interrupt-cnt.c               |   62 +-
 drivers/counter/microchip-tcb-capture.c       |   91 +-
 drivers/counter/stm32-lptimer-cnt.c           |  212 ++-
 drivers/counter/stm32-timer-cnt.c             |  195 +--
 drivers/counter/ti-eqep.c                     |  180 +-
 include/linux/counter.h                       |  715 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/linux/mfd/stm32-lptimer.h             |    5 +
 include/linux/mfd/stm32-timers.h              |    4 +
 include/uapi/linux/counter.h                  |  154 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   93 +
 29 files changed, 3569 insertions(+), 2791 deletions(-)
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


base-commit: 5ffeb17c0d3dd44704b4aee83e297ec07666e4d6
-- 
2.32.0

