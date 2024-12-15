Return-Path: <linux-iio+bounces-13507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36949F254A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7ED1885467
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E848F1B5ED0;
	Sun, 15 Dec 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imbjCwH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC813C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287376; cv=none; b=Iu213MeJZTUMX9TDeudnPtN4GNddqSKO3ypdVFEBwVfMxzXzoeJnO/LPNhSUIilsps4LeteCqRalIkRkpHQSqldchY3srMaLuIEa/wiP/auQ/3ta5OZh+3B9GiEaMm6ViJN7izT08jJ/nB1ML+phaPeReMTMDa1atWimMODliU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287376; c=relaxed/simple;
	bh=1WTeeEaBe9njS2zLj0MVTaTiIdyyf+X+6zDMsOVdavU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc0h60j7uiy4Qi7mmKQkd7h78M9o83fFa7QAw6VNeodN80vuok8uPLYve+pKg7JEl/AkCn8BZhh2iGWwyWZlOqPB+bzdWlWaxGHFZlCoPQJSojxpH+VSZ7jFAhJyq2fAUma6IHkZN/TwprZjM4hzXFqJmAqE9V3xZi6EMmWwDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imbjCwH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017E3C4CECE;
	Sun, 15 Dec 2024 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287376;
	bh=1WTeeEaBe9njS2zLj0MVTaTiIdyyf+X+6zDMsOVdavU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imbjCwH1whIf6mkC+dG0mY9p8zXEH4qUQQXIsB6/y3j1CqdQtwZLNdAt+1H11X2Pq
	 p9qQkH/hlwuNKrzMAUo15cj69rj+QpVS8wMur6sNViTvRRPfJpceurAtfgKf6pLpo7
	 AjbhvDZz7HPBRx1GQc1yAJu4/l/QVyHm1xd8Ou7mWmsIG6+A5yhM6ON5SD7UlTov23
	 fCd+p9jD12cUYbg0vj+1DnbqLd3ZllWH09mvT7ZTENs1T6VEjRjA/zQhlrp8OgJLvX
	 vuuyP6b0B1yYGsnho7Wd7xmLaTPt9yZRaKgD0syVK+lwRodXD1UpD514djRZNFGWk8
	 Jm0JTXU9bUx3Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/20] io: adc: ina2xx-adc: Fix sign and use aligned_s64 for timestamp.
Date: Sun, 15 Dec 2024 18:28:53 +0000
Message-ID: <20241215182912.481706-3-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst it doesn't actually make any difference because the code
that fills this field doesn't care, timestamps are all signed.
Use the new aligned_s64 instead of open coding alignment to avoid
confusing static analyzers and give slightly cleaner code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 48c95e12e791..40d14faa71c5 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -150,7 +150,7 @@ struct ina2xx_chip_info {
 	/* data buffer needs space for channel data and timestamp */
 	struct {
 		u16 chan[4];
-		u64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
-- 
2.47.1


