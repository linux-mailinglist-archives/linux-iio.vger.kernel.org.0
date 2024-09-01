Return-Path: <linux-iio+bounces-8931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A249676F4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7528B1C2120F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926717E473;
	Sun,  1 Sep 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQbBm3bZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1691CFB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199225; cv=none; b=Mg9V4Iadd2TQ0+urMKJJD2qfdtaTlUvQmdtQqKpnS+r4zYbbit0w4aDBqFMjGT05/aP+MMei0Ntzjh3PeWHvyGhU92/WrtlCGSoDn6s7UdaNV1wxxkbEEeukYG25B0nV8J314FqFldOc6RrDgoZ2NcQtrWVbI+odWun9sXpfoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199225; c=relaxed/simple;
	bh=Mhp6HRs/zBD+oOWJXdm4KkwZHLx7N9HeFcqIWsTbHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6JIPMN8wIx+dwIg07HmJXN3tKNJnuK79GXmwKG5bPsOTSL3WDhFDbcigaSkRfTSEAqrkawBeG81Nzt8Skdkm1WHPmOMxuGb6eCodMz7WrE/zsrNRKZE0oc9HEE1MoRxuPLq0R7w2GWEoBaiVgpa4K4h+Am/Rb/VM3Z9bYZlrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQbBm3bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A27C4CEC8;
	Sun,  1 Sep 2024 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199225;
	bh=Mhp6HRs/zBD+oOWJXdm4KkwZHLx7N9HeFcqIWsTbHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQbBm3bZcCkZWnMc9Gr/a4SF9VJgrvSneFyyDm6TuoZhHOEVgwYM+5azHLnEkI0G2
	 w9qbSO+HIDkU67c7Dwh6h5ip82cTTa5icwSgvZrj140kNsXpoJnedU7Ji+0U0nqXWZ
	 mmv+Bvizs4+B5CuMHjQnmPfa4szJ947gXb06KizoL7rVpM2+Qif6kyUhYQ2diSSBYY
	 WSiHxqp8VrrxpmEB+aI2yr7QrKjyj6alwu/7X1I0nHbp9eGofg6V+G7IkJ0IOTmCh9
	 +TAnGtcnIRMoCXDArLJ7F8UwWE1Srw/p4D4giJng/dQxKX7N+CLd01a6PsCvpEf29a
	 jr+sQhg66/KhA==
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
Subject: [PATCH 05/15] iio: gyro: fxas21002c: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:40 +0100
Message-ID: <20240901135950.797396-6-jic23@kernel.org>
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
 drivers/iio/gyro/fxas21002c_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index c28d17ca6f5e..877a2b07cb23 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -849,7 +849,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 	if (!data->dready_trig)
 		return -ENOMEM;
 
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(data->irq));
+	irq_trig = irq_get_trigger_type(data->irq);
 
 	if (irq_trig == IRQF_TRIGGER_RISING) {
 		ret = regmap_field_write(data->regmap_fields[F_IPOL], 1);
-- 
2.46.0


