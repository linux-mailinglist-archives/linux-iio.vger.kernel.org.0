Return-Path: <linux-iio+bounces-27745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E496D1DDEC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60178309FF59
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48938A725;
	Wed, 14 Jan 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="B7PSLGia"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944A318B8F;
	Wed, 14 Jan 2026 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385272; cv=none; b=q8yV8h9XbDyzDjU4nflkQHpYlnNFP5t44YdTGmh0VxTuoDIquK4GUxz3hG9y+Xs184PQ4kFaC3dv7vYEUq3Jxlh3NecQwCdrg8A7InpnmfRUM3FepkL8+vfwcOgIbhNdfmzGTgfBHesY/QX5ZiMFnfPhEXAZQ+2NeV88ijghNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385272; c=relaxed/simple;
	bh=MyBYpvbNZRKGwZI1cJlJc+nir1EyYhuRUsV6herZGGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAq+PmJ/uuv+9kQ9QGUDL1+L9IwTWjkRBuhIY8Hw6iiLEcFarL+56Vonhs098s0ATVp9UmHv1emedYZoVm3z0auUm/7Cb3cMFuuN1aHZuheOJX161O09lFpM6s7ORc981FYWdXGsOdE9g6/AbR1GDDPEZ/lgwSbPkDd+RqztkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=B7PSLGia; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 3BF6216020E;
	Wed, 14 Jan 2026 12:07:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeK6GWPFkFLCqNfKgRvUtjvirqJYFfpQ7IuIEdpk9BY=;
	b=B7PSLGiaSicEjmyrrHR2//wpvumoPyCWujevGw1yVPF5jT8kECRJ7YnEB2C3I0fK5x26ki
	RWzwRQiazD3YH9AQHtsjAaMuZaBWdP4qpKl4c7UR+nYDedPbOfF5W4QMrq0EADwWaMbdJY
	XqkcEnjO3msXx/9w5ONf4Nj3qpKMXvf2QNiFjNqMUh/QZj9T9bTvqVh8m7KIz5+pUltP0t
	KAg83/VhdLbVlu6+ufWrhEXU5NtNHHN/iLL0ZQbjPho15mR98sHUiEB7CvYKg5g4QDS0+U
	zz7yyUxfvt3U5D4MFKP8zC8vlaYCZczmJOHwcBDRglZ1zhnexbve8fhN26fhjw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:38 +0200
Subject: [PATCH v2 04/13] iio: pressure: mprls0025pa: fix scan_type struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-4-5868b0045316@subdimension.ro>
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
 bh=MyBYpvbNZRKGwZI1cJlJc+nir1EyYhuRUsV6herZGGs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXRtOGhKcXZNTzkrR3BxQWtUNnVFdE96CjFpaUNpZS9RUzE0WTZ5SGlT
 c1NsRFlrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoyclp
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXpJQg
 pELzloZm84TnNmaS9aMlJhQXpYdzBzdkhZK1dUN0VUcFhwWW1ZeFZ0VHZLNFBzdkFJNVlsaExNW
 HNWblk4SmN2ClZwd1cvYncvNE1CL0VNcGpyNEtMRk1iU1RxK2lnTk9HUUJRY0V2cDR6V1k1dzlO
 Y0FJeFZTUVpsSjJVZHF1YXkKSDJsclRhbmtJekI1RHRtWklKeGpoeVlQZDlTK1cxeDJXU3Vqbkd
 heVIzSFduS1E3cjd2V3NhT3lpM3RCN0NiWgpPVHd2T3RESXJhcFQrdThkZTRJVDF0OU9WWlJlVC
 9RaldoamVuY0lVQS93ZWtCYW1lRWMzSE1wQXFBSlpqRWdEClZ0bmpPeG0vVFJzOFZwSnNTNUZQZ
 HNYZ2RySERXTXNNYkMyeVM4alRSTTdxOGlGU2hNV01MRHZKeWVqUXBPdUcKZUM5ZjJiRFdBTElZ
 MFdpZ3o2di9IR2VCNDE3Z2ZpY1ozcGM1SFBVNjlwSHhHLzVRY0FFOEhKWnNpUE9SN01BUAp3VXY
 3VDNtMDcvQkpNblhIaVBxNXBxMTdqYWRZdEZRYVFVeTdPNExjWlZFSEM3L3R0R09PTk1OSXNSb0
 pEK2FRCkxHMTYwcUo3UUh5c01RYmZHaWxNVzlUSE9LTE10OUpIUFBMUkJuUS91UEtYRVhWVTZjb
 2xFNnhBcnRjbEtRSDYKTlE4bWcxSmM5Z3Y4WjdBR2hPSmZtQjZDRVovV2tVbmtCdms1NFFibE1t
 ekRpQWttYTNJbVBPYzVlaERYS1o2Rgo4bVZUdDdxT0Q1R3k2WlBHYXprbjlvZ1dGMGZNY0djekx
 YZFI0aWVRZU1WYVlNcERjdTAxTU9xZlpxL1owZDVxCktkQlJvNStmTzd5UC9RQVBpMmJrTTB2VW
 Q2OW00cjBxNXE5WnY3UWo3ZHE1VloyaEtRQT0KPWtFZGUKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
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
v1 -> v2 no change
---
 drivers/iio/pressure/mprls0025pa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 80985c090aff..cec0bb3fc16f 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -161,8 +161,8 @@ static const struct iio_chan_spec mpr_channels[] = {
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


