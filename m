Return-Path: <linux-iio+bounces-11476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0C9B338B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA87E1F22A71
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D21DDC04;
	Mon, 28 Oct 2024 14:31:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40953187352;
	Mon, 28 Oct 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125885; cv=none; b=TJQoQFT8JgXa8e5JEjACF1oVVCK16JnuoL8J8eMCUnPWS99CtSm9yYa5VdeBdynUstJXFAnPmU61A4Slh4n0+47SxisxGIMKdcgPpW3oDQekB5SzmQuT1X+/FzzfPfGS+GzBvNPtij/iIorVF1ncYqCZtO/ZFsMHasaeBhV8Beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125885; c=relaxed/simple;
	bh=uwHaIlsQqFu7ae8UFuLdJQ1AfGWr2S0itkv/Rz1zSsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tn1Ax4z3ztMs1Sbhkg1xYD8KvEh+y2mKLs1w4djVAGMZ3/rXcNc4O5+zCHLiS1gxT32P0l7KayL3hbPkhMBxqtLve7ejdLABpxdKMYnC2FsJLeEGNKZfdUXkD/++LfIbW+Bs9u2AHECkImDwCqB5RcysQVxsYfjHWdH08WJxTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XcbP03m0yz1T8Hx;
	Mon, 28 Oct 2024 22:29:08 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id E52E71800DE;
	Mon, 28 Oct 2024 22:31:16 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 28 Oct
 2024 22:31:16 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <Michael.Hennerich@analog.com>, <renatogeh@gmail.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <giuliano.belinassi@usp.br>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] ad7780: fix division by zero in ad7780_write_raw()
Date: Mon, 28 Oct 2024 14:20:27 +0000
Message-ID: <20241028142027.1032332-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the ad7780_write_raw() , val2 can be zero, which might lead to a
division by zero error in DIV_ROUND_CLOSEST(). The ad7780_write_raw()
is based on iio_info's write_raw. While val is explicitly declared that
can be zero (in read mode), val2 is not specified to be non-zero.

Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index e9b0c577c9cc..8ccb74f47030 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -152,7 +152,7 @@ static int ad7780_write_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0)
+		if (val != 0 || val2 == 0)
 			return -EINVAL;
 
 		vref = st->int_vref_mv * 1000000LL;
-- 
2.34.1


