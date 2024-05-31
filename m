Return-Path: <linux-iio+bounces-5561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D58D69FB
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA131F25569
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9817E478;
	Fri, 31 May 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSEeah8Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF817D354;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184571; cv=none; b=fkRPbflvfSMnYbKTlDaK+5k6X1jk+ie2c+PoteB40xgVs3zGlUWutQJv2mk8R4FHDo6UcRJ8I5wgOXp10Py4e2X1h46NSubxlEcIaIJPVOzqDLOhzW58nPnALymfkAD4F330VkdWGy9IGyft2adsOJEY/hQWEmusyHgxKcJrt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184571; c=relaxed/simple;
	bh=SPG7Z3QvR5evzT6qu+PUUSOfdaN8wsOF5rzy4+2fzwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjSAQqOhWdZg7AA8To4OiaXo1/LcnecGQQySQ2yAtHO+V/jo/cmeyVIJzLevonzbmuBykNOGqD01QwJb9eaYxnJDCRuZFkuyxz3R6BGp3pcb5Bvtd/0v3mxjh/Hh5YQULApSfmS0bheQetawYPBwvcy/0aTa8Izp17198/n9rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSEeah8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB3CC4AF13;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184571;
	bh=SPG7Z3QvR5evzT6qu+PUUSOfdaN8wsOF5rzy4+2fzwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FSEeah8ZG4pkcyWFvpV2mAujbQmDCa/SwGtP9K7cFH7zX3DUnHgR16dfHmLWCKcTB
	 6rBCqnS9FzdHtut6QrvFvDZpMwKLfSnVQEAwBJv4gf15QK5i/0OZCtZWtU6+tZnXx+
	 dBYa6nE1nXRsM9oc9c9YaUA/5cP04sYgHSRfgyu0N+hBJSaguakhRaXsV+4QntiSHz
	 K060ob1Bjtfp6iDArI/zyXUO0dtdlUd20Pffm+sUldYE+eA5eB/NapaEz0PjRRku9T
	 O/Ya97TcI99RXQnNjb+7mNo00TkoWgR8LUIRa4335wUfbWZU+bqdiXR0s/SLDiUhCT
	 KWQx9yjwa/s4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB1C25B75;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 31 May 2024 22:42:30 +0300
Subject: [PATCH v4 4/6] iio: adc: ad7173: add support for special inputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240531-ad4111-v4-4-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
In-Reply-To: <20240531-ad4111-v4-0-64607301c057@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717184569; l=3895;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=cB8o2kcrbEPNFNzCdWPShKZlvMUHAlRTNWGqJZsx23M=;
 b=1C5Nu3lQyjq+AULdmA9qCer108QWZ/p2cc+WRco1kxVyDtZc2kOVPqz1LELkzbu7DhXNB92Nv
 XFphNlajH7yAKq7ih96vrRdnywbKcNJhdoglIOpkoe6gjGmVO1rPSOl
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

 Add support for selecting REF+ and REF- inputs on all models.
 Add support for selecting ((AVDD1 − AVSS)/5) inputs
  on supported models.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a20831d99aa5..ebfd2d5f9632 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -66,6 +66,10 @@
 	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
+#define AD7173_AIN_COM_IN_POS	19
+#define AD7173_AIN_COM_IN_NEG	20
+#define AD7173_AIN_REF_POS	21
+#define AD7173_AIN_REF_NEG	22
 
 #define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
@@ -146,6 +150,8 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	/* ((AVDD1 − AVSS)/5) */
+	bool has_common_input;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
@@ -216,6 +222,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -230,6 +237,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -245,6 +253,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = false,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -259,6 +268,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -274,6 +284,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -288,6 +299,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = false,
 		.has_input_buf = false,
 		.has_int_ref = true,
+		.has_common_input = false,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -302,6 +314,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
+		.has_common_input = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.odr_start_value = AD7177_ODR_START_VALUE,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -918,6 +931,14 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 		if (ain[i] < st->info->num_inputs)
 			continue;
 
+		if (ain[i] == AD7173_AIN_REF_POS || ain[i] == AD7173_AIN_REF_NEG)
+			continue;
+
+		if ((ain[i] == AD7173_AIN_COM_IN_POS ||
+		     ain[i] == AD7173_AIN_COM_IN_NEG) &&
+		    st->info->has_common_input)
+			continue;
+
 		return dev_err_probe(dev, -EINVAL,
 			"Input pin number out of range for pair (%d %d).\n",
 			ain[0], ain[1]);

-- 
2.43.0



