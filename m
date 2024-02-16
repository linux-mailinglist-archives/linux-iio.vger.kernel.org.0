Return-Path: <linux-iio+bounces-2642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53885803D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7612845BF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70D12EBFE;
	Fri, 16 Feb 2024 15:09:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from queue02c.mail.zen.net.uk (queue02c.mail.zen.net.uk [212.23.3.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD61292EC
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096189; cv=none; b=GCnpuMTbhm0GFc8nhDezwZgIqvSZxcR8HIBH+hG13l2wcrY9nhUIfQHzCppzEDKsCyVJ0BYyGcJp11KXScsrucOFG/fxT1BnyU9lAb4pEvei0bJ6Rw9vXAd8KfFIwmdvT7dbLjLfNRYZTeUDRuOHrXUf5fe4+DiN47pjgWym+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096189; c=relaxed/simple;
	bh=6tAw8ngeqVdnw9A2b8hnULZpGqx7Mv3wyTPTKtnz0Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DZtowtkN9EV3Vc+3x818CV2xRn9H3xnuiuUKH0OPztFlwBfnlh757c4mElgVMPwrs76wPUefKM3oSsgLUvndR0/CqyyBlZn4AcdEE8buaZFhHsl704+IWl/vNi/bcLK5Pn3Vmz7jaq1in/c5ZYBl9URWQYbw/QGOyDwdbL3Aq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.5] (helo=smarthost01c.sbp.mail.zen.net.uk)
	by queue02c.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1razqL-00536s-3E
	for linux-iio@vger.kernel.org;
	Fri, 16 Feb 2024 15:09:36 +0000
Received: from [51.148.147.4] (helo=starbook..)
	by smarthost01c.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1razq5-006K7A-BD;
	Fri, 16 Feb 2024 15:09:22 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-iio@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4] iio: accel: kxcjk-1013: Implement ACPI method ROTM to retrieve mount matrix.
Date: Fri, 16 Feb 2024 15:09:20 +0000
Message-Id: <7d047e344ef05efab76f7ba3799346c9fe7dfea9.1708096118.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01c-IP: [51.148.147.4]
Feedback-ID: 51.148.147.4

Implement kxj_acpi_orientation to retrieve mount matrix
from ACPI ROTM method

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/iio/accel/kxcjk-1013.c | 83 ++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..d6b068cfa68a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -619,6 +619,80 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static bool kxj_acpi_orientation(struct device *dev,
+				 struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_status status;
+
+	if (!acpi_has_method(adev->handle, "ROTM"))
+		return false;
+
+	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false; // Removed goto, no buffer to free on ACPI failure
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
@@ -1449,9 +1523,12 @@ static int kxcjk1013_probe(struct i2c_client *client)
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


