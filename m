Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4893DED78
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhHCMHn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhHCMHj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:07:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF52C0613D5;
        Tue,  3 Aug 2021 05:07:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q2so23419793plr.11;
        Tue, 03 Aug 2021 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yShcpBwbYzy9vQiBArawadCUsDx/Zmukxf6CA6ZVbQQ=;
        b=mpoQ4NII7OL2gokwIT5jmBcp6cMSYtymAu4WJN3Xj2n4jBchtZmLoXSjaRug9247Aq
         xF8p/03wEwxG+D2sJUKjVyQwav/XWYxH+l1XBa8dKfhsVOI8JCMhnBjJIriSaaAV76e7
         OPDj1Dbvi52wN2fUzEs32qP6WMW7twMLuNoIOLGVpNlD42rNWRhvEeBTNXf0YrpUg2XC
         sOhW+KQoyn2t+iWzsHYwi3EpfSU0LPAyuPXuXG406eaztkAd79MNR1YpSz0GzIkbTInD
         i8BXhsqWJVUpMU+U3B/Xi/mWIRwuPIxKLv9FLFupw+UZMTVNlra/7/ktFsrhSU7f+0F3
         wWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yShcpBwbYzy9vQiBArawadCUsDx/Zmukxf6CA6ZVbQQ=;
        b=rq2Ps5ExVJiXc8FdjeAk7p3r0d1XkcdKHF3E0Q1vsjEiXTk49f7qPQdJfu6j7q7F7L
         MjFxo3TAIJZ/mmQXpOe2lwafiiyZkXBATYVeUnm6JoKh8hfCTZfwyQv0cZ9/WTgkAgMg
         JL7HOCntjPiptJFv38u6vITst+LL1CnKHQfU10RqRaJyAmSI4xpKLjHDOONnPqGWwZgW
         ICg0gkw9mDnAQMcyl6DhoZdEqsh3P1UH+hV7CtJD8cYrSwKHnJcDiY5B0GQPOpzg0ki8
         5IM7gzCw9SEWRsl+mZkoinHCtGFNEVTHR/JuUzVta6jegFIpEWKD8cM7+yardyl2jHaK
         OGTw==
X-Gm-Message-State: AOAM530qQcl6OzRt5D6alT3e+T4MBfMQKlHCJAo2pKeG9hLQnlJJ9r6m
        7Mt54MMXmp937psmkIMtqPY=
X-Google-Smtp-Source: ABdhPJz1x7F2ssg9hoiC1rDCvWdwBvOhv6XtEi8BsrxUXPnCvU2AP2kq+/3enMTqiNFRDLkqMJku9Q==
X-Received: by 2002:a62:a117:0:b029:394:dddf:6b00 with SMTP id b23-20020a62a1170000b0290394dddf6b00mr21834519pff.50.1627992446758;
        Tue, 03 Aug 2021 05:07:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:07:26 -0700 (PDT)
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
Subject: [PATCH v14 08/17] docs: counter: Update to reflect sysfs internalization
Date:   Tue,  3 Aug 2021 21:06:18 +0900
Message-Id: <bc652529b7d225e03d1ea457d64c6f6f8b1efd04.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Counter subsystem architecture and driver implementations have
changed in order to handle Counter sysfs interactions in a more
consistent way. This patch updates the Generic Counter interface
documentation to reflect the changes.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter  |   9 +-
 Documentation/driver-api/generic-counter.rst | 243 ++++++++++++++-----
 2 files changed, 185 insertions(+), 67 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 20fe5afd4f9e..dee79b606847 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -286,7 +286,14 @@ What:		/sys/bus/counter/devices/counterX/signalY/signal
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Signal data of Signal Y represented as a string.
+		Signal level state of Signal Y. The following signal level
+		states are available:
+
+		low:
+			Low level state.
+
+		high:
+			High level state.
 
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
 KernelVersion:	5.2
diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 64fe7db080e5..f6397218aa4c 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -250,8 +250,8 @@ for defining a counter device.
 .. kernel-doc:: drivers/counter/counter.c
    :export:
 
-Implementation
-==============
+Driver Implementation
+=====================
 
 To support a counter device, a driver must first allocate the available
 Counter Signals via counter_signal structures. These Signals should
@@ -267,25 +267,61 @@ respective counter_count structure. These counter_count structures are
 set to the counts array member of an allocated counter_device structure
 before the Counter is registered to the system.
 
