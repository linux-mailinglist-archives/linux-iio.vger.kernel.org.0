Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE12F255F
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 02:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbhALBSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 20:18:20 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbhALBSU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 20:18:20 -0500
Received: from [172.23.56.21] ([82.207.222.170]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqK6l-1kDNJt09lj-00nMYG for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021
 02:15:34 +0100
Message-ID: <efa4524cd07abe0a7773b24d33b64f09e0bf1f82.camel@richard-neumann.de>
Subject: [PATCH] - AMD Sensor Fusion Hub refactored driver with module
 parameters
From:   Richard Neumann <mail@richard-neumann.de>
To:     linux-iio@vger.kernel.org
Date:   Tue, 12 Jan 2021 02:15:33 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ivmc/tcUWtkIzi1Vvmz4yKPewUOWlEaI4+HO2HG4WF9QhDyeeMU
 I7G0WXXsE3PXHr15qBsIsWYzhnuUQVspHd8EtFzhrqfaQn4zcrIFmkiiFTqCaLEIEEttfKn
 QF6UudlysKFFrMrwgmYa/qomdV8l82i/UrdsjWpJ6lpd3lM9dmJKcEDc1DlfgL9yZsRr5zd
 nNzW0yhG+oxu/l1KWdlvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PI/MrzxmuSQ=:pkAX2FUyjBKkpzTqwmNJsS
 B4rHNppYemK3u7pi7dskDWtf+Up3neZOSIteTWSK67C2NDUY491Qi0U9otCmnEvvqla+7C3bj
 cT5DyL/4P3aw9WL/ekvpw61s4D0LnFJ9CtaGeqOWHRCioo5/irs/fTf6Mw7gku+O3E59Q/k2X
 OlSeUGIBlrj3URGfrp65bCovA8K/QPDR540e8TziejId4Y9EY4zVDiHjnLPtFfFu6t4Tk76CU
 YNeeEsX7IYB4pQ6j5IZWESswfbEgewqIMsBnckFayGalnDz6EdVbGZsbqCxpKmpxz4s7+hi6w
 Fis5sEYkNF3MCYUiCJUq027zEiqDVKwLoBq1VbFAAxGgPWYk57Su1rgOpONkb7AlEZGjgAfMs
 vSo7AZQVJdYaYWcJKv2coZV9dCZ8Zom7ASKRLtFerzg/3qQsBW8ZmcURIg5XFGOcAXgwvEpGx
 OBuIxnczdg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From fa17269ddab9113a4325a0c22b7b71acb16404c3 Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:09:39 +0100
Subject: [PATCH 1/7] Updated MAINTAINERS and documentation.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 Documentation/hid/amd-sfh-hid.rst | 275 ++++++++++++++----------------
 MAINTAINERS                       |   9 +
 2 files changed, 140 insertions(+), 144 deletions(-)

diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
index 1f2fe29ccd4f..d68ba2b85d1e 100644
--- a/Documentation/hid/amd-sfh-hid.rst
+++ b/Documentation/hid/amd-sfh-hid.rst
@@ -1,145 +1,132 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-
-AMD Sensor Fusion Hub
-=====================
-AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen based platforms.
-The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
-In terms of architecture it resembles ISH, however the major difference is all
-the HID reports are generated as part of the kernel driver.
-
-1. Block Diagram
-================
-
-::
-
-	---------------------------------
-	|  HID User Space Applications  |
-	- -------------------------------
-
-    ---------------------------------------------
-	 ---------------------------------
-	|		HID Core          |
-	 ---------------------------------
-
-	 ---------------------------------
-	|     AMD HID Transport           |
-	 ---------------------------------
-
-	 --------------------------------
-	|             AMD HID Client     |
-	|	with HID Report Generator|
-	 --------------------------------
-
-	 --------------------------------
-	|     AMD MP2 PCIe Driver        |
-	 --------------------------------
-    OS
-    ---------------------------------------------
-    Hardware + Firmware
-         --------------------------------
-         |     SFH MP2 Processor         |
-         --------------------------------
-
-
-AMD HID Transport Layer
------------------------
-AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2 is
-registered as a device on this bus. Here: MP2 which is an ARM core connected to x86 for processing
-sensor data. The layer, which binds each device (AMD SFH HID driver) identifies the device type and
-registers with the hid core. Transport layer attach a constant "struct hid_ll_driver" object with
-each device. Once a device is registered with HID core, the callbacks provided via this struct are
-used by HID core to communicate with the device. AMD HID Transport layer implements the synchronous calls.
-
-AMD HID Client Layer
+========================================
+Kernel drivers: amd-sfh-pci, amd-sfh-hid
+========================================
+
+Supported adapters:
+  * AMD Sensor Fusion Hub PCIe interface
+
+Datasheet: not publicly available.
+
+Authors:
+        - Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+        - Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+        - Sandeep Singh <sandeep.singh@amd.com>
+        - Richard Neumann <mail@richard-neumann.de>
+
+Description
+===========
+The AMD Sensor Fushion Hub (SFH) is part of a SOC on Ryzen-based platforms.
+The SFH uses HID over PCIe bus. In terms of architecture it is much more
+resmebles like ISH. However the major difference is, that currently HID reports
+are being generated within the kernel driver.
+
+Block Diagram
+-------------
+.. code-block:: none
+
+    +-------------------------------+
+    |  HID User Space Applications  |
+    +-------------------------------+
+    =================================
+    +-------------------------------+
+    |      HID low-level driver     |
+    |   with HID report generator   |
+    +-------------------------------+
+
+    +-------------------------------+
+    |      HID platform driver      |
+    +-------------------------------+
+
+    +-------------------------------+
+    |      AMD SFH PCIe driver      |
+    +-------------------------------+
+    =================================
+    +-------------------------------+
+    |       SFH MP2 Processor       |
+    +-------------------------------+
+
+HID low-level driver
 --------------------
-This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic, HID
-client layer fills the HID request structure and descriptors. HID client layer is complex as it is
-interface between MP2 PCIe layer and HID. HID client layer initialized the MP2 PCIe layer and holds
-the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Base
-on that allocates the DRAM address for each and every sensor and pass it to MP2-PCIe driver.On
-enumeration of each the sensor, client layer fills the HID Descriptor structure and HID input repor
-structure. HID Feature report structure is optional. The report descriptor structure varies from
-sensor to sensor.
-
-AMD MP2 PCIe layer
-------------------
-MP2 PCIe Layer is responsible for making all transactions with the firmware over PCIe.
-The connection establishment between firmware and PCIe happens here.
-
-The communication between X86 and MP2 is split into three parts.
-1. Command transfer via the C2P mailbox registers.
-2. Data transfer via DRAM.
-3. Supported sensor info via P2C registers.
-
-Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generate
-interrupt to MP2. The client layer allocates the physical memory and the same is sent to MP2 via
-the PCI layer. MP2 firmware writes the command output to the access DRAM memory which the client
-layer has allocated. Firmware always writes minimum of 32 bytes into DRAM. So as a protocol driver
-shall allocate minimum of 32 bytes DRAM space.
-
-Enumeration and Probing flow
-----------------------------
-::
-
-       HID             AMD            AMD                       AMD -PCIe             MP2
-       Core         Transport      Client layer                   layer                FW
-        |		|	       |                           |                 |
-        |		|              |                 on Boot Driver Loaded       |
-        |		|	       |                           |                 |
-        |		|	       |                        MP2-PCIe Int         |
-        |		|              |			   |                 |
-        |		|	       |---Get Number of sensors-> |                 |
-        |		|              |                       Read P2C              |
-        |		|	       |			Register             |
-        |		|              |                           |                 |
-        |               |              | Loop(for No of Sensors)   |                 |
-        |		|	       |----------------------|    |                 |
-        |		|              | Create HID Descriptor|    |                 |
-        |		|	       | Create Input  report |    |                 |
-        |		|              |  Descriptor Map      |    |                 |
-        |		|	       |  the MP2 FW Index to |    |                 |
-        |		|              |   HID Index          |    |                 |
-        |		|	       | Allocate the DRAM    |  Enable              |
-        |		|	       |	address       |  Sensors             |
-        |		|              |----------------------|    |                 |
-        |		| HID transport|                           |    Enable       |
-        |	        |<--Probe------|                           |---Sensor CMD--> |
-        |		| Create the   |			   |                 |
-        |		| HID device   |                           |                 |
-        |               |    (MFD)     |                           |                 |
-        |		| by Populating|			   |                 |
-        |               |  the HID     |                           |                 |
-        |               |  ll_driver   |                           |                 |
-        | HID           |	       |			   |                 |
-        |  add          |              |                           |                 |
-        |Device         |              |                           |                 |
-        |<------------- |	       |			   |                 |
-
-
-Data Flow from Application to the AMD SFH Driver
-------------------------------------------------
-
-::
-
-	        |	       |              |	  	 	          |		    |
-                |	       |	      |			          |                 |
-                |	       |	      |			          |                 |
-                |              |              |                           |                 |
-                |              |              |                           |                 |
-                |HID_req       |              |                           |                 |
-                |get_report    |              |                           |                 |
-                |------------->|              |                           |                 |
-	        |              | HID_get_input|                           |                 |
-	        |              |  report      |                           |                 |
-	        |              |------------->|------------------------|  |                 |
-	        |              |              |  Read the DRAM data for|  |                 |
-	        |              |              |  requested sensor and  |  |                 |
-	        |              |              |  create the HID input  |  |                 |
-	        |              |              |  report                |  |                 |
-	        |              |              |------------------------|  |                 |
-	        |              |Data received |                           |                 |
-	        |              | in HID report|                           |                 |
-    To	        |<-------------|<-------------|                           |                 |
-    Applications|              |              |                           |                 |
-        <-------|              |              |                           |                 |
+The driver is conceived in a multi-layer architecture.
+The level closest to the applications is the HID low-level (LL) driver,
+which implements the functions defined by the hid-core API to manage the
+respective HID devices and process reports.
+Therefor, the HID-LL-driver starts and stops the sensors as needed by invoking
+the exposed functions from the PCI driver (see below) and creates DMA mappings
+to access the DRAM of the PCI device to retrieve feature and input reports
+from it.
+
+HID platform driver (`amd-sfh-hid`)
+-----------------------------------
+The aforementioned HID devices are being managed, i.e. created on probing and
+destroyed on removing, by the platform driver. It is being loaded through ACPI
+table matching if the PCI driver was loaded successfully.
+It determines the HID devices to be created on startup using the connected
+sensors bitmask retrieved by invoking the respective function of the PCI driver.
+On some systems the firmware does not provide the information about sensors
+connected to the SFH device. In this case, the detected sensors can be manually
+overridden by setting the driver's module parameter `sensor_mask=<int>`.
+
+PCI device driver (`amd-sfh-pci`)
+---------------------------------
+The PCI driver is responsible for making all transaction with the chip's
+firmware over PCI-e.
+The sensors are being started and stopped respectively by writing commands
+and, where applicable, DRAM addresses to certain device registers.
+The sensor's input report data can then be accessed by accessing the DRAM
+through DMA-mapped virtual addresses. Commands are sent to the device using C2P
+mail box registers. These C2P registers are mapped in PCIe address space.
+Writing into the device message registers generates interrupts. The device's
+firmware uses DRAM interface registers to indirectly access DRAM memory. It is
+recommended to always write a minimum of 32 bytes into the DRAM.
+
+Driver loading
+--------------
+
++------------+-----------------+----------------------+
+| PCI driver | Platform driver | HID low-level driver |
++============+=================+======================+
+| Loaded at boot time if       | Used by spawned HIDs |
+| device is present.           |                      |
++------------------------------+----------------------+
+
+Data flow table
+---------------
+.. code-block:: none
+
+                                                 +===============================================+
+    +============+        Get sensor mask        |                Platform driver                |
+    | PCI driver | <---------------------------- +===============================================+
+    +============+    of available HID devices   | * Probe HID devices according to sensor mask. |
+          ^                                      | * Start periodical polling from DRAM.         |
+          |                                      +-----------------------------------------------+
+ Start / stop sensor on                                                 |
+ respective HID requsts.                                                |
+          |                +==============================+             |
+          |                |        HID ll-driver         |             |
+          +--------------- +==============================+ <-----------+
+                           | Provide reports as requested |
+                           | by hid-code.                 |
+                           +------------------------------+
+
+Quirks
+------
+On some systems, the sensor hub has not been programmed with information about
+the sensors active on the device. This results in no sensors bein activated and
+no HID devices being spawned by the driver. To manually active the respective
+sensors, you can load the module `amd-sfh-hid` with the kernel parameter
+`sensor_mask=<int>`. The available sensors are currently:
+
++----------------------+----------+
+|        sensor        |   mask   |
++======================+==========+
+| accelerometer        |  BIT(0)  |
+| gyroscope            |  BIT(1)  |
+| magnetometer         |  BIT(2)  |
+| ambient light sensor |  BIT(19) |
++----------------------+----------+
+
+To enable e.g. only the accelerometer:
+
+    $ cat /etc/modprobe.d/amd_sfh.conf
+    options amd_sfh_hid sensor_mask=1
diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..29fe4b9e803c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -949,6 +949,15 @@ M:	Tom Lendacky <thomas.lendacky@amd.com>
 S:	Supported
 F:	arch/arm64/boot/dts/amd/
 
+AMD SENSOR FUSION HUB DRIVER
+M:	Richard Neumann <mail@richard-neumann.de>
+M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
+M:	Sandeep Singh <sandeep.singh@amd.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hid/amd-sfh*
+F:	drivers/hid/amd-sfh-hid/
+
 AMD XGBE DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 L:	netdev@vger.kernel.org
-- 
2.30.0

From 46e332358edb9c3515312a140e8c76b35d374938 Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:11:05 +0100
Subject: [PATCH 2/7] Updated Kconfig and Makefile.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/Kconfig  |  4 ++--
 drivers/hid/amd-sfh-hid/Makefile | 14 +++++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
index db069a83e9a2..7ebb96827a05 100644
--- a/drivers/hid/amd-sfh-hid/Kconfig
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -12,7 +12,7 @@ config AMD_SFH_HID
 	  This driver will enable sensors functionality on AMD platforms
 	  starting from 17h family of RYZEN parts.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called amd-sfh.
+	  This driver can also be built as a module. If so, the modules will
+	  be called amd-sfh-pci and amd-sf-hid.
 	  Say Y or M here if you want to support AMD SFH. If unsure, say N.
 endmenu
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
index 35e704da5612..303ee8f9aac5 100644
--- a/drivers/hid/amd-sfh-hid/Makefile
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -1,13 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile - AMD SFH HID drivers
-# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
+# Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
 #
 #
-obj-$(CONFIG_AMD_SFH_HID) += amd_sfh.o
-amd_sfh-objs := amd_sfh_hid.o
-amd_sfh-objs += amd_sfh_client.o
-amd_sfh-objs += amd_sfh_pcie.o
-amd_sfh-objs += hid_descriptor/amd_sfh_hid_desc.o
-
-ccflags-y += -I $(srctree)/$(src)/
+ccflags-m := -Werror
+obj-$(CONFIG_AMD_SFH_HID) += amd-sfh-pci.o amd-sfh-hid.o
+amd-sfh-hid-objs += amd-sfh-plat.o amd-sfh-hid-ll-drv.o amd-sfh-hid-reports.o
-- 
2.30.0

From 850ecb3710a13ec066d2ad416fdd0bebbe72aeff Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:11:40 +0100
Subject: [PATCH 3/7] Updated HID descriptors.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 ...eport_desc.h => amd-sfh-hid-descriptors.h} | 51 +++++++++----------
 1 file changed, 25 insertions(+), 26 deletions(-)
 rename drivers/hid/amd-sfh-hid/{hid_descriptor/amd_sfh_hid_report_desc.h => amd-sfh-hid-descriptors.h} (95%)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/amd-sfh-hid-descriptors.h
