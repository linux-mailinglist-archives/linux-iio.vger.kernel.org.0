Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CA2CE800
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLDGVT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EADC061A52;
        Thu,  3 Dec 2020 22:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wRsJlxFIWj8q5aFJON2aTW63qPvnPACR49t7lFad7io=; b=qPXP8UE/AkYhiPk6J2wSXnVAtm
        Xb+4Nkj5d1HW/ekEMr5NOMp5ltsGfPtmPsinj7h11YlTxQqYKDbSfy9EouMjoq1eJ82/pfwFhce9u
        a1e9quHd0pzpLfjiPpNrXzSw/5BiOGF+O9WphZOyakQbYfbaCMbgFZt9+hRCaL04s5IEz54TiJ8ZC
        NlecW9ZJUuUnPqc1IyFIBLet4C0aLE+vo8r6c/gnB9m9Aj78KOjlitcJRs9Ygc7SzaOg44xDazF+H
        haBF/7y1QIq+aSJrMj1tYOaCOUv+gR6j+9EiY4hJmkz3oUPK3G24xf2SwVIYA/Oky5gdL3o1kFGOq
        O1c/HD3A==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SK-0002HZ-Lg; Fri, 04 Dec 2020 06:20:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/8] Documentation: HID: amd-sfh-hid editing & corrections
Date:   Thu,  3 Dec 2020 22:20:16 -0800
Message-Id: <20201204062022.5095-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to amd-sfh-hid.rst:
- fix punctuation
- use HID instead of hid consistently
- fix grammar, verb tense

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/amd-sfh-hid.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/amd-sfh-hid.rst
+++ linux-next-20201201/Documentation/hid/amd-sfh-hid.rst
@@ -3,7 +3,7 @@
 
 AMD Sensor Fusion Hub
 =====================
-AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen based platforms.
+AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen-based platforms.
 The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
 In terms of architecture it resembles ISH, however the major difference is all
 the HID reports are generated as part of the kernel driver.
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
+interface between MP2 PCIe layer and HID. HID client layer initializes the MP2 PCIe layer and holds
 the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Base
-on that allocates the DRAM address for each and every sensor and pass it to MP2-PCIe driver.On
-enumeration of each the sensor, client layer fills the HID Descriptor structure and HID input repor
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
