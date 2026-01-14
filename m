Return-Path: <linux-iio+bounces-27800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CCD20645
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCE330C9CC2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5D3A7858;
	Wed, 14 Jan 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="lhg+t88u"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0025F7A5;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409797; cv=none; b=GefOqG/5ch/VJGiIWK6OmQbGwMHg/DhvQqoLTFbjvrzsHr2+3ZWiXCeyfXlcfwGWkaey16UmJBptaqHqJolZ+r3YVPdZ2WDU2uZJUy1KmndZNCKvvyFWQdXbT79Aebj5HyxLuiDJgP1NMmK+pyHRAMsWM1yaQmtKvC00uMJzegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409797; c=relaxed/simple;
	bh=TcT3n2N94vRxT0NbCS+kF9wlgDV9Rt62znP8KSQmP8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgsxDhFqhRWV/MnRKRpyONP35fPj2DmwkTpZDMwEmPIffXnRkkyVNYLxLoPJbH9k+WYGXeq8RTBeOlouP/rrU03Py/nFjNTblmhR+IuJ3pEsiEERgIwvicACM8P0r40Ss2OeF1Cp2ghjISz/WmMlv68rL9TewVWjEfSKNBI9JG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=lhg+t88u; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 35910160215;
	Wed, 14 Jan 2026 18:56:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNZAu5OegEwfS1E1MNsRcHnMoSZfZSaoZ88VX9f7JwY=;
	b=lhg+t88uMPAwo9cJ2tH+AtPp3o3iRqb12sRnIGWY+jXSMhOVIiA9OqcAs1S32vvJ6mo/hL
	v3XHjeRNlzIMJKV6xrnXK7tqhkq8WNZqAnmsNv++RaIVFkUerY3BU24lDtd+XzwMJjNmQp
	disZc6/Gkoi2dfHBX56KdMnO8HVxEB3iHoFrV+Wpym4iAcvEtYSvXdaIjzyO1Ihf4oe6MW
	sCJmrOIeq8Z17Kk7ML/2e+PsnIF2vGjAtnRFb7j8Z9CEkqwMB0FJ7cTshumZW0YEO+2vQq
	vFmbPpOmJ66p4FrCAlt3poIFZ2n5ITHlI40b+95LH75BTi2b17laAbQXzyyiTg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:40 +0200
Subject: [PATCH v3 11/13] iio: pressure: mprls0025pa: stricter checks for
 the status byte
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-11-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=TcT3n2N94vRxT0NbCS+kF9wlgDV9Rt62znP8KSQmP8k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXE0WWRwSGhHQmJhdzMwYVg3L2gyaHQvCjl6bFVYT0EvTFkxajFxZmto
 dVNuMFlrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cXV
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTgxVg
 pELzl3ZzJvOTQ2K1ZHbndITWh6bS82cE9acDV6cS85ZklOeThtYmY3bitoYjNuWnFKUy9SMm9xb
 Gx6WWg5RHpuCnRQN1ZxbFRmRUlMalZ3d2VtV3B4T3JyRGRSdzZKZXpkb0M3OGtHQ3VXVjFoUzRr
 SWhQMzUxbVVjUk1vTGNkbncKNklRc3pZMzdlaEZHcHB6dDZvMVU4MWdRbmJUS2hnL0xhS1RGbXh
 kdlFXU0Vhb1M2NmdvakxCMXBEcmorcFpnWApMZUd4RE5HcTRQZklVTDZ5TVE1NGM3NDBXZ0t6WF
 FKQy9qWFJWa1hLdDhiaGIrR292MUJNU0ZBcWcwWVF1YlpqClZub3VGTU8vcVc1QmFqeGNaeVlXc
 085WUZGT3dFQS9Qb0JDenNMVWVVT3Bsd3lHQXAvUGxVZkNXaldtOHo3QWYKb01JZzBBcUxyT0JT
 LzhuOVpwa0syU2lBTkR0eXNrRnBhbWdBMEJRcFN4Z0JZUWNFVDZlMGczbmpGZTJmOGJHawo0c0R
 TSmI5MHhCMENlYW5jS3VNOTBEbVRXdHJsYXdZcVE3ZUw5Wm0yT0c0VTVoWmtTRStlRXk5Ty90OU
 llaFRhCkR3QUlFOTJRTzFEZlFTczdSSEpyWGxyTHAzRHpCcktaMTlBOWRGWWpuZll0YjFuUjEzR
 k9aTC9iTkZVNE5IN1YKODlUY1doTHVkaCtoUGc0N1pTZlFvMUExczVZOUpUN043L2o2QWZJUDFm
 UnNybUhOTDkxdEE3WEsraFUxdUdHVQpBZiszRFFacTdOUDVCOGhobGtjWHErK1lEZ1A5T3VSbzF
 wVUp3Tmt6a3EzM0RkalJLbHVYWnlONXpnS0ViRkkxCkE0VkFUbFBwS01vODd0RHZLRnQydDd4MV
 oybnVmMDVyZHUrVWlYdlpmZWxEQklzdEswaz0KPTU0MEsKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure a valid conversion comes with a status byte that only has
the MPR_ST_POWER bit set.
Return -EBUSY if also MPR_ST_BUSY is set or -EIO otherwise.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no changes
---
 drivers/iio/pressure/mprls0025pa.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index a7041a503bde..31ec2bae84b1 100644
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


