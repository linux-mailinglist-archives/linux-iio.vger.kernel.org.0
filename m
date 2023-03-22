Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7386C6C4192
	for <lists+linux-iio@lfdr.de>; Wed, 22 Mar 2023 05:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCVE1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Mar 2023 00:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVE1o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2023 00:27:44 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CAB1574F9
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2023 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oH63b
        BuCBkg7PmzINRmDbBYmRFHwZZC1VGm8nTg6SCg=; b=BozniIstuZdaHkOvBoWm8
        BXnDMSKYBw13wECGrtyt1FpTQSyV/AbkEpChCeoplWgeVbHc/vZ8v7GAW5umoUy9
        LOIjpeNUgj6ykT6vyplUqtV7AgUzVg1JUgrVDs3xiXXBHSb+vskadF/2PJ0LZTnH
        EhhPvRhdusonhtDC737FcA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3_w9sfBpkGQebAQ--.46098S2;
        Wed, 22 Mar 2023 11:56:29 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        windhl@126.com
Subject: [PATCH] iio: dac: ad5755: Add missing fwnode_handle_put()
Date:   Wed, 22 Mar 2023 11:56:27 +0800
Message-Id: <20230322035627.1856421-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_w9sfBpkGQebAQ--.46098S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1kuF4kWF1kGr13Zr4ruFg_yoW3Cwb_ur
        17u3s7Gr18Aw4IkrWayrsavr9ayFyjgr4rCw4Fv34fKryUCr95ZrnFvFW7JrykXay5tFyD
        Xrn09395Awn3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_lApDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiHhE6F2IxqJ+KTQAAsB
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In ad5755_parse_fw(), we should add fwnode_handle_put()
when break out of the iteration device_for_each_child_node()
as it will automatically increase and decrease the refcounter.

Fixes: 3ac27afefd5d ("iio:dac:ad5755: Switch to generic firmware properties and drop pdata")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/iio/dac/ad5755.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index beadfa938d2d..404865e35460 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -802,6 +802,7 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 	return pdata;
 
  error_out:
+	fwnode_handle_put(pp);
 	devm_kfree(dev, pdata);
 	return NULL;
 }
-- 
2.25.1

