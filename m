Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE5228932
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGUTgK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgGUTgJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:36:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B2C061794;
        Tue, 21 Jul 2020 12:36:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so17680qtm.10;
        Tue, 21 Jul 2020 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7rGcqeaKO7k4itsNk5qHhnQB9CfMz1CeEei7jxa15c=;
        b=fJImzWua3xh+vbSoJVn0n3E7PGhZCPcwgMGLNoAuVR+N/l13zae7Z+q9j9ensSesqI
         1MB88z+61Ra/QsDPCIzqAzIZN6zlfRFmO6E4+emq0dJMuU0OAvQbi/ywL7qw15OlcA2P
         zvVwRVJeObz51Mi+fmKbpa16lXfxqagrZHMDKIYV9cHUgxX+HlGA6FuBOQ/XdULwSdTl
         1dlweGzzxXhWkL5XP+4RfPHKUEIZH/KhquQdoQBRySJZe8IQJEJaQSTX1ECRZtLNJeb9
         EzulkKH+yK2IBJ2ObMiVBl7VbNbbToQdy9m5wWIX0irbuYhhSKZA8IEcpDYBPApl1kd+
         s2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7rGcqeaKO7k4itsNk5qHhnQB9CfMz1CeEei7jxa15c=;
        b=L5OijG0+brvO6eHzzRvPoq/zdy/eTmPPnF/LgUT+DcZ+918PcUlT254VNrLJ+NEir3
         iFh0WQjMiEL6l5t5P5QL6XUGt9XJsHRkkU8UPzjjlNc4kvPHGcPcGCLpx3nkjqF4BlVB
         GnHiVvA3uvLBAT02f7j/tLjsJJa6wj7bbMIV2Vq4Gt2APWjjI/H3deuQVFmDKla0oAnH
         3pGHoC1V9cu0p0w8e8F7n5dDKMTULKVkRP3yp6aYNQwNzwHSqOkcW2E6N/a4mqP0HaM2
         uVBxNs9/hJBMGvjNaFezYKvpb/K2LcLng0F+1awgep41U5J+HgSNPv8NMmcKBHJdV8x2
         ZZwQ==
X-Gm-Message-State: AOAM531QtPSvz/C2eLvgeMYCIqedE9niAyZq3HXHpaOPqyqVmYuinuJ5
        0TjP3bke7VuJRrxhGo89eu4=
X-Google-Smtp-Source: ABdhPJy2upr/MmRoCYuzhDs6LsS0n7B1rfn3tjkfkvdDtWR4Yw53st1TQCy/HckhwyUXfJ4aRlS2/A==
X-Received: by 2002:ac8:2fa9:: with SMTP id l38mr31189613qta.40.1595360168605;
        Tue, 21 Jul 2020 12:36:08 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j72sm3331351qke.20.2020.07.21.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:36:07 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 0/5] Introduce the Counter character device interface
Date:   Tue, 21 Jul 2020 15:35:46 -0400
Message-Id: <cover.1595358237.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v4:
 - Reimplement character device interface to report Counter events
 - Implement Counter timestamps
 - Implement poll() support
 - Convert microchip-tcb-capture.c to new driver interface
 - Add IRQ support for the 104-quad-8 Counter driver

Over the past couple years we have noticed some shortcomings with the
Counter sysfs interface. Although useful in the majority of situations,
there are certain use-cases where interacting through sysfs attributes
can become cumbersome and inefficient. A desire to support more advanced
functionality such as timestamps, multi-axes positioning tables, and
other such latency-sensitive applications, has motivated a reevaluation
of the Counter subsystem. I believe a character device interface will be
helpful for this more niche area of counter device use.

To quell any concerns from the offset: this patchset makes no changes to
the existing Counter sysfs userspace interface -- existing userspace
applications will continue to work with no modifications necessary. I
request that driver maintainers please test their applications to verify
that this is true, and report any discrepancies if they arise.

However, this patchset does contain a major reimplementation of the
Counter subsystem core and driver API. A reimplementation was necessary
in order to separate the sysfs code from the counter device drivers and
internalize it as a dedicated component of the core Counter subsystem
module. A minor benefit from all of this is that the sysfs interface is
now ensured a certain amount of consistency because the translation is
performed outside of individual counter device drivers.

