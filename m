Return-Path: <linux-iio+bounces-27801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674ACD20648
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDC4308D05F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544682E173D;
	Wed, 14 Jan 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="hXtEpun2"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A33A783E;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409797; cv=none; b=hfT7Da5sP3jy7wBnKpZyIJpOVVftDs0x+paEl57IBW/c5p/Ep80Lqvwv3pdJzc6zWqF3QB37d+PRHkSsJ7LoqD4/+RTk4oRhjmwQseSgMQVTvIxZyM2WlgD6ZxUb1C5UpsT32Xl0PZlIwCHpmI6z8TJYZImi8pXzn6DbcVwuMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409797; c=relaxed/simple;
	bh=e1S3HEsK35bXkddVFuCI99bJSSgr1E5u6JF4VQ2JU3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOPGJgSnoB5DJifeuAx5GUxw5kFWmzkmGs+MV3eCC1oi0dHUffrZqGNjNdMT8PWdBKOCPHTLaW28+mnqslUeqC7E5Ki9Ae/vFStyfBxLI2IskyDG4HOkMQowFYXVbAV1pPpvt3oJ+dXBOMPe3CSrwPC8tgCBd8unvfSfGSLXNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=hXtEpun2; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 715B3160210;
	Wed, 14 Jan 2026 18:56:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv9fm5Unw4Bq9ZNQaT7y2kUFvpDF5TiXhSeier1JuMQ=;
	b=hXtEpun2zd1kHDsCHSAYDv564GPTVoefUB9UdODB7qzP9fmNXLqNM0FVyY4CSaUX22qEBR
	kG2qI9ctEMx0W5pYHrJj2fgF7PIjb2PKJpQsb+6pYJdd4URV8VHR8yFtW+THh0NR2O/6r2
	gVvRSGTKsB7fGD+SX9lLvDPteDYRn0JehHzjG6LGOpFVbdlG/K3i2VbEAlcA1Th7vq7ttI
	98R2p6kLEBf/+silyhsSDq9VQnruQzVbHmxu7PD0YomgLjX5KUVZxTUG0VNEFtue24Kjik
	viAtxj3bQhYFzBqPJAoaz4FfTtLyeV3HB31Oywsy5td9hp3qJY0nhJ85vj0kyQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:35 +0200
Subject: [PATCH v3 06/13] iio: pressure: mprls0025pa: cleanup includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-6-bc7f1c2957c2@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=e1S3HEsK35bXkddVFuCI99bJSSgr1E5u6JF4VQ2JU3E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXFLRVY0bkJoZFlFYXEwTnk1Yy9nT2R0CnVoVXhSbnlEN1J0YmFKcGRT
 em1vVllrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cWl
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWStyag
 pELzlWRjdta3pNbGwvTUdBZzAzK1llQjJJY01uT3BDTndxVzBFNlV2SjIvUnF5OW5oOWlYN1ZBb
 3JGTW91b2lJCmhDR3hHZnh1L1JVQ25EK1NaUzFaWFBtZ015dTNMcksyaE1RU1kvNGtTN1pKSEh4
 T2dHYzRvN1B4aytuRUhBZDcKNzlzNmhScjhCZDZnUDRWaml2OHl5LzN4REg3Y04reEl3ZFdGYmZ
 CemhrQkR1dzlsdFBnME9yekthMjI3akc3Ugo3ZFVkckxTNTJzYkdoc1ZWSkhaMFdOQjg1MStyaj
 h2cU1MMkVMcFJCTmM5dGxnekE4b0ZmblRvL28vcU1DTnlUCk80NXVjaWVtbU15OEJDd0ZnMm1Ed
 HRhZksrSUxrYUlKQTFzSlFOR0J4RnNSRXBLalJuNFh4bnROK0M1TGcyWEgKaGRFNkpyNXJWeHFX
 a2dBeHd4bXplSWFqUExuVk5mRUg4c1lNam5ZaldwcTZ5Z2ZqVC9EaXZSSTNQajRGek5mcgowVGd
 2ZzVlaHRlbjlZRXc1a1k2SWVoUGJ3YnkwdU1xNmoxekZ1L204enNZYmpCZDh3K2dFVWdrQkt3K0
 l3QUxSCnd4bHdoYjBnQVNScUJuNWsvMDRzamgxREM3cG5hbjM3SC9nbEVDUVVqYzRLUUFwelJrN
 EhKSGFOQk1wNW41TisKeUQrVkx0eVN6eGd3UHkxOVVQTDI5NTFCVFdrUy84VjIzcHVDalB5M2R5
 N0FvTWdndWEyRlNGZ28yZDA3eENHTgo2T3pHbkErM1BIVXg4czJ3bXVrKzNBWjhNTEVMRXgvMlR
 sWmtsL29kSmtNQyt1R3A4UnpERDR4NEpvcWRoaE5JClIwZE1sK3lXNnZTQnRoTEhaTSsydE85dH
 IxMUErWnhVbWRFc2l2TVZTc21OOC9nVUtrWT0KPWY3djcKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove unused headers and add required headers as needed.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split based on Marcelo's request
v2->v3 no changes
---
 drivers/iio/pressure/mprls0025pa.c | 7 +++++++
 drivers/iio/pressure/mprls0025pa.h | 3 ---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index d4133fef91fa..3a5dbec81b50 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,6 +12,12 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -21,6 +27,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index b6944b305126..eab877da3451 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -12,10 +12,7 @@
 #define _MPRLS0025PA_H
 
 #include <linux/completion.h>
-#include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/mutex.h>
-#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>

-- 
2.52.0


