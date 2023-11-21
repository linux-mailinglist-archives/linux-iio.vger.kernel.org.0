Return-Path: <linux-iio+bounces-222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF47F2A07
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899252821D6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F83D39A;
	Tue, 21 Nov 2023 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lntgOrf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79333D3AC;
	Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8A5C433B6;
	Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700561839;
	bh=9VrRKn1T4nW7pywpPWHeJW9v+K02u4HC9bddai2LGIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lntgOrf9pEnmt1kBeSd1mEuOCJN9paZeKsT3jK8wRZVPLhqIbSMwiTYMe/U9HOPwc
	 zNnmJjyDvY5mOpZ92z2Kkx40eIPuks4mwBGpdIBqLAOrOyBuHk5+80mqR3TB2QtKsi
	 Vf5Fkke9TC2tqJYeJSgXO4+2jh8HxjWc+Vs2AZo769nsEf6Py80lcz95hZJ/nWiLVY
	 b7PV4+JxiEBNaYak7HM8YEBK+KWQqbF17mx9tWFEmU2B5a/4H/z0hfe2GJ86uhbqtq
	 z/D0wuyH26STC4e0nOa42Jt7GzGCvNg9zEmjlVcjLQse2/wzB781+XOu6MV0BgqV9C
	 1EpPBux/E12Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED7DC54FB9;
	Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 21 Nov 2023 11:20:21 +0100
Subject: [PATCH 08/12] iio: adc: ad9467: use spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-8-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=686;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zYitHUb6TMLk+FkB4cL0ig740y1mLs+DvRMVWPrSNF0=;
 b=bXWJ7iE5iGJrgtGP5xd739Rr7ggBJOq8O9gdmWl6WbsvAQnU0yaRoF4iISJY3EzpfGMuAUAIN
 4AltcqL8Q1WDNvkTtIpIqq0oGoY4BjwJS5R5b8uMYVJRnq0B/qzJQbm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Make use of spi_get_device_match_data() to simplify things.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index df4c21248226..f0342c8942ee 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -455,9 +455,7 @@ static int ad9467_probe(struct spi_device *spi)
 	unsigned int id;
 	int ret;
 
-	info = of_device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info)
 		return -ENODEV;
 

-- 
2.42.1


