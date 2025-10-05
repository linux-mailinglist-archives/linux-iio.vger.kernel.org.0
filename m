Return-Path: <linux-iio+bounces-24747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C450BB96BE
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE243BA2C9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B128A1CC;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="joS7s66D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D15287505;
	Sun,  5 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=mxJOSkWdLpyu9d3ToPpUAjf7U3vRTknB0Oi2MNtRX/wGoj9bnz3Lwy5fzy3XLGNTpvuNrM4bMPwdDD0rJi8FCc1WiZGSDr5iDGeLAun3FTUk46kWofLRfz20yQkecbLzvtawUw97SSLJQcoFAM9+qHfJEB76SvurV4acojG4OB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=NK+OVoMg3HwVpi5UC0omZz7JzNDOklhW7hbKH6XaTbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdUsrfsOzU916A6tkokdsnK4KSTBeGijf0rR7djBCiNaaKZje+GgODrScamJjI0d9fR2SIeu2TKJ4lfNJLnCVwZ3WnE2kbedTM16hnz2d76YpYXw6XshigEyCa0a4i3Xi3CvqYIxkU952ZkLgRxtC1qFuFtQsance1lNShuGQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=joS7s66D; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7AC94173BF4;
	Sun, 05 Oct 2025 16:13:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8Ndz0LJuGnEylU2rvOMSC7o8y9spIn/Fg/srnTHOLM=;
	b=joS7s66DpnYVQ4dtiOGV6fDC6BVHVEIZIpmpgu6q/NjUK+pdtm/gkZUQVnnXADrc3nExdK
	MoiSROqKwN8nFwrMjP4qYJ9gex6SUuss1kUoHvuDFI/6OpAsbBBq9mEsiZyi3Jx4AR66q7
	B8O8MGOG+AbAAZsYN8u1ZKH2wbO+egimceLFKjZlDxD4cLDWY3XaS+gtjVbANkBour5+rt
	1zmtaZHyZcSpZvpdJeFtD1QVSXS3/PcGp5RcIP5FG7UCIWQXx8WT53Np60M7deZ/7ltypF
	qXAjD33NMpLfkV1AOWQdZhP2CqwKxfbSuT/DWXFOgOfji8CXHxR86wIJgOa6EA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:21 +0300
Subject: [PATCH v4 12/19] iio: accel: bma220: populate buffer ts in trigger
 handler
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-12-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=NK+OVoMg3HwVpi5UC0omZz7JzNDOklhW7hbKH6XaTbs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnNqWjE0ZDROS0NnaytPdXcwNndxQXFqCm1VN08vOFFraEIrTkd2MG1X
 N2dSNTRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN0l
 BQW9KRUhRcko2ZGpPa2xqZE1BUC8yYVc1NFZCWXo0Tk5ZYnFyWWZaZ2Q1c2NadUF0TXk4SnhCMg
 pGR1IrUUI1TEZBeDZ2bnFpbFFzbG5PRi9PVE5RbzNVSTY1ZkxMKzVXYWJ6aTBaRHgwSFJ6Nlc0N
 nFJMXVLbEpUClBiRnZoVXNFdFI0MnN3d3lTeWhpNmpyVlMzdVc0WHVnN0hJNHVDYkd4VjhmdDdJ
 T0E5L0Rja1U1S2k0Q1lBOXcKLzFyU0ZmRFloWHM3US9JaW1sVFp4VEY4RDArMEJLWC96OCtCTkh
 UR29SQ3k1RytYd3QwMVBFOEl3N1NTWndOdwpWRGYxSGQ5WmdFa2ljL1g3VTdOWS9tZXh3RWhiL3
 dYR1NLRS9Ja0EveDZrOWVwUVd0SXVlNWh2b0toVk5pT3VDCkdMM2NKMkVXeVRCTlRuZFdkRDIzY
 2xTdWpLQVh0TUZraFhtcmJiNi94QUtmdnk4VXk3ejRFOUFuMFBhZ3lUQVUKQkNwTlgzVUt3V25S
 VlZWOHV5SWhKb0YvSWd1bFBGMDBGMXFrdEZENW00ejhDNXlod1hIL0V3YVc2SUwrYzhlYwpnS1V
 UQnhKdTdNQUhkSnZMRVVKSFg0LzkzaHhkYTY3UmxrK0NyVEJNZkJCUlI1TnFSdlY2V0ZXMVZOZy
 9qT0t3CnZqOFBURmVNTnEzRmw1NFlYSEUyQlFLcTQxQmVmeDcreThHVWJoa3pnYXp2L3FTTHZmU
 XR3cFp4NHpxRUZ6elQKVUJ5VXpyNFJteWdVL3B0RlloOFc4Qzh5Ukg0b2FrRFVzL0hmbXIvamU0
 ZU9SaGdjR3NMZkhBR0R4cTUvRGpETAp0NGtRRlhnTFVtc2dRVGQvalVBVzRCbWFMNE9pVUFrK3h
 HY3lFcFlISmJhMXozT0xQR1ZrTkNJYXQ1MXdXdDEyCmkvdmkwa0ZndzdJWVBRPT0KPWx0ZTAKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Populate buffer timestamps in trigger handler since not all
triggers can run the top half handler that provides
pf->timestamp.

Fixes failing unit test that triggers based on the INT signal.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 split out from bigger patch (Jonathan)
v4 more verbose commit msg (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 7b1e87c6932a3a6698651e528fb8182c03a2432e..ec7409db83f81882043653cd70e3205500348994 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -186,7 +186,7 @@ static irqreturn_t bma220_trigger_handler(int irq, void *p)
 		return IRQ_NONE;
 
 	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
-				    pf->timestamp);
+				    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -404,8 +404,7 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bma220_trigger_handler, NULL);
 	if (ret < 0)
 		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");

-- 
2.49.1


