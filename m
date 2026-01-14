Return-Path: <linux-iio+bounces-27798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D7D2063F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB83A30C62D3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FF3A7831;
	Wed, 14 Jan 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ihVBKfxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E963A784A;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409796; cv=none; b=Lo8nmFSYA0OP+NjWyQ1OE2CsSZdCy6Igws9Jxgs8ZpPfKv8kayCqXkrXmMSzpfPeJFytu0zP9PljBuB5ZgbUaGHI5U9V1TygXZb0/Ncxrk0IXHHNJkpRySeIynKVzNZurP3xk3Z6qdkg3mnaJq4CKbzBwG7HQqsOypNNfa3QA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409796; c=relaxed/simple;
	bh=NLtzNINdqdQVjTYfusVEMA6v2Hd9sfieKb6m9NFWaQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3+cs7KS8iTav4nsTU1KP6BoOqvyeS2HLGmpl423NRi9lfOjPEHcRD2e3tczK32gY+IAgCL1MyqaxhAhcukwWi2kQvn/ZPsDEnNqedG/YeKqR+V1A+8xhugrF0P2cgZg7JdHVgBNqA04bEi15/Piydnq4UlvkCN9yRbI+5aoW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ihVBKfxK; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id DD6C5160213;
	Wed, 14 Jan 2026 18:56:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HI3XnUHvvMs32B1ep4cLtSCZ2YnL5LoVIfJiMS1/rgg=;
	b=ihVBKfxKcDZ5yxhvrt1NOs4mLHFIrh0Ao6IcoptvIf6c3Lvi7THhTAkrbbmMGshuAWKoCk
	Mpp+V2XjTx7p0CRKTZg0vLeQR1Je8VvdwKhftAJtXJ4CsEaavQsGE9IP+KYUi10S3S1d/N
	s0zVfmTrG0sdok+aXJVqVr2a5oAX1iIIqPQv8vB37XrI60vAgSODhGhayHamKJhO7H/dSC
	MyYYbmV9kI4E8ZcnlJ/EhvZd2qgqcQKepACDdsH4NHYtiVmU04srMCgT0QuPnHMZPe74SM
	3ziPdf4Jw5ej+R/4wekylFQtsjBj9V0s2CFcD2E0P3EjJcvM8LCbpXTelIF1rA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:38 +0200
Subject: [PATCH v3 09/13] iio: pressure: mprls0025pa: introduce tx buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-9-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4745;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=NLtzNINdqdQVjTYfusVEMA6v2Hd9sfieKb6m9NFWaQQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2xueXFtaEVOT2JWRmtKZ2tUOGsrZnFMcW1UL2lXbW1FUU5EcmxaCkJyVTdONUdLVUlrQ1R3UUFB
 UW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpwWjhxcEd4U0EKQUFBQUFBUUF
 EbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWSsrNkQvNGt3TGp5MHA4OQ
 pzeGwxb0VUaGxyTE9LdWR4K283eXlMOTdNZWs1ZnNCY2daelRvbnllSE1xbUJpVDM0dnRHN2UwR
 GpneEJ5SWhCClphMi9GY25jREZ4K081cmkxNUNmUFFsekJjRXlGTW51NHNNVmdxK04yTmdKN1FS
 cUZhcVpvSS85VGxrTUhCOVoKRmh6NmFBYjdpR0NVc2FKcG1UMGFWcEEzZU80OVJqNVA5ank3RW1
 HQ2hCVW5kL2hJcUYwNkJjVlZtdUpCdFhrdQp1RUp5eWp6Yjdoc0trOEJGMmRPRkhqOWV4QzBuT2
 ZjTi9KL2l1Rlc3aWZZMFM0ZTREcExQczhnQjkvUkNxbzUxCjR4Wmsrd0ZjOVg2MkpHT29pOHd0N
 ERDTjRBYW9TWGF5YjRPaW1BeThST2JhK1d2b3FDODNQSlhRWktsRHJXYWsKOWtvdjVtbUh1azYx
 bzA5bVVQc2FpVjlVYVgyRlRIV2RYSHA2UTBHRFBSemNmajZ2VXBVZ0Z0QUFlek9UQUwrZwpOeWd
 vMDFBYWVqd205N0ZqMzBWemdwMGdTK1NyV3pCNndKRUtiaFBHeTdCN0VzM2t6NTk1TGhCZkk1T0
 ZkS2hQCnBSa0FKd2IvNWFpTGVrVEw1TlZsSDd5b243a0ZQS3ZFUS92NHU2MTdXZjZrRVZTSktIb
 WtzOVA3Qk9SMWE0TDQKLzBWUEMyOUMwbmVlbnc4clpWMmJObkRhcDZlY2g3K3dpOU5sUHlsaVJX
 NWR4S0ZNcnQ5WFNKbXlsQ0JDdHlrUQpqazA2NTc3RDFmd0g3ZXJ5OXFNd3I1Y2IzelAzTThOTkJ
 wYTcybFpaRjVrOWR5YkVlOFJ1a01QWWE3eUVEMDVvCnI5R1RmcUU3MnJvZFg2ZytZdWRjd3ViZ2
 doQ2ljMWdzMlE9PQo9VTNMdwotLS0tLUVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Use a tx_buf that is part of the priv struct for transferring data to
the sensor instead of relying on a devm_kzalloc()-ed array.
Remove the .init operation in the process.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no functional changes
---
 drivers/iio/pressure/mprls0025pa.c     |  4 ----
 drivers/iio/pressure/mprls0025pa.h     |  3 ++-
 drivers/iio/pressure/mprls0025pa_i2c.c | 10 ++--------
 drivers/iio/pressure/mprls0025pa_spi.c | 24 ++----------------------
 4 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 245d7ed82b6b..2bcd339dc84e 100644
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


