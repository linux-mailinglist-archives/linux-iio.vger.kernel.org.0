Return-Path: <linux-iio+bounces-27746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B9D1DDC2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F0413023A3E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAC138A2A2;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="dYl+Sypx"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5E315760;
	Wed, 14 Jan 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385272; cv=none; b=ir9pHsOZPGHrw4Tbnimapm6Rw18Ux9v74v/Y+1ZUe8xZluvOvHaWhGX0dfG1nbUX3uC5ywDqsIa9QMr5dV5P28O+ZaQCTs364A+Q6GxiX60d2v3ZsApXixJjUQeoKOF5yooskwmLFBPMwRrzkS9ZALou6mu28n5cuTPpIAakhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385272; c=relaxed/simple;
	bh=uMZ/2qhZPo2FEqne2iM7O/+A6QfQmq0ojRfiwGHhhkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj5pXUqaEu77jPNgBdnFf0Fs4OuZZBDRf1dYwrKj4ImnQfR79jxlyrzYW7/Tzy6cmv/+rdxsE7cbptPkUtwL+Cn8V8c1bYxiBGcHWEILGeJPLWoFopSljvZlAVQLTAD3tiEyyePHEra6lMhwN+Pi1pG5eH0OBh0svJlfoamh2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=dYl+Sypx; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id BE53616020D;
	Wed, 14 Jan 2026 12:07:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FE8a1uFbvKrcSUxZJ2v/byh4ni47RT1TTCYr2BpWGXc=;
	b=dYl+Sypxr0825pQUZtl4zx9jase79QhOxqYrAGnkcZG4nr6S/w9HLymvpB7yG6F3FI77/2
	FkWT8bPxPqslEm3izIuYhfUb2v9r+d0fyElBh/NoEYpIMgBvfnw/0PCA+X5ZZM7JBAjUzg
	xKMPy6I058Jl06FL0YYSsAycowmagiwsygNFTDcjokXF1V5mKRTG1o/ZQottk1hWttmXSE
	YMYdj/zdSgMgr6qmPfdwUECGKW8EVIjc2v1/+KfPfmXrwikoGL5lnMb6pph7K99sP8AnPS
	1E8r6UjdFptcTNVAcae99IJuPvsfM/ceY0HzqxcnUXm7UMW+Jrw/7+4XTDiR1w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:37 +0200
Subject: [PATCH v2 03/13] iio: pressure: mprls0025pa: fix interrupt flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-3-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=uMZ/2qhZPo2FEqne2iM7O/+A6QfQmq0ojRfiwGHhhkY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXRkMUNUQXdEUmowdjc5QTZOOVhpYk8wCnI0QzcrU25IQkdva1hqWTBP
 eWtjWVlrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoyclh
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXkraQ
 pELzR5M29LKzBoVHF6VUhnRmd0bEowUjcrRWJpVlM5T0NQMDRsMC80bkhPUmRXNm44dzFSQmlJQ
 mlrdzRxUmxZClE0cHRDNVBLTytWMG9EMlcxSHorYUh4alNXSjk1aGp5Uy9BVXk5RTZZMmR3WnAz
 dVNKeCtqTEZTNzhKdFZ3S2wKOFo3ckVGL1Q2TERwZTR1T1FWM2dXV0V2RWt6a1loVEhzMlhWOHM
 3dHBXNm41YTMzTlBVU1phN0V0OTRVYnJBaQp1c3cvQUh2bGpzdjlqMC9wcm1BMy85NWdnRk1CbV
 BoQi9uQ25qRm5tY1JlTStVSlA5QTUvVXhScjJkY2dIaGx3CjFrNG9KMHJheVNIdmVUVWVFN2U3N
 2JKQ3ArQ29MNUJLNGdvV054OFhySmo2RXd1WWtyZGwzdzU0d1NkU0lBcUcKOEkzSVpVeElmT1l2
 NGMrRktiVkpZRE4rRUpqWU5vTWNycllEc1N5TE11bDhReHZnbzJOaktMVDFrTzREZnNhWgplN2V
 wWXlWQWlZR1UrcEUxWHpsTmxCdE5TMFI3ZjRwVW5GdTladmY3Y0x1aHN1MzBDSnhvVkNKM01HYl
 BScmdvCkdUd2IreVljdUNYMUVxSVlnUmtDY0xpdFVhRHpEeWJSZ2c2akZLUkJ0bU91bGtwVkZBU
 klGVXZqbkRnVWQwekcKeVd3NUNOSWhXd1YyRnEreWdmZVVsQlRrSXhZUGFVdjdycXBQWTJaY3FJ
 eEdHZTFoM2NJZ2ZmbDhFaW16TDhWSgpvYWp6MllXS3VKdlhLN2hRcWhyUjhaVG1lVjUvUmFNaGh
 sd1VmdFg1RzdQc0pHdXNtbUZnR0V3Q2JXV3dLaU1FCnBETXhkaDBWa0E4NzI1SVA3YzVUMW84Zn
 N3Z0NRWVM1aGZqZmxaM09kc2luQmUzekh1RT0KPXIzeW8KLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Interrupt falling/rising flags should only be defined in the device tree.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 use IRQF_TRIGGER_NONE as Jonathan requested
---
 drivers/iio/pressure/mprls0025pa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2336f2760eae..80985c090aff 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,6 +12,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -419,9 +420,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				       IRQF_TRIGGER_RISING,
-				       dev_name(dev),
-				       data);
+				       IRQF_TRIGGER_NONE, dev_name(dev), data);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					  "request irq %d failed\n", data->irq);

-- 
2.52.0


