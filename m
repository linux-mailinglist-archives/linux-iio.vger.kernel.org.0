Return-Path: <linux-iio+bounces-10933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377A9AB022
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24531F23B4C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F419F121;
	Tue, 22 Oct 2024 13:54:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78145945;
	Tue, 22 Oct 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605262; cv=none; b=jzeccl266UuGHV0hJsMcPlWb9PqWLkdV6TpA9hRb7V+afzlW17jE/uSpBxUzI1sOUU0M/yLaW0zeEP5SuIw6zpM9yULkHe1F0LeIo7pZ7AillCBgBbAmKJAGRhMnHo/C1LW5dS0r0p5WJjOmrf+s5IQfQuaZ7U8ExPSqe+HJXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605262; c=relaxed/simple;
	bh=fov3MOMN4MVn5VReFQzMvMLjhpAOIGW0maeN2pNlE/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJEA5azh1nOb6H8a2P70CrG9nJ0FfEkJp299twZECBg3B3xgzNRCdO/lYTiYq63SDR1ipzKayPK/h6A7lxfeME5rKo0Iq5jqcAPX9yAVzEM2Qg7y84ymftj/dyCDNL3NUezZYQfJqpXRAinLjsd8aUIkQd9Kvn/qcSSMnKjFo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXtsH1S2dzpX5J;
	Tue, 22 Oct 2024 21:52:19 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 5934B18007C;
	Tue, 22 Oct 2024 21:54:16 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 22 Oct
 2024 21:54:15 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<alexandru.tachici@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] drivers/iio/adc/ad7124.c: fix division by zero in ad7124_set_channel_odr()
Date: Tue, 22 Oct 2024 13:43:30 +0000
Message-ID: <20241022134330.574601-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the ad7124_write_raw() function, parameter val can potentially
be zero. This may lead to a division by zero when DIV_ROUND_CLOSEST()
is called within ad7124_set_channel_odr(). The ad7124_write_raw()
function is invoked through the sequence: iio_write_channel_raw() ->
iio_write_channel_attribute() -> iio_channel_write(), with no checks
in place to ensure val is non-zero.

Cc: stable@vger.kernel.org
Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/adc/ad7124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a5d91933f505..b79c48d46ccc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -637,7 +637,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.34.1