-Driver callbacks should be provided to the counter_device structure via
-a constant counter_ops structure in order to communicate with the
-device: to read and write various Signals and Counts, and to set and get
-the "action mode" and "function mode" for various Synapses and Counts
-respectively.
+Driver callbacks must be provided to the counter_device structure in
+order to communicate with the device: to read and write various Signals
+and Counts, and to set and get the "action mode" and "function mode" for
+various Synapses and Counts respectively.
 
 A defined counter_device structure may be registered to the system by
 passing it to the counter_register function, and unregistered by passing
 it to the counter_unregister function. Similarly, the
-devm_counter_register and devm_counter_unregister functions may be used
-if device memory-managed registration is desired.
-
-Extension sysfs attributes can be created for auxiliary functionality
-and data by passing in defined counter_device_ext, counter_count_ext,
-and counter_signal_ext structures. In these cases, the
-counter_device_ext structure is used for global/miscellaneous exposure
-and configuration of the respective Counter device, while the
-counter_count_ext and counter_signal_ext structures allow for auxiliary
-exposure and configuration of a specific Count or Signal respectively.
+devm_counter_register function may be used if device memory-managed
+registration is desired.
+
+The struct counter_comp structure is used to define counter extensions
+for Signals, Synapses, and Counts.
+
+The "type" member specifies the type of high-level data (e.g. BOOL,
+COUNT_DIRECTION, etc.) handled by this extension. The "``*_read``" and
+"``*_write``" members can then be set by the counter device driver with
+callbacks to handle that data using native C data types (i.e. u8, u64,
+etc.).
+
+Convenience macros such as ``COUNTER_COMP_COUNT_U64`` are provided for
+use by driver authors. In particular, driver authors are expected to use
+the provided macros for standard Counter subsystem attributes in order
+to maintain a consistent interface for userspace. For example, a counter
+device driver may define several standard attributes like so::
+
+        struct counter_comp count_ext[] = {
+                COUNTER_COMP_DIRECTION(count_direction_read),
+                COUNTER_COMP_ENABLE(count_enable_read, count_enable_write),
+                COUNTER_COMP_CEILING(count_ceiling_read, count_ceiling_write),
+        };
+
+This makes it simple to see, add, and modify the attributes that are
+supported by this driver ("direction", "enable", and "ceiling") and to
+maintain this code without getting lost in a web of struct braces.
+
+Callbacks must match the function type expected for the respective
+component or extension. These function types are defined in the struct
+counter_comp structure as the "``*_read``" and "``*_write``" union
+members.
+
+The corresponding callback prototypes for the extensions mentioned in
+the previous example above would be::
+
+        int count_direction_read(struct counter_device *counter,
+                                 struct counter_count *count,
+                                 enum counter_count_direction *direction);
+        int count_enable_read(struct counter_device *counter,
+                              struct counter_count *count, u8 *enable);
+        int count_enable_write(struct counter_device *counter,
+                               struct counter_count *count, u8 enable);
+        int count_ceiling_read(struct counter_device *counter,
+                               struct counter_count *count, u64 *ceiling);
+        int count_ceiling_write(struct counter_device *counter,
+                                struct counter_count *count, u64 ceiling);
 
 Determining the type of extension to create is a matter of scope.
 
@@ -313,52 +349,127 @@ Determining the type of extension to create is a matter of scope.
   chip overheated via a device extension called "error_overtemp":
   /sys/bus/counter/devices/counterX/error_overtemp
 
