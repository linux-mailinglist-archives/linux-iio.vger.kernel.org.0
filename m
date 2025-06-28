Return-Path: <linux-iio+bounces-21027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE60AEC4EE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565DE560486
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93721B9CE;
	Sat, 28 Jun 2025 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGCDOPJK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A841A0BD0;
	Sat, 28 Jun 2025 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751085814; cv=none; b=Xv7wcvQILGA5yvGGRsMrurO0GuDsbUe1chyD9gs9Dj06cA1BUuFiNa4G8420ZCZ6DKhglMELItU1ic2h/Pb4cXKUpZFpK/ImjXOSVXxcsRmiRwfjyPeZ+BmRmHvbiv+Q+Jn45k8ns8H39181goy6TuaobgcpgTQjqo5JZFLbr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751085814; c=relaxed/simple;
	bh=2gPXD5yjmhI4B3pKH5Tr2d9zGU/Zymv5lSEf8kaV5AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZoyVoJKcMu2BBvjCHBTwCxBdRU/CgN17YY5X3cW8sfQ9nLgH0lYiRcZ+6e9gCbZ9XczLH8AsTODuAthCHThAiylUpL8qzz+w1viL7PLpzl/suXwjMBYDFuo4JYa2eZqOdOCPr89U/zMvs0q7ClwpLLveaKjam3bgBVCaEwgD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGCDOPJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32821C4CEEA;
	Sat, 28 Jun 2025 04:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751085813;
	bh=2gPXD5yjmhI4B3pKH5Tr2d9zGU/Zymv5lSEf8kaV5AE=;
	h=From:To:Cc:Subject:Date:From;
	b=RGCDOPJKe/1XcMPasv8XMAFFrvY3dSYAJIg+cadek8lRmr3MLd9vF/JxWpIufBz82
	 OL7i/x01xK7H4z57pKB9tl2JUrHiwm88hR0Y+Fi8jkvqfbNNFQujl4wT1r12N/LJHf
	 r6bZbrVWkCWJ/dfQ9uLGPRDkkpcVUT0Gqt1SVfZVFo+34RXFKZgzDkvueANV7bcq7+
	 WQ9mb82FzZ+r2dRGSUgAbgFagui8UTiBxdmifOh0hwaZS2lzZKxB1aAwygozjVSvqY
	 X5MDximh/MJ1LmnHCqK6gMi88/MJztbVweBQtTGrOSbULDKeNbgqRjocqg+IczkAOH
	 bKFyA8ulDW9DQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 46CE95FD53; Sat, 28 Jun 2025 12:43:30 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-iio@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps
Date: Sat, 28 Jun 2025 12:43:26 +0800
Message-Id: <20250628044326.2844027-1-wens@kernel.org>
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


