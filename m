Return-Path: <linux-iio+bounces-3255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8D86E701
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AA01F29787
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7710A2D;
	Fri,  1 Mar 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5hgqv9k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D116FC8;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313294; cv=none; b=gwmxgE2vaZ+4dCUmJcFTdX3ZoKVtK6GypkBEpxsdwW8TKDFWjmFV0b2n99d/wjuNghEMoHMTDLj8xn0Bf3ns4TY6CRS9I1RCvVmOwA9tpXQTQ8B26H3jdgAwWQaLgvtf2jJhNMhzFK2qUZgqj8VKq7nPIdOZfcPoTIt/MtO/tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313294; c=relaxed/simple;
	bh=9MPZx7U6NECvNT+hg5zI2JtI2unkxN0TswH2hArF/+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hI9C62zNtrFkXHGcJ/bwrIwT5G1PgrQrT/ChL6si0Cj3lfpHPVaJsVE+6DxTRPDQNzyQY2CGUsCIZPFmKJlnSQ4ZdXuR3WOk+DxpvyF9KqwlaMfwkhfy/Nh5U5itEcZdxa71aBbWGXouwQ3LIRQfwBLuGSIoG6Weg1MsIzW+a88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5hgqv9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8926BC43399;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313293;
	bh=9MPZx7U6NECvNT+hg5zI2JtI2unkxN0TswH2hArF/+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N5hgqv9kax9ygIVvD5/K+7amrshqpGrdv/Zc7nxxCcJYfNOhs9lyTGtkyaAJKA4QA
	 SjYeOdO2IWRam4f37dOBRn8oIyB8j4vhzzP+2tQO+SQZ96yjD4j8HE6o3LZNpqWzp6
	 U1pbpBxphbv5HFAiG51VOtbxOWemGopdLGR/UiGOpVplCeJCEBtpxI/jglQLiEq2E8
	 va6a4U5QFwDGNqc4nRIvvzIYizL9E3P7kbEslcEJ8EE5fGkA+fKvGyPZOfU3rIo2C4
	 tx5HEfymWJPK7CT1ZMegyDic74D0SOKvWpNJd9zSXc7chSJt+LSrcRFWF179rbag++
	 G05sEtpWxW3rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F53C54E49;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 01 Mar 2024 18:14:52 +0100
Subject: [PATCH v3 3/3] iio: temperature: ltc2983: support vdd regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-ltc2983-misc-improv-v3-3-c09516ac0efc@analog.com>
References: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
In-Reply-To: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709313291; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2oUoUw4KkUIEscan+R7Gf4fDzMGadWsp8HmTiYX2GY8=;
 b=21Pd1s7jXIJSXO9pTvA5u5zM5BJEidLumUPfRe/q/BNROYoy6DMxN3avsGLLoW1izPTcdL3Qw
 +chTKG6yU7oBPc1HpwoteCkAzUr1tGP6nCeLApHIk0DMDZIT2ZM2mlm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Add support for the power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 592887097117..9fb547417536 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
 #include <asm/byteorder.h>
@@ -1581,6 +1582,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	if (ret)
+		return ret;
+
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);

-- 
2.43.2


