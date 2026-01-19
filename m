Return-Path: <linux-iio+bounces-27964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F52D3AC88
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896613054426
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C437F75E;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efAt2KMr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44120327783;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=CkSLJyNe4KZrnaKANbE8tzgm+RChCBOK+K+r0bB77QiZHXZcBIMkQ3OOf9ij4JOz4WVNJnQlaiULNuIq9b62GOABqpHp89CSwyi6jeKefBlMOomKdrdCEa1gEXtcK2dDb3PF5sxwDodNdBOXihV76eXj6jIDbSMgyREz7/zqRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=xPOhEhJe2siRPjS/kJC/6NA/KZx23W+i1g4sCUKpoFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHr27tcNbssPPJNELuG13JEhSg+HBP27UZ/MJDdQzKDfSCG5ZOgWaMmbm/zMCJ1vo6xu+YTkEY+A1DbJSHGShvGWtgYW5QO/YH3GHrXSgSpPcWya2eNXtg3rrtIWaFYNQ1lAvLf3s2Db/UT9YH7Sb7Kasx5doTPfRdwUmYbp29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efAt2KMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1394FC2BC9E;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=xPOhEhJe2siRPjS/kJC/6NA/KZx23W+i1g4sCUKpoFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=efAt2KMrMLppYw+4RUV62Ws4oUbimR8M1+HGWZZT0FMDaiHWxdH9R0nvd4qBDbwtm
	 61xUCKOOWiaOE91qqRt9jLvg04PVIESJK+vNj2B24TE0ksPeNIRCpGta5cLRCZbGBb
	 ITAAOm1ooevK5rPvaRBBs3MF+0oNpUeOR3U6HDeX1lP72DFRam545WxLAqjPzaIObo
	 DZqKf0JWVzqcML0vIUkZzyRPMNB2kIirSsq0yDRhx5FVaNNwdjjZ15nGXiAW9+2eNs
	 lCP9TUeaYG2c/NElbQemZ7l68FpcrJIfyL0MhWis6I+b/kpETlXzy+6RNT9qrPwdeb
	 A6OhTq8QNDMvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC9CD29C30;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:36:57 +0000
Subject: [PATCH 3/7] iio: amplifiers: ad8366: consume enable gpio for
 applicable parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-3-8044e23e964a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=1344;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=72lAxpPNNVQiH2FXV5I3I6t6Jbf3Jb9inxis9HKayGg=;
 b=ucKmp4HZErTKFi9sJh+JIsoCqsY/QGNLqSVg7QQSl32tUv5zhJtJfI4iCycjsyP6+xhAmBpXc
 FiUEq/SJwoOCRtUjswdfirRTeW4ZDJdyst3bWb6gfYCsq7yFgtfS5bm
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Some parts may consume enable GPIO to set serial mode (PS pin) or
powerup the device (e.g. ADA4961's PWUP pin).

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d06ac786501c..63bb9f0179eb 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -43,6 +43,7 @@ struct ad8366_state {
 	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	struct gpio_desc	*reset_gpio;
+	struct gpio_desc	*enable_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
 	const struct ad8366_info *info;
@@ -281,6 +282,13 @@ static int ad8366_probe(struct spi_device *spi)
 			ret = PTR_ERR(st->reset_gpio);
 			goto error_disable_reg;
 		}
+
+		st->enable_gpio = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->enable_gpio)) {
+			ret = PTR_ERR(st->enable_gpio);
+			goto error_disable_reg;
+		}
+
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;

-- 
2.43.0



