Return-Path: <linux-iio+bounces-27172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E187CCB908
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C068F3030CB7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261C316193;
	Thu, 18 Dec 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="4L3P97xQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA314A9F;
	Thu, 18 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056469; cv=none; b=R4h0cSN/U6OO0aKgte6XwTLtunfnixv8gCP/n38O20AWOu1iCXWEyr9bBrQueCp8GyuiOxkW7W1Bsytl/uQWJm7aKvtl9Suyqb87rjq8q0XWFP48sVHL/Nr/sbzs1eI1Q6P4VCm8fWDxd77NtNojjgxLXV58Kz9HsUlEKypLuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056469; c=relaxed/simple;
	bh=sKTW6IBIfdkk0iNLSPI1Dms7VRckFpx2Oph0OcH66iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdY/66n7eC8hv/+TNYjWxG4H7F4PmDdtZw/PCKZukw0XwdEuL+u7bv8by0nO3yWslkmswzhxFBOzb9DK5X+BH/OPt2bHQeRlNJCtMzoG1NIAq6kvvSVTM4lQjCS/vEYIiHTzQ2z2rc86eb4XtWNusaGuf27T/3OaZhFnw/lr2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=4L3P97xQ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0EB4E16020C;
	Thu, 18 Dec 2025 13:06:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12Hs/dr79kvV6QCKEYb2XzPrzqxb3/7HkJRFJtYNjUg=;
	b=4L3P97xQ5/U8rglACXXBPc7pwb2iCntayqgYnUqF9lH6Dx0aJrI5nAwf18evYxmW5vbq6i
	geJbMwcPEbbugFLcKWkD7kRf6gNhi+pEgAGbQzEcMotu1LLyMYtePXcgmqWU1lQQJ+2e1l
	WBWDrmBDszNvyZ10a5LtgjNU/OhPOrkGSC38dNnEkOvxYu9JIdfEKdkMR3jAeLhjIPK3M3
	gPQcj60j0VKA+SyZQ9TfJTNShf96hvXwVk9PNFQ0+hw2q8MvSdYaBiijd6wi4YL9ZXFca0
	ZAsd4upAJlhw2Wju8sLavYK8Ef/Ml0UXA8atJywqBoo+BC/91zkolEPLsUi3ZA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:45 +0200
Subject: [PATCH 03/14] iio: pressure: mprls0025pa: rename buffer variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-3-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3471;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=sKTW6IBIfdkk0iNLSPI1Dms7VRckFpx2Oph0OcH66iI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJFNU5PcnlsMUdmVkk4dEJuTjViYk9yCmN2RytwbFU3ZTA4VWtGZXZY
 elUwZFlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVJ
 BQW9KRUhRcko2ZGpPa2xqdlpZUC8yMDRLVzh2L29kbXIxa1lhVUJDcjZSQmR0ZDg3YVVNUUh5Zw
 pxWFFvV0VjUEh2aXArTHhpM3ZYcmk1aUhPOWxscWpVS1dpajc5ZEw3ZllzRTQ0WVBoQVpYanFne
 WhmNjFDVTJxCkEvM0wxRzk5U0FwSVpManBQUlFDa1hhWlhZaVdlbHpIS3dsa0NOemphTFk2ZEJi
 UEN1Sk9iK1RmalJIbnZVaXcKMG9JdEJ6QTB0U3d0aVNZNHdWbXlwY09NMGhHNjdCYnZZdXZvLzR
 CWHlnS3oxdjRSZGNuNzRSdndxR295djZsMQpFRGpoL3BhODFkMlJTbmJXNCtxWXdyRDNyNlUwMl
 ZRSTNGdng4VGkxZkUxTG94Wm5FdnBEbytLYmNvY3U0c0FKCkoxbDJPdXUySzNITVMzZWkvZG1xR
 TY2WU9jdEEzMFZKbFkxVVhVWFVRMXZMOEtHSkdGMHVoUXNqSUpYTmhaaHAKRE9SUEM0ZmNnSGZx
 clV3bWQxT1o2a2dlczNxdytteFh0YTE1bGV2NUpYRmRUbEYvTW13d1k2am84MStWY3YyWApQbXM
 4WlhRdmY2UDNzc3hzSjEzQ2g5Q3haVWxPOHhEbUNWUm9peHdTeVYrZm5zZEFybzdDWEh2ajZDSE
 15TGVoCkptNDIrWnZoMTI3eU4xYW0vQlZ2QUhTN3Rpbkc2b004OFgyYlp4S1JUUGZUc3I3VVYwR
 EJONmNXUEdCL1Jqb20KY1pnbVRxcWZmeVpVZzZaVThkTkJJV0hEcG5EVzgxVHpmREFRSlE3T09r
 cVVhcUVueWlDNlNjM0FYT2pCTjhhOAp6Slp4cE84TExTa0dxamxaalBtQXFZbGxobU92YTdCdVM
 wVHA0aHdDVEprSkUvVVJVTEg5MVlFdURRUEpiOWdKCkliTENuMFQ3ZER3bThRPT0KPVZwdHgKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

