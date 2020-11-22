Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E1C2BC92C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 21:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgKVUaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 15:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgKVUaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 15:30:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C169C0613CF;
        Sun, 22 Nov 2020 12:30:18 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id h11so3163238qkl.4;
        Sun, 22 Nov 2020 12:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbGW1u1iXg2sjhUUqmB8fA+C9P7IMX/F0YirLSb6r04=;
        b=RTWsldFh41nwc2Wx74ic3DkdtRM3CQEO7wHmedoT6YI4+DPzysUHu57UFY5FGWTLJF
         wz7SZ0qzpY4zvzLL8B4HeZb8MstCoZaSh94BSgmmWd6khKwMPjZMMu2ceFqlLdV2pswY
         MD5F4R6Ae2fI4HBdkesvyxRowaE3e9MBvQUjcvRtKGnk+6DgbrmKhj5f5uWypuWdD00g
         zRlexYhiTUlbdgUi9Fsx0EuA6sPOy3JE0rhYEXESbsSqJUbhmSrIWutJHcSKpx4C646Q
         eLaAJLSiMxxyKIxaVS5E6iqHfFexqBH7uC2ZZEpfc+Cj1QVOgH1FwaUKVF/TrZXCfLJf
         eW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbGW1u1iXg2sjhUUqmB8fA+C9P7IMX/F0YirLSb6r04=;
        b=ae/nREcPdQu+ybgv2ccB5zj3CTy/DM14EiqoCJvV6MpKAYOFUy95bRscJKtUcAEbla
         JJSKm5jsJ8/zFj24couXMdVzlUM1hmMFEt+UvofAUPux7P1QP9e74g1aUYaJOpAlyddM
         +amCxJAU4LON/YsLbEkmBUgKvsaQOuura9Lx0OyldE1mUC1Q7IrOAuZKDdVQSZRzgOtT
         ciskYOnzUA9h62Sepr+mL/cB6KiGr38pdoDaKMtQvea187HS9S18wxrSXdTdcBhqrCe0
         7HP/sI445Imw3GFTkpHe1rUVP8SsWaHbXdDU/yCRpDNVypgQPd8n3driROgKG2yXK3EU
         Bk+g==
X-Gm-Message-State: AOAM532EfT4e2/67OLsf+SZWwQmDSn8AfgB0MVdu3qX1e5cnM2GM5IY5
        QpzfBW5zCpsqyrumkiaUIUI=
X-Google-Smtp-Source: ABdhPJx8TeR1hZ7K4qaplEYZbElGc3PHeJ1qIeSho/wsj4kjjQyKNDMCVPk/p1Niih2qJ40u1NEl2Q==
X-Received: by 2002:a37:7201:: with SMTP id n1mr25553424qkc.148.1606077017185;
        Sun, 22 Nov 2020 12:30:17 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p73sm7446522qka.79.2020.11.22.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 12:30:16 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 4/5] docs: counter: Document character device interface
Date:   Sun, 22 Nov 2020 15:29:55 -0500
Message-Id: <862173c8540e5e986315f8fa22c5c613ff8c20c0.1606075915.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606075915.git.vilhelm.gray@gmail.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds high-level documentation about the Counter subsystem
character device interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter   |   9 +
 Documentation/driver-api/generic-counter.rst  | 231 ++++++++++++++----
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 3 files changed, 200 insertions(+), 41 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 1820ce2f9183..c8abe7c03a82 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -99,6 +99,15 @@ Description:
 		Read-only attribute that indicates whether excessive noise is
 		present at the channel Y counter inputs.
 
+What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
+What:		/sys/bus/counter/devices/counterX/extensionZ_name
+What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the component name of
+		Extension Z.
+
 What:		/sys/bus/counter/devices/counterX/countY/function
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index b842ddbbd8a0..7c96d80f05e2 100644
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
 
@@ -387,16 +374,16 @@ userspace interface components::
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
@@ -427,23 +414,30 @@ driver and Counter userspace interface::
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
@@ -452,7 +446,7 @@ driver and Counter userspace interface::
         \ Count: "42"                                      /
          --------------------------------------------------
 
