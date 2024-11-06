Return-Path: <linux-iio+bounces-11930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE839BDCD3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 03:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26CA1C21909
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC80218D62;
	Wed,  6 Nov 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6HLYCYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429F218941;
	Wed,  6 Nov 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859276; cv=none; b=rawCSQCyYm17s4IzhwEavDbDAdV1vgk1yeV2jzC/Mf13DwRVCXizL5EUTKXlhl7qo+PkKADwvzQYiIIJrQYELpfQB5wjRrao4bhCOzkLyOmE31wcW+lViq2/vMeRTS+Wc4iDPTYoDdzBAXTnHfk7+MlgmaXgQwCQtFqn/74azd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859276; c=relaxed/simple;
	bh=3u/kBCazJ6XYfCHjeA1b3m9YnSaY1gMVrcsH3L6STZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEz5bUUK2/MAiMlvG8emUBKmei5l2iYKqFvEhEY9SXuOvGXbOOFFu86a6AE1kN4PBAtVJF1VuP444m/cgXQKaWp8UwYWOzn0PZniLbSguiqO9RegHDVPdduEIT+w/84/9mvfInNQuGPkGgMJd4GoUjidThSiF+ACfflSl4BjWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6HLYCYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E56C4CECF;
	Wed,  6 Nov 2024 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859276;
	bh=3u/kBCazJ6XYfCHjeA1b3m9YnSaY1gMVrcsH3L6STZE=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6HLYCYEvVgmKUQ9nuUVmoN+cxSctD/AUhV3qevCfuSDxS3Gf/acAjfN0bf7ctLo0
	 f66neLzvDx1wdtVDAKildpmh0+PGF9Wyur9+fExg0vQU8FdImsXTZADf/TQ64ZUgr1
	 ezdZfQ7hDzRU5JK4K07Xe41Igags1TFwrS/fsAVcWfcAuN2Zv8AB71gdepcF4uRkfG
	 ocASRq7oEPMQzpEPCkDPTJ5xnzsCShc8AMCDFnEBGMo3H5iMxhvx0ml61+tgUXqW3R
	 KtX4t4T9JOnIrtOGUMlURJZ81q8c8VbcLFDk9lVlZYlsKUt6eymKsvb+Ud8LVsMJ7u
	 Lpe++Ytwh14aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	quzicheng@huawei.com
Cc: Nuno Sa <nuno.sa@analog.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:33 -0500
Message-ID: <20241106021433.184357-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6bd301819f8f69331a55ae2336c8b111fc933f3d Mon Sep 17 00:00:00 2001
From: Zicheng Qu <quzicheng@huawei.com>
Date: Tue, 22 Oct 2024 13:43:54 +0000
Subject: [PATCH] staging: iio: frequency: ad9832: fix division by zero in
 ad9832_calc_freqreg()

In the ad9832_write_frequency() function, clk_get_rate() might return 0.
This can lead to a division by zero when calling ad9832_calc_freqreg().
The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
against the case when fout is 0. The ad9832_write_frequency() function
is called from ad9832_write(), and fout is derived from a text buffer,
which can contain any value.

Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20241022134354.574614-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6c390c4eb26de..492612e8f8bad 100644
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
2.43.0





