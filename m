Return-Path: <linux-iio+bounces-27164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C5CCB8A1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF56B305A114
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C4315D37;
	Thu, 18 Dec 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="0sAK5z0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9C2F83A2;
	Thu, 18 Dec 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=VQ+vjBAa6eFRyKvXidBDa1iVw5Dz6aS4DICc3RK4nvIvW45XjJTaW2sR9i6dqD0MfrGDkhawLjqkCzPJYjFOyeBGrbShKIWNk6kgolbP1zZ2Kt/rTBxel8PfLubSV0WnccJeMyfMNE3UdGrawl8cidRvDPyr8o+joy7iAFUP7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=4s2rTfy8Rc4f0E6bbCAsoMkgp8IOoWPTrBeuhgLf6TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvG4uVIc9A6y0FpsXo57umSdLiC1uBOjU8ekG8G/9TDHHlPCy1/58y2zU8GePN+br3ck788/y9GVUlvSSr/IWXkYrmijQlKH+7kMf0OA0Qwxe4Txn5gQFYj/2eNahDNyMyNNlioxoy5peEzzHIHtWMb/YA8TioaACAWC8PRJwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=0sAK5z0l; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A1FD1160210;
	Thu, 18 Dec 2025 13:06:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPOp+RTkgUDq1Xobzu5FbM62WKoxXthWCEcNxYe1Q3E=;
	b=0sAK5z0ltB967s14ri190aqetrHqAMsbAMnYNgv2aLTuF1LmboEBQ+qnHrNo9AySpFOZPU
	FygoAPU4ZU3zmB0uj5HrM9z1EgJAGfOY5rfBpImU4O0BuIq/O7u4vqPZUwNbA+7EuMInTr
	ZN/E2imUhntuQzSawkM+b4VQZ2wsianhdRbETMWPnEpnZ2DOqA5KB+5kBR0KdvVRai5p38
	0Nl8FtTG/JxrizcGR+FkjnYov9WRGBe3lXh+S3Bs8gJN+M1rbRJ95eJqz1YzsifNWEBTZY
	5d3LMcNXxoKBOUwNxEG4H2GHof2XS/btio99tbLs2wMt9/CkQL03BULwNGFWLA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:49 +0200
Subject: [PATCH 07/14] iio: pressure: mprls0025pa: make ops->write function
 consistent
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-7-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=4s2rTfy8Rc4f0E6bbCAsoMkgp8IOoWPTrBeuhgLf6TU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJlc1Vta0VRNEZFMkZ4WWdVeGQvTlhOCk5nczNMeXJJMWg1QURreFNo
 cDBEWG9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVh
 BQW9KRUhRcko2ZGpPa2xqd2lrUC9STHQ2dTNtY3pDRm9kTGl1ckg5QTVFRXZwWXRTQUl2VGExaQ
 pTektXS09odHk1YjIvMjhLbUdSVk8rVllCOVdmdFpGUHh0eWtZTXdPOVdSYnRXQVJMYWFNa3FXe
 WQ2UDJLakR1ClUxSm1rclZFSnhwelJCS1owY3BQODZ6cGlIaHhkRmdLTVk0dXpaSm52R3BOdTND
 ZlQyRTJqeWwrWGw0cjFvYVUKc21rWXRDcExKSlEwWHhZbGFMdFViTUdXa2t6aFlVbFdCWWlWMEJ
 rYWRwZ1lUMzZLR2JPd09OOUFhb2liTmo1cwpRVGRrMGtnMHpsZjZwUHBjKzROZG5yanNoZXVzKz
 B6ZFpGRW5GNXlNbUZtVUU5aU42OUVxSkJuUW1VNi9UVGM5CjhHL3lqWHRjcDZhSm90UEJHYkFKV
 3ZodlVva2NFNVRxL3JDcWRaN3ZiWWkwdWJ3YUNVMU9KNkJxSUE2bDU2dHMKSDlsdmNHYlVFdTMv
 Tk1xMXB1ZE9RZnlZbUhySXdCV01aeU1iOXpNSE5lTExHdlI4bGRDRVJ3b1hSbCs5cVZoZQpCbkt
 GMkhzMm1FUE5pYVR6bVpib2xsSG42UUI1a2ErMzRDTkZvS0RpQ254bkVVTVJIdWZua1NWOUVWTD
 J5b2xGCitQbkpQS0kvUkdiUmNKK293MXVMY2NiRk5mMUlUTWtrSGtMemF4a01kTFN6aHJjQkFvY
 jFaQjd6WnJLSUdSKzMKV1BLdVJpamY4a3poVXFNMjJaRE1PQlNIeVp5aXpwSm1yVEdRQTVTSGpz
 aUd0a0syMFBvWStSRmNyNnMwOHo1MwoySlh1SXlUd0RqTy9KVGZRMzVMRzQwWnVLVG5ycjBtWEQ
 4UWVEeGVhMG0vT1BGdVdhN3NJeUxpc3d2R21GUlVPCkZpUnQrUlh0NXY0Z1hRPT0KPVNhcGEKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make the i2c bus write operation more consistent with the rest of the
driver.
Also move defines only used by core out of the common header file.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c     | 5 +++++
 drivers/iio/pressure/mprls0025pa.h     | 4 ----
 drivers/iio/pressure/mprls0025pa_i2c.c | 9 ++++++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 7cc8dd0d8476..7f8dc47d7073 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -39,6 +39,11 @@
 
 #define MPR_ST_ERR_FLAG  (MPR_ST_BUSY | MPR_ST_MEMORY | MPR_ST_MATH)
 
+#define MPR_CMD_NOP      0xf0
+#define MPR_CMD_SYNC     0xaa
+#define MPR_PKT_NOP_LEN  MPR_MEASUREMENT_RD_SIZE
+#define MPR_PKT_SYNC_LEN 3
+
 /*
  * support _RAW sysfs interface:
  *
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 83dbc3ef8ba4..50c99ddc8937 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -20,10 +20,6 @@
 #include <linux/iio/iio.h>
 
 #define MPR_MEASUREMENT_RD_SIZE 4
-#define MPR_CMD_NOP      0xf0
-#define MPR_CMD_SYNC     0xaa
-#define MPR_PKT_NOP_LEN  MPR_MEASUREMENT_RD_SIZE
-#define MPR_PKT_SYNC_LEN 3
 
 struct device;
 
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 0fe8cfe0d7e7..5508a1681b7b 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -34,16 +34,19 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 	return 0;
 }
 
-static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
+static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 cnt)
 {
 	int ret;
 	struct i2c_client *client = to_i2c_client(data->dev);
 
+	if (cnt > MPR_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
 	data->tx_buf[0] = cmd;
-	ret = i2c_master_send(client, data->tx_buf, MPR_PKT_SYNC_LEN);
+	ret = i2c_master_send(client, data->tx_buf, cnt);
 	if (ret < 0)
 		return ret;
-	else if (ret != MPR_PKT_SYNC_LEN)
+	else if (ret != cnt)
 		return -EIO;
 
 	return 0;

-- 
2.51.2


