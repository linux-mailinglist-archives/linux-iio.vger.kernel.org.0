Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EB228938
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgGUTgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbgGUTgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:36:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF050C061794;
        Tue, 21 Jul 2020 12:36:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ed14so9900715qvb.2;
        Tue, 21 Jul 2020 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTQTbShVF5f+c6wukNK1yKIzK7colO0Y48fVskJS4aE=;
        b=GUtowlPk3wJgdTQAJUt+BchNDRUG4rnXm/tlAG1ai+m26C4yvzi1h/zqN3S0UAkDBi
         Q1M7grYdML3d4TDrM2IpP7r2pF8LWFIMsoij2hUczGyBg1Sy3WDLEAT0XzQTUA9NToAa
         z6VGe0cnT7isqdZ1jWLPKzoqWqr07keyDMMTKhekMajceZucRUDUOrEgYhYG5k9Fy9dq
         YfDFw+01C2pg7XFsFsNZkYMAFWipbmU4j/IGa+NtZPtvzi2vr5c2XHtrbDAT1FHLFS9T
         5KzghTczdaAOtowshcYdfujxcPZ0So8tf1q2qwH+h9TqYqrnOew9gDKwrB7E0n0tm0v0
         CI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTQTbShVF5f+c6wukNK1yKIzK7colO0Y48fVskJS4aE=;
        b=t1wEs5dfaztx3JvVj52BY2BTvXsF1j1mDgtBtil7/5nEGWRXtW8TAJT7FlrPTpDIpI
         QDX+sMEp6/oqh4B0ukydxhO15SK1aAJq1m3uYpXsif2Wzi77mGNnTRcw5bSQoXG/i+g7
         x5hGClkFX9r5CtzzwZZTSszdyB4qPevWsADkwCybMD3DvIm9yv8pJr2SahMMXgNAPTXi
         H+dD1Yv2d1g1qveegLdYmWFgp1UbYP8qlUwUH9zriLcrtXRZ6nVzmTbGopbTQVogiZ+D
         pZqX8ll2RF0FmVweYpEBFqQO69IPCxYKHvjLv7KlIiiI2pPa/gaS8or3/qcsscFPrUJX
         TXEA==
X-Gm-Message-State: AOAM532+fJkRYw38PoTNrIFasJBBwxsvptaChb2JjjJ5vvM2dLU+ZqDv
        0M4DvPo1tbJprQo8AN7uSr4=
X-Google-Smtp-Source: ABdhPJxcaSBOI4D/8aW82KLKn9JCSjGjSsu8kPHk1DE1l/RNeaz84H0iZSUjbA309N/npHs4UTxcKQ==
X-Received: by 2002:ad4:4f4b:: with SMTP id eu11mr28692269qvb.142.1595360175095;
        Tue, 21 Jul 2020 12:36:15 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j72sm3331351qke.20.2020.07.21.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:36:14 -0700 (PDT)
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
Subject: [PATCH v4 4/5] docs: counter: Document character device interface
Date:   Tue, 21 Jul 2020 15:35:50 -0400
Message-Id: <b3d5b045a03fc8d5ab0b8ba97257a196a0b95c53.1595358237.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595358237.git.vilhelm.gray@gmail.com>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds high-level documentation about the Counter subsystem
character device interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst  | 191 +++++++++++++++---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 2 files changed, 160 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index fa2d699d44a5..a5f2e8dc430c 100644
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
 
@@ -399,25 +386,32 @@ driver is exemplified by the following::
                         |               / driver callbacks /
                         |               -------------------
                         |                       |
-                +-------+                       |
+                +-------+---------------+       |
+                |                       |       |
+                |               +-------|-------+
+                |               |       |
+                V               |       V
+        +--------------------+  |  +---------------------+
+        | Counter sysfs      |<-+->| Counter chrdev      |
+        +--------------------+     +---------------------+
+        | Translates to the  |     | Translates to the   |
+        | standard Counter   |     | standard Counter    |
+        | sysfs output       |     | character device    |
+        |--------------------|     |---------------------+
+        | Type: const char * |     | Type: u64           |
+        | Value: "42"        |     | Value: 42           |
+        +--------------------+     +---------------------+
                 |                               |
-                |               +---------------+
-                |               |
-                V               |
-        +--------------------+  |
-        | Counter sysfs      |<-+
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
@@ -426,7 +420,7 @@ driver is exemplified by the following::
         \ Count: "42"                                      /
          --------------------------------------------------
 
-There are three primary components involved:
+There are four primary components involved:
 
 Counter device driver
 ---------------------
