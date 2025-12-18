Return-Path: <linux-iio+bounces-27165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74ECCB8AD
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95417302E164
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB0315D42;
	Thu, 18 Dec 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="y6q9O9u7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2D30CDB0;
	Thu, 18 Dec 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=OMKIkvmoae6DmW3tN7o93lKK9dmpYqSJdmM62xJzL4j3vl7RNiEQF8arBX59JRsL95i7fuIcHYHZfmc5gPOji9PV0o7+RcOPqFARJebRDb0MhTN9L8/Y0AAm8i8+P4YFCRNlySANsc1NVTlMPpKUnMRjKfZXjyhROmBUchfJb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=u5IPrFscRXthy8l7601VVgnJrNDzYLylzHB94d7fGm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exNCzYC3FF1fhx+10c/nYzW8cCXbmxnep2a19klKvnqqiOonZzrrWm2a/Hypx+lkSaSF4noQ0ypWdPgxM/tV+qbMJ49FZfNCqQ5JqG6jvXeXQ+ddQYss+AQIPApameFwpAcxyXTaHh2nGQRYrxXvqfpVanY0xhNEdCgOuo6eeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=y6q9O9u7; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 28566160211;
	Thu, 18 Dec 2025 13:06:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns8Jixq24EilpK8SnZ5Vu6qrCnipfGw2ulbcsyqUak8=;
	b=y6q9O9u7R9TtOC+02pkMvC7KoGTo9Ka0By+bycru7GOba/x+KM0RJTyiGOZjVTWrytkoLs
	fK/Z4cWJmaSwDLwHxXhK2oj8uBsdJDJtTaBTzjAAqlGQn8waww+EiY48vNUTy4sGV0o8jW
	tPEHAvmenSWiHSE89YZFnIwNdmK8Z8hFCNW0JTrcm8a94EOnRvKvNayQVTQNZwxIpxR49o
	5OfqcWRV7CmcDjoZb6bLvqmJPv/fhSHZQQCOxjub1dSU6ipGcQsIuH9AW2mTtXw9YA5OlU
	qqL29lHxtDsGkF9wl9lF49DE0iZHL7PNkMQ7atNfDt8kaVsSvJKA6kODkVX9Hg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:50 +0200
Subject: [PATCH 08/14] iio: pressure: mprls0025pa: stricter checks for the
 status byte
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-8-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=u5IPrFscRXthy8l7601VVgnJrNDzYLylzHB94d7fGm0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJrditrdW1RYXpXV0trc1BCZk81Wk1kCk15TlRZY3JNRmd1cUswRnd1
 bWh4a0lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVp
 BQW9KRUhRcko2ZGpPa2xqSTc4UC8xTHUxY0g4YzdUZUNDVGJXejMzVVFGamtCTldMM215UGErTg
 pXT2FQWHN3RmlPM3RLR1NFb0RJQTVjVkR1S0JKWXFYMmNwcGFwSHdabm9oeGcyN1BqaEVMYUNHM
 HRXVjIxVGhmCkZpWVpKTmdGKzlvMEEzRENwYnh3ZTJyL05PTnVyMTBOY3lVdUNSM1lHNjlHZWVz
 ZGxnajB1NTFJME1iZG13TFcKakRjY0hGZDZDQzJLTmI3blRUbVNVTmI0NjZxV083am5FeTRIblB
 ZbXlmckNobTVZck5sVXBFdlphMlFHVjVseAppVERxZVRRK2ZwRXNUK3dIYkVNWHRjOEpLd3UxUG
 Q5d3hRbmpOdW5XcE5mbEd2V1VtTjBGbzJvTENVczRNY29aCjArQTR0ZzJhV29kVnRZM2Q2Rk9BQ
 25iMXZPUVV5VnhicExocm81bzFqdVBGSmd4azYydEs2S3BvaU5ncXpOWFcKMnhiRjloR2x1emQ2
 ZlFFQ3kxQ1V1cjJFeHNQbC8wRGx2dytGaGtQTVRJSEt3K3RIeHFxWU5DRzNZY1htOGlyMgpGSUY
 1ZkZ1L2NMM2pJWkNpWjQwL2FiWHZTZXNlU1EwdGVLL3MrSEhyOWN4OHM2ZG5XRXV2dVNRdGVZSz
 U1U1VJCmJsbnhnbjVQdWxLUmJmRkp0cDFtWVh1akJCcDJwWTZzb0NZZTF0Vk9ra3JjdU5aOTc5Q
 3pYSldIK2ozU2NkSm0KM2NiUnBhUDAzYnpuaHRYdk43OVBaZDVxdmkzUStqVFBZVk9LanJPdE1h
 NStSYlFRczEyWTYwK0lyeXZLTzhrVwpmTkhJMzYvSGJrOHlTZUlFdVBvN2t4MTFETVZsdnc3STA
 5OFZKVFNwSzA5dHJGRmVxQ08rNGZKRlBYTSthQnlFCko3bmxiWUo0VWMwcHl3PT0KPUVXdzYKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure a valid conversion comes with a status byte that only has
the MPR_ST_POWER bit set.
Return -EBUSY if also MPR_ST_BUSY is set or -EIO otherwise.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 7f8dc47d7073..973d205da3e9 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,6 +12,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -195,9 +196,10 @@ static void mpr_reset(struct mpr_data *data)
  * waits for a maximum of one second for the interrupt.
  *
  * Return:
- * * 0		- OK, the pressure value could be read
- * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
- *		  still set after nloops attempts of reading
+ * * 0          - OK, the pressure value could be read
+ * * -EBUSY     - Sensor does not have a new conversion ready
+ * * -ETIMEDOUT - Timeout while waiting for the EOC interrupt
+ * * -EIO       - Invalid status byte received from sensor
  */
 static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 {
@@ -250,10 +252,25 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 	if (ret < 0)
 		return ret;
 
-	if (data->rx_buf[0] & MPR_ST_ERR_FLAG) {
+	/*
+	 * Status byte flags
+	 *  bit7 SANITY_CHK   - must always be 0
+	 *  bit6 MPR_ST_POWER - 1 if device is powered
+	 *  bit5 MPR_ST_BUSY  - 1 if device has no new conversion ready
+	 *  bit4 SANITY_CHK   - must always be 0
+	 *  bit3 SANITY_CHK   - must always be 0
+	 *  bit2 MEMORY_ERR   - 1 if integrity test has failed
+	 *  bit1 SANITY_CHK   - must always be 0
+	 *  bit0 MATH_ERR     - 1 during internal math saturation error
+	 */
+
+	if (data->rx_buf[0] == (MPR_ST_POWER | MPR_ST_BUSY))
+		return -EBUSY;
+
+	if (data->rx_buf[0] != MPR_ST_POWER) {
 		dev_err(data->dev,
-			"unexpected status byte %02x\n", data->rx_buf[0]);
-		return -ETIMEDOUT;
+			"unexpected status byte 0x%02x\n", data->rx_buf[0]);
+		return -EIO;
 	}
 
 	*press = get_unaligned_be24(&data->rx_buf[1]);

-- 
2.51.2


