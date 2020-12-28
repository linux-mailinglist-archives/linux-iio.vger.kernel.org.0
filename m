Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5142E6B95
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 00:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgL1Wzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 17:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgL1UyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 15:54:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E97C061796;
        Mon, 28 Dec 2020 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oC3WoNQlCXM7MybD3s/7U20d1WcH+cpXtHVbLSWjUK0=; b=wHFZt7Liyl33Qa9GjKF/hHVXzT
        0L0fe6l8/gYx6wfdTBAzsXn2h+a6etKUfsC31Dbzq0VlJky87uS3NVX6XMnndu/LPX2fFuWiy2d1K
        GICr1BPvasvMugOeEFYd+dCuLvcthDZZLoeKX8OmsyRpeiFoTWtWIN7NSzeAWZbzZXM2uqtgnw0pr
        GT9B+lD1Ax4aEVuqFB/tkiEwxqrHonStwMbDOd0inGFxtKsvjGfs65dnZmoNNfYaXi2LgoDgM4YUB
        Khuiuu3QB3fVRKReYNOAyuPcJ2Is4HOOP0ivxzGWgEPV1D0RaU1e7w3Binnlp+7GKWcyFXQ2RxPfr
        ncN6NTkA==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzWQ-0002ml-EJ; Mon, 28 Dec 2020 20:53:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/8] Documentation: HID: amd-sfh-hid editing & corrections
Date:   Mon, 28 Dec 2020 12:53:21 -0800
Message-Id: <20201228205327.1063-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
References: <20201228205327.1063-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to amd-sfh-hid.rst:
- fix punctuation
- use HID instead of hid consistently
- fix grammar, verb tense
- fix Block Diagram heading

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: Base -> Based (Jonathan Cameron)
    Change "1. Block Diagram" from a chapter heading to a section heading
    and remove its numbering.

 Documentation/hid/amd-sfh-hid.rst |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- lnx-511-rc1.orig/Documentation/hid/amd-sfh-hid.rst
+++ lnx-511-rc1/Documentation/hid/amd-sfh-hid.rst
@@ -3,13 +3,13 @@
 
 AMD Sensor Fusion Hub
 =====================
-AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen based platforms.
+AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen-based platforms.
 The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
 In terms of architecture it resembles ISH, however the major difference is all
 the HID reports are generated as part of the kernel driver.
 
-1. Block Diagram
-================
+Block Diagram
+-------------
 
 ::
 
@@ -45,20 +45,20 @@ the HID reports are generated as part of
 AMD HID Transport Layer
 -----------------------
 AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2 is
-registered as a device on this bus. Here: MP2 which is an ARM core connected to x86 for processing
+registered as a device on this bus. Here, MP2 is an ARM core connected to x86 for processing
 sensor data. The layer, which binds each device (AMD SFH HID driver) identifies the device type and
-registers with the hid core. Transport layer attach a constant "struct hid_ll_driver" object with
+registers with the HID core. Transport layer attaches a constant "struct hid_ll_driver" object with
 each device. Once a device is registered with HID core, the callbacks provided via this struct are
 used by HID core to communicate with the device. AMD HID Transport layer implements the synchronous calls.
 
 AMD HID Client Layer
 --------------------
-This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic, HID
+This layer is responsible to implement HID requests and descriptors. As firmware is OS agnostic, HID
 client layer fills the HID request structure and descriptors. HID client layer is complex as it is
-interface between MP2 PCIe layer and HID. HID client layer initialized the MP2 PCIe layer and holds
-the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Base
-on that allocates the DRAM address for each and every sensor and pass it to MP2-PCIe driver.On
-enumeration of each the sensor, client layer fills the HID Descriptor structure and HID input repor
+interface between MP2 PCIe layer and HID. HID client layer initializes the MP2 PCIe layer and holds
+the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Based
+on that allocates the DRAM address for each and every sensor and passes it to MP2-PCIe driver. On
+enumeration of each sensor, client layer fills the HID Descriptor structure and HID input report
 structure. HID Feature report structure is optional. The report descriptor structure varies from
 sensor to sensor.
 
@@ -72,7 +72,7 @@ The communication between X86 and MP2 is
 2. Data transfer via DRAM.
 3. Supported sensor info via P2C registers.
 
-Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generate
+Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generates
 interrupt to MP2. The client layer allocates the physical memory and the same is sent to MP2 via
 the PCI layer. MP2 firmware writes the command output to the access DRAM memory which the client
 layer has allocated. Firmware always writes minimum of 32 bytes into DRAM. So as a protocol driver
