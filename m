Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD159ABB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfF1MWl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 08:22:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1MUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 08:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TYXavV4uV+2PkrssmO4e1C10Nnd6/hTtqn1eNk3HPB8=; b=mlHgSiuVphsmfRAXxiwX8/MGSj
        6tjWIomFNDK182dr2srjO5iQe6jGrl1qqs87VH+R9cp9DfEsQHYPohQwc6Q3lAvH4HU1HiK30x3XM
        gwdtotIr41lwf1wC4ljl6mfpUMA/RGpVLEUqRs5TSdXPRKLMD/ZJL3RqRR54hVZ7OeDfoNUM/vZ2v
        vC4sNrnm/qvR1g5G9iFnQ/gHOTTQNzWWrSpDwSa8PGU45YZ0lylwNgZUo6sxyd+t6hj+nBWUSBqE8
        q+lbMxm1Plffz72mkpocKaPjWr4fT3V0LO/kCJO0+2b9RFeRa58cIkk29ob4Na5clEBFXY302lzP6
        L8HHQV9g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009q-0R; Fri, 28 Jun 2019 12:20:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-000572-2G; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 03/43] docs: hid: convert to ReST
Date:   Fri, 28 Jun 2019 09:19:59 -0300
Message-Id: <3ab0197cc24088ef25b627f14571936f62287452.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rename the HID documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

While here, fix the sysfs example from hid-sensor.txt, that
has a lot of "?" instead of the proper UTF-8 characters that
are produced by the tree command.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 .../hid/{hid-alps.txt => hid-alps.rst}        |  85 ++-
 .../hid/{hid-sensor.txt => hid-sensor.rst}    | 192 +++----
 .../{hid-transport.txt => hid-transport.rst}  |  82 ++-
 Documentation/hid/{hiddev.txt => hiddev.rst}  | 154 ++++--
 Documentation/hid/{hidraw.txt => hidraw.rst}  |  53 +-
 Documentation/hid/index.rst                   |  18 +
 Documentation/hid/intel-ish-hid.rst           | 485 ++++++++++++++++++
 Documentation/hid/intel-ish-hid.txt           | 454 ----------------
 Documentation/hid/{uhid.txt => uhid.rst}      |  46 +-
 Documentation/input/input.rst                 |   2 +-
 MAINTAINERS                                   |   2 +-
 11 files changed, 897 insertions(+), 676 deletions(-)
 rename Documentation/hid/{hid-alps.txt => hid-alps.rst} (64%)
 rename Documentation/hid/{hid-sensor.txt => hid-sensor.rst} (61%)
 rename Documentation/hid/{hid-transport.txt => hid-transport.rst} (93%)
 rename Documentation/hid/{hiddev.txt => hiddev.rst} (77%)
 rename Documentation/hid/{hidraw.txt => hidraw.rst} (89%)
 create mode 100644 Documentation/hid/index.rst
 create mode 100644 Documentation/hid/intel-ish-hid.rst
 delete mode 100644 Documentation/hid/intel-ish-hid.txt
 rename Documentation/hid/{uhid.txt => uhid.rst} (94%)

diff --git a/Documentation/hid/hid-alps.txt b/Documentation/hid/hid-alps.rst
similarity index 64%
rename from Documentation/hid/hid-alps.txt
rename to Documentation/hid/hid-alps.rst
index 6b02a2447c77..e2f4c4c11e3f 100644
--- a/Documentation/hid/hid-alps.txt
+++ b/Documentation/hid/hid-alps.rst
@@ -1,19 +1,26 @@
+==========================
 ALPS HID Touchpad Protocol
-----------------------
+==========================
 
 Introduction
 ------------
 Currently ALPS HID driver supports U1 Touchpad device.
 
-U1 devuce basic information.
+U1 device basic information.
+
+==========	======
 Vender ID	0x044E
 Product ID	0x120B
 Version ID	0x0121
+==========	======
 
 
 HID Descriptor
-------------
+--------------
+
+=======	====================	=====	=======================================
 Byte	Field			Value	Notes
+=======	====================	=====	=======================================
 0	wHIDDescLength		001E	Length of HID Descriptor : 30 bytes
 2	bcdVersion		0100	Compliant with Version 1.00
 4	wReportDescLength	00B2	Report Descriptor is 178 Bytes (0x00B2)
@@ -28,32 +35,42 @@ Byte	Field			Value	Notes
 22	wProductID		120B	Product ID 0x120B
 24	wVersionID		0121	Version 01.21
 26	RESERVED		0000	RESERVED
+=======	====================	=====	=======================================
 
 
 Report ID
-------------
-ReportID-1	(Input Reports)	(HIDUsage-Mouse) for TP&SP
-ReportID-2	(Input Reports)	(HIDUsage-keyboard) for TP
-ReportID-3	(Input Reports)	(Vendor Usage: Max 10 finger data) for TP
-ReportID-4	(Input Reports)	(Vendor Usage: ON bit data) for GP
-ReportID-5	(Feature Reports)	Feature Reports
-ReportID-6	(Input Reports)	(Vendor Usage: StickPointer data) for SP
-ReportID-7	(Feature Reports)	Flash update (Bootloader)
+---------
+
+==========	=================  =========================================
+ReportID-1	(Input Reports)	   (HIDUsage-Mouse) for TP&SP
+ReportID-2	(Input Reports)	   (HIDUsage-keyboard) for TP
+ReportID-3	(Input Reports)	   (Vendor Usage: Max 10 finger data) for TP
+ReportID-4	(Input Reports)	   (Vendor Usage: ON bit data) for GP
+ReportID-5	(Feature Reports)  Feature Reports
+ReportID-6	(Input Reports)	   (Vendor Usage: StickPointer data) for SP
+ReportID-7	(Feature Reports)  Flash update (Bootloader)
+==========	=================  =========================================
 
 
 Data pattern
 ------------
+
+=====	==========	=====	=================
 Case1	ReportID_1	TP/SP	Relative/Relative
 Case2	ReportID_3	TP	Absolute
 	ReportID_6	SP	Absolute
+=====	==========	=====	=================
 
 
 Command Read/Write
 ------------------
 To read/write to RAM, need to send a commands to the device.
+
 The command format is as below.
 
 DataByte(SET_REPORT)
+
+=====	======================
 Byte1	Command Byte
 Byte2	Address - Byte 0 (LSB)
 Byte3	Address - Byte 1
@@ -61,13 +78,19 @@ Byte4	Address - Byte 2
 Byte5	Address - Byte 3 (MSB)
 Byte6	Value Byte
 Byte7	Checksum
+=====	======================
 
 Command Byte is read=0xD1/write=0xD2 .
+
 Address is read/write RAM address.
+
 Value Byte is writing data when you send the write commands.
+
 When you read RAM, there is no meaning.
 
 DataByte(GET_REPORT)
+
+=====	======================
 Byte1	Response Byte
 Byte2	Address - Byte 0 (LSB)
 Byte3	Address - Byte 1
@@ -75,6 +98,7 @@ Byte4	Address - Byte 2
 Byte5	Address - Byte 3 (MSB)
 Byte6	Value Byte
 Byte7	Checksum
+=====	======================
 
 Read value is stored in Value Byte.
 
@@ -82,7 +106,11 @@ Read value is stored in Value Byte.
 Packet Format
 Touchpad data byte
 ------------------
-	b7	b6	b5	b4	b3	b2	b1	b0
+
+
+======= ======= ======= ======= ======= ======= ======= ======= =====
+-	b7	b6	b5	b4	b3	b2	b1	b0
+======= ======= ======= ======= ======= ======= ======= ======= =====
 1	0	0	SW6	SW5	SW4	SW3	SW2	SW1
 2	0	0	0	Fcv	Fn3	Fn2	Fn1	Fn0
 3	Xa0_7	Xa0_6	Xa0_5	Xa0_4	Xa0_3	Xa0_2	Xa0_1	Xa0_0
@@ -114,17 +142,25 @@ Touchpad data byte
 25	Ya4_7	Ya4_6	Ya4_5	Ya4_4	Ya4_3	Ya4_2	Ya4_1	Ya4_0
 26	Ya4_15	Ya4_14	Ya4_13	Ya4_12	Ya4_11	Ya4_10	Ya4_9	Ya4_8
 27	LFB4	Zs4_6	Zs4_5	Zs4_4	Zs4_3	Zs4_2	Zs4_1	Zs4_0
+======= ======= ======= ======= ======= ======= ======= ======= =====
 
 
-SW1-SW6:	SW ON/OFF status
-Xan_15-0(16bit):X Absolute data of the "n"th finger
-Yan_15-0(16bit):Y Absolute data of the "n"th finger
-Zsn_6-0(7bit):	Operation area of the "n"th finger
+SW1-SW6:
+	SW ON/OFF status
+Xan_15-0(16bit):
+	X Absolute data of the "n"th finger
+Yan_15-0(16bit):
+	Y Absolute data of the "n"th finger
+Zsn_6-0(7bit):
+	Operation area of the "n"th finger
 
 
 StickPointer data byte
-------------------
-	b7	b6	b5	b4	b3	b2	b1	b0
+----------------------
+
+======= ======= ======= ======= ======= ======= ======= ======= =====
+-	b7	b6	b5	b4	b3	b2	b1	b0
+======= ======= ======= ======= ======= ======= ======= ======= =====
 Byte1	1	1	1	0	1	SW3	SW2	SW1
 Byte2	X7	X6	X5	X4	X3	X2	X1	X0
 Byte3	X15	X14	X13	X12	X11	X10	X9	X8
@@ -132,8 +168,13 @@ Byte4	Y7	Y6	Y5	Y4	Y3	Y2	Y1	Y0
 Byte5	Y15	Y14	Y13	Y12	Y11	Y10	Y9	Y8
 Byte6	Z7	Z6	Z5	Z4	Z3	Z2	Z1	Z0
 Byte7	T&P	Z14	Z13	Z12	Z11	Z10	Z9	Z8
+======= ======= ======= ======= ======= ======= ======= ======= =====
 
-SW1-SW3:	SW ON/OFF status
-Xn_15-0(16bit):X Absolute data
-Yn_15-0(16bit):Y Absolute data
-Zn_14-0(15bit):Z
+SW1-SW3:
+	SW ON/OFF status
+Xn_15-0(16bit):
+	X Absolute data
+Yn_15-0(16bit):
+	Y Absolute data
+Zn_14-0(15bit):
+	Z
diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid-sensor.rst
similarity index 61%
rename from Documentation/hid/hid-sensor.txt
rename to Documentation/hid/hid-sensor.rst
index b287752a31cd..758972e34971 100644
--- a/Documentation/hid/hid-sensor.txt
+++ b/Documentation/hid/hid-sensor.rst
@@ -1,6 +1,6 @@
-
+=====================
 HID Sensors Framework
-======================
+=====================
 HID sensor framework provides necessary interfaces to implement sensor drivers,
 which are connected to a sensor hub. The sensor hub is a HID device and it provides
 a report descriptor conforming to HID 1.12 sensor usage tables.
