Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D600F31BE47
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhBOQFJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 11:05:09 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54195 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232006AbhBOPzW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:55:22 -0500
Received: from tech.aim-sportline.com ([185.56.157.72]:34080 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lBeyF-00GYMx-ON; Mon, 15 Feb 2021 15:35:27 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/5] docs: iio: fix bullet list formatting
Date:   Mon, 15 Feb 2021 15:35:10 +0100
Message-Id: <20210215143511.25471-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215143511.25471-1-luca@lucaceresoli.net>
References: <20210215143511.25471-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This 2nd-level bullet list is not properly ReST-formatted and thus it gets
rendered as a unique paragraph quite unreadable.  Fix by adding spaces as
needed.

While there also swap "shift" and "repeat" so they are in the correct
order.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/iio/buffers.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 9dad7c94034b..5801caf216a6 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -38,15 +38,16 @@ attributes of the following form:
 * :file:`type`, description of the scan element data storage within the buffer
   and hence the form in which it is read from user space.
   Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift] .
+
   * *be* or *le*, specifies big or little endian.
   * *s* or *u*, specifies if signed (2's complement) or unsigned.
   * *bits*, is the number of valid data bits.
   * *storagebits*, is the number of bits (after padding) that it occupies in the
-  buffer.
-  * *shift*, if specified, is the shift that needs to be applied prior to
-  masking out unused bits.
+    buffer.
   * *repeat*, specifies the number of bits/storagebits repetitions. When the
-  repeat element is 0 or 1, then the repeat value is omitted.
+    repeat element is 0 or 1, then the repeat value is omitted.
+  * *shift*, if specified, is the shift that needs to be applied prior to
+    masking out unused bits.
 
 For example, a driver for a 3-axis accelerometer with 12 bit resolution where
 data is stored in two 8-bits registers as follows::
@@ -123,4 +124,3 @@ More details
 .. kernel-doc:: include/linux/iio/buffer.h
 .. kernel-doc:: drivers/iio/industrialio-buffer.c
    :export:
-
-- 
2.30.0

