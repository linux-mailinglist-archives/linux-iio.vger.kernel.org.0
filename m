Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5475318120D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 08:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKHi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 03:38:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHi1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 03:38:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F247AD72;
        Wed, 11 Mar 2020 07:38:25 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH] HID: hid-sensor-custom: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:38:24 +0100
Message-Id: <20200311073824.7431-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/hid/hid-sensor-custom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index fb827c295842..4d25577a8573 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -313,7 +313,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 
 			while (i < ret) {
 				if (i + attribute->size > ret) {
-					len += snprintf(&buf[len],
+					len += scnprintf(&buf[len],
 							PAGE_SIZE - len,
 							"%d ", values[i]);
 					break;
@@ -336,10 +336,10 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 					++i;
 					break;
 				}
-				len += snprintf(&buf[len], PAGE_SIZE - len,
+				len += scnprintf(&buf[len], PAGE_SIZE - len,
 						"%lld ", value);
 			}
-			len += snprintf(&buf[len], PAGE_SIZE - len, "\n");
+			len += scnprintf(&buf[len], PAGE_SIZE - len, "\n");
 
 			return len;
 		} else if (input)
-- 
2.16.4

