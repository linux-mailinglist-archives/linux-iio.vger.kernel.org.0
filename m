Return-Path: <linux-iio+bounces-24072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B44B561EE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506FA1B20461
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDE2F60A2;
	Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="WHB/gfCo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F62F3C2B;
	Sat, 13 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778018; cv=none; b=nqWnUeO60ZqZZXcsyEFUgvXc1QN5lDdj4GzmQqRyO8rg0JXClgEBbdM1g6JYVAMPmXJRuGq/uqlkYJzSu4JwvO2DA84AJLEgeIUvWlCNMamAvFuQocg+bmR9S3HtGh2aqesMYDskTK8uuEgaepKgt8ajduV2psXdkH/LVA+rBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778018; c=relaxed/simple;
	bh=tsNoPlCjfCHiEb2p/pYG4XMVMYkOUsEoLwtLAurz5Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVsM3KUGSvgYgngRX0D4mH1giNSlulabm1cn4vzOqhVJm9Uq1skkR9GSD0W9tUylzskE7rTiSiUIWcm2iGCRdRVtOgOuoQASUSrPt+iAepD8iydBGBivM2PDObq/LyhuvIrPqgmTE9it0SPboVku2KFt77OCNHqdBY4I1rK7abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=WHB/gfCo; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 704F2173BF4;
	Sat, 13 Sep 2025 18:40:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmmoCj8hbGQPagAoUbSHrF+wWVL1+DK6FSTPzmGgS9M=;
	b=WHB/gfCobYGlLWmQKKpFEQUqvJAHHs7By7E4keajxOMPRvFUyAhM/XqdjEYFfLgIXECkE/
	VcRsqRYO2W6YEWyWZLdn70perRbVDYgL7aaNn0kCCP3aihhw1guM35+5qP+GBkEEaK9IuV
	VSnFYfrS6bg7xAyiRW219WC/tFRtQuwA6nXSwn1h5vaWumnIWId/iPegLfUegIjCroKwUP
	UI9ecuGM6AKRZhtt02rAMY7hyQi/cksAxh+NeNWp/0HMDWc4OAlMl+RVEXo8Kl2HEE1yNN
	w5+kJOaBZrIY0y9i/gEx1Wsw4qw6qwcc4H8khuAo54+iopr0fpkOdRmnurpB9w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:33 +0300
Subject: [PATCH v3 12/18] iio: accel: bma220: use find_match_table fct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-12-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=tsNoPlCjfCHiEb2p/pYG4XMVMYkOUsEoLwtLAurz5Co=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSpXLQwhPkwg79mrQygW8HoJ1Kz8FUYwfTf
 A53ziVV1yWJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MELXD/9q+GKQHki7d+HTRcpltvJFo/jNxUtSG78UwhpsiGjUyssUQfEE9Stt/THb/F3AOB6kMy0
 AnZDrgqwfxppD5ZtASIo+6oB21yoqriXwSu/VIy43CKFl1Tdmo5yd2wj2zYX5ha43RUyAKeaW7u
 keP/vdCPYnsJxkNdFlsbjbe03DRKaHj0qjKhLPTpvNsYToL57MCqj/hjZMj+gp7XZBW0C8TPj5n
 rT2GL9sZrTA0/2l197mX85LffAzWiXDw+G8cNWUq+W1y3jent2UG4Ze0THRoWahcNrHtC2IWn5z
 nEzKzVf9F1srFmdXQ3+4aFGDa14ttMwYuHYCBMi6U/QLlP7l0aPjv4j1XxnnUZ/PA6Io+tA18e2
 sRmTrDUsj/SZ1/NFdlhBq4UlMjVUpIC0Du2H9RuppSYbN2rWFPI6ZyMredX6o6RAbFxIj0oiZaB
 RZYLTUxrvSZbct/NrWO8mVsQfL18p+HsiUVlW0PHfUBsBA30cjkx23XvFHJFCwVYw25NsE6hCR+
 gaN/uGYJ7AlCePmK1Ke8/ehMer1/NxUWE+hjWtpPCWFW7Lmd5PepwmWszkW8DoTC1rs7lHVMFB2
 3c7fLG/KWNvPd+hcOnnUaybL3DoYDFZkgRhMyPgqVkGfBwIJbMKZZm8MZJOtbk4736OZYIhljoS
 9SkovY82GgFHcyg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Clean up the code a bit by using a find_match_table function.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 split out from bigger patch (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 728bf08c2cfb250266be56e69b11af4b6c4a1347..3252fb2d7fdcc84431ef19f5dbac8be01060e036 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -221,11 +221,23 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int bma220_find_match_2dt(const int (*tbl)[2], const int n,
+				 const int val, const int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (tbl[i][0] == val && tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int bma220_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	int i;
 	int ret;
 	int index = -1;
 	struct bma220_data *data = iio_priv(indio_dev);
@@ -234,12 +246,9 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
-			if (val == bma220_scale_table[i][0] &&
-			    val2 == bma220_scale_table[i][1]) {
-				index = i;
-				break;
-			}
+		index = bma220_find_match_2dt(bma220_scale_table,
+					      ARRAY_SIZE(bma220_scale_table),
+					      val, val2);
 		if (index < 0)
 			return -EINVAL;
 

-- 
2.49.1


