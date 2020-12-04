Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23A52CE81D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgLDGV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgLDGV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113CC08E85E;
        Thu,  3 Dec 2020 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=85a75XCalerfRjEXWXHwqX8/9O+dkhtYbWa8p+MOsLI=; b=oeJr47fZ9S9nSFIAVcEOK/HX0E
        IuP15/Xp+8vQERN3pRVbVg1mpp1b/UeDNWaBQwPxHpxSew7AcIArhnQatocq0gtvGc4PJgdC8Zr9L
        aTh9S9T/tjOTGSjuofGjRrmFzSI9avM1DeBYcCQ2FBMNiqPYmih/OloFVJHmPvOuhY3gv4yovkZ1+
        dWSdlWuYtelwAa2HTCI6HsyQ8CF+rAaYMmsgfLTeudtuvxTxsF+XZz8fDKwXOWDQowqvTM0b+0TVg
        y/uzFG9nwDzSzXUt6bQIm/pJPJbjaaMkScEFaYVVaP+TpolE2+V+BVPSu7OCZikfeGnlq7EYz8+rS
        QK6j4/Yg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4Sh-0002HZ-43; Fri, 04 Dec 2020 06:20:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 8/8] Documentation: HID: uhid editing & corrections
Date:   Thu,  3 Dec 2020 22:20:22 -0800
Message-Id: <20201204062022.5095-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to hid-alps.rst:
- correct a file name (.txt -> .rst)
- use less hyphenation when not needed
- fix grammar & punctuation
- fix article adjectives
- fix typos/spellos
- use HID instead of hid consistently


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/uhid.rst |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/uhid.rst
+++ linux-next-20201201/Documentation/hid/uhid.rst
@@ -3,7 +3,7 @@ UHID - User-space I/O driver support for
 ======================================================
 
 UHID allows user-space to implement HID transport drivers. Please see
-hid-transport.txt for an introduction into HID transport drivers. This document
+hid-transport.rst for an introduction into HID transport drivers. This document
 relies heavily on the definitions declared there.
 
 With UHID, a user-space transport driver can create kernel hid-devices for each
@@ -15,7 +15,7 @@ There is an example user-space applicati
 The UHID API
 ------------
 
-UHID is accessed through a character misc-device. The minor-number is allocated
+UHID is accessed through a character misc-device. The minor number is allocated
 dynamically so you need to rely on udev (or similar) to create the device node.
 This is /dev/uhid by default.
 
@@ -45,23 +45,23 @@ The "type" field defines the payload. Fo
 payload-structure available in the union "u" (except for empty payloads). This
 payload contains management and/or device data.
 
-The first thing you should do is sending an UHID_CREATE2 event. This will
-register the device. UHID will respond with an UHID_START event. You can now
+The first thing you should do is send a UHID_CREATE2 event. This will
+register the device. UHID will respond with a UHID_START event. You can now
 start sending data to and reading data from UHID. However, unless UHID sends the
 UHID_OPEN event, the internally attached HID Device Driver has no user attached.
 That is, you might put your device asleep unless you receive the UHID_OPEN
 event. If you receive the UHID_OPEN event, you should start I/O. If the last
-user closes the HID device, you will receive an UHID_CLOSE event. This may be
-followed by an UHID_OPEN event again and so on. There is no need to perform
+user closes the HID device, you will receive a UHID_CLOSE event. This may be
+followed by a UHID_OPEN event again and so on. There is no need to perform
 reference-counting in user-space. That is, you will never receive multiple
-UHID_OPEN events without an UHID_CLOSE event. The HID subsystem performs
+UHID_OPEN events without a UHID_CLOSE event. The HID subsystem performs
 ref-counting for you.
 You may decide to ignore UHID_OPEN/UHID_CLOSE, though. I/O is allowed even
 though the device may have no users.
 
 If you want to send data on the interrupt channel to the HID subsystem, you send
-an HID_INPUT2 event with your raw data payload. If the kernel wants to send data
-on the interrupt channel to the device, you will read an UHID_OUTPUT event.
+a HID_INPUT2 event with your raw data payload. If the kernel wants to send data
+on the interrupt channel to the device, you will read a UHID_OUTPUT event.
 Data requests on the control channel are currently limited to GET_REPORT and
 SET_REPORT (no other data reports on the control channel are defined so far).
 Those requests are always synchronous. That means, the kernel sends
@@ -71,7 +71,7 @@ the response via UHID_GET_REPORT_REPLY a
 The kernel blocks internal driver-execution during such round-trips (times out
 after a hard-coded period).
 
-If your device disconnects, you should send an UHID_DESTROY event. This will
+If your device disconnects, you should send a UHID_DESTROY event. This will
 unregister the device. You can now send UHID_CREATE2 again to register a new
 device.
 If you close() the fd, the device is automatically unregistered and destroyed
@@ -125,7 +125,7 @@ UHID_START:
   This is sent when the HID device is started. Consider this as an answer to
   UHID_CREATE2. This is always the first event that is sent. Note that this
   event might not be available immediately after write(UHID_CREATE2) returns.
-  Device drivers might required delayed setups.
+  Device drivers might require delayed setups.
   This event contains a payload of type uhid_start_req. The "dev_flags" field
   describes special behaviors of a device. The following flags are defined:
 
@@ -149,7 +149,7 @@ UHID_STOP:
   reloaded/changed the device driver loaded on your HID device (or some other
   maintenance actions happened).
 
-  You can usually ignored any UHID_STOP events safely.
+  You can usually ignore any UHID_STOP events safely.
 
 UHID_OPEN:
   This is sent when the HID device is opened. That is, the data that the HID
@@ -166,17 +166,17 @@ UHID_OUTPUT:
   This is sent if the HID device driver wants to send raw data to the I/O
   device on the interrupt channel. You should read the payload and forward it to
   the device. The payload is of type "struct uhid_output_req".
-  This may be received even though you haven't received UHID_OPEN, yet.
+  This may be received even though you haven't received UHID_OPEN yet.
 
 UHID_GET_REPORT:
   This event is sent if the kernel driver wants to perform a GET_REPORT request
-  on the control channeld as described in the HID specs. The report-type and
+  on the control channel as described in the HID specs. The report-type and
   report-number are available in the payload.
   The kernel serializes GET_REPORT requests so there will never be two in
   parallel. However, if you fail to respond with a UHID_GET_REPORT_REPLY, the
   request might silently time out.
-  Once you read a GET_REPORT request, you shall forward it to the hid device and
-  remember the "id" field in the payload. Once your hid device responds to the
+  Once you read a GET_REPORT request, you shall forward it to the HID device and
+  remember the "id" field in the payload. Once your HID device responds to the
   GET_REPORT (or if it fails), you must send a UHID_GET_REPORT_REPLY to the
   kernel with the exact same "id" as in the request. If the request already
   timed out, the kernel will ignore the response silently. The "id" field is
@@ -184,7 +184,7 @@ UHID_GET_REPORT:
 
 UHID_SET_REPORT:
   This is the SET_REPORT equivalent of UHID_GET_REPORT. On receipt, you shall
-  send a SET_REPORT request to your hid device. Once it replies, you must tell
+  send a SET_REPORT request to your HID device. Once it replies, you must tell
   the kernel about it via UHID_SET_REPORT_REPLY.
   The same restrictions as for UHID_GET_REPORT apply.
 
