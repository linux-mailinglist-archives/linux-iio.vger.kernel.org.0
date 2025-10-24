Return-Path: <linux-iio+bounces-25404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF5C04C3B
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B671AA1DA6
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F2E8B9D;
	Fri, 24 Oct 2025 07:39:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A82E764E;
	Fri, 24 Oct 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291561; cv=none; b=FWx4R6vU62ijPiB2g8BAE8YKdpkBHMRsuabdyDJlxAvIqz0gcyNbNiknnbAG2Vyg3tp+OkVo2TO3NFxlpbdScDXhvoB5pdjRDZJiDsgo4yeyMmfMvWK2aYQcB9nfdx0pI68he7Cn2O8T4RDKJgNBgo1Y+Dq+1k8QyilZihUuMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291561; c=relaxed/simple;
	bh=goBHQyw/GmuljsIW+ioQR+Ta9Xf4Z7l4C5d50Y7njNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cky6qwLFhw3jOKqIQHm6R/V1XZvE9SXOl/CSc6Pk8ifDSTKb/utqeZzFXlczoM4WccXZFU7NPEelAi2N0oRYqQytLy9NbnmSflJWChzSEzLLmspYec+lJceSsqxrflhUu6noX2fS8a2T7XH9D+s7nEJBvDBQYvIHDFwSqxCguNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510241539125534;
        Fri, 24 Oct 2025 15:39:12 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 15:39:12 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 15:39:12 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwVbUeLftodiUPAA--.3167S6;
	Fri, 24 Oct 2025 15:39:11 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<subhajit.ghosh@tweaklogic.com>, <javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 2/4] iio: light: veml3235: convert to use maple tree register cache
Date: Fri, 24 Oct 2025 15:38:21 +0800
Message-ID: <20251024073823.35122-3-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251024073823.35122-1-chuguangqing@inspur.com>
References: <20251024073823.35122-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwVbUeLftodiUPAA--.3167S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1fGw1xuw1kur4DXr1DJrb_yoWfKFg_Gw
	17XFWkGFWrAry2gw1DZwn8Zryq93y8ZF1vkF4ftasIyrZFqws5Ar1DuF47AF4DtFZ8JF4x
	ZwsxWr1ruw4SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbyAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
	cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?4Y3xEZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KQIITeJrTm7j9TbyQPFhd/y5YewrqjbMgYs1AFPPfFM/1al7oa9VVacecULWQWASRACK
	QXucA//GdANsme/8xLI=
Content-Type: text/plain
tUid: 202510241539123c383176c50d55a9bba5da7bdbce23fe
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/iio/light/veml3235.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index 77c9ae17ed47..9309ad83ca9e 100644
--- a/drivers/iio/light/veml3235.c
+++ b/drivers/iio/light/veml3235.c
@@ -154,7 +154,7 @@ static const struct regmap_config veml3235_regmap_config = {
 	.rd_table = &veml3235_readable_table,
 	.wr_table = &veml3235_writable_table,
 	.volatile_table = &veml3235_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
-- 
2.43.7


