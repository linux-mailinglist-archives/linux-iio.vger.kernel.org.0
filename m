Return-Path: <linux-iio+bounces-2474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C263851612
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764CD1C233AC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7E41760;
	Mon, 12 Feb 2024 13:47:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from queue02c.mail.zen.net.uk (queue02c.mail.zen.net.uk [212.23.3.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F363C060
	for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745645; cv=none; b=F0Jx8hXuYw3eX/yHujzTH6eq3JcrUqAMFsG+FVR8X1lJ/zq7Xy3gM6MpNKbiUb3DTc/ZbuJkNaqctHd3raPDQSXtofimRP2Vd/wod3Kf2MXVS911DXg8Cn7SX7BqFNCsPNoEdjAYiLoPfHnhJJdeNKp4KGOhjot2dfFTqTIWw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745645; c=relaxed/simple;
	bh=2qmZv4GFkXYxX5RnjL9mKiAC90jSUAyFcssJvZEWl2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bja57mtxTDC55dBZdv8VC7/OxrPGHlU8Usmcqw7s0ALSPtS1VlpwcGxUvAbpEq2k3cMGFV730PnAemORCadqwzHEd7xfSKz7u0L7r6Unx47mSkPAP67NTWvyEIyANtXyv7jaXvvbm5J0F3HFdwz9riG8oO0GZBdYKY7cQS8IV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.1] (helo=smarthost01a.sbp.mail.zen.net.uk)
	by queue02c.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rZWOS-001usJ-7P
	for linux-iio@vger.kernel.org;
	Mon, 12 Feb 2024 13:30:43 +0000
Received: from [51.148.147.4] (helo=starbook..)
	by smarthost01a.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rZWOD-000TJ1-Lh;
	Mon, 12 Feb 2024 13:30:29 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-iio@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] iio: accel: kxcjk-1013: Implement ACPI method ROTM to retrieve mount matrix.
Date: Mon, 12 Feb 2024 13:30:26 +0000
Message-Id: <ecf63cc9cc99eb4a9d813b11d976547eb3a610bd.1707744504.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01a-IP: [51.148.147.4]
Feedback-ID: 51.148.147.4

Implement kxj_acpi_orientation to retrieve mount matrix
from ACPI ROTM method

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/iio/accel/kxcjk-1013.c | 87 ++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..864c27fa75bc 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -619,6 +619,84 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
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
+	if (!acpi_has_method(adev->handle, "ROTM"))
+		return false;
+
+	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		goto out_free_buffer;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
+		dev_err(dev, "Unknown ACPI mount matrix package format\n");
+		goto out_free_buffer;
+	}
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING) {
+			dev_err(dev, "Unknown ACPI mount matrix element format\n");
+			goto out_free_buffer;
+		}
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
+			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
+			goto out_free_buffer;
+		}
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default:
+				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
+				goto out_free_buffer;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	ret = true;
+
+out_free_buffer:
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
@@ -1449,9 +1527,12 @@ static int kxcjk1013_probe(struct i2c_client *client)
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


