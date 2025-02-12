Return-Path: <linux-iio+bounces-15418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FAA3204B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC003A5407
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61108204C11;
	Wed, 12 Feb 2025 07:52:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC91E47B4;
	Wed, 12 Feb 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346758; cv=none; b=g99BfeKha0vqWY4kAS2NxpvPU6vWy2zYJOJIw9ZhaiT5KyvV18a5QYtN6fEEPddM89T/HESmx00/m4lpipZ0pttQ2900z5KuvaggKXkS1bCip2uvHw8eDgxkTQxyOZJNk4uKh0A5kGNrqIFMpHaWprf35XDejm9lntO6XXRh/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346758; c=relaxed/simple;
	bh=SYspyQSNBGb/WGFO6iGgh16RmnUcKmnlPNY/pj+oXAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1Vk2t5LqSVXjwY5R+qpPP8gGf4P7GuCsBIDQyUdLgt0kJEEHb104IqAxgbbmYgPmaJXDiTljw5rBhstvIEefOwk7Yudnt9afDSp87ya7MOUnEZFuzz/VLeS0jrJzxTlW1Lzmjc9OV/v95a1ZizqVNtx9+Gkrk/6i9/rz20mqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JZM00030;
        Wed, 12 Feb 2025 15:52:30 +0800
Received: from localhost.localdomain (10.94.15.56) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 12 Feb 2025 15:52:31 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dan@dlrobertson.com>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 2/4] iio: accel: bma400: convert to use maple tree register cache
Date: Wed, 12 Feb 2025 02:52:21 -0500
Message-ID: <20250212075223.4164-3-liubo03@inspur.com>
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
tUid: 2025212155230d3cb15f5a794ef806036e1ea2d261c20
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iio/accel/bma400_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index ae806ed60271..23f5e1ce9cc4 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -190,7 +190,7 @@ const struct regmap_config bma400_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = BMA400_CMD_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.writeable_reg = bma400_is_writable_reg,
 	.volatile_reg = bma400_is_volatile_reg,
 };
-- 
2.31.1


