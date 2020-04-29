Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351921BE5F0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgD2SME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgD2SMD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 14:12:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D8C03C1AE;
        Wed, 29 Apr 2020 11:12:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so2706894qtm.4;
        Wed, 29 Apr 2020 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tsSqdNWnb3CiuOvg96gs7sg5rhYKvwHlBRsWbohoX4=;
        b=p4WsQDKVxAz07MQA8hvDDKFPZMOxcFuvPUKCfaz8nY2dZ7WnmYgSOoDOobts8uWuvo
         ZIcaaUm1ApaCNIvFdCdSbVP3+b4Qc6Xn23PTrLU9ul80cxZdoD02Ok2mE1EIMRIHJJXI
         yjExhQiHAHJg8SjYdCjE3cSHxPBoeMhEWCxsqJy64KziBdBvPyFIL2u7/RNmhnKXp+bv
         WTASNdkj+S4YmcGpI3V//KYIg/zkKVb+FuBQwALXWhCKmRTbslaW+HTZa98NStwz4dOi
         RkXlsx9MfonxSRxhbh0nh5F/kD1T0obPNRx34CvhmcVOTjjZZtbr+b/lHgijj5fe9fq0
         NN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tsSqdNWnb3CiuOvg96gs7sg5rhYKvwHlBRsWbohoX4=;
        b=B4TCnZLGdIQMdvd9SU1tPuI2uZhNMGaDrOBqFvAJSWprvKFWoTHzeYKLiaHgVZFbTV
         8spqB+mwU/b+cAp+qqKhlJg3T1PBGvZHUTOT9jF07AQyN58qk26kL3TyBRMzaRuFzoVW
         xdEzQgV4Dngmchu0rWXIj4xVDXaeR06eaHA15E63j+Q3btkIpA4hjYm5kjVXrZ6NZVJq
         Yfcf4KNIVrcaWf4hTt1E9CCQ+8FKrL/qVdqBu62qmKlVD99y/utEYBxR7HuT2xk7qhHn
         bMCyn3KIEr8w+5mtLjYICEeuA9MnVgFR667eBaMXekDX/3gTChMkpRqwnm18oclbZAv4
         +IoA==
X-Gm-Message-State: AGi0PuYPOOYbSEOO2iBOosnQV5nleu7vtNR8RYFhEHnEwHH9IZqSLAd2
        KsVUNXkqY38j7DPEVRJ9zv4=
X-Google-Smtp-Source: APiQypKY8OpPGQ+A02xX2a1aWXbNyQ9A0dh8ssyUBdOY9769gG4lAy9hnA/fuVUNNmetqVHdZBDzeg==
X-Received: by 2002:aed:2766:: with SMTP id n93mr35352318qtd.130.1588183922632;
        Wed, 29 Apr 2020 11:12:02 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o43sm16315082qtf.46.2020.04.29.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:12:01 -0700 (PDT)
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
Subject: [PATCH 4/4] docs: counter: Document character device interface
Date:   Wed, 29 Apr 2020 14:11:38 -0400
Message-Id: <639b231a155fee0b1786aafb441f61e8094dcf75.1588176662.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588176662.git.vilhelm.gray@gmail.com>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds high-level documentation about the Counter subsystem
character device interface. The 0x3E major number and respective minor
number range is reserved for Counter character device interface ioctl
calls.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst  | 87 ++++++++++++-------
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 3ab8125b9c05..959c4074078c 100644
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
 
@@ -409,25 +396,32 @@ driver can be exemplified by the following::
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
+        | Type: const char * |     | Type: unsigned long |
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
+         ---------------                 ----------------
+        / const char * /                / unsigned long /
+        ---------------                 ----------------
+                |                               |
+                |                               V
+                |                       +-----------+
+                |                       | ioctl     |
+                |                       +-----------+
+                |                       \ Count: 42 /
+                |                        -----------
                 |
                 V
         +--------------------------------------------------+
@@ -436,7 +430,7 @@ driver can be exemplified by the following::
         \ Count: "42"                                      /
          --------------------------------------------------
 
-There are three primary components involved:
+There are four primary components involved:
 
 Counter device driver
 ---------------------
@@ -456,3 +450,32 @@ and vice versa.
 Please refer to the `Documentation/ABI/testing/sysfs-bus-counter` file
 for a detailed breakdown of the available Generic Counter interface
 sysfs attributes.
+
+Counter chrdev
+--------------
+Translates counter data to the standard Counter character device; data
+is transferred via ioctl calls.
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
+`counterX`, where `X` is the respective counter device id. Device
+information and control is exposed via a set of standard Counter
+subsystem ioctl commands.
+
+.. kernel-doc:: include/uapi/linux/counter.h
+   :internal:
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index f759edafd938..8136a26fb81c 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -88,6 +88,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <http://infiniband.sourceforge.net/>
 0x20  all    drivers/cdrom/cm206.h
 0x22  all    scsi/sg.h
+0x3E  00-1F  linux/counter.h                                         <mailto:linux-iio@vger.kernel.org>
 '!'   00-1F  uapi/linux/seccomp.h
 '#'   00-3F                                                          IEEE 1394 Subsystem
                                                                      Block for the entire subsystem
-- 
2.26.2