-Architecture
-============
-
-When the Generic Counter interface counter module is loaded, the
-counter_init function is called which registers a bus_type named
-"counter" to the system. Subsequently, when the module is unloaded, the
-counter_exit function is called which unregisters the bus_type named
-"counter" from the system.
-
-Counter devices are registered to the system via the counter_register
-function, and later removed via the counter_unregister function. The
-counter_register function establishes a unique ID for the Counter
-device and creates a respective sysfs directory, where X is the
-mentioned unique ID:
-
-    /sys/bus/counter/devices/counterX
-
-Sysfs attributes are created within the counterX directory to expose
-functionality, configurations, and data relating to the Counts, Signals,
-and Synapses of the Counter device, as well as options and information
-for the Counter device itself.
-
-Each Signal has a directory created to house its relevant sysfs
-attributes, where Y is the unique ID of the respective Signal:
-
-    /sys/bus/counter/devices/counterX/signalY
-
-Similarly, each Count has a directory created to house its relevant
-sysfs attributes, where Y is the unique ID of the respective Count:
-
-    /sys/bus/counter/devices/counterX/countY
-
-For a more detailed breakdown of the available Generic Counter interface
-sysfs attributes, please refer to the
-Documentation/ABI/testing/sysfs-bus-counter file.
-
-The Signals and Counts associated with the Counter device are registered
-to the system as well by the counter_register function. The
-signal_read/signal_write driver callbacks are associated with their
-respective Signal attributes, while the count_read/count_write and
-function_get/function_set driver callbacks are associated with their
-respective Count attributes; similarly, the same is true for the
-action_get/action_set driver callbacks and their respective Synapse
-attributes. If a driver callback is left undefined, then the respective
-read/write permission is left disabled for the relevant attributes.
-
-Similarly, extension sysfs attributes are created for the defined
-counter_device_ext, counter_count_ext, and counter_signal_ext
-structures that are passed in.
+Subsystem Architecture
+======================
+
+Counter drivers pass and take data natively (i.e. ``u8``, ``u64``, etc.)
+and the shared counter module handles the translation between the sysfs
+interface. This guarantees a standard userspace interface for all
+counter drivers, and enables a Generic Counter chrdev interface via a
+generalized device driver ABI.
+
+A high-level view of how a count value is passed down from a counter
+driver is exemplified by the following. The driver callbacks are first
+registered to the Counter core component for use by the Counter
+userspace interface components::
+
+        Driver callbacks registration:
+        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+                        +----------------------------+
+                        | Counter device driver      |
+                        +----------------------------+
+                        | Processes data from device |
+                        +----------------------------+
+                                |
+                         -------------------
+                        / driver callbacks /
+                        -------------------
+                                |
+                                V
+                        +----------------------+
+                        | Counter core         |
+                        +----------------------+
+                        | Routes device driver |
+                        | callbacks to the     |
+                        | userspace interfaces |
+                        +----------------------+
+                                |
+                         -------------------
+                        / driver callbacks /
+                        -------------------
+                                |
+                +---------------+
+                |
+                V
+        +--------------------+
+        | Counter sysfs      |
+        +--------------------+
+        | Translates to the  |
+        | standard Counter   |
+        | sysfs output       |
+        +--------------------+
+
+Thereafter, data can be transferred directly between the Counter device
+driver and Counter userspace interface::
+
+        Count data request:
+        ~~~~~~~~~~~~~~~~~~~
+                         ----------------------
+                        / Counter device       \
+                        +----------------------+
+                        | Count register: 0x28 |
+                        +----------------------+
+                                |
+                         -----------------
+                        / raw count data /
+                        -----------------
+                                |
+                                V
+                        +----------------------------+
+                        | Counter device driver      |
+                        +----------------------------+
+                        | Processes data from device |
+                        |----------------------------|
+                        | Type: u64                  |
+                        | Value: 42                  |
+                        +----------------------------+
+                                |
+                         ----------
+                        / u64     /
+                        ----------
+                                |
+                +---------------+
+                |
+                V
+        +--------------------+
+        | Counter sysfs      |
+        +--------------------+
+        | Translates to the  |
+        | standard Counter   |
+        | sysfs output       |
+        |--------------------|
+        | Type: const char * |
+        | Value: "42"        |
+        +--------------------+
+                |
+         ---------------
+        / const char * /
+        ---------------
+                |
+                V
+        +--------------------------------------------------+
+        | `/sys/bus/counter/devices/counterX/countY/count` |
+        +--------------------------------------------------+
+        \ Count: "42"                                      /
+         --------------------------------------------------
+
+There are three primary components involved:
+
+Counter device driver
+---------------------
+Communicates with the hardware device to read/write data; e.g. counter
+drivers for quadrature encoders, timers, etc.
+
+Counter core
+------------
+Registers the counter device driver to the system so that the respective
+callbacks are called during userspace interaction.
+
+Counter sysfs
+-------------
+Translates counter data to the standard Counter sysfs interface format
+and vice versa.
+
+Please refer to the ``Documentation/ABI/testing/sysfs-bus-counter`` file
+for a detailed breakdown of the available Generic Counter interface
+sysfs attributes.
-- 
2.32.0

