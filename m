Return-Path: <linux-iio+bounces-5497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C598D4B46
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5559F1C22C79
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF61822F8;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k25+vziB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99740176183;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070883; cv=none; b=V7KEdwZ+EN1Ls4VLhMAscC2WcYKJRqS45di9xDkX9uWa1l6kpz8DlibdMIJA1VzsXBEqGDxo5lYlw5RoVw2Mvkb2y/bmPa5wCIuir7WrrBIBKxYz0JMdI8rVICF99Z06w96ruCzso6xLDiAof+o7NeAQK+0F5if1e+7rD0FTpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070883; c=relaxed/simple;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQRiZciEBpNK7Z4WXpR9qM+43ems5zOdB6nYXw1r/OV58GtRYrLE0oiloiyIEmcpGOYKTSKJAXWeZ/wYbKPe/hY26Q9rlIPCgtBmvCpipfiXLSqBHsnBtS8AvN7AatImVBdFtzSbmSkLLrztcE/3kkQifqj9c59FKP6VqA+Im6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k25+vziB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45F29C32789;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717070883;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k25+vziBpoiI26hc8mqD/ADcr/eGRoNYx6hWJfWcjoE9D3xKEcY8SJQ/ewtrxohut
	 gVMxMOfhTyuHc1v0LEdzHOSrSs3b94TAzDrjxo//paOUa0pUdaMEyGLwvCJc21eXP2
	 92hnCnFVMr8Ut7sYqGYAXuDE3wYcrCOhuAMDlWo7cze1o9XHBk5KdpoU2s1lqrhV5K
	 hJtnlZdWR3IkW5AtOYStBiu+Glsb2ybo576FSafupPjzrv/WFaXYG5JWYrQ4PPaXn2
	 4cXm419xQHi5hrO09CmNasng4UzNmNYz9505LmLmPRGxUycWdVf6nHfZ29MTrvh1+d
	 kZqxJnPqW97nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F22C27C4F;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 30 May 2024 15:07:50 +0300
Subject: [PATCH v3 2/5] iio: adc: ad7173: Add ad7173_device_info names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-ad7173-fixes-v3-2-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
In-Reply-To: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717070881; l=1300;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=jyW8M3kG3uqXuCNPYLLJGiYuxqeZCfGKeCCNwqrSJqE=;
 b=4ER/UoEn/wZkI/mak5zAphUNqZ5UqOLKaguF+1NemNuXpdxwqAYvU7JqWghs5G4GC1++u9dYk
 QcklpdWm3gDCBALYdzKaYyoU2WcJ5jcZdZ03thUV592FTTXKtZ/1XUo
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add missing names from the device info struct for 3 models to ensure
consistency with the rest of the models.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 850574437bda..58620be41ef5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -220,6 +220,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
 	[ID_AD7172_4] = {
+		.name = "ad7172-4",
 		.id = AD7172_4_ID,
 		.num_inputs = 9,
 		.num_channels = 8,
@@ -262,6 +263,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7175_8] = {
+		.name = "ad7175-8",
 		.id = AD7175_8_ID,
 		.num_inputs = 17,
 		.num_channels = 16,
@@ -290,6 +292,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7177_2] = {
+		.name = "ad7177-2",
 		.id = AD7177_ID,
 		.num_inputs = 5,
 		.num_channels = 4,

-- 
2.43.0



