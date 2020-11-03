Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938F62A44B4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKCMCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 07:02:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7132 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCMCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 07:02:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQT111Zv4z15R0j;
        Tue,  3 Nov 2020 20:02:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 20:02:08 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] iio: adc: rockchip_saradc: fix missing clk_disable_unprepare() on error in rockchip_saradc_resume
Date:   Tue, 3 Nov 2020 20:07:43 +0800
Message-ID: <20201103120743.110662-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the missing clk_disable_unprepare() of info->pclk
before return from rockchip_saradc_resume in the error
handling case when fails to prepare and enable info->clk.

Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
Suggested-by:Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: remove useless braces because early return is pointless.

 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1f3d7d639..12584f163 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -462,7 +462,7 @@ static int rockchip_saradc_resume(struct device *dev)
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret)
-		return ret;
+		clk_disable_unprepare(info->pclk);
 
 	return ret;
 }
-- 
2.23.0

