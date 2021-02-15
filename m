Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC231BD7E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 16:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhBOPsW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 10:48:22 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52575 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231487AbhBOPqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:46:09 -0500
X-Greylist: delayed 4191 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 10:46:02 EST
Received: from tech.aim-sportline.com ([185.56.157.72]:34080 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lBeyG-00GYMx-0T; Mon, 15 Feb 2021 15:35:28 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/5] docs: iio: mark "repeat" sysfs attribute as optional
Date:   Mon, 15 Feb 2021 15:35:11 +0100
Message-Id: <20210215143511.25471-6-luca@lucaceresoli.net>
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

Show that this field is optional, just like the shift value.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/iio/buffers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 5801caf216a6..e83026aebe97 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -37,7 +37,7 @@ attributes of the following form:
 * :file:`index`, the scan_index of the channel.
 * :file:`type`, description of the scan element data storage within the buffer
   and hence the form in which it is read from user space.
-  Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift] .
+  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
 
   * *be* or *le*, specifies big or little endian.
   * *s* or *u*, specifies if signed (2's complement) or unsigned.
-- 
2.30.0

