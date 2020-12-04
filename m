Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E02CE808
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgLDGVX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGVX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DFC061A53;
        Thu,  3 Dec 2020 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XmyZzzTZKCb50OlY8+NVjIQzW91Ffi5HE4HYViQP4B8=; b=ov3p+fIa3mH2n58/9GJO4pKttm
        +xFzFcWh2SIIuH9XxFKkThFU6+xgfo1ppp9YqRbV8brnhdGE3FtT5uDqs4YO0FwtLYf4NrZ6VHbFU
        NV9fqMzbQ3/BOXGIPaIIGXmOrSQQUvn0x+u7R+teaWX5XDQ19pUDo6qex+D5IXaWCh2GDN+RxCZG3
        Jzl6jsRUrqRDtNNXkmiqEYPJGY++v+TL9jYgb4PBhJbzvlPe8XWeUcQk6IZG/BNZaQ7AiF4ro0vRx
        mpVaVTtun0257Gd0PPNUa+FZ8wzePaZTBsA0MOHU5152pZc6EJmii2aewbqORp6x/k8zaMgc3yuJJ
        HalU5YrA==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SO-0002HZ-9U; Fri, 04 Dec 2020 06:20:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/8] Documentation: HID: hiddev editing & corrections
Date:   Thu,  3 Dec 2020 22:20:17 -0800
Message-Id: <20201204062022.5095-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to hiddev.rst:
- use HID instead of hid consistently
- add hyphenation of multi-word adjectives
- drop a duplicate word
- unhyphenate "a priori"


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hiddev.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hiddev.rst
+++ linux-next-20201201/Documentation/hid/hiddev.rst
@@ -27,7 +27,7 @@ the following::
                           --> hiddev.c ----> POWER / MONITOR CONTROL
 
 In addition, other subsystems (apart from USB) can potentially feed
-events into the input subsystem, but these have no effect on the hid
+events into the input subsystem, but these have no effect on the HID
 device interface.
 
 Using the HID Device Interface
@@ -72,8 +72,8 @@ The hiddev API uses a read() interface,
 
 HID devices exchange data with the host computer using data
 bundles called "reports".  Each report is divided into "fields",
-each of which can have one or more "usages".  In the hid-core,
-each one of these usages has a single signed 32 bit value.
+each of which can have one or more "usages".  In the HID core,
+each one of these usages has a single signed 32-bit value.
 
 read():
 -------
@@ -113,7 +113,7 @@ HIDIOCAPPLICATION
   - (none)
 
 This ioctl call returns the HID application usage associated with the
-hid device. The third argument to ioctl() specifies which application
+HID device. The third argument to ioctl() specifies which application
 index to get. This is useful when the device has more than one
 application collection. If the index is invalid (greater or equal to
 the number of application collections this device has) the ioctl
@@ -181,7 +181,7 @@ looked up by type (input, output or feat
 must be filled in by the user. The ID can be absolute -- the actual
 report id as reported by the device -- or relative --
 HID_REPORT_ID_FIRST for the first report, and (HID_REPORT_ID_NEXT |
-report_id) for the next report after report_id. Without a-priori
+report_id) for the next report after report_id. Without a priori
 information about report ids, the right way to use this ioctl is to
 use the relative IDs above to enumerate the valid IDs. The ioctl
 returns non-zero when there is no more next ID. The real report ID is
@@ -200,7 +200,7 @@ HIDIOCGUCODE
   - struct hiddev_usage_ref (read/write)
 
 Returns the usage_code in a hiddev_usage_ref structure, given that
-given its report type, report id, field index, and index within the
+its report type, report id, field index, and index within the
 field have already been filled into the structure.
 
 HIDIOCGUSAGE
