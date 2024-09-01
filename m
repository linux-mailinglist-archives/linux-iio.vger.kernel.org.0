Return-Path: <linux-iio+bounces-8939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED69676FD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EA7B212EB
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9417F4F7;
	Sun,  1 Sep 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np4/PGCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791E17C211
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199259; cv=none; b=dGb2tTUjm9+1HbzfjC37VNTRY3dnO89mrJmLQscHuOg89KV6ohjQuegcFo8ldpdzLCoS+l2E6wij2ITDOGCKufZcBVHvP/URnujE3i0JisbYD7B9kFTOzzHdvW1+Ckqi7yiIIzKgfvAkaNB1o6fNzJ546frh/ZcMSbp2nKppghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199259; c=relaxed/simple;
	bh=95aVIy8fyTvQ69jAa90ET5aR2SZ5SowU/8OudCTKMLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcDhuia/+6Hqvpf4JYRWAWnMEdipi12VfubKy0HkX2nT3yQEC6BTCfRMh5tqaty0ttCPV+1KGqVHfZEB1Jeuku3mWf+v8soXgBjK+e4NUPaPr8D+yLt7XpqhL7G8o/KWajZ6orjeOhcujcU1Ym56ZJ7chSJJa9rythrXHi2A0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np4/PGCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D02C4CEC9;
	Sun,  1 Sep 2024 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199259;
	bh=95aVIy8fyTvQ69jAa90ET5aR2SZ5SowU/8OudCTKMLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np4/PGCNlbRdipi6LyUVItwnDnBf6qZVeawkRNr2i6za4tk+XxsK0748lk2Hnlun2
	 5hndH8thSVeCXv0tee8yZ6pjdrd1U+qBM/p7WR2NUVGbtLpb0hAPBxvOQF6uElcWTg
	 4Uzi6JFenp/zMLFkagNTUbMdt3pJhZ1+LznslfymvenYQ0fCFdnuC9xh/fXgRuB0Gv
	 NZEXryhcOUXgAw/ooiZdt7RibbUtntGPTvJ5u28vr2EAzE+CcIHHjkmUv5I9aipPRv
	 vPfbek6VusIJrnbSz5on0XnLdF9XuSU7WAoBF6eassFkR2raFAI3p7x5Ob1Y+AvmBJ
	 uUVeNBTQRxXuQ==
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
Subject: [PATCH 13/15] iio: light: st_uvis25: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:48 +0100
Message-ID: <20240901135950.797396-14-jic23@kernel.org>
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
 drivers/iio/light/st_uvis25_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index fba3997574bb..4a58591c3bea 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -174,7 +174,7 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
 	unsigned long irq_type;
 	int err;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+	irq_type = irq_get_trigger_type(hw->irq);
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
-- 
2.46.0