-There are three primary components involved:
+There are four primary components involved:
 
 Counter device driver
 ---------------------
@@ -472,3 +466,158 @@ and vice versa.
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
+        int counter_push_event(struct counter_device *const counter, const u8 event,
+                               const u8 channel);
+
+The event id is specified by the `event` parameter; the event channel id
+is specified by the `channel` parameter. When this function is called,
+the Counter data associated with the respective event is gathered, and a
+`struct counter_event` is generated for each datum and pushed to
+userspace.
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
+When `counter_push_event(counter, COUNTER_EVENT_INDEX, 1)` is called for
+example, it will go down the list for the `COUNTER_EVENT_INDEX` event
+channel 1 and execute the read callbacks for Signal 4, Signal 4
+Extension 0, and Count 4 -- the data returned for each is pushed to a
+kfifo as a `struct counter_event`, which userspace can retrieve via a
+standard read operation on the respective character device node.
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
+* COUNTER_ADD_WATCH_IOCTL:
+  Add a Counter watch for the specified event
+
+* COUNTER_LOAD_WATCHES_IOCTL:
+  Activates the Counter watches added earlier
+
+To configure events to gather Counter data, users first populate a
+`struct counter_watch` with the relevant event id, event channel id, and
+the information for the desired Counter component from which to read,
+and then pass it via the `COUNTER_ADD_WATCH_IOCTL` ioctl command.
+
+Note that an event can be watched without gathering Counter data by
+setting the `component.type` member equal to `COUNTER_COMPONENT_DUMMY`.
+This configures the component as a dummy: the Counter character device
+node will simply populate the event timestamps for those respective
+`struct counter_event` elements and ignore the component value.
+
+The `COUNTER_ADD_WATCH_IOCTL` command will buffer these Counter watches.
+When ready, the `COUNTER_LOAD_WATCHES_IOCTL` ioctl command may be used
+to activate these Counter watches.
+
+Userspace applications can then execute a `read` operation (optionally
+calling `poll` first) on the Counter character device node to retrieve
+`struct counter_event` elements with the desired data.
+
+For example, the following userspace code opens `/dev/counter0`,
+configures the `COUNTER_EVENT_INDEX` event channel 0 to gather Count 0
+and Count 1, and prints out the data as it becomes available on the
+character device node::
+
+        #include <fcntl.h>
+        #include <linux/counter.h>
+        #include <stdio.h>
+        #include <sys/ioctl.h>
+        #include <unistd.h>
+
+        struct counter_watch watches[2] = {
+                {
+                        .component.type = COUNTER_COMPONENT_COUNT,
+                        .component.scope = COUNTER_SCOPE_COUNT,
+                        .component.parent = 0,
+                        .event = COUNTER_EVENT_INDEX,
+                        .channel = 0,
+                },
+                {
+                        .component.type = COUNTER_COMPONENT_COUNT,
+                        .component.scope = COUNTER_SCOPE_COUNT,
+                        .component.parent = 1,
+                        .event = COUNTER_EVENT_INDEX,
+                        .channel = 0,
+                },
+        };
+
+        int main(void)
+        {
+                int fd;
+                struct counter_event event_data[2];
+
+                fd = open("/dev/counter0", O_RDWR);
+
+                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
+                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
+                ioctl(fd, COUNTER_LOAD_WATCHES_IOCTL);
+
+                for (;;) {
+                        read(fd, event_data, sizeof(event_data));
+
+                        printf("Count 0: %llu\nTimestamp 0: %llu\n"
+                               "Count 1: %llu\nTimestamp 1: %llu\n",
+                               (unsigned long long)event_data[0].value,
+                               (unsigned long long)event_data[0].timestamp,
+                               (unsigned long long)event_data[1].value,
+                               (unsigned long long)event_data[1].timestamp);
+                }
+
+                return 0;
+        }
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2a198838fca9..f6e96bb780cd 100644
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
2.29.2

