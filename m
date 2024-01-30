Return-Path: <linux-iio+bounces-2049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A148425D5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB2291F15
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC386A35F;
	Tue, 30 Jan 2024 13:10:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from queue02b.mail.zen.net.uk (queue02b.mail.zen.net.uk [212.23.3.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA067749
	for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620216; cv=none; b=IS1zNLrKgUbsOVyjn9hTlVy9v5N4LMjGdTLPt/1kxBU7sYJudTjwMCz4/Vb6H7/nOwuJilPZhbLX1VoN2aaIUvCD5k6vSd4+pL7eJqd1+VHZ2wFEicl03fWaoGxgh3q1eGeqXR4VH9L6m+rtHQ+CswwX+d9o6HAiG+CLUW+zMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620216; c=relaxed/simple;
	bh=RtPXEZQIuS1mZ9KQ5LJ4TIBsMem/jnzOXA5XFFRzDIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c57SThK+A+/dQR7/1nLobTM3JPJfN7XVOi6LJM8I8oCIUcjHIR8qqAj66KRbeQa/L8Li7rzXJlxEQ0uXzQMuNd6f31u538J9CXudtr1eNMRqmIbLTgt75FGXlmObN8Y0qw6OcmY0ordxMbf6ITJMjaKoNAChhL7D1HJviVIutnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
	by queue02b.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rUncX-003d2j-Q4
	for linux-iio@vger.kernel.org;
	Tue, 30 Jan 2024 12:53:47 +0000
Received: from [51.148.147.4] (helo=starbook..)
	by smarthost01b.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rUncL-000RhB-66;
	Tue, 30 Jan 2024 12:53:32 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-iio@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] drivers/iio/accel/kxcjk-1013: Add support for retrieving the mount-matrix
Date: Tue, 30 Jan 2024 12:53:20 +0000
Message-Id: <77875d90b21d3065b533d89b620c143b29d141a0.1706619185.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [51.148.147.4]
Feedback-ID: 51.148.147.4

Add support for reading the "ROTM" method from APCI which contains
the mount matrix.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/iio/accel/kxcjk-1013.c | 88 ++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..760bbd95b73c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -619,6 +619,85 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Support for getting accelerometer information from KIOX000A ACPI nodes.
+ *
+ */
+static bool kxj_acpi_orientation(struct device *dev,
+				 struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *name, *alt_name, *label, *str;
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+
+	if (acpi_has_method(adev->handle, "ROTM")) {
+		name = "ROTM";
+	} else {
+		return false;
+	}
+
+	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
+		goto unknown_format;
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING)
+			goto unknown_format;
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
+			goto unknown_format;
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
+	kfree(buffer.pointer);
+	return true;
+
+unknown_format:
+	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
+	kfree(buffer.pointer);
+	return false;
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
@@ -1449,9 +1528,12 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		ret = iio_read_mount_matrix(&client->dev, &data->orientation);
-		if (ret)
-			return ret;
+		if (!apply_kcj1009_acpi_orientation(&client->dev, &data->orientation)) {
+			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+			if (ret)
+				return ret;
+		}
+
 	}
 
 	ret = devm_regulator_bulk_get_enable(&client->dev,
-- 
2.40.1


