Return-Path: <linux-iio+bounces-20414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2FAD4F28
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D444517FC09
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D42638A9;
	Wed, 11 Jun 2025 09:00:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC525EFB7;
	Wed, 11 Jun 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632425; cv=none; b=rgii4xFtCkjeJfqqNT7JpdmLIrOWzstXpH2agWV+63Eyo2qE3Q2iMhy7hYfNHhh8O+V5eWXQ4C/V3HLao1zYijQYSqhSC1js4V6iBf/jCtvJ43rNPtJ17y8xbmZZNe4NFGMUSuNkAWAXeOQ02GAAORe5ooieFh4jC2z5YHmr73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632425; c=relaxed/simple;
	bh=a89/HWk26JsP/OkXtj4TeeGsaSJmnp0S87artYYyg7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4dvZ3Vd3qoS02xsNVm+lWBQm5HYcItnOgFdHX75xR6HTaE7yTerbiXY6YA28WzdWxvxStjdEn92RDUurg2OHqHQQecknGUALi+i31UVLN8n4CxRIX/nDMViKPx7MrOQq5j+4U/xeRQG++Kq1rlhH8Ip7fC9rbJQZMORW9vNHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201605.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202506111659062061;
        Wed, 11 Jun 2025 16:59:06 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:05 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:05 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 08/10] iio: light: isl29028: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:36 +0800
Message-ID: <20250611085838.4761-9-chuguangqing@inspur.com>
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
tUid: 202561116590618cd26c374da5421bc4e811ef719d038
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 609ebf0f7313..0e4284823d44 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -562,7 +562,7 @@ static const struct regmap_config isl29028_regmap_config = {
 	.volatile_reg = isl29028_is_volatile_reg,
 	.max_register = ISL29028_NUM_REGS - 1,
 	.num_reg_defaults_raw = ISL29028_NUM_REGS,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int isl29028_probe(struct i2c_client *client)
-- 
2.31.1


