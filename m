Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865238DBFF
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEWRCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbhEWRCp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mkhx/g9o1+KLwCNNf6XwuWbTEXPk9QmgZx7ph3jkix0=;
        b=asvJ0MoAmWHq1Q/UNGM1iCNMRF+7gN53aWu9hX9LFy9hBNarYsF6bheroIZ4ImN772rFC1
        a/CPfZJ2M9N6pRl1muRNUzn3BZJGH0lUG3I9WhTE6rkH3aTeNqHtaUQZh3f0K91xcCjcDp
        io4JzdD0+0w4bGwfJNmLUU/qRUkiit4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-blodlv6RNmC6H7b_1v3LEQ-1; Sun, 23 May 2021 13:01:16 -0400
X-MC-Unique: blodlv6RNmC6H7b_1v3LEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C77501F4;
        Sun, 23 May 2021 17:01:15 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25C4E5D9F2;
        Sun, 23 May 2021 17:01:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 5/9] iio: accel: bmc150: Move struct bmc150_accel_data definition to bmc150-accel.h
Date:   Sun, 23 May 2021 19:00:59 +0200
Message-Id: <20210523170103.176958-6-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Further patches to bmc150-accel-i2c.c need to store some extra info
(on top of the second_dev pointer) in the bmc150_accel_data struct,
rather then adding yet more accessor functions for this lets just
move the struct bmc150_accel_data definition to bmc150-accel.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 53 -----------------------
 drivers/iio/accel/bmc150-accel.h      | 61 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 8ff358c37a81..0d76df9e08eb 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -157,59 +157,6 @@ struct bmc150_accel_chip_info {
 	const struct bmc150_scale_info scale_table[4];
 };
 
-struct bmc150_accel_interrupt {
-	const struct bmc150_accel_interrupt_info *info;
-	atomic_t users;
-};
-
-struct bmc150_accel_trigger {
-	struct bmc150_accel_data *data;
-	struct iio_trigger *indio_trig;
-	int (*setup)(struct bmc150_accel_trigger *t, bool state);
-	int intr;
-	bool enabled;
-};
-
-enum bmc150_accel_interrupt_id {
-	BMC150_ACCEL_INT_DATA_READY,
-	BMC150_ACCEL_INT_ANY_MOTION,
-	BMC150_ACCEL_INT_WATERMARK,
-	BMC150_ACCEL_INTERRUPTS,
-};
-
-enum bmc150_accel_trigger_id {
-	BMC150_ACCEL_TRIGGER_DATA_READY,
-	BMC150_ACCEL_TRIGGER_ANY_MOTION,
-	BMC150_ACCEL_TRIGGERS,
-};
-
-struct bmc150_accel_data {
-	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
-	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
-	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
-	struct mutex mutex;
-	u8 fifo_mode, watermark;
-	s16 buffer[8];
-	/*
-	 * Ensure there is sufficient space and correct alignment for
-	 * the timestamp if enabled
-	 */
-	struct {
-		__le16 channels[3];
-		s64 ts __aligned(8);
-	} scan;
-	u8 bw_bits;
-	u32 slope_dur;
-	u32 slope_thres;
-	u32 range;
-	int ev_enable_state;
-	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
-	const struct bmc150_accel_chip_info *chip_info;
-	struct i2c_client *second_device;
-	struct iio_mount_matrix orientation;
-};
-
 static const struct {
 	int val;
 	int val2;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e30c1698f6fb..f503c5b5801e 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -2,7 +2,68 @@
 #ifndef _BMC150_ACCEL_H_
 #define _BMC150_ACCEL_H_
 
+#include <linux/atomic.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+
 struct regmap;
+struct i2c_client;
+struct bmc150_accel_chip_info;
+struct bmc150_accel_interrupt_info;
+
+struct bmc150_accel_interrupt {
+	const struct bmc150_accel_interrupt_info *info;
+	atomic_t users;
+};
+
+struct bmc150_accel_trigger {
+	struct bmc150_accel_data *data;
+	struct iio_trigger *indio_trig;
+	int (*setup)(struct bmc150_accel_trigger *t, bool state);
+	int intr;
+	bool enabled;
+};
+
+enum bmc150_accel_interrupt_id {
+	BMC150_ACCEL_INT_DATA_READY,
+	BMC150_ACCEL_INT_ANY_MOTION,
+	BMC150_ACCEL_INT_WATERMARK,
+	BMC150_ACCEL_INTERRUPTS,
+};
+
+enum bmc150_accel_trigger_id {
+	BMC150_ACCEL_TRIGGER_DATA_READY,
+	BMC150_ACCEL_TRIGGER_ANY_MOTION,
+	BMC150_ACCEL_TRIGGERS,
+};
+
+struct bmc150_accel_data {
+	struct regmap *regmap;
+	struct regulator_bulk_data regulators[2];
+	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
+	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
+	struct mutex mutex;
+	u8 fifo_mode, watermark;
+	s16 buffer[8];
+	/*
+	 * Ensure there is sufficient space and correct alignment for
+	 * the timestamp if enabled
+	 */
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+	u8 bw_bits;
+	u32 slope_dur;
+	u32 slope_thres;
+	u32 range;
+	int ev_enable_state;
+	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
+	const struct bmc150_accel_chip_info *chip_info;
+	struct i2c_client *second_device;
+	struct iio_mount_matrix orientation;
+};
 
 enum {
 	bmc150,
-- 
2.31.1

