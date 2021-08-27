Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1396D3F9337
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbhH0Dt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbhH0Dtq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57BC0613CF;
        Thu, 26 Aug 2021 20:48:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t42so4527841pfg.12;
        Thu, 26 Aug 2021 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpsbHrq2IaXLOLPN5z/eGq8r1/pQ9t90OrcWsC5v6A0=;
        b=Lbvpjnhs170lvn4VWQtsseHtZHJCWSX/R/2exSiAI//WSqiwiJmeoqDCBsA1hhCiEd
         1872DkqY6XyX8TYX/YStSfKR2xDr6ibeD90Mn2DFnhDj67qEnJGDtrh4GcpyhdbITvP+
         y0ZNHUEGsfYhhVEM1qGfrqJg8wbjSd/sosf4opELmziWOc65Are7iZfckuecoOirq4/l
         yUfFbMUhwL6UkL7GswEi4yMegelgSNK71OWk6i00wZMVzLykXGRzq9D9hmatT5uxoMQW
         FF47TNuYXQrfFC5LpJ0baxRzDsmzMBtK8LSMaz2D+7D61fEHjLAwEZENgTL4/qFYuSHi
         JDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpsbHrq2IaXLOLPN5z/eGq8r1/pQ9t90OrcWsC5v6A0=;
        b=XblD5a1WBIdAHeDsxfRUgDJOWNlz0E3JR1n8w+/AFD2SBSJ5LPwIPas8nCOGMAoMul
         SPfjXXtU/w2cdjov3hd1pq09+/9nJKrK/zVwcn6R4abaxdCZT4dwpGLKrq6KmLKC4XQC
         577/xyckn1lPyM3rSI2s25RRrrAMU2YrQJ1NhIVBEAKUCnbe+A7e/3hfki2D7Rmiq0Ht
         t77BJUxdrc9al29C+m7x9AyGGThg7fiLDgFgfS32XENz5WjuxtEc7Gt0o16uoOM5qhuu
         R3rocjlKEAl990GlC5t4D34QWhB+rOXlZqIlKKRYVjXQc8Lmb3tfPLtrqRsZjiYQMsT/
         WULw==
X-Gm-Message-State: AOAM530fMdjr6LCWT1zxcXQEuw266/JZmA/QufHu25957Ck4x5pAyhao
        zxKW3A1MfBTNj1cpe67eBj4=
X-Google-Smtp-Source: ABdhPJw4n7caducoo43Z+MWKtp3+KNRkCZpxPexpT+iSBWSx8ZCadaIvlxYFHgaBUC7P1aX10lL8fA==
X-Received: by 2002:a05:6a00:168a:b0:3e2:789e:5fd0 with SMTP id k10-20020a056a00168a00b003e2789e5fd0mr6917844pfc.68.1630036136321;
        Thu, 26 Aug 2021 20:48:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:55 -0700 (PDT)
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
Subject: [PATCH v16 08/14] docs: counter: Document character device interface
Date:   Fri, 27 Aug 2021 12:47:52 +0900
Message-Id: <532bd59e88d9bc6e4d1c323744b78ce137ff5c6a.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds high-level documentation about the Counter subsystem
character device interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst  | 177 ++++++++++++++----
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 2 files changed, 137 insertions(+), 41 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index f6397218aa4c..6ecb5d1942c7 100644
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
@@ -473,3 +467,104 @@ and vice versa.
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
+component read calls to perform. For example:
+
+        +------------------------+------------------------+
+        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
+        +========================+========================+
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
+Extension 0, and Count 7 -- the data returned for each is pushed to a
+kfifo as a ``struct counter_event``, which userspace can retrieve via a
+standard read operation on the respective character device node.
+
+Userspace
+---------
+Userspace applications can configure Counter events via ioctl operations
+on the Counter character device node. There following ioctl codes are
+supported and provided by the ``linux/counter.h`` userspace header file:
+
+* :c:macro:`COUNTER_ADD_WATCH_IOCTL`
+
+* :c:macro:`COUNTER_ENABLE_EVENTS_IOCTL`
+
+* :c:macro:`COUNTER_DISABLE_EVENTS_IOCTL`
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
index 1409e40e6345..fc4ccc79b1b8 100644
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

