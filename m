Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4F1BE5E6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2SL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 14:11:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73EDC03C1AE;
        Wed, 29 Apr 2020 11:11:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so3022261qkg.1;
        Wed, 29 Apr 2020 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6ytqgDFNHsaOJjTUUUjsCdnofrnVPTea34tVhvLGag=;
        b=bUt0zzXrJQLxLVIZKOSGZaDef2zTVtHzKp2OFZL1X/gYdKIm90Aci8JdCzU+HrnhyV
         Vu9hRMumm5D4AnMwumFwuQlVhj5yiboiM1cc9eeBrHKQFCM2zFpss+E8s4iYLzjLPBB0
         2SwjgpMwPX7VG2WaJGzHUUDu7bplqk4VzO4GChrHIkL12/2IoUQQmSlaklBzRXIOT4es
         K3yC1ufxKbErto9d6S8XNfgHcZeD6CgJUzWDLwVPoENy0MlIGzAOuPlu4zzdHw9nZFRR
         h/fm0R3Ajic+K8g7D+JNxg98G5zysinkwWtVFhEHKjuoQGQ8jYQEKg2wvu+FqNgPRMFt
         aWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6ytqgDFNHsaOJjTUUUjsCdnofrnVPTea34tVhvLGag=;
        b=Z5SRfe+QqU1HdIsLp+YkRsLAmj7gNKe/XpjCaLDSOk2//PhkOEMO3t54NTkNNF+6Rb
         gZ4EsumWXb1w3wG4fIG9E7u1l56Nifbp1aHt9EBXiPj4xSUS++oB7BpYMLnTKl9rlytW
         jTLkILyJqr792Lk0EcsCjgMSwwvn+Yokm01vBv65Uk4uUbTnZEp4wlFO/0PaKfDDZOjT
         1yb8z8u794tlI7M0SWrbT3mvhTdBVt9MmL7O2T2KHBvzjceP5Yo3bKM9OR4WStpGNuLg
         nvhmg9TiwxCvdkSJ4KwE0x9yXTtI/n03j9v+qD2bGQMZxVqSNRNcnm2A5psO1ZRrzaG4
         XOrA==
X-Gm-Message-State: AGi0PuaF2PO8Ls/TPm4+frG0CTTjRTpmrvqlrXlGdhg3MbQH2JO3+Zk2
        OxFwSfe7Vm5pTbIRE43rDQ8=
X-Google-Smtp-Source: APiQypLffH5aM3hScXzjOmVleEGq/GKFIsQVNidjLjtLe6HlCO9EYM6OMrwbw2vdYhGIPLCAhnhKzQ==
X-Received: by 2002:a37:886:: with SMTP id 128mr32049757qki.325.1588183915008;
        Wed, 29 Apr 2020 11:11:55 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o43sm16315082qtf.46.2020.04.29.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:11:54 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        felipe.balbi@linux.intel.com, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/4] Introduce the Counter character device interface
Date:   Wed, 29 Apr 2020 14:11:34 -0400
Message-Id: <cover.1588176662.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Over the past couple years we have noticed some shortcomings with the
Counter sysfs interface. Although useful in the majority of situations,
there are certain use-cases where interacting through sysfs attributes
can become cumbersome and inefficient. A desire to support more advanced
functionality such as timestamps, multi-axis positioning tables, and
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
                | Type: unsigned long        |  -------------------
                | Value: 42                  |          |
                +----------------------------+          |
                        |                               |
                 ----------------                       |
                / unsigned long /                       |
                ----------------                        |
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
        | Type: const char * |     | Type: unsigned long |
        | Value: "42"        |     | Value: 42           |
        +--------------------+     +---------------------+
                |                               |
         ---------------                 ----------------
        / const char * /                / unsigned long /
        ---------------                 ----------------
                |                               |
                |                               V
                |                       +-----------+
                |                       | ioctl     |
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
ioctl commands are solidified. A userspace ABI is effectively immutable
so I want to make sure we get that right before working on an in-kernel
API that is more flexible to change. However, when we do develop an
in-kernel API, it will likely be housed as part of the Counter core
component, through which the userspace interfaces will then communicate.

Interaction with Counter character devices occurs via ioctl commands.
This allows userspace applications to access and set counter data using
native C datatypes rather than working through string translations.

