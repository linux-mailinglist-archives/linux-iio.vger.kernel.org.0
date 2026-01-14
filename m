Return-Path: <linux-iio+bounces-27794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31DD20608
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 162C5305B58E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07183A6406;
	Wed, 14 Jan 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="dCEhCQ2U"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35F2D7801;
	Wed, 14 Jan 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409789; cv=none; b=J67ILQX35k5Nm2Msa8ismDC0Mx2JfyNqLZlnodQiiymHskMktiRb5uAf9ZW4nKR7eb1uZYVghr6tQWtsBWU6fqn2u+1kENs0F0/vNcFzYZWHCax/1aSjJtakiOFsy7q9cq3UBQjecPzsZ8QHJ1G2cYQzgXMXQXW8zSoDTj5OsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409789; c=relaxed/simple;
	bh=bEiD1Dw2A1KHBda3pVCiWnVm/tWIBqISeBNHTxPdkx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S40xO9LkspaLoxoDjZ8a4QyAqGbb28ddmK8deJLWgXu3Oyk+dtYd+cXuWEFhTYRm+Ex4s8AW26c7/BQI+enmY27YjGwRH2dlCGyD8VgeogiH/ne2GDwE1ZMQ52kkTmhp8GY35UsJZDSV27rVmsljZ/eeq5ag+lHRK6Hmv3hRZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=dCEhCQ2U; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 0A98316020D;
	Wed, 14 Jan 2026 18:56:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYqHsSPmZafVHyTkhxK98FY61IO+PtV2Qb40drKMq9E=;
	b=dCEhCQ2UPKzmWs/RISvyiqu6LZC5VsKeyuJqqLbS25Jb2UxNNOzAdQEauEZXein91epjlP
	dvJC8W7v02c0q2kMVIFH95UPbFzg5EHSmi0iIENcdS8YvvqdJ3sTTGaZk8d3MIk3Ja0O4x
	npUVqPph6NeE5jomhzDFv62AAeGIH9OaD6CMcz3Ddqa8oLRLVUoHj5bs8jqBg+BTavgxZ1
	fQzO26SdDPMV6VMXjSa0IerDNgxpIU3P57PRIZd6IvJPPwtLu62OX3FBdpgpIaIpYZUQj2
	hdQgnfkxKSBl8mlg/rFAHuMthlGbLpnWurbxG24xH0tt7wZ8+lTsHgJP6+OCJQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:32 +0200
Subject: [PATCH v3 03/13] iio: pressure: mprls0025pa: fix interrupt flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-3-bc7f1c2957c2@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=bEiD1Dw2A1KHBda3pVCiWnVm/tWIBqISeBNHTxPdkx0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXBzOFQyYzRkMmd6bkR2Znl2YWhDWEU0CngyVW5WZm1aSmpsL2E0dHZ1
 Uk1kTG9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cWJ
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTNXZw
 pELzR4a3hMZ25rZXB5ak5CaUtjZmd1ckw1eWVHRjJuWkFwUjB2dUZpVnpoU3ZaSkVPWVhCVGt6c
 DU3d0EyZXQ5CmQ0SUZ6YmFHM3ZSVzVPbHZBck5uTzk3VCtNdHFEb2NFSXlxVXNKcGxGMCsvRXJs
 ZStKUTRyK3djNmRnUWVCQnIKZlZTWk9PdEE0aTZxMlVRdXpyVDBxOHFqTlVKSldhVDExaEZ6dTB
 RdjE4VlFNUTQ3SmNQN05CU3hWMkd5ZHN6Ywp0YjRxZlhWcm1YTG4vdHNUNXdETjIzbEh0SXBFVG
 lnL1R5c002ZTFCbWxwNG1iVFYxSGlrM2thZ2NDSmhVK05WCks4YVd3U0NjL3huZVAycjFPclFDK
 2YrTEFJWVhtLzBYM1RiWVh0QWpqVER3bUNHUDdzczE2T3orU1UwK2RnaDkKSkJ3b3VTR3JXcllU
 d0dERTdJNVFacFhRRXFZQkdXNysxbVBsVnFIMFNDa1J3UGdZVWRhZllhaEpLSXRBUFVuZAo2SEk
 rV1NtWC9EZjBnQitQT1JJY1pDdWtpWFBBTUlVb2hPeGsxdktTR25vanpTbjJ2OFNDUFdmOUJWdF
 lJYWk5ClQ0aVp4a1lvVWYvSnp2Sjl2VXVBbmRjU29BR1dYZ2Q3akoxMHlBSHFiRnN3Z2hydlFKY
 mNPNnNILzhuSTBhSFcKazdWQ0Vrdm5pYzRtZ3lIK3NXNUhCWEw4dUFMMmdQZnZGUlZnOXVTTE5v
 cnM3WlpnWFhRb2I5NnhlWFprNTBtWApmSXU5RFpBZlViWFBSTXdtd2NVOGt2V1Z3R2FKdW8zckp
 aT2VyTVJjUDBLQW1wZit2L01yZitUOUR1dk5EQU5WCjZDYXFjTmxOS3drbXFmL1plZDN5RTErRS
 tjcEpiSTBtcExkTmhIUWhOaFZMU1dDVExhYz0KPVhjQXQKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Interrupt falling/rising flags should only be defined in the device tree.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 use IRQF_TRIGGER_NONE as Jonathan requested
v2 -> v3 use 0 instead of IRQF_TRIGGER_NONE as per Andy's request
---
 drivers/iio/pressure/mprls0025pa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2336f2760eae..4b23f87a822b 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -418,10 +418,8 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	data->offset = div_s64_rem(offset, NANO, &data->offset2);
 
 	if (data->irq > 0) {
-		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				       IRQF_TRIGGER_RISING,
-				       dev_name(dev),
-				       data);
+		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler, 0,
+				       dev_name(dev), data);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					  "request irq %d failed\n", data->irq);

-- 
2.52.0


