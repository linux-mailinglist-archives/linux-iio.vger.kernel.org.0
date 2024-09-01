Return-Path: <linux-iio+bounces-8941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1599676FE
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904C11C20F16
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCE1802A8;
	Sun,  1 Sep 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plr/gWpI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AF17F394
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199267; cv=none; b=EpssEgW0IMtEDd+nQpl6oD38S9TdrO59GoLav3znNvkze6yvCOt7yoqNSAwJ9lnxQeZoWpcvTXcNUbdLGThxB3CL3s4oCfamlIOPvSb0LNVLcBgaZxiM64hJd5c/KVIffMTte3GWeUnexCMGOE8bth8EneqNGTpStSBp/Y/9I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199267; c=relaxed/simple;
	bh=6hM+i1uK1O0NW1sB+53GxLHcQUdWgFDhCaKu0Pva99g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeCCEq8ErAJg1nUaY5sF6ifosDfSvLNGuFdFUtXUIUFSLzs7sAtlKQpJCU5muA4Of3PhEL9Hg7vJalSywVxwvz+0cH+bg0YA/qejwFrYMe8WWUD7DXklAq5GgEfkH9D2IY5nkV3q4tfOUmtCO4NN1z9jUVeH5L06Fh5MApY1xaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plr/gWpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2019C4CEC3;
	Sun,  1 Sep 2024 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199267;
	bh=6hM+i1uK1O0NW1sB+53GxLHcQUdWgFDhCaKu0Pva99g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Plr/gWpIf8b8TBPZnk68/+NT56FrlSGGIE9CfbEf8e2eISZdbUjzidormpGJjYpTg
	 lFErqMc4GURYEU+l+NDiySxd5nRsqou85zrt1O4TJvXI44aynmbyJrn5h4kdtsyLN5
	 0T3R3Au1jHJveGngCEXLxNWVWm1xEfHkE4zxI9cDPoVWLaqJ8+SdOoeuBNk4jDrdo7
	 eoGz3j2m9LgvqghuTRYMYJPu8vrIb8x4NRV617WOP13mpJd/O74G0C9vMPwHOBvD6t
	 uPmWpTd6EBgho81PCVrfnyaDcCzJwxumqlIjYy6DgBwtKnjlg9ZK7FNm/Pd1dTdyYE
	 PAYFeSX3lzu0w==
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
Subject: [PATCH 15/15] iio: pressure: bmp280: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:50 +0100
Message-ID: <20240901135950.797396-16-jic23@kernel.org>
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
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index da379230c837..b156dd763cf3 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2596,7 +2596,7 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	unsigned long irq_trig;
 	int ret;
 
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	if (irq_trig != IRQF_TRIGGER_RISING) {
 		dev_err(dev, "non-rising trigger given for EOC interrupt, trying to enforce it\n");
 		irq_trig = IRQF_TRIGGER_RISING;
-- 
2.46.0


