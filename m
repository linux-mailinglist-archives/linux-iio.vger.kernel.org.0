Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19B41BD2B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhI2DSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhI2DSH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F27C061745;
        Tue, 28 Sep 2021 20:16:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y186so1308305pgd.0;
        Tue, 28 Sep 2021 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nU8NjFcHiQb2juc6iNrXx4yBJlrwbry86U2d9RYhoEc=;
        b=ea9XZQK839csHLMExTfIPXgY4B/YhV0ikwP4KLbKfdTb1LxOXTjjd0FVIUV/iIJWtZ
         Lp5uwzTHdT025gACEWTVCKrIqCotGjaBLQ2fdEw97UKlIqGfhBxF8mpgRoTfseMak8EI
         Pii6a5Q8dYw9f4vuaUYTjBrqxpCrN9H+dPa2rYDVJqnlspqTa1hi5LRVIIcO1OQOY/J2
         /sWp0UxttFYUMYY44ACDYqPLL00wDoi1wzuhxoc4UWCUsV8jk6DYJM+a97gNnoZktkwd
         pIquPCHLds98CRSIZoF668JVQX5NqZQ0i+EenkdwUmfiTCZ3MPavZwYbvxGcClk+dYcZ
         /mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nU8NjFcHiQb2juc6iNrXx4yBJlrwbry86U2d9RYhoEc=;
        b=F0c0SlXFSYRcZTNl700bvSx3mgrrDD+dcGvMX8xDX+FpJi/HSJfQEwB05DOuYuEUnS
         0zBVx66SbyyWlk6XzerPXYzxv0erNSZDRJ8RdyW0nzVe4PlawGliQBJYT0QcISp3Cg9w
         Pxc2puUYRh+43HBigQytVTui6s4Gz/q0bkPpT0mekIgAyxQNkQEv7QvsgHsv7FLgw4aU
         GiYUNF68UMTx1UfzUATzjIpacWrcPsgU7DXujkz90TKLKB6k/giuRFdK+agZ5RlIk4sr
         Opp1tY58ckZQf/rbfPmBq5j5u88Qoc8QFhGdxTj9u+2GxRgEYrwYISvQqOiyezZniuEa
         b9OQ==
X-Gm-Message-State: AOAM531kpa272zTuhoXBO3sTYlujHkkaSugO5osxgdA+YQlUeIgzEKgQ
        d3RygR1mPSWb0zYCS2YV2ng=
X-Google-Smtp-Source: ABdhPJypHhopEVNS9JguXT5SH+XWxunhd/Pyg0tmBrjCHDWxgUIykr9qaW8Y1Ww9rfYyZjTNTWu8AA==
X-Received: by 2002:a63:e057:: with SMTP id n23mr7793886pgj.183.1632885386999;
        Tue, 28 Sep 2021 20:16:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:16:26 -0700 (PDT)
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
Subject: [PATCH v17 0/9] Introduce the Counter character device interface
Date:   Wed, 29 Sep 2021 12:15:57 +0900
Message-Id: <cover.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v17:
 - A couple minor improvements to documentation from review suggestions
 - chrdev_lock redeclared as atomic_t; BITMAP was not necessary because
   chrdev_lock is a single flag
 - test_and_set_bit_lock(), clear_bit_unlock(), and clear_bit(),
   replaced respectively with atomic_add_unless(), atomic_dec(), and
   atomic_set()
 - counter_comp_read_is_equal() and counter_comp_read_is_set() macros
   implemented in order to properly test counter_comp structures' read
   callback states
 - counter_sysfs_add() call performed before counter_chrdev_add() call
   in counter_register() in order to match unwinding sequence
 - for-loop utilized in counter-example.c in order to simplify code
 - counter-example.c returns 1 on error instead of -errno; errno may be
   modified after a subsequent library call so we can't depend on it

For convenience, this patchset is also available on my personal git
repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v17

A Counter character device interface is introduced that allows Counter
events and associated data to be read() by userspace; the
events_configure() and watch_validate() driver callbacks are introduced
to support Counter events; and IRQ support is added to the
104-QUAD-8 driver, serving as an example of how to support the new
Counter events functionality.

William Breathitt Gray (9):
  counter: Move counter enums to uapi header
  counter: Add character device interface
  docs: counter: Document character device interface
  tools/counter: Create Counter tools
  counter: Implement signalZ_action_component_id sysfs attribute
  counter: Implement *_component_id sysfs attributes
  counter: Implement events_queue_size sysfs attribute
  counter: 104-quad-8: Replace mutex with spinlock
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |  29 +
 Documentation/driver-api/generic-counter.rst  | 177 ++++--
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/counter/104-quad-8.c                  | 256 ++++++--
 drivers/counter/Kconfig                       |   6 +-
 drivers/counter/Makefile                      |   2 +-
 drivers/counter/counter-chrdev.c              | 578 ++++++++++++++++++
 drivers/counter/counter-chrdev.h              |  14 +
 drivers/counter/counter-core.c                |  56 +-
 drivers/counter/counter-sysfs.c               | 123 +++-
 include/linux/counter.h                       |  98 +--
 include/uapi/linux/counter.h                  | 154 +++++
 tools/Makefile                                |  13 +-
 tools/counter/Build                           |   1 +
 tools/counter/Makefile                        |  53 ++
 tools/counter/counter_example.c               |  92 +++
 17 files changed, 1509 insertions(+), 146 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 include/uapi/linux/counter.h
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c


base-commit: a5ae0cfd53aaf031c2e9ba048281776fa67047c2
-- 
2.33.0

