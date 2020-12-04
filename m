Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9E2CE809
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgLDGV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLDGV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A031C061A54;
        Thu,  3 Dec 2020 22:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uCFNSWUSBtMbsT8AQMzqFgOEcOQY5MAZMnp0YpVtlgk=; b=ub0kLm3lQmCdvjsLbMxi+93Dp2
        azppRjs5Y1+6lTDJMfrMsJarygwJn8mHJiYdKvL1jgDzlmnWFyNRtnZ2/hw67HbrzCN/r4fTljNjP
        ByynGadRUV+wys3upPkZSBkELjswwHqcBLmz3PooWktda6xqSfdiBtjtCLn2Zek5S0ey9Y8rlJonI
        Y0eZvoO2sUmhFqTtEAVLRHU9IOeXWs5pMr0Zx6P6rUJL3/rDTVeQkpZMDj6qy5jl3t+Tf6Fa0cjtS
        VgCBjBy+SEig/mx/8Rai7FO5jfhdNuciFH2+nqr6p73+WMKk3JNMWITsAb61VnDFVBCswvBsyZPUN
        tpVFPZeg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SR-0002HZ-SJ; Fri, 04 Dec 2020 06:20:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 4/8] Documentation: HID: intel-ish-hid editing & corrections
Date:   Thu,  3 Dec 2020 22:20:18 -0800
Message-Id: <20201204062022.5095-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to intel-ish-hid.rst:
- fix grammar, verb tense, punctutation, and word phrasing
- fix spellos
- hyphenate multi-word adjectives
- collapse 2 spaces to one space in the middle of sentences
- use "I2C" instead of lower-case letters (as Linux I2C does)
- change space indentation to tab
- use HID instead of hid consistently
- use a list so that some line items do not run together
- use "a UUID" instead of "an UUID"


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/intel-ish-hid.rst |   74 +++++++++++++-------------
 1 file changed, 38 insertions(+), 36 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/intel-ish-hid.rst
+++ linux-next-20201201/Documentation/hid/intel-ish-hid.rst
@@ -4,19 +4,19 @@ Intel Integrated Sensor Hub (ISH)
 
 A sensor hub enables the ability to offload sensor polling and algorithm
 processing to a dedicated low power co-processor. This allows the core
-processor to go into low power modes more often, resulting in the increased
+processor to go into low power modes more often, resulting in increased
 battery life.
 
-There are many vendors providing external sensor hubs confirming to HID
-Sensor usage tables, and used in several tablets, 2 in 1 convertible laptops
+There are many vendors providing external sensor hubs conforming to HID
+Sensor usage tables, and used in several tablets, 2-in-1 convertible laptops
 and embedded products. Linux had this support since Linux 3.9.
 
 Intel® introduced integrated sensor hubs as a part of the SoC starting from
 Cherry Trail and now supported on multiple generations of CPU packages. There
 are many commercial devices already shipped with Integrated Sensor Hubs (ISH).
-These ISH also comply to HID sensor specification, but the  difference is the
+These ISH also comply to HID sensor specification, but the difference is the
 transport protocol used for communication. The current external sensor hubs
-mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
+mainly use HID over I2C or USB. But ISH doesn't use either I2C or USB.
 
 1. Overview
 ===========
@@ -35,7 +35,7 @@ for a very high speed communication::
 	-----------------		----------------------
 	      PCI				 PCI
 	-----------------		----------------------
-        |Host controller|	-->	|    ISH processor   |
+	|Host controller|	-->	|    ISH processor   |
 	-----------------		----------------------
 	     USB Link
 	-----------------		----------------------
@@ -50,13 +50,13 @@ applications implemented in the firmware
 The ISH allows multiple sensor management applications executing in the
 firmware. Like USB endpoints the messaging can be to/from a client. As part of
 enumeration process, these clients are identified. These clients can be simple
-HID sensor applications, sensor calibration application or senor firmware
+HID sensor applications, sensor calibration application or sensor firmware
 update application.
 
 The implementation model is similar, like USB bus, ISH transport is also
 implemented as a bus. Each client application executing in the ISH processor
 is registered as a device on this bus. The driver, which binds each device
-(ISH HID driver) identifies the device type and registers with the hid core.
+(ISH HID driver) identifies the device type and registers with the HID core.
 
 2. ISH Implementation: Block Diagram
 ====================================
@@ -104,7 +104,7 @@ is registered as a device on this bus. T
 
 The ISH is exposed as "Non-VGA unclassified PCI device" to the host. The PCI
 product and vendor IDs are changed from different generations of processors. So
-the source code which enumerate drivers needs to update from generation to
+the source code which enumerates drivers needs to update from generation to
 generation.
 
 3.2 Inter Processor Communication (IPC) driver
@@ -112,41 +112,42 @@ generation.
 
 Location: drivers/hid/intel-ish-hid/ipc
 
-The IPC message used memory mapped I/O. The registers are defined in
+The IPC message uses memory mapped I/O. The registers are defined in
 hw-ish-regs.h.
 
 3.2.1 IPC/FW message types
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-There are two types of messages, one for management of link and other messages
-are to and from transport layers.
+There are two types of messages, one for management of link and another for
+messages to and from transport layers.
 
 TX and RX of Transport messages
 ...............................
 
