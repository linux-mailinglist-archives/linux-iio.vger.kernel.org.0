Return-Path: <linux-iio+bounces-27967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A25D3AD0E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECD11305BFD0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8C35EDBA;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcKDXOT+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE737C0FB;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=d/4JG/bB1AkIgyuBThR3yqUgSSH0Nl8gF5CmBdSvetZw5AGMxbKzMF9zhwwBvPAkIcnxNiW5hCEHPvL08uLtpnCNG6KNaaB+Ga6x8POHjI7Jp1FOtE/j4ak4jWuv3AL9HmI7LS1/zuoGPwBBEsIgdWfHLsKFQ2zYhylSrkLM7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=giJ6/VLbcxnk735dSuxazPN3skX6nOEAm+AhScCb89c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKYMfK6gOPymT1iN2UK6JVKRBwF7zNVKOuCsNpaTlQrRDnMp2JldM+JKMVRo9W89pEJR648Ch3QkyUsN11xl9iub0M9dL/SUwR007RR1EAWmN0fp6E/luV0+P9omiBYrRwCXfk/uVkWrqchZH6RUBe9+XvAsD9voKqfode57XI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcKDXOT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46B79C19424;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=giJ6/VLbcxnk735dSuxazPN3skX6nOEAm+AhScCb89c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fcKDXOT+XnsT17tUEjDfneiZgYtm6N7V6nc4rgjLTQrf3pHE/BDt6nVFyMZRmG4jv
	 XhKwTEdLX5MlyRB0QbInyYtPWtqnxHzr8KM79CCPzK1+wzZviBWtfYZV0S/KTybKeL
	 rXQCX1oK2zNkVFW+UIbV6ZatuHXqe1QWmYXufW8r3mL4PeqG27gMFPkp7o+7yuZ1M9
	 W5EqkYFSzkoOSoRkXj8i6vbDrLRcdIu9bMtzme2+wdX0FZD0w6/miorEmbbxDTowjI
	 NFFzUyGU/Vt9IT9GytDLkwTMUz2/3uXtmkHY+CW0QgXGMANPtOUxvPOEK9hKsfMRVW
	 RhmPkEkBGnvyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F9D29C33;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:37:00 +0000
Subject: [PATCH 6/7] iio: amplifiers: ad8366: simplify resource management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-6-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=4200;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9nMXwNgzXAopfdZluBjtYQNwc5lWj5QsLZXeSBRFTdk=;
 b=vUrAZJY0pjyhVmyviKaCRDU9w7phrJqDGahvMW4OAaA4iUXYlgQbCSKcHPbtWl6rxStJCxVk0
 kRGOfcfO1HGAgC5cyfUJMTaqFbYYwDkQeC2/7wkfKgB/lKRsbZA9TK5
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Device resource managed simplified with:
- voltage regulator managed internally by the device.
- IIO device registration handled with devm_iio_device_register().
- removal of goto's from the probe function.
- ad8366_remove() removed as it is not needed anymore.

Also, dev_err_probe() is used to report probe errors with created local
device pointer.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 68 +++++++++++------------------------------
 1 file changed, 18 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 26856cb4216e..d3fd8d44eae7 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -53,7 +53,6 @@ struct ad8366_info {
 
 struct ad8366_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	struct gpio_desc	*reset_gpio;
 	struct gpio_desc	*enable_gpio;
@@ -321,26 +320,22 @@ static int ad8366_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-	}
-
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 
-	ret = devm_mutex_init(&spi->dev, &st->lock);
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
 
@@ -359,25 +354,21 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADRF5731:
 	case ID_HMC1018:
 	case ID_HMC1019:
-		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio)) {
-			ret = PTR_ERR(st->reset_gpio);
-			goto error_disable_reg;
-		}
+		st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->reset_gpio))
+			return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
+					     "Failed to get reset GPIO\n");
 
-		st->enable_gpio = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->enable_gpio)) {
-			ret = PTR_ERR(st->enable_gpio);
-			goto error_disable_reg;
-		}
+		st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->enable_gpio))
+			return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
+					     "Failed to get enable GPIO\n");
 
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
 	default:
-		dev_err(&spi->dev, "Invalid device ID\n");
-		ret = -EINVAL;
-		goto error_disable_reg;
+		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
 	}
 
 	st->info = &ad8366_infos[st->type];
@@ -387,31 +378,9 @@ static int ad8366_probe(struct spi_device *spi)
 
 	ret = ad8366_write(indio_dev, 0, 0);
 	if (ret < 0)
-		goto error_disable_reg;
+		return dev_err_probe(dev, ret, "failed to write initial gain\n");
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static void ad8366_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad8366_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
-
-	iio_device_unregister(indio_dev);
-
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad8366_id[] = {
@@ -435,7 +404,6 @@ static struct spi_driver ad8366_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe		= ad8366_probe,
-	.remove		= ad8366_remove,
 	.id_table	= ad8366_id,
 };
 

-- 
2.43.0