similarity index 95%
rename from drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
rename to drivers/hid/amd-sfh-hid/amd-sfh-hid-descriptors.h
index 44271d39b322..d99eae76415d 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-hid-descriptors.h
@@ -1,25 +1,24 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * HID  descriptor stuructures
- * Copyright 2020 Advanced Micro Devices, Inc.
- * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
- *	    Sandeep Singh <Sandeep.singh@amd.com>
+ * AMD Sensor Fusion Hub HID descriptor definitions
+ *
+ * Author:	Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
  */
 
-#ifndef AMD_SFH_HID_REPORT_DESCRIPTOR_H
-#define AMD_SFH_HID_REPORT_DESCRIPTOR_H
+#ifndef AMD_SFH_HID_DESCRIPTORS_H
+#define AMD_SFH_HID_DESCRIPTORS_H
 
 // Accelerometer 3D Sensor
 static const u8 accel3_report_descriptor[] = {
-0x05, 0x20,          /* Usage page */
-0x09, 0x73,          /* Motion type Accel 3D */
-0xA1, 0x00,          /* HID Collection (Physical) */
+0x05, 0x20,		  /* Usage page */
+0x09, 0x73,		  /* Motion type Accel 3D */
+0xA1, 0x00,		  /* HID Collection (Physical) */
 
 //feature reports(xmit/receive)
-0x85, 1,           /* HID  Report ID */
+0x85, 1,		   /* HID  Report ID */
 0x05, 0x20,	   /* HID usage page sensor */
 0x0A, 0x09, 0x03,  /* Sensor property and sensor connection type */
-0x15, 0,           /* HID logical MIN_8(0) */
+0x15, 0,		   /* HID logical MIN_8(0) */
 0x25, 2,	   /* HID logical MAX_8(2) */
 0x75, 8,	   /* HID report size(8) */
 0x95, 1,	   /* HID report count(1) */
@@ -27,13 +26,13 @@ static const u8 accel3_report_descriptor[] = {
 0x0A, 0x30, 0x08, /* Sensor property connection type intergated sel*/
 0x0A, 0x31, 0x08, /* Sensor property connection type attached sel */
 0x0A, 0x32, 0x08, /* Sensor property connection type external sel */
-0xB1, 0x00,       /* HID feature (Data_Arr_Abs) */
+0xB1, 0x00,	   /* HID feature (Data_Arr_Abs) */
 0xC0,		  /* HID end collection */
 0x0A, 0x16, 0x03, /* HID usage sensor property reporting state */
-0x15, 0,          /* HID logical Min_8(0) */
+0x15, 0,		  /* HID logical Min_8(0) */
 0x25, 5,	  /* HID logical Max_8(5) */
 0x75, 8,	  /* HID report size(8) */
-0x95, 1,          /* HID report count(1) */
+0x95, 1,		  /* HID report count(1) */
 0xA1, 0x02,	  /* HID collection(logical) */
 0x0A, 0x40, 0x08, /* Sensor property report state no events sel */
 0x0A, 0x41, 0x08, /* Sensor property report state all events sel */
@@ -55,7 +54,7 @@ static const u8 accel3_report_descriptor[] = {
 0x0A, 0x53, 0x08, /* Sensor property power state D2 standby with wake sel */
 0x0A, 0x54, 0x08, /* Sensor property power state D3 sleep with wake  sel */
 0x0A, 0x55, 0x08, /* Sensor property power state D4 power off sel */
-0xB1, 0x00,       /* HID feature (Data_Arr_Abs) */
+0xB1, 0x00,	   /* HID feature (Data_Arr_Abs) */
 0xC0,		  /* HID end collection */
 0x0A, 0x01, 0x02, /* HID usage sensor state */
 0x15, 0,	  /* HID logical Min_8(0) */
@@ -339,7 +338,7 @@ const u8 gyro3_report_descriptor[] = {
 0xC0,			/* HID end collection */
 };
 
-const u8 comp3_report_descriptor[] = {
+const u8 magno_report_descriptor[] = {
 0x05, 0x20,		/* Usage page */
 0x09, 0x83,		/* Motion type Orientation compass 3D */
 0xA1, 0x00,		/* HID Collection (Physical) */
@@ -371,7 +370,7 @@ const u8 comp3_report_descriptor[] = {
 0x0A, 0x45, 0x08,	/* Sensor reporting state threshold events wake sel */
 0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
 0xC0,			/* HID end collection */
-0x0A, 0x19, 0x03,       /* HID usage sensor property power state */
+0x0A, 0x19, 0x03,	   /* HID usage sensor property power state */
 0x15, 0,		/* HID logical Min_8(0) */
 0x25, 5,		/* HID logical Max_8(5) */
 0x75, 8,		/* HID report size(8) */
@@ -391,13 +390,13 @@ const u8 comp3_report_descriptor[] = {
 0x75, 8,		/* HID report size(8) */
 0x95, 1,		/* HID report count(1) */
 0xA1, 0x02,		/* HID collection(logical) */
-0x0A, 0x00, 0x08,       /* HID usage sensor state unknown sel */
-0x0A, 0x01, 0x08,       /* HID usage sensor state ready sel */
-0x0A, 0x02, 0x08,       /* HID usage sensor state not available sel */
-0x0A, 0x03, 0x08,       /* HID usage sensor state no data sel */
-0x0A, 0x04, 0x08,       /* HID usage sensor state initializing sel */
-0x0A, 0x05, 0x08,       /* HID usage sensor state access denied sel */
-0x0A, 0x06, 0x08,       /* HID usage sensor state error sel */
+0x0A, 0x00, 0x08,	   /* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	   /* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	   /* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	   /* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	   /* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	   /* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	   /* HID usage sensor state error sel */
 0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
 0xC0,			/* HID end collection */
 0x0A, 0x0E, 0x03,	/* HID usage sensor property report interval */
@@ -516,7 +515,7 @@ const u8 als_report_descriptor[] = {
 0x09, 0x41,	/* HID usage sensor type Ambientlight  */
 0xA1, 0x00,	/* HID Collection (Physical) */
 
-//feature reports(xmit/receive)//
+//feature reports(xmit/receive)
 0x85, 4,		/* HID  Report ID */
 0x05, 0x20,		/* HID usage page sensor */
 0x0A, 0x09, 0x03,	/* Sensor property and sensor connection type */
-- 
2.30.0

From 3140e899d6e1cd89149f7a5d37f3b98ec4495f11 Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:12:42 +0100
Subject: [PATCH 4/7] Updated HID report generator functions.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.c | 354 ++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.h | 102 +++++
 .../hid_descriptor/amd_sfh_hid_desc.c         | 224 -----------
 .../hid_descriptor/amd_sfh_hid_desc.h         | 107 ------
 4 files changed, 456 insertions(+), 331 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.h
 delete mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
 delete mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h

diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.c b/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.c
new file mode 100644
index 000000000000..b8cb89b79fc2
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  AMD SFH HID report and descriptor generation
+ *
+ *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *          Richard Neumann <mail@richard-neumann.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "amd-sfh-hid-descriptors.h"
+#include "amd-sfh-hid-reports.h"
+#include "amd-sfh-pci.h"
+
+#define FIRMWARE_MULTIPLIER						1000
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM		0x41
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM		0x51
+#define HID_DEFAULT_REPORT_INTERVAL					0x50
+#define HID_DEFAULT_MIN_VALUE						0X7F
+#define HID_DEFAULT_MAX_VALUE						0x80
+#define HID_DEFAULT_SENSITIVITY						0x7F
+#define HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM	0x01
+/* state enums */
+#define HID_USAGE_SENSOR_STATE_READY_ENUM				0x02
+#define HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM			0x05
+#define HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM			0x04
+
+/**
+ * get_report_descriptor - Writes a report descriptor.
+ * @sensor_idx:		The sensor index
+ * @buf:		The report descriptor buffer
+ *
+ * Returns zero on success or nonzero on errors.
+ */
+int get_report_descriptor(enum sensor_idx sensor_idx, u8 *buf)
+{
+	size_t size;
+
+	if (!buf)
+		return -ENOBUFS;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		size = sizeof(accel3_report_descriptor);
+		memcpy(buf, accel3_report_descriptor, size);
+		break;
+	case GYRO_IDX:
+		size = sizeof(gyro3_report_descriptor);
+		memcpy(buf, gyro3_report_descriptor, size);
+		break;
+	case MAG_IDX:
+		size = sizeof(magno_report_descriptor);
+		memcpy(buf, magno_report_descriptor, size);
+		break;
+	case ALS_IDX:
+		size = sizeof(als_report_descriptor);
+		memcpy(buf, als_report_descriptor, size);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_report_descriptor);
+
+/**
+ * get_descriptor_size - Returns the requested descriptor size.
+ * @sensor_idx:		The sensor index
+ * @descriptor_name:	The requested descriptor
+ *
+ * Returns the respective descriptor's size or <0 on errors.
+ */
+int get_descriptor_size(enum sensor_idx sensor_idx, enum desc_type desc_type)
+{
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		switch (desc_type) {
+		case AMD_SFH_DESCRIPTOR:
+			return sizeof(accel3_report_descriptor);
+		case AMD_SFH_INPUT_REPORT:
+			return sizeof(struct accel3_input_report);
+		case AMD_SFH_FEATURE_REPORT:
+			return sizeof(struct accel3_feature_report);
+		}
+		break;
+	case GYRO_IDX:
+		switch (desc_type) {
+		case AMD_SFH_DESCRIPTOR:
+			return sizeof(gyro3_report_descriptor);
+		case AMD_SFH_INPUT_REPORT:
+			return sizeof(struct gyro_input_report);
+		case AMD_SFH_FEATURE_REPORT:
+			return sizeof(struct gyro_feature_report);
+		}
+		break;
+	case MAG_IDX:
+		switch (desc_type) {
+		case AMD_SFH_DESCRIPTOR:
+			return sizeof(magno_report_descriptor);
+		case AMD_SFH_INPUT_REPORT:
+			return sizeof(struct magno_input_report);
+		case AMD_SFH_FEATURE_REPORT:
+			return sizeof(struct magno_feature_report);
+		}
+		break;
+	case ALS_IDX:
+		switch (desc_type) {
+		case AMD_SFH_DESCRIPTOR:
+			return sizeof(als_report_descriptor);
+		case AMD_SFH_INPUT_REPORT:
+			return sizeof(struct als_input_report);
+		case AMD_SFH_FEATURE_REPORT:
+			return sizeof(struct als_feature_report);
+		}
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(get_descriptor_size);
+
+static void get_common_features(struct common_features *common, int report_id)
+{
+	common->report_id = report_id;
+	common->connection_type =
+		HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+	common->report_state =
+		HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+	common->power_state =
+		HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+	common->sensor_state = HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+	common->report_interval =  HID_DEFAULT_REPORT_INTERVAL;
+}
+
+static int get_accel_feature_report(int report_id, u8 *buf, size_t len)
+{
+	size_t size;
+	struct accel3_feature_report accel_features;
+
+	get_common_features(&accel_features.common, report_id);
+	accel_features.change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+	accel_features.sensitivity_min = HID_DEFAULT_MIN_VALUE;
+	accel_features.sensitivity_max = HID_DEFAULT_MAX_VALUE;
+	size = sizeof(accel_features);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &accel_features, size);
+	return size;
+}
+
+static int get_gyro_feature_report(int report_id, u8 *buf, size_t len)
+{
+	size_t size;
+	struct gyro_feature_report gyro_features;
+
+	get_common_features(&gyro_features.common, report_id);
+	gyro_features.change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+	gyro_features.sensitivity_min = HID_DEFAULT_MIN_VALUE;
+	gyro_features.sensitivity_max = HID_DEFAULT_MAX_VALUE;
+	size = sizeof(gyro_features);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &gyro_features, size);
+	return size;
+}
+
+static int get_mag_feature_report(int report_id, u8 *buf, size_t len)
+{
+	size_t size;
+	struct magno_feature_report magno_features;
+
+	get_common_features(&magno_features.common, report_id);
+	magno_features.heading_min = HID_DEFAULT_MIN_VALUE;
+	magno_features.heading_max = HID_DEFAULT_MAX_VALUE;
+	magno_features.flux_change_sensitivity = HID_DEFAULT_MIN_VALUE;
+	magno_features.flux_min = HID_DEFAULT_MIN_VALUE;
+	magno_features.flux_max = HID_DEFAULT_MAX_VALUE;
+	size = sizeof(magno_features);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &magno_features, size);
+	return size;
+}
+
+static int get_als_feature_report(int report_id, u8 *buf, size_t len)
+{
+	size_t size;
+	struct als_feature_report als_features;
+
+	get_common_features(&als_features.common, report_id);
+	als_features.change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+	als_features.sensitivity_min = HID_DEFAULT_MIN_VALUE;
+	als_features.sensitivity_max = HID_DEFAULT_MAX_VALUE;
+	size = sizeof(als_features);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &als_features, size);
+	return size;
+}
+
+/**
+ * get_feature_report - Writes a feature report and returns its size.
+ * @sensor_idx:		The sensor index
+ * @report_id:		The report id
+ * @buf:		The feature report buffer
+ *
+ * Returns the size on success or < 0 on errors.
+ */
+int get_feature_report(enum sensor_idx sensor_idx, int report_id, u8 *buf,
+		       size_t len)
+{
+	if (!buf)
+		return -ENOBUFS;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		return get_accel_feature_report(report_id, buf, len);
+	case GYRO_IDX:
+		return get_gyro_feature_report(report_id, buf, len);
+	case MAG_IDX:
+		return get_mag_feature_report(report_id, buf, len);
+	case ALS_IDX:
+		return get_als_feature_report(report_id, buf, len);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(get_feature_report);
+
+static void get_common_inputs(struct common_inputs *common, int report_id)
+{
+	common->report_id = report_id;
+	common->sensor_state = HID_USAGE_SENSOR_STATE_READY_ENUM;
+	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+}
+
+static int get_accel_input_report(int report_id, u8 *buf, size_t len,
+				  u32 *cpu_addr)
+{
+	size_t size;
+	struct accel3_input_report acc_input;
+
+	get_common_inputs(&acc_input.common, report_id);
+	acc_input.accel_x = (int)cpu_addr[0] / FIRMWARE_MULTIPLIER;
+	acc_input.accel_y = (int)cpu_addr[1] / FIRMWARE_MULTIPLIER;
+	acc_input.accel_z = (int)cpu_addr[2] / FIRMWARE_MULTIPLIER;
+	acc_input.shake_detection = (int)cpu_addr[3] / FIRMWARE_MULTIPLIER;
+	size = sizeof(acc_input);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &acc_input, size);
+	return size;
+}
+
+static int get_gyro_input_report(int report_id, u8 *buf, size_t len,
+				 u32 *cpu_addr)
+{
+	size_t size;
+	struct gyro_input_report gyro_input;
+
+	get_common_inputs(&gyro_input.common, report_id);
+	gyro_input.angle_x = (int)cpu_addr[0] / FIRMWARE_MULTIPLIER;
+	gyro_input.angle_y = (int)cpu_addr[1] / FIRMWARE_MULTIPLIER;
+	gyro_input.angle_z = (int)cpu_addr[2] / FIRMWARE_MULTIPLIER;
+	size = sizeof(gyro_input);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &gyro_input, size);
+	return size;
+}
+
+static int get_mag_input_report(int report_id, u8 *buf, size_t len,
+				u32 *cpu_addr)
+{
+	size_t size;
+	struct magno_input_report magno_input;
+
+	get_common_inputs(&magno_input.common, report_id);
+	magno_input.flux_x = (int)cpu_addr[0] / FIRMWARE_MULTIPLIER;
+	magno_input.flux_y = (int)cpu_addr[1] / FIRMWARE_MULTIPLIER;
+	magno_input.flux_z = (int)cpu_addr[2] / FIRMWARE_MULTIPLIER;
+	magno_input.accuracy = (u16)cpu_addr[3] / FIRMWARE_MULTIPLIER;
+	size = sizeof(magno_input);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &magno_input, size);
+	return size;
+}
+
+static int get_als_input_report(int report_id, u8 *buf, size_t len,
+				u32 *cpu_addr)
+{
+	size_t size;
+	struct als_input_report als_input;
+
+	get_common_inputs(&als_input.common, report_id);
+	als_input.illuminance = (int)cpu_addr[0] / FIRMWARE_MULTIPLIER;
+	size = sizeof(als_input);
+
+	if (size > len)
+		return -ENOMEM;
+
+	memcpy(buf, &als_input, size);
+	return size;
+}
+
+/**
+ * get_feature_report - Writes an input report and returns its size.
+ * @sensor_idx:		The sensor index
+ * @report_id:		The report id
+ * @buf:		The feature report buffer
+ * @cpu_addr:		The DMA mapped CPU address
+ *
+ * Returns the size on success or < 0 on errors.
+ */
+int get_input_report(enum sensor_idx sensor_idx, int report_id, u8 *buf,
+		     size_t len, u32 *cpu_addr)
+{
+	if (!buf)
+		return -ENOBUFS;
+
+	if (!cpu_addr)
+		return -EIO;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		return get_accel_input_report(report_id, buf, len, cpu_addr);
+	case GYRO_IDX:
+		return get_gyro_input_report(report_id, buf, len, cpu_addr);
+	case MAG_IDX:
+		return get_mag_input_report(report_id, buf, len, cpu_addr);
+	case ALS_IDX:
+		return get_als_input_report(report_id, buf, len, cpu_addr);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.h b/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.h
new file mode 100644
index 000000000000..1cb16d9bd143
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-hid-reports.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HID report and report stuructures and routines
+ *
+ * Author: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ */
+
+#ifndef AMD_SFH_HID_REPORTS_H
+#define AMD_SFH_HID_REPORTS_H
+
+#include "amd-sfh-pci.h"
+
+/**
+ * desc_type - Report descriptor types.
+ */
+enum desc_type {
+	AMD_SFH_DESCRIPTOR,
+	AMD_SFH_INPUT_REPORT,
+	AMD_SFH_FEATURE_REPORT,
+};
+
+struct common_features {
+	u8 report_id;
+	u8 connection_type;
+	u8 report_state;
+	u8 power_state;
+	u8 sensor_state;
+	u32 report_interval;
+} __packed;
+
+struct common_inputs {
+	u8 report_id;
+	u8 sensor_state;
+	u8 event_type;
+} __packed;
+
+struct accel3_feature_report {
+	struct common_features common;
+	u16 change_sesnitivity;
+	s16 sensitivity_max;
+	s16 sensitivity_min;
+} __packed;
+
+struct accel3_input_report {
+	struct common_inputs common;
+	int accel_x;
+	int accel_y;
+	int accel_z;
+	u8 shake_detection;
+} __packed;
+
+struct gyro_feature_report {
+	struct common_features common;
+	u16 change_sesnitivity;
+	s16 sensitivity_max;
+	s16 sensitivity_min;
+} __packed;
+
+struct gyro_input_report {
+	struct common_inputs common;
+	int angle_x;
+	int angle_y;
+	int angle_z;
+} __packed;
+
+struct magno_feature_report {
+	struct common_features common;
+	u16 headingchange_sensitivity;
+	s16 heading_min;
+	s16 heading_max;
+	u16 flux_change_sensitivity;
+	s16 flux_min;
+	s16 flux_max;
+} __packed;
+
+struct magno_input_report {
+	struct common_inputs common;
+	int flux_x;
+	int flux_y;
+	int flux_z;
+	int accuracy;
+} __packed;
+
+struct als_feature_report {
+	struct common_features common;
+	u16 change_sesnitivity;
+	s16 sensitivity_max;
+	s16 sensitivity_min;
+} __packed;
+
+struct als_input_report {
+	struct common_inputs common;
+	int illuminance;
+} __packed;
+
+int get_report_descriptor(enum sensor_idx sensor_idx, u8 *buf);
+int get_descriptor_size(enum sensor_idx sensor_idx, enum desc_type desc_type);
+int get_feature_report(enum sensor_idx sensor_idx, int report_id, u8 *buf,
+		       size_t len);
+int get_input_report(enum sensor_idx sensor_idx, int report_id, u8 *buf,
+		     size_t len, u32 *sensor_virt_addr);
+#endif
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
deleted file mode 100644
index 6e3ad66e57a4..000000000000
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ /dev/null
@@ -1,224 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  AMD SFH Report Descriptor generator
- *  Copyright 2020 Advanced Micro Devices, Inc.
- *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
- *	     Sandeep Singh <sandeep.singh@amd.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include "amd_sfh_pcie.h"
-#include "amd_sfh_hid_desc.h"
-#include "amd_sfh_hid_report_desc.h"
-
-#define	AMD_SFH_FW_MULTIPLIER (1000)
-#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x41
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM	0x51
-#define HID_DEFAULT_REPORT_INTERVAL				0x50
-#define HID_DEFAULT_MIN_VALUE					0X7F
-#define HID_DEFAULT_MAX_VALUE					0x80
-#define HID_DEFAULT_SENSITIVITY					0x7F
-#define HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM  0x01
-/* state enums */
-#define HID_USAGE_SENSOR_STATE_READY_ENUM                             0x02
-#define HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM                      0x05
-#define HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM                      0x04
-
-int get_report_descriptor(int sensor_idx, u8 *rep_desc)
-{
-	switch (sensor_idx) {
-	case accel_idx: /* accel */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
-		memcpy(rep_desc, accel3_report_descriptor,
-		       sizeof(accel3_report_descriptor));
-		break;
-	case gyro_idx: /* gyro */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
-		memcpy(rep_desc, gyro3_report_descriptor,
-		       sizeof(gyro3_report_descriptor));
-		break;
-	case mag_idx: /* Magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
-		memcpy(rep_desc, comp3_report_descriptor,
-		       sizeof(comp3_report_descriptor));
-		break;
-	case als_idx: /* ambient light sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
-		memcpy(rep_desc, als_report_descriptor,
-		       sizeof(als_report_descriptor));
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-u32 get_descr_sz(int sensor_idx, int descriptor_name)
-{
-	switch (sensor_idx) {
-	case accel_idx:
-		switch (descriptor_name) {
-		case descr_size:
-			return sizeof(accel3_report_descriptor);
-		case input_size:
-			return sizeof(struct accel3_input_report);
-		case feature_size:
-			return sizeof(struct accel3_feature_report);
-		}
-		break;
-	case gyro_idx:
-		switch (descriptor_name) {
-		case descr_size:
-			return sizeof(gyro3_report_descriptor);
-		case input_size:
-			return sizeof(struct gyro_input_report);
-		case feature_size:
-			return sizeof(struct gyro_feature_report);
-		}
-		break;
-	case mag_idx:
-		switch (descriptor_name) {
-		case descr_size:
-			return sizeof(comp3_report_descriptor);
-		case input_size:
-			return sizeof(struct magno_input_report);
-		case feature_size:
-			return sizeof(struct magno_feature_report);
-		}
-		break;
-	case als_idx:
-		switch (descriptor_name) {
-		case descr_size:
-			return sizeof(als_report_descriptor);
-		case input_size:
-			return sizeof(struct als_input_report);
-		case feature_size:
-			return sizeof(struct als_feature_report);
-		}
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static void get_common_features(struct common_feature_property *common, int report_id)
-{
-	common->report_id = report_id;
-	common->connection_type = HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
-	common->report_state = HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
-	common->power_state = HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
-	common->sensor_state = HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
-	common->report_interval =  HID_DEFAULT_REPORT_INTERVAL;
-}
-
-u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
-{
-	struct accel3_feature_report acc_feature;
-	struct gyro_feature_report gyro_feature;
-	struct magno_feature_report magno_feature;
-	struct als_feature_report als_feature;
-	u8 report_size = 0;
-
-	if (!feature_report)
-		return report_size;
-
-	switch (sensor_idx) {
-	case accel_idx: /* accel */
-		get_common_features(&acc_feature.common_property, report_id);
-		acc_feature.accel_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
-		acc_feature.accel_sensitivity_min = HID_DEFAULT_MIN_VALUE;
-		acc_feature.accel_sensitivity_max = HID_DEFAULT_MAX_VALUE;
-		memcpy(feature_report, &acc_feature, sizeof(acc_feature));
-		report_size = sizeof(acc_feature);
-		break;
-	case gyro_idx: /* gyro */
-		get_common_features(&gyro_feature.common_property, report_id);
-		gyro_feature.gyro_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
-		gyro_feature.gyro_sensitivity_min = HID_DEFAULT_MIN_VALUE;
-		gyro_feature.gyro_sensitivity_max = HID_DEFAULT_MAX_VALUE;
-		memcpy(feature_report, &gyro_feature, sizeof(gyro_feature));
-		report_size = sizeof(gyro_feature);
-		break;
-	case mag_idx: /* Magnetometer */
-		get_common_features(&magno_feature.common_property, report_id);
-		magno_feature.magno_headingchange_sensitivity = HID_DEFAULT_SENSITIVITY;
-		magno_feature.heading_min = HID_DEFAULT_MIN_VALUE;
-		magno_feature.heading_max = HID_DEFAULT_MAX_VALUE;
-		magno_feature.flux_change_sensitivity = HID_DEFAULT_MIN_VALUE;
-		magno_feature.flux_min = HID_DEFAULT_MIN_VALUE;
-		magno_feature.flux_max = HID_DEFAULT_MAX_VALUE;
-		memcpy(feature_report, &magno_feature, sizeof(magno_feature));
-		report_size = sizeof(magno_feature);
-		break;
-	case als_idx:  /* ambient light sensor */
-		get_common_features(&als_feature.common_property, report_id);
-		als_feature.als_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
-		als_feature.als_sensitivity_min = HID_DEFAULT_MIN_VALUE;
-		als_feature.als_sensitivity_max = HID_DEFAULT_MAX_VALUE;
-		memcpy(feature_report, &als_feature, sizeof(als_feature));
-		report_size = sizeof(als_feature);
-		break;
-	default:
-		break;
-	}
-	return report_size;
-}
-
-static void get_common_inputs(struct common_input_property *common, int report_id)
-{
-	common->report_id = report_id;
-	common->sensor_state = HID_USAGE_SENSOR_STATE_READY_ENUM;
-	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
-}
-
-u8 get_input_report(int sensor_idx, int report_id, u8 *input_report, u32 *sensor_virt_addr)
-{
-	struct accel3_input_report acc_input;
-	struct gyro_input_report gyro_input;
-	struct magno_input_report magno_input;
-	struct als_input_report als_input;
-	u8 report_size = 0;
-
-	if (!sensor_virt_addr || !input_report)
-		return report_size;
-
-	switch (sensor_idx) {
-	case accel_idx: /* accel */
-		get_common_inputs(&acc_input.common_property, report_id);
-		acc_input.in_accel_x_value = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
-		acc_input.in_accel_y_value = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
-		acc_input.in_accel_z_value =  (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
-		memcpy(input_report, &acc_input, sizeof(acc_input));
-		report_size = sizeof(acc_input);
-		break;
-	case gyro_idx: /* gyro */
-		get_common_inputs(&gyro_input.common_property, report_id);
-		gyro_input.in_angel_x_value = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
-		gyro_input.in_angel_y_value = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
-		gyro_input.in_angel_z_value =  (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
-		memcpy(input_report, &gyro_input, sizeof(gyro_input));
-		report_size = sizeof(gyro_input);
-		break;
-	case mag_idx: /* Magnetometer */
-		get_common_inputs(&magno_input.common_property, report_id);
-		magno_input.in_magno_x = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
-		magno_input.in_magno_y = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
-		magno_input.in_magno_z = (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
-		magno_input.in_magno_accuracy = (u16)sensor_virt_addr[3] / AMD_SFH_FW_MULTIPLIER;
-		memcpy(input_report, &magno_input, sizeof(magno_input));
-		report_size = sizeof(magno_input);
-		break;
-	case als_idx: /* Als */
-		get_common_inputs(&als_input.common_property, report_id);
-		als_input.illuminance_value =  (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
-		report_size = sizeof(als_input);
-		memcpy(input_report, &als_input, sizeof(als_input));
-		break;
-	default:
-		break;
-	}
-	return report_size;
-}
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
deleted file mode 100644
index 095c471d8fd6..000000000000
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * HID report descriptors, structures and routines
- * Copyright 2020 Advanced Micro Devices, Inc.
- * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
- *	    Sandeep Singh <Sandeep.singh@amd.com>
- */
-
-#ifndef AMD_SFH_HID_DESCRIPTOR_H
-#define AMD_SFH_HID_DESCRIPTOR_H
-
-enum desc_type {
-	/* Report descriptor name */
-	descr_size = 1,
-	input_size,
-	feature_size,
-};
-
-struct common_feature_property {
-	/* common properties */
-	u8 report_id;
-	u8 connection_type;
-	u8 report_state;
-	u8 power_state;
-	u8 sensor_state;
-	u32 report_interval;
-} __packed;
-
-struct common_input_property {
-	/* common properties */
-	u8 report_id;
-	u8 sensor_state;
-	u8 event_type;
-} __packed;
-
-struct accel3_feature_report {
-	struct common_feature_property common_property;
-	/* properties specific to this sensor */
-	u16 accel_change_sesnitivity;
-	s16 accel_sensitivity_max;
-	s16 accel_sensitivity_min;
-} __packed;
-
-struct accel3_input_report {
-	struct	common_input_property common_property;
-	/* values specific to this sensor */
-	int in_accel_x_value;
-	int in_accel_y_value;
-	int in_accel_z_value;
-	/* include if required to support the "shake" event */
-	u8 in_accel_shake_detection;
-} __packed;
-
-struct gyro_feature_report {
-	struct common_feature_property common_property;
-	/* properties specific to this sensor */
-	u16 gyro_change_sesnitivity;
-	s16 gyro_sensitivity_max;
-	s16 gyro_sensitivity_min;
-} __packed;
-
-struct gyro_input_report {
-	struct	common_input_property common_property;
-	/* values specific to this sensor */
-	int in_angel_x_value;
-	int in_angel_y_value;
-	int in_angel_z_value;
-} __packed;
-
-struct magno_feature_report {
-	struct common_feature_property common_property;
-	/*properties specific to this sensor */
-	u16 magno_headingchange_sensitivity;
-	s16 heading_min;
-	s16 heading_max;
-	u16 flux_change_sensitivity;
-	s16 flux_min;
-	s16 flux_max;
-} __packed;
-
-struct magno_input_report {
-	struct	common_input_property common_property;
-	int in_magno_x;
-	int in_magno_y;
-	int in_magno_z;
-	int in_magno_accuracy;
-} __packed;
-
-struct als_feature_report {
-	struct common_feature_property common_property;
-	/* properties specific to this sensor */
-	u16 als_change_sesnitivity;
-	s16 als_sensitivity_max;
-	s16 als_sensitivity_min;
-} __packed;
-
-struct als_input_report {
-	struct common_input_property common_property;
-	/* values specific to this sensor */
-	int illuminance_value;
-} __packed;
-
-int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
-u32 get_descr_sz(int sensor_idx, int descriptor_name);
-u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
-u8 get_input_report(int sensor_idx, int report_id, u8 *input_report, u32 *sensor_virt_addr);
-#endif
-- 
2.30.0

From 1c76091d884731127b808957ca40efbcb628594d Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:13:45 +0100
Subject: [PATCH 5/7] Updated HID LL-driver.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.c | 173 ++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.h |  41 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c        | 174 -------------------
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h        |  67 -------
 4 files changed, 214 insertions(+), 241 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.h
 delete mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.c
 delete mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.h

diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.c b/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.c
new file mode 100644
index 000000000000..fc9cd1908a5f
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * AMD Sensor Fusion Hub HID low-level driver
+ *
+ * Authors: Sandeep Singh <sandeep.singh@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *          Richard Neumann <mail@richard-neumann.de>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/hid.h>
+#include <linux/pci.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#include "amd-sfh-hid-ll-drv.h"
+#include "amd-sfh-hid-reports.h"
+#include "amd-sfh-pci.h"
+
+#define AMD_SFH_HID_DMA_SIZE	(sizeof(int) * 8)
+
+/**
+ * amd_sfh_hid_ll_parse - Callback to parse HID descriptor.
+ * @hid:	The HID device
+ *
+ * This function gets called during call to hid_add_device
+ *
+ * Return: 0 on success and non zero on error
+ */
+static int amd_sfh_hid_ll_parse(struct hid_device *hid)
+{
+	int rc;
+	u8 *buf;
+	size_t size;
+	struct amd_sfh_hid_data *hid_data;
+
+	hid_data = hid->driver_data;
+
+	size = get_descriptor_size(hid_data->sensor_idx, AMD_SFH_DESCRIPTOR);
+	if (size < 0) {
+		hid_err(hid, "Failed to get report descriptor size!\n");
+		return -EINVAL;
+	}
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	rc = get_report_descriptor(hid_data->sensor_idx, buf);
+	if (rc) {
+		hid_err(hid, "Failed to get report descriptor!\n");
+		goto free_buf;
+	}
+
+	rc = hid_parse_report(hid, buf, size);
+	if (rc)
+		hid_err(hid, "Failed to parse HID report!\n");
+
+free_buf:
+	kfree(buf);
+	return rc;
+}
+
+/**
+ * amd_sfh_hid_ll_start - Starts the HID device.
+ * @hid:	The HID device
+ *
+ * Allocates DMA memory and schedules report polling.
+ */
+static int amd_sfh_hid_ll_start(struct hid_device *hid)
+{
+	struct amd_sfh_hid_data *hid_data = hid->driver_data;
+
+	hid_data->cpu_addr = dma_alloc_coherent(&hid_data->pci_dev->dev,
+						AMD_SFH_HID_DMA_SIZE,
+						&hid_data->dma_handle,
+						GFP_KERNEL);
+	if (!hid_data->cpu_addr)
+		return -EIO;
+
+	schedule_delayed_work(&hid_data->work, hid_data->interval);
+	return 0;
+}
+
+/**
+ * amd_sfh_hid_ll_stop - Stops the HID device.
+ * @hid:	The HID device
+ *
+ * Stops report polling jobs and frees the DMA memory.
+ */
+static void amd_sfh_hid_ll_stop(struct hid_device *hid)
+{
+	struct amd_sfh_hid_data *hid_data = hid->driver_data;
+
+	cancel_delayed_work_sync(&hid_data->work);
+	dma_free_coherent(&hid_data->pci_dev->dev, AMD_SFH_HID_DMA_SIZE,
+			  hid_data->cpu_addr, hid_data->dma_handle);
+	hid_data->cpu_addr = NULL;
+}
+
+/**
+ * amd_sfh_hid_ll_open - Opens the HID device.
+ * @hid:	The HID device
+ *
+ * Starts the corresponding sensor via the PCI driver.
+ */
+static int amd_sfh_hid_ll_open(struct hid_device *hid)
+{
+	struct amd_sfh_hid_data *hid_data = hid->driver_data;
+
+	amd_sfh_start_sensor(hid_data->pci_dev, hid_data->sensor_idx,
+			     hid_data->dma_handle, hid_data->interval);
+	return 0;
+}
+
+/**
+ * amd_sfh_hid_ll_close - Closes the HID device.
+ * @hid:	The HID device
+ *
+ * Stops the corresponding sensor via the PCI driver.
+ */
+static void amd_sfh_hid_ll_close(struct hid_device *hid)
+{
+	struct amd_sfh_hid_data *hid_data = hid->driver_data;
+
+	cancel_delayed_work_sync(&hid_data->work);
+	amd_sfh_stop_sensor(hid_data->pci_dev, hid_data->sensor_idx);
+}
+
+/**
+ * amd_sfh_hid_ll_raw_request - Handles HID requests.
+ * @hid:	The HID device
+ * @reportnum:	The HID report ID
+ * @buf:	The write buffer for HID data
+ * @len:	The size of the write buffer
+ * @rtype:	The report type
+ * @reqtype:	The request type
+ *
+ * Delegates to the reporting functions
+ * defined in amd-sfh-hid-descriptor.h.
+ */
+static int amd_sfh_hid_ll_raw_request(struct hid_device *hid,
+				      unsigned char reportnum, u8 *buf,
+				      size_t len, unsigned char rtype,
+				      int reqtype)
+{
+	struct amd_sfh_hid_data *hid_data = hid->driver_data;
+
+	switch (rtype) {
+	case HID_FEATURE_REPORT:
+		return get_feature_report(hid_data->sensor_idx, reportnum, buf,
+					  len);
+	case HID_INPUT_REPORT:
+		return get_input_report(hid_data->sensor_idx, reportnum, buf,
+					len, hid_data->cpu_addr);
+	default:
+		hid_err(hid, "Unsupported report type: %u\n", rtype);
+		return -EINVAL;
+	}
+}
+
+/**
+ * The HID low-level driver for SFH HID devices.
+ */
+struct hid_ll_driver amd_sfh_hid_ll_driver = {
+	.parse	=	amd_sfh_hid_ll_parse,
+	.start	=	amd_sfh_hid_ll_start,
+	.stop	=	amd_sfh_hid_ll_stop,
+	.open	=	amd_sfh_hid_ll_open,
+	.close	=	amd_sfh_hid_ll_close,
+	.raw_request  =	amd_sfh_hid_ll_raw_request,
+};
diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.h b/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.h
new file mode 100644
index 000000000000..3c5ea8c7cdb0
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-hid-ll-drv.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Sensor Fusion Hub HID low-level driver interface
+ *
+ * Authors: Sandeep Singh <sandeep.singh@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *          Richard Neumann <mail@richard-neumann.de>
+ */
+
+#ifndef AMD_SFH_HID_LL_DRV_H
+#define AMD_SFH_HID_LL_DRV_H
+
+#include <linux/hid.h>
+#include <linux/pci.h>
+
+#include "amd-sfh-pci.h"
+
+/**
+ * struct amd_sfh_hid_data - Per HID device driver data.
+ * @sensor_idx:		The sensor index
+ * @pci_dev:		The uderlying PCI device
+ * @work:		Work buffer for device polling
+ * @hid:		Backref to the hid device
+ * @cpu_addr:		The DMA mapped CPU address
+ * @dma_handle:		The DMA handle
+ * @interval:		The sensor update interval
+ */
+struct amd_sfh_hid_data {
+	enum sensor_idx sensor_idx;
+	struct pci_dev *pci_dev;
+	struct delayed_work work;
+	struct hid_device *hid;
+	u32 *cpu_addr;
+	dma_addr_t dma_handle;
+	unsigned int interval;
+};
+
+/* The low-level driver for AMD SFH HID devices */
+extern struct hid_ll_driver amd_sfh_hid_ll_driver;
+
+#endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
deleted file mode 100644
index 4f989483aa03..000000000000
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * AMD MP2 Sensors transport driver
- *
- * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
- *	    Sandeep Singh <sandeep.singh@amd.com>
- */
-#include <linux/hid.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
-
-#include "amd_sfh_hid.h"
-
-#define AMD_SFH_RESPONSE_TIMEOUT	1500
-
-/**
- * amdtp_hid_parse() - hid-core .parse() callback
- * @hid:	hid device instance
- *
- * This function gets called during call to hid_add_device
- *
- * Return: 0 on success and non zero on error
- */
-static int amdtp_hid_parse(struct hid_device *hid)
-{
-	struct amdtp_hid_data *hid_data = hid->driver_data;
-	struct amdtp_cl_data *cli_data = hid_data->cli_data;
-
-	return hid_parse_report(hid, cli_data->report_descr[hid_data->index],
-			      cli_data->report_descr_sz[hid_data->index]);
-}
-
-/* Empty callbacks with success return code */
-static int amdtp_hid_start(struct hid_device *hid)
-{
-	return 0;
-}
-
-static void amdtp_hid_stop(struct hid_device *hid)
-{
-}
-
-static int amdtp_hid_open(struct hid_device *hid)
-{
-	return 0;
-}
-
-static void amdtp_hid_close(struct hid_device *hid)
-{
-}
-
-static int amdtp_raw_request(struct hid_device *hdev, u8 reportnum,
-			     u8 *buf, size_t len, u8 rtype, int reqtype)
-{
-	return 0;
-}
-
-static void amdtp_hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype)
-{
-	int rc;
-
-	switch (reqtype) {
-	case HID_REQ_GET_REPORT:
-		rc = amd_sfh_get_report(hid, rep->id, rep->type);
-		if (rc)
-			dev_err(&hid->dev, "AMDSFH  get report error\n");
-		break;
-	case HID_REQ_SET_REPORT:
-		amd_sfh_set_report(hid, rep->id, reqtype);
-		break;
-	default:
-		break;
-	}
-}
-
-static int amdtp_wait_for_response(struct hid_device *hid)
-{
-	struct amdtp_hid_data *hid_data =  hid->driver_data;
-	struct amdtp_cl_data *cli_data = hid_data->cli_data;
-	int i, ret = 0;
-
-	for (i = 0; i < cli_data->num_hid_devices; i++) {
-		if (cli_data->hid_sensor_hubs[i] == hid)
-			break;
-	}
-
-	if (!cli_data->request_done[i])
-		ret = wait_event_interruptible_timeout(hid_data->hid_wait,
-						       cli_data->request_done[i],
-						       msecs_to_jiffies(AMD_SFH_RESPONSE_TIMEOUT));
-	if (ret == -ERESTARTSYS)
-		return -ERESTARTSYS;
-	else if (ret < 0)
-		return -ETIMEDOUT;
-	else
-		return 0;
-}
-
-void amdtp_hid_wakeup(struct hid_device *hid)
-{
-	struct amdtp_hid_data *hid_data = hid->driver_data;
-	struct amdtp_cl_data *cli_data = hid_data->cli_data;
-
-	cli_data->request_done[cli_data->cur_hid_dev] = true;
-	wake_up_interruptible(&hid_data->hid_wait);
-}
-
-static struct hid_ll_driver amdtp_hid_ll_driver = {
-	.parse	=	amdtp_hid_parse,
-	.start	=	amdtp_hid_start,
-	.stop	=	amdtp_hid_stop,
-	.open	=	amdtp_hid_open,
-	.close	=	amdtp_hid_close,
-	.request  =	amdtp_hid_request,
-	.wait	=	amdtp_wait_for_response,
-	.raw_request  =	amdtp_raw_request,
-};
-
-int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
-{
-	struct hid_device *hid;
-	struct amdtp_hid_data *hid_data;
-	int rc;
-
-	hid = hid_allocate_device();
-	if (IS_ERR(hid))
-		return PTR_ERR(hid);
-
-	hid_data = kzalloc(sizeof(*hid_data), GFP_KERNEL);
-	if (!hid_data) {
-		rc = -ENOMEM;
-		goto err_hid_data;
-	}
-
-	hid->ll_driver = &amdtp_hid_ll_driver;
-	hid_data->index = cur_hid_dev;
-	hid_data->cli_data = cli_data;
-	init_waitqueue_head(&hid_data->hid_wait);
-
-	hid->driver_data = hid_data;
-	cli_data->hid_sensor_hubs[cur_hid_dev] = hid;
-	hid->bus = BUS_AMD_AMDTP;
-	hid->vendor = AMD_SFH_HID_VENDOR;
-	hid->product = AMD_SFH_HID_PRODUCT;
-	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-amdtp",
-		 hid->vendor, hid->product);
-
-	rc = hid_add_device(hid);
-	if (rc)
-		goto err_hid_device;
-	return 0;
-
-err_hid_device:
-	kfree(hid_data);
-err_hid_data:
-	hid_destroy_device(hid);
-	return rc;
-}
-
-void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
-{
-	int i;
-
-	for (i = 0; i < cli_data->num_hid_devices; ++i) {
-		kfree(cli_data->feature_report[i]);
-		kfree(cli_data->input_report[i]);
-		kfree(cli_data->report_descr[i]);
-		if (cli_data->hid_sensor_hubs[i]) {
-			kfree(cli_data->hid_sensor_hubs[i]->driver_data);
-			hid_destroy_device(cli_data->hid_sensor_hubs[i]);
-			cli_data->hid_sensor_hubs[i] = NULL;
-		}
-	}
-}
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
deleted file mode 100644
index 6be0783d885c..000000000000
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * AMD MP2 Sensors transport driver
- *
- * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
- *	    Sandeep Singh <sandeep.singh@amd.com>
- */
-
-#ifndef AMDSFH_HID_H
-#define AMDSFH_HID_H
-
-#define MAX_HID_DEVICES		4
-#define BUS_AMD_AMDTP		0x20
-#define AMD_SFH_HID_VENDOR	0x1022
-#define AMD_SFH_HID_PRODUCT	0x0001
-
-struct amdtp_cl_data {
-	u8 init_done;
-	u32 cur_hid_dev;
-	u32 hid_dev_count;
-	u32 num_hid_devices;
-	struct device_info *hid_devices;
-	u8  *report_descr[MAX_HID_DEVICES];
-	int report_descr_sz[MAX_HID_DEVICES];
-	struct hid_device *hid_sensor_hubs[MAX_HID_DEVICES];
-	u8 *hid_descr[MAX_HID_DEVICES];
-	int hid_descr_size[MAX_HID_DEVICES];
-	phys_addr_t phys_addr_base;
-	u32 *sensor_virt_addr[MAX_HID_DEVICES];
-	phys_addr_t sensor_phys_addr[MAX_HID_DEVICES];
-	u32 sensor_sts[MAX_HID_DEVICES];
-	u32 sensor_requested_cnt[MAX_HID_DEVICES];
-	u8 report_type[MAX_HID_DEVICES];
-	u8 report_id[MAX_HID_DEVICES];
-	u8 sensor_idx[MAX_HID_DEVICES];
-	u8 *feature_report[MAX_HID_DEVICES];
-	u8 *input_report[MAX_HID_DEVICES];
-	u8 request_done[MAX_HID_DEVICES];
-	struct delayed_work work;
-	struct delayed_work work_buffer;
-};
-
-/**
- * struct amdtp_hid_data - Per instance HID data
- * @index:		Device index in the order of enumeration
- * @request_done:	Get Feature/Input report complete flag
- *			used during get/set request from hid core
- * @cli_data:		Link to the client instance
- * @hid_wait:		Completion waitq
- *
- * Used to tie hid->driver data to driver client instance
- */
-struct amdtp_hid_data {
-	int index;
-	struct amdtp_cl_data *cli_data;
-	wait_queue_head_t hid_wait;
-};
-
-/* Interface functions between HID LL driver and AMD SFH client */
-void hid_amdtp_set_feature(struct hid_device *hid, char *buf, u32 len, int report_id);
-void hid_amdtp_get_report(struct hid_device *hid, int report_id, int report_type);
-int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data);
-void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
-int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type);
-void amd_sfh_set_report(struct hid_device *hid, int report_id, int report_type);
-void amdtp_hid_wakeup(struct hid_device *hid);
-#endif
-- 
2.30.0

From 3b94461ea6f1eb141f9f3e7e30036492c68ec056 Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:14:20 +0100
Subject: [PATCH 6/7] Updated HID platform driver.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/amd-sfh-plat.c   | 324 +++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd-sfh-plat.h   |  38 +++
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 246 -----------------
 3 files changed, 362 insertions(+), 246 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-plat.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-plat.h
 delete mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_client.c

diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-plat.c b/drivers/hid/amd-sfh-hid/amd-sfh-plat.c
new file mode 100644
index 000000000000..da7440cb59d4
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-plat.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  AMD Sensor Fusion Hub HID platform driver
+ *
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *           Richard Neumann <mail@richard-neumann.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "amd-sfh-hid-ll-drv.h"
+#include "amd-sfh-hid-reports.h"
+#include "amd-sfh-plat.h"
+
+#define AMD_SFH_HID_VENDOR	0x3fe
+#define AMD_SFH_HID_PRODUCT	0x0001
+#define AMD_SFH_HID_VERSION	0x0001
+#define AMD_SFH_PHY_DEV		"AMD Sensor Fusion Hub (PCIe)"
+#define AMD_SFH_ALL_SENSORS	(ACCEL_MASK + GYRO_MASK + MAGNO_MASK + ALS_MASK)
+
+/* Module parameters */
+static int sensor_mask_override = -1;
+static int sensor_update_interval = 200;
+
+module_param_named(sensor_mask, sensor_mask_override, int, 0644);
+MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
+module_param_named(interval, sensor_update_interval, int, 0644);
+MODULE_PARM_DESC(interval, "override the sensor update interval");
+
+/**
+ * get_sensor_name - Returns the name of a sensor by its index.
+ * @sensor_idx:	The sensor's index
+ *
+ * Returns the name of the respective sensor.
+ */
+static char *amd_sfh_get_sensor_name(enum sensor_idx sensor_idx)
+{
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		return "accelerometer";
+	case GYRO_IDX:
+		return "gyroscope";
+	case MAG_IDX:
+		return "magnetometer";
+	case ALS_IDX:
+		return "ambient light sensor";
+	default:
+		return "unknown sensor type";
+	}
+}
+
+/**
+ * amd_sfh_hid_poll - Updates the input report for a HID device.
+ * @work:	The delayed work
+ *
+ * Polls input reports from the respective HID devices and submits
+ * them by invoking hid_input_report() from hid-core.
+ */
+static void amd_sfh_hid_poll(struct work_struct *work)
+{
+	struct amd_sfh_hid_data *hid_data;
+	struct hid_device *hid;
+	size_t size;
+	u8 *buf;
+
+	hid_data = container_of(work, struct amd_sfh_hid_data, work.work);
+	hid = hid_data->hid;
+	size = get_descriptor_size(hid_data->sensor_idx, AMD_SFH_INPUT_REPORT);
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		goto reschedule;
+
+	size = get_input_report(hid_data->sensor_idx, 1, buf, size,
+				hid_data->cpu_addr);
+	if (size < 0) {
+		hid_err(hid, "Failed to get input report!\n");
+		goto free_buf;
+	}
+
+	hid_input_report(hid, HID_INPUT_REPORT, buf, size, 0);
+
+free_buf:
+	kfree(buf);
+reschedule:
+	schedule_delayed_work(&hid_data->work, hid_data->interval);
+}
+
+/**
+ * amd_sfh_hid_probe - Initializes the respective HID device.
+ * @pci_dev:		The underlying PCI device
+ * @sensor_idx:		The sensor index
+ *
+ * Sets up the HID driver data and the corresponding HID device.
+ * Returns a pointer to the new HID device or NULL on errors.
+ */
+static struct hid_device *amd_sfh_hid_probe(struct pci_dev *pci_dev,
+					    enum sensor_idx sensor_idx)
+{
+	int rc;
+	char *name;
+	struct hid_device *hid;
+	struct amd_sfh_hid_data *hid_data;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		pci_err(pci_dev, "Failed to allocate HID device!\n");
+		goto err_hid_alloc;
+	}
+
+	hid_data = devm_kzalloc(&pci_dev->dev, sizeof(*hid_data), GFP_KERNEL);
+	if (!hid_data)
+		goto destroy_hid_device;
+
+	hid_data->sensor_idx = sensor_idx;
+	hid_data->pci_dev = pci_dev;
+	hid_data->hid = hid;
+	hid_data->cpu_addr = NULL;
+	hid_data->interval = sensor_update_interval;
+
+	INIT_DELAYED_WORK(&hid_data->work, amd_sfh_hid_poll);
+
+	hid->bus = BUS_I2C;
+	hid->group = HID_GROUP_SENSOR_HUB;
+	hid->vendor = AMD_SFH_HID_VENDOR;
+	hid->product = AMD_SFH_HID_PRODUCT;
+	hid->version = AMD_SFH_HID_VERSION;
+	hid->type = HID_TYPE_OTHER;
+	hid->ll_driver = &amd_sfh_hid_ll_driver;
+	hid->driver_data = hid_data;
+
+	name = amd_sfh_get_sensor_name(sensor_idx);
+
+	rc = strscpy(hid->name, name, sizeof(hid->name));
+	if (rc >= sizeof(hid->name))
+		hid_warn(hid, "Could not set HID device name.\n");
+
+	rc = strscpy(hid->phys, AMD_SFH_PHY_DEV, sizeof(hid->phys));
+	if (rc >= sizeof(hid->phys))
+		hid_warn(hid, "Could not set HID device location.\n");
+
+	rc = hid_add_device(hid);
+	if (rc)	{
+		hid_err(hid, "Failed to add HID device: %d\n", rc);
+		goto free_hid_data;
+	}
+
+	return hid;
+
+free_hid_data:
+	devm_kfree(&pci_dev->dev, hid_data);
+destroy_hid_device:
+	hid_destroy_device(hid);
+err_hid_alloc:
+	return NULL;
+}
+
+/**
+ * amd_sfh_plat_get_sensor_mask - Returns the sensors mask.
+ * @pci_dev:	The SFH PCI device
+ *
+ * Gets the sensor mask from the PCI device.
+ * Optionally overrides that value with the value provided by the
+ * kernel parameter `sensor_mask_override`.
+ * If sensors were specified, that the SFH fundamentally does not
+ * support, it logs a warning to the kernel ring buffer.
+ */
+static int amd_sfh_plat_get_sensor_mask(struct pci_dev *pci_dev)
+{
+	int invalid_sensors;
+	int sensor_mask = amd_sfh_get_sensor_mask(pci_dev);
+
+	if (sensor_mask_override >= 0)
+		sensor_mask = sensor_mask_override;
+
+	pci_info(pci_dev, "Sensor mask: %#04x\n", sensor_mask);
+
+	invalid_sensors = (AMD_SFH_ALL_SENSORS & sensor_mask) ^ sensor_mask;
+	if (invalid_sensors)
+		pci_warn(pci_dev, "Invalid sensors: %#04x\n", invalid_sensors);
+
+	return sensor_mask;
+}
+
+/**
+ * init_hid_devices - Initializes the HID devices.
+ * @privdata:	The platform device data
+ *
+ * Matches the sensors's masks against the sensor mask retrieved
+ * from amd_sfh_plat_get_sensor_mask().
+ * In case of a match, it instantiates a corresponding HID device
+ * to process the respective sensor's data.
+ */
+static void amd_sfh_init_hid_devices(struct amd_sfh_plat_dev *privdata)
+{
+	struct pci_dev *pci_dev;
+	int sensor_mask;
+
+	pci_dev = privdata->pci_dev;
+	sensor_mask = amd_sfh_plat_get_sensor_mask(pci_dev);
+
+	if (sensor_mask & ACCEL_MASK)
+		privdata->accel = amd_sfh_hid_probe(pci_dev, ACCEL_IDX);
+	else
+		privdata->accel = NULL;
+
+	if (sensor_mask & GYRO_MASK)
+		privdata->gyro = amd_sfh_hid_probe(pci_dev, GYRO_IDX);
+	else
+		privdata->gyro = NULL;
+
+	if (sensor_mask & MAGNO_MASK)
+		privdata->magno = amd_sfh_hid_probe(pci_dev, MAG_IDX);
+	else
+		privdata->magno = NULL;
+
+	if (sensor_mask & ALS_MASK)
+		privdata->als = amd_sfh_hid_probe(pci_dev, ALS_IDX);
+	else
+		privdata->als = NULL;
+}
+
+/**
+ * remove_hid_devices - Removes all active HID devices.
+ * @privdata:	The platform device data
+ *
+ * Destroys all initialized HID devices.
+ */
+static void remove_hid_devices(struct amd_sfh_plat_dev *privdata)
+{
+	if (privdata->accel)
+		hid_destroy_device(privdata->accel);
+
+	if (privdata->gyro)
+		hid_destroy_device(privdata->gyro);
+
+	if (privdata->magno)
+		hid_destroy_device(privdata->magno);
+
+	if (privdata->als)
+		hid_destroy_device(privdata->als);
+}
+
+/**
+ * amd_sfh_platform_probe - Probes the AMD SFH platform driver
+ * @pdev:	The platform device
+ *
+ * Initializes the client data and invokes initialization of HID devices.
+ * Returns 0 on success and nonzero on errors.
+ */
+static int amd_sfh_platform_probe(struct platform_device *pdev)
+{
+	struct amd_sfh_plat_dev *privdata;
+	struct pci_dev *pci_dev;
+
+	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
+	if (!privdata)
+		return -ENOMEM;
+
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SFH, NULL);
+	if (!pci_dev) {
+		dev_err(&pdev->dev, "No matching PCI device found!\n");
+		return -ENODEV;
+	}
+
+	if (!amd_sfh_pci_probed(pci_dev)) {
+		dev_err(&pdev->dev, "PCI driver not loaded!\n");
+		return -EPROBE_DEFER;
+	}
+
+	privdata->pci_dev = pci_dev;
+	platform_set_drvdata(pdev, privdata);
+	amd_sfh_init_hid_devices(privdata);
+	return 0;
+}
+
+/**
+ * amd_sfh_platform_remove - Removes AMD SFH platform driver
+ * @pdev:	The platform device
+ *
+ * Removes the HID devices and unloads the driver.
+ * Returns 0 on success and nonzero on errors.
+ */
+static int amd_sfh_platform_remove(struct platform_device *pdev)
+{
+	struct amd_sfh_plat_dev *privdata;
+
+	privdata = platform_get_drvdata(pdev);
+	if (!privdata)
+		return -EINVAL;
+
+	remove_hid_devices(privdata);
+	return 0;
+}
+
+static const struct acpi_device_id amd_sfh_acpi_match[] = {
+	{ "AMDI0080" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, amd_sfh_acpi_match);
+
+static struct platform_driver amd_sfh_platform_driver = {
+	.probe = amd_sfh_platform_probe,
+	.remove = amd_sfh_platform_remove,
+	.driver = {
+		.name = "amd-sfh-hid",
+		.acpi_match_table = amd_sfh_acpi_match,
+	},
+};
+
+module_platform_driver(amd_sfh_platform_driver);
+
+MODULE_DESCRIPTION("AMD(R) Sensor Fusion Hub HID platform driver");
+MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
+MODULE_AUTHOR("Richard Neumann <mail@richard-neumann.de>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-plat.h b/drivers/hid/amd-sfh-hid/amd-sfh-plat.h
new file mode 100644
index 000000000000..97350ded2797
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-plat.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ *  AMD Sensor Fusion Hub platform interface
+ *
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *           Richard Neumann <mail@richard-neumann.de>
+ */
+
+#ifndef AMD_SFH_PLAT_H
+#define AMD_SFH_PLAT_H
+
+#include <linux/bits.h>
+#include <linux/hid.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+
+#define ACCEL_MASK	BIT(ACCEL_IDX)
+#define GYRO_MASK	BIT(GYRO_IDX)
+#define MAGNO_MASK	BIT(MAG_IDX)
+#define ALS_MASK	BIT(ALS_IDX)
+
+/**
+ * struct amd_sfh_plat_dev - Platform device data
+ * @pci_dev:		The handled AMD SFH PCI device
+ * @accel:		The HID device of the accelerometer
+ * @gyro:		The HID device of the gyroscope
+ * @magno:		The HID device of the magnetometer
+ * @als:		The HID device of the ambient light sensor
+ */
+struct amd_sfh_plat_dev {
+	struct pci_dev *pci_dev;
+	struct hid_device *accel;
+	struct hid_device *gyro;
+	struct hid_device *magno;
+	struct hid_device *als;
+};
+
+#endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
deleted file mode 100644
index 3d1ccac5d99a..000000000000
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ /dev/null
@@ -1,246 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  AMD SFH Client Layer
- *  Copyright 2020 Advanced Micro Devices, Inc.
- *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
- *	     Sandeep Singh <Sandeep.singh@amd.com>
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/hid.h>
-#include <linux/list.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-#include <linux/errno.h>
-
-#include "hid_descriptor/amd_sfh_hid_desc.h"
-#include "amd_sfh_pcie.h"
-#include "amd_sfh_hid.h"
-
-#define AMD_SFH_IDLE_LOOP	200
-
-struct request_list {
-	struct hid_device *hid;
-	struct list_head list;
-	u8 report_id;
-	u8 sensor_idx;
-	u8 report_type;
-	u8 current_index;
-};
-
-static struct request_list req_list;
-
-void amd_sfh_set_report(struct hid_device *hid, int report_id,
-			int report_type)
-{
-	struct amdtp_hid_data *hid_data = hid->driver_data;
-	struct amdtp_cl_data *cli_data = hid_data->cli_data;
-	int i;
-
-	for (i = 0; i < cli_data->num_hid_devices; i++) {
-		if (cli_data->hid_sensor_hubs[i] == hid) {
-			cli_data->cur_hid_dev = i;
-			break;
-		}
-	}
-	amdtp_hid_wakeup(hid);
-}
-
-int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
-{
-	struct amdtp_hid_data *hid_data = hid->driver_data;
-	struct amdtp_cl_data *cli_data = hid_data->cli_data;
-	int i;
-
-	for (i = 0; i < cli_data->num_hid_devices; i++) {
-		if (cli_data->hid_sensor_hubs[i] == hid) {
-			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
-
-			if (!new)
-				return -ENOMEM;
-
-			new->current_index = i;
-			new->sensor_idx = cli_data->sensor_idx[i];
-			new->hid = hid;
-			new->report_type = report_type;
-			new->report_id = report_id;
-			cli_data->report_id[i] = report_id;
-			cli_data->request_done[i] = false;
-			list_add(&new->list, &req_list.list);
-			break;
-		}
-	}
-	schedule_delayed_work(&cli_data->work, 0);
-	return 0;
-}
-
-static void amd_sfh_work(struct work_struct *work)
-{
-	struct amdtp_cl_data *cli_data = container_of(work, struct amdtp_cl_data, work.work);
-	struct request_list *req_node;
-	u8 current_index, sensor_index;
-	u8 report_id, node_type;
-	u8 report_size = 0;
-
-	req_node = list_last_entry(&req_list.list, struct request_list, list);
-	list_del(&req_node->list);
-	current_index = req_node->current_index;
-	sensor_index = req_node->sensor_idx;
-	report_id = req_node->report_id;
-	node_type = req_node->report_type;
-
-	if (node_type == HID_FEATURE_REPORT) {
-		report_size = get_feature_report(sensor_index, report_id,
-						 cli_data->feature_report[current_index]);
-		if (report_size)
-			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
-					 cli_data->feature_report[current_index], report_size, 0);
-		else
-			pr_err("AMDSFH: Invalid report size\n");
-
-	} else if (node_type == HID_INPUT_REPORT) {
-		report_size = get_input_report(sensor_index, report_id,
-					       cli_data->input_report[current_index],
-					       cli_data->sensor_virt_addr[current_index]);
-		if (report_size)
-			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
-					 cli_data->input_report[current_index], report_size, 0);
-		else
-			pr_err("AMDSFH: Invalid report size\n");
-	}
-	cli_data->cur_hid_dev = current_index;
-	cli_data->sensor_requested_cnt[current_index] = 0;
-	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
-}
-
-static void amd_sfh_work_buffer(struct work_struct *work)
-{
-	struct amdtp_cl_data *cli_data = container_of(work, struct amdtp_cl_data, work_buffer.work);
-	u8 report_size;
-	int i;
-
-	for (i = 0; i < cli_data->num_hid_devices; i++) {
-		report_size = get_input_report(cli_data->sensor_idx[i], cli_data->report_id[i],
-					       cli_data->input_report[i],
-					       cli_data->sensor_virt_addr[i]);
-		hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
-				 cli_data->input_report[i], report_size, 0);
-	}
-	schedule_delayed_work(&cli_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
-}
-
-int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
-{
-	struct amdtp_cl_data *cl_data = privdata->cl_data;
-	struct amd_mp2_sensor_info info;
-	struct device *dev;
-	u32 feature_report_size;
-	u32 input_report_size;
-	u8 cl_idx;
-	int rc, i;
-
-	dev = &privdata->pdev->dev;
-	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
-	if (!cl_data)
-		return -ENOMEM;
-
-	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
-
-	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
-	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
-	INIT_LIST_HEAD(&req_list.list);
-
-	for (i = 0; i < cl_data->num_hid_devices; i++) {
-		cl_data->sensor_virt_addr[i] = dma_alloc_coherent(dev, sizeof(int) * 8,
-								  &cl_data->sensor_phys_addr[i],
-								  GFP_KERNEL);
-		cl_data->sensor_sts[i] = 0;
-		cl_data->sensor_requested_cnt[i] = 0;
-		cl_data->cur_hid_dev = i;
-		cl_idx = cl_data->sensor_idx[i];
-		cl_data->report_descr_sz[i] = get_descr_sz(cl_idx, descr_size);
-		if (!cl_data->report_descr_sz[i]) {
-			rc = -EINVAL;
-			goto cleanup;
-		}
-		feature_report_size = get_descr_sz(cl_idx, feature_size);
-		if (!feature_report_size) {
-			rc = -EINVAL;
-			goto cleanup;
-		}
-		input_report_size =  get_descr_sz(cl_idx, input_size);
-		if (!input_report_size) {
-			rc = -EINVAL;
-			goto cleanup;
-		}
-		cl_data->feature_report[i] = kzalloc(feature_report_size, GFP_KERNEL);
-		if (!cl_data->feature_report[i]) {
-			rc = -ENOMEM;
-			goto cleanup;
-		}
-		cl_data->input_report[i] = kzalloc(input_report_size, GFP_KERNEL);
-		if (!cl_data->input_report[i]) {
-			rc = -ENOMEM;
-			goto cleanup;
-		}
-		info.period = msecs_to_jiffies(AMD_SFH_IDLE_LOOP);
-		info.sensor_idx = cl_idx;
-		info.phys_address = cl_data->sensor_phys_addr[i];
-
-		cl_data->report_descr[i] = kzalloc(cl_data->report_descr_sz[i], GFP_KERNEL);
-		if (!cl_data->report_descr[i]) {
-			rc = -ENOMEM;
-			goto cleanup;
-		}
-		rc = get_report_descriptor(cl_idx, cl_data->report_descr[i]);
-		if (rc)
-			return rc;
-		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
-		if (rc)
-			return rc;
-		amd_start_sensor(privdata, info);
-		cl_data->sensor_sts[i] = 1;
-	}
-	privdata->cl_data = cl_data;
-	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
-	return 0;
-
-cleanup:
-	for (i = 0; i < cl_data->num_hid_devices; i++) {
-		if (cl_data->sensor_virt_addr[i]) {
-			dma_free_coherent(&privdata->pdev->dev, 8 * sizeof(int),
-					  cl_data->sensor_virt_addr[i],
-					  cl_data->sensor_phys_addr[i]);
-		}
-		kfree(cl_data->feature_report[i]);
-		kfree(cl_data->input_report[i]);
-		kfree(cl_data->report_descr[i]);
-	}
-	kfree(cl_data);
-	return rc;
-}
-
-int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata)
-{
-	struct amdtp_cl_data *cl_data = privdata->cl_data;
-	int i;
-
-	for (i = 0; i < cl_data->num_hid_devices; i++)
-		amd_stop_sensor(privdata, i);
-
-	cancel_delayed_work_sync(&cl_data->work);
-	cancel_delayed_work_sync(&cl_data->work_buffer);
-	amdtp_hid_remove(cl_data);
-
-	for (i = 0; i < cl_data->num_hid_devices; i++) {
-		if (cl_data->sensor_virt_addr[i]) {
-			dma_free_coherent(&privdata->pdev->dev, 8 * sizeof(int),
-					  cl_data->sensor_virt_addr[i],
-					  cl_data->sensor_phys_addr[i]);
-		}
-	}
-	kfree(cl_data);
-	return 0;
-}
-- 
2.30.0