@@ -15,22 +15,22 @@ the drivers themselves."
 This specification describes many usage IDs, which describe the type of sensor
 and also the individual data fields. Each sensor can have variable number of
 data fields. The length and order is specified in the report descriptor. For
-example a part of report descriptor can look like:
+example a part of report descriptor can look like::
 
-   INPUT(1)[INPUT]
- ..
-    Field(2)
-      Physical(0020.0073)
-      Usage(1)
-        0020.045f
-      Logical Minimum(-32767)
-      Logical Maximum(32767)
-      Report Size(8)
-      Report Count(1)
-      Report Offset(16)
-      Flags(Variable Absolute)
-..
-..
+     INPUT(1)[INPUT]
+   ..
+      Field(2)
+        Physical(0020.0073)
+        Usage(1)
+          0020.045f
+        Logical Minimum(-32767)
+        Logical Maximum(32767)
+        Report Size(8)
+        Report Count(1)
+        Report Offset(16)
+        Flags(Variable Absolute)
+  ..
+  ..
 
 The report is indicating "sensor page (0x20)" contains an accelerometer-3D (0x73).
 This accelerometer-3D has some fields. Here for example field 2 is motion intensity
@@ -40,13 +40,14 @@ data will use this format.
 
 
 Implementation
-=================
+==============
 
 This specification defines many different types of sensors with different sets of
 data fields. It is difficult to have a common input event to user space applications,
 for different sensors. For example an accelerometer can send X,Y and Z data, whereas
 an ambient light sensor can send illumination data.
 So the implementation has two parts:
+
 - Core hid driver
 - Individual sensor processing part (sensor drivers)
 
@@ -55,8 +56,11 @@ Core driver
 The core driver registers (hid-sensor-hub) registers as a HID driver. It parses
 report descriptors and identifies all the sensors present. It adds an MFD device
 with name HID-SENSOR-xxxx (where xxxx is usage id from the specification).
-For example
+
+For example:
+
 HID-SENSOR-200073 is registered for an Accelerometer 3D driver.
+
 So if any driver with this name is inserted, then the probe routine for that
 function will be called. So an accelerometer processing driver can register
 with this name and will be probed if there is an accelerometer-3D detected.
@@ -66,7 +70,8 @@ drivers to register and get events for that usage id. Also it provides parsing
 functions, which get and set each input/feature/output report.
 
 Individual sensor processing part (sensor drivers)
------------
+--------------------------------------------------
+
 The processing driver will use an interface provided by the core driver to parse
 the report and get the indexes of the fields and also can get events. This driver
 can use IIO interface to use the standard ABI defined for a type of sensor.
@@ -75,31 +80,34 @@ can use IIO interface to use the standard ABI defined for a type of sensor.
 Core driver Interface
 =====================
 
-Callback structure:
-Each processing driver can use this structure to set some callbacks.
+Callback structure::
+
+  Each processing driver can use this structure to set some callbacks.
 	int (*suspend)(..): Callback when HID suspend is received
 	int (*resume)(..): Callback when HID resume is received
 	int (*capture_sample)(..): Capture a sample for one of its data fields
 	int (*send_event)(..): One complete event is received which can have
                                multiple data fields.
 
-Registration functions:
-int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
+Registration functions::
+
+  int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id,
 			struct hid_sensor_hub_callbacks *usage_callback):
 
 Registers callbacks for an usage id. The callback functions are not allowed
-to sleep.
+to sleep::
 
 
-int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
+  int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id):
 
 Removes callbacks for an usage id.
 
 
-Parsing function:
-int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
+Parsing function::
+
+  int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 			u8 type,
 			u32 usage_id, u32 attr_usage_id,
 			struct hid_sensor_hub_attribute_info *info);
@@ -110,26 +118,27 @@ so that fields can be set or get individually.
 These indexes avoid searching every time and getting field index to get or set.
 
 
-Set Feature report
-int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
+Set Feature report::
+
+  int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 			u32 field_index, s32 value);
 
 This interface is used to set a value for a field in feature report. For example
 if there is a field report_interval, which is parsed by a call to
-sensor_hub_input_get_attribute_info before, then it can directly set that individual
-field.
+sensor_hub_input_get_attribute_info before, then it can directly set that
+individual field::
 
 
-int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
+  int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 			u32 field_index, s32 *value);
 
 This interface is used to get a value for a field in input report. For example
 if there is a field report_interval, which is parsed by a call to
-sensor_hub_input_get_attribute_info before, then it can directly get that individual
-field value.
+sensor_hub_input_get_attribute_info before, then it can directly get that
+individual field value::
 
 
-int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
+  int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id,
 			u32 attr_usage_id, u32 report_id);
 
@@ -143,6 +152,8 @@ registered callback function to process the sample.
 ----------
 
 HID Custom and generic Sensors
+------------------------------
+
 
 HID Sensor specification defines two special sensor usage types. Since they
 don't represent a standard sensor, it is not possible to define using Linux IIO
@@ -158,66 +169,73 @@ keyboard attached/detached or lid open/close.
 To allow application to utilize these sensors, here they are exported uses sysfs
 attribute groups, attributes and misc device interface.
 
-An example of this representation on sysfs:
-/sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA.0001/HID-SENSOR-2000e1.6.auto$ tree -R
-.
-????????? enable_sensor
-????????? feature-0-200316
-??????? ????????? feature-0-200316-maximum
-??????? ????????? feature-0-200316-minimum
-??????? ????????? feature-0-200316-name
-??????? ????????? feature-0-200316-size
-??????? ????????? feature-0-200316-unit-expo
-??????? ????????? feature-0-200316-units
-??????? ????????? feature-0-200316-value
-????????? feature-1-200201
-??????? ????????? feature-1-200201-maximum
-??????? ????????? feature-1-200201-minimum
-??????? ????????? feature-1-200201-name
-??????? ????????? feature-1-200201-size
-??????? ????????? feature-1-200201-unit-expo
-??????? ????????? feature-1-200201-units
-??????? ????????? feature-1-200201-value
-????????? input-0-200201
-??????? ????????? input-0-200201-maximum
-??????? ????????? input-0-200201-minimum
-??????? ????????? input-0-200201-name
-??????? ????????? input-0-200201-size
-??????? ????????? input-0-200201-unit-expo
-??????? ????????? input-0-200201-units
-??????? ????????? input-0-200201-value
-????????? input-1-200202
-??????? ????????? input-1-200202-maximum
-??????? ????????? input-1-200202-minimum
-??????? ????????? input-1-200202-name
-??????? ????????? input-1-200202-size
-??????? ????????? input-1-200202-unit-expo
-??????? ????????? input-1-200202-units
-??????? ????????? input-1-200202-value
+An example of this representation on sysfs::
+
+  /sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA.0001/HID-SENSOR-2000e1.6.auto$ tree -R
+  .
+  │   ├──  enable_sensor
+  │   │   ├── feature-0-200316
+  │   │   │   ├── feature-0-200316-maximum
+  │   │   │   ├── feature-0-200316-minimum
+  │   │   │   ├── feature-0-200316-name
+  │   │   │   ├── feature-0-200316-size
+  │   │   │   ├── feature-0-200316-unit-expo
+  │   │   │   ├── feature-0-200316-units
+  │   │   │   ├── feature-0-200316-value
+  │   │   ├── feature-1-200201
+  │   │   │   ├── feature-1-200201-maximum
+  │   │   │   ├── feature-1-200201-minimum
+  │   │   │   ├── feature-1-200201-name
+  │   │   │   ├── feature-1-200201-size
+  │   │   │   ├── feature-1-200201-unit-expo
+  │   │   │   ├── feature-1-200201-units
+  │   │   │   ├── feature-1-200201-value
+  │   │   ├── input-0-200201
+  │   │   │   ├── input-0-200201-maximum
+  │   │   │   ├── input-0-200201-minimum
+  │   │   │   ├── input-0-200201-name
+  │   │   │   ├── input-0-200201-size
+  │   │   │   ├── input-0-200201-unit-expo
+  │   │   │   ├── input-0-200201-units
+  │   │   │   ├── input-0-200201-value
+  │   │   ├── input-1-200202
+  │   │   │   ├── input-1-200202-maximum
+  │   │   │   ├── input-1-200202-minimum
+  │   │   │   ├── input-1-200202-name
+  │   │   │   ├── input-1-200202-size
+  │   │   │   ├── input-1-200202-unit-expo
+  │   │   │   ├── input-1-200202-units
+  │   │   │   ├── input-1-200202-value
 
 Here there is a custom sensors with four fields, two feature and two inputs.
 Each field is represented by a set of attributes. All fields except the "value"
 are read only. The value field is a RW field.
-Example
-/sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$ grep -r . *
-feature-0-200316-maximum:6
-feature-0-200316-minimum:0
-feature-0-200316-name:property-reporting-state
-feature-0-200316-size:1
-feature-0-200316-unit-expo:0
-feature-0-200316-units:25
-feature-0-200316-value:1
+
+Example::
+
+  /sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$ grep -r . *
+  feature-0-200316-maximum:6
+  feature-0-200316-minimum:0
+  feature-0-200316-name:property-reporting-state
+  feature-0-200316-size:1
+  feature-0-200316-unit-expo:0
+  feature-0-200316-units:25
+  feature-0-200316-value:1
 
 How to enable such sensor?
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 By default sensor can be power gated. To enable sysfs attribute "enable" can be
-used.
-$ echo 1 > enable_sensor
+used::
+
+	$ echo 1 > enable_sensor
 
 Once enabled and powered on, sensor can report value using HID reports.
-These reports are pushed using misc device interface in a FIFO order.
-/dev$ tree | grep HID-SENSOR-2000e1.6.auto
-??????? ????????? 10:53 -> ../HID-SENSOR-2000e1.6.auto
-????????? HID-SENSOR-2000e1.6.auto
+These reports are pushed using misc device interface in a FIFO order::
+
+	/dev$ tree | grep HID-SENSOR-2000e1.6.auto
+	│   │   │   ├── 10:53 -> ../HID-SENSOR-2000e1.6.auto
+	│   ├──  HID-SENSOR-2000e1.6.auto
 
 Each reports can be of variable length preceded by a header. This header
 consist of a 32 bit usage id, 64 bit time stamp and 32 bit length field of raw
diff --git a/Documentation/hid/hid-transport.txt b/Documentation/hid/hid-transport.rst
similarity index 93%
rename from Documentation/hid/hid-transport.txt
rename to Documentation/hid/hid-transport.rst
index 4f41d67f1b4b..0fe526f36db6 100644
--- a/Documentation/hid/hid-transport.txt
+++ b/Documentation/hid/hid-transport.rst
@@ -1,5 +1,6 @@
-                          HID I/O Transport Drivers
-                         ===========================
+=========================
+HID I/O Transport Drivers
+=========================
 
 The HID subsystem is independent of the underlying transport driver. Initially,
 only USB was supported, but other specifications adopted the HID design and
