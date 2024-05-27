Return-Path: <linux-iio+bounces-5360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160E8D0912
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E369B23007
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34A15F415;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKsCy745"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B815EFCB;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829361; cv=none; b=IN6LjmvMZvYi5S/bY76lkmhsbJV4C0WLnKQ9oDOBkh7TAXciuxErk/NQZ/Z2MZ+qcRkZscqQKlQOBwpttIsKk0TTmhfUhdK/eLkszYlJXqGVKlZEg43DjazA4Mhx/8yxIFEy8maZpwGZ813/RquoIgY+uF5xy+wyql3CRlG6Ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829361; c=relaxed/simple;
	bh=IqesYaWJl2yZZhdPxGkum2usAMQPnOzK+vkmI2bk5lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTDeIp79PaYO4zCXoyulK/9aZ9i5WHtF2DodxGxbnZhH6geDVxp2AuWxUKEzzRmWge30Jf/jRUEtAvYIFS8mvuRHMt6sGPyDgDeQw1bHFMo3YXP7oMdaXpD3Q3Cq7at7yoD/8s9Bu/3WXbK9A7fkrsIZBaHXB9EmFyqNJ7WS3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKsCy745; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05DF1C32781;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716829361;
	bh=IqesYaWJl2yZZhdPxGkum2usAMQPnOzK+vkmI2bk5lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lKsCy745O680yxtv/0mDMC1BXEsa3C7J/dDniyqQdABpfs+tFKd1f2c3ddCTiq+F7
	 C5HGf9/5HG5DmSvAgv13faMJZyd8rrA3M8IILbavsaOJgxyVnKc/TDCJXP8FpkRXzf
	 8ZaMXBAyV7Q7TD5f9dFgWKtbKZeWCntOPSiBAlcNSfhH6exIREcB1LCvFC7zwSrGaK
	 +NrF8zyZA8TfWPfWxXrSaxncVqsmGblKWcmCuCYs4GVlMzgUi6DxMTsRN07z7p1JsO
	 kCih//pd5ZMavLPeey56sQS+86xutCEXa2OBZo8zX/ynAR8xofy+aduTQUxFhIM2ib
	 6NM+LRSUSu8oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF660C27C43;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 20:02:39 +0300
Subject: [PATCH v3 6/6] iio: adc: ad7173: Reduce device info struct size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-ad4111-v3-6-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
In-Reply-To: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716829358; l=1076;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=i/3qfPHmc9/fJMS7GphA3tYcltv4y8f3THcKw3nnHnI=;
 b=oSmM/iCHqtU2Fbgfsws2MdnrTzKs8xA2r7xrX1RGY/f4pWMUgc3baXJjLPh76lfEP9jLgyv+Q
 wZCFDZRWSVDDFqbaVPfUz/FVnu+aTuBc8FU1MnaNEvsVH16Mdyk/qMU
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Reduce the size used by the device info struct by packing the bool
 fields within the same byte. This reduces the struct size from 52 bytes
 to 44 bytes.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 328685ce25e0..e8357a21d513 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -179,15 +179,15 @@ struct ad7173_device_info {
 	unsigned int clock;
 	unsigned int id;
 	char *name;
-	bool has_current_inputs;
-	bool has_vcom_input;
-	bool has_temp;
+	bool has_current_inputs		:1;
+	bool has_vcom_input		:1;
+	bool has_temp			:1;
 	/* ((AVDD1 − AVSS)/5) */
-	bool has_common_input;
-	bool has_input_buf;
-	bool has_int_ref;
-	bool has_ref2;
-	bool higher_gpio_bits;
+	bool has_common_input		:1;
+	bool has_input_buf		:1;
+	bool has_int_ref		:1;
+	bool has_ref2			:1;
+	bool higher_gpio_bits		:1;
 	u8 num_gpios;
 };
 

-- 
2.43.0



