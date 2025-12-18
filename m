Return-Path: <linux-iio+bounces-27163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F299ECCB8A4
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50BB5304B03D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57FE315D2B;
	Thu, 18 Dec 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="l6tvGBlp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1103126B7;
	Thu, 18 Dec 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=cmHXeox1MYfBBlnIJhRhqWtHpmnnj8vpkFlWhm81rEn1qjeFSeDhH/bd/SdPRioJOTUBkCVBDJXjVcFtoUqKVLZeiRbdOOFcCsWpVW0dn3WnMPAqrYy5hGvUKL94PZuQpYR7lmgzcYYCybk+VqprCKA/W1Aha6mh6mrgF0UdbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=5T9rsS+I1fbLvEWUW4lEIjx4Jbwa8+/QXH8wG1z6CGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idjUERqEZmunxMW8w0O4+lkX8TukgjRQpPZ5I4KBsMgNNwSqEOmgpRmac4AY8IwKbIvVauDmtRK99u265aHhlQWqByFdzbbNvQc0x7mwefmpEbP68Ftf3f4/FwPFxhx4tarY7ezoKw2Ya6AG7iUUZ2aZB36C/F0RP73/NeKY8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=l6tvGBlp; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3D70C160213;
	Thu, 18 Dec 2025 13:06:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYNUr5LM3yJvHJEtcWjM44hfWraLErHaf9XQzDx+Ask=;
	b=l6tvGBlp0A+XphJCzBvF3EnuDo4UvdaTLHDxwtVZ8vYYhcrKVIeRlYp2BL3gQ4C7ssosCj
	JaZLu2t5TuAlgZOq71ZUVMQWZgjmTvL1wpAuLxYXWem4XiGiiCnCZlmhACEx5StcI3PbYP
	/b1G3aEHF5iDWXvQOVehnzW7ZSuuUmA/tVVHCPxJfQbBHW6qUoI/PgTUNA6JknRqqTV1A/
	fXCDMLl/WHvwieKJWeRHA47y08iUCqgmSM36WKTflSImnG29NMCxvdSzDVdSv4MvKeNpn3
	j7PgDPG0PzbbYX7wCqtSKIayfWyYscCS4LmZ/kFiwZXfFMiZIfL04mZoEgiTcQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:52 +0200
Subject: [PATCH 10/14] iio: pressure: mprls0025pa: cleanup pressure
 calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-10-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=5T9rsS+I1fbLvEWUW4lEIjx4Jbwa8+/QXH8wG1z6CGg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJ5RjFsb01CU21zd2RxVmNiRGJxRWhKCndRcTkwcGtOSmpVRGQyb3A5
 endWQzRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWN
 BQW9KRUhRcko2ZGpPa2xqQ293UC8zcEZxN1ROVHJSTHpjUVNNVnRtUkFaVE9ZaHlRMWFrR1ZCTA
 ptV1JvUlpJQ0Q3SzRsYWNETHduQ0dtTnlJcldWWFBhcHlhR3YrYUc5MUtHL09uejF0NGhkRm45S
 nVKY1hjWTFpCk1PRVV5TTVtVTh2SjdaL2ZCRGNMNCtncmx6eUhLeUhWK0svZ0tqbS9KV1VTQTlp
 c2orRHNwdVVrTFZUbzVYVFcKQUh2ZC9CZjVGSTQ0ejRKNWg4eDhWaVRnZzNBOHVldU03WEZhZUZ
 FLzZMcG1RaWtIczUrTnI2cEhKOG9mZHVkTgpLcXhtRlc5OERSZ0x0QWNCVDBacGU2bVY2d2lWZX
 V3Kzh0ZTNMcDd0Z0RFbVJmWW1QRnMvdVgveHAwY2NwdnczCk5JQnp3TnNDTFEwR00rQzY0RkhNY
 3hFZlBobVd5ZHo2eVpQSG4xOTJNc1BOQjVDRzd4QmdHQThQREsrS3F1SUUKai9wQ0F1YXJmdkVn
 UjRKaDBOU0hyNytjT1VWMHduamkvSTNmSEhkdmcvTmNpdkU2d3BkK3hHQTFqclJtSVZyWgpLa3h
 2OXk4b0svWURkZHZlYjliWGlGeHplSlJhRHJqRk9KY2E1cVJZZm9ZMzZ6U1VUSmxzejFtL244Lz
 ZyTGRwCkRMc21odnZJNXl3ZTdia0crY1RORlQ2OXVtRnljNWhlcnQ1L3JFYmZnazZoTTFHZVVhe
 DE5NUhJSHgzcHBmYmMKeXRwRzZnaTRNY215YitmYkxZY0EzTjFLQ0FsRStZZ3JpVUUxOWFSZFlq
 VkpzZlJCSFVKdnA0RWdmamFPSzRrbgpUdkVsSTdITytCaHlBek4xbCtka1dudjhOQ2QxSFRZOWp
 0QU42aVRpQ3hjWkNtRlh4aWZ4WExzTU9KQmpuY2ZjClVKaDBFNUdBOFZZZFVBPT0KPXY3cE4KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

A sign change is needed for proper calculation of the pressure.
The value of the affected element is zero for all official MPR sensors
covered in the datasheet.

The change will however ensure a correct calculation if a custom chip
is used (and if honeywell,pmin-pascal != 0 in the device tree overlay).

Also due to the fact that raw pressure values can not be lower
than output_min (400k-3.3M) there is no need to calculate a decimal for
the offset.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 26 +++++++++++---------------
 drivers/iio/pressure/mprls0025pa.h |  2 --
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index a1d7ec358036..9b18d5fb7e42 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -64,7 +64,7 @@
  *
  * Values given to the userspace in sysfs interface:
  * * raw	- press_cnt
- * * offset	- (-1 * outputmin) - pmin / scale
+ * * offset	- (-1 * outputmin) + pmin / scale
  *                note: With all sensors from the datasheet pmin = 0
  *                which reduces the offset to (-1 * outputmin)
  */
@@ -307,8 +307,7 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = data->offset;
-		*val2 = data->offset2;
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -324,8 +323,9 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	s64 scale, offset;
 	u32 func;
+	s32 tmp;
+	s64 odelta, pdelta;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -394,17 +394,13 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
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
index 50c99ddc8937..2bdffe1e0eb1 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -47,7 +47,6 @@ enum mpr_func_id {
  * @scale: pressure scale
  * @scale2: pressure scale, decimal number
  * @offset: pressure offset
- * @offset2: pressure offset, decimal number
  * @gpiod_reset: reset
  * @irq: end of conversion irq. used to distinguish between irq mode and
  *       reading in a loop until data is ready
@@ -69,7 +68,6 @@ struct mpr_data {
 	int			scale;
 	int			scale2;
 	int			offset;
-	int			offset2;
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;

-- 
2.51.2


