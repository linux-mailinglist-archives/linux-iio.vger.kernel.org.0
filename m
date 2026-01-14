Return-Path: <linux-iio+bounces-27752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D69D1DE20
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED43030477DF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A4338E10A;
	Wed, 14 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ohMzwctc"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C138B98B;
	Wed, 14 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385275; cv=none; b=B4H3YTUFmVf5BryETeeDHzJe/U5KLsPlDTQK8uoH1IZKObcETmZnrK0JI3R+j0s1495n6GKIhg0O58rytW8qCheVxam331RIpKLYTJDir210srNHOQOqhUd5iL0KViLun2rx2Qfl9sGz/YpN5kwt8RDOF/0NiFFSG3aC7vvVrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385275; c=relaxed/simple;
	bh=F7QdlnZXr1YFo0d62ot4N6Uu1lCneEx3/osA687r0oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hS434Jj9kOLg6w+wuzh4JOUBMjPdQF2Jpjj9mRwaJlTUnJZxiQkBGAw+3raLJopzx2bw2DSEOsQMMfvjm1PhViWgCVQtbg3Ov3cusP6gEurNPC8rmdUosKOMs3TCVQuYkgudscliO64mTJwnErtFGoedefNOZbj5Iw91JnYibrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ohMzwctc; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 4209F160212;
	Wed, 14 Jan 2026 12:07:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQiBm8/EVxjFZgRPWykvrrYwBnm8p+PJbdIHgiGhIEk=;
	b=ohMzwctcM64WdUK6lzl/qqVhT51lzX77yeC/Y10oZ/QCYmigmq0mKW9xFZZ+V33tDBoHMF
	74DEkam/ybv1DgDg9FfED4R04Sf7zWvdqgUEBG4HicSXlv9JsOPd/9+oz0swMXLUuj3tQs
	ELntFG96LQ1bkqvNXMNyyFhIbrLSmELvBXQGlonP4+Z0rXNonvwm/tAN789LDDri5g+BX6
	RFvzknSny4tXDK6ij+3a/jrJvAg04ibVt0TPAOCYeSE+bV2GGD46lVoA37QqlGZYBbMrqh
	sypkAbtdY0w4P7DojOZ6zsww6r7KMKJp+9nHcvE0gr4izwebuQEwjpAMS7pTnQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:42 +0200
Subject: [PATCH v2 08/13] iio: pressure: mprls0025pa: rename buffer
 variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-8-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=F7QdlnZXr1YFo0d62ot4N6Uu1lCneEx3/osA687r0oc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXVNeEVJRWJlYmFKVG1kQ0tNbmFjRERrCm9RdFdtMWYxYWF4WGpaNlF5
 N1NWRm9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycmp
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTZqRA
 pFQUNBNkkwWGhHeXZvZTZ1eE1ueXhGTXZiVmlvTmtrcUQxTHBNc0VVUEdQWCtTZWdNOEFzdUZEU
 nJCSGNnUWtXCnhBdjRlOEh2M09pcEEzV3dXbGxydi96eWVXaVZvcE9FcmwvMGtTclRadjQ3R01Q
 VStQdjFSZCtHZXBNSmRERU8Ka2tTOWMxRC9rbEc5dHg4UmJoWGV4bnZKQWRwekVScDZuZDNvTEt
 OK1VkVTVBUkJyOVNLMGhFMHByb2pvMUY1awprQjFaRkZKSVhNU1ZuZVFMU2hqQkppcjU3SStHMm
 NESkl4V0Rmb0h5NW9zSVJncjVzMTFpRnJQcVRpY0x4WFRRCnpOY3ZMMFM0MXNwQ3Z5TFFvdmQvK
 2h6d1RVM3ZzYndCUzdmVEdkL3VzRlVYVnF6TEE5eFN5N01yTlA3TGxWRmEKQlJzSEc2cWROd2Na
 MHdLclNZS3h6VjArNnowMm5pbllnKzNYUnY5Tm9ZbzZFdEZsNmhMRk5RN2xyNjJra3QyegpRVzJ
 CbEVpejNxUXVqYy9CbHMzQjhPS2Q3Ri9HanhoVHlhaHJsUTMrQnhORG11cW9yNUJhYkJoQ0xzNk
 R2R1E3Cll0MXlvcjNZU1BOVlFLemRjL08zVDFSQmhoMkJHWlhLZlJxQThtWWw5cUFLSXh3YnNzd
 VZ6TUhkS0M5Mm1QRVQKTGF4SkhEeXRNVkJnSzJOeWFETGhsRk5CYmphNjVITG5QZmlMMlc4TTRy
 cVNkZVJxQSsyOWpDNTRKQU9IWkJiNApCMnpudTZDNzE0SERTV3VCWkYxWjVKdFUyeE1MOEx4bVV
 ra2l1dm1zSVZXTTNhUUVPZVMrN0wyaktFUVM2MjF4Ck92Mk13a0I2QVJ6ZjRITkRyVlEweFJyZk
 95S1dPWFVtSi9wUlpOZStCRFB6UzQ4Y0s1bz0KPUc5TWUKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

For the reason of better naming consistency rename priv->buffer into
priv->rx_buf since tx_buf will get introduced in the next patch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no functional change
---
 drivers/iio/pressure/mprls0025pa.c     | 10 +++++-----
 drivers/iio/pressure/mprls0025pa.h     |  4 ++--
 drivers/iio/pressure/mprls0025pa_i2c.c |  4 ++--
 drivers/iio/pressure/mprls0025pa_spi.c |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index b0f70c9b503c..fd9c8ea61eb3 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -238,7 +238,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 					ret);
 				return ret;
 			}
-			if (!(data->buffer[0] & MPR_ST_ERR_FLAG))
+			if (!(data->rx_buf[0] & MPR_ST_ERR_FLAG))
 				break;
 		}
 		if (i == nloops) {
@@ -251,15 +251,15 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
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
index e34253af8e23..119ebb0ba567 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -54,7 +54,7 @@ enum mpr_func_id {
  * @chan: channel values for buffered mode
  * @chan.pres: pressure value
  * @chan.ts: timestamp
- * @buffer: raw conversion data
+ * @rx_buf: raw conversion data
  */
 struct mpr_data {
 	struct device		*dev;
@@ -75,7 +75,7 @@ struct mpr_data {
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
index cf17eb2e7208..247b65226bb9 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -56,7 +56,7 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].tx_buf = buf->tx;
-	xfers[1].rx_buf = data->buffer;
+	xfers[1].rx_buf = data->rx_buf;
 	xfers[1].len = pkt_len;
 
 	return spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));

-- 
2.52.0


