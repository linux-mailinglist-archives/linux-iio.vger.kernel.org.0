Return-Path: <linux-iio+bounces-16610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6CA585FE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F333ABCA4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB61DE8B8;
	Sun,  9 Mar 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1zViEkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E11DE4CA
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540022; cv=none; b=K8UETgyL5j/K9iesQH0FEhs9Lv8fCSvp4fYTyZyuFYMHQOI+bc+fU5RpEX154Pqnib0MsvDIDhCfBRot4PzbFXAU8AD8swq+qZCMjbpbYeGjNn1xn2spe+tD1XWPHHUGkrRb95hmrnG9RQgvF7fswwfvVvwfqNwoygOXrpKY0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540022; c=relaxed/simple;
	bh=XqhwJWvXrjIMVDeQulkYU/6RudYJSuGMEXFUXrqG4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br3v/C3m/Ay/U06Qh6hOHGzoSMmDycw1y6mgmKB0K1RW6cmCL2Nz0lqB+ZucL+XqNqKunbaLwkhck1QrkOfkEonFV/DYuqX/cyd1MSXrP3sCwt3s2gHeO0Df8kQ7jGVdM7FYkVh4wwiw7rRHNfMnauVlze//vzkRqM1sdIFr6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1zViEkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288B1C4CEE3;
	Sun,  9 Mar 2025 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540022;
	bh=XqhwJWvXrjIMVDeQulkYU/6RudYJSuGMEXFUXrqG4vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1zViEkweOYJpOvYtAgA85DwrwDPZsUgD6GWkXaGmsja7cgu4jqcnUy6o1ThjGf0g
	 /x4c9B5YCagvXmphONRPHfqjAVqtW5MjvRWVFlfh3JZ5DE1JPqZ959GK/mDBePEnvx
	 u3TLUI5PfiVIRiWgC0gWcwV47QNbSBmsPXqttBwKQecQMDbipmi82GGdaXZjwaVZwD
	 pR6jzclKYY7zF2I6qZk8QD1x+OOCVGBBOs7hcbUEZYL/1RnHwiqOsFYgfCp/wX7tXm
	 qIZM6S/F10QkeWiyw62dm2wF/c69BBijfj5MxAXODzuDphxy89EPVOvDBzvELIUMyB
	 lOkwMe9/NCDxQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/18] iio: light: as73211: Use guard() and move mode switch into inner write_raw fucntion
Date: Sun,  9 Mar 2025 17:06:19 +0000
Message-ID: <20250309170633.1347476-5-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

By using guard(mutex) and moving code that switches the device to config
mode into _as73211_write_raw() the error flow is simplified.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 37fffce35dd1..4b73ce57a3d8 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -17,6 +17,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/completion.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/buffer.h>
@@ -517,6 +518,16 @@ static int _as73211_write_raw(struct iio_dev *indio_dev,
 	struct as73211_data *data = iio_priv(indio_dev);
 	int ret;
 
+	/* Need to switch to config mode ... */
+	if ((data->osr & AS73211_OSR_DOS_MASK) != AS73211_OSR_DOS_CONFIG) {
+		data->osr &= ~AS73211_OSR_DOS_MASK;
+		data->osr |= AS73211_OSR_DOS_CONFIG;
+
+		ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
+		if (ret < 0)
+			return ret;
+	}
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		int reg_bits, freq_kHz = val / HZ_PER_KHZ;  /* 1024, 2048, ... */
@@ -601,28 +612,15 @@ static int as73211_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec con
 	struct as73211_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret < 0)
-		goto error_unlock;
-
-	/* Need to switch to config mode ... */
-	if ((data->osr & AS73211_OSR_DOS_MASK) != AS73211_OSR_DOS_CONFIG) {
-		data->osr &= ~AS73211_OSR_DOS_MASK;
-		data->osr |= AS73211_OSR_DOS_CONFIG;
-
-		ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
-		if (ret < 0)
-			goto error_release;
-	}
+		return ret;
 
 	ret = _as73211_write_raw(indio_dev, chan, val, val2, mask);
-
-error_release:
 	iio_device_release_direct_mode(indio_dev);
-error_unlock:
-	mutex_unlock(&data->mutex);
+
 	return ret;
 }
 
-- 
2.48.1


