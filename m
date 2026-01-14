Return-Path: <linux-iio+bounces-27803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68BD2065A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B1830CF7EA
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE83A7E0D;
	Wed, 14 Jan 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="0qypVIQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779C3A7820;
	Wed, 14 Jan 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409799; cv=none; b=ewZ1WdL0x7rmygUvXqbJpjCY5dP5PlCO1QkS2D5BuV8zz3yshfGVrykieeROG58Cv1I07Dz7u5W1pkFDXrq03QkpuXr5Zxmsk/nktTZLvbkPLhg4QKpN0oRHrfMV7yaTzEB/wBPeUuG74pZpe8cV2OssTW4uqKnMbO9rdC2j7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409799; c=relaxed/simple;
	bh=vFEDfthT2z+ZxE46oYIzbxzpnThOiTPtjzBws6rmMCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZN3wjXvJJVF4ScWcZlXTGXcAAnTdWJv0+U3q11gLAdHwANYXCRRp1edt5pPD98cb8SBj1DywO5CNYasMnUGIecb8n+ddrMy/V5MKnqsRZrlA6nMawpNd+cG9xsREgfCfM9y2PR2XQVRI5JpY7zCyIbIvXD0qowp4+AQuFtIu44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=0qypVIQT; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 8C1F5160217;
	Wed, 14 Jan 2026 18:56:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBSFj4guSw4TZ/tZ1ql2UrIIgqgc/RJ0B+/JMDKWqxI=;
	b=0qypVIQTgKNJi+TUoJfvZ42ohmTqHh9zAy1js+twltvh0B5MmP1HrWK4Z+ChMnEO7jPkjX
	AONtbY8e0c8M0NUry12kWYQ08NOWb53atk8o25gkm4oPYT29gpUhpVmYbstYkgBl6zrDqB
	dl29FfVBYP9i+aj+4yE5aFAsUVc89DKMLBlH4NupeC3MGf6LHGui5QyZ5LlnGq+jyaX44B
	vRz/eCGb6czAW+fzsxAvgzgMZsL5WxSIZw6dCpRo18Af7ElUaEt3CCg8dfjChHy9qzQPEG
	2a1n6zCLOArAa+w6f3xPGP7ikUaaaEXb6jtYYyEIT9A6GMQ/s6BW5VZGnbx1tA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:42 +0200
Subject: [PATCH v3 13/13] iio: pressure: mprls0025pa: add copyright line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-13-bc7f1c2957c2@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=vFEDfthT2z+ZxE46oYIzbxzpnThOiTPtjzBws6rmMCM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2xueXJLakJSNTFzd3BwNEhQUGpEdWcyUkxhZmZpQkhVVmtGejBQClZpYTBBNTRHWUlrQ1R3UUFB
 UW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpwWjhxeUd4U0EKQUFBQUFBUUF
 EbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTNXWEQvNHp4VVdZTlFNQw
 pRMjRFRWdlNWtGakhpRTdrcy9oaHArajRpMGMzemc0UFRTWkRsYVhUMWsrQlc2RUlyVFREbk5SM
 1VMT3lDcEovCmRPTnlVbzhMK29wMTNZd0xlTEZUenp3QmY4blpRMkF4bHYxNVR2QmlYSzFNWVdj
 b1d6T2l4ZEQ2TGdMWXR5WHEKdVEzeFRpenBBa0wrdlp2ODdSL1NtZFdQUUtxcy8xR1ZFNE5QSFh
 sV2xaMkRTd3dCTjVxa2R0akZWek9JVGtUdgppUi9Vd2VOaXNMSGszb1YraUxzZVZudnlOYWlGSF
 R1UlVqb0tudXVuTklabzNFOHgzcUxYL1ZibklsWlR2S09kCk9zZFlYNVdTdnJYdWYzVUZUeEZPS
 FBSMGNUNUU0cDVjYjJvNnJ6OWdVWFFaVkdvaDQ1TVZndVpuUlNVZGpJTDYKd1VKZ1FZR05RYUVa
 R1EyQ0VTOG9lbkpaSHRPazduUXFwWnRFdlVZSEpDdFlQSFNrTXBhMEdDbEZhNTN5azh2MQpsQXd
 zcm1uU2c0MzJiY3JuZkUyVk10V0orWmlVNEpUa1pGRmNFYVRMejh6ZWR6ODQweUd3YkpqZnhzRS
 92cXB6Cm8rZTVCSHpQWEdRSFdhVUVTVnJIV3VORDQ0YVQ5MnIxOUxIVlZhc3haczZPQXYwRWdTT
 VNjdEI1cXhVRDhMUG0KdXJUeUdKcnd0STA5WWhTdUh0L1ZtWTZYZjZNREJxVTZ1bGF6aEMxTjFK
 ZC9BVkFYZDhDMysxbGZmVVFRQTY3UgpIK0NFUGZqcDRSK2s2d040ZU5SY2dQamFDY1VZUU40UXd
 PZU1TenEwa3BVRjZiTkVTYjYxeEFqMjdIV243dW8yCjFLNUErN2xkQ0VOa1gzSk9RdnlON1ZCcl
 VWNm9vVTFnWVE9PQo9czVjcgotLS0tLUVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add copyright line to the core driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no changes
---
 drivers/iio/pressure/mprls0025pa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index b1122ace6bac..587d0dcad89b 100644
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


