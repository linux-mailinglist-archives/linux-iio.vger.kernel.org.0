Return-Path: <linux-iio+bounces-4424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4728ACA25
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40D61F22ABF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0513CFB7;
	Mon, 22 Apr 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gijy1g6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644152F96
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780150; cv=none; b=Sw1hmO4hEulckmgkzOJA7/UjmmbpPavN6B4PaoGIZIHOTKRbkOlLn8YgZ4cs1H1j+x2JR2eyMRLFTnt5TsWvb9KDnp2mh8ACmYJB9h92xO1aOPVybPfurmyGaMST7IlLmeJavuUeTEFAYULRVzda5RHjM26YXods5vg8cFs/CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780150; c=relaxed/simple;
	bh=aAFwxEH9B04eDbJYtJ1Hy7LMAWj5FCYFYLDchXUy0dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgUWT8USHgNhDBxZ6El/6d/2JwJ02lP/TmG0iuWjkvN9+/quU1JzKAQJZReAwwoVU+dFw0Je7WIiQzqmXzXz08ZLITYGgPBAD7udbVz8aGeplOIAjGyjemrJDhMuEVmk02L0MXbTHSeT65jEhWYtyQNZAxd6mKfLbwsZZUaMihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gijy1g6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QDLQob6Cd6fzwRXQb40w2r9Vkd42hTzyinA+naePrA=;
	b=Gijy1g6YWe/Tfdyj61W5+IYc1I8CMAQgv7ItZuuQfWKFgVitVVxeUq65Pc1p8gVc6GlDrB
	ZaHGZVmJEUJ1V99/LLU7n2g7Ot8CYymCxD665E/xKtxtyKt9JXAqxxH1eIgclmWm5Utp2+
	FOA6XiElXOjevSaOQQQ6ljVqEF6wn74=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-BY-zrGTKMD6zhn6hb5uuRQ-1; Mon,
 22 Apr 2024 06:02:23 -0400
X-MC-Unique: BY-zrGTKMD6zhn6hb5uuRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72A9A3C0278A;
	Mon, 22 Apr 2024 10:02:23 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E21C143FAD;
	Mon, 22 Apr 2024 10:02:21 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/4] iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
Date: Mon, 22 Apr 2024 12:02:15 +0200
Message-ID: <20240422100218.7693-2-hdegoede@redhat.com>
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

There is no reason to limit the parsing of the ROTM mount matrix to only
ACPI devices with an ACPI HID (Hardware-ID) of "KIOX000A". If kxcjk-1013
ACPI devices with another HID have a ROTM method that should still be
parsed and if the method is not there then the:

	if (!adev || !acpi_has_method(adev->handle, "ROTM"))
		return false;

check will skip checking the ROTM method silently.

Move the check to see if there is an ACPI companion at all into
kxj_acpi_orientation() and drop the wrapper checking the HID.

Cc: Sean Rhodes <sean@starlabs.systems>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 126e8bdd6d0e..bb1660667bb0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -637,8 +637,8 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 }
 
 #ifdef CONFIG_ACPI
-static bool kxj_acpi_orientation(struct device *dev,
-				 struct iio_mount_matrix *orientation)
+static bool kxj1009_apply_acpi_orientation(struct device *dev,
+					   struct iio_mount_matrix *orientation)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device *adev = ACPI_COMPANION(dev);
@@ -648,7 +648,7 @@ static bool kxj_acpi_orientation(struct device *dev,
 	int i, j, val[3];
 	bool ret = false;
 
-	if (!acpi_has_method(adev->handle, "ROTM"))
+	if (!adev || !acpi_has_method(adev->handle, "ROTM"))
 		return false;
 
 	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
@@ -695,17 +695,6 @@ static bool kxj_acpi_orientation(struct device *dev,
 	kfree(buffer.pointer);
 	return ret;
 }
-
-static bool kxj1009_apply_acpi_orientation(struct device *dev,
-					  struct iio_mount_matrix *orientation)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	if (adev && acpi_dev_hid_uid_match(adev, "KIOX000A", NULL))
-		return kxj_acpi_orientation(dev, orientation);
-
-	return false;
-}
 #else
 static bool kxj1009_apply_acpi_orientation(struct device *dev,
 					  struct iio_mount_matrix *orientation)
-- 
2.44.0


