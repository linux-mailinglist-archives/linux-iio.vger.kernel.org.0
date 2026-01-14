Return-Path: <linux-iio+bounces-27756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A334FD1DDA0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73EE2301BB36
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F738F229;
	Wed, 14 Jan 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="veKDRH17"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDDC38B9B6;
	Wed, 14 Jan 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385276; cv=none; b=apgHKGccfz/WdKDbuRZBJVdZt/54rHF4Tc0oHtUYL3i9SnQH3rAA3KIM/xqIorTmxVapRcTjLQwwgNhHMThdBnNFe+ML/hLbpVv8ehy/ltYQEvI8OeXl7nL01Zf3sduW9SlQRbzAOgGrB14X6g6iliJ2eK012ZId//F83G5nQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385276; c=relaxed/simple;
	bh=qeoHSKRTrPKZ9m29PlRFc4X5jX70X+3ZvqlcGQUVONg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oremHWhY079PEVYjhUXnaPZ/m6KRk13Y1BSIyJ8Bxh5JK2f73rkvbcj/z8h0dCl77snAnR0LcU5+A4/ByOaUkfjAGbLghyfOYe/Ytiph7RW8ROfqS0SEL2xNdz6btqxtp4bvbzlz17dZfT1UT7Y/vtNxxFTAzu4je5FOqRPyyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=veKDRH17; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 76216160216;
	Wed, 14 Jan 2026 12:07:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwvCH52rkwZvNNllHPFX2xGB2klIldjgQiDwrcA2Z9A=;
	b=veKDRH17UVKl7Jh+0QYVSXhDT40A2L+SjSE6RWBNpqjkacPmhnLbUM8DP+4k4uB0xsQeRl
	T1qXsFmUFbEFz/OlaLP6Guk1Wk1xfVnHDZtB6sln71ijoymlI1YVQT3OhAliRE7CD+qrAu
	ZOJi0Q44Ui+eS09GxlUbXTv3tsU9bmlQxwLUPH0fduLSWhNVHfm8GppRUfIX17IpRxPol6
	fW3BgSUuZsTO/OrCQpjfD0xEQ5OYkgjV7K/7sDx9ECwVqDiUHVHo2QJ/nDcDs56EElsRuh
	J+MhuemDMncTvsEdKLIT9I39++cQIFgdbWkmijJUJpubkothdsNaw4MtOD0goQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:46 +0200
Subject: [PATCH v2 12/13] iio: pressure: mprls0025pa: change measurement
 sequence
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-12-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3291;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=qeoHSKRTrPKZ9m29PlRFc4X5jX70X+3ZvqlcGQUVONg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXV6dDZNbXV4MmcxSjNoUnJKWU1OcE8vCjRHNGg2R3FiM21QY2FzOHE0
 dGdIa29rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycnN
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWS90WA
 pELzlVNjFaTFIzdHFpbnRCZmlJWkF4SEY4ZE9lTG5xT01wcWRwZWovckZoQnlhQmJwS1NzWDZBc
 lVpVUZRaVBxCjhKOGNNYzN5YnI1ZmZLaktrSCt2Y0V4bUpGYkt4bkV2VnBlNGJwWUxENFoxeDNv
 UHFabUk0bUg5QU50TGFIM2sKNXFiVmt3a3gwWkFLeEhnRU8vOWFZUUMwQ3VLaWVYRFFRaStHVXV
 HMGlla0UrNEFYYndiOHprc2h4RUEvV2VCLwptSHVqK2ErMlo1Q2diRlJZV1l6QVhIMnMwbnR6N2
 01QU5LUVhyZk15N290TUQrejRUaTFTaVVSaW1vYjg4ZmtxCjNRWlRpaXFCSmlxWEh1QURkVkpnM
 DVwdk5RaHNvczV0QURUUU83aHE3Ly9nWDVGZmRFRGJRQzY1MmhZMzJKK00KazYrY20yWll6QTAx
 cmIzR1B2djZlM2dBcERXUExWYkd0UmNNSGp0ZXJ6cWtHRURZS0FFSXRSd1ZKY0IyOWZwaQpGeGJ
 kZk1HOS8zUTN5TkhNcnZCMU52cnUrbzZmanZ5YUxZeXdZU1ZZdVpBOHpuN0FXYzVObUpYL1lFT0
 lyNUVNCnZ4WGxqQlNibjV2KzRkZWFtL2tVRFNLMzNkOGREbk9Fa0R2MlVEQzFMeFNoOVZRTUtJU
 UpBdVYyVWRSRythc2IKNG5mc0wvWmhvVVlySHhwTHFkSEFCWmxZUENLbGI3cDN3Z0xFN3lQdzRx
 TmlycmJ2RWMzQkUzY0V0ajloSjAwbApYREwzajBWbkxNcGw2MVUzblJ6TjUvem5NaERwMm9ibk5
 kUDFza1Y3RHR4bVlINUEvZkcyRDVwcWNsSy8zNEVsCnRMNWM0b3dva3FWQmhUUmZEa1d5QVJhS3
 ZaVXkxMk9kckI2L3FIRGUyUGd1dHpUWUxVZz0KPTVRYWUKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

