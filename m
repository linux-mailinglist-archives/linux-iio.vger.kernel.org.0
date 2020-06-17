Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD571FC3C6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFQBlA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jun 2020 21:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgFQBkp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2020 21:40:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC210C061573;
        Tue, 16 Jun 2020 18:40:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c185so601084qke.7;
        Tue, 16 Jun 2020 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWwCvXGLu1d/G++bm7Oxn/c4JGmCfQ82ajY1qfafTpE=;
        b=HIgvMYLotp2h5l+AVet4rhc5L93WzEhO+AOYx5JGqwBg+NTBJL2yCwhpsqqPX2xeIV
         SEU3TQJ0/txS7XZIvCLkliGTluk0Uf9rDIxorpCz/0K45cQfhBuBRiej69bQGz6pMAXU
         OwDImDm792HuORCnRGS0kEq/isnW5VVTInw5FmylN+Ktp8xstSzo1ZbkGffqQg/xmOQD
         rnFthKu55yM2WGGzRf3eXRPhe/EWwUep6x4aBZN3enj1jNQ+3z/lDvsISBGQ3aj8zcoO
         M3z/xA+HYEX6wtUYhxX3DXHrGj7PmrQleDVp0i9sTG3/H3id753GZy3poMwwY57Rxz1z
         on/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWwCvXGLu1d/G++bm7Oxn/c4JGmCfQ82ajY1qfafTpE=;
        b=lsGoOX6pCRzVVLjEZNvD+2N9x/mneENrzJcMWmE1kDIkxWrbX/mk33w4f4c8xjVSVX
         kmyYrzEIwgvXdP47q5vrz4yJIpb4O7thoq/52okaxCy99wx9miwJmV37BFkqbsGQ3hp7
         ipHk3NC6poXqmOW8bRTNHdhkZ7IcyWeGs6iq1tmH2l3NCT6L5RDsI8QgtRcQ2EoSk3rN
         G5lF6gfzGGRNdmSzdmxHwVEyBWQYOsiHNGoN/cwG/hrkGpP1NmoBvJKbudTgB1XGfJu7
         bJqLHpaqEhnaNiRb4REe3K+z1YXYzMordRbXxR5fAdwpu+2Ql9oxFNMRTc91dmJt/GO/
         3qTQ==
X-Gm-Message-State: AOAM532TeWfHeASSgmuckkT5Uke6Pfmii/Vz6RvuURg2aE5VHPWwv4Zm
        Voi7uFdTOniKrCW4v1yJx0o=
X-Google-Smtp-Source: ABdhPJwE3D3cZ9qs43mDkPVXfw5Jp+J/fhH36c9wvJ3LklRXK0DNFu/9EuqwqrvQbUSn0+uZ2ek82Q==
X-Received: by 2002:a37:9cc7:: with SMTP id f190mr23211573qke.236.1592358042991;
        Tue, 16 Jun 2020 18:40:42 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a14sm1917014qkn.16.2020.06.16.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:40:42 -0700 (PDT)
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
Subject: [PATCH v3 4/4] docs: counter: Document character device interface
Date:   Tue, 16 Jun 2020 21:40:02 -0400
Message-Id: <061c85baa1c2e1bf1510b6235a82b44ba2a89931.1592341702.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592341702.git.vilhelm.gray@gmail.com>
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-counter  |  31 +++++
 Documentation/driver-api/generic-counter.rst | 132 ++++++++++++++-----
 2 files changed, 127 insertions(+), 36 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 566bd99fe0a5..8533a8732544 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -193,6 +193,37 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/chrdev_format
