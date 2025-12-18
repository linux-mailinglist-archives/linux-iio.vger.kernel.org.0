Return-Path: <linux-iio+bounces-27161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA043CCB892
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8269D3053909
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDF314B6D;
	Thu, 18 Dec 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aHcaiDfn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF182314A7E;
	Thu, 18 Dec 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=ni2Bw44r/px8kBeiru3+fWXM/aoriJEComQAH9dHJFcUzD0sEChAdgI3W9PcCpMGvscLzb0KuBMCqhm/F+lOsFQj8p9Nhv3RchqYiYipRGeSH5FYlyfBq/hWkrwOfUWg2knDPUIMl/UDPBbUxV13p8cwUO7t61z9rzJh3z3KT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=i2E+jfjK81U1qieOr4tfsvMfhk11pPuIIc+VFbXQ1HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5IliwmeJR1RgqNTCqLyg23Y4jS8mQfz+vculJ/bWR6D6YK8d388FzP2Cx++yFhtvT4OBmgzpWJHKjDQpXnp4RHtVkIuqvvrvd0S7uafV5gnG6fObTMZJELZ2y40Bnq+tuSfh0RWZ+X1+PYp9H2lWo1T/OYREw/kZoWGfgu2484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=aHcaiDfn; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 07CF5160215;
	Thu, 18 Dec 2025 13:06:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyMLcWTm5jiH1jQ6mHYwXRTLPdKxHYWWusZTtJVLEUQ=;
	b=aHcaiDfnFF2k6156UTHAWUikxtoJpEPPR8vhF2AizhDfeUCVhkUSrFDj5colxFw6a5o81Z
	OIHSsnknAmmvcXWG3LwnLo4xh6iJLsOFAdAEqHk3lFYWPQFw5OFE+rljI8rlHFXNcJyz1r
	2ac3R+yUeVcdWJFOLnXvgEuKuRtKzFuU2WPrvZVM5DWvu0YDXrhRPdx4zcHK1+1IMhWUJB
	2inv5ZTfJ6PmNGFfeSWXOROJI89cLSZOFm4ewDrSETvKK/NrqOWx+7tofeoJcjUlZdfZ3s
	SzFO6qX5Susjor//jlkxYDRgRFSS6y2TtROmnHNYt6Kd2g4Cf6uwTae1asgkVg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:54 +0200
Subject: [PATCH 12/14] iio: pressure: mprls0025pa: fix interrupt flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-12-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=i2E+jfjK81U1qieOr4tfsvMfhk11pPuIIc+VFbXQ1HM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENENFRlY5UERpd1BJaGw4ajYxc1JRVjFYCjNsTEY5RXdrSTVmam9XY3Q1
 dWxXd1lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWh
 BQW9KRUhRcko2ZGpPa2xqdjkwUUFJSWt3SmwxSk5WNWh6WnJLMnNDYWhKTnAzNG9QQkxoVGdmMg
 pDbU5oYzBuTyt5VFowSWlYNzkybHZIVE9CNVlTRE8yZXRYak94VG1sQnU5K1RvTFBuc242RjZ5S
 llXMmp5SzU2Cm1mRDRFN2FkYTNSNnZsNVA2cFd6blRWQVdjZld6MngvaG5jUUQ5Q0FLT1lPUjVw
 ZmdvUmpldkpsRUNCOGMrK0IKQkE4UUtqRGlTclZ2TlhWZzJoRmtMY09PUXBvWkFDb3B4OVI2dkt
 4cU9QbTc0ZmdPZmpJVDh6WDZybHVjRE95bQpPNytycFQ2UktoSVpQcTRPbzRpaUFhOHd2dVluZj
 dTSnRGVTVjR1lxOG1PalM4VE55SHZYOGhBTUdtTVQ1T1hsCnBSa2dnYzAxMjZFWWttRVV3UDI2U
 E5SNTRjT3U2YWlCRFZYWkhjZGRLSHU5ZUU1VGxOZ2UwSVhBdmRXcWVUdGMKYnVEU1B4TGRHTTBk
 TEcxMytzZ3p0T0pONWNiTVZOTkdTc2pTVnVZeWtVMy91OUxiVmNMcWtJMzVSNkUzQ2RCRQp1Tkl
 zVVJZSjduY1B6SnBYOTQ2bDNYSGJETGVtcTBmcC8xdUpnVDdTSE1abmIyeDRHelJQUW43Y3RNcj
 JMVmZwCk10YUFZRnovTklMemlraWlaSXJvV3FlUmNaTkxvcnphMlpBdEpISjFKUUUzMXNaMW1HU
 nVhdkcwR21SbkdTRGMKQ3hFRnY3U3Z2eGZmUzg3WEN6cGxTUzZtL0FGQ2pabUJNNmZ3cmc2U3FB
 R0FscWlnQVlEbTNDTFZyOE1NT2dnMwpidUlUSzZLamt4Mk5Bbk5LZXRDVSs5eG0rYXpNalcrZ3h
 0cUs1V2FNKzc5TjNWL1ZXVG1hZWtvV1U0YnVaRDE2CmdCQjRSdEROMXFRbWV3PT0KPWdjUlUKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Interrupt falling/rising flags should only be defined in the device tree.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 243a5717b88f..fc04988b9437 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -14,6 +14,7 @@
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -404,9 +405,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				       IRQF_TRIGGER_RISING,
-				       dev_name(dev),
-				       data);
+				       IRQF_ONESHOT, dev_name(dev), data);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					  "request irq %d failed\n", data->irq);

-- 
2.51.2


