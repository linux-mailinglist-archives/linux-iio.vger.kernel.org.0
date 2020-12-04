Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6502F2CE818
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLDGV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgLDGV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F7C08C5F2;
        Thu,  3 Dec 2020 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Dzqd9oWAlypnBUcaG3+r48ufax/PraL0ot/F6/P6l7w=; b=tM22K/DvSjtAesgLcQpHIW7ji9
        ItRk6lPuHIrurRLsyxFTpiz7meGhsxJ9AzPUpWxKvGrWfY7c4jDxK2wOTIxO8HZB2a+UvSAr7sCgQ
        PA7x9Uj1g0NmndvexVT3v1GJS/+HaI/sy3+y7M3VEl+3NkOpK7StCa2zoDqCxakEdMTKSzqpaPUTz
        UbR4f9kKqFcct1LwynHspEzLpO1oiOOjH8q+6JVe436Xi2AvLg/levGSh4FWmDdB3kSBDePmNNcoJ
        FLZUxoDqZd1qtbyPV5BA4Df+Sh1+oO7R9omNDyeeSjg0sygfwjRsSHh7HLl0pABcz7pF5fsgnyYa5
        onhgQKPw==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4Sd-0002HZ-Az; Fri, 04 Dec 2020 06:20:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 7/8] Documentation: HID: hid-transport editing & corrections
Date:   Thu,  3 Dec 2020 22:20:21 -0800
Message-Id: <20201204062022.5095-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to hid-transport.rst:
- s/responsible of/responsible for/
- fix grammar & punctuation


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hid-transport.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hid-transport.rst
+++ linux-next-20201201/Documentation/hid/hid-transport.rst
@@ -12,8 +12,8 @@ Bluetooth, I2C and user-space I/O driver
 
 The HID subsystem is designed as a bus. Any I/O subsystem may provide HID
 devices and register them with the HID bus. HID core then loads generic device
-drivers on top of it. The transport drivers are responsible of raw data
-transport and device setup/management. HID core is responsible of
+drivers on top of it. The transport drivers are responsible for raw data
+transport and device setup/management. HID core is responsible for
 report-parsing, report interpretation and the user-space API. Device specifics
 and quirks are handled by all layers depending on the quirk.
 
@@ -67,7 +67,7 @@ Transport drivers attach a constant "str
 device. Once a device is registered with HID core, the callbacks provided via
 this struct are used by HID core to communicate with the device.
 
-Transport drivers are responsible of detecting device failures and unplugging.
+Transport drivers are responsible for detecting device failures and unplugging.
 HID core will operate a device as long as it is registered regardless of any
 device failures. Once transport drivers detect unplug or failure events, they
 must unregister the device from HID core and HID core will stop using the
@@ -101,7 +101,7 @@ properties in common.
    channel. Any unrequested incoming or outgoing data report must be sent on
    this channel and is never acknowledged by the remote side. Devices usually
    send their input events on this channel. Outgoing events are normally
-   not send via intr, except if high throughput is required.
+   not sent via intr, except if high throughput is required.
  - Control Channel (ctrl): The ctrl channel is used for synchronous requests and
    device management. Unrequested data input events must not be sent on this
    channel and are normally ignored. Instead, devices only send management
@@ -161,7 +161,7 @@ allowed on the intr channel and are the
    payload may be blocked by the underlying transport driver if the
    specification does not allow them.
  - SET_REPORT: A SET_REPORT request has a report ID plus data as payload. It is
-   sent from host to device and a device must update it's current report state
+   sent from host to device and a device must update its current report state
    according to the given data. Any of the 3 report types can be used. However,
    INPUT reports as payload might be blocked by the underlying transport driver
    if the specification does not allow them.
@@ -294,7 +294,7 @@ The available HID callbacks are:
       void (*request) (struct hid_device *hdev, struct hid_report *report,
 		       int reqtype)
 
-   Send an HID request on the ctrl channel. "report" contains the report that
+   Send a HID request on the ctrl channel. "report" contains the report that
    should be sent and "reqtype" the request type. Request-type can be
    HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
 
