Return-Path: <linux-iio+bounces-27749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3171D1DE15
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B60630B010D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21638A9A1;
	Wed, 14 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="JTuZkQhR"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE538B989;
	Wed, 14 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385275; cv=none; b=J+/FbRb+Exmf1akJ74sCz/YftNJOGYEneSoKsNiixgFucQPQhjMQxfhFwlazn1n68ns8S6haUwIn6sD6J+7G2e6x8kvDjUPMjK9L77K5BhnIYkr3w+C65QNwVvDgPOgndMbNJnrhBHfRIGX6mZbPwDW8b4P9xF7F7sioZs/pOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385275; c=relaxed/simple;
	bh=K6fvhnsBPRpbmlGfScciuaTpzFhOGbFk4c7hDf3rrtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjUqhmsaOlmIhtq9j6C4pWXh/1DPU77qTcBv2wM7ilnXaSNb1eZ1yxpkR2PHazWcyEFCt1KHwsoArzUK51TqBeI6ybE7WHZ0HRm1rldpXPebLxjGI11wb0CAYdncs5hHFki+8WD4bN4SK+MpwAHcFnp9vo/9iFgtdu9G5NkQB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=JTuZkQhR; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id C6CC6160211;
	Wed, 14 Jan 2026 12:07:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4cO0bdwqYtq2NStQRC+vyXtJPhUo/iR+o2fI1FK+sk=;
	b=JTuZkQhRw1W7NPvmxGLZebUW1gMWJW9tr7sWaU1F0Z8rC2h3fvBxxcFtBuU5dR3JBCcxZB
	GSO4pqUteWVq622JBF5rCQC2j5wLTAOF2g9tgvYGEXqcnIuCd54cO+m+p8f/noBOhYdEOT
	HHH+KHDCjm1/TNSh9630ZHn4ArLFqKXxEOP7J4W3Oy3GhxhJPXXC2mZqKWPjX17dPs4WyZ
	0wzjAhKnor7BJY0PwIzGuCLO97H5pE1TYvUCwqXORWcmq1iKnxesC3PjRXtPNjm+AA1BnF
	iVnB6EAqmiq/7iWqmgD5H8LTrgIySXbXI8Uc81tXFJvqMxJdZILKgDsN0FXKJg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:41 +0200
Subject: [PATCH v2 07/13] iio: pressure: mprls0025pa: remove redundant
 declarations
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-7-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=649;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=K6fvhnsBPRpbmlGfScciuaTpzFhOGbFk4c7hDf3rrtk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXVDUlMrMll1T2ZtaVphZDFmMEcrYXVzCnp1aStPODB4NFFrVXlJRGRS
 c2pEVm9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycmd
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWStLMw
 pELzlLY2tGWGIwQkdReFdpai9JVVoxWmtkck8rYk9SOVI4Wi8vU1g1T254emR0dE93MUZBSzhKS
 2VHek1TNTVwClRoWVJWcFp0RDJGWUwzOVR5cy9lQVRyeWhWQjA5QVBoNS9sbkJYSFdWNi8rZW96
 R1IrdWxOWU9hU1UvUjBmT0cKTG1JSXpsaDBscVc2K3N0R1FRbHhMejJRTmdydEdwMmJhQkpGQTJ
 lcjVJcTZJT1RaYkhUMHgyOWR0VnRuRkFCbgpSWU5JVFY2UFJ2STAzekpLeDZLL21pc3lKZ2ZqZU
 FCMTZxejN5OEhkbXhCdk9ucnJkWjV2aXg2THFqZUdiY09YCmhFTFRuRjFvcmZPT1gwQ2tSTVFxR
 k5vWkdUeDYvUzlRejh0THY1MWVkRklvMkFRZHJpRUpBZ3RzWWF4ZDZ2bXUKM08wM0lkQnVJL3Bt
 M1ZweElYTDdoVlZGdC9hemJ0L3poOXNGaFRIZUJXaEx1a2hFZDlUUVdkS2x6ZmI0OWhBVQpxekt
 mQ0dPQjRRVGNOQVdLVExIVlhnSTZNVHFOK1cyQnM4ZmJ2VENsL2Y1bXFyeWVINnpHblN2bkR3TV
 B2NGgwCmxzc1M4dkNVUm15VkJkWlF1UDMxNzlxekp5QkxXcndlcGVOWFZHN3gxU2l1alVqNThYT
 jRaSjEwdTVaU2hROFUKd1hMWkk5MmZpeC9hMU1QcXpRV3MrSzBMNVl1NDJEN3poam1vQWU1ME5h
 a0kvUVlQOTF0cDJ4WEhOcFdOVm44cgpTQ0Z1bmlTb09hZGV3djJVUFJpNUJiU1FvU1ZiYWVXMjg
 vNkVNTjdoSXpmUGdwbndHL0NLMExIWEFvbkxSQnhvCklqVTkvU3ovOUpNM0xCcWJVNmN3SkU4OX
 hIdkZLenhCcnFlNnRRVlpENk5qL0pzcExzOD0KPUkrUjcKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove the iio_chan_spec and iio_dev structs which are already defined in
the included iio.h header.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 split based on Marcelo's request
---
 drivers/iio/pressure/mprls0025pa.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index eab877da3451..e34253af8e23 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -25,9 +25,6 @@
 
 struct device;
 
-struct iio_chan_spec;
-struct iio_dev;
-
 struct mpr_data;
 struct mpr_ops;
 

-- 
2.52.0


