Return-Path: <linux-iio+bounces-27166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B7CCB8AA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5E93001BAF
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12303315D5F;
	Thu, 18 Dec 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="L87aC+ki"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA9310627;
	Thu, 18 Dec 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=L3tqq2hmhwEMFYBc39WW8txdgqtEyOX/Q7AeB7XYcct6PWGnCjR15ryLgW83KHtqIZX1qSD7mum3qDUV0coftq5dNYNX0jhVnp+lnmSCpPSbeSIUO/c18ob/PTUajydStI+atAkd6zqIe/vQ1Yiny1rhbe1wKvHgNEn6UW/6asU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=6t/ui8dg/vJN2qHfwf5MmUY3lf7MfcGnKwo5/na4dxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRMAfHaCTn2Pm0XwEz362gg90TX+L4lfQYnhr9I6Qmcs4fUJOTLvmd4KwYqJXMd0Thsyx5Y9YxCm0W8K1DqD79oN1tYUKu5T7jk+pKch8gDAEVsCWR+WQomDhTfW+d+95Rg/8Vh6NCk66hcbOHi5TnFkoYS8Y/cqyDwPtowsx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=L87aC+ki; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8B264160212;
	Thu, 18 Dec 2025 13:06:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zAOyvnYZ4rxfIK2SgIcQUO+ViTcPzuZ2MakZsOFgqw=;
	b=L87aC+ki8/9LRFiTaDZ7f7hLhgEaH/lxahtl9cqPs8YlVwfb+U+S/DPvLfUzOu1uwjJzEn
	tTlxBn3i/q4WL0eQwTy+MMLQHdFkGuz5+XYXmL1YYZxMOBzxqtVLNWj+v72BtDGqE48L0o
	Vk9EOHnrR7lAZHGRt327nAN7zF0Ydktpukf02fbhTj3uEMCVm5HCaidAiJ+3Vb1ManHnTK
	k6bHpsrMmOA27tPV5Id+2ELYCNuqjSfug+NQTzyaRbVhknW17/qpNt26O4NgIfCal3QbgS
	A5AHSaVJSRRa8DPRS+bOD7IcyFXRITw5H9WKv4nZP6wCAP2do7tJvE4oB61HQw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:51 +0200
Subject: [PATCH 09/14] iio: pressure: mprls0025pa: mitigate SPI CS delay
 violation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-9-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3647;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=6t/ui8dg/vJN2qHfwf5MmUY3lf7MfcGnKwo5/na4dxQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJyZk1uNWFkVHlXOG1RbXJXRVJKL1BJCldBZktSUnJYT2NwdmZWRkVX
 N2ZDQklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWF
 BQW9KRUhRcko2ZGpPa2xqOU9FUC8wQ2IySDFsK1lMcFhDOWFNZlc1NGRPSmFiWnVORFpFaHNDVg
 pIVmcvQklUYWRwZjVBdEZJNDV3S1lJNEc5bGYrNG9SaWw2eEhuZ0lVYkVOdDlJWEZWNU4vR1dvc
 WpPajNwazgyClVEbmg2N0ZuNEpMeXgyL1lEVTIxTWF5RVN2Z2lLb3NaSW91anRQaExPY3VERUxk
 b1BjbXlwMHZ5N2dGams5cysKM05rNzI2Y1FjREZ2cWgrK1RtelRNTGhQUWJYbDNSaWFaQTdsM0g
 yblJoZ2RKVVpGaFRQVnN5MDBQdXowc1pjUAovOCtZWDk5Qnhsd2hDWkN1cVByS3cvQUszczBFR0
 ZkTE1Ca2t1WTBsOU5wVXZVQStobjRjbXFIbmFiODl0emd5Ckc4SDNSbFRFMnBzRjlxTjBNMFY4M
 m1TVVFDdkFtOUYzbFJtbTU2T1hYZEdwL3IxTTM5UFZRWVN0VHNBd05sa3gKMEhaQTdudWVwSEdz
 WnBzaVpMeXQvNmo5a2NVaTRXR3lnaHU1NndYL2FNeDFPUXVyNW5iZnNFTFhDSWZPbCtweQpaa25
 abGMwZVB0K3YzSDNoRXl4SGJCNnZKNnNla3ZCc0hlcTFiNFVwb3ViSEY2TUZLK3RYNWtnam9KdE
 1SV0hkCmtwaUZyQzJobzFtaXlnVUZXNi90WHd6dDdBWjYxTlQrUzN1VWVnMEFFUURkTThQQ25Ld
 1NkYS9zYStQbXp2VVoKb2tueVVzc1cvNERKTHg1Y0tXUitTRG1xcVo3N0luUHZpYnp3MkdWVkht
 VTNJbThJdDYzQUtHSUxyM3R2T3R6SwpKWGlsWnM3d1laVlhhTElva0xVQW1QOWhGcGV2c0s3aG1
 ZeDM3aVpDcktLMzZ5M1lzTFR1aEV0Y0tJT2xRU3VPCm5NL2xMKys4dlJBc0V3PT0KPUxVUTAKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
during the SPI transfer there is a minimum time interval between the
CS being asserted and the first clock edge (tHDSS).
This minimum interval of 2.5us is being violated if two consecutive SPI
transfers are queued up, at least on my SPI controller (omap2_mcspi) [1]
As you can see in the first package that only contains a NOP the interval
is 0.75us (half a 800kHz clock cycle).

This patch mitigates the problem by implementing a different measurement
technique that does not involve checking for the EOC indicator before
reading the conversion, thus making sure SPI transfers are not queued up.
see Option 2 in Table 19 SPI output measurement command.
Note that Honeywell's example code also follows this technique for both i2c
and SPI.

This change only affects users that do not define the EOC interrupt in the
device tree.

Remove defines that are no longer used.

[1] https://pasteboard.co/66WN38MRI1wc.png

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 973d205da3e9..a1d7ec358036 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,12 +12,14 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/string.h>
+#include <linux/time.h>
 #include <linux/units.h>
 
 #include <linux/gpio/consumer.h>
@@ -35,10 +37,6 @@
 /* bits in status byte */
 #define MPR_ST_POWER  BIT(6) /* device is powered */
 #define MPR_ST_BUSY   BIT(5) /* device is busy */
-#define MPR_ST_MEMORY BIT(2) /* integrity test passed */
-#define MPR_ST_MATH   BIT(0) /* internal math saturation */
-
-#define MPR_ST_ERR_FLAG  (MPR_ST_BUSY | MPR_ST_MEMORY | MPR_ST_MATH)
 
 #define MPR_CMD_NOP      0xf0
 #define MPR_CMD_SYNC     0xaa
@@ -204,8 +202,7 @@ static void mpr_reset(struct mpr_data *data)
 static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 {
 	struct device *dev = data->dev;
-	int ret, i;
-	int nloops = 10;
+	int ret;
 
 	reinit_completion(&data->completion);
 
@@ -222,29 +219,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
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
2.51.2


