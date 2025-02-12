Return-Path: <linux-iio+bounces-15419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A02A3204D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A7D18883B7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01ED204F62;
	Wed, 12 Feb 2025 07:52:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC0204691;
	Wed, 12 Feb 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346759; cv=none; b=ng2DtqM6SMHiRVsgGpCFe6Ti+mtT6rV5CsyPSyrKxsSbJjHE+PK0WStf10Yi4D2H1CyPM5xmRPG9UKfIzCUFKoaO8/1u+lWitNQ1PA49kNMXOxn4a7TgvmlS3tA0Zhv10iAtaUCdHf+zoq7MfCADy9tGzf7Cp/JtnuGN37wJ0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346759; c=relaxed/simple;
	bh=vdMCZmMwLvojqlQevhSCmfhyYF28/13RA6CgmxUc/3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4py+rEnOETwu19FK3FXlVNxtijL6VRK2CjuXKbfHBm+Vy2H9hRpqrWruP/QVWPTnWlB9MZ9N3g7dst0G7nzg4ao6W4FCa+s9YxTVb+aFyTwkBuGiRgCX0niRVlHQQMlx6bj5ByvI9t+cotZEjSQpt8ldbjIgfRilDqfFPSC1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JZM00029;
        Wed, 12 Feb 2025 15:52:29 +0800
Received: from localhost.localdomain (10.94.15.56) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 12 Feb 2025 15:52:30 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dan@dlrobertson.com>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 1/4] iio: accel: msa311: convert to use maple tree register cache
Date: Wed, 12 Feb 2025 02:52:20 -0500
Message-ID: <20250212075223.4164-2-liubo03@inspur.com>
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
tUid: 20252121552292362f648069df6e783a35677e747e940
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iio/accel/msa311.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index e7fb860f3233..fe4c32a9558a 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -332,7 +332,7 @@ static const struct regmap_config msa311_regmap_config = {
 	.wr_table = &msa311_writeable_table,
 	.rd_table = &msa311_readable_table,
 	.volatile_table = &msa311_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 #define MSA311_GENMASK(field) ({                \
-- 
2.31.1


