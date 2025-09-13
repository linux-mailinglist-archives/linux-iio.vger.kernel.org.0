Return-Path: <linux-iio+bounces-24081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73007B56209
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151FD3B2373
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2852FA0F4;
	Sat, 13 Sep 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="4FQCto8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A32F617B;
	Sat, 13 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778021; cv=none; b=Kc0Q8ke2MMv+w2FJifGYfsQrHCUDT8oi769fbDkCI25FXdIpYBdPi7qJPQIuZIKk8UN/Qzhm4vFm7ijrJ8+mecOd4Tyjpdndb7DmO0tUJ7gC5Vn16uzsPbYohvt2Hg9tMTCxiPRMK2Ov8NUluUL2zOv+6AIlpaHKetjdMmIOIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778021; c=relaxed/simple;
	bh=5R8tQ4VrLnm2YLDC7B6YMclq3X4UjxnGUMONrZFEKuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8kCQ3av+wginl3f9b3w6+MVevVGO4zVZLOAUmBMF4IJ/dTyYzd1xcOC3pGyViiTzvY8K5ufMOqKwIVYFWp79lKLd2d3VQUpRM/QFgo2UHx+wBXx750Kle5xHeaHeqeii5BhLkPA/xLwuDTt+Wt2QFYPVRE9e5jC7ukvqBvxmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=4FQCto8J; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id CA8E0173BF9;
	Sat, 13 Sep 2025 18:40:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI2ikw6a7+Jm1RPvMDac/LhN97h9gT3N3OAW284tnt0=;
	b=4FQCto8J7IhuTeIFB7cyx67F8eUm+BJ0qz3PilM2zOY5dCf7A9KaDdX172Hj+EFmmZAKW3
	2iw/ww2HRzhxGX1Q6FAeUfBT3SL9/TDJdl94NdnH+1CqqXF8q8+yLltuz5Tvuybcht71Et
	VmCfALR4A11irvLbbvlRsbIOv5FeQ54pDt8Gy/hsGhD3tMECWMAt8t5JR6S8QHmn5QlIts
	NyGHczmJk/qiKGUW7XfmYuiYQ0L/bHFcbBEfb7var9ZQXnHAnD5MjxqZxDBZLi947d9CtI
	TgMzuw/7HEKA//shwHdTXoFLpF24Sa6Opv7WxXmfSFuRC8MQJXZi9zORhLrXhg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:38 +0300
Subject: [PATCH v3 17/18] iio: accel: bma220: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-17-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=5R8tQ4VrLnm2YLDC7B6YMclq3X4UjxnGUMONrZFEKuk=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBS0jcKoBAkrfTz5MZxWfqMEFUxLoKBZ/ZsX
 iWRBO4b6yeJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MP0vEACZx8aTN03Bo4A2F6QiQ0rOt3+E/v0RfFD4qcyxkvJkpIK4yTHzAQi3PYEOSjQCC8cb8aw
 jR6V7EcMhV35tw7HnUsLs7k23AVPadln8wBgSDdyV25gTVkMWxqQ9JlnZFokfQeSxxtX8EuhIFV
 +6Om89Vdd4TM8mga11juy5YUPTQCgPzU0B2PJpwYdX+faUqp5dmxJCVBeShuwY8eUUTN4dtwyiT
 uODRs6gfQxpWJetYFNz64wOrSrkRjOTKk3Yzyv7BIEaQbkCgNz5Kz7B/Yx+oI1jFlxSgzkfcBKt
 FcjaVXidYbX1gG9PeGYf0y36tSEaGxBel4qkCMbl4zmN8MEMWPbAmqBWOSgLlhxG2sHkN4bHZ5m
 vntDEWDgW2is4zIqV5ddApPvyp7BIExAVOw5l6y1NFZAYZRwhc5XuyLiQpyFcbQj+GBnPVm0S4w
 VNJnge97Lg2gTAEyflcOXJeOUAQGF+mFTsJeG62qT4M/EYlIsJdO2pXCogIWoffMtx/Qa/y9n99
 P7GYAHeMfipXWzo/3Pon2RvbeJA5922KxpfaN99qn2e/USDFMoo1RnZVHLM1X7vEPYWlxHELeIG
 6lbuGKyNFTF2bqX45D9igH2hcH6BSPfAIvn8FcoHM3bsVDPoHV9Pf1wU1geMAtLcadXVOxmejGk
 /CbGmC96D1Cmn0A==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Allow read/write access to sensor registers for use in unit-tests.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v3 no change
---
 drivers/iio/accel/bma220_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 508a1142a74b3fb330eea5222c4b0abc8fc37e49..9bc7a3023de76b9b519d2a645535f12bb42f6f15 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -376,10 +376,21 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.debugfs_reg_access	= &bma220_reg_access,
 };
 
 static int bma220_reset(struct bma220_data *data, bool up)

-- 
2.49.1


