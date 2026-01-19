Return-Path: <linux-iio+bounces-27990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4466D3B59C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43F0B30022D7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526012DEA67;
	Mon, 19 Jan 2026 18:24:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FB365A02
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847077; cv=none; b=Ng3DbWGJxgRkvewvt9FbOJz0wdOAmSSw+80Ve98r66a+6PNsqW6QqkM4+Xa5ZaHFBu1YvOsKjj7O/BCRRib+hlJNCDZVEbuUC2+MddZ5rwMTxyNWpqeMjsWpl8dFML9LjA13b70caVu8424Sa6M/85lR3SGksovJ4X2y2zdfGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847077; c=relaxed/simple;
	bh=Vjn6/7sVL2PRX0fnsG7PEGcF6n99+IlYZKmpZI6Qq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJzAiCMITDMAc1f9GC/q6K/uodoswkZVLw7rTV/PBRgV6L+1rdl+VkxA4aD9lQR1HibogXNdCEHLMKKCCoNtKfpalxhG7Jv8eruycpRFmp/M0VfLLI9iw8sMnu+tJurALh/ilP06noC9PA7tQu7U+R8DiXKaVye3oL/EnlrL6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-0004SQ-7b; Mon, 19 Jan 2026 19:24:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-001SUn-1R;
	Mon, 19 Jan 2026 19:24:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvN-00000006y2J-2lo9;
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
Subject: [PATCH v1 6/8] iio: dac: ds4424: clear outputs on probe
Date: Mon, 19 Jan 2026 19:24:22 +0100
Message-ID: <20260119182424.1660601-7-o.rempel@pengutronix.de>
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

The DS44xx devices have no reset pin or reset bit, so output registers
may retain preconfigured values across reboot or warm reset.

Also, the driver suspend/resume path restores from data->raw. When the
device is first probed, data->raw is zero-initialized and may not match
the actual hardware state. A later suspend/resume can therefore change an
output from a preconfigured non-zero value to 0 mA.

Initialize all channels to 0 output current during probe to ensure a
deterministic baseline and consistent suspend/resume behavior.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/dac/ds4424.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a0c60eb89717..2d299a52cede 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -220,6 +220,20 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int ds4424_init(struct iio_dev *indio_dev)
+{
+	int i, ret;
+
+	/* Set all channels to 0 current. */
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = ds4424_set_value(indio_dev, 0, &indio_dev->channels[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ds4424_setup_channels(struct i2c_client *client,
 				 struct ds4424_data *data,
 				 struct iio_dev *indio_dev)
@@ -397,6 +411,11 @@ static int ds4424_probe(struct i2c_client *client)
 	if (ret)
 		goto fail;
 
+	/* No reset pin/bit: clear any preconfigured output on probe. */
+	ret = ds4424_init(indio_dev);
+	if (ret)
+		goto fail;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ds4424_iio_info;
 
-- 
2.47.3


