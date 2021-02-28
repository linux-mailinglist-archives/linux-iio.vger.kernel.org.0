Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B0326FF7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 02:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhB1Bd3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 20:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhB1Bd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Feb 2021 20:33:27 -0500
Received: from chill.innovation.ch (chill.innovation.ch [IPv6:2001:470:1:5ba:222:15ff:fecf:4ca5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AF0C061786
        for <linux-iio@vger.kernel.org>; Sat, 27 Feb 2021 17:32:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id B874A6400FF;
        Sat, 27 Feb 2021 17:26:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at innovation.ch
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sP_JG41WKqpK; Sat, 27 Feb 2021 17:26:53 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch D413964017A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1614475613;
        bh=VihNzrk+xZI9VyDVaU3pAXqdSqJuCqNPnc2U8RvcdUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e60bTeDiKKSMFrnhvt1pMyeNYxlI0QXH23gUq5nV1VM8fLqav100RnJAkwUbzSWgd
         lRHtTKpytDyRHGBhi8kz91aLDMLpbJgTW5jwWOmHtpdKENsu2bPAZiEQ2yu0KbI0sQ
         yDngzx4DZhcTb8TLPH92r91uSGKhi6lXjWJjD6E4Nd2MKz/nYMpYJ19/NsHyF+lMdR
         RdoLVTGdKbWiv/O8ZJT2PNwEUnYn4uyx0qTJP88xLsjst9lKVBsLmRTx+/oAX5zVuL
         CC+kvAilTVFhBNu2UfApmDvsCfXKYnMa4Zw67pQKvIVT1JtM0TlhfENPJJUhTByQ4n
         mrxd00LWI2g3Q==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/5] HID: Recognize sensors with application collections too.
Date:   Sat, 27 Feb 2021 17:26:39 -0800
Message-Id: <20210228012643.69944-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210228012643.69944-1-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to HUTRR39 logical sensor devices may be nested inside
physical collections or may be specified in multiple top-level
application collections (see page 59, strategies 1 and 2). However,
the current code was only recognizing those with physical collections.

This issue turned up in recent MacBook Pro's which define the ALS in
a top-level application collection.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/hid/hid-core.c       | 3 ++-
 drivers/hid/hid-sensor-hub.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 56172fe6995cd..a96b252f97366 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -799,7 +799,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	int i;
 
 	if (((parser->global.usage_page << 16) == HID_UP_SENSOR) &&
-	    type == HID_COLLECTION_PHYSICAL)
+	    (type == HID_COLLECTION_PHYSICAL ||
+	     type == HID_COLLECTION_APPLICATION))
 		hid->group = HID_GROUP_SENSOR_HUB;
 
 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3dd7d32467378..9aea558407794 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -393,7 +393,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 		for (i = 0; i < report->maxfield; ++i) {
 			field = report->field[i];
 			if (field->maxusage) {
-				if (field->physical == usage_id &&
+				if ((field->physical == usage_id ||
+				     field->application == usage_id) &&
 					(field->logical == attr_usage_id ||
 					field->usage[0].hid ==
 							attr_usage_id) &&
@@ -502,7 +503,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					collection->usage);
 
 		callback = sensor_hub_get_callback(hdev,
-				report->field[i]->physical,
+				report->field[i]->physical ?:
+					report->field[i]->application,
 				report->field[i]->usage[0].collection_index,
 				&hsdev, &priv);
 		if (!callback) {
-- 
2.26.2

