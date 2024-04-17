Return-Path: <linux-iio+bounces-4304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742158A8951
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FC3282121
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881E17107B;
	Wed, 17 Apr 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn4Slse3"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150B17106C
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372395; cv=none; b=LH5it28mXf+xf2EtZmEkASypcKbw1Qxd2AP3XooG/WVZzT4zesEcDtX5gGkVf0GPLJk0Nv+DSlsAlDfE0OPyD6ajYu/zzH+76f4/qTfYjUHKlt4bjZZ/1M5EAeloPKX+uzinIinCuOD2JT9cD9V7PWs2B/EteZgCYyqkCvBGVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372395; c=relaxed/simple;
	bh=aAFwxEH9B04eDbJYtJ1Hy7LMAWj5FCYFYLDchXUy0dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfCCyiPkgEq7Gy8l7I49Jj0Ia5tJJrC8iJ4kwfvU2HkovSe9zgIpyZqFsCUYXDusVfHyFLg4Q7SwLpT0Kuid+A2lohR6twqoUFKhWAHLLHRmWAR7Au8giAcV8QOgccw8Vv85KXZOt531Vkp5tJTHTVwEsIOV6o+UdYVhXLbE5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vn4Slse3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QDLQob6Cd6fzwRXQb40w2r9Vkd42hTzyinA+naePrA=;
	b=Vn4Slse3qWOP5VBjql6e3+I7MpfBjJgo5GDb7/t6aj0hbA3AC4ih7XVC3BYJjGEUoOrY2e
	nMfFyVpRmMD2Ue4LLznQN/7Wlzjp2o7ZcE6v8/W87LLKkXBqh4LmgPu9yAnRENXEyR1S+S
	oYhmnNSFCiES+gHYvx1CP1cFZF/IDZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-FPFbip6GP9W5WbMtVLT0NA-1; Wed, 17 Apr 2024 12:46:28 -0400
X-MC-Unique: FPFbip6GP9W5WbMtVLT0NA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A48D834FB4;
	Wed, 17 Apr 2024 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6FDF2166B36;
	Wed, 17 Apr 2024 16:46:27 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/4] iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
Date: Wed, 17 Apr 2024 18:46:13 +0200
Message-ID: <20240417164616.74651-2-hdegoede@redhat.com>
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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


