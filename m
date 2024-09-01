Return-Path: <linux-iio+bounces-8929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45D9676F2
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94016B212CD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CC14F9F5;
	Sun,  1 Sep 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9hDtpqQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFE1D1319
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199216; cv=none; b=DoO5D2ZrzSEdFLU96UT0+MJD8tRkgTCqsoRk7kJCkVAqXBaNiW1Wgjc6j1u1pClkqyQDQZfs/FByz80ljah4iN5t0cb9CNe9Pb9495ENjeWxVX6xpLDEgtVdg/9Srdbx80vvHCEUgc8pkPCo9BJIO2UKp+h182nkX+dWOGaTi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199216; c=relaxed/simple;
	bh=RohKoi9RNZkbwxqX0DvxllErixx47Hn4CoGLLIHaQmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgc70L3rBu4dOqLZKg7iYFvCLfLk1D+CYTbIFMawg09Very/M3E6ktBXwABEtlWuUQXAI3txarE6JyD+LVyD6ccTc0+/7avLnKL1tEZEuqZCXl/jVXGbcFrzw0v6rg0UGGnhjN1OE8Rs1ll1/yBV5Dp36w8Cy2bIKKZMVxjMFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9hDtpqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC6C4CEC7;
	Sun,  1 Sep 2024 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199216;
	bh=RohKoi9RNZkbwxqX0DvxllErixx47Hn4CoGLLIHaQmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9hDtpqQq4EEhXETJ0PcsF1IAceRmnX9ftMMzchAnCXnYCLBcGg4nzoHm119p4KpZ
	 kz0dP1zZzRf6Sfv7P1BlBN/Ik9reY4BSJujZm8TyD/fq4vmU1aYQhw5h4m9Qb/OKz8
	 YGDstpVPUn55Qaj69XFeU1lO6H1k98VBGGb/GqRhYMtVJZiPA5PDgUdx9v7XO36WOw
	 vpvBm4JEdAtUi+/Ga6DaE7dYvnfOT3nvzr4gzH1x9I746IkVExvxAR3kXgiI5oItJh
	 mgaJpMQOsYdECzZ1CMYJlcroiAFgWqWhI0ajGqDLV7l2jX+BTgisCyr69SgmuMLoJ5
	 euXAZpBu9vkyg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/15] iio: adc: ti-ads1015: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:38 +0100
Message-ID: <20240901135950.797396-4-jic23@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901135950.797396-1-jic23@kernel.org>
References: <20240901135950.797396-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use irq_get_trigger_type() to replace getting the irq data then the
type in two steps.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index ca432c49eab1..70f60d018049 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1033,7 +1033,7 @@ static int ads1015_probe(struct i2c_client *client)
 
 	if (client->irq && chip->has_comparator) {
 		unsigned long irq_trig =
-			irqd_get_trigger_type(irq_get_irq_data(client->irq));
+			irq_get_trigger_type(client->irq);
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
 			ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
 		unsigned int cfg_comp =
-- 
2.46.0