Essentially, the reimplementation has enabled counter device drivers to
pass and handle data as native C datatypes now rather than the sysfs
strings from before. A high-level view of how a count value is passed
down from a counter device driver can be exemplified by the following:

                 ----------------------
                / Counter device       \
                +----------------------+
                | Count register: 0x28 |
                +----------------------+
                        |
                 -----------------
                / raw count data /
                -----------------
                        |
                        V
                +----------------------------+
                | Counter device driver      |----------+
                +----------------------------+          |
                | Processes data from device |   -------------------
                |----------------------------|  / driver callbacks /
                | Type: u64                  |  -------------------
                | Value: 42                  |          |
                +----------------------------+          |
                        |                               |
                 ----------                             |
                / u64     /                             |
                ----------                              |
                        |                               |
                        |                               V
                        |               +----------------------+
                        |               | Counter core         |
                        |               +----------------------+
                        |               | Routes device driver |
                        |               | callbacks to the     |
                        |               | userspace interfaces |
                        |               +----------------------+
                        |                       |
                        |                -------------------
                        |               / driver callbacks /
                        |               -------------------
                        |                       |
                +-------+---------------+       |
                |                       |       |
                |               +-------|-------+
                |               |       |
                V               |       V
        +--------------------+  |  +---------------------+
        | Counter sysfs      |<-+->| Counter chrdev      |
        +--------------------+     +---------------------+
        | Translates to the  |     | Translates to the   |
        | standard Counter   |     | standard Counter    |
        | sysfs output       |     | character device    |
        |--------------------|     |---------------------+
        | Type: const char * |     | Type: u64           |
        | Value: "42"        |     | Value: 42           |
        +--------------------+     +---------------------+
                |                               |
         ---------------                 -----------------------
        / const char * /                / struct counter_event /
        ---------------                 -----------------------
                |                               |
                |                               V
                |                       +-----------+
                |                       | read      |
                |                       +-----------+
                |                       \ Count: 42 /
                |                        -----------
                |
                V
        +--------------------------------------------------+
        | `/sys/bus/counter/devices/counterX/countY/count` |
        +--------------------------------------------------+
        \ Count: "42"                                      /
         --------------------------------------------------

Counter device data is exposed through standard character device read
operations. Device data is gathered when a Counter event is pushed by
the respective Counter device driver. Configuration is handled via ioctl
operations on the respective Counter character device node.

The following are some questions I have about this patchset:

1. Should I support multiple file descriptors for the character device
   in this introduction patchset?

   I intend to add support for multiple file descriptors to the Counter
   character device, but I restricted this patchset to a single file
   descriptor to simplify the code logic for the sake of review. If
   there is enough interest, I can add support for multiple file
   descriptors in the next revision; I anticipate that this should be
   simple to implement through the allocation of a kfifo for each file
   descriptor during the open callback.

2. Should struct counter_event have a union for different value types,
   or just a value u8 array?

   Currently I expose the event data value via a union containing the
   various possible Counter data types (value_u8 and value_u64). It is
   up to the user to select the right union member for the data they
   received. Would it make sense to return this data in a u8 array
   instead, with the expectation that the user will cast to the
   necessary data type?

3. How should errors be returned for Counter data reads performed by
   Counter events?

   Counter events are configured with a list of Counter data read
   operations to perform for the user. Any one of those data reads can
   return an error code, but not necessarily all of them. Currently, the
   code exits early when an error code is returned. Should the code
   instead continue on, saving the error code to the struct
   counter_event for userspace to handle?

William Breathitt Gray (5):
  counter: Internalize sysfs interface code
  docs: counter: Update to reflect sysfs internalization
  counter: Add character device interface
  docs: counter: Document character device interface
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   32 +
 Documentation/driver-api/generic-counter.rst  |  363 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    2 +-
 drivers/counter/104-quad-8.c                  |  753 +++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  441 +++++
 drivers/counter/counter-chrdev.h              |   16 +
 drivers/counter/counter-core.c                |  188 +++
 drivers/counter/counter-sysfs.c               |  849 ++++++++++
 drivers/counter/counter-sysfs.h               |   14 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   59 +-
 drivers/counter/microchip-tcb-capture.c       |  104 +-
 drivers/counter/stm32-lptimer-cnt.c           |  161 +-
 drivers/counter/stm32-timer-cnt.c             |  139 +-
 drivers/counter/ti-eqep.c                     |  211 +--
 include/linux/counter.h                       |  633 +++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |   90 +
 21 files changed, 2919 insertions(+), 2685 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h

-- 
2.27.0

