Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF33F1A2D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhHSNTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 09:19:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14279 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbhHSNTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 09:19:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gr51S5bD3z7x9H;
        Thu, 19 Aug 2021 21:18:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 21:18:29 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 19 Aug
 2021 21:18:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jic23@kernel.org>
Subject: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()
Date:   Thu, 19 Aug 2021 21:24:16 +0800
Message-ID: <20210819132416.175644-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 9996d5eef289..c38f43ea624f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -570,8 +570,10 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(adc->adclk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(adc->pclk);
 		return ret;
+	}
 
 	rzg2l_adc_pwr(adc, true);
 
-- 
2.25.1

