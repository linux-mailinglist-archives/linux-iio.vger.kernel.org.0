Return-Path: <linux-iio+bounces-27168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC51CCB89B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AC0E3048E41
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE1316900;
	Thu, 18 Dec 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="STHmHVpl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B32314B8C;
	Thu, 18 Dec 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055989; cv=none; b=D/Xsr+uxsXp9RTY8wOI6opkfXk6284SPBncXL1dKPp8DF+gGUDdfN97N8MCjniAB3uovaiJmVPotAuXtXkSHHIqYmBJfYMXxJ1kiuPaWrS+CQHkIOiAvcPz5VowCyK7e7mGXTLLbqDLoRrs2/9A8EQIr9QIf7GuBsY4liXZnee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055989; c=relaxed/simple;
	bh=eYI9DcCaMYxKhzj6DDAt0VqNKVXU5dxJET6/UXZKNZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGWFZ08/84x/uLjTmMB/qmz7u0QENbYj9C16FpWG+EOxIzzstcvwbW8x5QfIoIe68IAUomXhfhxa0NyHnNTWGGS4JCzY0pfBylcN+BMwZYsOZJ36xPhBtlJJ0c4dTAvkp79L1McawfiMRBdan7mKMBeMMGZFeUug8jj1tc1C/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=STHmHVpl; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AB1E7160216;
	Thu, 18 Dec 2025 13:06:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UyQA0DniInIHUpPsEpLVH2XA8YqZtFjrZ8MhD1diSk=;
	b=STHmHVplAzFJuztjJtHgj95p38GdOfo/O8gmw2E8ZZAObJhcKZBVDJ42eHbX9CV9m9IN2u
	PjvedyGmPAozZlQoRqwOcHZZ2eM7Ge5MCXkV99BsC6KBuMS0SXIxf7VaVwhwKz4ZGDKzLv
	955c/KJCtzTVXNKYDwfnrYG2UtPw/O10UuUvwrjq9YqVkeMPJgOZ0kXCeJJ5Yvzm4BxGbj
	17/NcCaZuDwn46w7vUUvPLpJEzRd6jIP8NttUGiGWv8C+BUCRgZ5ofibNZqfoBkDxnmBff
	Gqv3LU69QTyDpv43izaDlENfCZxB/0ttHiamlzsmTlCvbJxj/5olAz7XpECEQg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:55 +0200
Subject: [PATCH 13/14] iio: pressure: mprls0025pa: cleanup includes and
 forward declarations
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-13-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=eYI9DcCaMYxKhzj6DDAt0VqNKVXU5dxJET6/UXZKNZo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENENPVHppLzJJK3k5TWRabnJ5WFE2alhNCjl3c3NEd1gxN0JVMkg3UnJz
 WDRTMm9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWp
 BQW9KRUhRcko2ZGpPa2xqQ3IwUC8wQzQyVUJDQTJWb3RDMm42Ly92OFljMFFTWW5zakFCS09ldw
 pnSVA2K2dwRFFRNEJMWTBoelFMQkVFRmRyK3BBQlJDNjYzWVFwa3EwL3AydlorQmg4Y01xU1M3R
 jFiYk01VnJSClNRdDkxZjZjQkZkY293SVdvaW9ZSkZNR1prMy93UGdkZEE3eHhzRDNQN240RGxL
 bVlnSGNlWnlucnMzZFhwN2cKM1htbi9mdVV0MVdKamJydlRlaWp1d0dZU1ZzQ21pWlorNXFQK2t
 XaUYwTktyYWZ2N3FCbWJaTk00ZmxtTmluRgpUcEpkS25GcTJHd0lrSmRKd1Q1U1BMK1U4OXFYM0
 krb2JLd2pCcWJSbHpIbkRlV3kyUUZndFFvY3pkUGpsNTFTCjNLQ3BueGtvaDZ2YXlQeGVXeTMyV
 kcrUEg0MG5nMW1KZnZ1MStDdGtEaElsY1BHNFRaSVV4bzFuM2FIWXZySTMKbmplL3FpWjhLRkF2
 RnZYblVhcDNPRHNzTzBNZkhBTlJMTTFuRm1UZ2pRYTl1QlErazBkVmIzcHRPbVJ2S0JUdgpGUWs
 2VGNQdGdtNkgxYkZyRUQyUWkzV1I1QVFqay90dGZjVllRNnNQakI5WU5vcnU4dFFTUlFGVzFLMU
 NadXRrCjJJVG1jVTc0NjRVQWZYTmhVM1k2ZnFaSms5bTVwSEpqRkN4VmFNVTVOeG94eWFTb2xxU
 zdhY1Q2Y25LbCtyeXcKZCtuc0x2V3NWcmNlbmFMUnRtNW8yVWc2ZmZoT0lmZGV5ZFV1UUpaT2xN
 WHVPNmFGUHU4UXBmaXJQeTIxbEM0dwpkRkt2YVJYSXBKTE53ZkVyZWVxSDYzRTBvRlY0SFQyci8
 rdzdEYnM4UzhJdHVtYXg3a1QxUUFQZ3p3Skx4YWNFCk1JNWp5RS9BaVl3a3N3PT0KPWhNbnAKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove unused headers and add required headers as needed.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 4 ++++
 drivers/iio/pressure/mprls0025pa.h | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index fc04988b9437..71728f9fc498 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -12,9 +12,12 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -26,6 +29,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 2bdffe1e0eb1..ccd252f64351 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -12,9 +12,6 @@
 #define _MPRLS0025PA_H
 
 #include <linux/completion.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>
@@ -23,9 +20,6 @@
 
 struct device;
 
-struct iio_chan_spec;
-struct iio_dev;
-
 struct mpr_data;
 struct mpr_ops;
 

-- 
2.51.2


