Return-Path: <linux-iio+bounces-20406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF0AD4F0C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FFB3A8362
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F625A2DE;
	Wed, 11 Jun 2025 08:59:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3787257AF9;
	Wed, 11 Jun 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632362; cv=none; b=iKUOiVScvRP+CaOMtO4kIyUeyr+WgUiLKCYdyr2fDwy4Og0nzW1H7XOSwU7uRRitLkZPAhBZm50ACjZSDGx5lUZPGWS7tfrvwhr3/MsbrXDDS5RKr3V349g5MrJOZluzs79BNV76vjXAa8HSpN5+NmWGfPAuMqICn1JCHyWhKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632362; c=relaxed/simple;
	bh=Rx9I0gH+j/FABSJTa9fh9g66DDw/GqXCCH519IEVMOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRjYviWyijuokgnp1a+dJn9xD8sClfzS9dwOetdd+6Ykx5YfxsNvWlrn7oDD//LR6MoLzqYY9+i5ZuhvbBiTub1L1/I1N/MIuVj8hDFD+GjxySof8Ckbqw7FpMHLyZr2dmkXL0S7Rd7aNPAJfNUklVmLQlxch8BfuDmqL7/NwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202506111659049683;
        Wed, 11 Jun 2025 16:59:04 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
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
Subject: [PATCH 02/10] iio: dac: ad5380: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:30 +0800
Message-ID: <20250611085838.4761-3-chuguangqing@inspur.com>
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
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index f63af704b77e..0ddce7b218e3 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -426,7 +426,7 @@ static const struct regmap_config ad5380_regmap_config = {
 	.val_bits = 14,
 
 	.max_register = AD5380_REG_DATA(40),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.volatile_reg = ad5380_reg_false,
 	.readable_reg = ad5380_reg_false,
-- 
2.31.1