For the reason of better naming consistency rename priv->buffer into
priv->rx_buf since tx_buf will get introduced in the next patch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c     | 10 +++++-----
 drivers/iio/pressure/mprls0025pa.h     |  4 ++--
 drivers/iio/pressure/mprls0025pa_i2c.c |  4 ++--
 drivers/iio/pressure/mprls0025pa_spi.c |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index d3e76eed07e6..a1fd3807b455 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -230,7 +230,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 					ret);
 				return ret;
 			}
-			if (!(data->buffer[0] & MPR_ST_ERR_FLAG))
+			if (!(data->rx_buf[0] & MPR_ST_ERR_FLAG))
 				break;
 		}
 		if (i == nloops) {
@@ -243,15 +243,15 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 	if (ret < 0)
 		return ret;
 
-	if (data->buffer[0] & MPR_ST_ERR_FLAG) {
+	if (data->rx_buf[0] & MPR_ST_ERR_FLAG) {
 		dev_err(data->dev,
-			"unexpected status byte %02x\n", data->buffer[0]);
+			"unexpected status byte %02x\n", data->rx_buf[0]);
 		return -ETIMEDOUT;
 	}
 
-	*press = get_unaligned_be24(&data->buffer[1]);
+	*press = get_unaligned_be24(&data->rx_buf[1]);
 
-	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, data->buffer, *press);
+	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, data->rx_buf, *press);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d38ac750e392..567f9a465a01 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -59,7 +59,7 @@ enum mpr_func_id {
  * @chan: channel values for buffered mode
  * @chan.pres: pressure value
  * @chan.ts: timestamp
- * @buffer: raw conversion data
+ * @rx_buf: raw conversion data
  */
 struct mpr_data {
 	struct device		*dev;
@@ -80,7 +80,7 @@ struct mpr_data {
 		s32 pres;
 		aligned_s64 ts;
 	} chan;
-	u8	    buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 struct mpr_ops {
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 79811fd4a02b..36da0059b19f 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -30,8 +30,8 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 	if (cnt > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
-	memset(data->buffer, 0, MPR_MEASUREMENT_RD_SIZE);
-	ret = i2c_master_recv(client, data->buffer, cnt);
+	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
+	ret = i2c_master_recv(client, data->rx_buf, cnt);
 	if (ret < 0)
 		return ret;
 	else if (ret != cnt)
diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index d04102f8a4a0..65958b1186fa 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -47,7 +47,7 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 
 	buf->tx[0] = cmd;
 	xfer.tx_buf = buf->tx;
-	xfer.rx_buf = data->buffer;
+	xfer.rx_buf = data->rx_buf;
 	xfer.len = pkt_len;
 
 	return spi_sync_transfer(spi, &xfer, 1);

-- 
2.51.2


