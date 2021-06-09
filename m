Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD33A0964
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhFIBga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbhFIBgU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE42C061787;
        Tue,  8 Jun 2021 18:34:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o9so15227233pgd.2;
        Tue, 08 Jun 2021 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmCGQEco/c2Qxge73VA7yqOK4Qy2QVkfMpvqHDa9hK4=;
        b=RZJHCieNB+rtHSElvIbUAHqVfBgsfHkIuVYh/4UMjyzVrc5b/HISBUwuDcgByepEqM
         YHOzSkF4RHjMfiqBipQ3g1dDzgq1N3jotWTQb6coUH2Qye+dVT0B0v3FpjrJvqH9QYbP
         Zk9v99+Hww6AZ3c940QD/Z37Q2jKY52ugwmnvStzD+tbBUMF0eAUaepXxXU3/kX7OQu9
         lN5Ckmw9EsMxgytHx0cgUgekR9rIx7MzvJdLz2JsMVmD4mvnpInZwqlUVBTxbZ9sGTO2
         pd8yRcoNFN4SoWx0303drtmt63tMwlK8XbGAFKty3rIelHUPG3MhDlU+l+ZZWYDHk/lz
         h6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmCGQEco/c2Qxge73VA7yqOK4Qy2QVkfMpvqHDa9hK4=;
        b=N9H66Nlqu3MNaLI7DOWaLzKcBSOwLBijgi1nnSEntsB3/407k+bF+597+a42nPa0h4
         DqvtsRqLjxs0S/VDDI7I07sRHz2rqSVsn/o9k0s4/EHAkiltbQKHUAUN8HiD51/OsoZR
         5yKZlo10ZlGbLH+7/SkCDeXoCbcFfPh0ZVXnvrlFkUHwKvvsl/7X07klPdvWcbR5bx/s
         BozzTufb86Op7tK1wQD0eFEQy3W7kaZm1cmpPZEWkmoOu/28GTYrIeISn1Z/pv5fxad3
         31EFb7mZqF0W9aYvV3jChfrLKkuvqcHowSEIh2xpOW9AdwgmkjYnW+grBDnOtZ50o6Y0
         IP3g==
X-Gm-Message-State: AOAM533MHH2mqfDaTPPUyvUmw8d7Eb2E4gbMeg/ZSLwKrvycFJIKCbNU
        CkgjyLVJ0s8tOyVH2vSousw=
X-Google-Smtp-Source: ABdhPJw+MtYCLUDXkgU4ZLv2WQCA+UvtfOHpxg51q0wrhhiVYN3D6ByvnIMH+PHtte6vVwhjgaq2nA==
X-Received: by 2002:a62:1b41:0:b029:2f1:f8bd:398d with SMTP id b62-20020a621b410000b02902f1f8bd398dmr2654257pfb.39.1623202450294;
        Tue, 08 Jun 2021 18:34:10 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:34:09 -0700 (PDT)
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
Subject: [PATCH v11 27/33] docs: counter: Document character device interface
Date:   Wed,  9 Jun 2021 10:31:30 +0900
Message-Id: <d20ae20a44e7cffdb4910e93ecbae79918e72174.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds high-level documentation about the Counter subsystem
character device interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst  | 185 ++++++++++++++----
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 2 files changed, 145 insertions(+), 41 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index f6397218aa4c..62a702e7f994 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -223,19 +223,6 @@ whether an input line is differential or single-ended) and instead focus
 on the core idea of what the data and process represent (e.g. position
 as interpreted from quadrature encoding data).
 
-Userspace Interface
-===================
-
-Several sysfs attributes are generated by the Generic Counter interface,
-and reside under the /sys/bus/counter/devices/counterX directory, where
-counterX refers to the respective counter device. Please see
-Documentation/ABI/testing/sysfs-bus-counter for detailed
-information on each Generic Counter interface sysfs attribute.
-
-Through these sysfs attributes, programs and scripts may interact with
-the Generic Counter paradigm Counts, Signals, and Synapses of respective
-counter devices.
-
 Driver API
 ==========
 
