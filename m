Return-Path: <linux-iio+bounces-27173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B1CCB91F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0ABC30A2D97
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D91314B9A;
	Thu, 18 Dec 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="n/wORLbO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1960314B6D;
	Thu, 18 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056470; cv=none; b=ilzM1T3SHhfziswN52ELPGO17Z3oFcHyXFe8zwdXICZRW/j1D5425G4g0xMRBL8oKFgr/zudESrtcxcKIoXcNZlrMazPmO7SJd+JF2//72CeZXGfJxDTvvYbuER/+m4ktfTpQTEetz0z8s8MFhgQDNU1NuzR5vOQgqIegdjS0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056470; c=relaxed/simple;
	bh=fgIJy8VYLcV8kmTqs+So2xTZb8MuiECUJvpZpgTUuPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3gU/doOFSvseCxuIhlG5A7PiiM0IU/ICaGg4G34Slz4aauftOkhIVKDGQ4DTo8QmY8/txE13vdCFiKqYfKsXZa5WuXtax8NNkt6NzkzeI5t2UjFIFsrdWdXV22LZPhW33rjIqUoraXnqDhQ3/a4yBeP14xJgHvwgKvBEwzgscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=n/wORLbO; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7363416020D;
	Thu, 18 Dec 2025 13:06:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq8jTTQewI2zWD/+KyanjkVoemCM+R0m77o4KDvX8xI=;
	b=n/wORLbOhrbENeUAAS92lFb2oDl3GwygFmcjvgcrrdQqhbghxGV53LnQ84OSZW2dIKAsnX
	yOTrCKM4PDJRxgbMEw6nqvipkFiBRSHjQoietWslSkhXXNXwuS1QeQJDkV2qKtQ6J6rTZS
	3Ha0iUWeMecKRDds1d3lXjxGTdY8j59kLrh3Eb9APOzbyhRqcJcPyT9b/H9f6hL119iFv4
	SHsx2q5hUiQNpbQV3zSTlH9E656mKCMmZLmQvNSmtzGWKjUFKMwS/LY2Rqehm9i7cKFuCm
	VMDRN7grA1mBi21Y2zx/gF/1RG7YJ5xXDxrkB5r7xBk7tOm0moAh3Lyafw/upg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:46 +0200
Subject: [PATCH 04/14] iio: pressure: mprls0025pa: introduce tx buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-4-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4351;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=fgIJy8VYLcV8kmTqs+So2xTZb8MuiECUJvpZpgTUuPM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJLODRoR0NwdXF2U2MxRy9XRDA1TGw2CmpHNlB0ZzAxbzdSUWxSOFd1
 d1ZDSklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVN
 BQW9KRUhRcko2ZGpPa2xqUVNNUUFJL05ZNndFTmxJNjJIMmY3RGdSaFVMZmRUV0xKQXNTSkdZUA
 ovNUNDUS91aG9zWGJVUjcrUk9tdW5iallsQnNmWDNNdFVLVkNZcXBCMkphRkIzNGZmR29QcGJjT
 nl5NWFmdEhnCjc1Rkd0YVlHTzk5Yzk3QjN4K1VvUEIzcEpjbWpDM0hmM0liVmd5N00xZ2dYbnNE
 NUFtdUJDdGRLNTFxMy9UNksKRDAwekZ1UjQ4MkZSMmtrcW9neGszbjdFbXE4L0NUaU5OK3gwM1c
 yd2J5N2I5YkNneWR0Rm5UUHVBSW13aDVBOApxNVpxaHIvallOYkk3NjJ3WUF1LzlwSnVOZjh1R2
 kxTVlGQmZqM1J2bVRSUmNUbXRJa21YM3Z1STBYOSt3WGRhCnBwcm4zQ29zdmRTWm5uaDlnOE5mU
 WhPcE8reGlUWGNOdGxIakExR05KOWVqUlhjUmdSeFBZYkJtZzhxUTRML2UKUUI2ZE9yeDZicnhC
 V052eGppSmJaeEpERHhLaFI1M3JNYUdJb3JWRDI5UVA0UFpMbWtoV24wMkVlT1R1dWJSRgp5dSt
 jTVUza3k5VThPdVVVa3JsT0Q2RENUcGNNVXd0THVYejNsV0srZ3B0cjNRRGIxZ1FVYSswempHOD
 V4NU9vClkxS0NpSnlKSWpWMXhNTG5uSS85V0VBZHBJaE5ZMjdocTJnaFdhK2p4L1p4Ukk5ZVNwc
 kZybFdNeW84K2VCazQKTjBMQmd5UG9ZN2dQbkFTbHhIMm1PNDMyM2ZvU0oxL0ZNMjYyV0JXSUU3
 QzZXcktLTDQ3R25FMno0Q3VENkR2WQp4V0hUQldFM1hVVjNvWmVsZ1NtRUxOY2VQaU12bjZWeXZ
 POVVzR0dwTkhRRmQ2dFJzaXIveEU5M09reVBrNTVFCloxbWVudWxBOFpVaDhnPT0KPVN3dXQKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Use a tx_buf that is part of the priv struct for transferring data to
the sensor instead of relying on a devm_kzalloc()-ed array.
Remove the .init operation in the process.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c     |  4 ----
 drivers/iio/pressure/mprls0025pa.h     |  3 ++-
 drivers/iio/pressure/mprls0025pa_i2c.c | 10 ++--------
 drivers/iio/pressure/mprls0025pa_spi.c | 24 ++----------------------
 4 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index a1fd3807b455..00b1ff1e50a8 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -350,10 +350,6 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
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
index 567f9a465a01..83dbc3ef8ba4 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -60,6 +60,7 @@ enum mpr_func_id {
  * @chan.pres: pressure value
  * @chan.ts: timestamp
  * @rx_buf: raw conversion data
+ * @tx_buf: output buffer
  */
 struct mpr_data {
 	struct device		*dev;
@@ -81,10 +82,10 @@ struct mpr_data {
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
index 65958b1186fa..021c0ed812c0 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -18,35 +18,16 @@
 
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
 	struct spi_transfer xfer;
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
-	buf->tx[0] = cmd;
-	xfer.tx_buf = buf->tx;
+	data->tx_buf[0] = cmd;
+	xfer.tx_buf = data->tx_buf;
 	xfer.rx_buf = data->rx_buf;
 	xfer.len = pkt_len;
 
@@ -54,7 +35,6 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 }
 
 static const struct mpr_ops mpr_spi_ops = {
-	.init = mpr_spi_init,
 	.read = mpr_spi_xfer,
 	.write = mpr_spi_xfer,
 };

-- 
2.51.2


