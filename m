Return-Path: <linux-iio+bounces-27792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EDD205EA
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE756300AFFD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01C3A7822;
	Wed, 14 Jan 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="e/ImHivy"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE943A6412;
	Wed, 14 Jan 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409788; cv=none; b=VUhKYPviD8KWqvfxXGIxa4vDy5UBlpO2LTMeqsSwhLdSuKQ70by1h4xg5sEJveqAAN5iOcrrCsywhxlD2yo0UnIUQoe9BdgOJyesLP2Q9TjhvbiR1ZQqlTtlbcLesdJ4NQJxXQWU+n/n5xmPiN2v7epUMefSD2XYZE/kHhmzqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409788; c=relaxed/simple;
	bh=W9aAMBBR6uyrjOwGrt0cli/0vzbAjq13Qzolf5EZ+Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQ+SC8wCdUXXGOJm3u9KIUVdtD0VK5bt8O2WTUpNJQ8cnP2C5Ahm2MGaYUYHT/9Issi46m3m/IhFuuzpttCXNeZxl2hSK6+LmyOHZueukezh/y29vawZQ4G8fPWeK98XFptaccZvsihnRAxaCABRPaEb1mzb1fAtnU2FVC2GtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=e/ImHivy; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 83B2B16020B;
	Wed, 14 Jan 2026 18:56:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeEhn/pRGwMuCxZxT+q3vRI9M7KSErrvZC+oQg46pR8=;
	b=e/ImHivyWuLYON92EuS87qOKfVlv2hm0z1T4u0oyWpUiyWSfPsFFtYAJi6kxPrjmwq6zfW
	14yAK71L0v3oEis4OA868O7TIEygaz7+dnxQSfe32VIQGQv5jhP4/sp1MYEgR6tuC7lX17
	bkgTmt/GVBxf9oFqkQkryUlSxbLTQrvYe7fgtdf72N8Im2+30a54OLdoXQW6JOTuFXcB6h
	x2Z+mXmisPnP8e9VkmH47xr2E1Mg6W0Emnytz86k0Faq3AjgJCtDaZcwssq9DQ+6dUPEo3
	ihtT41IaXnva+MiKGIj3Sz0UUXxp2fhRLpo88MlyO9gTHaAii++VllhUBhetzw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:31 +0200
Subject: [PATCH v3 02/13] iio: pressure: mprls0025pa: fix SPI CS delay
 violation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-2-bc7f1c2957c2@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=W9aAMBBR6uyrjOwGrt0cli/0vzbAjq13Qzolf5EZ+Lc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXBrcks4UHQzZEdjd2E5RUVxQlBwbmRBCjB0d244OTQ0aSsra0U5OG5j
 allNVW9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cVp
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXhqMg
 pELzBjT3JEazZVdkFXRi8wSFhVK2IxSnA3SHgxNnFwMklsakYxZEJJR2FWbGtZMGdGWXpuNXhjb
 HNRYmxHcHJoCm9wTis0aG5TNmZuQnZuQnZlTmZ1SjZyRGhXK0Ntbk8vdUpKdjZjV0FSNm52cjFV
 Z2IrWSt1RWh5TmU4d2dZUGgKaFlkenYwRWNBREdZb0NBL3oxazNzUlRTUVQxTDg2Q292ZlBrYmh
 jeHYyR2Q0NnpwZ3pkTXhObzJjcE1wUmowRwoxYzFZOURmQ29vbzllWjRlLzRsZTJ1NzBvdWVwWk
 ZGd2FCaktsaDVMdmNOOTNaclgxSEZUMkZ5MHozNElnNnJXCko5RGhhK1lrQWxaZ2ZaRnlEYlNDT
 UpjVTZrVStWUk9DRkZXc04veVV4OHJ3MFY2TWJYc2ZySmZHS1FuTnpnd1QKVU5MaWc0M29XcWhD
 Tk1vczBtNStqQXVHVDRlRExiVWNzakhCbldHSzhQS1J4L2M5TjNhc1k2eHk4dGFEbmQraQpnMFo
 0bGpaWXhxWE1ad3VyMkRVOXBmNmxFS0FGclR4dmNkSEQ5SEJCekRpZDMxWGRKelpJdU5vZTYybH
 AxQ2oyCnBtYXVSRk5ZUWtNck1raFptQ3pvL0ZuL08rczhpaHJacVN2SWhNU0tpY1Z3Q3NuU0dCR
 FJ6N0lYY3VTS0s3TjMKazFKUzNLZWJJYXJpL0EvWWhUaUdTeWh1OEkvenRmbkd2U3ladWpDN2hh
 bnk2MmNSS25WQ2Z4VmtzWXlMdDQvRgpBMStDK08xU2FtUzVvOHN0MEhNdkRoMkdBSUNuUjV3c2h
 WVEdPOEFtZnZXeVlxc1UyVDhSK1FQQ3VyTzdqcUo4CnpGdllnTnVKRWdUaWtpMGxLSHV1WDErSV
 JpakRIRkJBOXNoeHh2Q2lDdE9uaWZhT05IMD0KPTlYR2sKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
during the SPI transfer there is a minimum time interval requirement
between the CS being asserted and the first clock edge (tHDSS).
This minimum interval of 2.5us is being violated if two consecutive SPI
transfers are queued up.

Fixes: a0858f0cd28e ("iio: pressure: mprls0025pa add SPI driver")
Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 use xfer.delay.value as per Marcelo Schmitt's review
v2 -> v3 no change
---
 drivers/iio/pressure/mprls0025pa_spi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index e6bb75de3411..cf17eb2e7208 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -8,6 +8,7 @@
  *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  */
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
@@ -40,17 +41,25 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
 	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
-	struct spi_transfer xfer = { };
+	struct spi_transfer xfers[2] = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
 	buf->tx[0] = cmd;
-	xfer.tx_buf = buf->tx;
-	xfer.rx_buf = data->buffer;
-	xfer.len = pkt_len;
 
-	return spi_sync_transfer(spi, &xfer, 1);
+	/*
+	 * Dummy transfer with no data, just cause a 2.5us+ delay between the CS assert
+	 * and the first clock edge as per the datasheet tHDSS timing requirement.
+	 */
+	xfers[0].delay.value = 2500;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].tx_buf = buf->tx;
+	xfers[1].rx_buf = data->buffer;
+	xfers[1].len = pkt_len;
+
+	return spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static const struct mpr_ops mpr_spi_ops = {

-- 
2.52.0


