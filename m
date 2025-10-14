Return-Path: <linux-iio+bounces-25058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F03BDAAC2
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B989E4F387C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1A303A08;
	Tue, 14 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="yt94USnQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CD2FAC0E;
	Tue, 14 Oct 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460206; cv=none; b=RaZvaS3GjFGuM8zdOaEFUzruPWYzU5kqWxqmExOXjnyKOKgFVRj55ogKeTtC1Uo99B0XZhp8Wmz5p89zP4aswWVktDlvmis81wKyuLHoHV46F9VNsIRgL9EhqCt7Sszm3wvzSTddNNRZSA+72QaZ0nJko7yPbgE+iePG1ZINjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460206; c=relaxed/simple;
	bh=hGXHFJP6a5r4+lwUKvutRj9vqsCCkyQojjkFA9hhQtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yn9b87v67+2pZ5FjmySXlAKd8UBsQLdLS/HW7GmVl1266NggBgNsLU2PcUIt5k2EEjHrDgM5o7/jZ/X94x8AC2us0UTO1vhkKFcdDnL56rBcHEeANs0bJqQEfuxKOEuSlQFmW5mErsRfq9kZxdbxmvKfCNVOfVnLyQoeKdEd0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=yt94USnQ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BB978173BEB;
	Tue, 14 Oct 2025 19:43:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=novRg474SpBhfjFfxS19TVOepKB3QzxOpPoaY/ruPpA=;
	b=yt94USnQ1HKWTuk1d6Gq+3hnLljFmpkuW0yY/ZBuQoZ85iCK4cpICN3ovezjuqzPtxsn5i
	GZVK0xDyJUHoK27U41DbSUHVdYlaZ03MOQpszG7jVgWpHcF0D7KPu73qLUgTNP/1ub1hM/
	9b+mdtmwx9qQidasZVD+9L/PvlsrKC3O2h/uN7AKE2kkFJMnIR+a0ow5mU2Ysfw6bpjWvv
	QZjUWHk2NNFlw2M4xmxGBT923lP5e2y7gIyTRBjP5vql6g7QWEotufBzOI0DXHL5cFAOGF
	IX9nkYYWkNfoEIFteqLmPBwTlkvtZYyGlKZFhknQsSj9cSLiiajnYIQUO1jewg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:42:58 +0300
Subject: [PATCH 2/6] iio: accel: bma220: remove useless include
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-2-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=662;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=hGXHFJP6a5r4+lwUKvutRj9vqsCCkyQojjkFA9hhQtc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1ZlptSHlST0d2dG54VTBQa1AxNWRFaEtPCkNEa3RtTE90SnNaeit0NS9o
 K1RCVW9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMlp
 BQW9KRUhRcko2ZGpPa2xqUWh3UUFJMU9LQUtVaXhEcVFZTVFUL1JXRUoyQmhrNmNUZXMwSER0UA
 pxWS94bGc5SnVxZXJLQ25DQ1hoZ2ZvekpuSzNEKzJCMUhQay90US9kVi9DZlhpZUtrTXJXY21HZ
 1BRcm90Nk96CnJURUc5YTNmeno5UXJaOXVlS1o0eitSSDgzSnpmVVV4bTZEeWZuazlybmJSQ0NI
 TmpVTHdWZHl2bFFBTmY3WE4KTWJqd1p3ajREd1M1THZmaWZEeW1mYTVUdEJROXY4alBxcGNwVHF
 sa21jOEJIVVc1cGE4WmNEZ1NScmF0TzBWNgpWdGh4U1Fuc2VSQzgzdWErSVF4azVpdVR2QUdmZE
 k2bXBzQlFQa05zTFBQNTE5ZnQzaXUzVWhieWV6Q0J6UzNoCkgzd3FpdlVaZk9ZQXRLdWJqS2h1T
 lUrUnNUU214K0hNdzlWekJXOHR1d0pXamVkcE90ckNZUmpNc0pGSjJtVGoKTVpjSEQ2R1c1VElt
 OERNcGIyaTYxeWN6L24rYm1JZUU1Z3QxWlRlRGltN3A4clNBSTVEUTd6ejV3ZUNCV0E2egp1QzR
 yeE5iaGk1c2NLZHkzRHZta1R3MXREMjRmYkg3Z3grYklTYmlPRFFuNjQyWEFYWVgrMTdMNG5OWU
 R4cnpoCnhOSk5KRFczallUaU5NZjA5NTd1cVFjcnNlb0wyYk5na1NhWDNmNm1XY2JkeUhSbm11T
 FhCdW5ycHNCeDBIUDAKZXFBUDdUYkppUlpCRWd1NTQ4WDg0dDFRKys0K2JaVENtRlAxWHFoamV0
 L1VvakxIcGZTNkhlcS9HTTJ1bzliUApBS2hCd20wS28xL2Q0MSs4WU9YejNWbjBTY3ZGU0Q1V3d
 mZGhoRnlvczNuYy9LejhsLzJDL0hscUdmTHlDd1NTCi9UWDIrYkYyY0xFNFZnPT0KPTllVTgKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove errno.h include from bma220_i2c.c since error codes are generated
within bma220_core.c instead.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
index 5dc7c38f53b3..2b85d4921768 100644
--- a/drivers/iio/accel/bma220_i2c.c
+++ b/drivers/iio/accel/bma220_i2c.c
@@ -8,7 +8,6 @@
  * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
  */
 
-#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>

-- 
2.49.1


