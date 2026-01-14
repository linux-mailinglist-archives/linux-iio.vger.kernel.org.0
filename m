Return-Path: <linux-iio+bounces-27744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E9D1DDB6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD08330223EF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DA38B7A3;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="2cH+TASJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62438A9D3;
	Wed, 14 Jan 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385272; cv=none; b=YChfEffec/k3hn59vxBsvxlIZPBpBHqPoA/OpR52SLEXTvG7O4HpgcgrNpESJYqw9I+JVI0W/glpJ3vrhCMOabFXrJJMtq85yj4i7qKtVpH3wd3frO9FINUWmBoHH25Ls2L24JMdtkU4mZfBKdY203csGrE0gRu1hmLrZXweGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385272; c=relaxed/simple;
	bh=7rCaX+CMv5HNdIPee0VsDwpR0x1bUWrRQRcBwyAiUiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5fB0sIn6kuu0aP4fPYWgLgMWPDaIOldtZuRbO9CeODPCufJyke59ldBXhAcy8reuboAld3KFg1K0Uq99NpiN8IFlKMNKtBzB95X6FjY6OQo7+v4MpdliL8BVF4/fhbW1OszI+/2fCCq2/pvE7/lQ1MUU+LCl6keOs0UOntPGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=2cH+TASJ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id D66BB16020A;
	Wed, 14 Jan 2026 12:07:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HoBv256gCYHaQi0ntlLJRTJazk23mjzSprlx97V/Zc=;
	b=2cH+TASJ9wBfedvA81fCCNaJHxZwuEMtiYQ9fxuL0pis2bW9jxdsvfbliwkbbb1fo33y+8
	alLf2tYn0HS5cwRouOxrmlhDZTZ2Ec+H39CgMUXWD5X407OzW3fOvCiQXATQvcgWl/0SZ9
	4yfiKMo5X7LcTbO60xvQLl2Q4ikxT4TLfXY8w42lBAokzicntLzJPyKLnLjearytjvW8FQ
	uiv7mNN7gkiTqyIzojOCZANP/1QavBIwLqWoue49FiZYFOWO/d8IPfV+n+xWc0UAojBvBq
	HJj6TI3+qyVR2o6fUTY5462cabqq590Q933pL62tlgOTvYHI46t5QFBT0NVzyA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:35 +0200
Subject: [PATCH v2 01/13] iio: pressure: mprls0025pa: fix spi_transfer
 struct initialisation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-1-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=7rCaX+CMv5HNdIPee0VsDwpR0x1bUWrRQRcBwyAiUiQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXROcWlUTisxZEJ4dTROYzE0bXI5bVE4CkFiR1JjZlJ3VHRxanFlTTJJ
 UHNwTDRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoyclR
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTVuLw
 pELzlDSnBETmtqNWh3R0YvUkI4Wm42MHcyemJLa09XVUN4ZXpHK25iN01SSWtDVTFHelZkNnpBa
 GgvTFZZaVRSCnQ4YkdpeDNRTVZlUW1wQXhqbFRUekxRd0xGVldVUjNhQUNPdkN0Vm5JU21ab1dr
 SXk1aXhCM2Y4OFhQR3I4RkwKdnk0aVJrYmtwQ2E4dVEvL2xncEhmdDdhZVBRbEpxNjRESjdwRDB
 MQnp1Ym1LdHhtR1FMcU95NzEzR2l2cDdLZgpDYUxOaStTaUNnUVRrbVowSGZ1ZGdqTnk1cDNDNk
 04SndCZy9UTWRGcFdiYlB6VzlBeENtanBJZE05MHpXQzVXCjZaODlsOFlqR0JLKzkxcGZFbFNLN
 WFTeUttVlJLYXhCRTFmbXprQVdleEZlZjBNazRGb00zME0rRDVUbE5KdHoKTnAzWEtvMG1xWWcw
 dGdWWFNiOEd4cEFNMGxRNEVWbUxEcjhHbnRSK2N3NzhzV0hrbjJBQ2pIYndNRWY1N3dMTwpiTS9
 qOFdMT1BMeXNwR1I0Y3lTTFA0WktRS25jOFM5VlF5SkU4Y0Vtd2dnZzFHN1ZqQUtQbit4aS9iYy
 9UcUlyCjJWMEpWaTdVOW12a0QvS2Z4WWdqOURzc2Z2SkFucUtBcms1ZXBaL3o5dHZOT3Fqc2VBd
 WVHckxKV2VhRUhrQ1UKYzJzQ2dFWjJLOGhhY0hYOC9QRUF6bkZpWWcwRGlvU2NKclBBUlR5aFBD
 ZkFsNmZtUDExblc3M3ZUMHk2MG1NbwpVZ3N6eEFseUVLY1luaGtUeWZFOVlDbS9xeHZXcmdlTzJ
 RUExKemhRZ2RlTEFrenVPRmZhTGlrWmpIR2RMYW1OClRpRktzYmo1MjhxZ1RDdGZadTBQbzh1Uk
 tTdVl0a2hnNXlzWmVsSFlYZnJVcXBOVklaWT0KPXEwSHAKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure that the spi_transfer struct is zeroed out before use.

Fixes: a0858f0cd28e ("iio: pressure: mprls0025pa add SPI driver")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no change
---
 drivers/iio/pressure/mprls0025pa_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index d04102f8a4a0..e6bb75de3411 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -40,7 +40,7 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
 	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
-	struct spi_transfer xfer;
+	struct spi_transfer xfer = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;

-- 
2.52.0


