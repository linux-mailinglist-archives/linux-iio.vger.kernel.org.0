Return-Path: <linux-iio+bounces-27793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24ECD205ED
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A40E03013C65
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC003A6419;
	Wed, 14 Jan 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="VcdpoK0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9D35E551;
	Wed, 14 Jan 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409789; cv=none; b=U9batCs94eJiJny/ueeRAil6+cpOGfhOFhG4eEzFIf8E81K8E2y/kZr1/CeoCjg2RjP/0VAoABTKXK0VxPj3Nh2Wkxjx8l3zgkLT4UXLkDxP1H+Ac+4JmWlJF6AHY+rgWdI4bYAPHA/88Ks0PaudXJ/aysNJHZq4v9MZ2FPkCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409789; c=relaxed/simple;
	bh=XOIcrgqwLdbh/uSw9m3W8n4ERWUbOIAvlIxQ8mKmptk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCJgyHi5YDx2xnBE0cueWd5vn4h6fdzXpE0ekeFhDWWn8zvv6xhIQXkBCnBKSf5Ym1m3aqg/QbtTx4D1+0C7mWrMu9Kepni+zkYBwF1gaMXiyoyJxLulX7BHflRkRZbQl8/ZquDyXGqCFuTO5v4yXi10mYwUKiZStpWJ77e7QsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=VcdpoK0M; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 7E00916020E;
	Wed, 14 Jan 2026 18:56:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0LT54JMEynrDdlo2zeOfcrf07/x7ZdSaCC3Q43hioE=;
	b=VcdpoK0MRDzdQT2LpFPvTfpCgKJu7Ld4xGo3djjwcpgTbICGXts6CDdKvIIq+a7ovdxk1E
	e7QallP1I+auyuOeCHEzIK9+VZBteI73pAQk5cfULdd1xQDSOl13WYhCnzRx2sMo5U28dQ
	GzcmL/jAwtbdH+pJthlBc4h4H5WzwTKvhKkUKf8zx6F+e0MsAmtjok2ryncfzUIj3qg5ux
	V9uMF9oC4Q4LAXwMJc1/xfeRBmY3kYU9Jhk0wSS54s1OweOJFvA6IW7FADv4tU4ZMQeQUk
	i7Ys5O2nFTvxBUMQcjp4WPRUdwHaCPF18NiOuhWiQGypaZrNB7ImZR/fjJg83Q==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:33 +0200
Subject: [PATCH v3 04/13] iio: pressure: mprls0025pa: fix scan_type struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-4-bc7f1c2957c2@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=XOIcrgqwLdbh/uSw9m3W8n4ERWUbOIAvlIxQ8mKmptk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXAyQ2JUcDZ1Uk52OEY1cWVpb3M5VUl6CkU0VjNtSk1TempFNTF2NHFl
 MWRqQ1lrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cWR
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXlIYg
 pELzl3S2xvUTBYdUhudmptVnN3TlltTXlBWFBBa3RBaE9PZVNhcWFRWTh4UnltbDNhV0pKUURCN
 kZnOHhWSGlYCmF2RU5hUFh6YkVhRzJvZFlKVEJZQTdqUkVpa0xkMERHc2hXd0J1MCtYTU1NREcr
 TzExZUp5VFA0RG5JcXFVZ2UKZ1g5UVRUZDVWV2xOUE1rT2dWZDJyVnFJNGJDWlo5K2lGaUp5dGJ
 lNTVIcHZVN045bnNJa3Y0WWVLVjArby9neQp0Z0w2NUxSL01WaHcwc2dQZXBQUGEzV2p0dk5Jb2
 ZzNGRIaXVQYlRUV29USWtqeTZmekhhdVZPZFk3VVFOeWs4Cko4YlhrT1FiNUlWRVZHUnBqRjRQW
 UkvNS9Jd1AwSDRXWDQ5NjBWWUVVZXNVWnNEbm9BRWdYSXhwOTgvVjhzb28KamdOTzF5aFlUenhL
 SFh1YW05d3NMeE5XRlhBOERmYkhzWExpUVZFYVpkUndEdTgwcXArRTFIZjBLdGhWSTVSMAptR21
 FT3ZmRTh1VHhHMVRtcDc2OVFyRnNVVjM4bjFUc2VtK1ZzTXJiTXNBMklGSXZFc01lQ0FzOEZSYn
 BGWnBjCitqWlQ0ckNQQXVRR3d5SGJocHVCSHd1ZTI4ZFZic0FUcWdPMWpndjE5WThyalNzcDJBa
 2VQcVlWMzB0RW9hK3cKNy9rQVVjNmtDL0MyeWVUZ2VWTGxBWGZxUCtqVTFxRGsrdnF2ODdPdHZ5
 WXMxUXM5eGRnNmtET1pLVFdPWkxqOQpTdzFUaGdGYUcxbTBBRFBhVGJueldrdDVQdkxXZVpuaFl
 odEZoUEFLTGR2L2RMTXRqTjR6V2cxVDV5RmxGUC9oCitSNXJXZkpIcHNZMjNGN21TbUdwVkFvaG
 srTEhSVittQkd0VlhPclZTQms2MlpCZ0ljaz0KPTRNa0oKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Fix the scan_type sign and realbits assignment.

The pressure is a 24bit unsigned int between output_min and output_max.

 transfer function A: 10%   to 90%   of 2^24
 transfer function B:  2.5% to 22.5% of 2^24
 transfer function C: 20%   to 80%   of 2^24
[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 }
[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 }
[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 }

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no change
---
 drivers/iio/pressure/mprls0025pa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 4b23f87a822b..6ba45d4c16b3 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -160,8 +160,8 @@ static const struct iio_chan_spec mpr_channels[] = {
 					BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 's',
-			.realbits = 32,
+			.sign = 'u',
+			.realbits = 24,
 			.storagebits = 32,
 			.endianness = IIO_CPU,
 		},

-- 
2.52.0


