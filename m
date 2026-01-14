Return-Path: <linux-iio+bounces-27750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B097D1DE19
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F02330B193F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA438BF8B;
	Wed, 14 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Sb4tqubH"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A038B7BB;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385275; cv=none; b=dPEYFtzI0nejBwDb0VMuCiZPMw8J9q59r72JlHEowJdIfZRJRjxNP/O48qLZZqSTx7kgVe36R8alWMdDaLV6OVnjt9A/ScShAbCb6QZ/95tR9swpZFfBx3Aaj2RnMnrw6oIki4IEr6mVu1Vz8diKvwk7b+a9GBfqZy7EXQ+f4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385275; c=relaxed/simple;
	bh=iJp9Vwll+ifz/Yk9h4SORJYOakpvJpU30w8HkxpTYcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itpiqBOLh9Q65M2MPYne/3pKC73TV4mMzPXxwHhjimv1+2RDdKVU51G/1Nt2174ycTxSbpl7EQFY9nE0MPDBKvQn81eBrmyhMFh0TBqA0J1r5bgysp1AQ/BP/YuQfqhAKo1mGcEVz3NoaOqL+bqX61/ex+YJ5HXiUcdlD0vlBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Sb4tqubH; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 3C663160210;
	Wed, 14 Jan 2026 12:07:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWKSNN7QH3PspslsIKj6evISg3OUPDOE5OBK66GNqpg=;
	b=Sb4tqubH6zCfw81ch6C0bsn54jirS6mP6ftVraTj9ALS4P0QEphA4ThVfPLteu+A1/6Fo/
	fKVQddYJbNbrqs3Aj9hVjxGz2r4ERqP8BgOgzZE4QutmzO+TcQ6yTI3DehQnqZfFo6hE9N
	TzPlA3PplkKp5Ro3ZuTDbnMps4uC/xYAq1UdaZ9/PklTTy30B9YLeqiLaaKYPQSPmeHIVS
	wNL2sfSmE3WE95bmzYaYpPqcOFThEpb4Eycb+ZOaC7nOBEbbxDfN4teMveHEWMHAb5ecky
	nzJBJYXOaJkoiyS6Y0+S//e2MBjWt82HPPxgT5bWrBBN9/QgyUF3/+my+pOOqg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:40 +0200
Subject: [PATCH v2 06/13] iio: pressure: mprls0025pa: cleanup includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-6-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=iJp9Vwll+ifz/Yk9h4SORJYOakpvJpU30w8HkxpTYcg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXQ1emJmTmFtcEtEMS9rN2htcVB3TWpICm04eEx5VTgvOEh0bXZUaXcr
 dlAvRUlrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycmV
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTMrQQ
 pFQUNETnhNbmliTUdBN1VPR0RjVlJUWWY4b3NRMnJiSUVVTjVIRXJDZUR1eVpuYk9GVmZCLzFOM
 S9idVZML0t2ClFoMmhBbG5hWCt3SzJKUEhuMFJSMitPcTZ6Q1NIMlhXQmRhU0dFcit1Y0pCOUta
 a254cENuWnZXWGtObTFJNEgKUmt4OXc1bGpEZlFQVEFpRVdZbGxJUFlWblhtSnZzS1M4MkZoaFB
 4U3NHTUpTdXh0M0QxNlJVd01MOVE0dGR6LwpEOVRvUGUrRW5YTEpNYkNRUlZ5WXVqM2wxSWNtUk
 JDNlVWL0pEbHJ2KzZyY3RMaDRzR3JGYkF5L2V3dldQenplCkNBMEN5bEs1ZjgvUkZiQkxFWUhuV
 1NrY1ZBbUlLckhEcUlZWmFMMTVLcVUxNkZBNkovZzZRZ2Z5OXRTeThJUFUKLzFkNmVHVGlGVEdX
 VENFaXFUYlp4aXdBeXdJYWw3dlNJQ29KNi9CdVViRmdKajFJR2dmRzRMdHRBb0wrNE54UApVR3R
 CTGM2cHA5SjBtTGRyd0Q4QjgrdmlWakFIbFpDWHhoS241QmtWd1BJWTV0anUyTzFEb2NLaFdGcj
 EzckVvCkhFVFYwZGk2QkYzbmtQU1RSazA0YWlLanVWaXdSbHhhR01iV0NRZ2pYNGFDeERqdVdhW
 mFLVWJJSlZPRkdhK2cKT0pxVGNFRU96cDBNZlNzNFFEd3htMTI4aVl2V3lLcUxGZjNqaHl0dWpZ
 eE9vT3MweDRsNmR5VHF6WWs5OEM5MwpFY3I1bjNZMXZZVFgvbGRYeW1PQ3BjYzB2NHVRd3Rtc1k
 yNzZPTzQyeTlvSlJWT1NOWnFpYW1OL3dHenN6Y3dBCkVhbmoyMmE0T0hQbUsvN3VhTXM5R0o0cm
 dReFJtUlUydDJJa1d2TXVYa09manh0SEtUOD0KPW5FZ0IKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove unused headers and add required headers as needed.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split based on Marcelo's request
---
 drivers/iio/pressure/mprls0025pa.c | 6 ++++++
 drivers/iio/pressure/mprls0025pa.h | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2142df7932e8..b0f70c9b503c 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,7 +12,12 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -22,6 +27,7 @@
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


