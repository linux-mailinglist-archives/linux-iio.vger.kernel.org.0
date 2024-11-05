Return-Path: <linux-iio+bounces-11917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5AC9BCEDB
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2171F245B2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D01D8A0A;
	Tue,  5 Nov 2024 14:15:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AE1D8A1D;
	Tue,  5 Nov 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816105; cv=none; b=RZuLVlg63qNf4Vff2UVlJ6QvDSJmYLOqIh1NQKg04AiVaFzS0ZDGmOo3eWApvuQVDHDPwaSXoVSc9eigb5SPkA2OoH63y3v4hk/1M2b/CR+gU/xVpflDoQcCFBeWtmLEnMKLQJPQCzbXQDqwQzX0POuMm4D+MQ//eVoDk3NWF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816105; c=relaxed/simple;
	bh=X8qqhoGjXg1cRNRhRbrUDPzutukt4geqg9iXvrjNjMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGWWvd0cnpNNKNds+tVux89Cmk/0OPkWR8jPEQTi5ew8/MEwbJvBFsSBHeet54JyjtlIQI7T3VQGECWPihqeQUsJmPREoQhKnSTrBJTmaaFKgUkLL4Fa4f+WGNBDwAu+gQAwil+Tx/I9Ty9s08r59hFt0OSSh0lV90KKjvvZqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjVg45ksrz2Fbsg;
	Tue,  5 Nov 2024 22:13:20 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id BE21318001B;
	Tue,  5 Nov 2024 22:15:00 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:15:00 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <cristina.opriceana@gmail.com>,
	<daniel.baluta@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 1/2] staging: iio: ad9834: Correct phase range check
Date: Tue, 5 Nov 2024 14:03:58 +0000
Message-ID: <20241105140359.2465656-2-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105140359.2465656-1-quzicheng@huawei.com>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

The phase register for the AD9834 is 12 bits, which means the valid
phase values range from 0 to 4095 (2^12 - 1). The current check uses a
greater-than condition with BIT(12), which equals 4096. This allows an
invalid phase value of 4096 to pass.

This patch corrects the check to use greater-than-or-equal-to, ensuring
that only phase values within the valid range are accepted.

Fixes: f1d05b5f68cb ("Staging: iio: Prefer using the BIT macro")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 47e7d7e6d920..6e99e008c5f4 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -131,7 +131,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 static int ad9834_write_phase(struct ad9834_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9834_PHASE_BITS))
+	if (phase >= BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
 	st->data = cpu_to_be16(addr | phase);
 
-- 
2.34.1


