Return-Path: <linux-iio+bounces-8933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D539676F6
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75373B21320
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8017C211;
	Sun,  1 Sep 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUAteJDI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788B1CFB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199232; cv=none; b=AhiZ+5XM8BKlSOFAzEyTGqrWKw5F3VPkqj6x9gQsn2RZCCLPUC1OWg/MEspD6I1FrppyQCWQkvJjsMn/kUCzGQ4M9kkxiJjXWtpQ5QEwAfUrqAKlnkknr7OOpTOTddv8ldGd8bZ9O1XuBqe5FUP65BIvYdTy3FC3bEA5ncIL5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199232; c=relaxed/simple;
	bh=N5FRNBOwx7ymqBM7YDf6pM0TCRzhS/ZrguB2VGaDgw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYWWLGk5eVRVcc2JlOmNy46Du2xWZn589PEvReNuDrLbb2SWhJkdFlIy33S3BHm5gMLSsjIQE1tagvx8R2ir5T1GN+DFufAyQsT67tLccEKQ3KCOTXU3D9U7MC7XlAOiccsIaqsG818CSmyyZgkkHciBjUyQpPT0nwbD87F7WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUAteJDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52858C4CEC3;
	Sun,  1 Sep 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199232;
	bh=N5FRNBOwx7ymqBM7YDf6pM0TCRzhS/ZrguB2VGaDgw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUAteJDIjRVv68GDkHg4/IjkoetJfeeTdV3dKzRv2/xFDKo+oxiEfqFKQLyzoQkFn
	 H5xggU1DKn0qu/asqA31pcHmEyuTFUN15ZWeO5tc64GuvrobFK5isHn0DgVvkhoKZ9
	 YB83HqBPqsZEdrrKIMwIwn3pAS+MROWhto0ERZTac1IWp5NRhszghyrpyDfdfksWH4
	 I9f+cGgBgphGnL18Ps6t6ypJlHExKemw7ovD899FHjbnWr4Qa7BHLduLubH+XuRMw8
	 oao8A0ldWrNpW68zNj2sWtu7lMkH/7DNTNq+aT9GBwE5O4kUWuOYcFhDX+GYJqqbxu
	 tQwCmn2ZSZg5A==
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
Subject: [PATCH 07/15] iio: humidity: hts221: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:42 +0100
Message-ID: <20240901135950.797396-8-jic23@kernel.org>
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
 drivers/iio/humidity/hts221_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 11ef38994a95..0272065cc44a 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -81,7 +81,7 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
 	unsigned long irq_type;
 	int err;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+	irq_type = irq_get_trigger_type(hw->irq);
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
-- 
2.46.0


