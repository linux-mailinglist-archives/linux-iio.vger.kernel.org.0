Return-Path: <linux-iio+bounces-20404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E67AD4F08
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792E67AA2B7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA46256C7C;
	Wed, 11 Jun 2025 08:59:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425A25487A;
	Wed, 11 Jun 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632356; cv=none; b=EqfQGh7EvwF2FjsN2p9CCaV217pHjR6wsZlWnkGzWm+3S9NjV5l489Wnfi/6z839VO1c9u58Zt30tXwpsFmkoxs72LEXqtyLTOVmgDbesmZXDfMMRBwJuqKf5kvY+VGIRHPKu3pgTLmPjpQZyKv4NWqHVSBuXcluROEOZb4HjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632356; c=relaxed/simple;
	bh=m4CWXoIJxXj7A/0m38Ur8raypeBQWVZqSo0YDfBdzU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1ObJzzgAKTEc9ltmyfrR1tmkdCeuNhZZowDZATLH/+s1I0HbEI+uDKRHQ6HX8PD/ivVGGjbgi+iy7JbyZoSQD35Wa2JzFHQvLkIPXODuqTZVy48ENaAI0xUkzBLc2KUgZh3CqQcYQdlvuZ3z2LFsjkCMu2zvWG8WpipRQitAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202506111659049660;
        Wed, 11 Jun 2025 16:59:04 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:05 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:04 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 07/10] iio: imu: bno055: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:35 +0800
Message-ID: <20250611085838.4761-8-chuguangqing@inspur.com>
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
tUid: 2025611165904fd726e4cf646a75730e4f4d479ba992d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 597c402b98de..3f4c18dc3ee9 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -290,7 +290,7 @@ const struct regmap_config bno055_regmap_config = {
 	.max_register = 0x80 * 2,
 	.writeable_reg = bno055_regmap_writeable,
 	.readable_reg = bno055_regmap_readable,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_NS_GPL(bno055_regmap_config, "IIO_BNO055");
 
-- 
2.31.1