Regarding the organization of this patchset, I have combined the counter
device driver changes with the first patch because the changes must all
be taken together in order to avoid compilation errors. I can see how
this can end up making it difficult to review so many changes at once,
so alternatively I can separate out the counter device driver changes
into their own dedicated patches -- with the understanding that the
patches must all be taken together.

In addition, I anticipate the Microchip TCB capture counter driver to
break with this patchset. I'm not sure how that driver will be picked
up yet so I have avoided adding it to this patchset right now. But the
changes to support that driver are simple to make so I can add them in a
later revision of this patchset.

The following are some questions I have about this patchset:

1. Should enums be used to represent standard counter component states
   (e.g. COUNTER_SIGNAL_LOW), or would these be better defined as int?

   These standard counter component states are defined in the
   counter-types.h file and serve as constants used by counter device
   drivers and Counter subsystem components in order to ensure a
   consistent interface.

   My concern is whether enum constants will cause problems when passed
   to userspace via the Counter character device ioctl calls. Along the
   same lines is whether the C bool datatype is safe to pass as well,
   given that it is a more modern C datatype.

2. Should device driver callbacks return int or long? I sometimes see
   error values returned as long (e.g. PTR_ERR(), the file_operations
   structure's ioctl callbacks, etc.); when is it necessary to return
   long as opposed to int?

3. I only implemented the unlocked_ioctl callback. Should I implement a
   compat_ioctl callback as well?

4. How much space should allot for name strings? Name strings hold the
   names of components (ideally as they appear on datasheets), so I've
   arbitrarily chosen a size of 32 for the character device interface.

5. Should the owning component of an extension be determined by the
   device driver or Counter subsystem?

   A lot of the complexity in the counters-function-types.h file and the
   sysfs-callbacks.c file is due to the function pointer casts required
   in order to support three different ownership scenarios: the owning
   component is the device, the owning component is a Count, the owning
   component is a Signal.

   Because the Counter subsystem doesn't not know which scenario is
   valid, it must manually check and provide for all three ownership
   cases. On the other hand, device drivers do know exactly which case
   applies because they are the ones providing the callbacks.

   The complexity in the Counter subsystem code can be eliminated if the
   owning component is simply passed down to the callbacks as a void
   pointer. The device drivers will then be responsible for casting to
   the appropriate component type, but this should in theory not be a
   problem since the device driver assigned the callback to the owning
   component in the first place.

William Breathitt Gray (4):
  counter: Internalize sysfs interface code
  docs: counter: Update to reflect sysfs internalization
  counter: Add character device interface
  docs: counter: Document character device interface

 Documentation/driver-api/generic-counter.rst  |  259 ++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +-
 drivers/counter/104-quad-8.c                  |  437 +++--
 drivers/counter/Makefile                      |    2 +
 drivers/counter/counter-chrdev.c              | 1134 +++++++++++++
 drivers/counter/counter-chrdev.h              |   16 +
 drivers/counter/counter-core.c                |  220 +++
 drivers/counter/counter-function-types.h      |   81 +
 drivers/counter/counter-strings.h             |   46 +
 drivers/counter/counter-sysfs-callbacks.c     |  566 +++++++
 drivers/counter/counter-sysfs-callbacks.h     |   28 +
 drivers/counter/counter-sysfs.c               |  524 ++++++
 drivers/counter/counter-sysfs.h               |   14 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   46 +-
 drivers/counter/stm32-lptimer-cnt.c           |  159 +-
 drivers/counter/stm32-timer-cnt.c             |  132 +-
 drivers/counter/ti-eqep.c                     |  170 +-
 include/linux/counter.h                       |  547 +++---
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter-types.h            |   67 +
 include/uapi/linux/counter.h                  |  313 ++++
 23 files changed, 3816 insertions(+), 2490 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-function-types.h
 create mode 100644 drivers/counter/counter-strings.h
 create mode 100644 drivers/counter/counter-sysfs-callbacks.c
 create mode 100644 drivers/counter/counter-sysfs-callbacks.h
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter-types.h
 create mode 100644 include/uapi/linux/counter.h


base-commit: 00edef1ac058b3c754d29bcfd35ea998d9e7a339
-- 
2.26.2

