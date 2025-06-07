Return-Path: <linux-iio+bounces-20291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B67AD0DC2
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D6A16E287
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA491A4E9D;
	Sat,  7 Jun 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYczttIG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD81990A7;
	Sat,  7 Jun 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749304592; cv=none; b=dFxV9WxKq5boQ5QzYqOLPh7ehTwAImcxY265Np+cC+902lKj0wq8q8146mFGEzgPg24bHHKX8EJ7za9/60StJa2pTBNpd2za0KP6Dun2Cxexsf9LvNRZGXXDDeely7qxpLBnxG2gy5yEQGjuoN04TUHWuBsHDCwbnpysnbsyQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749304592; c=relaxed/simple;
	bh=2gPXD5yjmhI4B3pKH5Tr2d9zGU/Zymv5lSEf8kaV5AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/7RgrX2dCDwzDNiuZKRjWSA6DWoEaL4NR/yTkYhoap+PdEf6cnd0wpuuYsiJlOEffKdLn0Tu/0j1Uhy4wGfRRyzFHlfHJUVeTGVn6/GTvb4Gra3DRV692YgXHj40nTG2NoQJe0w7ymTwS8UWFeGjRDBcbxvyWG8mARz0n4sDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYczttIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EFEC4CEE4;
	Sat,  7 Jun 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749304591;
	bh=2gPXD5yjmhI4B3pKH5Tr2d9zGU/Zymv5lSEf8kaV5AE=;
	h=From:To:Cc:Subject:Date:From;
	b=PYczttIGX2Dtvj8t5QlBdf+DbvRTjUxRu9FmWiv5kh2Cvyb35IT8fUivey6ieSadg
	 N0DSZuE6ZLKFCModOp2dBfHTi/kDyM3sGLkEB7O8otZ36IEtkhblHEvsmrKnrfWgRI
	 wNwJsCrLUl/JKESMqS7morRlwqXII023XU8rh7DpOxQmJMvAG2ACSzRXTqMeyzZ/sL
	 EC9mgsafFqv5jUYjXBxjjJFmIHsqTNnJ20bgk8Om7b+axNXIckrFwO62s+vkLBAgVs
	 eBiSRw0q+eYLh6MdGkUhOVepRA/XAdapdrQdPH8bbLpH2UWdstgBi0QMYmhWpTEMzg
	 i0UZRBeM51mgA==
Received: by wens.tw (Postfix, from userid 1000)
	id C656B5FD0C; Sat,  7 Jun 2025 21:56:28 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps
Date: Sat,  7 Jun 2025 21:56:27 +0800
Message-Id: <20250607135627.2086850-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The AXP717 ADC channel maps is missing a sentinel entry at the end. This
causes a KASAN warning.

Add the missing sentinel entry.

Fixes: 5ba0cb92584b ("iio: adc: axp20x_adc: add support for AXP717 ADC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/iio/adc/axp20x_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 71584ffd3632..1b49325ec1ce 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -187,6 +187,7 @@ static struct iio_map axp717_maps[] = {
 		.consumer_channel = "batt_chrg_i",
 		.adc_channel_label = "batt_chrg_i",
 	},
+	{ }
 };
 
 /*
-- 
2.39.5


