Return-Path: <linux-iio+bounces-27981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CDD3B3E6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF7BB30066D5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2B329392;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGxb4rOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1E31A7E1;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843209; cv=none; b=l5tZlSGpmvDdVRTj32NZrlvMoHvRNvRT9fa5VDFk8wf4x4hsywCM64FTcjBy59+SEmKEL7AfoK8czXxsDQOwzPyerGf0/s3XaMufa4LaSmGviOahyD1VA6pH8qLX+b2CvN6XXPW1l/h5l9kFwnHdI+shmrAzGmEiOaeT2s/t4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843209; c=relaxed/simple;
	bh=rG76RvhBOVOgf0yOJgNfSS9lji4ANp3koFBz9AaFvxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSXmv6/scfIM0zZ5ySN4N6LNIpszzPzUo9Cd315oFj6Je6RlMjsdCyymRzNiXjLZQWuEkI25ZVBQTlpUKTk/SL+AEaDJ/bDPGlplvEIXeyDQ//V+NVAqFOH1UPgTNrEfcJl0zLB0hvIpDp+TccDKDroKcPuKnPfhxVPkO8v1pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGxb4rOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BA61C19422;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843209;
	bh=rG76RvhBOVOgf0yOJgNfSS9lji4ANp3koFBz9AaFvxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZGxb4rOb5wJd2vmoaafqZ89eWXyXiOcnZayfQRckdVLM94roW9FL6aqM9lg5zhFe5
	 aO1RyzXVkDmoSXLvQ5wwqjM2gQRJuPpRyiREPsElAWOBq74J6J19WL5wQbJfGrxbIR
	 ODZJH/CwT0HGA5llgthmmwwsvJxpJJKyLr7f1lXAy2YKzK8uaPP0QJi+TdllwBgFfJ
	 wsl0eUkbxpfJXMBYyh2HBKb5zUvd4cbAt8w/Ks7kIDIhSes31EpFwpbeAc6uClqqyi
	 ZyYOgJnjJ6Q6i02CHvHC3PcZ4n15ihijWWzDdt8SL/4F82DmvxDzF2eebdyYvNM7kj
	 DXdwBU+WeXV1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04239D29C50;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 19 Jan 2026 18:19:56 +0100
Subject: [PATCH 2/4] iio: proximity: vl53l0x-i2c: Add optional vddio supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-vl53l0x-v1-2-cf71715a1353@protonmail.com>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
In-Reply-To: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
To: Song Qiang <songqiang1304521@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843207; l=2141;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=Z/oDKMbpkux1E6FCJwGZb5Lx2YWZ4LyLjJUa6LfMlOM=;
 b=SFNOISE7IEkxlXLbDRMMG0CEL2Csv/oRflzEaswxviZT9PR6ZHYPThjG0zTC02ny1cRCHVCRj
 ofxk87oieUhA1PsZymKAT3rmFmIJkE0I1MFH9TQGEU0bYy21az+XWUq
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

From: Petr Hodina <petr.hodina@protonmail.com>

The VL53L0X can be powered using separate core (VDD) and I/O (VDDIO)
supplies.

Add support for an optional vio regulator and enable/disable it during
power on/off when present. Update the device tree binding to document the
new optional supply.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47fa8..7bfab396377a 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -55,6 +55,7 @@ struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
 	struct regulator *vdd_supply;
+	struct regulator *vio_supply;
 	struct gpio_desc *reset_gpio;
 	struct iio_trigger *trig;
 };
@@ -256,6 +257,8 @@ static void vl53l0x_power_off(void *_data)
 	gpiod_set_value_cansleep(data->reset_gpio, 1);
 
 	regulator_disable(data->vdd_supply);
+	if (data->vio_supply)
+		regulator_disable(data->vio_supply);
 }
 
 static int vl53l0x_power_on(struct vl53l0x_data *data)
@@ -266,6 +269,12 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	if (ret)
 		return ret;
 
+	if (data->vio_supply) {
+		ret = regulator_enable(data->vio_supply);
+		if (ret)
+			return ret;
+	}
+
 	gpiod_set_value_cansleep(data->reset_gpio, 0);
 
 	usleep_range(3200, 5000);
@@ -338,6 +347,13 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->vio_supply = devm_regulator_get_optional(&client->dev, "vio");
+	if (PTR_ERR(data->vio_supply) == -ENODEV)
+		data->vio_supply = NULL;
+	else if (IS_ERR(data->vio_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vio_supply),
+				     "Unable to get VDDIO regulator\n");
+
 	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(data->reset_gpio))
 		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),

-- 
2.52.0



