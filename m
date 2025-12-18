Return-Path: <linux-iio+bounces-27171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9FCCB919
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCBD30528EE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8D315D35;
	Thu, 18 Dec 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aMrj6yMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DB3128A1;
	Thu, 18 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056469; cv=none; b=GjAF68tJOuzbsFap3bxrj7rd7qdyyJrBJBejGQs0c/09bnU8p+aR1b4o92bLWLz4P1Qpp0uvBa5QmBYyDriyZJPmB1i2qOY7eho4syQUhQAyc6sA54mXIv7A23B9pcwdqWBZvI/eLjC5PTG2Zo+9DFwuZR8m3/DbzkYedDUnvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056469; c=relaxed/simple;
	bh=1coGTefDFpJud9GjaT9tBoJNihKOd+3uZmtnEgI/peU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGJcVMCtqqLX3j2iwPPZV0QWwzinCaEz7iHzfPNAoGKbzwuIV0Tg+7vvapr0OqjN7tlYE3uKb1LLJQVfx4elH5QsSDwVWDrLu4IAXlfw55k+mNg9stfTexpmT4hfifeQODVj//sgf0EzJg9uvd9biJfttalHU6cV4YZ9Tu2M/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=aMrj6yMW; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9D8A516020B;
	Thu, 18 Dec 2025 13:06:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMjFVRQ20JyE32MWgj0CsR8LhHhUMC95H0NKR5JiROQ=;
	b=aMrj6yMWu9wEqQxyBox3sJNIsaCPQLYp65JGVSfrb5tb9nYVP/pJ2lGtBqnyIN+nb2yTZR
	wymMV/9mUfGJytyZpAu1h0i9kp9kVOwQ8mn7u2JpGJcsSgfyJG9xJOlYz+IVMR/acSwz5E
	Ov6SKTEGQq2tnOI+r43+HYiQMBowAhjRxAxmBg+gjHXZVtSBCSMREiqEKIYyqI3NcoOqYZ
	7P+V3OZWfVCDI7rSzIgc8j6RCSye2YQR5v5vxLo5UT2sMM1o7RDERrJsMQaNNui6M0pEKw
	9uOBrgb8cNOd8njnQC1P0M6KwKxaxO2JXRCkEvKA+OdaWI3HWk2z57zMdQF3zg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:44 +0200
Subject: [PATCH 02/14] iio: pressure: mprls0025pa: remove redundant mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-2-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=1coGTefDFpJud9GjaT9tBoJNihKOd+3uZmtnEgI/peU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEE5eDZTSXBBREY3eENCbGlwWEJJdHdHCm1zMjREWUF2dHY2cUNzenJ3
 U04vZ0lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVB
 BQW9KRUhRcko2ZGpPa2xqUGxrUC8zRUlxWGFOU2lRK0t6YStlelRCaDMweGNrNVlZOThmdEtqLw
 oydHNJUi9IYlA4SmJvQUxFaURTNW5RdldsVHF6QjN4SFNCbjg3U29XaXdhUnBWMzRISWxEanNuV
 FY0Sk9iZEl3CkFLcmw3Vzg3NUF0RUhoWHJRRFlSazQ1dzBybXV6clppdkE5Uy84dXpZbWI3VGs4
 VnczSU9jblRIdHRMWkZoalkKSUIxU0xuS1N1bENJS2J1K3ZOZHljY2taeXNFSEVSMzg4d1NZdjY
 3aS8rMTVLcExwUzJ6ek9uQkxoTjMxc3NVcQo3NDlseGxiQzdaWVJoL3lpMHdzVnJDeVNnVFFhWm
 h4ZkJRYlVqTm5uNjVZUGpheTRtUUo1VzcycTVVeEZockcvCk0rSVV2ajFaM3piMlFROFVSdnlhT
 EcyMFhFWXhrcW1tYkZPTEJXRDBiMnNybXpmSGtUWHRMZVdRTFNGckhzZkYKenJRcmtvRkpRTmYx
 S1hBMjAxRzRQR2pGSDNYVytrNWFaYkFuVDFQOEV5M1dXNVV0SjRIMWJBclFOUDNHL2lZMApyaml
 PU0Y4YXFjbUtKMWFEbkMzQTY1VTdoUFVpOGNxcjBiWlA0TWkyY1VOTzhYQUhIWXVnZ1owWDByYj
 RBTW1FCkZpR2c2MGo3RVp1U1ViRlhMcW96Unl6Q092UWczRGZNV29KRDUzNENwM0thcElzcmxaL
 1FVa1NvM1FrMHRtNXYKcmFHWnVkTy9xVW9FeEZSWlpnYUJYZGNwYUREMEFuOUlJTlNpcEZ5ZmZD
 S0NyTFlGQ3I0T0Z2aFA2VmlCV3JrSwpEYVE4SjRHckRsMnRQaTA4SWVMVi9WMjYveXNETVB6dEw
 1VEVuMmVUQi9vNW5pM1doeTlXSE5tSkxhUVBIZ2hFClVHSFdTbkpSeEVRYldnPT0KPXBscysKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove the redundant mutex since both i2c and spi transfer functions
provide their own locking mechanism.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 6 ------
 drivers/iio/pressure/mprls0025pa.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2336f2760eae..d3e76eed07e6 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -188,7 +188,6 @@ static void mpr_reset(struct mpr_data *data)
  * If there is an end of conversion (EOC) interrupt registered the function
  * waits for a maximum of one second for the interrupt.
  *
- * Context: The function can sleep and data->lock should be held when calling it
  * Return:
  * * 0		- OK, the pressure value could be read
  * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
@@ -273,7 +272,6 @@ static irqreturn_t mpr_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpr_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->lock);
 	ret = mpr_read_pressure(data, &data->chan.pres);
 	if (ret < 0)
 		goto err;
@@ -282,7 +280,6 @@ static irqreturn_t mpr_trigger_handler(int irq, void *p)
 					   iio_get_time_ns(indio_dev));
 
 err:
-	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -300,9 +297,7 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->lock);
 		ret = mpr_read_pressure(data, &pressure);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 		*val = pressure;
@@ -342,7 +337,6 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	data->ops = ops;
 	data->irq = irq;
 
-	mutex_init(&data->lock);
 	init_completion(&data->completion);
 
 	indio_dev->name = "mprls0025pa";
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d62a018eaff3..d38ac750e392 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -14,7 +14,6 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -44,7 +43,6 @@ enum mpr_func_id {
  * struct mpr_data
  * @dev: current device structure
  * @ops: functions that implement the sensor reads/writes, bus init
- * @lock: access to device during read
  * @pmin: minimal pressure in pascal
  * @pmax: maximal pressure in pascal
  * @function: transfer function
@@ -66,7 +64,6 @@ enum mpr_func_id {
 struct mpr_data {
 	struct device		*dev;
 	const struct mpr_ops	*ops;
-	struct mutex		lock;
 	u32			pmin;
 	u32			pmax;
 	enum mpr_func_id	function;

-- 
2.51.2


