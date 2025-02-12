Return-Path: <linux-iio+bounces-15420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA61A3204F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B621889E2A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48797204F79;
	Wed, 12 Feb 2025 07:52:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459F1DACB1;
	Wed, 12 Feb 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346760; cv=none; b=iOr4xTIVmSuVReRz7zohHmowh5W5flN+cV+6J6VroCCZcpqoDLojdsX8oUHQNJqkBalSBS+ln26CwZvQyM6ykfQmW2qU7hm/4AgqKJ3raUGseCvhPB6vm6pKq0sGRxuPNFQI10jV09UkmRc0QZ2iRCegcAJaxZ864ICxqKpUypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346760; c=relaxed/simple;
	bh=pabkowy5KiKUWx2QVW0U0p9gAJRVu2PeEwkOYWY0Am8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7LJhIjFnxAy8ySNyQlUQo5m5WrgUE55C3zzef4jr46AXUmniWdzcnR/UcejSuN0Fe8fIScxDj+cWzfR/1M0w69G1VDyoolK4PWqG2xwV6jRA7FXyb58jZ65S9MjtbGDxZ9AYpSvUr7iwdPXtxLXXiLiffwC6LyF/xe6pWf7IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JZM00031;
        Wed, 12 Feb 2025 15:52:31 +0800
Received: from localhost.localdomain (10.94.15.56) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 12 Feb 2025 15:52:32 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dan@dlrobertson.com>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 3/4] iio: accel: bmi088: convert to use maple tree register cache
Date: Wed, 12 Feb 2025 02:52:22 -0500
Message-ID: <20250212075223.4164-4-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250212075223.4164-1-liubo03@inspur.com>
References: <20250212075223.4164-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2025212155231c962a82b6baf20fb70618002098192f4
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iio/accel/bmi088-accel-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 9206fbdbf520..36e5d06ffd33 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -145,7 +145,7 @@ const struct regmap_config bmi088_regmap_conf = {
 	.val_bits = 8,
 	.max_register = 0x7E,
 	.volatile_table = &bmi088_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_NS_GPL(bmi088_regmap_conf, "IIO_BMI088");
 
-- 
2.31.1


