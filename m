Return-Path: <linux-iio+bounces-13133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FB9E5FC6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 21:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F221884B10
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0731BDA8D;
	Thu,  5 Dec 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I/IZYPg3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27701B87ED;
	Thu,  5 Dec 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432228; cv=none; b=FOOXp2MaHvjLfIfHpLMapLmg+zK1Qdm9tMoThRouY4adkyfhdeol+SLNEUQh/ozIO2JDMZyKEydIBdbC87IGlJqPwRWX5cxumVmBSEnzrZnq4ObE1TOHn+atDJqf8cqZtmfO3j5J+oY31L5Gw45+UVakxOXgwBeC3R3GY8QrZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432228; c=relaxed/simple;
	bh=exLBzZN44uq/eA51sJujDUJBC7JPNknSB8+UHw95tF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abTPjLmk51c2fmM2peKYraP9hREZKJTYVwxU2J0P6sCSlsIH5iY6yjolof7eGTwze/sFoDykmo2IJqj+vlomAyhMjqavZ8PO0sjKcrcB4fyE7Ob2IcIIics49jCKUGenkeTdDz0RucOMC0HDU2nEVOI4gfm6hDkbfOehq/1kRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I/IZYPg3; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JIlAtbRosTOxlJIlAtj0ZA; Thu, 05 Dec 2024 21:47:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733431663;
	bh=pyxcVRr6ZRTbmf6+JN/+2wrLbnr75KpReBklbPYd8+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I/IZYPg3BkLso/QaobGcJZ5eJL6VbnL4e3isD3pRhWgkfik35/o83uss3AXEUNGD8
	 w2URZl+OgsO2aRc74wZ8juEfzJzWr1vPNOmVqg9B7Sbc+fI87dHYa7PIWwM+F3/ftI
	 Tf34jQF68h/yV6klnM3gZZOM3KS+2roGiUI46JQRVoF4piLcB1kd6v2ddrvI5CvXV1
	 9RMHQJROQsUKC7jAMO66tEsfYtPPnAtBQ1X7fhDZf0aDzaCgjWHw1/4WO6EVJcZRiR
	 OrTZX0Z1boCFAMGcX94RGqDmnZ8EiHu3xWS85RdxGBVvAvOEL/liU3GsCJhVBVE6d7
	 PIqBN6xrfwu0A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Dec 2024 21:47:43 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad9467: Fix the "don't allow reading vref if not available" case
Date: Thu,  5 Dec 2024 21:47:29 +0100
Message-ID: <556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in Fixes add a special case when only one possible scale is
available.
If several scales are available, it sets the .read_avail field of the
struct iio_info to ad9467_read_avail().

However, this field already holds this function pointer, so the code is a
no-op.

Update ad9467_info to actually reflect the intent described in the commit
message. Keep .read_avail to NULL, unless it is changed to
ad9467_read_avail() in the probe at runtime.

Fixes: b92f94f74826 ("iio: adc: ad9467: don't allow reading vref if not available")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only and is completely speculative.

Another solution would be to keep ad9467_info as a const struct as it was
before and add a new ad9467_info_no_read structure.
This way, instead of writing in the structure itself, we would choose at
runtime which version to use. The main benefit would be keep this structure
with function pointer const.
---
 drivers/iio/adc/ad9467.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index d358958ab310..356637677524 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -900,7 +900,6 @@ static struct iio_info ad9467_info = {
 	.write_raw = ad9467_write_raw,
 	.update_scan_mode = ad9467_update_scan_mode,
 	.debugfs_reg_access = ad9467_reg_access,
-	.read_avail = ad9467_read_avail,
 };
 
 static int ad9467_scale_fill(struct ad9467_state *st)
-- 
2.47.1