This patch implements a measurement sequence that does not involve a
one byte read of the status byte before reading the conversion.

The sensor's conversions should be read either once the EoC interrupt
has triggered or 5ms after the 0xaa command. See Options 1 and 2
respectively in Tables 16 (page 15) and 18 (page 18) of the datasheet.
Note that Honeywell's example code also covered in the datasheet follows
Option 2 for both i2c and SPI.

The datasheet does not specify any of the retry parameters that are
currently implemented in the driver. A simple 5+ms sleep as specified in
Option 2 is enough for a valid measurement sequence.

The change also gets rid of the code duplication tied to the verification
of the status byte.

This change only affects users that do not define the EOC interrupt in
the device tree.

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 rewrote commit message
---
 drivers/iio/pressure/mprls0025pa.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 078d1d719023..8218d931647b 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/string.h>
+#include <linux/time.h>
 #include <linux/units.h>
 
 #include <linux/gpio/consumer.h>
@@ -41,10 +42,6 @@
 /* bits in status byte */
 #define MPR_ST_POWER  BIT(6) /* device is powered */
 #define MPR_ST_BUSY   BIT(5) /* device is busy */
-#define MPR_ST_MEMORY BIT(2) /* integrity test passed */
-#define MPR_ST_MATH   BIT(0) /* internal math saturation */
-
-#define MPR_ST_ERR_FLAG  (MPR_ST_BUSY | MPR_ST_MEMORY | MPR_ST_MATH)
 
 /*
  * support _RAW sysfs interface:
@@ -206,8 +203,7 @@ static void mpr_reset(struct mpr_data *data)
 static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 {
 	struct device *dev = data->dev;
-	int ret, i;
-	int nloops = 10;
+	int ret;
 
 	reinit_completion(&data->completion);
 
@@ -224,29 +220,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 			return -ETIMEDOUT;
 		}
 	} else {
-		/* wait until status indicates data is ready */
-		for (i = 0; i < nloops; i++) {
-			/*
-			 * datasheet only says to wait at least 5 ms for the
-			 * data but leave the maximum response time open
-			 * --> let's try it nloops (10) times which seems to be
-			 *     quite long
-			 */
-			usleep_range(5000, 10000);
-			ret = data->ops->read(data, MPR_CMD_NOP, 1);
-			if (ret < 0) {
-				dev_err(dev,
-					"error while reading, status: %d\n",
-					ret);
-				return ret;
-			}
-			if (!(data->rx_buf[0] & MPR_ST_ERR_FLAG))
-				break;
-		}
-		if (i == nloops) {
-			dev_err(dev, "timeout while reading\n");
-			return -ETIMEDOUT;
-		}
+		fsleep(5 * USEC_PER_MSEC);
 	}
 
 	memset(data->rx_buf, 0, sizeof(data->rx_buf));

-- 
2.52.0


