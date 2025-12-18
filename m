Return-Path: <linux-iio+bounces-27167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5BCCB8B3
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D1D304D49D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21813316185;
	Thu, 18 Dec 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="OFc8taho"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C927B34E;
	Thu, 18 Dec 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=J1/2XbFsZ0uW33jIEDNFXULORP/VUe4hzRYJhxHCXVqno2QTbALtPKU77HCob+OkaCcP4LSGv49epv9Y0WuBOZb4RVZ+zGwIflBisv/Y6hjpzw9SX7UB6JVzFNL+F57MCkQYbPgygZWkXH7cL1uBtGPN5bbY/IvDPs0/WsKq1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=YCMxb0/KH0SzecNTUm+wqHVgDSQEi8Mn311iHi5YMNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhS1m0akzxKhp+fGAVMgPJC+mZAMNNxVNZ2QA6Sp5RCKpPXhLigfkgTSjRh86/MUlUgsTRqHYJrFRkALSU2b91a2lyj2y5D0oF0UZNfOcV/Fzk7sEKAyd/BdbKebyIbPe6UUzEcVaMArOZuNZJH5uwZxwg1WNHtOktMnKt1Eru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=OFc8taho; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3D93816020F;
	Thu, 18 Dec 2025 13:06:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RryMvMNFzXI8uVPl6e/Zy+uRfb63j+kGVdrAzDDjVog=;
	b=OFc8tahoVdxdVVWLgY5CdL92wmIobt0mcZq5ySnMOHNKzkNUTbOfjPlFbakfaEAZE9GfUz
	XYwIvgGV/OUrAq5wuDRrIgU4BY7dZWCRB2+U6GvUeL6VTnx2IZOaU26vVNoHCOwC5kLVNX
	1Pp2GkHHcYtaYgs8fjIo/slZ2BqeAujXx80y2N9OKgvGrwM4z17Bjccng2tK9gbDNcIAt0
	5CNdhuW7CVKyVMbew3deRmn0RaboViUhnJh7E502F/POSd0cu6k/mgKKhyZOJPVbpfpnta
	aRDGKQAF2d7OudHAmfwr1cUwGTFNuIvVRqp+jGi5u1xuV6wLm9798rGrYbF7WQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:48 +0200
Subject: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=YCMxb0/KH0SzecNTUm+wqHVgDSQEi8Mn311iHi5YMNE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJWUnlDYzZRZmt2N1JSbkFoWXh4Tkt6CjZVNGQ5OXhEVUF1OTBKd2pM
 aDhOcklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVZ
 BQW9KRUhRcko2ZGpPa2xqOVJRUUFJOTJvcWpaTUZpbzBSSWpyNXVIMGZ4bUJ4NEo1d3ZJclJjUA
 pZaitJT09NaGpvY2RNOXptV0h6UW5VQlY3YXRYc1JUMXRuSERyQ3hqQ09SQ3ExM2RVTE9STm01M
 VZtajdLZFUxCitseTFmYXEvNGt1b1p6WXppYSs0alVmZ01ieHhYUHVFN3UzdThtaEFuUzR1cXZz
 Mmw4M2ErMitTMWVOM2pSUWkKaUkrTmcvcTZFbTZwWmN3V09vRlBhLzh2aWUvN0hXaWt4SG9vZ0Z
 maXoxUExaOFZwTUJhWWl6dkFtNXJ3N2hmUApkcmdNTVB2b3FKSGNoMlZPdGFnYnBHVjJVc3ptbj
 kxdG9sRWFVUHhnZUdqcnhpSHU2aTJ5UG9ZU1VQNUhWYzZ4CjFEd25RS3VqQTdlaTVwcXdYcytFQ
 TdVUldGT0wxcFRuK2tYdnp3QXdDYmxzcm1LclRzRGhSTkpjdEVrQXNzSGkKUExkeU42cWMraURQ
 OENxZERPNjBDNzFJMzNQTGdSYlV0RnNPcDZJUVpPcDFzSTErT3I0L3VHc082UVJaYzVGRgpSbVJ
 XQWNyK3dVK3VlN1ZEcFNwMmdzV1NvOWZSODNkc21jWGpRUkNSblV6VkJST0pvNW9tVUMrS3c4ZE
 xKdEkvCitLYXFTU1poRlIvKy9kdStIZGxpNEptaEpjMlQySno2dmlmOXEyaTBmUWpHdFU3REZoS
 kRJYmZWL2pYU0FLSlgKUDBGRnZFZmZVVXdVYzA4bURqbysyWGRrZnpKSUtJYWlGQmxLU092d0Zy
 RnpJY0lTOFEyNVlqSG5EcmJFaVM4bQora3ZvQmNaR2tCUGkyWVljNDdHQXNlQzdQQnBpamlCMUN
 kMmNkUFhzcXU4TCtmZmt6N2pxTnppTWZVTWxtdG1mCnVUT2JVK1ptSkc4cDR3PT0KPXBOMXAKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Zero out input buffer before reading the new conversion.
Perform this operation in core instead of in the bus specific code.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c     | 2 ++
 drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 00b1ff1e50a8..7cc8dd0d8476 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/string.h>
 #include <linux/units.h>
 
 #include <linux/gpio/consumer.h>
@@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 		}
 	}
 
+	memset(data->rx_buf, 0, sizeof(data->rx_buf));
 	ret = data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index a0bbc6af9283..0fe8cfe0d7e7 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 	if (cnt > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
-	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
 	ret = i2c_master_recv(client, data->rx_buf, cnt);
 	if (ret < 0)
 		return ret;

-- 
2.51.2


