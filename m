Return-Path: <linux-iio+bounces-27747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C7D1DDF7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 933E93075D0A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65538B7CC;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="BR58bJ0o"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51038A727;
	Wed, 14 Jan 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385272; cv=none; b=m8c1zOVJlD703zAO6W4ldXSPA0a1WFJBdyyqi/G4XRWEX8FriRkwa+tamIkL2PnTztdahfDhwT4XZmFF/MTJgRi0iiKJKabiA+6fXOau9Nusj+8tolwG5w8WRjAHeRcLpxS5QohEVyhQXWI4q0EDuZe9CzEuaH9VKqmJ4agIx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385272; c=relaxed/simple;
	bh=JZsCYvArYiw2BVJX7iMWL2ZaOKYdTaYkGif2qRc37fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDLRZzHlz8qQrHn2Pq9+eKOLqGvF7/3rOktxn1VvUBL3NZQ8E2X9tODoUOvB2/+N8HHFjx8Gq2uNl3vlTFd1LTdnJmLfuTdpjInkt7p9alIXyqRNgaM14AsBpaDW6rrmakuMJkJzPu6LCK2P/VzsIEv+lmAgqU70+dUsvHw9k2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=BR58bJ0o; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 532FB16020B;
	Wed, 14 Jan 2026 12:07:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvD+Mz/V+BUQ9wfDWzvPQ+wQyq4iAUHqGEljuaj6y1Y=;
	b=BR58bJ0o5LpJ3PpAoSp7fFNfFfsXPgzfW1amKVjaSySDiOyH9MgxTPzDKsIX6w0P2IY0cn
	VhEKJ89x8MznUimpvL4xpfrbtyi3uoxTPg5c6VW70cDPBWJ5yc+Gvbs0MQSxihxVbL0MDo
	ZLPi2ApTLZD9wzGtdT5aDY8iFTlWdkjYQHFhrHgtr2Ypc9EXpu5x+mEUvAq+/YGy8L3nZY
	huJ5bk1si3E+jDKJAgls2tRJfSCaddhJAF8FzTS2Q7s5qHNt0OKasK7pttWkm1VUp4G4pc
	zVZCs+a8vdnNUehprtfPF3mgcppW6Am0C2OwkSuuNJOQKxs5X+WgKercdJ3nQA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:36 +0200
Subject: [PATCH v2 02/13] iio: pressure: mprls0025pa: fix SPI CS delay
 violation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-2-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=JZsCYvArYiw2BVJX7iMWL2ZaOKYdTaYkGif2qRc37fc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXRVRjBxcGlIdVJNK0dPQjd1QVhteDZxCitpZWh4WHhOWk9PZGg0MHZR
 YnB3SllrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoyclZ
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWS9ZNg
 pELzlFMTkra0V5Z2lBdzg3R25mNU9YVC9aNXJmRjF2T0pYdW5odzQvY3lLVG1QbWZSZFRyTEdZe
 E1IeDdBUXd0CllUNy9nQmRnNzhoRE5HVjZHZWpUdHZ0Z1J3dDloT1EwNTh6TG5Wd3hscEYvUERa
 ZFJLdmdGS25oc1k4QVdIb1cKdnFUTmR1UitEbXRKWmtILzBDMmhsL205WjdJMlhOaWtUNllObXh
 0YlcwcGRnclpmdmhRTTVJaVNpcGFReWF3RAo1Q2FvUVN4OHFjN25VdkRLNGs3OG5yaThDNnNydn
 oxa3creTRoZGZNZnlac1g0MTVVT2tWd3hNK2VEaFJZYXhLClUvenk0dGc3eEo3Ky9lWGdNbnRkT
 kQ4UDQvOFJ0K3RwTU5nOEd6WWJTQVRUdkNMa0lxbWhrSFZwY21UYVl5aWEKUytDeWE0cDRzaDZK
 Y0Vib1RiMS9kMVlPRlBJakFXbEtRTjFQdmMyQVk3TWNJbUZEeE4xWGM3a3IxazV1WVQvSQpDaXo
 wWUlONThxKy9DVERyQm9hNVArSUxqMkw0eFlqMGwrYXh6S0RVYWJSREZpUTB6eXVuRGVoTlF2U2
 V1cGxxClE2T2JpV2NKTk1yR0ZZRGx4WFlSN1lRZWVPZHlxQmw0dXFMSnFHcW04VHMzZkFId1RtZ
 FlDUU5GbUpzcHdrdGkKZjBJZE5LMU5jNkRrRHJoeXVCcDhiT1RQV01wVWpzcW1HSVBDUjdUcjl6
 aDFSRncrRVk2bnExbXRud3N2ek1SNgpGWjZZczkvL3gzRlN3ZUJwcU9PQm1paEhGa2pzZzR4VHh
 WWGsxSzhtR3lZcUU0WFNoU2h3TnNMUW5heGRrU0x6CklrRElUdTVVVjl3SmFsRHFOeGNLRi9UaF
 ZWcC9QU00zTGhGNVhaMjVJeGQva1Vrd0pUUT0KPVVIOGcKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
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


