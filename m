Return-Path: <linux-iio+bounces-20411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FBAD4F19
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7138217F703
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EB25F787;
	Wed, 11 Jun 2025 09:00:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A725CC54;
	Wed, 11 Jun 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632421; cv=none; b=VaVt4lOxQc97gVHI1zURxZ3QJsoTz3JGVcd0PInMbrHjD4j+FCq1NQKkMwZtkqqQUsRln+56QBD2X7FU69wXHCw5zwKlkeU5ur4sG3WliSawLKEWGJ66mU2hBjp4HU5jjBTIYR0GcG8cWwoKhJLHv0Ftb0VjqCgBTMYUv6oj8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632421; c=relaxed/simple;
	bh=O/+Z1CoNDX/mRDXuev9DfNfUrUDAApxbIMNCdEWUjNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSmYBe2E7KFeVspSAL/EWg1UprkaEPd9ANC58x1vT3D7wusA1Y52LPP+A40r7zEO/ogSej7Qbhupjp2yXGwv+i4W4Vt0+Qvx5KNaDRGhMpDNcCkpAYmKlNocgqrvp/4V/zzP1gSNefjo8L3JTMi1a5JtHPm6J/1VvQLYHIv4+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506111659050561;
        Wed, 11 Jun 2025 16:59:05 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
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
Subject: [PATCH 06/10] iio: imu: icm42600: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:34 +0800
Message-ID: <20250611085838.4761-7-chuguangqing@inspur.com>
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
tUid: 2025611165905828bf27d5be692cabd28fa2b0c2e37f1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 63d46619ebfa..1fc4fddc2029 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -83,7 +83,7 @@ const struct regmap_config inv_icm42600_regmap_config = {
 	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
 	.volatile_table = inv_icm42600_regmap_volatile_accesses,
 	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, "IIO_ICM42600");
 
@@ -97,7 +97,7 @@ const struct regmap_config inv_icm42600_spi_regmap_config = {
 	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
 	.volatile_table = inv_icm42600_regmap_volatile_accesses,
 	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_write = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
-- 
2.31.1


