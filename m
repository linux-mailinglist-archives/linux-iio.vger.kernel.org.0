Return-Path: <linux-iio+bounces-27754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92ED1DD99
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C99EB3022F1C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D038E5C1;
	Wed, 14 Jan 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="1RSvy+KX"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09338B9B1;
	Wed, 14 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385276; cv=none; b=MIa39HVy6pQ3xH5DQUkOwecOocqZ21XfMrRFAUt95IZe4lPlcYmQpcnHxByTLMVM2mp1BYKd1whctiER1JnvtxPqH133bAihDpVXseUJU+RHo7jVlIGhAuNAiraDTZYQNRCSN3jsJYzlqZ4+iTgfvHlHcc4R2U6kvcpQYJ4Onc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385276; c=relaxed/simple;
	bh=7MdGxwLTxlrcpk2Wj3X/dDItTKbsuApVpweVdA4m2SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ur6YdnfCKJOpxDPjAQlUktIWZm6Vi3jkoqxBQGEcijKpneqPToBIs2DO6Y6hdiEk9EaqJDgtJ2IYFGDyAYveId64/DOj2q3PEJy7rSbtkcr5/IjhB9d5OEMvNstf0eHHo+YSiBp3vcuuW+2fz9OQAIm+uo7h9WZjpDh/UL658FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=1RSvy+KX; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 1142D160215;
	Wed, 14 Jan 2026 12:07:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKSwapDXxY7W4Dns3lBtSSMEHfUUsClJlPvxd+iKp3Y=;
	b=1RSvy+KXAW2iHRKx/i1y/aQKlv+fJNDH/dfyhSqZAWI2SW3Ysl/rLTz6PomwjztgFhfyjC
	42tzytsvIU/lCBd+vA4Urv2h06ZiXv7YdEQQeOlol7C9+4qDkcuKY6HS21gFpNpI/yDXlX
	ca8rQO02Fn2ztj5IT1dg84iwb1Ir2EkALkq3X5gz1SrP8bWcmz3lE0j3SPdJTEOfJ+TlHF
	iP0uEHQzLW7qIC3lkawOdoqgzghjzXKAB7k8f8fjcEiT8DmTntrdoEm9jcc3yCvbNWm0kF
	Npx3sHZMZgxgjE6/7cU4b2VMe/V3ReVAU/uai/fxT5+bSFYWx1MdbwGq3tM37g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:45 +0200
Subject: [PATCH v2 11/13] iio: pressure: mprls0025pa: stricter checks for
 the status byte
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-11-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=7MdGxwLTxlrcpk2Wj3X/dDItTKbsuApVpweVdA4m2SU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXVxcEVxbmc0ZC8yblQ4eXF5Si85QmppCllUQ1MvYVJwT0UvdEJyNjg4
 TjBHTllrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycnF
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTdmZA
 pFQUNPN1ErZmExM3hsc2x2UUcwT243a3p4ejN4RXVTYzZ1dVBqL0JDVXZIcnpCN0tkZ3NaUm5ib
 kdrQVpMY0lHClJRQnRNUVV1cXg1MGYvWFIxU052UWhaUnVLRHdkOTIvM21zY0lpVEJSdDZNajlz
 ckMvNUN6bnBTT25HUUltQlQKS05qZXArSkVETVRnRW5nQ256RzJRQUM0NWJ6TllrSTlidjJ3bis
 vTW15d1pPVDZ0dURWOXZEdWgxZzJvYmhtMApaNi9CYjJSdTl4NjFuU3pLSUdEaG8xb0dMc251eH
 RsZk52QjRwdXpTZFVHM2o3cDJwZi9pMHlXMXBNRVJVTGJtCk1sQU0yNlRZOEJacW5oQzI2QUZjc
 1V0U3lMQ0o2dUNzT0tZM3NGL05CcjJGMUVlck9qVlJuOTQ1L21mUXo0MkgKRWxuRjViU2VueGdz
 OURHUjkrRHpKLzNML0kzZlJSWTI4cGZ0Qk1FREppWkNJU0llN1JCOFdlWG9vRzRsb1JvUApBTHB
 JSnJKZmZJNXJtVGNNYktlcGFib2tSZDFocVJTK1VnK1h4dG8rL0xDcGtLOG9aVGFFQkFhOEFJck
 l2d3F4Cm15cVVTbDlEOGd3VUd4MXVGUFBwQktvU1EyVHRMdEJBS0U1NTZrNkNDbzBENVJhR0pzV
 WVJNWlyUWxkOVVEa1gKRDJ5TUVoaUFDMDRnSndjSUxhY1BKMlViQnNwWWxOaVhSaytIWTlZcTVL
 dDBQSll3VnBpSThiS3FTRE1NRlFBUQp4YTZWeEFWNW9YQTFpQUZVbWNycitwNEJnWUJPUzhQR20
 xTzhrcGtOeStKVWg3K2xDYVNUVUZERUtqV1NtWkdWClJSZytSa3RUd01XS1NpTFJWYldyQTgrMH
 FQZ1EyYjRMUDN1V2NBb0ZhYVpFTkhlMkhnUT0KPVZlZ3YKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure a valid conversion comes with a status byte that only has
the MPR_ST_POWER bit set.
Return -EBUSY if also MPR_ST_BUSY is set or -EIO otherwise.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no change
---
 drivers/iio/pressure/mprls0025pa.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index e4651d3f686d..078d1d719023 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -198,9 +198,10 @@ static void mpr_reset(struct mpr_data *data)
  *
  * Context: The function can sleep and data->lock should be held when calling it
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
@@ -253,10 +254,25 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
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
2.52.0


