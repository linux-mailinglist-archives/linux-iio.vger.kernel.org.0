Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB64E1A01
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 06:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiCTFqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 01:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTFqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 01:46:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C6E36169;
        Sat, 19 Mar 2022 22:45:28 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KLmr96GsSzCqhy;
        Sun, 20 Mar 2022 13:43:21 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 20 Mar 2022 13:45:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Sun, 20 Mar
 2022 13:45:25 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <liwei391@huawei.com>,
        <bobo.shaobowang@huawei.com>, <antoniu.miclaus@analog.com>,
        <Nuno.Sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for ADMV8818
Date:   Sun, 20 Mar 2022 13:54:57 +0800
Message-ID: <20220320055457.254983-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

admv8818 driver needs __devm_regmap_init_spi() which is defined
when CONFIG_REGMAP_SPI is set and struct regmap_config when
CONFIG_REGMAP is set, so automatically select CONFIG_REGMAP_SPI
which also sets CONFIG_REGMAP.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/iio/filter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
index 3ae35817ad82..a85b345ea14e 100644
--- a/drivers/iio/filter/Kconfig
+++ b/drivers/iio/filter/Kconfig
@@ -8,6 +8,7 @@ menu "Filters"
 config ADMV8818
 	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass Filter"
 	depends on SPI && COMMON_CLK && 64BIT
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices ADMV8818
 	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass Filter.
-- 
2.25.1

