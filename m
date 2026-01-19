Return-Path: <linux-iio+bounces-27982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0FD3B3E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C87D230090F0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DF329C69;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVMfdHML"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA3320CCF;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843209; cv=none; b=cCuxKd8nb1apLo2Um0CmxU7tx8UEnJhcAZwIcyfqylWf7k+zFDqfrhxG14kNQI7pPflnusbgRB6UhtN0OeFUodzxIfsnq7rRLQ1FtkSaUoZsWJxtJreNTPPMHDq1X3SbDMT1WTBH1LpIQ5tFNsPh5yfzvIkF7tmOlgKgif2/Lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843209; c=relaxed/simple;
	bh=qWbkmFUVqb1jkcEEsBWUt6AU2jPXhmoXkQv4QUYC574=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvMoZw3CweRBYuBuBtmey1d17Kfg+YqrqI+SCRaZTXFCfOEerXGv3xVqRfTzYGFUCYXrbHzeSAK4eNMDTnxSfdDXsnokRXe7y9hfDmaskNdn1a1VRMxKZfVUlgPoIp55ADdTuuD0u+/ao/6Toz14+C/Lr304UJEgO2vdfuMsZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVMfdHML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B6DAC4AF15;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843209;
	bh=qWbkmFUVqb1jkcEEsBWUt6AU2jPXhmoXkQv4QUYC574=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jVMfdHMLiE2ZCvuCYGmwRYYWFFQNxE+kyPIL4Ilf7YelCJjbLiB9ewZPmxFPQ792p
	 MErTgucT2XB20upP4Qr1NJV6vaGr/6GP5wtvcAR6cEO2Cz98MVTrkgnoo4jC3XiXVv
	 7xI0mUT4sHMtI6mOgH7wfki7Q3ku+0Mh7NB9sEZ+uuh9mJVOvtPSrXYmFnw6oAl1/b
	 PTHSsyVQcwWqMnkDL6VSIMoeKkYNfYWhqaip1nGevFazxFDAUUZqZGUTD2p5gK0D3R
	 CdWiYOPchYypO6D9I0fCBzbQC9YjabzO6GDuoQOy8XpgJrmTfK0zspPazbahJQqMJ5
	 /QkilVxFbxDgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21996D29C4F;
	Mon, 19 Jan 2026 17:20:09 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 19 Jan 2026 18:19:58 +0100
Subject: [PATCH 4/4] iio: proximity: vl53l0x-i2c: Use raw I2C access and
 read full device ID
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843207; l=2915;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=d+hR0F/bDeIjVeoY7OePEyZl2RADxLrlf6OYgdsANok=;
 b=0kzauao6M0YQ7pPlLk4mUBIlnjb12ECy1EXuGr6fNc/b4+2imVy+PWaKfasHv0iuQbXkvcSZV
 JJ2fmLulcfoB37cVPj1OtwNKTlsMdbV31tGmdYZECrPZbAn+HluMrJg
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

From: Petr Hodina <petr.hodina@protonmail.com>

Replace SMBus byte reads with raw I2C transfers when reading the device
identification registers.

The VL53L0X exposes its model and revision as 16-bit registers, which are
more accurately accessed using standard I2C send/receive operations.
This also avoids depending on SMBus byte data support, which is not
guaranteed on all I2C adapters.

Read and log both model and revision IDs, and validate the model ID
during probe to ensure the expected device is present.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 45 +++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 6901ce7dd835..a2de4cc16a43 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -320,11 +320,35 @@ static const struct iio_trigger_ops vl53l0x_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+
+static int vl53l0x_read_word(struct i2c_client *client, u8 reg, u16 *val)
+{
+	int ret;
+	u8 buf[2];
+
+	ret = i2c_master_send(client, &reg, 1);
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EIO;
+
+	ret = i2c_master_recv(client, buf, 2);
+	if (ret < 0)
+		return ret;
+	if (ret != 2)
+		return -EIO;
+
+	*val = (buf[0] << 8) | buf[1];
+
+	return 0;
+}
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	u16 model, rev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -339,13 +363,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
-	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
-	if (ret < 0)
-		return -EINVAL;
-
-	if (ret != VL53L0X_MODEL_ID_VAL)
-		dev_info(&client->dev, "Unknown model id: 0x%x", ret);
-
 	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_supply))
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
@@ -372,6 +389,20 @@ static int vl53l0x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = vl53l0x_read_word(client, 0xC0, &model);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to read model ID\n");
+
+	ret = vl53l0x_read_word(client, 0xC2, &rev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to read revision ID\n");
+
+	dev_info(&client->dev, "VL53L0X model=0x%04x rev=0x%04x\n", model, rev);
+
+	if ((model >> 8) != VL53L0X_MODEL_ID_VAL)
+		return dev_err_probe(&client->dev, -ENODEV,
+			"Unexpected model ID: 0x%04x\n", model);
+
 	indio_dev->name = "vl53l0x";
 	indio_dev->info = &vl53l0x_info;
 	indio_dev->channels = vl53l0x_channels;

-- 
2.52.0



