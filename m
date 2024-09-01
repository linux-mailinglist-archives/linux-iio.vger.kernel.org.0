Return-Path: <linux-iio+bounces-8938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBC9676FA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EFD1C20E2D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199117F4F7;
	Sun,  1 Sep 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdfPz4JC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762A17C211
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199254; cv=none; b=evphvHTcBQFwQpZkGPftC5Rpga+sipZaUxEf3X9wWu1OQAt+HXxu+XcivCaSkZT0jfTzkKTFIcRJzv8JfkHBrRbZG38ag3zv8VAdBGxj23dPSlyPdFF5JmdQsE2sBbJMfZD38GC1HpvNGTIx7fan9VNTzPwhdnkp3omPkjin0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199254; c=relaxed/simple;
	bh=a8peXB79CCP/+nOwan1Z0/NGi2flRPjmfiJfXgHWPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT6y6Zo9bpaLcZwRHQJVpU+UhQNwcyRqHEG4E/iKOJYhuEksMlKVlr2TIi8TYp42DkPI6dbmyu8UFK8W3iwlEIdSmpbAhWsd/fG5DYXcyI8h1lnnCofzYA2YqBrLaiPF2kCx0s28Q8j71cNRuf8gMxLBwXO1PGwnauGpmmRrQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdfPz4JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB5C4CEC3;
	Sun,  1 Sep 2024 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199254;
	bh=a8peXB79CCP/+nOwan1Z0/NGi2flRPjmfiJfXgHWPpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdfPz4JCYFU1/4mHgZaT8rWik/ohgxeKH2yzoV1WK4ZntrPGsvhbgtpmP5iVqhDgm
	 +ukQx1FgG28tXR8oK934MTuv3KZXmxuKO/NPrpYK1VC5pFp8GSQZssQwEcp/2lkVvf
	 DLru+omhCdzJhfAYIlZF60DXW5HeP9G3UeeW5Tut/WyQuAWbNIQaxIpcVR6foeZ9vN
	 PK6fFGHkFRmXXlE06IApn/YuX+MkORzMXXZnpNGaadgR3GnXBe8mOY82FG9fsI902t
	 FrY+nnfSBuZU79BXo1ew12HP7g7ZeAKq7GiJ2inLIY9jgcbYVye7qgmi+zWbkjANI5
	 R0eO2DMK1J1Vw==
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
Subject: [PATCH 12/15] iio: imu: st_lsm6dsx: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:47 +0100
Message-ID: <20240901135950.797396-13-jic23@kernel.org>
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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ed0267929725..ca1a2c24d7ce 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2531,7 +2531,7 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	bool irq_active_low;
 	int err;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+	irq_type = irq_get_trigger_type(hw->irq);
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
-- 
2.46.0


