Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DAB181238
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCKHn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 03:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgCKHn3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 03:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7D96AED6;
        Wed, 11 Mar 2020 07:43:27 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:43:25 +0100
Message-Id: <20200311074325.7922-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311074325.7922-1-tiwai@suse.de>
References: <20200311074325.7922-1-tiwai@suse.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/iio/light/tsl2772.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index be37fcbd4654..44a0b56a558c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
+		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,",
 			chip->tsl2772_device_lux[i].ch0,
 			chip->tsl2772_device_lux[i].ch1);
 		if (chip->tsl2772_device_lux[i].ch0 == 0) {
@@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 		i++;
 	}
 
-	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
+	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
 	return offset;
 }
 
-- 
2.16.4

