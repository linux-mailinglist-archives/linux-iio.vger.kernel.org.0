Return-Path: <linux-iio+bounces-27748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD17D1DE0D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B0D30AC716
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09C38B9AC;
	Wed, 14 Jan 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ehac2Mah"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E638B7BA;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385274; cv=none; b=K6Pihy/Henvq4YzlZTZFwkDAjrxJBE7hLpfE25KWaJTq+PIvR5tz6DvfLwRgRYeR9Ve0MbntYedGrQyWE6sRZjLgShcF2XYnOQO1cqwR3ksehnijevztUAd+f2ibZ3YxOxMCoVgTkR2v7ynjMF0hMZ34M/fbgAmI0Ctyt6byaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385274; c=relaxed/simple;
	bh=LKvTD8aHqFRmeM95cBnwTmKJ6WfenpacionrWy/Xr1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfYu7/N5B623ZVChdrEimTXuUzndmA6V+NgnRcoe5HKzjOVCMQvX6F9f1TjEFs9MjmSf/tvvuPEtIdu44jUSWo2e5HHDmxJD/XaH2HUp5r4BHwFV0os7eZvfBuOsJAVWQt3DNXAaIN2e+eZdyKnFeKH3B33Ztt73nZeQNwlH0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ehac2Mah; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id AE7E516020F;
	Wed, 14 Jan 2026 12:07:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu9/knj6FOADhot47Dbp3LbH8d/8Y+l67aXoXVo8IKw=;
	b=ehac2Mah9ZjWMzGO7P4mSH+3OeTEGk5Kp47qYj+IVaLXW9oWRe7+FigrHVIRxrrJMlpLae
	g+je8M894X6KYkCAj75lOSHZDsRhbsFq8BhrqqP1cK5qYd//YiuBBMf2s01joFt9SUwL54
	uyue9V6VDJhUEw1Pok33jFThC608TiFyysbXG6AXouYeSbpb0RYXPi0Lbi0FR6vbvvz/3V
	k3yVNVIt4YmqDzIHbOyxC6DlRm/Zf5rrsuDxrYUqybnZdnURmNWPRUtm9TlFLmr27krC/g
	lg0hahAEYFYCJtMr/SxaXMRe7nAm9HYpbAi/++j/mk3/GjK22dc2zEL9ZCa+xA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:39 +0200
Subject: [PATCH v2 05/13] iio: pressure: mprls0025pa: fix pressure
 calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-5-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3697;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=LKvTD8aHqFRmeM95cBnwTmKJ6WfenpacionrWy/Xr1c=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXR3YVNpMk1JYXR2L0htT2lmTWZZdFlWCkxwWEtUQ3BJR20wWDVzSExD
 ejZ6NjRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycmN
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXg3SA
 pELzBVWUJOSTFyNkMrZ1loNWZwblJNK0lDN2lxYU1ETXg3Q3pVbmxacmtDd2hJT29TMThvckc1N
 Ul0NGQzNUNSCk50VWZpTHpwYTBsblNSNTdnNzQxbk95L2p5aFQwNFFDeTgxOFlkNHAwRnJPSGto
 UFBpSUthaU1GZ2YxYVN3QWoKSThEUzZVOUtxWE95RFJTNmxNR2ZCZy9lSnl6SWRKbkp5aTBtSHl
 6OFkzV2h6V1F4eHhHeWZHbCtrZW0vRlNsRwpBRHl3d28weld1MTFoM3lqVWhiVmRzZkVsWlVLS2
 tncSttQWd3THREVVJWcC8wNVM2L3hLZk0wbGViUXZyeTRIClg0c1lvTC83OTBNRFkzdkFvRjRET
 TZmOWFnSlRXNVJaWjd1aWlrVGEvQjBKODRYVmcwdndzdWYrY0lFTmJRKysKcHpVeTdvL3llYlJ1
 THczamd6QmdYRTZEYnBwUHZEbno2Vmd2M1hSU1l1eGR5YVNnMzE2cGtvZWdVVVFTWFgxMQpQQU9
 HRGVjaE40SFJ1c1kyQmpzQzNZaTdPN1p1Q3BZSHREL0lpZ0JmUHhXemNoU1plSmFQRnF6bzFsbD
 EwYnlqClduV003MnlvTlRxK0g5YVhwQUZhcENrdVM3cWMxeGVibEpidU5wbkIxV0FiY1FqeWo3O
 DdDWjF2U3lvRCttQ2YKeXlOazN0clE3NUhlWHVTRkNQQUFTRFA5S2cyNUhKRnJKTjl2OUVpdUlh
 QkkvU0NUVDExTXp1aHpwTkNhZEllTgpWS21uaENsZWZ5dUtSeG1VWEVRSms2VjVYVG5YbkhnS1F
 ZaHhrQ0xORnRQT3YwM2s4dVFGVUxxTThlUCtPNWdJCjljeVVxbW9EbXJtNEVEWHZjT2N2UjhwUF
 FUOXNXeDBnL2xSOTdvRC9mZjNXVi82WEloND0KPUtCL2EKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

A sign change is needed for proper calculation of the pressure.

This is a minor fix since it only affects users that might have custom
silicon from Honeywell that has honeywell,pmin-pascal != 0.

Also due to the fact that raw pressure values can not be lower
than output_min (400k-3.3M) there is no need to calculate a decimal for
the offset.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 slightly changed commit message, added fixes tag
---
 drivers/iio/pressure/mprls0025pa.c | 26 +++++++++++---------------
 drivers/iio/pressure/mprls0025pa.h |  2 --
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index cec0bb3fc16f..2142df7932e8 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -60,7 +60,7 @@
  *
  * Values given to the userspace in sysfs interface:
  * * raw	- press_cnt
- * * offset	- (-1 * outputmin) - pmin / scale
+ * * offset	- (-1 * outputmin) + pmin / scale
  *                note: With all sensors from the datasheet pmin = 0
  *                which reduces the offset to (-1 * outputmin)
  */
@@ -314,8 +314,7 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = data->offset;
-		*val2 = data->offset2;
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -331,8 +330,9 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	s64 scale, offset;
 	u32 func;
+	s32 tmp;
+	s64 odelta, pdelta;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -406,17 +406,13 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
 
-	/* use 64 bit calculation for preserving a reasonable precision */
-	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-			data->outmax - data->outmin);
-	data->scale = div_s64_rem(scale, NANO, &data->scale2);
-	/*
-	 * multiply with NANO before dividing by scale and later divide by NANO
-	 * again.
-	 */
-	offset = ((-1LL) * (s64)data->outmin) * NANO -
-		  div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
-	data->offset = div_s64_rem(offset, NANO, &data->offset2);
+	odelta = data->outmax - data->outmin;
+	pdelta = data->pmax - data->pmin;
+
+	data->scale = div_s64_rem(div_s64(pdelta * NANO, odelta), NANO, &tmp);
+	data->scale2 = tmp;
+
+	data->offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d62a018eaff3..b6944b305126 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -53,7 +53,6 @@ enum mpr_func_id {
  * @scale: pressure scale
  * @scale2: pressure scale, decimal number
  * @offset: pressure offset
- * @offset2: pressure offset, decimal number
  * @gpiod_reset: reset
  * @irq: end of conversion irq. used to distinguish between irq mode and
  *       reading in a loop until data is ready
@@ -75,7 +74,6 @@ struct mpr_data {
 	int			scale;
 	int			scale2;
 	int			offset;
-	int			offset2;
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;

-- 
2.52.0


