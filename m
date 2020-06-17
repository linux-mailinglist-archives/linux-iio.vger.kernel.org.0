Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB761FC3A3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 03:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgFQBkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jun 2020 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgFQBkh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2020 21:40:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DF5C061573;
        Tue, 16 Jun 2020 18:40:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d82so579485qkc.10;
        Tue, 16 Jun 2020 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmUuAYdq3VSDmDEV+vJqIoAD1bN1Pfe0CFNGJ2Z92oo=;
        b=HWGSiETopD/8uT/vgDnO1Txg4Pp5nB6BJMg6gAMCIytMHnLMPYx9X5GgorKkY7+EYj
         2eExjiU5LPG11i5hxF+RFhIe6NezkmENcrB/siZPzF9/sCzIK2AyyJu6B/r3hIjFnWDp
         VnFHCuFKpxp4FSeVN0xf6fHSAVcM6L4BrjwlOjwKmErHUjdRYs07Z/VsNt4YSH6kxWB8
         Vjqz+wi7a/O5HgnpSh1MVK21BNNPOJVmK8AnxupiVzcMswsdie96UcBo92hIdVCuFxMJ
         /+s0WcX2ZCIX8htssXw8VFsr7Y+3hr/WYW1GASqZTd4+Rlwr694ua+/yFFVPR1hCKbWw
         /0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmUuAYdq3VSDmDEV+vJqIoAD1bN1Pfe0CFNGJ2Z92oo=;
        b=ql1r0/0ghl0SGbyt5z43jWecA5cTGcArtKFm4rGaxGpSUqv4KQExy2edG54RaFTna6
         n5ndBJzcBPBDCi0yum6crd1gIBjav9jVC6WBCmx6RNj3QSK+7sLFEHOs7vhrefGmq4U3
         iuUK/650GqjfOBsLjfu9/UZzGiYpjBnXTzC6XHoL0Nz2aptEkgnJ+HXBCqe3M6YM9AGL
         WFFz+K3COd7lno/GRFxriFY9BjTc2a0xz0Qu2iwW4EiUWWEozXWIlo3UoVxwpCLG3VI3
         sdJdddFiULYZmvHOMWzJAGLi8HsfDXotGtn50G7fcWwu6wBH6XqcJDFjFTB9QtN6fd8s
         T1uQ==
X-Gm-Message-State: AOAM532Gdu3Nx1aTlt2HZtAzBMrVJckdVSKiKyZ7XoAbebdpn4ikECJI
        y+HwOsfLV53nSchrkMP6TF0=
X-Google-Smtp-Source: ABdhPJwIasLV+HgrGfsdPlWIktHCipTx9jA7XP9YqH4HFXHuTL2RhhgRP7gpJ2zoSD+VVGUwiYLt1g==
X-Received: by 2002:a37:a292:: with SMTP id l140mr23257952qke.171.1592358035895;
        Tue, 16 Jun 2020 18:40:35 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a14sm1917014qkn.16.2020.06.16.18.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:40:34 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Introduce the Counter character device interface
Date:   Tue, 16 Jun 2020 21:39:58 -0400
Message-Id: <cover.1592341702.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v3:
 - Remove string data type; there is no need to handle strings via the
   chrdev interface
 - Reimplement COUNTER_DATA_TYPE_ENUM using struct counter_available
 - Refactor Count and Signal sysfs number as index offset rather than id
   value; this should make the naming and paths more consistent
 - Implement chrdev_format sysfs attribute; data format of chrdev is
   configured via sysfs in order to keep data and configuration separate

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
         ---------------                 ----------
        / const char * /                / u64     /
        ---------------                 ----------
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

I am aware that an in-kernel API can simplify the data transfer between
counter device drivers and the userspace interfaces, but I want to
postpone that development until after the new Counter character device
interface is solidified. A userspace ABI is effectively immutable so I
want to make sure we get that right before working on an in-kernel API
that is more flexible to change. However, when we do develop an
in-kernel API, it will likely be housed as part of the Counter core
component, through which the userspace interfaces will then communicate.

Interaction with Counter character devices occurs via standard character
device read/write operations. This allows userspace applications to
access and set counter data using native C datatypes rather than working
through string translations.

The following are some questions I have about this patchset:

1. Should the data format of the character device be configured via a
   sysfs attribute, ioctl, or something else?

   I believe it's good to have the configuration of the data format
   separate from the actual data, but I'm not sure if that configuration
   should be exposed via sysfs or some other interface. What interface
   would be most fitting for such configuration?

2. Should the format of the chrdev_format attribute be more friendly for
   a human user?

   I implemented a minimalistic syntax for the sake of simplifying the
   parsing code, but we could increase the verbosity a bit to make it
   easier for humans to understand the format of the chrdev_format
   attribute.

   For example, "C0 C0E3 S1 C1E2" could instead be "Count 0, Count 0
   Ceiling, Signal 1, Count 1 Floor"; because extension names are
   required to be unique, it possible to refer to the extensions
   directly by their names (i.e. "ceiling" and "floor") rather than
   their index offset. The downside to this is of course the need for a
   more complex parser.

3. How should alignment of the character device data be handled?

   We might not need to handle this just yet, but I can envision
   situations where it would be nice for user to specify the alignment
   of the data in order to match the packing of a structure in a
   userspace application. How we specify the alignment will naturally
   depend on the syntax we decide for the chrdev_format attribute. I can
   see a "padding" option as a possible solution, but it'll be nice to
   get some feedback if there are any other ideas.

William Breathitt Gray (4):
  counter: Internalize sysfs interface code
  docs: counter: Update to reflect sysfs internalization
  counter: Add character device interface
  docs: counter: Document character device interface

 Documentation/ABI/testing/sysfs-bus-counter  |   31 +
 Documentation/driver-api/generic-counter.rst |  280 +++-
 MAINTAINERS                                  |    3 +-
 drivers/counter/104-quad-8.c                 |  474 +++---
 drivers/counter/Makefile                     |    1 +
 drivers/counter/counter-chrdev.c             |  612 +++++++
 drivers/counter/counter-chrdev.h             |   23 +
 drivers/counter/counter-common.h             |   15 +
 drivers/counter/counter-core.c               |  187 +++
 drivers/counter/counter-sysfs.c              |  881 +++++++++++
 drivers/counter/counter-sysfs.h              |   14 +
 drivers/counter/counter.c                    | 1496 ------------------
 drivers/counter/ftm-quaddec.c                |   59 +-
 drivers/counter/stm32-lptimer-cnt.c          |  161 +-
 drivers/counter/stm32-timer-cnt.c            |  139 +-
 drivers/counter/ti-eqep.c                    |  211 +--
 include/linux/counter.h                      |  628 ++++----
 include/linux/counter_enum.h                 |   45 -
 include/uapi/linux/counter-types.h           |   34 +
 19 files changed, 2748 insertions(+), 2546 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-common.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter-types.h

-- 
2.26.2

