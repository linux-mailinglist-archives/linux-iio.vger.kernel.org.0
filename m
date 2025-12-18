Return-Path: <linux-iio+bounces-27169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD95CCB8BF
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B512D30A4751
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57169315D58;
	Thu, 18 Dec 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="G7O8DHya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD1314B9A;
	Thu, 18 Dec 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055990; cv=none; b=RJscZ0r7oN8oR8/rtJjAtjJQXNEWHQqjJw18S5qbOxdnoI236xHet8tuBtTqydWRIxgOfZoIGuQeUq4kl4PgSFWJPowvGuDvOa2k7P/ZBQpgnxvB/tjxMoBkVZd0gjL1wnvcd9aI9z+T/V22gO1e0ISGshnjbw4P9WmaTkzu4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055990; c=relaxed/simple;
	bh=GCkK0VAT6YURJVUHsAV2cRDK2Ylk9MKA9vKPrxg8PHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alNWArFY+vHMrcCNIZAXGUMxNWI14DRP7joFHU4BIKZR2qNHWLvDR88136lc/Cf4iSlBfOFTIs0NJ3ZreOxL6FKseZbsPbgG4UiedomAJtEtzVhf4AUrKHnd5q406HQhSK7tDHSrzQikDE0yzMve01R4vg/W3DfTiSR/KYkz7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=G7O8DHya; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3F7DA160217;
	Thu, 18 Dec 2025 13:06:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5I6rVkaUyMlNAVNjMbpzYJ5yxuGb41VpMPmiTDGi4EA=;
	b=G7O8DHya0Dv/v84ctsxX2qzV6HaI6ozrtHo5i1y2/xSoRuUmkd2De5q8omGAP1MgN58hpm
	eZJ4O4Kf5OPz6xPkkSXhUJdjELfHaHh2G9s3KW3oWzLAMBYByHDdb+U6qPipj6vY+gsGWf
	54d8cv0cKA+VK/qlDoJ+y3ZJHknC3s7viVnrgVR7o23CeHUcJdZuBnZIg5dpEC9yeiRuJT
	7zaMq6po0gNAyHVuR07vdcAQVO+dCslEvT5sox7qJc2GNRRdIzSGY+YewUWXjwnFo50tS1
	Xo3M3vGtNWWO4NH+iE58kSkU56aBCnY31ywi60/qZ9TemYPHed7S3xq5O+uybg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:56 +0200
Subject: [PATCH 14/14] iio: pressure: mprls0025pa: add copyright line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-14-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=884;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=GCkK0VAT6YURJVUHsAV2cRDK2Ylk9MKA9vKPrxg8PHA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENENWM2NKb2Vzak42NlVvTWoxbWRaZ2tUCmJ5eDNJNjFHZWp2TDZaWDFz
 SDJ3RG9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWx
 BQW9KRUhRcko2ZGpPa2xqN0xBUC9qSlRyZzQram5qR2Q3UlRLZ2YzLyt4cStTeVp3aG1PSDJDbg
 ppOW5qa1JHYStsVzVmMmRnOERwV3FBQnBaS0greVNQSGpPQVlscTVsYzlTY3IzT1dYNGQrb0Ire
 lp4TmVGdVF2CjI4RmRxVkJRZ3NseS91OTJLNy9QMWVsajU1anZ4Q2UxWm93cDlka1VrOGVkS3ZT
 ekhkVmdxSGN1NlQ0cGM4UjcKam5nOVIxWkpISiszMzNibjJtelc3d29JVDM5OVdLb0NiUXlxRkV
 TenFJT1B4cmo3WU1LWFF3OUNPeUVoNFpVTwpmZVNPUmxrYXVFM1ZXK3B1RXB6SXdRK2ZZRHMwZm
 loaDRUbDIrUnJzMHRWdVZwY1MxbDVaOXc1cjF0SVlCVXVtCjJpZWhWNFRwdm9PNDFwU3JaaGQ0T
 0JmT3A4b0tzNm04VDlienRxcUpHZFBwQzk2akU4YmZYNnRDRVptazI3ZXoKWUZBVGI0YUhaUENY
 OXRTQ3ZRV0ZHMXRCQ01qRTMzY3plaWtyRlc0UXI0ZnBuQ2JWZDdKTDZiTVg5dXd3K0xVdwpxNGl
 SQ3dHNHNNemEvd1Jma0ZmL0tHaDQxQThUb3RKRElqWjc0MmFQNVh3QmN1d2RKdXRFU3FHbGRvem
 FmYUZXCk5ya29ETk1HN242c25BRmhmdGJuUFBHVGxhV1FKT2poa0h5VUd6a2YxWDZHVFZqZTR1N
 EczTUU5cUJwRWZmK2EKbDVQN2JTeUpVNWhQd0owKzRQQWE4VGxSRW1hZEdyNjF3NHU2M0ZtZ2VX
 UWtTSlRuaTRoSUI3MExaeGJnUVJZcAoxZlZhakpEcm9MdmhBMzRRVDRNSjRlZnZsYWh6SFZScU0
 2WkpBYXg4OW9YbjZCbXpIQkdtU3RaekY5blFBQk9NCldNU2tMRE40Vk5rblhRPT0KPWMyT0IKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add copyright line to the core driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 71728f9fc498..d71b36fcc982 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -3,6 +3,7 @@
  * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
  *
  * Copyright (c) Andreas Klinger <ak@it-klinger.de>
+ * Copyright (c) 2023-2025 Petre Rodan <petre.rodan@subdimension.ro>
  *
  * Data sheet:
  *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf

-- 
2.51.2


