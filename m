Return-Path: <linux-iio+bounces-2327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE584EA38
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 22:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334302857C3
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAF4EB38;
	Thu,  8 Feb 2024 21:21:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from queue02b.mail.zen.net.uk (queue02b.mail.zen.net.uk [212.23.3.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1A381D3
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427263; cv=none; b=WTFpZimSEa375wrsGU0UMO7CH0f+ihkIUU/51G209COTdGhnTXkpUg1QnybxM9hSowLNoVXR5dcLneVx+N5oXwTHB0Zx38uD7/yB7YqLHIfC+L0IVJTMXTlXOHF7lZpDkDe4TDZIYS7AHKqQOiExog0fbaJTjEUm0j9v7kePfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427263; c=relaxed/simple;
	bh=0D1EOhGzdw9h96+nas6ReoxJ700RKruKQDCZ0EZNDIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mk7I19gvoc61CRkFqk48ELCOBpUcHlI10PSxEllkodn0nYpBfjQf9vqjodUEspgm25rOJAGT+bBJawYBfoKJ4JoFSYcQPL0UDZ1PtBBbsZXFHd1waBfXAcPj6Qtm0kpPUpUi8QOfscJlws7Ehd8yzJgV7nikHFLeVndFTyxHfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
	by queue02b.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rYBYd-002vtx-9W
	for linux-iio@vger.kernel.org;
	Thu, 08 Feb 2024 21:03:43 +0000
Received: from [217.155.46.38] (helo=starbook..)
	by smarthost01b.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rYBYO-00DXoN-EY;
	Thu, 08 Feb 2024 21:03:28 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-iio@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] drivers/iio/accel/kxcjk-1013: Retrieve mount-matrix from ACPI Implement kxj_acpi_orientation to retrieve mount matrix from ACPI ROTM method
Date: Thu,  8 Feb 2024 21:03:26 +0000
Message-Id: <560489c23cb702e60d4f32c5b6c9f758d39841d2.1707426098.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/iio/accel/kxcjk-1013.c | 86 ++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..f5ac06d5566c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -619,6 +619,83 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static bool kxj_acpi_orientation(struct device *dev,
+				 struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *str;
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+	bool ret = false;
+
+	if (!acpi_has_method(adev->handle, "ROTM")) {
+		return false;
+	}
+
+	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		goto out;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
+		dev_err(dev, "Unknown ACPI mount matrix package format\n");
+		goto out;
+	}
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING) {
+			dev_err(dev, "Unknown ACPI mount matrix element format\n");
+			goto out;
+		}
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
+			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
+			goto out;
+		}
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default: goto unknown_format;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	ret = true;
+
+out:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static bool kxj1009_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev && acpi_dev_hid_uid_match(adev, "KIOX000A", NULL))
+		return kxj_acpi_orientation(dev, orientation);
+
+	return false;
+}
+#else
+static bool kxj1009_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	return false;
+}
+#endif
+
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -1449,9 +1526,12 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		ret = iio_read_mount_matrix(&client->dev, &data->orientation);
-		if (ret)
-			return ret;
+		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation)) {
+			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+			if (ret)
+				return ret;
+		}
+
 	}
 
 	ret = devm_regulator_bulk_get_enable(&client->dev,
-- 
2.40.1


