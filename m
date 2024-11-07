Return-Path: <linux-iio+bounces-11958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CF9BFB4B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D71C215A6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62079D515;
	Thu,  7 Nov 2024 01:21:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738677485;
	Thu,  7 Nov 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942484; cv=none; b=keZraA51/emo1bM/RHktsbVuwj4y8A5pXOq5O6HOvM3cXn1m1njjCpwvo+5HkTjAyqKSZIA3QKT0Goh4jC+m6G428VkYs0Qzh6DyTb2iHgjzbfGyZQrligmFoCm0nzcqrHXtVZiUx1HsuchAM9LHxjh19UaBahWl5PgFbLokO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942484; c=relaxed/simple;
	bh=sHp8mOAE3GGSxo/mAG0pTmnAYg9RbxjnKqYOIEcTHio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biHXx6BacipkTyT+odY9+TZEOqrzetUQo4Ju1/mVLt+7bw1vRpkJTciltDcSTPH0IQl0gAl3Atxt9Ls2N/qFH3LuC/mnHpHiu3zZmCm5808vdcIcdRJRB7gCIo3PoNse+GxJ7mC3w37Muvmkyq4sSmZBZjmYnQukluTlvh1sAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkPP96QwvzpZ9s;
	Thu,  7 Nov 2024 09:19:25 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id E05551402CB;
	Thu,  7 Nov 2024 09:21:19 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 7 Nov
 2024 09:21:19 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <daniel.baluta@intel.com>,
	<shubhrajyoti@ti.com>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH v2 2/2] staging: iio: ad9832: Correct phase range check
Date: Thu, 7 Nov 2024 01:10:15 +0000
Message-ID: <20241107011015.2472600-3-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107011015.2472600-1-quzicheng@huawei.com>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
 <20241107011015.2472600-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

User Perspective:
When a user sets the phase value, the ad9832_write_phase() is called.
The phase register has a 12-bit resolution, so the valid range is 0 to
4095. If the phase offset value of 4096 is input, it effectively exactly
equals 0 in the lower 12 bits, meaning no offset.

Reasons for the Change:
1) Original Condition (phase > BIT(AD9832_PHASE_BITS)):
This condition allows a phase value equal to 2^12, which is 4096.
However, this value exceeds the valid 12-bit range, as the maximum valid
phase value should be 4095.
2) Modified Condition (phase >= BIT(AD9832_PHASE_BITS)):
Ensures that the phase value is within the valid range, preventing
invalid datafrom being written.

Impact on Subsequent Logic: st->data = cpu_to_be16(addr | phase):
If the phase value is 2^12, i.e., 4096 (0001 0000 0000 0000), and addr
is AD9832_REG_PHASE0 (1100 0000 0000 0000), then addr | phase results in
1101 0000 0000 0000, occupying DB12. According to the section of WRITING
TO A PHASE REGISTER in the datasheet, the MSB 12 PHASE0 bits should be
DB11. The original condition leads to incorrect DB12 usage, which
contradicts the datasheet and could pose potential issues for future
updates if DB12 is used in such related cases.

Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
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