From b00f73ed4307bcff428190fc3c1435a79cc8fb74 Mon Sep 17 00:00:00 2001
From: Richard Neumann <mail@richard-neumann.de>
Date: Mon, 4 Jan 2021 20:14:59 +0100
Subject: [PATCH 7/7] Updated PCIe driver.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 drivers/hid/amd-sfh-hid/amd-sfh-pci.c  | 241 +++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd-sfh-pci.h  | 113 ++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 152 ----------------
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h |  79 --------
 4 files changed, 354 insertions(+), 231 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-pci.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd-sfh-pci.h
 delete mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
 delete mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h

diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-pci.c b/drivers/hid/amd-sfh-hid/amd-sfh-pci.c
new file mode 100644
index 000000000000..87c28b1cdc68
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-pci.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * AMD Sensor Fusion Hub (SFH) PCIe driver
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
+ *          Richard Neumann <mail@richard-neumann.de>
+ */
+
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "amd-sfh-pci.h"
+
+/**
+ * amd_sfh_get_sensor_mask - Returns the sensors mask.
+ * @pci_dev:	The Sensor Fusion Hub PCI device
+ *
+ * Returns an integer representing the bitmask to match
+ * the sensors connected to the Sensor Fusion Hub.
+ */
+int amd_sfh_get_sensor_mask(struct pci_dev *pci_dev)
+{
+	int sensor_mask;
+	struct amd_sfh_dev *privdata = pci_get_drvdata(pci_dev);
+
+	sensor_mask = readl(privdata->mmio + AMD_P2C_MSG3);
+	/* Correct bit shift in firmware register */
+	sensor_mask = sensor_mask >> 4;
+
+	if (!sensor_mask)
+		pci_err(pci_dev, "[Firmware Bug]: No sensors marked active!\n");
+
+	return sensor_mask;
+}
+EXPORT_SYMBOL_GPL(amd_sfh_get_sensor_mask);
+
+/**
+ * amd_sfh_start_sensor- Starts the respective sensor.
+ * @pci_dev:	Sensor Fusion Hub PCI device
+ * @sensor_idx:	Sensor index
+ * @dma_handle:	DMA handle
+ * @interval:	Sensor poll interval
+ */
+void amd_sfh_start_sensor(struct pci_dev *pci_dev, enum sensor_idx sensor_idx,
+			  dma_addr_t dma_handle, unsigned int interval)
+{
+	struct amd_sfh_dev *privdata;
+	union amd_sfh_parm parm;
+	union amd_sfh_cmd cmd;
+
+	privdata = pci_get_drvdata(pci_dev);
+
+	cmd.ul = 0;
+	cmd.s.cmd_id = AMD_SFH_CMD_ENABLE_SENSOR;
+	cmd.s.interval = interval;
+	cmd.s.sensor_id = sensor_idx;
+
+	parm.ul = 0;
+	parm.s.buffer_layout = 1;
+	parm.s.buffer_length = 16;
+
+	writeq(dma_handle, privdata->mmio + AMD_C2P_MSG2);
+	writel(parm.ul, privdata->mmio + AMD_C2P_MSG1);
+	writel(cmd.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+EXPORT_SYMBOL_GPL(amd_sfh_start_sensor);
+
+/**
+ * amd_sfh_stop_sensor- Stops the respective sensor.
+ * @pci_dev:	Sensor Fusion Hub PCI device
+ * @sensor_idx:	Sensors index
+ */
+void amd_sfh_stop_sensor(struct pci_dev *pci_dev, enum sensor_idx sensor_idx)
+{
+	struct amd_sfh_dev *privdata;
+	union amd_sfh_parm parm;
+	union amd_sfh_cmd cmd;
+
+	privdata = pci_get_drvdata(pci_dev);
+
+	cmd.ul = 0;
+	cmd.s.cmd_id = AMD_SFH_CMD_DISABLE_SENSOR;
+	cmd.s.interval = 0;
+	cmd.s.sensor_id = sensor_idx;
+
+	parm.ul = 0;
+
+	writeq(0x0, privdata->mmio + AMD_C2P_MSG2);
+	writel(parm.ul, privdata->mmio + AMD_C2P_MSG1);
+	writel(cmd.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+EXPORT_SYMBOL_GPL(amd_sfh_stop_sensor);
+
+/**
+ * amd_sfh_pci_probed - Checks whether the PCI driver was probed successfully.
+ * @pci_dev:	Sensor Fusion Hub PCI device
+ */
+bool amd_sfh_pci_probed(struct pci_dev *pci_dev)
+{
+	struct amd_sfh_dev *privdata = pci_get_drvdata(pci_dev);
+
+	if (privdata)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(amd_sfh_pci_probed);
+
+/**
+ * amd_sfh_stop_all_sensors- Stops all sensors on the SFH.
+ * @pci_dev:	Sensor Fusion Hub PCI device
+ */
+static void amd_sfh_stop_all_sensors(struct pci_dev *pci_dev)
+{
+	struct amd_sfh_dev *privdata;
+	union amd_sfh_parm parm;
+	union amd_sfh_cmd cmd;
+
+	privdata = pci_get_drvdata(pci_dev);
+
+	cmd.ul = 0;
+	cmd.s.cmd_id = AMD_SFH_CMD_STOP_ALL_SENSORS;
+	cmd.s.interval = 0;
+	cmd.s.sensor_id = 0;
+
+	parm.ul = 0;
+
+	writel(parm.ul, privdata->mmio + AMD_C2P_MSG1);
+	writel(cmd.ul, privdata->mmio + AMD_C2P_MSG0);
+}
+
+/**
+ * amd_sfh_clear_registers - Clears the C2P and P2C registers.
+ * @privdata:	PCI driver data
+ */
+static void amd_sfh_clear_registers(struct amd_sfh_dev *privdata)
+{
+	unsigned int reg;
+
+	/* Clear C2P registers */
+	for (reg = AMD_C2P_MSG0; reg <= AMD_C2P_MSG9; reg += 4)
+		writel(0, privdata->mmio + reg);
+
+	/* Clear P2C registers */
+	for (reg = AMD_P2C_MSG0; reg <= AMD_P2C_MSG2; reg += 4)
+		writel(0, privdata->mmio + reg);
+}
+
+/**
+ * amd_sfh_pci_init - Initializes the PCI device.
+ * @privdata:	PCI driver data
+ * @pci_dev:	PCI device
+ *
+ * Enables the PCI device and performs I/O mapping.
+ * Returns 0 on success or nonzero on errors.
+ */
+static int amd_sfh_pci_init(struct amd_sfh_dev *privdata,
+			    struct pci_dev *pci_dev)
+{
+	int rc;
+
+	rc = pcim_enable_device(pci_dev);
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pci_dev, BIT(2), pci_name(pci_dev));
+	if (rc)
+		return rc;
+
+	privdata->pci_dev = pci_dev;
+	privdata->mmio = pcim_iomap_table(pci_dev)[2];
+	pci_set_master(pci_dev);
+
+	rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	pci_set_drvdata(pci_dev, privdata);
+	pci_info(pci_dev, "AMD SFH device initialized\n");
+
+	return 0;
+}
+
+/**
+ * amd_sfh_pci_probe - Probes the PCI device driver.
+ * @pci_dev:	The handled PCI device
+ * @id:		PCI device ID
+ *
+ * Returns 0 on success or nonzero on errors.
+ */
+static int amd_sfh_pci_probe(struct pci_dev *pci_dev,
+			     const struct pci_device_id *id)
+{
+	struct amd_sfh_dev *privdata;
+
+	privdata = devm_kzalloc(&pci_dev->dev, sizeof(*privdata), GFP_KERNEL);
+	if (!privdata)
+		return -ENOMEM;
+
+	return amd_sfh_pci_init(privdata, pci_dev);
+}
+
+/**
+ * amd_sfh_pci_remove - Unloads the PCI device driver.
+ * @pci_dev:	The PCI device
+ */
+static void amd_sfh_pci_remove(struct pci_dev *pci_dev)
+{
+	struct amd_sfh_dev *privdata = pci_get_drvdata(pci_dev);
+
+	amd_sfh_stop_all_sensors(privdata->pci_dev);
+	pci_clear_master(pci_dev);
+	amd_sfh_clear_registers(privdata);
+}
+
+static const struct pci_device_id amd_sfh_pci_tbl[] = {
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_SFH) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, amd_sfh_pci_tbl);
+
+static struct pci_driver amd_sfh_pci_driver = {
+	.name		= "amd-sfh-pci",
+	.id_table	= amd_sfh_pci_tbl,
+	.probe		= amd_sfh_pci_probe,
+	.remove		= amd_sfh_pci_remove,
+};
+module_pci_driver(amd_sfh_pci_driver);
+
+MODULE_DESCRIPTION("AMD(R) Sensor Fusion Hub PCI driver");
+MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>");
+MODULE_AUTHOR("Richard Neumann <mail@richard-neumann.de>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/hid/amd-sfh-hid/amd-sfh-pci.h b/drivers/hid/amd-sfh-hid/amd-sfh-pci.h
new file mode 100644
index 000000000000..f157e87b38c4
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd-sfh-pci.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ *  AMD Sensor Fusion Hub PCIe driver interface
+ *
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *           Richard Neumann <mail@richard-neumann.de>
+ */
+
+#ifndef AMD_SFH_PCI_H
+#define AMD_SFH_PCI_H
+
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#define PCI_DEVICE_ID_AMD_SFH	0x15E4
+
+/**
+ * Sensor Fusion Hub communication registers
+ */
+enum {
+	/* SFH C2P Message Registers */
+	AMD_C2P_MSG0 = 0x10500,		/* SFH command register */
+	AMD_C2P_MSG1 = 0x10504,		/* SFH parameter register */
+	AMD_C2P_MSG2 = 0x10508,		/* DRAM Address Lo / Data 0 */
+	AMD_C2P_MSG3 = 0x1050c,		/* DRAM Address HI / Data 1 */
+	AMD_C2P_MSG4 = 0x10510,		/* Data 2 */
+	AMD_C2P_MSG5 = 0x10514,		/* Data 3 */
+	AMD_C2P_MSG6 = 0x10518,		/* Data 4 */
+	AMD_C2P_MSG7 = 0x1051c,		/* Data 5 */
+	AMD_C2P_MSG8 = 0x10520,		/* Data 6 */
+	AMD_C2P_MSG9 = 0x10524,		/* Data 7 */
+
+	/* SFH P2C Message Registers */
+	AMD_P2C_MSG0 = 0x10680,		/* Do not use */
+	AMD_P2C_MSG1 = 0x10684,		/* I2C0 interrupt register */
+	AMD_P2C_MSG2 = 0x10688,		/* I2C1 interrupt register */
+	AMD_P2C_MSG3 = 0x1068C,		/* SFH sensor info */
+	AMD_P2C_MSG_INTEN = 0x10690,	/* SFH interrupt gen register */
+	AMD_P2C_MSG_INTSTS = 0x10694,	/* Interrupt status */
+};
+
+/**
+ * The sensor indices on the AMD SFH device
+ * @ACCEL_IDX:	Index of the accelerometer
+ * @GYRO_IDX:	Index of the gyroscope
+ * @MAG_IDX:	Index of the magnetometer
+ * @ALS_IDX:	Index of the ambient light sensor
+ */
+enum sensor_idx {
+	ACCEL_IDX = 0,
+	GYRO_IDX,
+	MAG_IDX,
+	ALS_IDX = 19,
+};
+
+/**
+ * SFH command IDs
+ */
+enum {
+	AMD_SFH_CMD_NOOP = 0,
+	AMD_SFH_CMD_ENABLE_SENSOR,
+	AMD_SFH_CMD_DISABLE_SENSOR,
+	AMD_SFH_CMD_DUMP_SENSOR_INFO,
+	AMD_SFH_CMD_NUMBER_OF_SENSORS_DISCOVERED,
+	AMD_SFH_CMD_WHOAMI_REGCHIPID,
+	AMD_SFH_CMD_SET_DCD_DATA,
+	AMD_SFH_CMD_GET_DCD_DATA,
+	AMD_SFH_CMD_STOP_ALL_SENSORS,
+	AMD_SFH_CMD_INVALID = 0xF,
+};
+
+/**
+ * SFH command registers
+ */
+union amd_sfh_cmd {
+	u32 ul;
+	struct {
+		u32 cmd_id : 8;
+		u32 sensor_id : 8;
+		u32 interval : 16;
+	} s;
+};
+
+/**
+ * SFH command parameters
+ */
+union amd_sfh_parm {
+	u32 ul;
+	struct {
+		u32 buffer_layout : 2;
+		u32 buffer_length : 6;
+		u32 rsvd : 24;
+	} s;
+};
+
+/**
+ * struct amd_sfh_dev - AMD SFH PCI device data
+ * @pci_dev:		Handled PCI device
+ * @mmio:		iommapped registers
+ */
+struct amd_sfh_dev {
+	struct pci_dev *pci_dev;
+	void __iomem *mmio;
+};
+
+/* SFH PCI driver interface functions */
+int amd_sfh_get_sensor_mask(struct pci_dev *pci_dev);
+void amd_sfh_start_sensor(struct pci_dev *pci_dev, enum sensor_idx sensor_idx,
+			  dma_addr_t dma_handle, unsigned int interval);
+void amd_sfh_stop_sensor(struct pci_dev *pci_dev, enum sensor_idx sensor_idx);
+bool amd_sfh_pci_probed(struct pci_dev *pci_dev);
+
+#endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
deleted file mode 100644
index a51c7b76283b..000000000000
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * AMD MP2 PCIe communication driver
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
- *	    Sandeep Singh <Sandeep.singh@amd.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include "amd_sfh_pcie.h"
-
-#define DRIVER_NAME	"pcie_mp2_amd"
-#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Driver"
-
-#define ACEL_EN		BIT(0)
-#define GYRO_EN		BIT(1)
-#define MAGNO_EN		BIT(2)
-#define ALS_EN		BIT(19)
-
-void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info)
-{
-	union sfh_cmd_param cmd_param;
-	union sfh_cmd_base cmd_base;
-
-	/* fill up command register */
-	memset(&cmd_base, 0, sizeof(cmd_base));
-	cmd_base.s.cmd_id = ENABLE_SENSOR;
-	cmd_base.s.period = info.period;
-	cmd_base.s.sensor_id = info.sensor_idx;
-
-	/* fill up command param register */
-	memset(&cmd_param, 0, sizeof(cmd_param));
-	cmd_param.s.buf_layout = 1;
-	cmd_param.s.buf_length = 16;
-
-	writeq(info.phys_address, privdata->mmio + AMD_C2P_MSG2);
-	writel(cmd_param.ul, privdata->mmio + AMD_C2P_MSG1);
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
-}
-
-void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
-{
-	union sfh_cmd_base cmd_base;
-
-	/* fill up command register */
-	memset(&cmd_base, 0, sizeof(cmd_base));
-	cmd_base.s.cmd_id = DISABLE_SENSOR;
-	cmd_base.s.period = 0;
-	cmd_base.s.sensor_id = sensor_idx;
-
-	writeq(0x0, privdata->mmio + AMD_C2P_MSG2);
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
-}
-
-void amd_stop_all_sensors(struct amd_mp2_dev *privdata)
-{
-	union sfh_cmd_base cmd_base;
-
-	/* fill up command register */
-	memset(&cmd_base, 0, sizeof(cmd_base));
-	cmd_base.s.cmd_id = STOP_ALL_SENSORS;
-	cmd_base.s.period = 0;
-	cmd_base.s.sensor_id = 0;
-
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
-}
-
-int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
-{
-	int activestatus, num_of_sensors = 0;
-
-	privdata->activecontrolstatus = readl(privdata->mmio + AMD_P2C_MSG3);
-	activestatus = privdata->activecontrolstatus >> 4;
-	if (ACEL_EN  & activestatus)
-		sensor_id[num_of_sensors++] = accel_idx;
-
-	if (GYRO_EN & activestatus)
-		sensor_id[num_of_sensors++] = gyro_idx;
-
-	if (MAGNO_EN & activestatus)
-		sensor_id[num_of_sensors++] = mag_idx;
-
-	if (ALS_EN & activestatus)
-		sensor_id[num_of_sensors++] = als_idx;
-
-	return num_of_sensors;
-}
-
-static void amd_mp2_pci_remove(void *privdata)
-{
-	amd_sfh_hid_client_deinit(privdata);
-	amd_stop_all_sensors(privdata);
-}
-
-static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	struct amd_mp2_dev *privdata;
-	int rc;
-
-	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
-	if (!privdata)
-		return -ENOMEM;
-
-	privdata->pdev = pdev;
-	pci_set_drvdata(pdev, privdata);
-	rc = pcim_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
-	if (rc)
-		return rc;
-
-	privdata->mmio = pcim_iomap_table(pdev)[2];
-	pci_set_master(pdev);
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (rc) {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		return rc;
-	}
-	rc = devm_add_action_or_reset(&pdev->dev, amd_mp2_pci_remove, privdata);
-	if (rc)
-		return rc;
-
-	return amd_sfh_hid_client_init(privdata);
-}
-
-static const struct pci_device_id amd_mp2_pci_tbl[] = {
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
-	{ }
-};
-MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
-
-static struct pci_driver amd_mp2_pci_driver = {
-	.name		= DRIVER_NAME,
-	.id_table	= amd_mp2_pci_tbl,
-	.probe		= amd_mp2_pci_probe,
-};
-module_pci_driver(amd_mp2_pci_driver);
-
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
-MODULE_AUTHOR("Sandeep Singh <Sandeep.singh@amd.com>");
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
deleted file mode 100644
index e8be94f935b7..000000000000
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * AMD MP2 PCIe communication driver
- * Copyright 2020 Advanced Micro Devices, Inc.
- * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
- *	    Sandeep Singh <Sandeep.singh@amd.com>
- */
-
-#ifndef PCIE_MP2_AMD_H
-#define PCIE_MP2_AMD_H
-
-#include <linux/pci.h>
-
-#define PCI_DEVICE_ID_AMD_MP2	0x15E4
-
-#define ENABLE_SENSOR		1
-#define DISABLE_SENSOR		2
-#define STOP_ALL_SENSORS	8
-
-/* MP2 C2P Message Registers */
-#define AMD_C2P_MSG0	0x10500
-#define AMD_C2P_MSG1	0x10504
-#define AMD_C2P_MSG2	0x10508
-
-/* MP2 P2C Message Registers */
-#define AMD_P2C_MSG3	0x1068C /* Supported Sensors info */
-
-/* SFH Command register */
-union sfh_cmd_base {
-	u32 ul;
-	struct {
-		u32 cmd_id : 8;
-		u32 sensor_id : 8;
-		u32 period : 16;
-	} s;
-};
-
-union sfh_cmd_param {
-	u32 ul;
-	struct {
-		u32 buf_layout : 2;
-		u32 buf_length : 6;
-		u32 rsvd : 24;
-	} s;
-};
-
-struct sfh_cmd_reg {
-	union sfh_cmd_base cmd_base;
-	union sfh_cmd_param cmd_param;
-	phys_addr_t phys_addr;
-};
-
-enum sensor_idx {
-	accel_idx = 0,
-	gyro_idx = 1,
-	mag_idx = 2,
-	als_idx = 19
-};
-
-struct amd_mp2_dev {
-	struct pci_dev *pdev;
-	struct amdtp_cl_data *cl_data;
-	void __iomem *mmio;
-	u32 activecontrolstatus;
-};
-
-struct amd_mp2_sensor_info {
-	u8 sensor_idx;
-	u32 period;
-	phys_addr_t phys_address;
-};
-
-void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor_info info);
-void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx);
-void amd_stop_all_sensors(struct amd_mp2_dev *privdata);
-int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id);
-int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata);
-int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata);
-#endif
-- 
2.30.0