+KernelVersion:	5.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Data format of the respective character device node of the
+		Counter. Reading this attribute returns the current data format
+		of the respective character device node; writing to this
+		attribute sets the current data format of the respective
+		character device node. This attribute interfaces via the
+		following format:
+
+		Components/extensions are specified by a character identifier
+		and an index offset; whitespace serves as delimiters. The
+		following character identifiers are supported:
+
+		C: Count
+		S: Signal
+		E: Extension
+		A: Synapse Action
+		F: Count Function
+
+		Count/Signal extensions may be specified by first specifying the
+		respective owning component then the desired extension
+		immediately following without delimiting whitespace; Synapse
+		Action and Count Function are specified in a similar manner.
+
+		For example, "C4 C2E6 C0F S7E1 C3A4 S5" would specify the
+		following data format: Count 4, Count 2's Extension 6, Count 0's
+		Count Function, Signal 7's Extension 1, Count 3's Synapse Action
+		4, Signal 5.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 8aaa6cd37fd4..d46ce65d1488 100644
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
 
@@ -378,13 +365,13 @@ driver is exemplified by the following::
                 +----------------------------+          |
                 | Processes data from device |   -------------------
                 |----------------------------|  / driver callbacks /
-                | Type: unsigned long        |  -------------------
+                | Type: u64                  |  -------------------
                 | Value: 42                  |          |
                 +----------------------------+          |
                         |                               |
-                 ----------------                       |
-                / unsigned long /                       |
-                ----------------                        |
+                 ----------                             |
+                / u64     /                             |
+                ----------                              |
                         |                               |
                         |                               V
                         |               +----------------------+
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
+         ---------------                 ----------
+        / const char * /                / u64     /
+        ---------------                 ----------
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
@@ -446,3 +440,69 @@ and vice versa.
 Please refer to the `Documentation/ABI/testing/sysfs-bus-counter` file
 for a detailed breakdown of the available Generic Counter interface
 sysfs attributes.
+
+Counter chrdev
+--------------
+Translates counter data to the standard Counter character device; data
+is transferred via standard character device read/write calls.
+
+Sysfs Interface
+===============
+
+Several sysfs attributes are generated by the Generic Counter interface,
+and reside under the `/sys/bus/counter/devices/counterX` directory,
+where `X` is to the respective counter device id. Please see
+Documentation/ABI/testing/sysfs-bus-counter for detailed information on
+each Generic Counter interface sysfs attribute.
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
+`include/uapi/linux/counter-types.h` file.
+
+A `/sys/bus/counter/devices/counterX/chrdev_format` sysfs attribute is
+available to expose the character device data format.
+
+Users may write to this sysfs attribute to select the components they
+want to interface -- the layout can be determined as well from the
+order. For example::
+
+# echo "C0 C3 C2" > /sys/bus/counter/devices/counter0/chrdev_format
+
+This would select Counts 0, 3, and 2 (in that order) to be available
+in the `/dev/counter0` node as a contiguous memory region.
+
+Users can select extensions in a similar fashion::
+
+# echo "C4E2 S1E0" > /sys/bus/counter/devices/counter0/chrdev_format
+
+This would select extension 2 from Count 4, and extension 0 from
+Signal 1.
+
+Users may read from this `chrdev_format` sysfs attribute in order to see
+the currently configured format of the character device.
+
+Users may perform read/write operations on the `/dev/counterX` node
+directly; the layout of the data is what they user has configured via
+the chrdev_format sysfs attribute. For example::
+
+# echo "C0 C1 S0 S1" > /sys/bus/counter/devices/counter0/chrdev_format
+
+Yields the following `/dev/counter0` memory layout::
+
+        +-----------------+------------------+----------+----------+
+        | Byte 0 - Byte 7 | Byte 8 - Byte 15 | Byte 16  | Byte 17  |
+        +-----------------+------------------+----------+----------+
+        | Count 0         | Count 1          | Signal 0 | Signal 2 |
+        +-----------------+------------------+----------+----------+
+
+The number of bytes allotted for each component or extension is
+determined by its respective data type: u8 will have 1 byte allotted,
+u64 will have 8 bytes allotted, etc.
-- 
2.26.2

