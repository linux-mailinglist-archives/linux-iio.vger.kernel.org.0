Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8472CE7FE
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgLDGVR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D01C061A51;
        Thu,  3 Dec 2020 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tifnINnQ0NLHptCKXQmX+jamUjQmXsFh4DRr8z/8b7o=; b=JJhppijuSc3zJdSxQOsDJhUI4f
        QjfPHkaCManBxu7oI5OQtUSKwY0DI6CtR+FyTlBArgdQw2xHkSn0ZXu6Lea21Yw5qUgnGjucjlcO8
        kMGFVFY5YsiUV5Qho6fuedw2zh9v38HNy8BwTtP87j0ag5fsDIjo9eVEHMU5b0IGGkE5V+bk4mGrw
        o2hPXEUhbDFDtH7u6OgVD1pDKvlOoQdlQmfSBFg8DOott1Voxa7kP71FuYwFG4G5mKKHpeTsFt9di
        3AFr7gQwQ4Ja/KVsbuUDtv3M82ENapXD2zs6CVN7ljwxMEmC2DIN6Mm9G/Zix8DMmTfSGOgSxeXjW
        IGDQ1bXg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SH-0002HZ-40; Fri, 04 Dec 2020 06:20:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/8] Documentation: HID: hid-alps editing & corrections
Date:   Thu,  3 Dec 2020 22:20:15 -0800
Message-Id: <20201204062022.5095-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Do basic editing & correction to hid-alps.rst:
- fix grammar
- fix punctuation spacing


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hid-alps.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hid-alps.rst
+++ linux-next-20201201/Documentation/hid/hid-alps.rst
@@ -64,7 +64,7 @@ Case2	ReportID_3	TP	Absolute
 
 Command Read/Write
 ------------------
-To read/write to RAM, need to send a commands to the device.
+To read/write to RAM, need to send a command to the device.
 
 The command format is as below.
 
@@ -80,7 +80,7 @@ Byte6	Value Byte
 Byte7	Checksum
 =====	======================
 
-Command Byte is read=0xD1/write=0xD2 .
+Command Byte is read=0xD1/write=0xD2.
 
 Address is read/write RAM address.
 
