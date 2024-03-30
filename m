Return-Path: <linux-iio+bounces-3953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83280892CB5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14167B220D3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DC3FBBF;
	Sat, 30 Mar 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRpJiceW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581613FB81
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825753; cv=none; b=t1rTdvlYsdYz7CZHGMWNYubHmOJjvWAGwwsYdyD4F6Z82Xl5xzR7SOwcvkaILtYqBlA9fnlF+LMgvRNiUXnHO4GC8CRKHAnpgAvLZRzTSpYCvouJQ9MGcmHQ3hZvEowsKHnzy+njn8cRbkBmxD2RGHOCecXgbFdp5QfLsMDJsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825753; c=relaxed/simple;
	bh=h99Hg6GwiZm8R1GlrKNeI5fpGvHJAFB/VxgKTYEkcv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKHVwkQxSeGmG2VOe85s3h4PooaRsgmknDjhXCsJfdNp0FTf4KWKLyzpOx8Rpfmk9q7IgTe22HOXxI3y7YWsDWJmrLnZUe9G+QYhnneCrQ/OQt0BZNR8Pvm2Y0dm/D9hceiiq58L1226iotqngAM2Djn9PKXHImnZu3rGgEjOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRpJiceW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEC9C433C7;
	Sat, 30 Mar 2024 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825753;
	bh=h99Hg6GwiZm8R1GlrKNeI5fpGvHJAFB/VxgKTYEkcv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRpJiceW1XGm2YqdtGTNtljHaFJJ9jb62S+zeBw5A7ltpoedID3TC5XwYI6ZpyrnM
	 J576PkJspHS7Cet1oxpEGDY/oxfK5LOXiMRtjpMnS5cj9htSnk4QHkTEQmcj6o99M4
	 3YJt10DXijarQ9qgQv5WTEaitbIpNMfTiAtZpWQ/W4HAKYSStpItSq+zN/NfX0BjZD
	 nVaGX4zw0XgLoEj7BqRvYhukGZASzpAnvqDmCiMF9qgaugrM3wPWuvvMfxiYH0w+a9
	 5WH72WLiDLW65ZsOrWV6PBoj5d3Y2fiV8pbvO0FQ9FPvzpFIQYDKEUQBEpsDreKw3D
	 i1v+OF22au2VQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() to simplify erorr paths.
Date: Sat, 30 Mar 2024 19:08:44 +0000
Message-ID: <20240330190849.1321065-4-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new loop definition automatically releases the handle on early exit
reducing the chance of bugs that cause resource leaks.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ab8500-gpadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 0bc1550c7f11..59f66e9cb0e8 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1028,7 +1028,6 @@ static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 				       struct iio_chan_spec **chans_parsed,
 				       unsigned int *nchans_parsed)
 {
-	struct fwnode_handle *child;
 	struct ab8500_gpadc_chan_info *ch;
 	struct iio_chan_spec *iio_chans;
 	unsigned int nchans;
@@ -1052,7 +1051,7 @@ static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(gpadc->dev, child) {
+	device_for_each_child_node_scoped(gpadc->dev, child) {
 		struct iio_chan_spec *iio_chan;
 		int ret;
 
@@ -1062,7 +1061,6 @@ static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 		ret = ab8500_gpadc_parse_channel(gpadc->dev, child, ch,
 						 iio_chan);
 		if (ret) {
-			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
-- 
2.44.0