@@ -446,3 +440,136 @@ and vice versa.
 Please refer to the `Documentation/ABI/testing/sysfs-bus-counter` file
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
+and reside under the `/sys/bus/counter/devices/counterX` directory,
+where `X` is to the respective counter device id. Please see
+`Documentation/ABI/testing/sysfs-bus-counter` for detailed information
+on each Generic Counter interface sysfs attribute.
+
+Through these sysfs attributes, programs and scripts may interact with
+the Generic Counter paradigm Counts, Signals, and Synapses of respective
+counter devices.
+
+Counter Character Device
+========================
+
+Counter character device nodes are created under the `/dev` directory as
+`counterX`, where `X` is the respective counter device id. Defines for
+the standard Counter data types are exposed via the userspace
+`include/uapi/linux/counter.h` file.
+
+Counter events
+--------------
+Counter device drivers can support Counter events by utilizing the
+`counter_push_event` function::
+
+        int counter_push_event(struct counter_device *const counter, const u8 event);
+
+The event id is specified by the `event` parameter. When this function
+is called, the Counter data associated with the respective event is
+gathered, and a `struct counter_event` is generated for each datum and
+pushed to userspace.
+
+Counter events can be configured by users to report various Counter
+data of interest. This can be conceptualized as a list of Counter
+component read calls to perform. For example::
+
+        +------------------------+------------------------+
+        | Event 0                | Event 1                |
+        +------------------------+------------------------+
+        | * Count 0              | * Signal 0             |
+        | * Count 1              | * Signal 0 Extension 0 |
+        | * Signal 3             | * Extension 4          |
+        | * Count 4 Extension 2  |                        |
+        | * Signal 5 Extension 0 |                        |
+        +------------------------+------------------------+
+
+When `counter_push_event(counter, 1)` is called for example, it will go
+down the list for Event 1 and execute the read callbacks for Signal 0,
+Signal 0 Extension 0, and Extension 4 -- the data returned for each is
+pushed to a kfifo as a `struct counter_event`, which userspace can
+retrieve via a standard read operation on the respective character
+device node.
+
+Userspace
+---------
+Userspace applications can configure Counter events via ioctl operations
+on the Counter character device node. There following ioctl codes are
+supported and provided by the `linux/counter.h` userspace header file:
+
+* COUNTER_CLEAR_WATCHES_IOCTL:
+  Clear all Counter watches from all events
+
+* COUNTER_SET_WATCH_IOCTL:
+  Set a Counter watch on the specified event
+
+To configure events to gather Counter data, users first populate a
+`struct counter_watch` with the relevant event id and the information
+for the desired Counter component from which to read, and then pass it
+via the `COUNTER_SET_WATCH_IOCTL` ioctl command.
+
+Userspace applications can then execute a `read` operation (optionally
+calling `poll` first) on the Counter character device node to retrieve
+`struct counter_event` elements with the desired data.
+
+For example, the following userspace code opens `/dev/counter0`,
+configures Event 0 to gather Count 0 and Count 1, and prints out the
+data as it becomes available on the character device node::
+
+        #include <fcntl.h>
+        #include <linux/counter.h>
+        #include <poll.h>
+        #include <stdio.h>
+        #include <sys/ioctl.h>
+        #include <unistd.h>
+
+        struct counter_watch watches[2] = {
+                {
+                        .event = 0,
+                        .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
+                        .component.owner_id = 0,
+                        .component.type = COUNTER_COMPONENT_TYPE_COUNT,
+                },
+                {
+                        .event = 0,
+                        .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
+                        .component.owner_id = 1,
+                        .component.type = COUNTER_COMPONENT_TYPE_COUNT,
+                },
+        };
+
+        int main(void)
+        {
+                struct pollfd pfd = { .events = POLLIN };
+                struct counter_event event_data[2];
+
+                pfd.fd = open("/dev/counter0", O_RDWR);
+
+                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
+                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
+
+                for (;;) {
+                        poll(&pfd, 1, -1);
+
+                        read(pfd.fd, event_data, sizeof(event_data));
+
+                        printf("Timestamp 0: %llu\nCount 0: %llu\n"
+                               "Timestamp 1: %llu\nCount 1: %llu\n",
+                               (unsigned long long)event_data[0].timestamp,
+                               (unsigned long long)event_data[0].value_u64,
+                               (unsigned long long)event_data[1].timestamp,
+                               (unsigned long long)event_data[1].value_u64);
+                }
+
+                return 0;
+        }
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 59472cd6a11d..63ff377561fd 100644
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
2.27.0