@@ -16,6 +17,8 @@ transport and device setup/management. HID core is responsible of
 report-parsing, report interpretation and the user-space API. Device specifics
 and quirks are handled by all layers depending on the quirk.
 
+::
+
  +-----------+  +-----------+            +-----------+  +-----------+
  | Device #1 |  | Device #i |            | Device #j |  | Device #k |
  +-----------+  +-----------+            +-----------+  +-----------+
@@ -42,8 +45,9 @@ and quirks are handled by all layers depending on the quirk.
  +----------------+  +-----------+  +------------------+  +------------------+
 
 Example Drivers:
-  I/O: USB, I2C, Bluetooth-l2cap
-  Transport: USB-HID, I2C-HID, BT-HIDP
+
+  - I/O: USB, I2C, Bluetooth-l2cap
+  - Transport: USB-HID, I2C-HID, BT-HIDP
 
 Everything below "HID Core" is simplified in this graph as it is only of
 interest to HID device drivers. Transport drivers do not need to know the
@@ -183,7 +187,7 @@ Other ctrl-channel requests are supported by USB-HID but are not available
 -------------------
 
 Transport drivers normally use the following procedure to register a new device
-with HID core:
+with HID core::
 
 	struct hid_device *hid;
 	int ret;
@@ -215,7 +219,7 @@ Once hid_add_device() is entered, HID core might use the callbacks provided in
 "custom_ll_driver". Note that fields like "country" can be ignored by underlying
 transport-drivers if not supported.
 
-To unregister a device, use:
+To unregister a device, use::
 
 	hid_destroy_device(hid);
 
@@ -226,73 +230,110 @@ driver callbacks.
 -----------------------------
 
 The available HID callbacks are:
- - int (*start) (struct hid_device *hdev)
+
+   ::
+
+      int (*start) (struct hid_device *hdev)
+
    Called from HID device drivers once they want to use the device. Transport
    drivers can choose to setup their device in this callback. However, normally
    devices are already set up before transport drivers register them to HID core
    so this is mostly only used by USB-HID.
 
- - void (*stop) (struct hid_device *hdev)
+   ::
+
+      void (*stop) (struct hid_device *hdev)
+
    Called from HID device drivers once they are done with a device. Transport
    drivers can free any buffers and deinitialize the device. But note that
    ->start() might be called again if another HID device driver is loaded on the
    device.
+
    Transport drivers are free to ignore it and deinitialize devices after they
    destroyed them via hid_destroy_device().
 
- - int (*open) (struct hid_device *hdev)
+   ::
+
+      int (*open) (struct hid_device *hdev)
+
    Called from HID device drivers once they are interested in data reports.
    Usually, while user-space didn't open any input API/etc., device drivers are
    not interested in device data and transport drivers can put devices asleep.
    However, once ->open() is called, transport drivers must be ready for I/O.
    ->open() calls are nested for each client that opens the HID device.
 
- - void (*close) (struct hid_device *hdev)
+   ::
+
+      void (*close) (struct hid_device *hdev)
+
    Called from HID device drivers after ->open() was called but they are no
    longer interested in device reports. (Usually if user-space closed any input
    devices of the driver).
+
    Transport drivers can put devices asleep and terminate any I/O of all
    ->open() calls have been followed by a ->close() call. However, ->start() may
    be called again if the device driver is interested in input reports again.
 
- - int (*parse) (struct hid_device *hdev)
+   ::
+
+      int (*parse) (struct hid_device *hdev)
+
    Called once during device setup after ->start() has been called. Transport
    drivers must read the HID report-descriptor from the device and tell HID core
    about it via hid_parse_report().
 
- - int (*power) (struct hid_device *hdev, int level)
+   ::
+
+      int (*power) (struct hid_device *hdev, int level)
+
    Called by HID core to give PM hints to transport drivers. Usually this is
    analogical to the ->open() and ->close() hints and redundant.
 
- - void (*request) (struct hid_device *hdev, struct hid_report *report,
-                    int reqtype)
+   ::
+
+      void (*request) (struct hid_device *hdev, struct hid_report *report,
+		       int reqtype)
+
    Send an HID request on the ctrl channel. "report" contains the report that
    should be sent and "reqtype" the request type. Request-type can be
    HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
+
    This callback is optional. If not provided, HID core will assemble a raw
    report following the HID specs and send it via the ->raw_request() callback.
    The transport driver is free to implement this asynchronously.
 
- - int (*wait) (struct hid_device *hdev)
+   ::
+
+      int (*wait) (struct hid_device *hdev)
+
    Used by HID core before calling ->request() again. A transport driver can use
    it to wait for any pending requests to complete if only one request is
    allowed at a time.
 
- - int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
-                       __u8 *buf, size_t count, unsigned char rtype,
-                       int reqtype)
+   ::
+
+      int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
+                          __u8 *buf, size_t count, unsigned char rtype,
+                          int reqtype)
+
    Same as ->request() but provides the report as raw buffer. This request shall
    be synchronous. A transport driver must not use ->wait() to complete such
    requests. This request is mandatory and hid core will reject the device if
    it is missing.
 
- - int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len)
+   ::
+
+      int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len)
+
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
    must not cause SET_REPORT calls! This must be implemented as asynchronous
    output report on the intr channel!
 
- - int (*idle) (struct hid_device *hdev, int report, int idle, int reqtype)
+   ::
+
+      int (*idle) (struct hid_device *hdev, int report, int idle, int reqtype)
+
    Perform SET/GET_IDLE request. Only used by USB-HID, do not implement!
 
 2.3) Data Path
@@ -314,4 +355,5 @@ transport driver and not passed to hid_input_report().
 Acknowledgements to SET_REPORT requests are not of interest to HID core.
 
 ----------------------------------------------------
+
 Written 2013, David Herrmann <dh.herrmann@gmail.com>
diff --git a/Documentation/hid/hiddev.txt b/Documentation/hid/hiddev.rst
similarity index 77%
rename from Documentation/hid/hiddev.txt
rename to Documentation/hid/hiddev.rst
index 638448707aa2..209e6ba4e019 100644
--- a/Documentation/hid/hiddev.txt
+++ b/Documentation/hid/hiddev.rst
@@ -1,6 +1,9 @@
+================================================
 Care and feeding of your Human Interface Devices
+================================================
 
-INTRODUCTION
+Introduction
+============
 
 In addition to the normal input type HID devices, USB also uses the
 human interface device protocols for things that are not really human
@@ -16,38 +19,40 @@ normalised event interface - see Documentation/input/input.rst
 * the hiddev interface, which provides fairly raw HID events
 
 The data flow for a HID event produced by a device is something like
-the following :
+the following::
 
  usb.c ---> hid-core.c  ----> hid-input.c ----> [keyboard/mouse/joystick/event]
                          |
                          |
-                          --> hiddev.c ----> POWER / MONITOR CONTROL 
+                          --> hiddev.c ----> POWER / MONITOR CONTROL
 
 In addition, other subsystems (apart from USB) can potentially feed
 events into the input subsystem, but these have no effect on the hid
 device interface.
 
-USING THE HID DEVICE INTERFACE
+Using the HID Device Interface
+==============================
 
 The hiddev interface is a char interface using the normal USB major,
 with the minor numbers starting at 96 and finishing at 111. Therefore,
-you need the following commands:
-mknod /dev/usb/hiddev0 c 180 96
-mknod /dev/usb/hiddev1 c 180 97
-mknod /dev/usb/hiddev2 c 180 98
-mknod /dev/usb/hiddev3 c 180 99
-mknod /dev/usb/hiddev4 c 180 100
-mknod /dev/usb/hiddev5 c 180 101
-mknod /dev/usb/hiddev6 c 180 102
-mknod /dev/usb/hiddev7 c 180 103
-mknod /dev/usb/hiddev8 c 180 104
-mknod /dev/usb/hiddev9 c 180 105
-mknod /dev/usb/hiddev10 c 180 106
-mknod /dev/usb/hiddev11 c 180 107
-mknod /dev/usb/hiddev12 c 180 108
-mknod /dev/usb/hiddev13 c 180 109
-mknod /dev/usb/hiddev14 c 180 110
-mknod /dev/usb/hiddev15 c 180 111
+you need the following commands::
+
+	mknod /dev/usb/hiddev0 c 180 96
+	mknod /dev/usb/hiddev1 c 180 97
+	mknod /dev/usb/hiddev2 c 180 98
+	mknod /dev/usb/hiddev3 c 180 99
+	mknod /dev/usb/hiddev4 c 180 100
+	mknod /dev/usb/hiddev5 c 180 101
+	mknod /dev/usb/hiddev6 c 180 102
+	mknod /dev/usb/hiddev7 c 180 103
+	mknod /dev/usb/hiddev8 c 180 104
+	mknod /dev/usb/hiddev9 c 180 105
+	mknod /dev/usb/hiddev10 c 180 106
+	mknod /dev/usb/hiddev11 c 180 107
+	mknod /dev/usb/hiddev12 c 180 108
+	mknod /dev/usb/hiddev13 c 180 109
+	mknod /dev/usb/hiddev14 c 180 110
+	mknod /dev/usb/hiddev15 c 180 111
 
 So you point your hiddev compliant user-space program at the correct
 interface for your device, and it all just works.
@@ -56,7 +61,9 @@ Assuming that you have a hiddev compliant user-space program, of
 course. If you need to write one, read on.
 
 
-THE HIDDEV API
+The HIDDEV API
+==============
+
 This description should be read in conjunction with the HID
 specification, freely available from http://www.usb.org, and
 conveniently linked of http://www.linux-usb.org.
@@ -69,12 +76,14 @@ each of which can have one or more "usages".  In the hid-core,
 each one of these usages has a single signed 32 bit value.
 
 read():
+-------
+
 This is the event interface.  When the HID device's state changes,
 it performs an interrupt transfer containing a report which contains
 the changed value.  The hid-core.c module parses the report, and
 returns to hiddev.c the individual usages that have changed within
 the report.  In its basic mode, the hiddev will make these individual
