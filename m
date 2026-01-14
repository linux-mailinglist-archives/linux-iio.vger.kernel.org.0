Return-Path: <linux-iio+bounces-27795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B064D205DF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 870013003FF4
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CA3A6404;
	Wed, 14 Jan 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="yWPu/4Os"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4E3A6418;
	Wed, 14 Jan 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409789; cv=none; b=OoiVLZYQ3JLxlFOopvl8zAH0Xp55nvoWPuKqdWUbiS7yLMj68d5P4YCMn7iGIh3IzMWXcItebxRQVbXKNgSj/9N+xWgGuuRWurRFgxG+WMBRtBCvBR8zB70Ub31eSlIM5ZTEN2O1lto3EioEEKLpsqErqsul2JAqMyVeWdp2Nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409789; c=relaxed/simple;
	bh=IrBBqYGtnCb6p5tEeOkCTs4ptATchd6cwrxwKsj7nuY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=twt6BEomhUD93IZUZ0U2uXNY+hHdNWuLwl6wSmQCgc9Iyk6WcwEAzH08SWgpDPKCZM+vsrrh4/VxXsr4Ahhs4Eggo9r+hIStRLA06vDCQ+uAi+PTE/Xa3a64NmScbJTagK1RSmkttp//5YFufeJH8gjgA8TIuDyBnuRD42i8jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=yWPu/4Os; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 36A65160209;
	Wed, 14 Jan 2026 18:56:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3b6IvD0jWWjPcG0xCT1+Vn08FwigYkNoS5N3bzlcWDE=;
	b=yWPu/4OsPQEQ24sc3DXZCRJ93lDCJqcpiHqG+zcu24kzCbCIgcpAi4LOgjqdecyoR4Xnlb
	L+B3o8+Wx2V/CXY4wsnupoAFc4yigtsajtY6QKNZljlKofLu4Q5E5LycytqrHT2OGSiu88
	X97J4c0HI24mUHJKuf0eee6ntNk4ieMFrexpmAypgL2/j96JyvcdTYNKXPqrtZE1PDtJxw
	YxyxG0BAj6epDU9Fc/QK9N330bOhrN9RKLiIK9nGiT/ifbaxjFObQoSSYCz8cJLgfRtaA/
	aPU1XJN1M4chehX5+CQOuQdsJUKAMeGMO6Yz7Qh0Im/SG/J3XHpuZMTMzovt0w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v3 00/13] iio: pressure: mprls0025pa: driver code cleanup
Date: Wed, 14 Jan 2026 18:55:29 +0200
Message-Id: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILKZ2kC/2XO0QqDIBTG8VcJr+fwaFrb1d5jjKF1WkJZ6JKN6
 N1nQTft8v/B+XFmEtBbDOSazcRjtMEOLoU4ZaRqtXshtXVqwhmXwEHSfvRdeFYdajeNlEGN5aU
 Ak4sLSTejx8Z+Nu/+SN3a8B78d+MjrOsulQcpAmXUCKWhYA1oWd3CZGrbo1tfOvuBrF7ku6EYQ
 H40eDJkqUrDWC4FqH9jWZYfyq186PQAAAA=
