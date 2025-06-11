Return-Path: <linux-iio+bounces-20407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81CAD4F0D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454E517E333
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8A25A334;
	Wed, 11 Jun 2025 08:59:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8125334B;
	Wed, 11 Jun 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632362; cv=none; b=ImHuydxHyn4kTYdpIgMXnBkkCEW/Gg3OIcsnA8PpORK856wGXnXrTiH7H0D+CzQhVGj7da+wC2XzJH4pV4ra3G6bqJUM1R6v26TzOYcPaWCDocO1txdtpZHxqdQnswybPU0Jdt89z0o6NPRvgdyEtUNMhywpKe6ZUPi1FV+LMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632362; c=relaxed/simple;
	bh=1fWCwnlSXdLuAVukdT4G6sSI6gWBplyZTWeB9QlGs/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnLB3tmQ2WIs2M4DnRlarCesd/xmXc/EfVNqeMoT4jzOEg+LHvivHw+lvo10D5KyrAAwtNi1iaEC+EAJIXHHOXLUZwxh0GNjsL6qMFvmO3urPoDCy+m53LuUHeYWoRQOdrw/xOhBdgBCDseOMbJQB3wqTGz16NK4ihXMwr/g1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202506111659061076;
        Wed, 11 Jun 2025 16:59:06 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server
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
Subject: [PATCH 09/10] iio: light: ltr501: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:37 +0800
Message-ID: <20250611085838.4761-10-chuguangqing@inspur.com>
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
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8d8051cf6927..e293707f4f7d 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1408,7 +1408,7 @@ static const struct regmap_config ltr501_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = LTR501_MAX_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = ltr501_is_volatile_reg,
 };
 
-- 
2.31.1


