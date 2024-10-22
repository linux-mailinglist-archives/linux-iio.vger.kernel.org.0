Return-Path: <linux-iio+bounces-10934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7639AB024
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1B31F2335A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58F19F127;
	Tue, 22 Oct 2024 13:54:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502619F110;
	Tue, 22 Oct 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605283; cv=none; b=PSXYKjwxx7Pz1F4l1ZORnJpFhnSo+ivJRCpihFrxoSc9UPfRnxyRR/5iNwaMO+o4yStH6gIWRJF9ATH1Xf/x69rpf+nxTB1m7G3IYMHSIJqdEGqNagcv2e43BqKNdgMhkSPGMwKZlg2CnMImE3XPGajbwcu8keKFFrCB0sJDhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605283; c=relaxed/simple;
	bh=1RuQV7IHtget8xAZ/49F3q4nCzlg6g7Nc8l27myNw2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p8ejWX6gC202M5R/opeP8WfaTh43U0m+lreDOtNq9ZxHvARUZ8rsqokOU7LQgDR8aXn7GVX01eBOLDNK6vBMolTni4knwuQiO/+ZQVLfnvd0nEeW38uWA99CVdgx55zdaz5boRFKwymz5hLfE6jnprhD2agtrXKjlhxDNmKkBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XXttD4G8RzyTdC;
	Tue, 22 Oct 2024 21:53:08 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 28E5D18009E;
	Tue, 22 Oct 2024 21:54:39 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 22 Oct
 2024 21:54:38 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] drivers/staging/iio/frequency/ad9832.c: fix division by zero in ad9832_calc_freqreg()
Date: Tue, 22 Oct 2024 13:43:54 +0000
Message-ID: <20241022134354.574614-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the ad9832_write_frequency() function, clk_get_rate() might return 0.
This can lead to a division by zero when calling ad9832_calc_freqreg().
The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
against the case when fout is 0. The ad9832_write_frequency() function
is called from ad9832_write(), and fout is derived from a text buffer,
which can contain any value.

Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6c390c4eb26d..492612e8f8ba 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |
-- 
2.34.1