X-Change-ID: 20251215-mprls_cleanup-01de8971b439
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=IrBBqYGtnCb6p5tEeOkCTs4ptATchd6cwrxwKsj7nuY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXBUQm9MWlA0MzlqQlA1cG8xdWhVTmdvClcrbGNjcUNlcjI1OTg5aU9p
 K3F5d0lrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cVV
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXpGUQ
 pELzluZC9IUzlBd213OGxIYk53elQ1TUpicStvWm1sNVpiZjdkc3RSRThFajJtMnJvZUhNRDUxR
 XlQWWpBekVGCmJldEFrRFgvRTM1QURIeTBFL2VFR1NwYndGUWYvMDBReHQyMG96UVh1SDk2M1ZT
 K0V4SUhoTlp5Ykt6am9VYk4KNlEyU3o0WlhIWDJHN3RDbDdabks5VE54Nmsxc0NRM25WZW52dDU
 yTVFjT2k0WnFERk1uaFhPSHMwdDhtcUZQVAorZGREenZONHEwNEtGVVZJNUlzQWlualdaaDd4TW
 1qdkh2dW9JbGRlTFJrWFJBRDVYREN6ZUpZdThKbFU1SlNPCjBaT2FqdUxVK0o0Mk1ka0lhbXVSc
 W9RRkt1c0lsRVlSeWxlajBFMUlZSjZoek01aVRBVGp5cGRwVGdtbDBVZU8KN2tORStKU0w5eXFB
 L2xHSDlqWkQySFNCNVV1VjVVTzRlVG1UQjk3SWxUSnJ6NllZdHJmRjg3U3ByaUFpVU5rRgpsU1R
 pbEpyTmRWK2hOMGIyWGhQOUZ3ZUxmS3NRYTd0RDVyMWlqeUR3cmlQOEV0bmNGbEpORVNaV0pabV
 lGN0wwClRtYVRKTHR1ZHpxcG5jYTM5Q1JPdjY4YjZzOFdnb0YvSm5FSGtPbHhlZVM1YlNVM0sva
 nZtenplL2tlZFRLdlcKK3lnQnNFY3RKemxMSGNFUS9uZ1k2Y203OTE4L1k2Yitadjd4UXEvQi8z
 MUJOblhVaDd6MFkyZG4wSlJ1TlVtNQo1TjRBQ0I2bWdOVlZ3czc5RnB4RjZaVW9MZHMzSEpZWS9
 CZTdLTW5XMWdOdm91TmZWVTNXZmN0anhrZXRyQVIyCjdVcGY2RUFZeWh1bFZaWDdZMHJiY3p4YV
 RFYlc5OE9WNVVHSDREZW0vZEhHVC94ME5SQT0KPUxib2QKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

This series contains a collection of patches to the MPR sensor based
on feedback I received for other drivers.

major changes:
 - trigger flag fix (define edge direction only in the device tree)
 - fix SPI timing violation
 - fix scan_type struct
 - fix pressure calculation
    (does not affect users that define a sensor via the pressure-triplet)
 - stricter check for the status byte + better error return levels
 - drop the use of devm_kzalloc()
 - stick to the datasheet parameters while performing the measurement
    sequence

minor changes:
 - includes added and removed
 - rename generic 'buffer' variable to 'rx_buf'

Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Changes in v3:
- implement changes based on Andy's review
- Link to v2: https://lore.kernel.org/r/20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro

Changes in v2:
- reordered patches based on Marcelo's input
- implemented code changes based on Marcelo and Jonathan's reviews
- Link to v1: https://lore.kernel.org/r/20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro

---
Petre Rodan (13):
      iio: pressure: mprls0025pa: fix spi_transfer struct initialisation
      iio: pressure: mprls0025pa: fix SPI CS delay violation
      iio: pressure: mprls0025pa: fix interrupt flag
      iio: pressure: mprls0025pa: fix scan_type struct
      iio: pressure: mprls0025pa: fix pressure calculation
      iio: pressure: mprls0025pa: cleanup includes
      iio: pressure: mprls0025pa: remove redundant declarations
      iio: pressure: mprls0025pa: rename buffer variable
      iio: pressure: mprls0025pa: introduce tx buffer
      iio: pressure: mprls0025pa: move memset to core
      iio: pressure: mprls0025pa: stricter checks for the status byte
      iio: pressure: mprls0025pa: change measurement sequence
      iio: pressure: mprls0025pa: add copyright line

 drivers/iio/pressure/mprls0025pa.c     | 114 +++++++++++++++------------------
 drivers/iio/pressure/mprls0025pa.h     |  15 ++---
 drivers/iio/pressure/mprls0025pa_i2c.c |  13 +---
 drivers/iio/pressure/mprls0025pa_spi.c |  41 +++++-------
 4 files changed, 74 insertions(+), 109 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251215-mprls_cleanup-01de8971b439

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


