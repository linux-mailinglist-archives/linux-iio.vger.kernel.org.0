Return-Path: <linux-iio+bounces-27753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C86D1DE2A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 413A530B5ABF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11BC38A9BD;
	Wed, 14 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="x+gxoIwe"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D138B98A;
	Wed, 14 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385275; cv=none; b=KJ9hgWhQw+AqujgOn4STG0YT7xYR4LdUp/LEFObk6q7ajSnq72yuT/qG4B9naWHj2gJY67FpiUtbxb8bM/Q3ArMCjZSufe6SBN7/qavlDT1UU8xr5xfnwBQ5vREuQZqPARhfWXEbL4u65n0uHfvEroQM3nLRBeDgL50WPFwoLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385275; c=relaxed/simple;
	bh=r7/wsy7HB+4f1693kJN+/vfUoCR858XPerJPnyAp77Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TuSqiF2e5J31NrRrNRIiTQ3XUtviw2+VIDHkav0KxYZ/2Rp+snZahEqcsMLXgxUXDPMsX9A7uIeqy8R4W3PLBTjj/3sHGOuqvt3O0tWBffZRfjxSguwip0vnNEil0fzVLtYMNmKcB5KprT+5H5P1yk9kj6nDOYbHnIUXYWnc2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=x+gxoIwe; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id BCF6D160213;
	Wed, 14 Jan 2026 12:07:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fu6qccZ+dkp0wdqBIfjyjgctv04oNHIa2SQYNxr+5+8=;
	b=x+gxoIwe6YOddeWU5MidyY514/OqWaebx7DHMTTx9IgrQPWtMjEAaeJsrffeO2RBilgz9C
	99psYXr3myN1k50BbubhWHtppLPmtNq2bPl59VlgMUOPbEfZ+P2yEtD6rB5CULXekutoZ3
	mLXvxLTOU+iFgZZLbq5dUVgBwEJ3X1iq/eG6CU13flK8dxjsxvGqQwbRLLr9Ytx5xx74xp
	SfX+QwdQ5edRDBuRR3Lj9FL1H6sXUfFZ9iMBRtSdmAR9ENc7DC0H3Jfvy1WNBk70PIe7yN
	ttjlEhd5CunHKUZyGzySo0OMIsANFfJKS88xWaTn9ZJu1JSog0zLIPEQKfXs6g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:43 +0200
Subject: [PATCH v2 09/13] iio: pressure: mprls0025pa: introduce tx buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-9-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=r7/wsy7HB+4f1693kJN+/vfUoCR858XPerJPnyAp77Y=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXVYQS9JL1JodEE2Z09sQStyYk4vc2JnCkQwTHZmWlUxZmRudE1PUEUr
 ZVdnc29rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycmx
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWThZMA
 pELzkrNXNRZWM5ZGxnVjV1Vmxhck1wNGl2ekl6TU04bXo5eWcrcnp0dmxVRXUxcHVsMW55TzFad
 2lkWi9CU0hCCjA2V1NEQ3l5WjcyVlMrNEUvZEY1U0JBWVNGSVF0NlBSaUw3NjhhYmp4RjJsODVJ
 dE16am1EZGg0VXVnNTFack8KMnhmM1pPbmRmdkV5VEE0bm5kaVZRQjhHTDN1K3FqbERaNjFpTks
 rYzV4SnhYUzlQU2xsMjNvM01PWG04dzdIQgpmUlFISStiS0JUREJMVTVEUEZlZnY5YnZCZG0xQU
 9kaUFJLzdwVHQzZnMrWVY4ZSsyK2RVWFk2OG1xZUVRVnp1CnpiSnZBRkVhSFJvZTdtR1FRMXFDY
 XpsWGhjMEFOck5LNWFZdTJ4TVVXVDVPVUtvUkRzbmRyNm5QMk9GUGU0TlIKZkJ0MGFnUFZlVlRm
 WGdVM2RPU0phWnNRcmZvVVpJbEd2SnVtR094ZXR4Q3BlY2dOUmpvcnp0OTJYYjBEOTB6TQpCZG5
 COXlZbUZCRERuU0xod1lWZ3NBcUtqaTFhWTRVd1VLZDEvYTJCNHU3QjF2dmNIeEdKQS9VS3BNY0
 pkdmt5ClVLYmdWZklqR0xpWWtaUThoL2xlSGg2RStVSDJuSElHMUFPZHQzUGViV0pUMDhSQUwzR
 jJTMkRmQmo4WXZGbGQKeG9QQjltaHltMVZJcTlnWWxROVRaUXRYSW1WbmlGcFFhaHpNQVcrb0NJ
 VW5ka0t1ZFU2N01QcUYwM2pHaUNxMAprTzVOVUlQVHQ1TkIwSHk3RW92UjJVNlAwN1phaXM0SkY
 0aU5LQ1hJUnBMd08waEdPbDc5TGlIUVBGM0dXT1dyCmVHeTZ3MjdkV3RpVjJ5cGZ6R2ljZ01UcV
 JmRzlEOW1Xbm15eG5xRTBLR0syTk02ZUxNbz0KPTBmdCsKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Use a tx_buf that is part of the priv struct for transferring data to