-usage changes available to the reader using a struct hiddev_event:
+usage changes available to the reader using a struct hiddev_event::
 
        struct hiddev_event {
            unsigned hid;
@@ -90,13 +99,19 @@ behavior of the read() function can be modified using the HIDIOCSFLAG
 ioctl() described below.
 
 
-ioctl(): 
-This is the control interface. There are a number of controls: 
+ioctl():
+--------
 
-HIDIOCGVERSION - int (read)
-Gets the version code out of the hiddev driver.
+This is the control interface. There are a number of controls:
+
+HIDIOCGVERSION
+  - int (read)
+
+ Gets the version code out of the hiddev driver.
+
+HIDIOCAPPLICATION
+  - (none)
 
-HIDIOCAPPLICATION - (none)
 This ioctl call returns the HID application usage associated with the
 hid device. The third argument to ioctl() specifies which application
 index to get. This is useful when the device has more than one
@@ -104,25 +119,33 @@ application collection. If the index is invalid (greater or equal to
 the number of application collections this device has) the ioctl
 returns -1. You can find out beforehand how many application
 collections the device has from the num_applications field from the
-hiddev_devinfo structure. 
+hiddev_devinfo structure.
+
+HIDIOCGCOLLECTIONINFO
+  - struct hiddev_collection_info (read/write)
 
-HIDIOCGCOLLECTIONINFO - struct hiddev_collection_info (read/write)
 This returns a superset of the information above, providing not only
 application collections, but all the collections the device has.  It
 also returns the level the collection lives in the hierarchy.
-The user passes in a hiddev_collection_info struct with the index 
-field set to the index that should be returned.  The ioctl fills in 
-the other fields.  If the index is larger than the last collection 
+The user passes in a hiddev_collection_info struct with the index
+field set to the index that should be returned.  The ioctl fills in
+the other fields.  If the index is larger than the last collection
 index, the ioctl returns -1 and sets errno to -EINVAL.
 
-HIDIOCGDEVINFO - struct hiddev_devinfo (read)
+HIDIOCGDEVINFO
+  - struct hiddev_devinfo (read)
+
 Gets a hiddev_devinfo structure which describes the device.
 
-HIDIOCGSTRING - struct hiddev_string_descriptor (read/write)
+HIDIOCGSTRING
+  - struct hiddev_string_descriptor (read/write)
+
 Gets a string descriptor from the device. The caller must fill in the
 "index" field to indicate which descriptor should be returned.
 
-HIDIOCINITREPORT - (none)
+HIDIOCINITREPORT
+  - (none)
+
 Instructs the kernel to retrieve all input and feature report values
 from the device. At this point, all the usage structures will contain
 current values for the device, and will maintain it as the device
@@ -130,21 +153,29 @@ changes.  Note that the use of this ioctl is unnecessary in general,
 since later kernels automatically initialize the reports from the
 device at attach time.
 
-HIDIOCGNAME - string (variable length)
+HIDIOCGNAME
+  - string (variable length)
+
 Gets the device name
 
-HIDIOCGREPORT - struct hiddev_report_info (write)
+HIDIOCGREPORT
+  - struct hiddev_report_info (write)
+
 Instructs the kernel to get a feature or input report from the device,
 in order to selectively update the usage structures (in contrast to
 INITREPORT).
 
-HIDIOCSREPORT - struct hiddev_report_info (write)
+HIDIOCSREPORT
+  - struct hiddev_report_info (write)
+
 Instructs the kernel to send a report to the device. This report can
 be filled in by the user through HIDIOCSUSAGE calls (below) to fill in
 individual usage values in the report before sending the report in full
-to the device. 
+to the device.
+
+HIDIOCGREPORTINFO
+  - struct hiddev_report_info (read/write)
 
-HIDIOCGREPORTINFO - struct hiddev_report_info (read/write)
 Fills in a hiddev_report_info structure for the user. The report is
 looked up by type (input, output or feature) and id, so these fields
 must be filled in by the user. The ID can be absolute -- the actual
@@ -154,52 +185,67 @@ report_id) for the next report after report_id. Without a-priori
 information about report ids, the right way to use this ioctl is to
 use the relative IDs above to enumerate the valid IDs. The ioctl
 returns non-zero when there is no more next ID. The real report ID is
-filled into the returned hiddev_report_info structure. 
+filled into the returned hiddev_report_info structure.
+
+HIDIOCGFIELDINFO
+  - struct hiddev_field_info (read/write)
 
-HIDIOCGFIELDINFO - struct hiddev_field_info (read/write)
 Returns the field information associated with a report in a
 hiddev_field_info structure. The user must fill in report_id and
 report_type in this structure, as above. The field_index should also
 be filled in, which should be a number from 0 and maxfield-1, as
-returned from a previous HIDIOCGREPORTINFO call. 
+returned from a previous HIDIOCGREPORTINFO call.
+
+HIDIOCGUCODE
+  - struct hiddev_usage_ref (read/write)
 
-HIDIOCGUCODE - struct hiddev_usage_ref (read/write)
 Returns the usage_code in a hiddev_usage_ref structure, given that
 given its report type, report id, field index, and index within the
 field have already been filled into the structure.
 
-HIDIOCGUSAGE - struct hiddev_usage_ref (read/write)
+HIDIOCGUSAGE
+  - struct hiddev_usage_ref (read/write)
+
 Returns the value of a usage in a hiddev_usage_ref structure. The
 usage to be retrieved can be specified as above, or the user can
 choose to fill in the report_type field and specify the report_id as
 HID_REPORT_ID_UNKNOWN. In this case, the hiddev_usage_ref will be
 filled in with the report and field information associated with this
-usage if it is found. 
+usage if it is found.
+
+HIDIOCSUSAGE
+  - struct hiddev_usage_ref (write)
 
-HIDIOCSUSAGE - struct hiddev_usage_ref (write)
 Sets the value of a usage in an output report.  The user fills in
 the hiddev_usage_ref structure as above, but additionally fills in
 the value field.
 
-HIDIOGCOLLECTIONINDEX - struct hiddev_usage_ref (write)
+HIDIOGCOLLECTIONINDEX
+  - struct hiddev_usage_ref (write)
+
 Returns the collection index associated with this usage.  This
 indicates where in the collection hierarchy this usage sits.
 
-HIDIOCGFLAG - int (read)
-HIDIOCSFLAG - int (write)
+HIDIOCGFLAG
+  - int (read)
+HIDIOCSFLAG
+  - int (write)
+
 These operations respectively inspect and replace the mode flags
 that influence the read() call above.  The flags are as follows:
 
-    HIDDEV_FLAG_UREF - read() calls will now return 
+    HIDDEV_FLAG_UREF
+      - read() calls will now return
         struct hiddev_usage_ref instead of struct hiddev_event.
         This is a larger structure, but in situations where the
         device has more than one usage in its reports with the
         same usage code, this mode serves to resolve such
         ambiguity.
 
-    HIDDEV_FLAG_REPORT - This flag can only be used in conjunction
+    HIDDEV_FLAG_REPORT
+      - This flag can only be used in conjunction
         with HIDDEV_FLAG_UREF.  With this flag set, when the device
         sends a report, a struct hiddev_usage_ref will be returned
-        to read() filled in with the report_type and report_id, but 
+        to read() filled in with the report_type and report_id, but
         with field_index set to FIELD_INDEX_NONE.  This serves as
         additional notification when the device has sent a report.
diff --git a/Documentation/hid/hidraw.txt b/Documentation/hid/hidraw.rst
similarity index 89%
rename from Documentation/hid/hidraw.txt
rename to Documentation/hid/hidraw.rst
index c8436e354f44..4a4a0ba1f362 100644
--- a/Documentation/hid/hidraw.txt
+++ b/Documentation/hid/hidraw.rst
@@ -1,5 +1,6 @@
-      HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices
-     ==================================================================
+================================================================
+HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices
+================================================================
 
 The hidraw driver provides a raw interface to USB and Bluetooth Human
 Interface Devices (HIDs).  It differs from hiddev in that reports sent and
@@ -31,6 +32,7 @@ directly under /dev (eg: /dev/hidraw0).  As this location is distribution-
 and udev rule-dependent, applications should use libudev to locate hidraw
 devices attached to the system.  There is a tutorial on libudev with a
 working example at:
+
 	http://www.signal11.us/oss/udev/
 
 The HIDRAW API
@@ -51,7 +53,7 @@ byte.  For devices which do not use numbered reports, the report data
 will begin at the first byte.
 
 write()
---------
+-------
 The write() function will write a report to the device. For USB devices, if
 the device has an INTERRUPT OUT endpoint, the report will be sent on that
 endpoint. If it does not, the report will be sent over the control endpoint,
@@ -62,38 +64,52 @@ number.  If the device does not use numbered reports, the first byte should
 be set to 0. The report data itself should begin at the second byte.
 
 ioctl()
---------
+-------
 Hidraw supports the following ioctls:
 
-HIDIOCGRDESCSIZE: Get Report Descriptor Size
+HIDIOCGRDESCSIZE:
+	Get Report Descriptor Size
+
 This ioctl will get the size of the device's report descriptor.
 
-HIDIOCGRDESC: Get Report Descriptor
+HIDIOCGRDESC:
+	Get Report Descriptor
+
 This ioctl returns the device's report descriptor using a
 hidraw_report_descriptor struct.  Make sure to set the size field of the
 hidraw_report_descriptor struct to the size returned from HIDIOCGRDESCSIZE.
 
-HIDIOCGRAWINFO: Get Raw Info
+HIDIOCGRAWINFO:
+	Get Raw Info
+
 This ioctl will return a hidraw_devinfo struct containing the bus type, the
 vendor ID (VID), and product ID (PID) of the device. The bus type can be one
-of:
-	BUS_USB
-	BUS_HIL
-	BUS_BLUETOOTH
-	BUS_VIRTUAL
+of::
+
+	- BUS_USB
+	- BUS_HIL
+	- BUS_BLUETOOTH
+	- BUS_VIRTUAL
+
 which are defined in uapi/linux/input.h.
 
-HIDIOCGRAWNAME(len): Get Raw Name
+HIDIOCGRAWNAME(len):
+	Get Raw Name
+
 This ioctl returns a string containing the vendor and product strings of
 the device.  The returned string is Unicode, UTF-8 encoded.
 
-HIDIOCGRAWPHYS(len): Get Physical Address
+HIDIOCGRAWPHYS(len):
+	Get Physical Address
+
 This ioctl returns a string representing the physical address of the device.
 For USB devices, the string contains the physical path to the device (the
 USB controller, hubs, ports, etc).  For Bluetooth devices, the string
 contains the hardware (MAC) address of the device.
 
-HIDIOCSFEATURE(len): Send a Feature Report
+HIDIOCSFEATURE(len):
+	Send a Feature Report
+
 This ioctl will send a feature report to the device.  Per the HID
 specification, feature reports are always sent using the control endpoint.
 Set the first byte of the supplied buffer to the report number.  For devices
@@ -101,7 +117,9 @@ which do not use numbered reports, set the first byte to 0. The report data
 begins in the second byte. Make sure to set len accordingly, to one more
 than the length of the report (to account for the report number).
 
-HIDIOCGFEATURE(len): Get a Feature Report
+HIDIOCGFEATURE(len):
+	Get a Feature Report
+
 This ioctl will request a feature report from the device using the control
 endpoint.  The first byte of the supplied buffer should be set to the report
 number of the requested report.  For devices which do not use numbered
@@ -109,11 +127,12 @@ reports, set the first byte to 0.  The report will be returned starting at
 the first byte of the buffer (ie: the report number is not returned).
 
 Example
----------
+-------
 In samples/, find hid-example.c, which shows examples of read(), write(),
 and all the ioctls for hidraw.  The code may be used by anyone for any
 purpose, and can serve as a starting point for developing applications using
 hidraw.
 
 Document by:
+
 	Alan Ott <alan@signal11.us>, Signal 11 Software
diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
new file mode 100644
index 000000000000..af4324902622
--- /dev/null
+++ b/Documentation/hid/index.rst
@@ -0,0 +1,18 @@
+:orphan:
+
+=============================
+Human Interface Devices (HID)
+=============================
+
+.. toctree::
+   :maxdepth: 1
+
+   hiddev
+   hidraw
+   hid-sensor
+   hid-transport
+
+   uhid
+
+   hid-alps
+   intel-ish-hid
diff --git a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/intel-ish-hid.rst
new file mode 100644
index 000000000000..cccbf4be17d7
--- /dev/null
+++ b/Documentation/hid/intel-ish-hid.rst
@@ -0,0 +1,485 @@
+=================================
+Intel Integrated Sensor Hub (ISH)
+=================================
+
+A sensor hub enables the ability to offload sensor polling and algorithm
+processing to a dedicated low power co-processor. This allows the core
+processor to go into low power modes more often, resulting in the increased
+battery life.
+
+There are many vendors providing external sensor hubs confirming to HID
+Sensor usage tables, and used in several tablets, 2 in 1 convertible laptops
+and embedded products. Linux had this support since Linux 3.9.
+
+Intel® introduced integrated sensor hubs as a part of the SoC starting from
+Cherry Trail and now supported on multiple generations of CPU packages. There
+are many commercial devices already shipped with Integrated Sensor Hubs (ISH).
+These ISH also comply to HID sensor specification, but the  difference is the
+transport protocol used for communication. The current external sensor hubs
+mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
+
+1. Overview
+===========
+
+Using a analogy with a usbhid implementation, the ISH follows a similar model
+for a very high speed communication::
+
+	-----------------		----------------------
+	|    USB HID	|	-->	|    ISH HID	     |
+	-----------------		----------------------
+	-----------------		----------------------
+	|  USB protocol	|	-->	|    ISH Transport   |
+	-----------------		----------------------
+	-----------------		----------------------
+	|  EHCI/XHCI	|	-->	|    ISH IPC	     |
+	-----------------		----------------------
+	      PCI				 PCI
+	-----------------		----------------------
+        |Host controller|	-->	|    ISH processor   |
+	-----------------		----------------------
+	     USB Link
+	-----------------		----------------------
+	| USB End points|	-->	|    ISH Clients     |
+	-----------------		----------------------
+
+Like USB protocol provides a method for device enumeration, link management
+and user data encapsulation, the ISH also provides similar services. But it is
+very light weight tailored to manage and communicate with ISH client
+applications implemented in the firmware.
+
+The ISH allows multiple sensor management applications executing in the
+firmware. Like USB endpoints the messaging can be to/from a client. As part of
+enumeration process, these clients are identified. These clients can be simple
+HID sensor applications, sensor calibration application or senor firmware
+update application.
+
+The implementation model is similar, like USB bus, ISH transport is also
+implemented as a bus. Each client application executing in the ISH processor
+is registered as a device on this bus. The driver, which binds each device
+(ISH HID driver) identifies the device type and registers with the hid core.
+
+2. ISH Implementation: Block Diagram
+====================================
+
+::
+
+	 ---------------------------
+	|  User Space Applications  |
+	 ---------------------------
+
+  ----------------IIO ABI----------------
+	 --------------------------
+	|  IIO Sensor Drivers	  |
+	 --------------------------
+	 --------------------------
+	|	 IIO core	  |
+	 --------------------------
+	 --------------------------
+	|   HID Sensor Hub MFD	  |
+	 --------------------------
+	 --------------------------
+	|       HID Core	  |
+	 --------------------------
+	 --------------------------
+	|   HID over ISH Client   |
+	 --------------------------
+	 --------------------------
+	|   ISH Transport (ISHTP) |
+	 --------------------------
+	 --------------------------
+	|      IPC Drivers	  |
+	 --------------------------
+  OS
+  ---------------- PCI -----------------
+  Hardware + Firmware
+	 ----------------------------
+	| ISH Hardware/Firmware(FW) |
+	 ----------------------------
+
+3. High level processing in above blocks
+========================================
+
+3.1 Hardware Interface
+----------------------
+
+The ISH is exposed as "Non-VGA unclassified PCI device" to the host. The PCI
+product and vendor IDs are changed from different generations of processors. So
+the source code which enumerate drivers needs to update from generation to
+generation.
+
+3.2 Inter Processor Communication (IPC) driver
+----------------------------------------------
+
+Location: drivers/hid/intel-ish-hid/ipc
+
+The IPC message used memory mapped I/O. The registers are defined in
+hw-ish-regs.h.
+
+3.2.1 IPC/FW message types
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There are two types of messages, one for management of link and other messages
+are to and from transport layers.
+
+TX and RX of Transport messages
+...............................
+
+A set of memory mapped register offers support of multi byte messages TX and
+RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer maintains
+internal queues to sequence messages and send them in order to the FW.
+Optionally the caller can register handler to get notification of completion.
+A door bell mechanism is used in messaging to trigger processing in host and
+client firmware side. When ISH interrupt handler is called, the ISH2HOST
+doorbell register is used by host drivers to determine that the interrupt
+is for ISH.
+
+Each side has 32 32-bit message registers and a 32-bit doorbell. Doorbell
+register has the following format:
+Bits 0..6: fragment length (7 bits are used)
+Bits 10..13: encapsulated protocol
+Bits 16..19: management command (for IPC management protocol)
+Bit 31: doorbell trigger (signal H/W interrupt to the other side)
+Other bits are reserved, should be 0.
+
+3.2.2 Transport layer interface
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To abstract HW level IPC communication, a set of callbacks are registered.
+The transport layer uses them to send and receive messages.
+Refer to  struct ishtp_hw_ops for callbacks.
+
+3.3 ISH Transport layer
+-----------------------
+
+Location: drivers/hid/intel-ish-hid/ishtp/
+
+3.3.1 A Generic Transport Layer
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The transport layer is a bi-directional protocol, which defines:
+- Set of commands to start, stop, connect, disconnect and flow control
+(ishtp/hbm.h) for details
+- A flow control mechanism to avoid buffer overflows
+
+This protocol resembles bus messages described in the following document:
+http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
+specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
+
+3.3.2 Connection and Flow Control Mechanism
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Each FW client and a protocol is identified by an UUID. In order to communicate
+to a FW client, a connection must be established using connect request and
+response bus messages. If successful, a pair (host_client_id and fw_client_id)
+will identify the connection.
+
+Once connection is established, peers send each other flow control bus messages
+independently. Every peer may send a message only if it has received a
+flow-control credit before. Once it sent a message, it may not send another one
+before receiving the next flow control credit.
+Either side can send disconnect request bus message to end communication. Also
+the link will be dropped if major FW reset occurs.
+
+3.3.3 Peer to Peer data transfer
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Peer to Peer data transfer can happen with or without using DMA. Depending on
+the sensor bandwidth requirement DMA can be enabled by using module parameter
+ishtp_use_dma under intel_ishtp.
+
+Each side (host and FW) manages its DMA transfer memory independently. When an
+ISHTP client from either host or FW side wants to send something, it decides
+whether to send over IPC or over DMA; for each transfer the decision is
+independent. The sending side sends DMA_XFER message when the message is in
+the respective host buffer (TX when host client sends, RX when FW client
+sends). The recipient of DMA message responds with DMA_XFER_ACK, indicating
+the sender that the memory region for that message may be reused.
+
+DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus message
+(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
+Additionally to DMA address communication, this sequence checks capabilities:
+if thw host doesn't support DMA, then it won't send DMA allocation, so FW can't
+send DMA; if FW doesn't support DMA then it won't respond with
+DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
+Here ISH acts as busmaster DMA controller. Hence when host sends DMA_XFER,
+it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, it means
+that it already did DMA and the message resides at host. Thus, DMA_XFER
+and DMA_XFER_ACK act as ownership indicators.
+
+At initial state all outgoing memory belongs to the sender (TX to host, RX to
+FW), DMA_XFER transfers ownership on the region that contains ISHTP message to
+the receiving side, DMA_XFER_ACK returns ownership to the sender. A sender
+needs not wait for previous DMA_XFER to be ack'ed, and may send another message
+as long as remaining continuous memory in its ownership is enough.
+In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent at once
+(up to IPC MTU), thus allowing for interrupt throttling.
+Currently, ISH FW decides to send over DMA if ISHTP message is more than 3 IPC
+fragments and via IPC otherwise.
+
+3.3.4 Ring Buffers
+^^^^^^^^^^^^^^^^^^
+
+When a client initiate a connection, a ring or RX and TX buffers are allocated.
+The size of ring can be specified by the client. HID client set 16 and 32 for
+TX and RX buffers respectively. On send request from client, the data to be
+sent is copied to one of the send ring buffer and scheduled to be sent using
+bus message protocol. These buffers are required because the FW may have not
+have processed the last message and may not have enough flow control credits
+to send. Same thing holds true on receive side and flow control is required.
+
+3.3.5 Host Enumeration
+^^^^^^^^^^^^^^^^^^^^^^
+
+The host enumeration bus command allow discovery of clients present in the FW.
+There can be multiple sensor clients and clients for calibration function.
+
+To ease in implantation and allow independent driver handle each client
+this transport layer takes advantage of Linux Bus driver model. Each
+client is registered as device on the the transport bus (ishtp bus).
+
+Enumeration sequence of messages:
+
+- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is up.
+- FW responds with HOST_START_RES_CMD
+- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
+- FW responds with HOST_ENUM_RES_CMD that includes bitmap of available FW
+  client IDs
+- For each FW ID found in that bitmap host sends
+  HOST_CLIENT_PROPERTIES_REQ_CMD
+- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties include UUID,
+  max ISHTP message size, etc.
+- Once host received properties for that last discovered client, it considers
+  ISHTP device fully functional (and allocates DMA buffers)
+
+3.4 HID over ISH Client
+-----------------------
+
+Location: drivers/hid/intel-ish-hid
+
+The ISHTP client driver is responsible for:
+
+- enumerate HID devices under FW ISH client
+- Get Report descriptor
+- Register with HID core as a LL driver
+- Process Get/Set feature request
+- Get input reports
+
+3.5 HID Sensor Hub MFD and IIO sensor drivers
+---------------------------------------------
+
+The functionality in these drivers is the same as an external sensor hub.
+Refer to
+Documentation/hid/hid-sensor.rst for HID sensor
+Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
+
+3.6 End to End HID transport Sequence Diagram
+---------------------------------------------
+
+::
+
+  HID-ISH-CLN                    ISHTP                    IPC                             HW
+          |                        |                       |                               |
+          |                        |                       |-----WAKE UP------------------>|
+          |                        |                       |                               |
+          |                        |                       |-----HOST READY--------------->|
+          |                        |                       |                               |
+          |                        |                       |<----MNG_RESET_NOTIFY_ACK----- |
+          |                        |                       |                               |
+          |                        |<----ISHTP_START------ |                               |
+          |                        |                       |                               |
+          |                        |<-----------------HOST_START_RES_CMD-------------------|
+          |                        |                       |                               |
+          |                        |------------------QUERY_SUBSCRIBER-------------------->|
+          |                        |                       |                               |
+          |                        |------------------HOST_ENUM_REQ_CMD------------------->|
+          |                        |                       |                               |
+          |                        |<-----------------HOST_ENUM_RES_CMD--------------------|
+          |                        |                       |                               |
+          |                        |------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
+          |                        |                       |                               |
+          |                        |<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
+          |       Create new device on in ishtp bus        |                               |
+          |                        |                       |                               |
+          |                        |------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
+          |                        |                       |                               |
+          |                        |<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
+          |       Create new device on in ishtp bus        |                               |
+          |                        |                       |                               |
+          |                        |--Repeat HOST_CLIENT_PROPERTIES_REQ_CMD-till last one--|
+          |                        |                       |                               |
+       probed()
+          |----ishtp_cl_connect--->|----------------- CLIENT_CONNECT_REQ_CMD-------------->|
+          |                        |                       |                               |
+          |                        |<----------------CLIENT_CONNECT_RES_CMD----------------|
+          |                        |                       |                               |
+          |register event callback |                       |                               |
+          |                        |                       |                               |
+          |ishtp_cl_send(
+          HOSTIF_DM_ENUM_DEVICES)  |----------fill ishtp_msg_hdr struct write to HW-----  >|
+          |                        |                       |                               |
+          |                        |                       |<-----IRQ(IPC_PROTOCOL_ISHTP---|
+          |                        |                       |                               |
+          |<--ENUM_DEVICE RSP------|                       |                               |
+          |                        |                       |                               |
+  for each enumerated device
+          |ishtp_cl_send(
+          HOSTIF_GET_HID_DESCRIPTOR|----------fill ishtp_msg_hdr struct write to HW-----  >|
+          |                        |                       |                               |
+          ...Response
+          |                        |                       |                               |
+  for each enumerated device
+          |ishtp_cl_send(
+       HOSTIF_GET_REPORT_DESCRIPTOR|--------------fill ishtp_msg_hdr struct write to HW-- >|
+          |                        |                       |                               |
+          |                        |                       |                               |
+   hid_allocate_device
+          |                        |                       |                               |
+   hid_add_device                  |                       |                               |
+          |                        |                       |                               |
+
+
+3.7 ISH Debugging
+-----------------
+
+To debug ISH, event tracing mechanism is used. To enable debug logs
+echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
+cat sys/kernel/debug/tracing/trace
+
+3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
+-----------------------------------------------------
+
+::
+
+  root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
+  /sys/bus/iio/devices/
+  ├── iio:device0 -> ../../../devices/0044:8086:22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
+  │   ├── buffer
+  │   │   ├── enable
+  │   │   ├── length
+  │   │   └── watermark
+  ...
+  │   ├── in_accel_hysteresis
+  │   ├── in_accel_offset
+  │   ├── in_accel_sampling_frequency
+  │   ├── in_accel_scale
+  │   ├── in_accel_x_raw
+  │   ├── in_accel_y_raw
+  │   ├── in_accel_z_raw
+  │   ├── name
+  │   ├── scan_elements
+  │   │   ├── in_accel_x_en
+  │   │   ├── in_accel_x_index
+  │   │   ├── in_accel_x_type
+  │   │   ├── in_accel_y_en
+  │   │   ├── in_accel_y_index
+  │   │   ├── in_accel_y_type
+  │   │   ├── in_accel_z_en
+  │   │   ├── in_accel_z_index
+  │   │   └── in_accel_z_type
+  ...
+  │   │   ├── devices
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_intensity_both_raw
+  │   │   │   │   ├── in_intensity_hysteresis
+  │   │   │   │   ├── in_intensity_offset
+  │   │   │   │   ├── in_intensity_sampling_frequency
+  │   │   │   │   ├── in_intensity_scale
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_intensity_both_en
+  │   │   │   │   │   ├── in_intensity_both_index
+  │   │   │   │   │   └── in_intensity_both_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
+  ...
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_magn_hysteresis
+  │   │   │   │   ├── in_magn_offset
+  │   │   │   │   ├── in_magn_sampling_frequency
+  │   │   │   │   ├── in_magn_scale
+  │   │   │   │   ├── in_magn_x_raw
+  │   │   │   │   ├── in_magn_y_raw
+  │   │   │   │   ├── in_magn_z_raw
+  │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_raw
+  │   │   │   │   ├── in_rot_hysteresis
+  │   │   │   │   ├── in_rot_offset
+  │   │   │   │   ├── in_rot_sampling_frequency
+  │   │   │   │   ├── in_rot_scale
+  │   │   │   │   ├── name
+  ...
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_magn_x_en
+  │   │   │   │   │   ├── in_magn_x_index
+  │   │   │   │   │   ├── in_magn_x_type
+  │   │   │   │   │   ├── in_magn_y_en
+  │   │   │   │   │   ├── in_magn_y_index
+  │   │   │   │   │   ├── in_magn_y_type
+  │   │   │   │   │   ├── in_magn_z_en
+  │   │   │   │   │   ├── in_magn_z_index
+  │   │   │   │   │   ├── in_magn_z_type
+  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_en
+  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_index
+  │   │   │   │   │   └── in_rot_from_north_magnetic_tilt_comp_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
+  ...
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_anglvel_hysteresis
+  │   │   │   │   ├── in_anglvel_offset
+  │   │   │   │   ├── in_anglvel_sampling_frequency
+  │   │   │   │   ├── in_anglvel_scale
+  │   │   │   │   ├── in_anglvel_x_raw
+  │   │   │   │   ├── in_anglvel_y_raw
+  │   │   │   │   ├── in_anglvel_z_raw
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_anglvel_x_en
+  │   │   │   │   │   ├── in_anglvel_x_index
+  │   │   │   │   │   ├── in_anglvel_x_type
+  │   │   │   │   │   ├── in_anglvel_y_en
+  │   │   │   │   │   ├── in_anglvel_y_index
+  │   │   │   │   │   ├── in_anglvel_y_type
+  │   │   │   │   │   ├── in_anglvel_z_en
+  │   │   │   │   │   ├── in_anglvel_z_index
+  │   │   │   │   │   └── in_anglvel_z_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
+  ...
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_anglvel_hysteresis
+  │   │   │   │   ├── in_anglvel_offset
+  │   │   │   │   ├── in_anglvel_sampling_frequency
+  │   │   │   │   ├── in_anglvel_scale
+  │   │   │   │   ├── in_anglvel_x_raw
+  │   │   │   │   ├── in_anglvel_y_raw
+  │   │   │   │   ├── in_anglvel_z_raw
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_anglvel_x_en
+  │   │   │   │   │   ├── in_anglvel_x_index
+  │   │   │   │   │   ├── in_anglvel_x_type
+  │   │   │   │   │   ├── in_anglvel_y_en
+  │   │   │   │   │   ├── in_anglvel_y_index
+  │   │   │   │   │   ├── in_anglvel_y_type
+  │   │   │   │   │   ├── in_anglvel_z_en
+  │   │   │   │   │   ├── in_anglvel_z_index
+  │   │   │   │   │   └── in_anglvel_z_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
+  ...
diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/intel-ish-hid.txt
deleted file mode 100644
index d48b21c71ddd..000000000000
--- a/Documentation/hid/intel-ish-hid.txt
+++ /dev/null
@@ -1,454 +0,0 @@
-Intel Integrated Sensor Hub (ISH)
-===============================
-
-A sensor hub enables the ability to offload sensor polling and algorithm
-processing to a dedicated low power co-processor. This allows the core
-processor to go into low power modes more often, resulting in the increased
-battery life.
-
-There are many vendors providing external sensor hubs confirming to HID
-Sensor usage tables, and used in several tablets, 2 in 1 convertible laptops
-and embedded products. Linux had this support since Linux 3.9.
-
-Intel® introduced integrated sensor hubs as a part of the SoC starting from
-Cherry Trail and now supported on multiple generations of CPU packages. There
-are many commercial devices already shipped with Integrated Sensor Hubs (ISH).
-These ISH also comply to HID sensor specification, but the  difference is the
-transport protocol used for communication. The current external sensor hubs
-mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
-
-1. Overview
-
-Using a analogy with a usbhid implementation, the ISH follows a similar model
-for a very high speed communication:
-
-	-----------------		----------------------
-	|    USB HID	|	-->	|    ISH HID	     |
-	-----------------		----------------------
-	-----------------		----------------------
-	|  USB protocol	|	-->	|    ISH Transport   |
-	-----------------		----------------------
-	-----------------		----------------------
-	|  EHCI/XHCI	|	-->	|    ISH IPC	     |
-	-----------------		----------------------
-	      PCI				 PCI
-	-----------------		----------------------
-        |Host controller|	-->	|    ISH processor   |
-	-----------------		----------------------
-	     USB Link
-	-----------------		----------------------
-	| USB End points|	-->	|    ISH Clients     |
-	-----------------		----------------------
-
-Like USB protocol provides a method for device enumeration, link management
-and user data encapsulation, the ISH also provides similar services. But it is
-very light weight tailored to manage and communicate with ISH client
-applications implemented in the firmware.
-
-The ISH allows multiple sensor management applications executing in the
-firmware. Like USB endpoints the messaging can be to/from a client. As part of
-enumeration process, these clients are identified. These clients can be simple
-HID sensor applications, sensor calibration application or senor firmware
-update application.
-
-The implementation model is similar, like USB bus, ISH transport is also
-implemented as a bus. Each client application executing in the ISH processor
-is registered as a device on this bus. The driver, which binds each device
-(ISH HID driver) identifies the device type and registers with the hid core.
-
-2. ISH Implementation: Block Diagram
-
-	 ---------------------------
-	|  User Space Applications  |
-	 ---------------------------
-
-----------------IIO ABI----------------
-	 --------------------------
-	|  IIO Sensor Drivers	  |
-	 --------------------------
-	 --------------------------
-	|	 IIO core	  |
-	 --------------------------
-	 --------------------------
-	|   HID Sensor Hub MFD	  |
-	 --------------------------
-	 --------------------------
-	|       HID Core	  |
-	 --------------------------
-	 --------------------------
-	|   HID over ISH Client   |
-	 --------------------------
-	 --------------------------
-	|   ISH Transport (ISHTP) |
-	 --------------------------
-	 --------------------------
-	|      IPC Drivers	  |
-	 --------------------------
-OS
-----------------   PCI -----------------
-Hardware + Firmware
-	 ----------------------------
-	| ISH Hardware/Firmware(FW) |
-	 ----------------------------
-
-3. High level processing in above blocks
-
-3.1 Hardware Interface
-
-The ISH is exposed as "Non-VGA unclassified PCI device" to the host. The PCI
-product and vendor IDs are changed from different generations of processors. So
-the source code which enumerate drivers needs to update from generation to
-generation.
-
-3.2 Inter Processor Communication (IPC) driver
-Location: drivers/hid/intel-ish-hid/ipc
-
-The IPC message used memory mapped I/O. The registers are defined in
-hw-ish-regs.h.
-
-3.2.1 IPC/FW message types
-
-There are two types of messages, one for management of link and other messages
-are to and from transport layers.
-
-TX and RX of Transport messages
-
-A set of memory mapped register offers support of multi byte messages TX and
-RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer maintains
-internal queues to sequence messages and send them in order to the FW.
-Optionally the caller can register handler to get notification of completion.
-A door bell mechanism is used in messaging to trigger processing in host and
-client firmware side. When ISH interrupt handler is called, the ISH2HOST
-doorbell register is used by host drivers to determine that the interrupt
-is for ISH.
-
-Each side has 32 32-bit message registers and a 32-bit doorbell. Doorbell
-register has the following format:
-Bits 0..6: fragment length (7 bits are used)
-Bits 10..13: encapsulated protocol
-Bits 16..19: management command (for IPC management protocol)
-Bit 31: doorbell trigger (signal H/W interrupt to the other side)
-Other bits are reserved, should be 0.
-
-3.2.2 Transport layer interface
-
-To abstract HW level IPC communication, a set of callbacks are registered.
-The transport layer uses them to send and receive messages.
-Refer to  struct ishtp_hw_ops for callbacks.
-
-3.3 ISH Transport layer
-Location: drivers/hid/intel-ish-hid/ishtp/
-
-3.3.1 A Generic Transport Layer
-
-The transport layer is a bi-directional protocol, which defines:
-- Set of commands to start, stop, connect, disconnect and flow control
-(ishtp/hbm.h) for details
-- A flow control mechanism to avoid buffer overflows
-
-This protocol resembles bus messages described in the following document:
-http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
-specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
-
-3.3.2 Connection and Flow Control Mechanism
-
-Each FW client and a protocol is identified by an UUID. In order to communicate
-to a FW client, a connection must be established using connect request and
-response bus messages. If successful, a pair (host_client_id and fw_client_id)
-will identify the connection.
-
-Once connection is established, peers send each other flow control bus messages
-independently. Every peer may send a message only if it has received a
-flow-control credit before. Once it sent a message, it may not send another one
-before receiving the next flow control credit.
-Either side can send disconnect request bus message to end communication. Also
-the link will be dropped if major FW reset occurs.
-
-3.3.3 Peer to Peer data transfer
-
-Peer to Peer data transfer can happen with or without using DMA. Depending on
-the sensor bandwidth requirement DMA can be enabled by using module parameter
-ishtp_use_dma under intel_ishtp.
-
-Each side (host and FW) manages its DMA transfer memory independently. When an
-ISHTP client from either host or FW side wants to send something, it decides
-whether to send over IPC or over DMA; for each transfer the decision is
-independent. The sending side sends DMA_XFER message when the message is in
-the respective host buffer (TX when host client sends, RX when FW client
-sends). The recipient of DMA message responds with DMA_XFER_ACK, indicating
-the sender that the memory region for that message may be reused.
-
-DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus message
-(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
-Additionally to DMA address communication, this sequence checks capabilities:
-if thw host doesn't support DMA, then it won't send DMA allocation, so FW can't
-send DMA; if FW doesn't support DMA then it won't respond with
-DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
-Here ISH acts as busmaster DMA controller. Hence when host sends DMA_XFER,
-it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, it means
-that it already did DMA and the message resides at host. Thus, DMA_XFER
-and DMA_XFER_ACK act as ownership indicators.
-
-At initial state all outgoing memory belongs to the sender (TX to host, RX to
-FW), DMA_XFER transfers ownership on the region that contains ISHTP message to
-the receiving side, DMA_XFER_ACK returns ownership to the sender. A sender
-needs not wait for previous DMA_XFER to be ack'ed, and may send another message
-as long as remaining continuous memory in its ownership is enough.
-In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent at once
-(up to IPC MTU), thus allowing for interrupt throttling.
-Currently, ISH FW decides to send over DMA if ISHTP message is more than 3 IPC
-fragments and via IPC otherwise.
-
-3.3.4 Ring Buffers
-
-When a client initiate a connection, a ring or RX and TX buffers are allocated.
-The size of ring can be specified by the client. HID client set 16 and 32 for
-TX and RX buffers respectively. On send request from client, the data to be
-sent is copied to one of the send ring buffer and scheduled to be sent using
-bus message protocol. These buffers are required because the FW may have not
-have processed the last message and may not have enough flow control credits
-to send. Same thing holds true on receive side and flow control is required.
-
-3.3.5 Host Enumeration
-
-The host enumeration bus command allow discovery of clients present in the FW.
-There can be multiple sensor clients and clients for calibration function.
-
-To ease in implantation and allow independent driver handle each client
-this transport layer takes advantage of Linux Bus driver model. Each
-client is registered as device on the the transport bus (ishtp bus).
-
-Enumeration sequence of messages:
-- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is up.
-- FW responds with HOST_START_RES_CMD
-- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
-- FW responds with HOST_ENUM_RES_CMD that includes bitmap of available FW
-client IDs
-- For each FW ID found in that bitmap host sends
-HOST_CLIENT_PROPERTIES_REQ_CMD
-- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties include UUID,
-max ISHTP message size, etc.
-- Once host received properties for that last discovered client, it considers
-ISHTP device fully functional (and allocates DMA buffers)
-
-3.4 HID over ISH Client
-Location: drivers/hid/intel-ish-hid
-
-The ISHTP client driver is responsible for:
-- enumerate HID devices under FW ISH client
-- Get Report descriptor
-- Register with HID core as a LL driver
-- Process Get/Set feature request
-- Get input reports
-
-3.5 HID Sensor Hub MFD and IIO sensor drivers
-
-The functionality in these drivers is the same as an external sensor hub.
-Refer to
-Documentation/hid/hid-sensor.txt for HID sensor
-Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
-
-3.6 End to End HID transport Sequence Diagram
-
-HID-ISH-CLN			ISHTP			IPC				HW
-	|			|			|				|
-	|			|			|-----WAKE UP------------------>|
-	|			|			|				|
-	|			|			|-----HOST READY--------------->|
-	|			|			|				|
-	|			|			|<----MNG_RESET_NOTIFY_ACK----- |
-	|			|			|				|
-	|			|<----ISHTP_START------ |				|
-	|			|			|				|
-	|			|<-----------------HOST_START_RES_CMD-------------------|
-	|			|			|				|
-	|			|------------------QUERY_SUBSCRIBER-------------------->|
-	|			|			|				|
-	|			|------------------HOST_ENUM_REQ_CMD------------------->|
-	|			|			|				|
-	|			|<-----------------HOST_ENUM_RES_CMD--------------------|
-	|			|			|				|
-	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
-	|			|			|				|
-	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
-	|	Create new device on in ishtp bus	|				|
-	|			|			|				|
-	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
-	|			|			|				|
-	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
-	|	Create new device on in ishtp bus	|				|
-	|			|			|				|
-	|			|--Repeat HOST_CLIENT_PROPERTIES_REQ_CMD-till last one--|
-	|			|			|				|
-     probed()
-	|----ishtp_cl_connect-->|----------------- CLIENT_CONNECT_REQ_CMD-------------->|
-	|			|			|				|
-	|			|<----------------CLIENT_CONNECT_RES_CMD----------------|
-	|			|			|				|
-	|register event callback|			|				|
-	|			|			|				|
-	|ishtp_cl_send(
-	HOSTIF_DM_ENUM_DEVICES) |----------fill ishtp_msg_hdr struct write to HW-----  >|
-	|			|			|				|
-	|			|			|<-----IRQ(IPC_PROTOCOL_ISHTP---|
-	|			|			|				|
-	|<--ENUM_DEVICE RSP-----|			|				|
-	|			|			|				|
-for each enumerated device
-	|ishtp_cl_send(
-	HOSTIF_GET_HID_DESCRIPTOR |----------fill ishtp_msg_hdr struct write to HW---  >|
-	|			|			|				|
-	...Response
-	|			|			|				|
-for each enumerated device
-	|ishtp_cl_send(
-	HOSTIF_GET_REPORT_DESCRIPTOR |----------fill ishtp_msg_hdr struct write to HW- >|
-	|			|			|				|
-	|			|			|				|
- hid_allocate_device
-	|			|			|				|
- hid_add_device			|			|				|
-	|			|			|				|
-
-
-3.7 ISH Debugging
-
-To debug ISH, event tracing mechanism is used. To enable debug logs
-echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
-cat sys/kernel/debug/tracing/trace
-
-3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
-
-root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
-/sys/bus/iio/devices/
-├── iio:device0 -> ../../../devices/0044:8086:22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
-│   ├── buffer
-│   │   ├── enable
-│   │   ├── length
-│   │   └── watermark
-...
-│   ├── in_accel_hysteresis
-│   ├── in_accel_offset
-│   ├── in_accel_sampling_frequency
-│   ├── in_accel_scale
-│   ├── in_accel_x_raw
-│   ├── in_accel_y_raw
-│   ├── in_accel_z_raw
-│   ├── name
-│   ├── scan_elements
-│   │   ├── in_accel_x_en
-│   │   ├── in_accel_x_index
-│   │   ├── in_accel_x_type
-│   │   ├── in_accel_y_en
-│   │   ├── in_accel_y_index
-│   │   ├── in_accel_y_type
-│   │   ├── in_accel_z_en
-│   │   ├── in_accel_z_index
-│   │   └── in_accel_z_type
-...
-│   │   ├── devices
-│   │   │   │   ├── buffer
-│   │   │   │   │   ├── enable
-│   │   │   │   │   ├── length
-│   │   │   │   │   └── watermark
-│   │   │   │   ├── dev
-│   │   │   │   ├── in_intensity_both_raw
-│   │   │   │   ├── in_intensity_hysteresis
-│   │   │   │   ├── in_intensity_offset
-│   │   │   │   ├── in_intensity_sampling_frequency
-│   │   │   │   ├── in_intensity_scale
-│   │   │   │   ├── name
-│   │   │   │   ├── scan_elements
-│   │   │   │   │   ├── in_intensity_both_en
-│   │   │   │   │   ├── in_intensity_both_index
-│   │   │   │   │   └── in_intensity_both_type
-│   │   │   │   ├── trigger
-│   │   │   │   │   └── current_trigger
-...
-│   │   │   │   ├── buffer
-│   │   │   │   │   ├── enable
-│   │   │   │   │   ├── length
-│   │   │   │   │   └── watermark
-│   │   │   │   ├── dev
-│   │   │   │   ├── in_magn_hysteresis
-│   │   │   │   ├── in_magn_offset
-│   │   │   │   ├── in_magn_sampling_frequency
-│   │   │   │   ├── in_magn_scale
-│   │   │   │   ├── in_magn_x_raw
-│   │   │   │   ├── in_magn_y_raw
-│   │   │   │   ├── in_magn_z_raw
-│   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_raw
-│   │   │   │   ├── in_rot_hysteresis
-│   │   │   │   ├── in_rot_offset
-│   │   │   │   ├── in_rot_sampling_frequency
-│   │   │   │   ├── in_rot_scale
-│   │   │   │   ├── name
-...
-│   │   │   │   ├── scan_elements
-│   │   │   │   │   ├── in_magn_x_en
-│   │   │   │   │   ├── in_magn_x_index
-│   │   │   │   │   ├── in_magn_x_type
-│   │   │   │   │   ├── in_magn_y_en
-│   │   │   │   │   ├── in_magn_y_index
-│   │   │   │   │   ├── in_magn_y_type
-│   │   │   │   │   ├── in_magn_z_en
-│   │   │   │   │   ├── in_magn_z_index
-│   │   │   │   │   ├── in_magn_z_type
-│   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_en
-│   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_index
-│   │   │   │   │   └── in_rot_from_north_magnetic_tilt_comp_type
-│   │   │   │   ├── trigger
-│   │   │   │   │   └── current_trigger
-...
-│   │   │   │   ├── buffer
-│   │   │   │   │   ├── enable
-│   │   │   │   │   ├── length
-│   │   │   │   │   └── watermark
-│   │   │   │   ├── dev
-│   │   │   │   ├── in_anglvel_hysteresis
-│   │   │   │   ├── in_anglvel_offset
-│   │   │   │   ├── in_anglvel_sampling_frequency
-│   │   │   │   ├── in_anglvel_scale
-│   │   │   │   ├── in_anglvel_x_raw
-│   │   │   │   ├── in_anglvel_y_raw
-│   │   │   │   ├── in_anglvel_z_raw
-│   │   │   │   ├── name
-│   │   │   │   ├── scan_elements
-│   │   │   │   │   ├── in_anglvel_x_en
-│   │   │   │   │   ├── in_anglvel_x_index
-│   │   │   │   │   ├── in_anglvel_x_type
-│   │   │   │   │   ├── in_anglvel_y_en
-│   │   │   │   │   ├── in_anglvel_y_index
-│   │   │   │   │   ├── in_anglvel_y_type
-│   │   │   │   │   ├── in_anglvel_z_en
-│   │   │   │   │   ├── in_anglvel_z_index
-│   │   │   │   │   └── in_anglvel_z_type
-│   │   │   │   ├── trigger
-│   │   │   │   │   └── current_trigger
-...
-│   │   │   │   ├── buffer
-│   │   │   │   │   ├── enable
-│   │   │   │   │   ├── length
-│   │   │   │   │   └── watermark
-│   │   │   │   ├── dev
-│   │   │   │   ├── in_anglvel_hysteresis
-│   │   │   │   ├── in_anglvel_offset
-│   │   │   │   ├── in_anglvel_sampling_frequency
-│   │   │   │   ├── in_anglvel_scale
-│   │   │   │   ├── in_anglvel_x_raw
-│   │   │   │   ├── in_anglvel_y_raw
-│   │   │   │   ├── in_anglvel_z_raw
-│   │   │   │   ├── name
-│   │   │   │   ├── scan_elements
-│   │   │   │   │   ├── in_anglvel_x_en
-│   │   │   │   │   ├── in_anglvel_x_index
-│   │   │   │   │   ├── in_anglvel_x_type
-│   │   │   │   │   ├── in_anglvel_y_en
-│   │   │   │   │   ├── in_anglvel_y_index
-│   │   │   │   │   ├── in_anglvel_y_type
-│   │   │   │   │   ├── in_anglvel_z_en
-│   │   │   │   │   ├── in_anglvel_z_index
-│   │   │   │   │   └── in_anglvel_z_type
-│   │   │   │   ├── trigger
-│   │   │   │   │   └── current_trigger
-...
diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.rst
similarity index 94%
rename from Documentation/hid/uhid.txt
rename to Documentation/hid/uhid.rst
index 958fff945304..b18cb96c885f 100644
--- a/Documentation/hid/uhid.txt
+++ b/Documentation/hid/uhid.rst
@@ -1,5 +1,6 @@
-      UHID - User-space I/O driver support for HID subsystem
-     ========================================================
+======================================================
+UHID - User-space I/O driver support for HID subsystem
+======================================================
 
 UHID allows user-space to implement HID transport drivers. Please see
 hid-transport.txt for an introduction into HID transport drivers. This document
@@ -22,9 +23,9 @@ If a new device is detected by your HID I/O Driver and you want to register this
 device with the HID subsystem, then you need to open /dev/uhid once for each
 device you want to register. All further communication is done by read()'ing or
 write()'ing "struct uhid_event" objects. Non-blocking operations are supported
-by setting O_NONBLOCK.
+by setting O_NONBLOCK::
 
-struct uhid_event {
+  struct uhid_event {
         __u32 type;
         union {
                 struct uhid_create2_req create2;
@@ -32,7 +33,7 @@ struct uhid_event {
                 struct uhid_input2_req input2;
                 ...
         } u;
-};
+  };
 
 The "type" field contains the ID of the event. Depending on the ID different
 payloads are sent. You must not split a single event across multiple read()'s or
@@ -86,31 +87,31 @@ the request was handled successfully. O_NONBLOCK does not affect write() as
 writes are always handled immediately in a non-blocking fashion. Future requests
 might make use of O_NONBLOCK, though.
 
-  UHID_CREATE2:
+UHID_CREATE2:
   This creates the internal HID device. No I/O is possible until you send this
   event to the kernel. The payload is of type struct uhid_create2_req and
   contains information about your device. You can start I/O now.
 
-  UHID_DESTROY:
+UHID_DESTROY:
   This destroys the internal HID device. No further I/O will be accepted. There
   may still be pending messages that you can receive with read() but no further
   UHID_INPUT events can be sent to the kernel.
   You can create a new device by sending UHID_CREATE2 again. There is no need to
   reopen the character device.
 
-  UHID_INPUT2:
+UHID_INPUT2:
   You must send UHID_CREATE2 before sending input to the kernel! This event
   contains a data-payload. This is the raw data that you read from your device
   on the interrupt channel. The kernel will parse the HID reports.
 
-  UHID_GET_REPORT_REPLY:
+UHID_GET_REPORT_REPLY:
   If you receive a UHID_GET_REPORT request you must answer with this request.
   You  must copy the "id" field from the request into the answer. Set the "err"
   field to 0 if no error occurred or to EIO if an I/O error occurred.
   If "err" is 0 then you should fill the buffer of the answer with the results
   of the GET_REPORT request and set "size" correspondingly.
 
-  UHID_SET_REPORT_REPLY:
+UHID_SET_REPORT_REPLY:
   This is the SET_REPORT equivalent of UHID_GET_REPORT_REPLY. Unlike GET_REPORT,
   SET_REPORT never returns a data buffer, therefore, it's sufficient to set the
   "id" and "err" fields correctly.
@@ -120,16 +121,18 @@ read()
 read() will return a queued output report. No reaction is required to any of
 them but you should handle them according to your needs.
 
-  UHID_START:
+UHID_START:
   This is sent when the HID device is started. Consider this as an answer to
   UHID_CREATE2. This is always the first event that is sent. Note that this
   event might not be available immediately after write(UHID_CREATE2) returns.
   Device drivers might required delayed setups.
   This event contains a payload of type uhid_start_req. The "dev_flags" field
   describes special behaviors of a device. The following flags are defined:
-      UHID_DEV_NUMBERED_FEATURE_REPORTS:
-      UHID_DEV_NUMBERED_OUTPUT_REPORTS:
-      UHID_DEV_NUMBERED_INPUT_REPORTS:
+
+      - UHID_DEV_NUMBERED_FEATURE_REPORTS
+      - UHID_DEV_NUMBERED_OUTPUT_REPORTS
+      - UHID_DEV_NUMBERED_INPUT_REPORTS
+
           Each of these flags defines whether a given report-type uses numbered
           reports. If numbered reports are used for a type, all messages from
           the kernel already have the report-number as prefix. Otherwise, no
@@ -137,33 +140,35 @@ them but you should handle them according to your needs.
           For messages sent by user-space to the kernel, you must adjust the
           prefixes according to these flags.
 
-  UHID_STOP:
+UHID_STOP:
   This is sent when the HID device is stopped. Consider this as an answer to
   UHID_DESTROY.
+
   If you didn't destroy your device via UHID_DESTROY, but the kernel sends an
   UHID_STOP event, this should usually be ignored. It means that the kernel
   reloaded/changed the device driver loaded on your HID device (or some other
   maintenance actions happened).
+
   You can usually ignored any UHID_STOP events safely.
 
-  UHID_OPEN:
+UHID_OPEN:
   This is sent when the HID device is opened. That is, the data that the HID
   device provides is read by some other process. You may ignore this event but
   it is useful for power-management. As long as you haven't received this event
   there is actually no other process that reads your data so there is no need to
   send UHID_INPUT2 events to the kernel.
 
-  UHID_CLOSE:
+UHID_CLOSE:
   This is sent when there are no more processes which read the HID data. It is
   the counterpart of UHID_OPEN and you may as well ignore this event.
 
-  UHID_OUTPUT:
+UHID_OUTPUT:
   This is sent if the HID device driver wants to send raw data to the I/O
   device on the interrupt channel. You should read the payload and forward it to
   the device. The payload is of type "struct uhid_output_req".
   This may be received even though you haven't received UHID_OPEN, yet.
 
-  UHID_GET_REPORT:
+UHID_GET_REPORT:
   This event is sent if the kernel driver wants to perform a GET_REPORT request
   on the control channeld as described in the HID specs. The report-type and
   report-number are available in the payload.
@@ -177,11 +182,12 @@ them but you should handle them according to your needs.
   timed out, the kernel will ignore the response silently. The "id" field is
   never re-used, so conflicts cannot happen.
 
-  UHID_SET_REPORT:
+UHID_SET_REPORT:
   This is the SET_REPORT equivalent of UHID_GET_REPORT. On receipt, you shall
   send a SET_REPORT request to your hid device. Once it replies, you must tell
   the kernel about it via UHID_SET_REPORT_REPLY.
   The same restrictions as for UHID_GET_REPORT apply.
 
 ----------------------------------------------------
+
 Written 2012, David Herrmann <dh.herrmann@gmail.com>
diff --git a/Documentation/input/input.rst b/Documentation/input/input.rst
index 47f86a4bf16c..0eb61e67a7b7 100644
--- a/Documentation/input/input.rst
+++ b/Documentation/input/input.rst
@@ -188,7 +188,7 @@ LCDs and many other purposes.
 
 The monitor and speaker controls should be easy to add to the hid/input
 interface, but for the UPSs and LCDs it doesn't make much sense. For this,
-the hiddev interface was designed. See Documentation/hid/hiddev.txt
+the hiddev interface was designed. See Documentation/hid/hiddev.rst
 for more information about it.
 
 The usage of the usbhid module is very simple, it takes no parameters,
diff --git a/MAINTAINERS b/MAINTAINERS
index 3e3b9738f2e6..9458cdaa5b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16461,7 +16461,7 @@ M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-usb@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 S:	Maintained
-F:	Documentation/hid/hiddev.txt
+F:	Documentation/hid/hiddev.rst
 F:	drivers/hid/usbhid/
 
 USB INTEL XHCI ROLE MUX DRIVER
-- 
2.21.0

