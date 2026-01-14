Return-Path: <linux-iio+bounces-27688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E0D1CF70
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF0CF302FCDA
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104C37BE6B;
	Wed, 14 Jan 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="TQxxAPiT"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755172E7BB6;
	Wed, 14 Jan 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377329; cv=none; b=LhabnK1AWuZmtHJlv6cIBwYeJpvPAba+Qz7sBsS1REhX+Ogb9c/nebXWF8NCg2xVq4IJGUKyl8K+PReynYtGxUtCfaA/kwUHU+AurAWUbJpzLf/oekrzdOa4PIbSXHnQ5Tly6//Cqenht1LyQNTvMSC4B9kVYm0pvmJCTbab9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377329; c=relaxed/simple;
	bh=b5tlNjz/pW72IqhgkeZRT35OhNnwVKu21GrLirtBSSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OvHba09e3R4daiCapsj/Y1k41kO2hKBQw4r8TXzno0rUdc+YDDybOnC+8iLoKGcTCxATFQ7DxbEeTeufWag8WFTLSgYX2PIWYt/DjWD/3U6xOwsrT8zE2lhKacaoaS3w//e28h27ck+rmuXu5gYh9llya0AKNaOcHuj3qsFodtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=TQxxAPiT; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id BFEFB160209;
	Wed, 14 Jan 2026 09:51:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768377119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zU9uwfq7bgNvZu7k1gs3x7WhjiUXa64yiSIvSgJLu24=;
	b=TQxxAPiT656R3roYYBpRHUjLtMFG7ADNsK6qXxnkaCJDN4teYM+MquS8sIpiQKUxf6Fb6p
	96SVGcVTZyjloOOiXauligF5dodDrvpA9612F2/OM6buCrmdteOJZcZi76ZL9grodk5JFJ
	q5uh0vRZfkooA1lUovbkYilBcSx2AJV0Lb1xZr+1H0SAfs9n+6mLAbJX1056yOcEX8W+3g
	L32gKGQrTnq3P1+nhR3w89eBID6NvRyvZqujVeHTodVxDNvqzg9z3olVk4E0pMDsDd7qbR
	OS0AB4ugvhKRhKPqh16JauPrMLnwPVKz2ajMCaGUbaCKgrFN1Rap9XEelFsqRA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v6 0/2] iio: pressure: abp2030pa: cleanup
Date: Wed, 14 Jan 2026 09:51:36 +0200
Message-Id: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhLZ2kC/4XO20oDMRAG4FcpuTaSTE67XvkeUkoOEzdQd0tio
 6Xsu5stiAUNXg3/wHzzX0nBnLCQp92VZKyppGVuQT/siJ/s/Io0hZYJMFCcA9BpmfHygcfjwbo
 THEJOFTMdvRk1RualA9JuTxlj+ry5L/uWp1Tel3y5val82/4nVk4ZNXZA0CqOGsxzObuQ3nDeK
 j7mhWxuhXtr6FmwWUwJIweLPnYs8WMBkz1LNMsGAUa5NhT+bcl7y/Qs2SynwEo3aud6vdS3pRl
 nomepZjEplI0+CqbDb2td1y/LXu1A8AEAAA==
X-Change-ID: 20251122-honeywell_abp2_driver-9c796ef0c4b2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=b5tlNjz/pW72IqhgkeZRT35OhNnwVKu21GrLirtBSSM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuU3hTeit5VEM4ZHdPajN4R1FqeU1VdXdvCmlaQnE1UVBCKzgxTEdCaVlR
 UmNYUzRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFowc1V
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXd2Ng
 pELzRpNi8rb2h2RjNNQitSMUlFZUJhWnd4czI2K01PdzkxR1FnTG5tdWVjTzg5NFhPZkFmay9hQ
 kQ5TEU0Vy9pCjMrYXh1cENybG1TY092bVBVYTRJLytwVlRnQXh1d0lRdXFBdGpzRWVRVU16M3pF
 aW5rWm5PRmlIM2h1NGZwSEQKd05hYXk2VTBHaFdiTU04QXRpVG1WMXo5TnlrOEhlUXVKTHRJMk9
 FMURDQ0N0LzFZNU9hYWRwTExZVUd0bWxMMgpJVGhYdWczb3UyYk85Zk1wWk56SGxHNFcxUnpIZ3
 FiRWdBbjlBa3VVd1MrNUZzaElpSkxuV1c5d2ZJR1MyWmcwCmxKdXJwdEpvaHk5bnI5SG9XeWNLT
 kVmTjFJY3VQaTc2UGRrR0dRbHA0ZVZ5RzlvUXZWQ003bUptZm9oMXdMV3IKTmNQR2JVVm9vQVpK
 a2x4aWZLRkIvQ2xhaC84T3VDR0dzQnVEUzB5L0pIM2tJNDVWWHUzWVlzMFErRXdocVk5SAp2NFZ
 lcjBtbHpIZWFZWGc4ckFoSm44T1IyRlo1UFUraFljM3BGS1ducEYzanMwTE1KQUlNNXB4Q1B0T3
 dycHBPCjNsY29DdXZGZ0hXa1ZLUTlhcENVNVdJQm9ROFNwcHRLcmF1K1FQczY0M1A2N2k4RmkyY
 zczZmFna3VEV01IQzcKbU1LaXBNT2djNmN3ek1ZUUFKcVhON3lzWjFtYzhjdENaQXJ5MUdiaHNV
 SGVIOWdHRVZHY01GVENOUEtlY29FNwpSSkpoYVpiZG1XNkZmWWE4TDI5ZzVUV0F5RFhKSEpqY29
 qWEdjVU1iek5CS1Q2NUVZRFY3Y3JMay9iSzd1Z1E3CjVKMEFsaEpkZE1ZWnhvT0NBWVpYSFN5cU
 02c2pEY0N3c1RIYlFTTkQzOTFoSjU1eUt6ND0KPUx6WFkKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Fix one typo within a Kconfig description and remove redundant error message
if devm_request_irq() fails.

This cleanup series is now based on the testing branch as requested by Jonathan.

- Link to v5: https://lore.kernel.org/r/20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (2):
      iio: pressure: abp2030pa: fix typo in Kconfig description
      iio: pressure: abp2030pa: remove error message

 drivers/iio/pressure/Kconfig     | 2 +-
 drivers/iio/pressure/abp2030pa.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: e0bc6d7e258486c10bb11e31fd4421c134063b1d
change-id: 20251122-honeywell_abp2_driver-9c796ef0c4b2

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