the sensor instead of relying on a devm_kzalloc()-ed array.
Remove the .init operation in the process.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no functional change
---
 drivers/iio/pressure/mprls0025pa.c     |  4 ----
 drivers/iio/pressure/mprls0025pa.h     |  3 ++-
 drivers/iio/pressure/mprls0025pa_i2c.c | 10 ++--------
 drivers/iio/pressure/mprls0025pa_spi.c | 24 ++----------------------
 4 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index fd9c8ea61eb3..7532b2e74413 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -363,10 +363,6 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 		return dev_err_probe(dev, ret,
 				     "can't get and enable vdd supply\n");
 
-	ret = data->ops->init(data->dev);
-	if (ret)
-		return ret;
-
 	ret = device_property_read_u32(dev,
 				       "honeywell,transfer-function", &func);
 	if (ret)
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 119ebb0ba567..9f43273e635f 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -55,6 +55,7 @@ enum mpr_func_id {
  * @chan.pres: pressure value
  * @chan.ts: timestamp
  * @rx_buf: raw conversion data
+ * @tx_buf: output buffer
  */
 struct mpr_data {
 	struct device		*dev;
@@ -76,10 +77,10 @@ struct mpr_data {
 		aligned_s64 ts;
 	} chan;
 	u8 rx_buf[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+	u8 tx_buf[MPR_MEASUREMENT_RD_SIZE];
 };
 
 struct mpr_ops {
-	int (*init)(struct device *dev);
 	int (*read)(struct mpr_data *data, const u8 cmd, const u8 cnt);
 	int (*write)(struct mpr_data *data, const u8 cmd, const u8 cnt);
 };
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 36da0059b19f..a0bbc6af9283 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -17,11 +17,6 @@
 
 #include "mprls0025pa.h"
 
-static int mpr_i2c_init(struct device *unused)
-{
-	return 0;
-}
-
 static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 {
 	int ret;
@@ -44,9 +39,9 @@ static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
 {
 	int ret;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	u8 wdata[MPR_PKT_SYNC_LEN] = { cmd };
 
-	ret = i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
+	data->tx_buf[0] = cmd;
+	ret = i2c_master_send(client, data->tx_buf, MPR_PKT_SYNC_LEN);
 	if (ret < 0)
 		return ret;
 	else if (ret != MPR_PKT_SYNC_LEN)
@@ -56,7 +51,6 @@ static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
 }
 
 static const struct mpr_ops mpr_i2c_ops = {
-	.init = mpr_i2c_init,
 	.read = mpr_i2c_read,
 	.write = mpr_i2c_write,
 };
diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index 247b65226bb9..8c8c726f703f 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -19,34 +19,15 @@
 
 #include "mprls0025pa.h"
 
-struct mpr_spi_buf {
-	u8 tx[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
-};
-
-static int mpr_spi_init(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct mpr_spi_buf *buf;
-
-	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, buf);
-
-	return 0;
-}
-
 static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
-	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
 	struct spi_transfer xfers[2] = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
-	buf->tx[0] = cmd;
+	data->tx_buf[0] = cmd;
 
 	/*
 	 * Dummy transfer with no data, just cause a 2.5us+ delay between the CS assert
@@ -55,7 +36,7 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 	xfers[0].delay.value = 2500;
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
-	xfers[1].tx_buf = buf->tx;
+	xfers[1].tx_buf = data->tx_buf;
 	xfers[1].rx_buf = data->rx_buf;
 	xfers[1].len = pkt_len;
 
@@ -63,7 +44,6 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 }
 
 static const struct mpr_ops mpr_spi_ops = {
-	.init = mpr_spi_init,
 	.read = mpr_spi_xfer,
 	.write = mpr_spi_xfer,
 };

-- 
2.52.0


