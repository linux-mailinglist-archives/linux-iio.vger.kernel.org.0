Return-Path: <linux-iio+bounces-5033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D448C4CD5
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557161C20A1F
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194B2C6A3;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK1Uo2nc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EB22611;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=dgp7Lng9vkMOHDPl9h14/9CEek/m/8AhF4Zgi7AoO95Tup6rqd5irGenDQDMQpHUFwjiEl/z7GIQyqydx3nEjoEYCk6HK8k3p+31fVerzbx0H5myQlSKo6DqJ13bXpr3uMkJQzwtnyRyefehN+Qnq3QkEU6AYBnXkvUVq37S+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=r/iJwwjlTmvF5IR+bY064hfHnkla7DJQglYzNY1CROw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRDaD4uTUnBrYL8tbF9YnCW2J3uG1oRQoGuaHL7zeGeu4uLpULe2M1DrciUuJAjrdgxSqK2Y8rosrWs6DiSX0Ot6rsh+aiaMYl4oIQG26Cjt6CMM3irOMAhFfnBZqui1QHkNuf6kkKWhsFw1I2iDHpOVBfCdNOom/RYpK2BGxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK1Uo2nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D89C4AF66;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=r/iJwwjlTmvF5IR+bY064hfHnkla7DJQglYzNY1CROw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XK1Uo2ncNP1zh6y3yjqNyh46mh//XVRSQuNMISE1inNWZnWWOy1AcLXle8HcJl1cL
	 iH0XRHBIF7We3ekhsuCpl/tQEegWvWZNuXouzjF3hVY8dnzET4918CkO8aw7dxJLjQ
	 Mvlm/8xQMAcMnNZVkI81ISiCgcaRpzeKVr4H4qHs8RsZR+RysbCjAJ9EtpdaGV9AiS
	 5MN0vY2VrnAXypjbF431VoT7Qrgz29i+3z45hToAVFaMc4ORnO+rM2oid6tacs0mbt
	 BMtvpsfxl5pb7IV/qNg2qLFvhP3PvhTg0iu0ZGlOGDUP6x/+4wXeKTTDfxvYZv2/BI
	 Z7qJal0ckf6LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75861C04FFE;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:51 +0300
Subject: [PATCH v2 6/9] iio: adc: ad7173: Add ad7173_device_info names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-ad4111-v2-6-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=1239;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=PqeTnj5w9/XrPfeAGecqWJITOQlmi0XSad6CyOICJio=;
 b=5EmB4s4xRNoWeii1HzRetU0NZrVJYr0z8L4RtClGtisPJFdo5sZtmdPDFdLDUxxzYyPeA0Qio
 ccQ28CIMpNXB0mTmg+X4S/OGoM3YwoBVgE4QS1NuSjrZFDVu11nkqeT
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add missing names from the device info struct for 3 models to ensure
consistency with the rest of the models.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 1e9ba3070770..d965b66d4d5a 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -227,6 +227,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
 	[ID_AD7172_4] = {
+		.name = "ad7172-4",
 		.id = AD7172_4_ID,
 		.num_inputs = 9,
 		.num_channels = 8,
@@ -272,6 +273,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7175_8] = {
+		.name = "ad7175-8",
 		.id = AD7175_8_ID,
 		.num_inputs = 17,
 		.num_channels = 16,
@@ -302,6 +304,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7177_2] = {
+		.name = "ad7177-2",
 		.id = AD7177_ID,
 		.num_inputs = 5,
 		.num_channels = 4,

-- 
2.43.0



