Return-Path: <linux-iio+bounces-10662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E39A0C82
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17171F217E8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9314F114;
	Wed, 16 Oct 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu/Fn0zI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10020C006
	for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088522; cv=none; b=jIu5E4SeCb3ZUB8fvjC7y756cJK/gasb3jULXRb/Ri6F8Oc3cNoILrYArV0kYx6TDGx5h99WHXJ0ECbGcVRMc8LE0DhEr6qkzpGlz4BE+vFomelyp0SMSFEERnivSeFIrJhAs7DTVc+2r0SRxxpXrB+1owx5E4L4t7BUZTEQsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088522; c=relaxed/simple;
	bh=7UX0WOZb0I8bJ0RJYNd3GaprHRSk5lvjIvfD+BiQSnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouaj/0PT7iV8sxSYt6APCjVg47dqaNm1t+zuo87iBQlckMGNlOjoPX1mK8jNmmcqFV0ZVmWKE3KdZcO2Xk4mV0tZ1l7HMP5JkAe/rRZAD2bovHAiQJpcafdyye2SroaQcR9AX8xr8vJIjIkPyLtoqF+7t5lXJhCGW9RPTQ8CNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu/Fn0zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 535A1C4CEC7;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088522;
	bh=7UX0WOZb0I8bJ0RJYNd3GaprHRSk5lvjIvfD+BiQSnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qu/Fn0zIkzDbcPfKHnbdDhvPt29242vTeC5oay1Uz+wORI9zW3tVICgPttU0K8FGV
	 MTsfQdYOL6bwwh9tpSQWxNmKIrhKY9VejUtHWJECuxIGSZI49XVPJeASKDm8T5D5sO
	 ChAMcN2SBmpinrTU1asgEEOGDHUe6wkvajIAmHGS9s301orrPd4CAVDdX2bZEDc+vt
	 SBg7ddCChEBCvUdc/ixci+44Nmcs+SFeccPemkGzbfdmlbyInIo76Qh1OdRe/XW6x9
	 iZLSnBJ+9hBGYjV81hps0FSOr7j+tt3js+lCW+vzcC4hkMQjFwML9WAbOx2qCZB6LJ
	 Gw8yaCDIV8W+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDFD206BA;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 16 Oct 2024 16:22:00 +0200
Subject: [PATCH 2/3] iio: addac: ad74413r: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-dev-ad74413r-minor-improv-v1-2-13c9c769237d@analog.com>
References: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
In-Reply-To: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
To: linux-iio@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729088521; l=2669;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jWsbLCxTUm/W19uTe2di1jluXpyIQzkCZn4CIrpSErI=;
 b=o1ytCpDTla7wfILFbxWK5oft0TJhYrU0CgFRdey37VvNztllXhr37TvyTg0gY286ptPai1UqV
 ORa4Ph+cWAeCAW3TKbUFeAtnHpM2jv/rEmPmuLeYlD6bfWYQmmJGC/f
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

It's highly unlikely for the converter ref voltage to change at runtime.
Hence, let's read the voltage and save it (instead of the regulator
struct). While at it, simplify the code by using
devm_regulator_get_enable_read_voltage().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/addac/ad74413r.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 550e2460e29c..cfe26a394465 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -60,7 +60,7 @@ struct ad74413r_state {
 	unsigned int			num_gpo_gpios;
 	unsigned int			num_comparator_gpios;
 	u32				sense_resistor_ohms;
-
+	int				refin_reg_uv;
 	/*
 	 * Synchronize consecutive operations when doing a one-shot
 	 * conversion and when updating the ADC samples SPI message.
@@ -69,7 +69,6 @@ struct ad74413r_state {
 
 	const struct ad74413r_chip_info	*chip_info;
 	struct spi_device		*spi;
-	struct regulator		*refin_reg;
 	struct regmap			*regmap;
 	struct device			*dev;
 	struct iio_trigger		*trig;
@@ -664,7 +663,7 @@ static int ad74413r_get_output_voltage_scale(struct ad74413r_state *st,
 static int ad74413r_get_output_current_scale(struct ad74413r_state *st,
 					     int *val, int *val2)
 {
-	*val = regulator_get_voltage(st->refin_reg);
+	*val = st->refin_reg_uv;
 	*val2 = st->sense_resistor_ohms * AD74413R_DAC_CODE_MAX * 1000;
 
 	return IIO_VAL_FRACTIONAL;
@@ -1351,11 +1350,6 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 	return 0;
 }
 
-static void ad74413r_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int ad74413r_probe(struct spi_device *spi)
 {
 	struct ad74413r_state *st;
@@ -1382,19 +1376,11 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
-	st->refin_reg = devm_regulator_get(st->dev, "refin");
-	if (IS_ERR(st->refin_reg))
-		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
-				     "Failed to get refin regulator\n");
-
-	ret = regulator_enable(st->refin_reg);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
-				       st->refin_reg);
-	if (ret)
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(st->dev, "refin");
+	if (ret < 0)
+		return dev_err_probe(st->dev, ret,
+				     "Failed to get refin regulator voltage\n");
+	st->refin_reg_uv = ret;
 
 	st->sense_resistor_ohms = 100000000;
 	device_property_read_u32(st->dev, "shunt-resistor-micro-ohms",

-- 
2.46.1