-A set of memory mapped register offers support of multi byte messages TX and
-RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer maintains
-internal queues to sequence messages and send them in order to the FW.
+A set of memory mapped register offers support of multi-byte messages TX and
+RX (e.g. IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer maintains
+internal queues to sequence messages and send them in order to the firmware.
 Optionally the caller can register handler to get notification of completion.
-A door bell mechanism is used in messaging to trigger processing in host and
+A doorbell mechanism is used in messaging to trigger processing in host and
 client firmware side. When ISH interrupt handler is called, the ISH2HOST
 doorbell register is used by host drivers to determine that the interrupt
 is for ISH.
 
 Each side has 32 32-bit message registers and a 32-bit doorbell. Doorbell
-register has the following format:
-Bits 0..6: fragment length (7 bits are used)
-Bits 10..13: encapsulated protocol
-Bits 16..19: management command (for IPC management protocol)
-Bit 31: doorbell trigger (signal H/W interrupt to the other side)
-Other bits are reserved, should be 0.
+register has the following format::
+
+  Bits 0..6: fragment length (7 bits are used)
+  Bits 10..13: encapsulated protocol
+  Bits 16..19: management command (for IPC management protocol)
+  Bit 31: doorbell trigger (signal H/W interrupt to the other side)
+  Other bits are reserved, should be 0.
 
 3.2.2 Transport layer interface
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-To abstract HW level IPC communication, a set of callbacks are registered.
+To abstract HW level IPC communication, a set of callbacks is registered.
 The transport layer uses them to send and receive messages.
-Refer to  struct ishtp_hw_ops for callbacks.
+Refer to struct ishtp_hw_ops for callbacks.
 
 3.3 ISH Transport layer
 -----------------------
@@ -158,7 +159,7 @@ Location: drivers/hid/intel-ish-hid/isht
 
 The transport layer is a bi-directional protocol, which defines:
 - Set of commands to start, stop, connect, disconnect and flow control
-(ishtp/hbm.h) for details
+(see ishtp/hbm.h for details)
 - A flow control mechanism to avoid buffer overflows
 
 This protocol resembles bus messages described in the following document:
@@ -168,14 +169,14 @@ specifications/dcmi-hi-1-0-spec.pdf "Cha
 3.3.2 Connection and Flow Control Mechanism
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Each FW client and a protocol is identified by an UUID. In order to communicate
+Each FW client and a protocol is identified by a UUID. In order to communicate
 to a FW client, a connection must be established using connect request and
 response bus messages. If successful, a pair (host_client_id and fw_client_id)
 will identify the connection.
 
 Once connection is established, peers send each other flow control bus messages
 independently. Every peer may send a message only if it has received a
-flow-control credit before. Once it sent a message, it may not send another one
+flow-control credit before. Once it has sent a message, it may not send another one
 before receiving the next flow control credit.
 Either side can send disconnect request bus message to end communication. Also
 the link will be dropped if major FW reset occurs.
@@ -209,7 +210,7 @@ and DMA_XFER_ACK act as ownership indica
 At initial state all outgoing memory belongs to the sender (TX to host, RX to
 FW), DMA_XFER transfers ownership on the region that contains ISHTP message to
 the receiving side, DMA_XFER_ACK returns ownership to the sender. A sender
-needs not wait for previous DMA_XFER to be ack'ed, and may send another message
+need not wait for previous DMA_XFER to be ack'ed, and may send another message
 as long as remaining continuous memory in its ownership is enough.
 In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent at once
 (up to IPC MTU), thus allowing for interrupt throttling.
@@ -219,8 +220,8 @@ fragments and via IPC otherwise.
 3.3.4 Ring Buffers
 ^^^^^^^^^^^^^^^^^^
 
-When a client initiate a connection, a ring or RX and TX buffers are allocated.
-The size of ring can be specified by the client. HID client set 16 and 32 for
+When a client initiates a connection, a ring of RX and TX buffers is allocated.
+The size of ring can be specified by the client. HID client sets 16 and 32 for
 TX and RX buffers respectively. On send request from client, the data to be
 sent is copied to one of the send ring buffer and scheduled to be sent using
 bus message protocol. These buffers are required because the FW may have not
@@ -230,10 +231,10 @@ to send. Same thing holds true on receiv
 3.3.5 Host Enumeration
 ^^^^^^^^^^^^^^^^^^^^^^
 
-The host enumeration bus command allow discovery of clients present in the FW.
+The host enumeration bus command allows discovery of clients present in the FW.
 There can be multiple sensor clients and clients for calibration function.
 
-To ease in implantation and allow independent driver handle each client
+To ease implementation and allow independent drivers to handle each client,
 this transport layer takes advantage of Linux Bus driver model. Each
 client is registered as device on the transport bus (ishtp bus).
 
@@ -270,7 +271,7 @@ The ISHTP client driver is responsible f
 The functionality in these drivers is the same as an external sensor hub.
 Refer to
 Documentation/hid/hid-sensor.rst for HID sensor
-Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
+Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space.
 
 3.6 End to End HID transport Sequence Diagram
 ---------------------------------------------
@@ -341,9 +342,10 @@ Documentation/ABI/testing/sysfs-bus-iio
 3.7 ISH Debugging
 -----------------
 
-To debug ISH, event tracing mechanism is used. To enable debug logs
-echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
-cat sys/kernel/debug/tracing/trace
+To debug ISH, event tracing mechanism is used. To enable debug logs::
+
+  echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
+  cat sys/kernel/debug/tracing/trace
 
 3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
 -----------------------------------------------------
