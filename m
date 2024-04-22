Return-Path: <linux-iio+bounces-4425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137F8ACA29
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BA2834A7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791013D623;
	Mon, 22 Apr 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxyAzxYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBB52F96
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780152; cv=none; b=RRH8N298gZWP/6SxgoeiSzuYek1X1wEDjx6xd2kBsE94h7WXp11WQW8+lgV7a5eeMzh9hHH2ggzGefBtJKgbMZd6R1e1x+dBTg5T/0NeYafHOuxGTDMBKJ+USufbTDcmCEzAJ5miTIpk91nkQqxRibVV8Pf9Y+hGjAILov0YWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780152; c=relaxed/simple;
	bh=JRLv+7c6/54HDoGYrbdHXHSK8O4NnP+tTLDS2tZlvxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMz3mK6uq9gdATvrb3tVaIdKrgwsLLti6C5uFMroNPb9vJPclPr5L7Zv43WvCBbuSfzZf/P9Uz19IOtueSDWmK5iv5ZIvBbPQRPu/4UacukLTRdT17W3pvKgwC486p/TZzMuNQNRu+syekVOmGptu/nxm9ORN2LRb+r+gzpZjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxyAzxYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCvduDYfaBEzJg7iPTcnkiyhAz7LjPATOqpFPP2ip+k=;
	b=QxyAzxYkb7WNy9QfUw1n5jMa2BX59grkUEKd39c5M+7KW6SoKyLrXIjVeSZoVtZQuIcpdf
	mIecaMLuOo9mitlPOPRhWWw0Wvthp2eJsw9DbSm9IS7LSpIUxRRKfGJj5iHisM7/mcwls8
	at9kl094e3l1dSQ7nUnY8Ze9ibbgoik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Xn71PnciPfS0PSnNXqt9Fg-1; Mon, 22 Apr 2024 06:02:26 -0400
X-MC-Unique: Xn71PnciPfS0PSnNXqt9Fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DDC1811003;
	Mon, 22 Apr 2024 10:02:26 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3508F44049;
	Mon, 22 Apr 2024 10:02:25 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 3/4] iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
Date: Mon, 22 Apr 2024 12:02:17 +0200
Message-ID: <20240422100218.7693-4-hdegoede@redhat.com>
In-Reply-To: <20240422100218.7693-1-hdegoede@redhat.com>
References: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Replace the duplicate ACPI "ROTM" data parsing code with the new
shared acpi_read_mount_matrix() helper.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 45 ++-------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 110591804b4c..ace550b0ba40 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -23,6 +23,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include "acpi-helpers.h"
 #include "bmc150-accel.h"
 
 #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
@@ -386,13 +387,9 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 						   struct iio_mount_matrix *orientation)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	char *name, *alt_name, *label, *str;
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
+	char *name, *alt_name, *label;
 
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
 		alt_name = "ROMK";
@@ -411,43 +408,7 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 		return false;
 	}
 
-	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
-		return false;
-	}
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
-		goto unknown_format;
-
-	elements = obj->package.elements;
-	for (i = 0; i < 3; i++) {
-		if (elements[i].type != ACPI_TYPE_STRING)
-			goto unknown_format;
-
-		str = elements[i].string.pointer;
-		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
-			goto unknown_format;
-
-		for (j = 0; j < 3; j++) {
-			switch (val[j]) {
-			case -1: str = "-1"; break;
-			case 0:  str = "0";  break;
-			case 1:  str = "1";  break;
-			default: goto unknown_format;
-			}
-			orientation->rotation[i * 3 + j] = str;
-		}
-	}
-
-	kfree(buffer.pointer);
-	return true;
-
-unknown_format:
-	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
-	kfree(buffer.pointer);
-	return false;
+	return acpi_read_mount_matrix(dev, orientation, name);
 }
 
 static bool bmc150_apply_dual250e_acpi_orientation(struct device *dev,
-- 
2.44.0


