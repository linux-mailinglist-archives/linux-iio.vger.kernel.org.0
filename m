Return-Path: <linux-iio+bounces-20408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADCAD4F10
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441073A803D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF225A340;
	Wed, 11 Jun 2025 08:59:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE825B1F0;
	Wed, 11 Jun 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632365; cv=none; b=kQABgkmwy8qCsk8hODDHGty1UYuhRvvwUX1EB3LRUjxFj3qDIhvc2TZzeJ3oyWNOo3wSp3OTQZwrkEiziDzglDe0Wq6tAFK7VhCu9EouQj2oJU16oFb/byj3axi42lVU54+yfJj+jLZZb/+pTuS98APred+RzZoXvuXv9mOwSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632365; c=relaxed/simple;
	bh=VF/D12KF+O2uGqA9x7ILCkxRBCK+OvWJpeQDG1Sn+p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVOYvchGRXllOZ4zggwrRM6VZhXJSjFp9KrUI/v+SrY4PIz55gjQMfAJyWWhcHuQZXwlxzXdy+XoLptX38hPzI5FpVKNHqhJflInVkoYoj1+Dfx4Vl9ME7GINx1iM5h0PUx1A+Hz6RQfxpOqsKVu0EyzqxhRrwIFSSc5GVS7n7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202506111659031988;
        Wed, 11 Jun 2025 16:59:03 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:04 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:04 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 04/10] iio: health: afe4403: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:32 +0800
Message-ID: <20250611085838.4761-5-chuguangqing@inspur.com>
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
tUid: 2025611165903aac6313a1c759c92a6e2828091bde120
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/health/afe4403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 1582cfc03579..30d3f984b032 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -405,7 +405,7 @@ static const struct regmap_config afe4403_regmap_config = {
 	.val_bits = 24,
 
 	.max_register = AFE440X_PDNCYCLEENDC,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_table = &afe4403_volatile_table,
 };
 
-- 
2.31.1


