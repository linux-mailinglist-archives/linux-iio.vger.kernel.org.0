Return-Path: <linux-iio+bounces-27994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C061D3B5AD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD71304421F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1738F23D;
	Mon, 19 Jan 2026 18:24:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B436BCE0
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847077; cv=none; b=DmzMdTq5VAUsihASWqx1Cq4HBgbW9rjF+haq38P3u+UaABN4qUZTeN7cF1fzvfcW6SURPh8aOAUY3SIrWH4WjnWrLAlY7CSpuJ+puBRDhApg09xdN/rU5n1ZsGofnIzPo84+QtsnkUATi+OLn8I/xoROZVfxtpNIu8w7X0WQZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847077; c=relaxed/simple;
	bh=gKdxgCeUIfsMv9ke4Upzqo22FIpf6SCbXM4wJZi9nto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEDbyX65moYMs38sSABU6hMMIIGqrwzFldB7HxPxU93BuJAKPgZne1njO1GFPxCwmki0JdJB/XGNj6ZGca5qFakHuuIC5eZChBc1Myq2mdAEkiKtSiCsuYByJZrUA+zBsihNgiq2drAmdwY9subiwzYrhJgom5aINSLC2i6OKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-0004SS-7c; Mon, 19 Jan 2026 19:24:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-001SUr-1Y;
	Mon, 19 Jan 2026 19:24:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvN-00000006y2f-2wCL;
	Mon, 19 Jan 2026 19:24:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v1 8/8] iio: dac: ds4424: document output sign and probe verification
Date: Mon, 19 Jan 2026 19:24:24 +0100
Message-ID: <20260119182424.1660601-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119182424.1660601-1-o.rempel@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Document that a zero output value is encoded with a don't-care sign bit
and that the driver verifies device presence via a readable register
since the hardware provides no device ID.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/dac/ds4424.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 13acb427d43b..2ccac674878e 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -194,6 +194,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 		if (val < -max_val || val > max_val)
 			return -EINVAL;
 
+		/* Canonicalize 0 to sink; datasheet treats sign as don't-care. */
 		if (val > 0) {
 			raw.source_bit = DS4424_SOURCE_I;
 			raw.dx = val;
@@ -213,6 +214,7 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 {
 	int ret, val;
 
+	/* No device ID; verify presence by a readable register. */
 	ret = ds4424_get_value(indio_dev, &val, 0);
 	if (ret < 0)
 		dev_err(&indio_dev->dev,
-- 
2.47.3


