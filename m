Return-Path: <linux-iio+bounces-27755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE0D1DE37
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D88123047FF2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0038E5DE;
	Wed, 14 Jan 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="mAil5V4W"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159638B9B2;
	Wed, 14 Jan 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385276; cv=none; b=qMXoR0j4YvY/s3ElNWvXIqo7UK4mATEwq/F30cYzSozBGZBE6X8+PtjuSH3ygHTteo2ekMzuHCBdS1CsP8Qh5bs2awfBG+PGtyIj0GqZPQB7UsntG53MaUt9rICzTYRff2+/xVIrOF6ocqGnS4iz6R2m4715QjtlTtcOZu60s1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385276; c=relaxed/simple;
	bh=u8nJdjLQUjSOqf5UERLRYhKgjyBHVISmP1XXJDWr4TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEvDnWOv2ySpYHnhm75C4mTESFz2zatE6P/uLdrrvmj3PHMSk3bPkAd0c5AbJAwKOqM4zLGzBbAGNQkwZ/+mtQL47skNC/I/oenD/CFB4WRWx6l4wt9WJQXFnPAmGX754QcDWjU/3Gp1I4p4x14emG4G/7AdMyA7DZDTwOY1mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=mAil5V4W; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id D70CC160217;
	Wed, 14 Jan 2026 12:07:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P0EmzE+tJqaBdRgoKLXjuTwM+IXH2WiY1ySV5bS6Dw=;
	b=mAil5V4W0ICOX3cP+HZ1higUC+gYvrbLbTzfY3LUSZnonsPtVzT/WAghEqUw8NwOyXBuSu
	UL2k15V7WHdGG0xU2BDJd9UYzPyS3rAz9z7VI8V3a6L3zsGmY40d1u21ysNbIX4sx+e1Yz
	PKrvaFRAYwwjcG735WxH3bOkh5hVKLa3eF/WogBBqbaq3Ymv4Pp1p3OyQ5sk0sw9LcKYwR
	P37KK7Ksj7YyDmqvy2gTtZieUnUWqnP6WyOkUXUCoya4hOlXqo7KiCMaji8jL+Y+Gl6l/Q
	/oghho6zX8e1My2cz9S0SYSTbvsqzJ93RQ1UTQSAKIzIIYIR9jXGaOu5dvBvig==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:47 +0200
Subject: [PATCH v2 13/13] iio: pressure: mprls0025pa: add copyright line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-13-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=u8nJdjLQUjSOqf5UERLRYhKgjyBHVISmP1XXJDWr4TI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXU3ZzNkMjg3RkFSVlp4N3czTnFjUU1pCk1PSVlhb29XV2lvWnFjSTVX
 NTZ3VTRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycnV
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTZiVg
 pEL3NGTkVOUHpObWxvdnBqaDEycy81a1lWazdPZDU3a2h0NURjTmhBYmFRNytXOW1PblhtNithZ
 0djWUQzcmR5CmpZMC9LMjRYbmlQN3NuV3ppbEludllobDlkcWZ6TVZlNWZUQUtuem93VmFVSTlE
 SWJ0OEQ0KzFQZXl5emZIU04KdXpyWDAxT0Q3ZlNaYW9oR3dyU0gxbGo4ZmlhRm51TDZSeXJDSkt
 FM2JrUi9Od0c1Q1dHSDlqZyt4a0ZQZWRRSAozTy9vaUowdS9nMlpWOUZZRndIQVdzOUtlWURlZG
 JVQVo4V2EvZS9EQ2pFQjlNOXBZNWxKazUwSStqL29XNWY0CnRDM0VIeHBXaU0vS2QzbnFLSGZFV
 HpKbEQ5LzhVc2pYVG1UdlBHaVBHY0hwQzg2dUE2d1dTVjMvbDc0TzdjWmoKOWg4SXpuTEw2azFa
 M1ZNSktMYUFIeTMxODdOZDBjaWFPTENJR3pENlI2aU8vQlBkN01iR2tXM3dhQUZYYjhCagpnb0x
 YcCtHckc3S0ltNDEvSFBCbWZKYVNkMnNEMDN0cEtsdWxGMTFndGxhcEk0V0NQdC9UVkpSMy8wRH
 JTY1lVCkRjMEVWYS9NK1ZMVzBzTUN6UXBPRTh0cVdlbG1kTW0rUDhhZHhvRGtvaStBQlZpQXJQd
 GdtOEJ5WHdjaDNGRXIKM3A0NVZIS3ZGSWZRMDBQR3VESUkrL3A2ZEo2bjlyWTZCUVUrcDN0dUFt
 aHlMcHZUZ29nNVUvOFljTTl4R0lCQwppTVA1dnMxRjBEYzA2TEN4U3J4djFjSG5XejVHVkZXa2o
 zdFZoUGZlZzZlUFdkTHdDNkZFQWREd1ZBNWVia212CmJpT1JuK0wwMnNkV25wZWRDNVFEZFg2Z2
 5nS2JFTmphVzlsRStYRmhNY20zRkxWc05Tdz0KPXpNWm4KLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add copyright line to the core driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no change
---
 drivers/iio/pressure/mprls0025pa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 8218d931647b..0122108f1f3e 100644
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
2.52.0


