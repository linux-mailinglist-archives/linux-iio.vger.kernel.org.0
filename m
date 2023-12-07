Return-Path: <linux-iio+bounces-711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E5808804
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368021C21ED5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2A3D0BA;
	Thu,  7 Dec 2023 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8ZX9hkC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AB3C487
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E831C433CC;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=84rGSUhGu8nxNXK4h2gLMdKQfSceGnZ7XPEmGa25Rww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i8ZX9hkCJ1V0qEv06Wt5bn1aR/e+f8BicJQ0uZAUf/YekllYdmyEVHX/c13JFK8S7
	 WVMqUDKm6893P9oq6dOx4Iwtd9jF/meFAWn/F31zrEPvl2wNAaj70EJMWxrjKl/b2z
	 +gOffEhd2JHms61I9YzkvbeAp9LeSovCBIUB1RZKwKgwGWr+YWuFXGenLi4Q9lDE6H
	 9LLAX47QjuhexI/RXIh8fMq82+K47Ouvkdm5z6MWVpqOlJm6Pj71uAtjk/2VJg7EgK
	 njADjlwwrRsTg2GEBOUFEJNf/tpKHl5vjTNLX31GD/1GwF94bPq8rAl7d167xbIRE0
	 XhgKOUG/aP0Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EAC10F05;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:28 +0100
Subject: [PATCH v2 5/8] iio: adc: ad9467: use spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-5-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=n8Aav+VNN3B3YvMoVVGj82oY7GjyH/2D22CiUso8SJs=;
 b=92eEHBFLYZLpD9IC+HfCn/kfBeLmDxK0ICY5k4AUT6ZijpYMfrIQKCbZf96E1E9XQAmX2K0V+
 BOORfBP/YzwA1htqdTrbFkuLNfkHtFpYxMquthmK5W9BLpgCwt3D/c7
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Make use of spi_get_device_match_data() to simplify things.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f668313730cb..b16d28c1adcb 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -454,9 +454,7 @@ static int ad9467_probe(struct spi_device *spi)
 	unsigned int id;
 	int ret;
 
-	info = of_device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info)
 		return -ENODEV;
 

-- 
2.43.0


