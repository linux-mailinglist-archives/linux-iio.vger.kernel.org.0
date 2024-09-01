Return-Path: <linux-iio+bounces-8936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838389676F9
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24511C2116D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9617F394;
	Sun,  1 Sep 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etA70p3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBC17E00F
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199246; cv=none; b=bsk15R896hlv3GHgETZRBmzT4izGHzXz7jomarV17nmGwt78/jU058tdN/ze1ETk/RLgpEfnfCVlK1CaQF9NYzUqAWYwxLVEd+8XK0kKTfzH5hgvLE/rl0XlyfnIv7byrNnEAidgzyClMagEhaNvgMry1ELuMoNPf2WaTljhGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199246; c=relaxed/simple;
	bh=grREwPn4HqEqjVVjEZ1YBZSER1V+zCXNmNiJUfppIO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpiTulNyBArpo2YoHeFqJYohGsaMgyB04wkQxW+QB6u2ETLOEf4OCg1k98HvIx8RpOYfXWQGCBRsvROrfF3alLQ/+zJC9DHmFAB0TnTxq6LOhJ9SbgDs6THzauUuF4x65CbzImK1o9nXrdovRKfuMS4ZKQE6qZRA5vfJq1uCPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etA70p3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFE2C4CEC7;
	Sun,  1 Sep 2024 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199245;
	bh=grREwPn4HqEqjVVjEZ1YBZSER1V+zCXNmNiJUfppIO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etA70p3T8XBhyg2oP28rmw/SX2ytwiqXpCVrEiBK7ahLspd239wp/YT25D+BOWkIM
	 6dH5dsQ8Txk/VzSz5v5ZALt4MwIXWTwN8gZ9unYtuRRAlze93aIsAqvI736SC2eT2i
	 e7wLt9DgUnDC9cMB6cZPKivzINSuaO/NW6bIdccPUkEKjPxq4ekUlEBJJPqud3sScP
	 WmctZ6ETelvyCduT2CAoAcA+Qj4QfcTRJiTg9U2j2sCoRgzQEng+9HRN5w3LjIRLoL
	 8glzJvZC/H7Yn3m0SEKyBcwYtPG4k0Tf4089HNbowv3Vy3S+T+zd7kbsN6QgzNsEpW
	 Gfi4KHdYpcG/w==
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
Subject: [PATCH 10/15] iio: imu: inv_icm42600: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:45 +0100
Message-ID: <20240901135950.797396-11-jic23@kernel.org>
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c3924cc6190e..93b5d7a3339c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -673,7 +673,6 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42600_state *st;
-	struct irq_data *irq_desc;
 	int irq_type;
 	bool open_drain;
 	int ret;
@@ -683,14 +682,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return -ENODEV;
 	}
 
-	/* get irq properties, set trigger falling by default */
-	irq_desc = irq_get_irq_data(irq);
-	if (!irq_desc) {
-		dev_err(dev, "could not find IRQ %d\n", irq);
-		return -EINVAL;
-	}
-
-	irq_type = irqd_get_trigger_type(irq_desc);
+	irq_type = irq_get_trigger_type(irq);
 	if (!irq_type)
 		irq_type = IRQF_TRIGGER_FALLING;
 
-- 
2.46.0


