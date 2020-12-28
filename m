Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A42E6B92
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 00:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgL1Wzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 17:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgL1Uy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 15:54:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D3C061799;
        Mon, 28 Dec 2020 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n2g1QeXFiuQZHIxa1jA2LknOcIv8elO1uDDgK0+qeTE=; b=2U1h3avIPKjzpeaYoIAzGsdkqY
        sD5/R41qG90WAojcpvzDVCP1gEqPgJCJgOXyZ9s13aqhD7/pGGWgtG87oANhHfnL3Q14mQoJEDTTY
        JyBZ2dScassFgqWvppDNgI77XPdClTDcJY8gLvBscpRp30zGG9XecRRFJCqegj3927QE4+L5amcTa
        CskUAmCNBKaCU0IsS9T6NMOHfC//l9IYezDTKiP1JN5OP0f4TuMUaUOgjnT7USs+ceVHuyWRBftLO
        kWtlqOfffD8AY487i8OoCvp27MY7XueOzU6feJHlUZdzS5aOsYl1LNhrWFbRS7eU92Y0wr9DaF7yV
        tLwaD01g==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzWT-0002ml-Vf; Mon, 28 Dec 2020 20:53:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/8] Documentation: HID: hiddev editing & corrections
Date:   Mon, 28 Dec 2020 12:53:22 -0800
Message-Id: <20201228205327.1063-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
References: <20201228205327.1063-1-rdunlap@infradead.org>
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
Cc: Jonathan Cameron <jic23@kernel.org>
---
v2: leave hid-core in one place where it might be deliberate. (Jonathan=jic23)

 Documentation/hid/hiddev.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- lnx-511-rc1.orig/Documentation/hid/hiddev.rst
+++ lnx-511-rc1/Documentation/hid/hiddev.rst
@@ -27,7 +27,7 @@ the following::
                           --> hiddev.c ----> POWER / MONITOR CONTROL
 
 In addition, other subsystems (apart from USB) can potentially feed
-events into the input subsystem, but these have no effect on the hid
+events into the input subsystem, but these have no effect on the HID
 device interface.
 
 Using the HID Device Interface
@@ -73,7 +73,7 @@ The hiddev API uses a read() interface,
 HID devices exchange data with the host computer using data
 bundles called "reports".  Each report is divided into "fields",
 each of which can have one or more "usages".  In the hid-core,
-each one of these usages has a single signed 32 bit value.
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
