Return-Path: <linux-iio+bounces-6838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA44915733
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E6C281A5F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E81A01A1;
	Mon, 24 Jun 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H30Y5ogk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68D19FA9B
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257536; cv=none; b=fhSgOkDDIjzB9Qw4yODORL598XCRzA6GZkqv7sDSopYeqZNNyP7jDmuC1GCHGRsfztru1VcdKnNkPHgj5jsTIlWKQL1mKWv8GcUGC5CnTO0UNc2hrtgQbAJL39ToiQcxfEue1+cmPk4Zla/dh0pjQ4bLw97e6HP9YwqOmfshPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257536; c=relaxed/simple;
	bh=twLl8YaVGWcGIHaMeuKQEqe2hFrKOAL7nxs/JcmP3wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2ZwxYlOfnK18HMnbM9Zph/zzkt8YjTeT8gUOvrPZfRWVRwqoZuZ5Zm1f3ICk9ZHr0fQx0/fulOHkSpZgDGqK6jTtCYqMZjv6nv//YmWHoBmVyP2PSf056RcFd0M9HSI7cDQQ/UfpsOBt5Yp0LnFFsrKoxjqKARBGntrYsDQ/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H30Y5ogk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F47BC4AF09;
	Mon, 24 Jun 2024 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257535;
	bh=twLl8YaVGWcGIHaMeuKQEqe2hFrKOAL7nxs/JcmP3wM=;
	h=From:To:Cc:Subject:Date:From;
	b=H30Y5ogkun5/eTOtIlfZP9/ce5QzVSNIzYERBnbIp5fFKhc31yBSb9fAMePO4QmU9
	 8te7BXUNe3HsHrbxKXfndC9FhYs+25AkNErt46Q8QBHAv5P0/o/SV8ffA4hcuABsCk
	 +wxsBjs9RscsD1/EF/9T+rmzkaOXYYHfiSb20Bf2kWp1l/kaHo3PpVEYsopOQJVKoS
	 dYhoeLg9d0eSOq3t7TWB3alFhAhg4iVXAW5zLrJi5Pjyb8EWkfovInl5FCeUD1Zcmh
	 h/dmim189X6Om5VATCq6JoX+MaFYgcqGOVKB/+9Zme81/arbjyJHuL49MgcApceFrF
	 l8J2B1GGCis9w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH] iio: adc: ltc2309: Fix endian type passed to be16_to_cpu()
Date: Mon, 24 Jun 2024 20:32:10 +0100
Message-ID: <20240624193210.347434-1-jic23@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Picked up by sparse.

Cc: Liam Beguin <liambeguin@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ltc2309.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 888a71454070..5f0d947d0615 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -103,7 +103,7 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
 	int ret;
-	u16 buf;
+	__be16 buf;
 	u8 din;
 
 	din = FIELD_PREP(LTC2309_DIN_CH_MASK, address & 0x0f) |
-- 
2.45.2


