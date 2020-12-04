Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B12CE815
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgLDGVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgLDGVx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2107C061A56;
        Thu,  3 Dec 2020 22:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FLeiyYcYndFk6Ks4B0qswcYUlqrq6gt+Fx7r0g+Y8ik=; b=zzLwHWxuX5I8GLqCIpWPnwFOpd
        je0NB1McyN7WaOOs9mkpTX3KLVVGJ5HW6T6/xrUZOxAmyNRam9hknyhXquOsrwCLZktRK+uBxjlgp
        fOVCCXaIThzM+T74eg+Hu7GdF/g3qa2/Y39d0JbgSV6lo5aCfDX+4cj16INypm/xbsXszCFZ1WKqh
        wLuziDNc2RnAkjoVgq/JVDYYeNH1rzvX0VZFt2W1gw/JoRC43A0Lh4McEYhuzhb+07k/ePw3S94Yd
        eeF5qA8BLswpWWp0MTYPork05/08eY7BbYOP5F42gwLOH7rG76XnH5Qhx54JJ7PrM4ZpQiVKKE4f2
        dsDfpnNg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SZ-0002HZ-Gt; Fri, 04 Dec 2020 06:20:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 6/8] Documentation: HID: hid-sensor editing & corrections
Date:   Thu,  3 Dec 2020 22:20:20 -0800
Message-Id: <20201204062022.5095-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Do basic editing & correction to hid-sensor.rst:
- use HID consistently instead of hid
- drop a duplicate word
- change article adjective an -> a
- fix grammar & punctuation
- spell out RW -> read-write
- hyphenate multi-word adjectives


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hid-sensor.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hid-sensor.rst
+++ linux-next-20201201/Documentation/hid/hid-sensor.rst
@@ -48,12 +48,12 @@ for different sensors. For example an ac
 an ambient light sensor can send illumination data.
 So the implementation has two parts:
 
-- Core hid driver
+- Core HID driver
 - Individual sensor processing part (sensor drivers)
 
 Core driver
 -----------
-The core driver registers (hid-sensor-hub) registers as a HID driver. It parses
+The core driver (hid-sensor-hub) registers as a HID driver. It parses
 report descriptors and identifies all the sensors present. It adds an MFD device
 with name HID-SENSOR-xxxx (where xxxx is usage id from the specification).
 
@@ -95,14 +95,14 @@ Registration functions::
 			u32 usage_id,
 			struct hid_sensor_hub_callbacks *usage_callback):
 
-Registers callbacks for an usage id. The callback functions are not allowed
+Registers callbacks for a usage id. The callback functions are not allowed
 to sleep::
 
 
   int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id):
 
-Removes callbacks for an usage id.
+Removes callbacks for a usage id.
 
 
 Parsing function::
@@ -166,7 +166,7 @@ This allows some differentiating use cas
 Some common use cases are debug other sensors or to provide some events like
 keyboard attached/detached or lid open/close.
 
-To allow application to utilize these sensors, here they are exported uses sysfs
+To allow application to utilize these sensors, here they are exported using sysfs
 attribute groups, attributes and misc device interface.
 
 An example of this representation on sysfs::
@@ -207,9 +207,9 @@ An example of this representation on sys
   │   │   │   ├── input-1-200202-units
   │   │   │   ├── input-1-200202-value
 
-Here there is a custom sensors with four fields, two feature and two inputs.
+Here there is a custom sensor with four fields: two feature and two inputs.
 Each field is represented by a set of attributes. All fields except the "value"
-are read only. The value field is a RW field.
+are read only. The value field is a read-write field.
 
 Example::
 
@@ -237,6 +237,6 @@ These reports are pushed using misc devi
 	│   │   │   ├── 10:53 -> ../HID-SENSOR-2000e1.6.auto
 	│   ├──  HID-SENSOR-2000e1.6.auto
 
-Each reports can be of variable length preceded by a header. This header
-consist of a 32 bit usage id, 64 bit time stamp and 32 bit length field of raw
+Each report can be of variable length preceded by a header. This header
+consists of a 32-bit usage id, 64-bit time stamp and 32-bit length field of raw
 data.
