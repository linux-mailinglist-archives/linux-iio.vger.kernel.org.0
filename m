Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1145B186B64
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgCPMtp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:49:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731086AbgCPMtp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 08:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E0B5AD14;
        Mon, 16 Mar 2020 12:49:43 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow
Date:   Mon, 16 Mar 2020 13:49:41 +0100
Message-Id: <20200316124941.8010-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200316124941.8010-1-tiwai@suse.de>
References: <20200316124941.8010-1-tiwai@suse.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

snprintf() is a hard-to-use function, it's especially difficult to use
it for concatenating substrings in a buffer with a limited size.
Since snprintf() returns the would-be-output size, not the actual
size, the subsequent use of snprintf() may go beyond the given limit
easily.  Although the current code doesn't actually overflow the
buffer, it's an incorrect usage.

This patch replaces such snprintf() calls with a safer version,
scnprintf().

Also this fixes the incorrect argument of the buffer limit size passed
to snprintf(), too.  The size has to be decremented for the remaining
length.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Fix the snprintf() buffer limit argument
        Rephrase the changelog

 drivers/iio/light/tsl2772.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index be37fcbd4654..9fbde9b71b63 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -932,7 +932,7 @@ static ssize_t in_illuminance0_target_input_show(struct device *dev,
 {
 	struct tsl2772_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
 }
 
 static ssize_t in_illuminance0_target_input_store(struct device *dev,
@@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
+		offset += scnprintf(buf + offset, PAGE_SIZE - offset, "%u,%u,",
 			chip->tsl2772_device_lux[i].ch0,
 			chip->tsl2772_device_lux[i].ch1);
 		if (chip->tsl2772_device_lux[i].ch0 == 0) {
@@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 		i++;
 	}
 
-	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
+	offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n");
 	return offset;
 }
 
-- 
2.16.4

