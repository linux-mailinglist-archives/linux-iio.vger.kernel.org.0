Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44732E6B9A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 00:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgL1Wzy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 17:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbgL1UyV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 15:54:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D11C061793;
        Mon, 28 Dec 2020 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+rwsPNKVBMsHPuzlmKq794q1bunkBRLuFJTK5VEEMG0=; b=Iuebx5jXtKym2o10SIBJ4sVe4a
        RT5SfT0TnwtfeaB7aW17oh2E9JA+2G11JWNGwS8gGPAHh8mFoc3oXaozrw5f5XAi6r4BGEr/P8Nq2
        OXyx6hR1DCaP4ro32Z5i8ZeD40y8PGKTdRSCDwCKo/lJDfB+OJLEPRp1n57Eg9ow27rs9Zk5B6YAK
        bk7qjelrUUU73Ityncxu4yu5BxdY95BCOt8vKlEl/mq3pON/Q1Bjzvy43645IafL7M6I7uBCvud8m
        H5Bb42czwMYx5rEyXjM4KphXrx2usW6KifofdfxTdqVU9If4QMm6nAa18zTDLCWUP3dfcrhDaLSw4
        gXqFJu5w==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzWM-0002ml-SL; Mon, 28 Dec 2020 20:53:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/8] Documentation: HID: hid-alps editing & corrections
Date:   Mon, 28 Dec 2020 12:53:20 -0800
Message-Id: <20201228205327.1063-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
References: <20201228205327.1063-1-rdunlap@infradead.org>
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
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-doc@vger.kernel.org
---
v2: rebase & resend

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
 
