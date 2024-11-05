Return-Path: <linux-iio+bounces-11918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B179BCEDD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A966B1F24614
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE921D90A4;
	Tue,  5 Nov 2024 14:15:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A71D8DE2;
	Tue,  5 Nov 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816105; cv=none; b=ZV2nM0NHtXdI5nX73ONSQVPRpOOKeI5H8g0/BmnuBVGXybpXyKwaFULX5mnghOM3q/K10dlXCBLyHQ5v/9NVxYr99dXVMrvigFLIcjF3iyn+S7nU2HCDoyJdEjpIZpH2/ohpzUmtRDOsXmmTb947XzDaTyjcGXfONNpTBzRxfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816105; c=relaxed/simple;
	bh=lwWLSDm0IpzRpsFlwC6lgHfCTy0GnBpOaMrLvpvPsIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkYlUJyLWN2d8xMpXpF5xzoGmr/JI9l9Z9cXDnw92+B7eez4z6TNsm8ANyK+wIVlR2vf+BlyDLSj3lWuA2zJ0ry3a2PL9BAF5lfpTbz9xaHlNn2oAx+62zbDIRMTutbtIW7kSdB+jousquaAu3wci/E+NTR3P75W+d3lKt5YoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XjVg53Jd8z1jwZ1;
	Tue,  5 Nov 2024 22:13:21 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F7201A016C;
	Tue,  5 Nov 2024 22:15:01 +0800 (CST)
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
Subject: [PATCH 2/2] staging: iio: ad9832: Correct phase range check
Date: Tue, 5 Nov 2024 14:03:59 +0000
Message-ID: <20241105140359.2465656-3-quzicheng@huawei.com>
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

The phase register for the AD9832 is 12 bits, which means the valid
phase values range from 0 to 4095 (2^12 - 1). The current check uses a
greater-than condition with BIT(12), which equals 4096. This allows an
invalid phase value of 4096 to pass.

This patch corrects the check to use greater-than-or-equal-to, ensuring
that only phase values within the valid range are accepted.

Fixes: f1d05b5f68cb ("Staging: iio: Prefer using the BIT macro")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 492612e8f8ba..140ee4f9c137 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -158,7 +158,7 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 static int ad9832_write_phase(struct ad9832_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9832_PHASE_BITS))
+	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
 
 	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
-- 
2.34.1


