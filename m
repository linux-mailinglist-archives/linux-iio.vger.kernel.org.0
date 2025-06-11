Return-Path: <linux-iio+bounces-20412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B48AD4F1D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484C317F7B1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5A13DBB1;
	Wed, 11 Jun 2025 09:00:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6925D90D;
	Wed, 11 Jun 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632421; cv=none; b=qG8DgMBjYBgaCXRHXdoLKCVdoYdLeeYLRb84HpAdsQKh1k1wjkW1TAe/bshEYTazLtci2ZtH9a963N+1nsARqK0aaEWRjwVJKFWHc1CUw+LXeKjEm86+8sAWCFJ6rD5XDEPYt5oPwYeuOF5J/slFsOTP/i9cC+ULFgorBeYuZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632421; c=relaxed/simple;
	bh=qMB0IVjf/eFcUbo2qir82IqBWxx2Dgb/e6s/DzeGxek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKcKmqls1QTryAVcMeQ3kFISaRVMgg9P3WbL8kcbLs9ExN4ws+4BOLgv5fDCTzmfW1LvizHgcue5KSDt4nUnrcgavY+Q9W23NX1qD4jefAYzPGRDSH8jz7PUGrKqluo+3caFhCiFt9vZiizi6scda9hfdxEcnymkCfQ4B0N4tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202506111659021925;
        Wed, 11 Jun 2025 16:59:02 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:03 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:03 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 01/10] iio: chemical: bme680: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:29 +0800
Message-ID: <20250611085838.4761-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250611085838.4761-1-chuguangqing@inspur.com>
References: <20250611085838.4761-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20256111659027ba150282aebe609eb8341d2ec05f679
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 3e850562ab00..61d446fd456c 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -158,7 +158,7 @@ const struct regmap_config bme680_regmap_config = {
 	.val_bits = 8,
 	.max_register = 0xef,
 	.volatile_table = &bme680_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_NS(bme680_regmap_config, "IIO_BME680");
 
-- 
2.31.1