@@ -388,16 +375,16 @@ userspace interface components::
                         / driver callbacks /
                         -------------------
                                 |
-                +---------------+
-                |
-                V
-        +--------------------+
-        | Counter sysfs      |
-        +--------------------+
-        | Translates to the  |
-        | standard Counter   |
-        | sysfs output       |
-        +--------------------+
+                +---------------+---------------+
+                |                               |
+                V                               V
+        +--------------------+          +---------------------+
+        | Counter sysfs      |          | Counter chrdev      |
+        +--------------------+          +---------------------+
+        | Translates to the  |          | Translates to the   |
+        | standard Counter   |          | standard Counter    |
+        | sysfs output       |          | character device    |
+        +--------------------+          +---------------------+
 
 Thereafter, data can be transferred directly between the Counter device
 driver and Counter userspace interface::
@@ -428,23 +415,30 @@ driver and Counter userspace interface::
                         / u64     /
                         ----------
                                 |
-                +---------------+
-                |
-                V
-        +--------------------+
-        | Counter sysfs      |
-        +--------------------+
-        | Translates to the  |
-        | standard Counter   |
-        | sysfs output       |
-        |--------------------|
-        | Type: const char * |
-        | Value: "42"        |
-        +--------------------+
-                |
-         ---------------
-        / const char * /
-        ---------------
+                +---------------+---------------+
+                |                               |
+                V                               V
+        +--------------------+          +---------------------+
+        | Counter sysfs      |          | Counter chrdev      |
+        +--------------------+          +---------------------+
+        | Translates to the  |          | Translates to the   |
+        | standard Counter   |          | standard Counter    |
+        | sysfs output       |          | character device    |
+        |--------------------|          |---------------------|
+        | Type: const char * |          | Type: u64           |
+        | Value: "42"        |          | Value: 42           |
+        +--------------------+          +---------------------+
+                |                               |
+         ---------------                 -----------------------
+        / const char * /                / struct counter_event /
+        ---------------                 -----------------------
+                |                               |
+                |                               V
+                |                       +-----------+
+                |                       | read      |
+                |                       +-----------+
+                |                       \ Count: 42 /
+                |                        -----------
                 |
                 V
         +--------------------------------------------------+
@@ -453,7 +447,7 @@ driver and Counter userspace interface::
         \ Count: "42"                                      /
          --------------------------------------------------
 
-There are three primary components involved:
+There are four primary components involved:
 
 Counter device driver
 ---------------------
@@ -473,3 +467,112 @@ and vice versa.
 Please refer to the ``Documentation/ABI/testing/sysfs-bus-counter`` file
 for a detailed breakdown of the available Generic Counter interface
 sysfs attributes.
