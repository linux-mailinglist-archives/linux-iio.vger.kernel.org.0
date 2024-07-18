Return-Path: <linux-iio+bounces-7687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D912B934E59
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FF7B2120A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895B13F428;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOo7cFdG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873313DDCE
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=FIQNd0uqBqmhbNAiX+IADcDIGLmLGri75D7fZj1FWGv3xGY14n5GlScfVlmLGapXOxp4UqJEEemnrQMYfX6vkwWkk0cCNfVKYVoGSR6ipXY5XrQ1W6JN50POxSlFjRqX3nEBZSvAcLUmGGS3MhOeuwz+rWJW0yqvnn83CcS4ILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=t3v9pNREQW04rw1bPr4IKujLCrhaPczP09b4jgHutKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdP4I3LqqYIW7N5jnkc74FfRX3kgnWJtot66rRzWi84yE62xTm18vKBEyML6k0CK0SiEfUgrtkLynrKFIcwxq8RiM0sFbkYX8HDOiyabKjJ/h7cUIe0cL5va0oB002ksHSXxselKqhBkeoecdyzvH4nVVL5zYzhCrhIMG38udgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOo7cFdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B783AC4AF1C;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=t3v9pNREQW04rw1bPr4IKujLCrhaPczP09b4jgHutKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rOo7cFdGik/mi3vFs/0cIapk3wb80DiYPqCiL23O/BikL+NAOCOZi3DpN5cRVKRrS
	 gtpaultUuO43SnEu3rzTXvAJrHFQWpn8w99LSDH2GfoOBugWXDVHy32y0+ENXK9itP
	 Afq2ZZVCBRkqI7JTslRiuHxffi/wCUjsSF1K74UWOJXk2OkxydG3MuQFB54ty1WeMx
	 9T5KJj67eg0ORyiCNUw2cEu7YFwSzNhtxZ9I5GGjJDgafoBf5+Cngb8g4FWGCDhRgT
	 GT5f3zGgALnsMirTro7ef7K8a7knWkT1eHjixloWsVSKCmpiUei2WHDxNwoqsA4Oi+
	 /mDjB9fc2Nk3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B201EC3DA6A;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:55 +0200
Subject: [PATCH 09/22] iio: imu: bmi160_core: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-9-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=968;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FCLyiHnQTa3nd6JpFgp4oW46A/SnReH0cNLG6fHRNAw=;
 b=wAqC8oxgdozzLH8C2SfoiJq+6J85sx9mKJ7L2mzkWOcQ7si6k3ztMmcr8CiKOqN1c2SQcYG7H
 MMc0dTolNgMD0ILZHAEaD1VDw5WrQNtVsdoN+BrQSQt7TWKLnzS5gD0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 90aa04d94da54..495e8a74ac676 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -435,8 +435,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
 	__le16 sample;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, base + i * sizeof(sample),
 				       &sample, sizeof(sample));
 		if (ret)

-- 
2.45.2



