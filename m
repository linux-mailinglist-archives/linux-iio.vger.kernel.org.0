Return-Path: <linux-iio+bounces-24757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFCBB974F
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B143A47A0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB22882CF;
	Sun,  5 Oct 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="JJoXx3ea"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C913BC0C;
	Sun,  5 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670415; cv=none; b=HQqb7cf3gPhNWTQIebf5V5ZZaXsILEKiJPwaGhmocId3efReDMKnejjuw73jmNi8JsyFgF/5bidCRyDGnQKZWjxIiu3XO4mKFHXxjlP7FA1N+p/5miLGOJUZkPy+9Dag+RHk6fqD+HmvmJuFpUYO8R4YEt3qV0PwtDXokPzeEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670415; c=relaxed/simple;
	bh=SNhbxKclOKr8qZtB+edcMSy2LI4wWi2Pgm22C0Nbp+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gg45ha/PZnlFDtg5GLo1xmPjoxdMd1RJINumeA1xuO9AQNyCl3BbHjsLKbj7PfK79vYTpHEgSqPosFkhHzOXxLbMimYw9JJpESJXPCJG7UNOgWUzWWXNSV9pHAgjNfmrz3HeAAzm9Xzq1xDz1a5foiEbLXDFPc+1iuUCJhe8YIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=JJoXx3ea; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C426D173BEB;
	Sun, 05 Oct 2025 16:13:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pW6byNvJFW64sJMN/ca6XK7BnGpgRLCEvucnRjd3ONk=;
	b=JJoXx3eaZ5q8lIJquexTf/QLVQBiIDOG4h9yAiqUXYQLtmjtQrLhNKyhCIEAtgIy7zlqs0
	I1TwsFY/xI4SwLGEUw+m7jhchxFav/FHtJiTQwCdLRYg32q33NliTc49hi0uOSL7LYpyHF
	6nrbXDFsyOs8vkWp6Xaq/DOupEPxsiPNJkPmQaJtzjWf3RacLtS1Hyc5aD0zpOVOyRIJTw
	bt+DTr9DNRKft/jFx/MgXv8Fn3kPegZV/7ezQwEEv5zdZoXm5Vju4EakoJ7kAwmlfU6IhX
	v9AjsT3obtvH6UIq5jGHw5tFhVZz80S6cQAy7r/pHF211GQRfH5KWNjenjNUYg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:12 +0300
Subject: [PATCH v4 03/19] iio: accel: bma220: cleanup license string
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-3-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=SNhbxKclOKr8qZtB+edcMSy2LI4wWi2Pgm22C0Nbp+w=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnJOaXA4ekYrZ3RuSVNnZ05LOGNhZ2tqCjlnNUs0eVptbXFuODdqeUpa
 dnlLcm9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNnp
 BQW9KRUhRcko2ZGpPa2xqaFJ3UC9pTmQ3bXJwN2psT2tjczYwL2VXMlc0Vi8rRWNLM2Y3NDhwTg
 p6VW9KNnpySFhmU1BzS0lrMjZpcGp4c3dwMWpFOUxrR252Z1hzd3ZmYWhkOThvVWp0bFZvUGdIY
 kVZckVBQzdUClJrSFl0WWVnTFFxSUNrM1pISkIwbGFVbVA5d3N3M3E0c0V0ellNcFVnb3F4TmlO
 eXppQXlranBEVnZ2amh0QnAKaEVHdHFmNWNZQjRUcFJ3VGRKbGVpYVlyclJvdXBWQ01QamYzLzJ
 GMlJCbEgyaFRESWVBS25WNVRtZ0RBeDdBeApRbEZhOVdRemhNakNndU1HWnBIa0xLR1JoOTduZ0
 dna3F4UDUySklsM0dsd2hhbkNXTC9tTER5RTNVWkF1VFpHCno5cERkNWtSd0l6SzFCc2h0ZWw5N
 lBzRkpXTlBtbEdRNy9ETFJWcmdDdVNlZk1mMkF6eFlVdW1IOElHd3BiOG0KcGZpZHY4NXZKZVlZ
 Zk5BZGtYQU1HL0xGK09wMTgxeEw4ejRPV29pVXkrVEFMb1kycFVWejA0MXZlSUN4U3ZLWQpSa2Z
 ETWhNZTQ3c3BmYUI2dUQ4c0IrM3Q5VWdyWGY2RG8xaHBMdEh4VDQyaFF3alZiQUpacGVveE5yek
 dDN090CnZVT1c5NG85YndOSDluRk5uOGthRGUzRkpDbUFMYnMvQkFRVXdvV3NyZXB5N0xqZDh4U
 Vh2bjdXa01jWGZPcUQKdnFLbExST1JrVzV2MGc4WjQ3VTVzYXB3OG9KVWtMVUNIdmkyaEZMNmI3
 bWcvbkZPYVFBRDI5a2ozVTd2V0o1OAo1VUdFRXpKaWM1cmdLNUFjNkwxSVNKbWErcUo3T25yVnJ
 EWGROZGhMYkNEeHlqTUxSOWdGK1dlS2lJaWhpUW9CCnZ6UC9SVGdaNVdVbkZ3PT0KPWpwQTcKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Fix checkpatch warning about use of "GPL v2" license:

Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 - split from bigger patch (Andy)
---
 drivers/iio/accel/bma220_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 02ee6b4d51c0816a88ac258f0e5107111ec2a2bc..8c313debc1dff7f4bae7c165bc555ee190996291 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -332,4 +332,4 @@ module_spi_driver(bma220_driver);
 
 MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
 MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");

-- 
2.49.1


