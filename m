Return-Path: <linux-iio+bounces-27799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35648D205F9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EDAB304DAE2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6733A7851;
	Wed, 14 Jan 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="dPKIfU0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60663A7848;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409796; cv=none; b=WIfS9Ytr5+oC3NC84yqBMd75nw7Sh/ulnMxpPitFD1qCsM1uTGvJPKcu6SEtSMzsx3g5QtnHuGdKy4/qDFj6+J3ME+LZ9K6TZ0hTD4HsT2ZVn6Kok+nJgrModFCxckiUz/+WmB+TCMJrxomZuemyb7G7tC948LtVgeeUvhezrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409796; c=relaxed/simple;
	bh=WJKVLZ1I2EIW/6qv0xlsg3N1W2Db/KEadYzBTpe1u4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McGCDikHj7E6Mt8YaJbeeFL+0vYKhzbYvbeSyQkmlShkrj2hprTzcS8AjGOKNTlxtijTN0dckcosmTvxo6pWlnpFs63C9yjrRB9PXX+IU3kTawgGCXd73aFjn6hhCHMMgJFJEkJvprMgWgq7E1FPruS/9Cv5iWRLWnW7Mkv+2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=dPKIfU0G; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 65788160212;
	Wed, 14 Jan 2026 18:56:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vATulwRPClMT2N7MVmTwYrLe+WT5uKETu05GKANtcWE=;
	b=dPKIfU0G5i8Wm9BK7YmPvkqBgDK9mMevl7aWvgKk5botM6RaAq13VhB6eu6OZVGUYEImPI
	YDkGFu5NK1RJ+69k1vRnickR05igjL0PwS3aD04x9r2nVQar+VE2tKHskIMjpzdhHZXvfr
	LxapUlhKXFTyr8nZkiTKItZLjMJ+gbX2OJaVS8SoNI90McBfxU5JlQBGL89/B1rNixcVx3
	aFPgprYwXkn4uudVp6Ah9M5/DX6jqVPWNdkl5UKyx5kAmQF01CIREwn0g17qEPJrUIJg08
	L0Ykvvtu8DAnPQljSDMBcNco+B54GKJ3bnn1MlOU9IQhFTZmbKCKIEHHsmabiQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:37 +0200
Subject: [PATCH v3 08/13] iio: pressure: mprls0025pa: rename buffer
 variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-8-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3566;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=WJKVLZ1I2EIW/6qv0xlsg3N1W2Db/KEadYzBTpe1u4M=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXFmSHJYbUdRbTN4L0ExaEh4WG13VGtHCkw1bVhiR0t4RVp1QkcydllX
 T25mam9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cW5
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWStvag
 pELzlPZUxTeUdudERsTXZCbHhQV1daQmZNVTZxNEYyYi9FMTlBdGRzK2ljOVp1Zm00bXZSejc3M
 HFSeXBWc1ZnCnNiMGg3RU8xYlU5QXlwNmRZNzVtNnM1aEQ3YjRQRDBjUys0cHNMKzJIYU1sZHEw
 eTVvVVNkSS9wUlRTK3hKSzgKWm43elNuZlhybjZ5WWJKN3JTT1ZPTGx3WVJST3VqNEtoMjhyR3d
 URGE3Y01LcldNTTBEaXJ1Q2w5U0NGYUVETAozT05tYWQrV0dueWtWdEVHWEpHSGNWTThCajlPa1
 g2SllzVmZ5RmhOMVNtRWljcFg1VU1adG9VYUlHNlBLOHp5CktlK0M2MUx0KzViWWNvRVFFamhxa
 2tYK3FaYXVqMnRMbzlZcU1TYmNJVXNBell3VWcyTEFYN2pNQWI2anF0UWcKN0E1bWtUK0VUeEdY
 Zkk3VHlTZ2RsTG1tNWZ0czlLc3BqV3N5S0paOVNkRm9xSWdLd3U0cmlSdkNwUTZvVWxGZQp4K05
 LMkhVdmV5S0hTODJJWUMxTWpxVk9Hb1F0Wlk1a3BhdTZ3dmRGcEx6aFRNWTM3N1FMWEozL0pJVG
 8ramZ2CldoaUg3SzdveW11ay81bTF3UGpic2ZTL2xDa24yRjJFR0pJTjJFTFFIRVJxVXVtZ3hOb
 m8xL2RWcGhtTmZVSnUKV2tzdkE1VjhFV2w1Tndha3dQNlk3eTJYRU5VT2EycDk4SW5YdS80NSsz
 ZCt4a2dRZFpIY3VxM3hCb0hWWEF3WgpwOHR1ak1nOTl6R0lubzB2aWEwSGg0UGRCTUc0SGhUSWw
 0b1ZiUkUvYnJCeUl1VnJRclFZSmZSWFZCUWZJZWsrCmNEQlJNNW1sZHdMVHdzVnp6Q3BVWFNQTm
 V2dnBLQXYwclpadFhWT2VHYUFKRzRTRUs4QT0KPVhuamsKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

For the reason of better naming consistency rename priv->buffer into
priv->rx_buf since tx_buf will get introduced in the next patch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no functional changes
---
 drivers/iio/pressure/mprls0025pa.c     | 10 +++++-----
 drivers/iio/pressure/mprls0025pa.h     |  4 ++--
 drivers/iio/pressure/mprls0025pa_i2c.c |  4 ++--
 drivers/iio/pressure/mprls0025pa_spi.c |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 3a5dbec81b50..245d7ed82b6b 100644
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