+
+Counter chrdev
+--------------
+Translates counter data to the standard Counter character device; data
+is transferred via standard character device read calls, while Counter
+events are configured via ioctl calls.
+
+Sysfs Interface
+===============
+
+Several sysfs attributes are generated by the Generic Counter interface,
+and reside under the ``/sys/bus/counter/devices/counterX`` directory,
+where ``X`` is to the respective counter device id. Please see
+``Documentation/ABI/testing/sysfs-bus-counter`` for detailed information
+on each Generic Counter interface sysfs attribute.
+
+Through these sysfs attributes, programs and scripts may interact with
+the Generic Counter paradigm Counts, Signals, and Synapses of respective
+counter devices.
+
+Counter Character Device
+========================
+
+Counter character device nodes are created under the ``/dev`` directory
+as ``counterX``, where ``X`` is the respective counter device id.
+Defines for the standard Counter data types are exposed via the
+userspace ``include/uapi/linux/counter.h`` file.
+
+Counter events
+--------------
+Counter device drivers can support Counter events by utilizing the
+``counter_push_event`` function::
+
+        void counter_push_event(struct counter_device *const counter, const u8 event,
+                                const u8 channel);
+
+The event id is specified by the ``event`` parameter; the event channel
+id is specified by the ``channel`` parameter. When this function is
+called, the Counter data associated with the respective event is
+gathered, and a ``struct counter_event`` is generated for each datum and
+pushed to userspace.
+
+Counter events can be configured by users to report various Counter
+data of interest. This can be conceptualized as a list of Counter
+component read calls to perform. For example::
+
+        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
+        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
+        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
+        | Channel 0              | Channel 0              |
+        +------------------------+------------------------+
+        | * Count 0              | * Signal 0             |
+        | * Count 1              | * Signal 0 Extension 0 |
+        | * Signal 3             | * Extension 4          |
+        | * Count 4 Extension 2  +------------------------+
+        | * Signal 5 Extension 0 | Channel 1              |
+        |                        +------------------------+
+        |                        | * Signal 4             |
+        |                        | * Signal 4 Extension 0 |
+        |                        | * Count 7              |
+        +------------------------+------------------------+
+
+When ``counter_push_event(counter, COUNTER_EVENT_INDEX, 1)`` is called
+for example, it will go down the list for the ``COUNTER_EVENT_INDEX``
+event channel 1 and execute the read callbacks for Signal 4, Signal 4
+Extension 0, and Count 4 -- the data returned for each is pushed to a
+kfifo as a ``struct counter_event``, which userspace can retrieve via a
+standard read operation on the respective character device node.
+
+Userspace
+---------
+Userspace applications can configure Counter events via ioctl operations
+on the Counter character device node. There following ioctl codes are
+supported and provided by the ``linux/counter.h`` userspace header file:
+
+* COUNTER_ADD_WATCH_IOCTL:
+  Queues a Counter watch for the specified event. The queued watches
+  will not be applied until ``COUNTER_ENABLE_EVENTS_IOCTL`` is called.
+
+* COUNTER_ENABLE_EVENTS_IOCTL:
+  Enables monitoring the events specified by the Counter watches that
+  were queued by ``COUNTER_ADD_WATCH_IOCTL``. If events are already
+  enabled, the new set of watches replaces the old one. Calling this
+  ioctl also has the effect of clearing the queue of watches added by
+  ``COUNTER_ADD_WATCH_IOCTL``.
+
+* COUNTER_DISABLE_EVENTS_IOCTL:
+  Stops monitoring the previously enabled events.
+
+To configure events to gather Counter data, users first populate a
+``struct counter_watch`` with the relevant event id, event channel id,
+and the information for the desired Counter component from which to
+read, and then pass it via the ``COUNTER_ADD_WATCH_IOCTL`` ioctl
+command.
+
+Note that an event can be watched without gathering Counter data by
+setting the ``component.type`` member equal to
+``COUNTER_COMPONENT_NONE``. With this configuration the Counter
+character device will simply populate the event timestamps for those
+respective ``struct counter_event`` elements and ignore the component
+value.
+
+The ``COUNTER_ADD_WATCH_IOCTL`` command will buffer these Counter
+watches. When ready, the ``COUNTER_ENABLE_EVENTS_IOCTL`` ioctl command
+may be used to activate these Counter watches.
+
+Userspace applications can then execute a ``read`` operation (optionally
+calling ``poll`` first) on the Counter character device node to retrieve
+``struct counter_event`` elements with the desired data.
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9bfc2b510c64..cad12ae3f945 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -88,6 +88,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <http://infiniband.sourceforge.net/>
 0x20  all    drivers/cdrom/cm206.h
 0x22  all    scsi/sg.h
+0x3E  00-0F  linux/counter.h                                         <mailto:linux-iio@vger.kernel.org>
 '!'   00-1F  uapi/linux/seccomp.h
 '#'   00-3F                                                          IEEE 1394 Subsystem
                                                                      Block for the entire subsystem
-- 
2.32.0

