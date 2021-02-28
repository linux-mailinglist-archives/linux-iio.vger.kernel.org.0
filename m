Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A83326FF5
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 02:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhB1Bda (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 20:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhB1Bd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Feb 2021 20:33:27 -0500
Received: from chill.innovation.ch (chill.innovation.ch [IPv6:2001:470:1:5ba:222:15ff:fecf:4ca5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A500C06174A
        for <linux-iio@vger.kernel.org>; Sat, 27 Feb 2021 17:32:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 7F083641289;
        Sat, 27 Feb 2021 17:26:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at innovation.ch
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id q6_hZsrfokZm; Sat, 27 Feb 2021 17:26:54 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch B2863640198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1614475614;
        bh=pfSfoLaMQP0QU7DUkoypwKopPbKseRDwMDeGRCldQy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W90Qp4C+lwW+UE4T8+XErrQ0pAzm8D7nfY1O7asSFqG/M8lCSDUzymswnhYbAUHFs
         IpS14OoBo+KI2aoSfqHpbi7m/LSG7KLkLkw8nROgNKkSYOUClIu1mTIuyGhXx/jAoZ
         sKM07gAVNvnPWFDPFXvkdQaXyEXY6TaUg88Ow9/9D0TAxmrx7c9eDqxgDl45AQHycf
         EOcW/J5ktBENOwXtTXHBNuAS3JQPZAtex3PCMqxCusLSf6qIy6AmOfV4B2U1Xvo2be
         lJMoJrxVmUSrPMca2owcYFf3rIGY+bRg2Nnfn2kU7nvL1RiIQz426i979vBZ5BsnE8
         JSc6uLjYjsZQg==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/5] HID: core: Export some report item parsing functions.
Date:   Sat, 27 Feb 2021 17:26:41 -0800
Message-Id: <20210228012643.69944-4-ronald@innovation.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210228012643.69944-1-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These are useful to drivers that need to scan or parse reports
themselves.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/hid/hid-core.c | 54 +++++++++++++++++++++++++-----------------
 include/linux/hid.h    |  4 ++++
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a96b252f97366..b4c3d71a0ddda 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -340,7 +340,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
  * Read data value from item.
  */
 
-static u32 item_udata(struct hid_item *item)
+u32 hid_item_udata(struct hid_item *item)
 {
 	switch (item->size) {
 	case 1: return item->data.u8;
@@ -349,8 +349,9 @@ static u32 item_udata(struct hid_item *item)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hid_item_udata);
 
-static s32 item_sdata(struct hid_item *item)
+s32 hid_item_sdata(struct hid_item *item)
 {
 	switch (item->size) {
 	case 1: return item->data.s8;
@@ -359,6 +360,7 @@ static s32 item_sdata(struct hid_item *item)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hid_item_sdata);
 
 /*
  * Process a global item.
@@ -391,29 +393,29 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_USAGE_PAGE:
-		parser->global.usage_page = item_udata(item);
+		parser->global.usage_page = hid_item_udata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_LOGICAL_MINIMUM:
-		parser->global.logical_minimum = item_sdata(item);
+		parser->global.logical_minimum = hid_item_sdata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_LOGICAL_MAXIMUM:
 		if (parser->global.logical_minimum < 0)
-			parser->global.logical_maximum = item_sdata(item);
+			parser->global.logical_maximum = hid_item_sdata(item);
 		else
-			parser->global.logical_maximum = item_udata(item);
+			parser->global.logical_maximum = hid_item_udata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_PHYSICAL_MINIMUM:
-		parser->global.physical_minimum = item_sdata(item);
+		parser->global.physical_minimum = hid_item_sdata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM:
 		if (parser->global.physical_minimum < 0)
-			parser->global.physical_maximum = item_sdata(item);
+			parser->global.physical_maximum = hid_item_sdata(item);
 		else
-			parser->global.physical_maximum = item_udata(item);
+			parser->global.physical_maximum = hid_item_udata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
@@ -421,7 +423,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		 * nibble due to the common misunderstanding of HID
 		 * specification 1.11, 6.2.2.7 Global Items. Attempt to handle
 		 * both this and the standard encoding. */
-		raw_value = item_sdata(item);
+		raw_value = hid_item_sdata(item);
 		if (!(raw_value & 0xfffffff0))
 			parser->global.unit_exponent = hid_snto32(raw_value, 4);
 		else
@@ -429,11 +431,11 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT:
-		parser->global.unit = item_udata(item);
+		parser->global.unit = hid_item_udata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
-		parser->global.report_size = item_udata(item);
+		parser->global.report_size = hid_item_udata(item);
 		if (parser->global.report_size > 256) {
 			hid_err(parser->device, "invalid report_size %d\n",
 					parser->global.report_size);
@@ -442,7 +444,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_COUNT:
-		parser->global.report_count = item_udata(item);
+		parser->global.report_count = hid_item_udata(item);
 		if (parser->global.report_count > HID_MAX_USAGES) {
 			hid_err(parser->device, "invalid report_count %d\n",
 					parser->global.report_count);
@@ -451,7 +453,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_ID:
-		parser->global.report_id = item_udata(item);
+		parser->global.report_id = hid_item_udata(item);
 		if (parser->global.report_id == 0 ||
 		    parser->global.report_id >= HID_MAX_IDS) {
 			hid_err(parser->device, "report_id %u is invalid\n",
@@ -476,7 +478,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 	unsigned n;
 	__u32 count;
 
-	data = item_udata(item);
+	data = hid_item_udata(item);
 
 	switch (item->tag) {
 	case HID_LOCAL_ITEM_TAG_DELIMITER:
@@ -608,7 +610,7 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
 
 	hid_concatenate_last_usage_page(parser);
 
-	data = item_udata(item);
+	data = hid_item_udata(item);
 
 	switch (item->tag) {
 	case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
@@ -707,12 +709,19 @@ static void hid_device_release(struct device *dev)
 	kfree(hid);
 }
 
-/*
+/**
+ * hid_fetch_item - fetch an item from a report
+ *
+ * @start: the current position in the report buffer to read the next item from
+ * @end: the end of the report buffer
+ * @item: the item struct to fill in
+ *
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
+ *
+ * Return: the position of the next item in the report
  */
-
-static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
+u8 *hid_fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 {
 	u8 b;
 
@@ -773,6 +782,7 @@ static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(hid_fetch_item);
 
 static void hid_scan_input_usage(struct hid_parser *parser, u32 usage)
 {
@@ -831,7 +841,7 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
 
 	hid_concatenate_last_usage_page(parser);
 
-	data = item_udata(item);
+	data = hid_item_udata(item);
 
 	switch (item->tag) {
 	case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
@@ -891,7 +901,7 @@ static int hid_scan_report(struct hid_device *hid)
 	 * be robust against hid errors. Those errors will be raised by
 	 * hid_open_report() anyway.
 	 */
-	while ((start = fetch_item(start, end, &item)) != NULL)
+	while ((start = hid_fetch_item(start, end, &item)) != NULL)
 		dispatch_type[item.type](parser, &item);
 
 	/*
@@ -1250,7 +1260,7 @@ int hid_open_report(struct hid_device *device)
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 
 	ret = -EINVAL;
-	while ((next = fetch_item(start, end, &item)) != NULL) {
+	while ((next = hid_fetch_item(start, end, &item)) != NULL) {
 		start = next;
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c39d71eb1fd0a..919f595084610 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -898,6 +898,10 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
 				       unsigned int field_index,
 				       unsigned int report_counts);
 
+u32 hid_item_udata(struct hid_item *item);
+s32 hid_item_sdata(struct hid_item *item);
+u8 *hid_fetch_item(__u8 *start, __u8 *end, struct hid_item *item);
+
 void hid_setup_resolution_multiplier(struct hid_device *hid);
 int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
-- 
2.26.2

