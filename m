Return-Path: <linux-iio+bounces-15421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08610A32053
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D833160EE7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80C205509;
	Wed, 12 Feb 2025 07:52:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C803204C29;
	Wed, 12 Feb 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346761; cv=none; b=CYsdQ8ODAa3rgDmwymiVpw8GRJ0RqTq1WsEQgRZR3iFH/agw2DRQxDGoWVp/tkum6fuLZTcLb39B5Euo3iVyriJ6ZdKC76S+zdQWcvX+i41BfadM0xuJWce9jinCr0ssTGMV/cI7pP3H0RaKfAwaGKOM8RwYX9HQS1NjIUEuAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346761; c=relaxed/simple;
	bh=TnbBYhm8H1OhuDao0dJq2j9mGUrhsIFx/IZfBsY2Hdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/6u+2acQLm+K3Si8Zrk0yv5MOEAWJQz8lmJbKjL8696VxYUGQi2Hn0HBjYWIzsMP2l2dsweJpl0K+iOwqHbOwyDj6vuz3zWBRD7pkxh/6eZqMt0MvIQfGYA2yQFajSUrPw8DlskhyMSGkik4b6GdNne3O+sYyLU3JkFAHZHBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JZM00131;
        Wed, 12 Feb 2025 15:52:31 +0800
Received: from localhost.localdomain (10.94.15.56) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 12 Feb 2025 15:52:33 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dan@dlrobertson.com>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 4/4] iio: accel: kx022a: convert to use maple tree register cache
Date: Wed, 12 Feb 2025 02:52:23 -0500
Message-ID: <20250212075223.4164-5-liubo03@inspur.com>
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
 drivers/iio/accel/kionix-kx022a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 5aeb3b951ac5..3a56ab00791a 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -149,7 +149,7 @@ static const struct regmap_config kx022a_regmap_config = {
 	.rd_noinc_table = &kx022a_nir_regs,
 	.precious_table = &kx022a_precious_regs,
 	.max_register = KX022A_MAX_REGISTER,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /* Regmap configs kx132 */
@@ -260,7 +260,7 @@ static const struct regmap_config kx132_regmap_config = {
 	.rd_noinc_table = &kx132_nir_regs,
 	.precious_table = &kx132_precious_regs,
 	.max_register = KX132_MAX_REGISTER,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 struct kx022a_data {
-- 
2.31.1


